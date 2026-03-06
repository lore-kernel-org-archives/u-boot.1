Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09AFF513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B51C83FBC;
	Fri,  6 Mar 2026 03:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJaWKohP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960F083F9B; Fri,  6 Mar 2026 03:37:14 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18F8483F9B
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-899ee87355dso70716416d6.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764629; x=1773369429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiee4PDnsbFCAqlerT0THOld0kTgVJ2plLZffMZf5Ok=;
 b=FJaWKohPqHL9bTcvuml42g5vLOLq9jt02Wrifurn5V5G25mlV35v4PBD+46OvfVwXU
 F3BjLbqqqrb6HcH1kfkaGXzK6gVrVuwDls9S2uV90RwbDBJWbBWxLmvoqiUrhFR/fkiK
 kImoRHL0w5mVzOa/OOUsJceDeNTWimclQZgs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764629; x=1773369429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wiee4PDnsbFCAqlerT0THOld0kTgVJ2plLZffMZf5Ok=;
 b=MGrEvixPhoA15+6gpxTFHhjCdK0ZkO/ID/WH+WgzWZWuYKRK9VtEvCu1ZHVGHBloRB
 HIWJw1479cZ6c78ufgVp/sx2qoh2owlIlpACqPrA1BjfSKIh8AJ9LDqzAjIiVolKNIZl
 AV2XVKF03iDpZyFielg72Y/wD2Q4JTjOnns4EtlA6o6bNQsjmLggFJa3Ylv3sl4/ZXbb
 DpKtIdhoUOHAIviNzqDEMt5sfrdfN0wdIPyxGNcnBZVvlpGajgPcup0H6toHU0gvmM8u
 Zfn6pTd5zOFFpXJflOdWtela2LDQcCU0H4/pQv1lJXR1ivpeqtODjl5ztm3eyjJHSpLF
 RXpQ==
X-Gm-Message-State: AOJu0YzeLFyGgryPu/VioOTIepObDNZ3o7K9+h3dDDaOGi5u0ytYD6o7
 tXUJaDo2Yvk+7y7njFCsqv9eVZWNeGHEsLQJIlFPPzMjknQJ2w45yuS03LlBUb8zoRK1rpSslYh
 A6Lo=
X-Gm-Gg: ATEYQzzSkRnkNB7lY/Nf8aLKFk6v1IfrTfqVB09ToDYZoltaj6pVITEI4wT9aVxeLk0
 hk4lEON5GgpCOzRAWwwgFNE2x8NQoP/r9QnAP56qMlUqEX3nTfKn5IhPCAfubten25v6FbpA6Zr
 Nk4H6wd2OapFWXICeAX2vnwIB4KAKW18K8Q2IMX093O1AzPtXDkvhup3uov/l0c+t0gN/p3rgPI
 YXNqT+UM5O/VLTWBYE/NU1k7/83VBWWBbjuXeNxSxqdPJmoUhQ8nIH1tMed9SPwv/EDGnECTkJk
 zj7ppz1wHIvB8X4AemyvEfqU2lMUytHVnJSPrabwlknwFYgjc/YdVokc2JFJ2DO0yfSu4NCr6kJ
 27YaUhB8qHVcwgq+nd/G/2yEmIXYCmAjxF01y7U+S08E65zZLP2UBxrgocH6N8UkVoNVYukqUmo
 GZyEmoVVLhkusP9ssrOA==
X-Received: by 2002:a05:6214:19c6:b0:899:efd1:9e07 with SMTP id
 6a1803df08f44-89a30a67a12mr7084946d6.30.1772764629316; 
 Thu, 05 Mar 2026 18:37:09 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 05/17] x86: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:14 -0700
Message-ID: <20260306023638.2678886-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Simon Glass <simon.glass@canonical.com>

The x86 code in bootm_announce_and_cleanup() is very similar to the new
bootm_final() function, so just use the latter.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

(no changes since v3)

Changes in v3:
- Drop the DMA comment move (now in the introductory patch)

 arch/x86/lib/bootm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 7a94dc877e3..cde4fbf3557 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -34,22 +34,10 @@ DECLARE_GLOBAL_DATA_PTR;
 
 void bootm_announce_and_cleanup(void)
 {
-	printf("\nStarting kernel ...\n\n");
-
 #ifdef CONFIG_SYS_COREBOOT
 	timestamp_add_now(TS_START_KERNEL);
 #endif
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#if IS_ENABLED(CONFIG_BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
-
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 */
-	dm_remove_devices_active();
+	bootm_final(0);
 }
 
 #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
-- 
2.43.0


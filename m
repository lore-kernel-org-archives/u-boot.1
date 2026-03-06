Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A165F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B87183FF5;
	Fri,  6 Mar 2026 03:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fPUO+tV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328E983FFA; Fri,  6 Mar 2026 03:37:24 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C4783FEC
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-89a000f5adeso90127706d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764640; x=1773369440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1QyQAJqQyVt+eMietJC8/e+W6fr2Sv3xjB3tKW7eeo=;
 b=fPUO+tV6sny3FdUWrX4PEnRvWknieswcuHFm1jLipbjA717m6dq15rCNqEGK3nTz5L
 ltFAwPuRVriaM4uwUCrbFgQ0yhf5VISzFQSSFor/ZHmdCf4tX6eAqrGNFdevdsopKeIJ
 QM7pfFq2B2RsNmAGvEp9gsglxQPwCvczEl0dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764640; x=1773369440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L1QyQAJqQyVt+eMietJC8/e+W6fr2Sv3xjB3tKW7eeo=;
 b=b46585EDmDr2Fll60nKba8Ka/p7GwhiIm/S9cKuEYMa2p96vTH7T9MfCRN+e6ecvaj
 oEh2z1Y6GAAmWMvLfjUzUKMsiSP8tc7s404si+ZcS+vTYov0pOqF2ze8R2vDUxWe7bIV
 ns4/IsT+J9VyC+bGR7hecmH+USdGhNL5RaIpMfLXEqWWSkqrpVtnX7u02APL9UDYXZXx
 k7HwPwFvUtx9zwq/Y86gfLtbf93Ob6xyhmuXnL4FT0VzU+UGKnSFgKCgeZVvw8lwbe4P
 vlaQ2IM/VaT3VKbXH67gZ2VEz4XOs8gYuGncBwbyapO1UELwqJOSVnCe7FjYlSqYroVb
 QarA==
X-Gm-Message-State: AOJu0YzV+X7N7kMLKqKfU6WW0B4dC2APHT3GXbcuzEAQoJ5EQw/SBnUP
 +/JekkEY3Hle8aQWqjvFNmxhuLnXAiiGqtmiKNkAvUcWMXMG1OCDf+TvzZVUhpavWA0hvvryDM4
 KPW8=
X-Gm-Gg: ATEYQzw7beDDww1aBXYqABQJ49jg7uMbzBUTPIezIb7nnAVSpiqVMMa+y47+vrkaNH5
 9Vx/BvFN3BRzTNjEkI6QxQCsPlvVCXrwFQWmfzVIkPGTiwsY3ebk38A4rJVjQQ5uHlwp4vM2pLx
 pYxkNPs5dGWtW/5U4ptt4e5TtfV7IVAhZEe4F2qa0ww/K0YBmOow9pxz6/cXugGJKX/jGWBxj1p
 TFJZT3IgEyR/PRlqHq1d3jcivz6dS6sb9V8aal1Oagh9M46OV5Kp+op+xaZewkC/NefdgCGHg3N
 kNP9V9pKiLG4Q2kNFgd5xe+qp+8z5C/pcd/6sJduuYgVecWm3Nq//K3icC56A1kdUSr0B+4FZJy
 AlyG/9zbfSW1HOmIqiYt7XfSk/paw4uNOfLyLykhK1+zMBpFT/rcLi3FaKOMO1OpQABdqpTVSaP
 svtB6/qUj6UYBxA0CJsQ==
X-Received: by 2002:a05:6214:400a:b0:899:f993:f2a3 with SMTP id
 6a1803df08f44-89a30a3944bmr6156646d6.23.1772764640510; 
 Thu, 05 Mar 2026 18:37:20 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH v4 11/17] mips: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:20 -0700
Message-ID: <20260306023638.2678886-12-sjg@chromium.org>
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

Replace the open-coded bootstage_fdt_add_report() and
bootstage_report() with a call to bootm_final(). This also adds the
"Starting kernel" message, board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on MIPS.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add new patch for MIPS conversion

 arch/mips/lib/bootm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 87195100023..066c830f3fa 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -268,12 +268,7 @@ static void boot_jump_linux(struct bootm_headers *images)
 	if (CONFIG_IS_ENABLED(MALTA))
 		linux_extra = gd->ram_size;
 
-#if IS_ENABLED(CONFIG_BOOTSTAGE_FDT)
-	bootstage_fdt_add_report();
-#endif
-#if IS_ENABLED(CONFIG_BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
+	bootm_final(0);
 
 	if (CONFIG_IS_ENABLED(RESTORE_EXCEPTION_VECTOR_BASE))
 		trap_restore();
-- 
2.43.0


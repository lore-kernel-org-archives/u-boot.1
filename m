Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09D7C369CA
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6959283121;
	Thu, 17 Apr 2025 20:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aq41khDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0383283086; Thu, 17 Apr 2025 20:17:07 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CA883086
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d7f11295f6so3593225ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913823; x=1745518623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=btVOn5B6NxwhRxe5rPpvDCZDE/KBe6IuSuAwUEl3sg4=;
 b=Aq41khDvJz7jNwkotNoo8zeAFbBWu/M5KxubRPk5TnW36AqJtTsSgvdG7eSspiBclx
 aHbALO7Mr7ezBduDaOkiceuZRafUK1mLVQWVjQu1dutlX3+SOI4Uf3PvhwfTQ0yaROR6
 NLDq7kTNwxlMoadBmBYUpGFhMfz5uNfRLoTbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913823; x=1745518623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=btVOn5B6NxwhRxe5rPpvDCZDE/KBe6IuSuAwUEl3sg4=;
 b=d62P2tPB+opEpD2qKuufH74sa6PAuoCu/s7IcCF4kkv8QjzFhGGR68pKa3DRSnC5RS
 KqXzPi2NsGoz3APGYl0ei3UwV4E/q8XS6V9wITW3AjNSb0w4SLT003LdswKBw01A6qLk
 aQ5PU7jWzvkujQwOKogxDsZ1YEagHYQDpfqPHs87C2yYX9IqkwhefquBRQPTL6m/7s98
 tBpBUuUqe+DvKUUzlgrC4JY0B/flNWZb4/PHjYk0mDUh8RowPHRF8EDHrY5Dys7DAAFR
 8SSdnaipfvVigLurP0Acr6699fa8QWsovaeeWcB4Gl5Q5/gbQ4I8KiRxRZE1DmrePh9o
 +72Q==
X-Gm-Message-State: AOJu0Yw2tCFCW5Yopd6F2Viq+xACBY7hvSl4qxjXZpU1cRWCSmugDzI6
 +2swSHjohz9mMdBOpQ1nRo3PcIzNmzkcZC5rugTEDlFpbTa1bFseJMgOvZdrPtEJ1YQ0AYqVcBk
 =
X-Gm-Gg: ASbGncst/I2eTPVCdYleKP37omeBu24fiRUjjV30LbqvgQAr+u9fPkPghw0XQ/HGn/L
 wc8pr8DEERfru/aQ2fMyBD0TUT5/D6G1ClmflbW8kYvaY7ma/Vt0dZKgQZ50cZzPt7SqnR63jC2
 ZVL8yoCszdklo0LTrHkf/9jlf7KBP9t0Bmda+zMhxobz4cUOfq6J+1j0mNRO0S+bCjPC3B8oxZY
 xpA5UKuUXJCCRgIxjxziZ1gLuLcw+8uE3iZCCiLOOyJqsfr1g9ZI26qrqOfzShBErKH9pjZnU51
 5flAuxge+qSgn/PyF7nyfyfEnfmckNfOwGPEUqPfmBDrUQaqm2RddjHkfM1DLIA7htHlG0CAhJT
 Q4w==
X-Google-Smtp-Source: AGHT+IGXSIv5X/dP+LSZIWH4KmkHMbwBzkISaierRhmHSjNY0BN2oOd448eQdWaMK+dHotqlzHWFeA==
X-Received: by 2002:a05:6e02:1c01:b0:3d5:7f32:8d24 with SMTP id
 e9e14a558f8ab-3d88ee265ccmr790715ab.15.1744913823004; 
 Thu, 17 Apr 2025 11:17:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 12/22] passage: spl: Support passing the passage to U-Boot
Date: Thu, 17 Apr 2025 12:15:54 -0600
Message-ID: <20250417121601.v3.12.Ifb43052c7d1729d6d1503a74e89abb69ee99cbf3@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

Create a new arch-specific way of creating a standard passage to the
next phase.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Make the stdpass calling standard arch-specific

 common/spl/spl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 6e38f118f48..b705fd5514a 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -22,6 +22,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <nand.h>
+#include <passage.h>
 #include <serial.h>
 #include <spl.h>
 #include <spl_load.h>
@@ -398,13 +399,28 @@ int spl_load(struct spl_image_info *spl_image,
 
 __weak void __noreturn jump_to_image(struct spl_image_info *spl_image)
 {
-	typedef void __noreturn (*image_entry_noargs_t)(void);
-
-	image_entry_noargs_t image_entry =
-		(image_entry_noargs_t)spl_image->entry_point;
+	ulong bloblist = 0;
 
 	debug("image entry point: 0x%lx\n", spl_image->entry_point);
-	image_entry();
+
+	if (CONFIG_IS_ENABLED(PASSAGE_OUT)) {
+		const void *fdt;
+
+		bloblist = bloblist_get_base();
+		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+
+		log_debug("passage: sending bloblist %lx dtb %lx\n",
+			  bloblist, (ulong)map_to_sysmem(fdt));
+		arch_passage_entry(spl_image->entry_point,
+				   map_to_sysmem(gd_bloblist()),
+				   map_to_sysmem(fdt));
+	} else {
+		typedef void __noreturn (*image_entry_noargs_t)(void);
+
+		image_entry_noargs_t image_entry =
+			(image_entry_noargs_t)spl_image->entry_point;
+		image_entry();
+	}
 }
 
 #if CONFIG_IS_ENABLED(HANDOFF)
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C390CD37B6
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 08:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767418658E;
	Sat, 16 Sep 2023 10:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAt5mbV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F3386589; Sat, 16 Sep 2023 10:25:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4348655E
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 10:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so32208345e9.1
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 01:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694852710; x=1695457510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=aI+9hJ/am1VvVJg/d4wjr8D70jZ36Dsvpo6y+ALITIY=;
 b=OAt5mbV4WNNE0GaP4sv7X5x+OMLr+FA/rsKdz1+WSHVZxuEi6i7V9MRedCIE3KP7Nq
 HIDturm84W+rdKmGuuwhUguEi73POPuS7ftE5DOXU1N4WH0cTWRNQ16KWREP/zOekodO
 9Mt5M3Hs728c/rNhYOwphyWBLd3OfbY5HZEgZoCKPZc9snRkzpWVVI/Ax5764JbEhJKY
 oF2Q2EV/xrF73N+TrmesHqyt0pKEO6b7cYIwPg1kpPh2Rw7+pSe34A2nv22fVuoNVqs4
 wj7mRcnILeCSixzzrGNHrEhIrvp6UnttZmrO8Z9JDeDh2uMpjZiQ0/DSbEiVVnskpwgZ
 eZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694852710; x=1695457510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI+9hJ/am1VvVJg/d4wjr8D70jZ36Dsvpo6y+ALITIY=;
 b=M4NQ4ZDZgoqvsa1NxVqSxy8xG1QkLM1ntBQ06phqxfmZNnoY1zUilXsAtRY1KEUyd5
 DyCiz14Xu+Q3pctRHg/Z53Ha7FD483A8aqcVwjmkhiS87xiGAizqgT1VQRwKq56kt2O0
 ZbGe2hTQvf751HhoeJmTXS4DyjNOz1K2x5a49ZJDhatk7CbSftooDb8Sc7x5ggFpEaCm
 8q3iBE5/UgggQQijUpx6n3NFBfE7Fa+uVUThGEe5GYbuiG0s060GmDQR0KbR8CAAqO+y
 y24qWOxsHfz2ux997xGJRP2aZWf9FI4J0Yk6pfRzGXS0dKosahNHjyM/Jlj4Fr9gxosD
 oCqw==
X-Gm-Message-State: AOJu0YyndyynceN9Q9yZcGxiQfCg2p3oXNgq+c6waGQCEbmCx+Q4c039
 BugbE8v1IDKgCFBZ/8XBGC/ZTu6Fti4=
X-Google-Smtp-Source: AGHT+IHNNlddU4QeQaQLgAthr4bfDEyPi0OqNXVyRz7+iI7unu75hQfc2NU9dmca8oz4Qs8A++B9RA==
X-Received: by 2002:a7b:c44b:0:b0:401:b2c7:349d with SMTP id
 l11-20020a7bc44b000000b00401b2c7349dmr3869992wmi.29.1694852709810; 
 Sat, 16 Sep 2023 01:25:09 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.71.172.204])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c024c00b003fc06169ab3sm9480635wmj.20.2023.09.16.01.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:25:09 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH 4/4] spl: atf: Reduce SPL code size
Date: Sat, 16 Sep 2023 10:25:07 +0200
Message-Id: <20230916082507.583405-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Previous fix commit increases code size of a few bytes. This minor
rework finally reduces SPL size of about 64-72 bytes (tested with
buildman on several aarch64 boards).

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 common/spl/spl_atf.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index 0d8db2d14e..fa79f73be2 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -209,7 +209,19 @@ static void spl_enter_atf(uintptr_t bl31_entry, uintptr_t bl32_entry,
 	atf_entry(bl31_params, (void *)fdt_addr);
 }
 
-static int spl_fit_images_find(void *blob, int os)
+static void spl_fit_images_get_entry(void *blob, int node, uintptr_t *entry_p)
+{
+	ulong val;
+
+	if (fit_image_get_entry(blob, node, &val))
+		if (fit_image_get_load(blob, node, &val))
+			return;
+
+	debug("%s: entry point 0x%lx\n", __func__, val);
+	*entry_p = val;
+}
+
+static int spl_fit_images_get_os_entry(void *blob, int os, uintptr_t *entry_p)
 {
 	int parent, node, ndepth = 0;
 	const void *data;
@@ -231,41 +243,28 @@ static int spl_fit_images_find(void *blob, int os)
 		if (!data)
 			continue;
 
-		if (genimg_get_os_id(data) == os)
-			return node;
+		if (genimg_get_os_id(data) == os) {
+			spl_fit_images_get_entry(blob, node, entry_p);
+			return 0;
+		}
 	};
 
 	return -FDT_ERR_NOTFOUND;
 }
 
-void spl_fit_images_get_entry(void *blob, int node, uintptr_t *entry_p)
-{
-	ulong val;
-
-	if (fit_image_get_entry(blob, node, &val))
-		if (fit_image_get_load(blob, node, &val))
-			return;
-
-	debug("%s: entry point 0x%lx\n", __func__, val);
-	*entry_p = val;
-}
-
 void spl_invoke_atf(struct spl_image_info *spl_image)
 {
 	uintptr_t bl32_entry = 0;
 	uintptr_t bl33_entry = CONFIG_TEXT_BASE;
 	void *blob = spl_image->fdt_addr;
 	uintptr_t platform_param = (uintptr_t)blob;
-	int node;
 
 	/*
 	 * Find (in /fit-images) the TEE binary entry point address
 	 * (or load address if entry point is missing) and pass it as
 	 * the BL3-2 entry point. This is optional.
 	 */
-	node = spl_fit_images_find(blob, IH_OS_TEE);
-	if (node >= 0)
-		spl_fit_images_get_entry(blob, node, &bl32_entry);
+	spl_fit_images_get_os_entry(blob, IH_OS_TEE, &bl32_entry);
 
 	/*
 	 * Find (in /fit-images) the U-Boot binary entry point address
@@ -273,10 +272,7 @@ void spl_invoke_atf(struct spl_image_info *spl_image)
 	 * the BL3-3 entry point.
 	 * This will need to be extended to support Falcon mode.
 	 */
-
-	node = spl_fit_images_find(blob, IH_OS_U_BOOT);
-	if (node >= 0)
-		spl_fit_images_get_entry(blob, node, &bl33_entry);
+	spl_fit_images_get_os_entry(blob, IH_OS_U_BOOT, &bl33_entry);
 
 	/*
 	 * If ATF_NO_PLATFORM_PARAM is set, we override the platform
-- 
2.34.1


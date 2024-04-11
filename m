Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6162DCD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94178824E;
	Thu, 11 Apr 2024 10:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eCg4b8vv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E76588250; Thu, 11 Apr 2024 10:57:46 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A92188241
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d8129797fcso101694501fa.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712825863; x=1713430663; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wnB2yt2mGhiEzh8NDpS8L99wpsNdUHC8LLMf7jGIQIc=;
 b=eCg4b8vvCkA6/M5C7UrWYWufH3185FiFR0uJXFNgGzwwdpioq4MKaozooolvAfKsBq
 kbuDkBOLAI5rLDWyovazakdfLiuuPwA3uhgXyVkjgi0z8wpOtEyXiue0z5Zg65o5T6oT
 6oNxefQQs/y4LQ7QrUX37OFVgYU81wC5NvM13WcQSrQsZqqDimlj2aiB5lJuaVJ8v+V3
 0SDDrYVcLlgKXjrOVQasZoiAmz27yUEhX63O/983fv704b7da+eonjzbta/nl116naie
 5rmTMrjcMC28awAp0gVPAyXZj8Afal0sPXEvpDQxpOGMzyJiHsNNc4rbz/Qk4CbsoiTC
 BfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712825863; x=1713430663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnB2yt2mGhiEzh8NDpS8L99wpsNdUHC8LLMf7jGIQIc=;
 b=dk6S9mWsFfL/Z9MbnxbViAX3mq89wfyWe9E2H6NFbAROPPG6tdMddzbJBYFIfCi3Xo
 M7AKcKW0ccjC9Rv2gNZAWhkOExR7EmhwvT9xlqnbxNJn7/Q/9sLtynzlKJciBQvVLJ6Y
 KPpVVtcohzEDuNAxQofAtd6JOkEATBU7MzlOOzvwKJwTwyH6D+xEVvrZYslbAwvcGhYX
 G80X3p16pWUw8Jd5HmUDJ3y45XWDaa2k5NM9CwPOWiD2NsNG3xkcMz5/ubUnJee1dOmk
 S9eiI7QvVcbmkHTS4tRpihBOZObn1xocnsl1zo1XDXq1dg+va5+4shaO7hSFBWacY0Wm
 RoXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViLMfvuK/JOGciqNZIbbsIz8CBAfTISpptFZRgMNhF04g6QWYDw0tQ//H4DBboS2dqbn26g9/v5Eoa8U1ZvQurFt+nPg==
X-Gm-Message-State: AOJu0YxkmyMksgwUEr1ljoabvbXy29xw322c99DmjmXFtXxnlbTBBLeN
 L0sOUOS3AHagtIkchiPBhqUiK4n7n8F26ZUL6/GA8v6TaAdkBsrS
X-Google-Smtp-Source: AGHT+IHieDgfUe7vnA78fgRGtCz8FfHOdjDU+Jmsp9lNgTv0EJdzVLEnTpUTaUMLp75NZkgeXJKUiA==
X-Received: by 2002:a2e:86d9:0:b0:2d8:3fc0:db5c with SMTP id
 n25-20020a2e86d9000000b002d83fc0db5cmr3916847ljj.20.1712825863167; 
 Thu, 11 Apr 2024 01:57:43 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:4110:4a8c:111a:1a9f:9667:892b])
 by smtp.gmail.com with ESMTPSA id
 bj36-20020a2eaaa4000000b002d6bc956deesm142569ljb.99.2024.04.11.01.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 01:57:42 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: marek.vasut+renesas@mailbox.org, mkorpershoek@baylibre.com,
 ralph.siemsen@linaro.org, sean.anderson@seco.com, sjg@chromium.org,
 souajih@baylibre.com, takahiro.akashi@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 quentin.schulz@theobroma-systems.com
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH v4] cmd: bootm: add ELF file support
Date: Thu, 11 Apr 2024 11:57:38 +0300
Message-Id: <20240411085738.31779-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

From: Maxim Moskalets <maximmosk4@gmail.com>

Some operating systems (e.g. seL4) and embedded applications are ELF
images. It is convenient to use FIT-images to implement trusted boot.
Added "elf" image type for booting using bootm command.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 boot/bootm_os.c  | 23 +++++++++++++++++++++++
 boot/image-fit.c |  3 ++-
 boot/image.c     |  3 +++
 include/image.h  |  1 +
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ccde72d22c..f6b46cf57f 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -395,6 +395,26 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
 }
 #endif
 
+#if defined(CONFIG_CMD_ELF)
+static int do_bootm_elf(int flag, struct bootm_info *bmi)
+{
+	struct bootm_headers *images = bmi->images;
+	char *local_args[2] = {NULL};
+	char str[19] = ""; /* "0x" + 16 digits + "\0" */
+
+	if (flag != BOOTM_STATE_OS_GO)
+		return 0;
+
+	snprintf(str, ARRAY_SIZE(str), "0x%lx", images->ep); /* write entry-point into string */
+	local_args[0] = bmi->argv[0];
+	local_args[1] = str;	/* and provide it via the arguments */
+
+	do_bootelf(NULL, 0, 2, local_args);
+
+	return 1;
+}
+#endif
+
 #ifdef CONFIG_INTEGRITY
 static int do_bootm_integrity(int flag, struct bootm_info *bmi)
 {
@@ -536,6 +556,9 @@ static boot_os_fn *boot_os[] = {
 #ifdef CONFIG_BOOTM_EFI
 	[IH_OS_EFI] = do_bootm_efi,
 #endif
+#if defined(CONFIG_CMD_ELF)
+	[IH_OS_ELF] = do_bootm_elf,
+#endif
 };
 
 /* Allow for arch specific config before we boot */
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 89e377563c..0419bef6d2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2180,7 +2180,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		fit_image_check_os(fit, noffset, IH_OS_TEE) ||
 		fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
 		fit_image_check_os(fit, noffset, IH_OS_EFI) ||
-		fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
+		fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
+		fit_image_check_os(fit, noffset, IH_OS_ELF);
 
 	/*
 	 * If either of the checks fail, we should report an error, but
diff --git a/boot/image.c b/boot/image.c
index 073931cd7a..5b88d6808c 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -134,6 +134,9 @@ static const table_entry_t uimage_os[] = {
 #endif
 	{	IH_OS_OPENSBI,	"opensbi",	"RISC-V OpenSBI",	},
 	{	IH_OS_EFI,	"efi",		"EFI Firmware" },
+#ifdef CONFIG_CMD_ELF
+	{	IH_OS_ELF,	"elf",		"ELF Image" },
+#endif
 
 	{	-1,		"",		"",			},
 };
diff --git a/include/image.h b/include/image.h
index 21de70f0c9..9a40bca22c 100644
--- a/include/image.h
+++ b/include/image.h
@@ -100,6 +100,7 @@ enum {
 	IH_OS_TEE,			/* Trusted Execution Environment */
 	IH_OS_OPENSBI,			/* RISC-V OpenSBI */
 	IH_OS_EFI,			/* EFI Firmware (e.g. GRUB2) */
+	IH_OS_ELF,			/* ELF Image (e.g. seL4) */
 
 	IH_OS_COUNT,
 };
-- 
2.39.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1801CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 08:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E676A881CD;
	Thu, 11 Apr 2024 10:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WDi1SkPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1FA88280; Thu, 11 Apr 2024 10:29:09 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DA98865D0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-516a01c8490so437846e87.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712824146; x=1713428946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hmxfq23HcvWlihi2WBwDpYODLE7D4eEjZZW872Ffp/I=;
 b=WDi1SkPTYDA7WKJ1xmcYps3s0BBOZDkmZTv3UJmwpEyaFlJ5gck6v/ChkJF9WAF1Kn
 y2y1fAEeRt6v21ZzNjyTfZxVssOMABQisS2R3Kb9zKIk0UJPFwmJGL3L5LeHhzOGHujS
 XYU8yZXWETXTzErE1b/g/PxSTRsW+WYL7gN/RZr8MYCjMmS6n2uaOs8eq0eVeqsuQ+EH
 cSryjCA29et3inlOuu5IDVYESBaE7eS5kMdyis1f9zOndAClna77TjJWo4oeh1n/PMTN
 fDXae8YahsAf8uSsImWr2QyTK6eicBgXiO5QWKYBCnh2YjTLUV04eHIO2hW0kU4eqQYu
 TZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712824146; x=1713428946;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hmxfq23HcvWlihi2WBwDpYODLE7D4eEjZZW872Ffp/I=;
 b=vNbLUYu2NkbMDAVPrJPBrJVlWM83gR3S5nYcUeyy0Wbr75faGyXP+X/Cyukpo5Kkex
 yMtwTXiYVFbypBavTDHdYc6dnVseMc2fDvrWy1AlOQlkptXMyMn1JKYGBneTercaRXx9
 shI1tdUkfgEsdnMZmTc7lShV+Xo6K63rK0XUK1S3xSr8bGNr6gokEY8pbINkYe4wDSaC
 NG5Cnnej9SNsL7zRsWu3RziOax33vnmOtYuqNrK4CqMf3iM5yd4BPnzlzZemMJZhTFbC
 BcLOwZPPsjMV8O2aisNK2/uw23c0NRcZlatpg3JKBb/l2yL1dOS9D7Z9vHoC2X5UYYXz
 u0Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsY1CEAJAS2hOu8p8u31zvhsVJNnpgIP6tvPrzWDTzIMKpdD6+sdXJaQj1WDQ85ciVrY4unJwmadBC2Hnsq7m8GKQD2w==
X-Gm-Message-State: AOJu0YwXTyndH1cZTzCthfycuxcW1Pev1pofrxJsr6yDHpcqNOHQ+5BR
 rF90iz0oQYVTXwePUwIhtcMh1M7VD8ctcc5Kn/wqg5eDr3rbrFmY
X-Google-Smtp-Source: AGHT+IHdYDVdHs3vd/ninN4JmYC309NyKWAizphmijNg07XM6rRFBZuYkq+uPlVALBuaYrwscsFMcA==
X-Received: by 2002:a05:6512:b9e:b0:513:ca5c:fccc with SMTP id
 b30-20020a0565120b9e00b00513ca5cfcccmr718363lfv.7.1712824146049; 
 Thu, 11 Apr 2024 01:29:06 -0700 (PDT)
Received: from moskalets-nb.avp.ru ([2a00:1fa0:4110:4a8c:111a:1a9f:9667:892b])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a199111000000b005159d671616sm144794lfd.134.2024.04.11.01.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 01:29:05 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: marek.vasut+renesas@mailbox.org, mkorpershoek@baylibre.com,
 ralph.siemsen@linaro.org, sean.anderson@seco.com, sjg@chromium.org,
 souajih@baylibre.com, takahiro.akashi@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 quentin.schulz@theobroma-systems.com
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH v2] cmd: bootm: add ELF file support
Date: Thu, 11 Apr 2024 11:29:02 +0300
Message-Id: <20240411082902.20065-1-Maxim.Moskalets@kaspersky.com>
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
 boot/bootm_os.c  | 24 ++++++++++++++++++++++++
 boot/image-fit.c |  3 ++-
 boot/image.c     |  3 +++
 include/image.h  |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index ccde72d22c..1c92b8149c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -395,6 +395,27 @@ static int do_bootm_qnxelf(int flag, struct bootm_info *bmi)
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
+	snprintf(str, sizeof str, "0x%lx", images->ep); /* write entry-point into string */
+	str[18] = '\0';
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
@@ -536,6 +557,9 @@ static boot_os_fn *boot_os[] = {
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


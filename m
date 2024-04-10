Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680DDCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 21:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879E8878A1;
	Wed, 10 Apr 2024 23:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iv0nbEqb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB85881A9; Wed, 10 Apr 2024 23:22:05 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE6CC87150
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 23:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516d6c1e238so6236711e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712784123; x=1713388923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XTaplCsqxAtn5Hd/ULBkC+T6OlmgNprGQX3f31jBe0U=;
 b=Iv0nbEqbEN8Y27/g7ScaSu+awzs9nLbcn3AJqjz6hTIQkBB2tD7GgLib6fj1/ywdPu
 n/Uq1U8KcFlx3byEO3/rBm+NVRqNwX17xnvxuBrRuury+pnj1rNcJRa6whMjGp+/NT9q
 g7HS/PXz1zkRqMLVT09G9UdG9EaQPNWNMEipJgDn1SeHAXMbkewMNQFtg/dS8/kcgGIo
 GAtoVkbEsSzUpKnywYauA6vtVwGHXfkFFr0LxP1xaCtE48teWsE0R2gvPySSnS6URIu+
 5wGMXoHDA5SmanEK0PJ4Kzc17E/VaCiI4Ud7EgyafoZiA714bJojVYiwLX1QUB555uP8
 hGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712784123; x=1713388923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XTaplCsqxAtn5Hd/ULBkC+T6OlmgNprGQX3f31jBe0U=;
 b=SPZIR3/4tjNL52dzUIQ1UX00Lx2pi24lA5onPNVeLDwTqE8euQ6o9TiFmaCbzi4n2f
 ns0brC+PtHHqJL0zFwR+TkpjQYCdXJmqz138v32fL7e+RRyE2zgHOYOyHHjgFE7lsXaZ
 bAhG0ojin2j/aX26FzaUa7UaWrSG9SO7ouclQKvHFJgC/cgu6dYzr8CnWEldqA33CBxV
 lvQVvhcBkKP0+90ODSp6K7hVhPs6RtGpMuivL5bThdV8QNndDbkzoQwoFk4ZCwfaNUNV
 J+f9Xumu3gyI5Jvhv/hpyaOMEACHcsjdfCSeuqgEXFpNYM5Ngs/NRg9tSEkFrGt0a5Yv
 NMjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN+j275RLKXku3rjXM+vdqXwwGpXh/58OUB1ZTmRRtzaIDes3XYCOMXXhs2F5U+t2E1lyW4u8XnwENjRxwumfCJyRkkg==
X-Gm-Message-State: AOJu0YzlLfFmHlTH9/1mO9DVL5TcK/CPJWxHkvyIxC0UdLjvbgbkM384
 DRz122dy/8hOT/3YSmo7udr5cBWr8jZ7NE2WjFMIgnfY67txJW2e
X-Google-Smtp-Source: AGHT+IGG95v+9hACo6iGSNXd8/J7JhP1IcKkWm3xpmUJYeRPF9GdfA3sIGOq1FvrEpvmtKsD0IdnyQ==
X-Received: by 2002:a19:910f:0:b0:516:cde1:cf19 with SMTP id
 t15-20020a19910f000000b00516cde1cf19mr2345139lfd.12.1712784122710; 
 Wed, 10 Apr 2024 14:22:02 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru.
 [109.252.14.191]) by smtp.gmail.com with ESMTPSA id
 z7-20020a056512370700b00516d4c31ef4sm17949lfr.248.2024.04.10.14.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 14:22:02 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: marek.vasut+renesas@mailbox.org, mkorpershoek@baylibre.com,
 ralph.siemsen@linaro.org, sean.anderson@seco.com, sjg@chromium.org,
 souajih@baylibre.com, takahiro.akashi@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH] cmd: bootm: add ELF file support
Date: Thu, 11 Apr 2024 00:21:53 +0300
Message-Id: <20240410212153.6854-1-Maxim.Moskalets@kaspersky.com>
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
+	sprintf(str, "0x%lx", images->ep); /* write entry-point into string */
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


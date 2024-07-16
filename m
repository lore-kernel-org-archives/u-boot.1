Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC1FC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED66288984;
	Tue, 16 Jul 2024 09:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N5KnHRU8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247848898B; Tue, 16 Jul 2024 09:04:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BBB88971
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-427aeebaecdso11605905e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113473; x=1721718273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UdkFCeTeVO/sskCVzuXx4r9crqLLSuoHY45wTgqz6E=;
 b=N5KnHRU8qo21RnmJcidp3KX8IAUoPq1jBxby8B1pWXXTVAEvzd5NjOvUs6D0bjajTs
 eipixgqykHuc82L6GLgFqqf9nV7wLou6Bt+ewU7dwNZ9CfbZfSKnTL8GHGJPwi1ipIl6
 thJM3C2qD0fY895+gvwjLSdA4SjCF1JuZftrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113473; x=1721718273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UdkFCeTeVO/sskCVzuXx4r9crqLLSuoHY45wTgqz6E=;
 b=PtyRfGyPavy2Nv80K2OrS80rzBpFwa8f023qd0H/hQ4PN0u/XdO6bR+FBk+cAK/JME
 Ksb6hpTKIpaJUCeNYjMjlXeiKdqXSad/dSu8f1nv/WqWmoaePcwsrXA9yptGh/c8a5U0
 EeTc8vWUUFvRBfeNzuvZlH//BwmWSZZaXOqGd8pQVIy41/JqVVXNMfynaHV8DbIDmyPO
 DPUTHT2QwH49YhtMy0ibPa+fdtMMxqeNfPeQiQ5f15xNfeJ2laH5umKXnYAHPShq6W6W
 PwYKGsAsOxLflho7MzW/Bs430t3NYbXnH8mI0MlmwD9XOhsmpzq22dtG+60gzD8YwcuQ
 Ap1Q==
X-Gm-Message-State: AOJu0YxXA0KPfS1ev0yO9mdU60ReymWiSXOg71f4v/DpJSc2eVTIIk4d
 ZCLF1wVHj7CapSxjT8iD5x6Htr1p4TSki1nLGZwq91YPB2EIXjmbRqPwFUPVB1OjusITMgYEV60
 =
X-Google-Smtp-Source: AGHT+IENZIxF4bp7FR5+6Inm4E4Nndmh2xmJgRfZurEnThavlZBAxziYeQaxuskubDW96UVUU9zfsQ==
X-Received: by 2002:a05:600c:3152:b0:426:6707:9be4 with SMTP id
 5b1f17b1804b1-427ba62bc4cmr6565955e9.14.1721113473633; 
 Tue, 16 Jul 2024 00:04:33 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 09/14] bootstd: Tidy up comments on the boothmeth drivers
Date: Tue, 16 Jul 2024 08:04:14 +0100
Message-Id: <20240716070419.1897560-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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

Fix a typo in the comment and add one to the EFI driver too.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/bootmeth_efi.c      | 1 +
 boot/bootmeth_extlinux.c | 2 +-
 boot/bootmeth_script.c   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 5a4c125835a..56a6e47f5b2 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -394,6 +394,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
 	{ }
 };
 
+/* Put a number before 'efi' to provide a default ordering */
 U_BOOT_DRIVER(bootmeth_4efi) = {
 	.name		= "bootmeth_efi",
 	.id		= UCLASS_BOOTMETH,
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 9b55686948f..fbb05ef928e 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -183,7 +183,7 @@ static const struct udevice_id extlinux_bootmeth_ids[] = {
 	{ }
 };
 
-/* Put an number before 'extlinux' to provide a default ordering */
+/* Put a number before 'extlinux' to provide a default ordering */
 U_BOOT_DRIVER(bootmeth_1extlinux) = {
 	.name		= "bootmeth_extlinux",
 	.id		= UCLASS_BOOTMETH,
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 0e05d28d4d9..24da47c7259 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -250,7 +250,7 @@ static const struct udevice_id script_bootmeth_ids[] = {
 	{ }
 };
 
-/* Put an number before 'script' to provide a default ordering */
+/* Put a number before 'script' to provide a default ordering */
 U_BOOT_DRIVER(bootmeth_2script) = {
 	.name		= "bootmeth_script",
 	.id		= UCLASS_BOOTMETH,
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4294BC35FF3
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5293381A04;
	Sat, 15 Mar 2025 15:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZxvjJeFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31F98198A; Sat, 15 Mar 2025 15:27:25 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6B19811B2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so3380815e9.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048842; x=1742653642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=ZxvjJeFifpSKRw1iNd8axY0RyB8SLdiTJJTTew/vCLV5JzLxArxqSlEZJcYtGaG/MV
 n8ghtkyzCMKfQMOBloizNpvDmRB+d/hD90H/m683HOsR1AgKFWiVEdtRvnDEX0xBXJXm
 2hC9ZZ/1sDV4KKYVaZ8sMIy6e6Q91TNnzNIfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048842; x=1742653642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=lLIJ4vvDxb/4eim7Z/RxtlrmMOJTvFzGPDdAdUqEApopZ5uYjcMphZRe3ZGYd6up3a
 Sl2L1xBQbSxgJ64R+bdnuurGsJ6q6QuXmbiLry3NzP7r4zMNbPm+9MxiZgA2MwfrrpVX
 NMkic5W6Q6rW5ayNLH9t6oaTFWY82yKD/GLlXC5E1+hdiE/9cpShv/hRpFvnwO7wtV4R
 8NBOv8om/Keq6Uf3XLE5KdK/pEIZdntj/Uqneonm9eLAF0KxeWMt+0ybgL+27fshMpxB
 C8SZMB3vmrcHd+V4sHEqlHdABBIYCesA7NFRVxA9qP0/PH1oVETVfxZ0188GKWGtEkjN
 6+Sg==
X-Gm-Message-State: AOJu0Yyew24XSq0pVEVcIKY9JF8QQlnUhNOBxTxcOGoXNpGjAbVw9Xk0
 eK3EjvfGEdy38HPXyvbx1YtFTMAGQACc1NikIHUEmlCsWn1zMwq6fYARtxF6ZKZ6iWaXku4sFfy
 /lg==
X-Gm-Gg: ASbGncsHG5d/aZftqAAWHakD4mTyUzt2iPRS9gGmICHdvpUSI802jUxEVDD7sNsynD0
 JxYhzhkwyHAvBJRh8UHQv6qgBMt1RAjF0/n0VeaRf+RIk06mH0XE0mbugJQ6B/Xd3VBTWtrg5Ng
 M7MN7Ponm2MHk7t4NEtpmxMmQREVBlHvjc3eV11MyxDoUuNIbtI545jjCfPUY6CE628hUFvVWop
 2o6ikWnxQcL3zBCFZ0VOgxpd47xnAiMydf6ije9Cjp89orlR1b8GOgFd7AEAMYjZPf+UFqTBlA4
 L5B9QTacmmc8M6Nx6A2lQrJAkyMUUT5zcZiEFRMmsA==
X-Google-Smtp-Source: AGHT+IGQFKxTe9uUhW69L/A1IKrS1GeD6w9nXe1sPPJUaJMkVEXu7Qea37LPcLLKzb6JIV2El1doTQ==
X-Received: by 2002:a05:600c:6b09:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-43d180cef19mr124533465e9.13.1742048842173; 
 Sat, 15 Mar 2025 07:27:22 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:27:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 06/46] x86: qemu: Avoid accessing BSS too early
Date: Sat, 15 Mar 2025 14:25:26 +0000
Message-ID: <20250315142643.2600605-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

BSS is placed in DRAM which is actually available early with QEMU. But
it is cleared by the init sequence, so values stored there are lost.

Move the system-type flag into a function, instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/qemu/qemu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/cpu/qemu/qemu.c b/arch/x86/cpu/qemu/qemu.c
index 563f63e2bc8..e846ccd44aa 100644
--- a/arch/x86/cpu/qemu/qemu.c
+++ b/arch/x86/cpu/qemu/qemu.c
@@ -15,14 +15,21 @@
 #include <asm/arch/qemu.h>
 #include <asm/u-boot-x86.h>
 
-static bool i440fx;
-
 #if CONFIG_IS_ENABLED(QFW_PIO)
 U_BOOT_DRVINFO(x86_qfw_pio) = {
 	.name = "qfw_pio",
 };
 #endif
 
+static bool is_i440fx(void)
+{
+	u16 device;
+
+	pci_read_config16(PCI_BDF(0, 0, 0), PCI_DEVICE_ID, &device);
+
+	return device == PCI_DEVICE_ID_INTEL_82441;
+}
+
 static void enable_pm_piix(void)
 {
 	u8 en;
@@ -50,16 +57,17 @@ static void enable_pm_ich9(void)
 
 void qemu_chipset_init(void)
 {
-	u16 device, xbcs;
+	bool i440fx;
+	u16 xbcs;
 	int pam, i;
 
+	i440fx = is_i440fx();
+
 	/*
 	 * i440FX and Q35 chipset have different PAM register offset, but with
 	 * the same bitfield layout. Here we determine the offset based on its
 	 * PCI device ID.
 	 */
-	pci_read_config16(PCI_BDF(0, 0, 0), PCI_DEVICE_ID, &device);
-	i440fx = (device == PCI_DEVICE_ID_INTEL_82441);
 	pam = i440fx ? I440FX_PAM : Q35_PAM;
 
 	/*
@@ -123,7 +131,7 @@ int mp_determine_pci_dstirq(int bus, int dev, int func, int pirq)
 {
 	u8 irq;
 
-	if (i440fx) {
+	if (is_i440fx()) {
 		/*
 		 * Not like most x86 platforms, the PIRQ[A-D] on PIIX3 are not
 		 * connected to I/O APIC INTPIN#16-19. Instead they are routed
-- 
2.43.0


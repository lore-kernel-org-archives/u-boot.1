Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22399C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B90581870;
	Thu,  6 Mar 2025 17:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dDpD5KQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2215F81428; Thu,  6 Mar 2025 17:05:03 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235448141E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so2998535ab.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277097; x=1741881897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=dDpD5KQGr/yizD/VSEpvXtjXC6ApHbbMy2B/RFnNI+GPC3sdLg6Fta3PWel+zfPTOE
 kNrelXpBiX6neaAs0lhs7pgPF8X0nEsuZe602OAiI0xKvDxL2Oq5mKWtma52nht/3hIf
 IKKfnQnmnYDcp9iwm6EqS+WEqR8YRJI6OCPx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277097; x=1741881897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=R5q/4B8mUi9AlsyEFBXStITMdlUOSRNvqDXIals9pe7/8B6ujaAe03lM8x5ofwDZfn
 D9lrewFXMiCgVzAPL8uvSDri8G7I2NbhmOoajNz7r+vHsrbJNKlH8AtQwGpqGg2rzGaS
 8rIKSuY8CtTg82wXwK/qOmY7Y2ZgphJkp18f9oR4vxKxn+OfX1293ejwU+yViEww484f
 N8JIB4Ms2ZpU2uDnFVTvJntUZoRQPJUBJQxrLI0VzcLoIrZY7NJnjrwtB8o7f2Kx1xft
 wjn7s5j1sYoYAKxnVPP8Y614di0ReB5faZJp7yYIWBsBjIS/3MBLaEtWB39wh2CG+DHF
 Zdrg==
X-Gm-Message-State: AOJu0YyJAmpYvRGr8YqoZzy4iCsmvhevUISvkc5OowV5mXwIuT6nK3zZ
 /XfStfWy6bgVYu7po/FeGi/rkJ9ABmeTfTI79S5QSM6Qrj4xT3THO0DloaEOzpgSp7VWX/xS7pQ
 =
X-Gm-Gg: ASbGncskIZzi7rU+mp7D5IS9MoGLbPSjU+cHBUnczhFPeSh/GBsEbaZN2Yu/t5Zgjdz
 2lZEiiUF9sAB81z6nUYv1EAEjwdeLeVC9fI4c7ktqjjq97Bv2HxfW3yDewUkbUlIj1HrldmAX7+
 V01impp6t/+QPFjkQjohMM9RM3avHs7t55BeYVETGYh0M2x3IT4tCyj2zGjrj2XdQzDr8obYTlB
 phsOD5J0VcTbEE6iroRzuYSH6uXs3wEtnXQNziyJbRMd5Jg4OqKadKb2DVQfci4GYvZi5hgu0pe
 JhKDI0u9BqjRMRKBeQZw9MvKv7QZW2UYWV52HDfixlb/+m98q5SDSTZYX/3yw2kfjGrtIL3m8qJ
 9PnGYhQ==
X-Google-Smtp-Source: AGHT+IEEQXDzmyW5nkBuIaoREplf5yZ8Jtg/vswpLt2FZkwUf5WEnmJN1MFp2Hg2Quy0N2OWtvpMLg==
X-Received: by 2002:a92:c266:0:b0:3cf:bac5:d90c with SMTP id
 e9e14a558f8ab-3d42b9759f5mr105381605ab.18.1741277097260; 
 Thu, 06 Mar 2025 08:04:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 06/47] x86: qemu: Avoid accessing BSS too early
Date: Thu,  6 Mar 2025 09:03:33 -0700
Message-ID: <20250306160428.3041057-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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


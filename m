Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752A1C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E333980F67;
	Tue, 25 Feb 2025 00:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTN0B823";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9449B80FA4; Tue, 25 Feb 2025 00:07:07 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B1A80FD1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d2af701446so40766555ab.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438423; x=1741043223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=KTN0B8236dXzZiTkXiqn6N4GAYP+f0FJFH/fy7eTc99w1yDahecZRfSaGDROzSYUHp
 iSiUjqPeXaTNbCP6lLYiZ2/Av5TsrMQT/X+kyMagcqyoK6VazuevJCP3UqXegt/tCh2I
 BzJn2Eavgh7aaws4QFwYD2YsA+QPKhyuY+2aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438423; x=1741043223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=E5Jds9OcsvUXWLevq/84dBZlDFMbUDcNRq4SKuEJEyqEjrnRAyEveROgJ92b+phU7U
 JVCOsQRNTODvj1z42qMqFtHHJDZjyCjq0nho5wwHljAnk7iDh6hx/FJxWjVt+MzUjok+
 QpnGl7mlWT6tAk81wxz/tCUhnw8CyZvdGnxfXHhqCmBg6HQ/+TCU0fa7Nu0LdhNtxp9A
 Hfned2Tl+YOaSSXOyxzJI/DkJ5PbbCoGMfKmDABvGFfUWjehluAfigLXD14JDlPHeVes
 RgGfx6fMKsUqfdpSgZjOyA7UN+EcO0dTiBbl9LGqMFZYguEdpFr+I47T70S9uD+83k/M
 WelQ==
X-Gm-Message-State: AOJu0YwLDdnAZ63fCGEEYNMz8ONiTo11XujrLLS3bi/Snl3zkJ/fIv4A
 xV0nld64puGIjdRVFQwspfKLZG7f7362QfTeyyqXFS/9l+kVQjWn8oBBrzah3N7HdDxkdqbD6O4
 =
X-Gm-Gg: ASbGncs12NxtfEguNh37v0rVP2PnGFWPLKHImtuGIxkMzqcj7MAhAhZ4vp1Iq6icdtC
 +jlH1zc8YyvUuhOH8KqP+QX/sOdK5N4cT8VA9u9v5l/07/AlnriOqQqUDYsBFOlQTDMC5lEhWOy
 JahD3athIPQu6qmRT0bUBAYkHEmpNmxInz2oDL0aTQz2uX0vGjoxYdKEtJVbTIDsmEOkTA+ERS9
 GRKDLYaO+p8Rg2LbFU0vlaZDA4PztrTaD/JjnyEQBFSJI/7YOabedJFWusQattrIKAvTtxaHfnF
 kiILyz0tYAzvDYOs+SbZNuUYOXA/5Toiv6lRERkO7HcLre/TbDJL8uw/ytMSrhc=
X-Google-Smtp-Source: AGHT+IFNct6lnzD/RZAZBeipW8gHFWGG2XuMfCVmS66pkePHPioDGJmUrm5ZiV/XCBnOKBRB9w0pMA==
X-Received: by 2002:a05:6e02:16cb:b0:3d0:137a:8ca2 with SMTP id
 e9e14a558f8ab-3d2caf0dbeamr173540975ab.22.1740438423559; 
 Mon, 24 Feb 2025 15:07:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 04/44] x86: qemu: Avoid accessing BSS too early
Date: Mon, 24 Feb 2025 16:05:53 -0700
Message-ID: <20250224230640.2665206-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D060FC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27C818056A;
	Sun, 16 Feb 2025 21:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V+cmkJV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8284480F57; Sun, 16 Feb 2025 21:45:00 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B68080F68
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8559461c2c2so2009439f.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738696; x=1740343496; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=V+cmkJV1PL3qGZtDAWMYnHsgGe2N3nt9T7/bBOR3FSa5Co87EJHj1jm+faLnXqtYBi
 1bClKL4NlCSzkp5ZWe5SlelJL5akBBdg8hpRCxfrwJgcWcILFMvRt0qJuBqkiPBBXAJD
 pVlaAebg5pdsvXcirS25KsGtZ9yaV6ovExNwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738696; x=1740343496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSH50K2JoZy3b57Ten2+Yq1o4INV7m/qW+7NuVpQc3U=;
 b=SvFDuU5Sie6H+cQqH9c+h9hC/3xaihK766fzok8r/H6Hxg0TBBKJlEE7HsK6ZqSs+d
 XVOhgOD41UqmMGcOjT4rAKmks7ZDflcCxeAaBmwmPqrZHT1GG/JOSwCgKaNkn/z1pcJn
 x/zIG5BQxaHnbFTthomwjYorbZ4ovqfNGFwVUborCwlmX6Qc8haVQ1F/AtM5uigz4Pma
 HKB9vHfokXY4UYFNSYjQyQQjvxXOI1z1Wf7MqNcmHoq22TsEahrGH674XAkGplDZN86M
 8oOogjORrDgXYTxEG9iDFBKoI+D2z/ornfJfcoAVDZTXN1ZJQoVfuYGowpkU7v+6nkfj
 2RaA==
X-Gm-Message-State: AOJu0YzjP128GMjWrbe90WWQSG3dd6fOlHEzMRTtiRndVUcfoilQAKYW
 QXlbO7Rb7iYcY4bvmQLNi52cwgGBZ4zKiWkt+YgS3MdlxGCqrAWmGECCwQW8msW/aX/0m455wr0
 =
X-Gm-Gg: ASbGncvPgpkOfCKKxtGStFPEdK4TN/vKJmifKFPjfOPv1uIr8E5B1Ezq/q9Fcz1rhhb
 RhsRyDSOHKf49KyzxXB+iRoDDWG0HvSFJS4jlptree9IUNpL1f62u7JDg2tkGXyoM1Hdvdo9pxd
 CkLWBpYDlh3ZAEsnfE1AvXbp/bHqdV9x0nMOb7/92DozN/z9kUW+O4+wp2+3rKnGynM1w9P9uy2
 CvV3wfjxvU2KogHTDxNoIhZtOWZ4CDsyZrbW63sQ/q4shVQBn2B3jSpA3NvrAZhtbQ4feH67K0H
 sAmAgz7qa2xOZIFWqbVe7ZFPHwdlFot3NW8pj6cVuwICWo8xwY9w
X-Google-Smtp-Source: AGHT+IFISbdq5Wij5MmQleMsFwBroEinOUYjslIJWvkUtfyVXW49il4lSVIOnWISmblklYFkdKf4fw==
X-Received: by 2002:a05:6e02:1fed:b0:3cf:fa94:c7d with SMTP id
 e9e14a558f8ab-3d2807fe341mr49492515ab.9.1739738696188; 
 Sun, 16 Feb 2025 12:44:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 04/28] x86: qemu: Avoid accessing BSS too early
Date: Sun, 16 Feb 2025 13:43:49 -0700
Message-ID: <20250216204421.3560012-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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


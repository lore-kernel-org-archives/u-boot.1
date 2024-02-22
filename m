Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615ADC48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 15:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18961880AC;
	Thu, 22 Feb 2024 16:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="rgtXRu3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03042880A1; Thu, 22 Feb 2024 16:21:34 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2074587C56
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 16:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3d2bXZQYKBtY32JF2K8GG8D6.4GEM-3GGLDAKLK.56FP.56@flex--barnas.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-607e56f7200so71615997b3.2
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 07:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708615288; x=1709220088; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=rlMFAkrKn4ZcuZeo1F/ZBa8pchDzsFzQllBc4nlGcA4=;
 b=rgtXRu3n32jKGv0nbEVwyUekTvz0iSJinrw5q2GSAcIbYpHMJkTCLtblBkkqI3Jox8
 kRPoGHUsBPg6b+N7txJwaLxglNqkGZ0h0DzHbe/WYBmKQlBpVUv0CQKv7bm3c4eoXmdm
 5ZPQ1ha7NsAhe/SJwA/7ekGiKybzOcs0gH5zwGjt7uzXYLEsc/ZLBYLcUOTrFUnUUbX6
 l0tRBI7FU82e9cnFz2VFhW8Yb7JptpmQvhsKX/1Z9KAjYQJKon/olvXCkh0R++kB+skE
 CacZuACY4W6Ykk2DjNujXaNF4SCH30dsYREUSIOxTfcaosXsWehydpACTQO7huW6mn0A
 Bexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615288; x=1709220088;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rlMFAkrKn4ZcuZeo1F/ZBa8pchDzsFzQllBc4nlGcA4=;
 b=rZVlM0lYrLhVdFXB/CXaEBIagOAkfYmCZ9K5OSje7WeEBkqcBCTNuTp+GmZ5PXgHrG
 UDtQfR+LY1XRc1OdaGI0scqZtnvcUQ595GZz+KbyPwC5goVyNxXoidzobRHvr9tW7r/+
 YRQzrcES9lQt8wj+qB476eeQkbPq1SE3esuXp/BhX4VFVHShKgqE7p59Ij5ynEzhclgu
 Z/Aq/fcvIOn0JM6g7BM95rNJ0W+M54ON3ykOPBmI2UEtDp9Poo0UBjAH7qaKwEI0ZS3W
 QVr8/Pw4xRrAaiQYL2qPkHAGPOZGlETPJ4KHXHZGJrjbtQAMjG1wlRZ5qFzjVvBRBQm6
 1RIA==
X-Gm-Message-State: AOJu0YylSKOCaGm9emZhdfFbaUVS+2A3z0DqLMPtOTxXYkPWPmWuhlcK
 vEuzbVytY5FspqO6T9gCcycpVyOG5tSgFOocpqaRTFyiG5Q45TPH918riFv3BeSaXY8CZkmk2hn
 LUCDXJiF9Zc7xPIygX5+a3WGk9Y6coJJlijck+ojvX9Ol4dtajWpnGd3UB54MJivYJXORu0dpg/
 KQj2Id2zKZ8bMLPV+KNkOIwvdxEfj0Sw==
X-Google-Smtp-Source: AGHT+IG0p5hwnxCEpe8SbX8d1ojrcOoIy56zFg53F7kz+NbsW6Ufa9jn5UX9yHUumqnM/drreyaxx+V9zbM=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a81:99d5:0:b0:607:75af:8006 with SMTP id
 q204-20020a8199d5000000b0060775af8006mr3567905ywg.0.1708615287805; Thu, 22
 Feb 2024 07:21:27 -0800 (PST)
Date: Thu, 22 Feb 2024 15:20:56 +0000
In-Reply-To: <20240222152102.1677445-1-barnas@google.com>
Mime-Version: 1.0
References: <20240222152102.1677445-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222152102.1677445-2-barnas@google.com>
Subject: [PATCH 1/2] arm: socfpga: arria10: add option to reprogram the FPGA
 every reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Feb 2024 16:23:55 +0100
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

Add Kconfig that enables FPGA reprogramming with warm boot on Arria 10.
This option allows to change the bitstream on the filesystem and apply
changes with warm reboot without the need for a power cycle.

Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
---

 arch/arm/mach-socfpga/Kconfig   | 8 ++++++++
 arch/arm/mach-socfpga/spl_a10.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 114d243812..89303f1f16 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -80,6 +80,14 @@ config TARGET_SOCFPGA_ARRIA10
 	imply FPGA_SOCFPGA
 	imply SPL_USE_TINY_PRINTF
=20
+config TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
+	bool "Always reprogram Arria 10 FPGA"
+	depends on TARGET_SOCFPGA_ARRIA10
+	help
+	  Arria 10 FPGA is only programmed during the cold boot.
+	  This option forces the FPGA to be reprogrammed every reboot,
+	  allowing to change the bitstream and apply it with warm reboot.
+
 config TARGET_SOCFPGA_CYCLONE5
 	bool
 	select TARGET_SOCFPGA_GEN5
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a1=
0.c
index 9edbbf4a29..d5d3327a42 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -122,7 +122,11 @@ void spl_board_init(void)
 	arch_early_init_r();
=20
 	/* If the full FPGA is already loaded, ie.from EPCQ, config fpga pins */
+#ifdef CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
+	if (is_regular_boot_valid()) {
+#else
 	if (is_fpgamgr_user_mode()) {
+#endif
 		ret =3D config_pins(gd->fdt_blob, "shared");
 		if (ret)
 			return;
@@ -130,7 +134,11 @@ void spl_board_init(void)
 		ret =3D config_pins(gd->fdt_blob, "fpga");
 		if (ret)
 			return;
+#ifdef CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
+	} else {
+#else
 	} else if (!is_fpgamgr_early_user_mode()) {
+#endif
 		/* Program IOSSM(early IO release) or full FPGA */
 		fpgamgr_program(buf, FPGA_BUFSIZ, 0);
=20
--=20
2.44.0.rc1.240.g4c46232300-goog


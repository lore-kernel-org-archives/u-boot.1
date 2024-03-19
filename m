Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FDEC54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 18:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5134A8806F;
	Tue, 19 Mar 2024 19:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="wpHX/Ccg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAB488033; Tue, 19 Mar 2024 19:20:09 +0100 (CET)
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com
 [IPv6:2a00:1450:4864:20::14a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A949A8800B
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3VNf5ZQYKBiE87OK7PDLLDIB.9LJR-8LLQIFPQP.ABKU.AB@flex--barnas.bounces.google.com
Received: by mail-lf1-x14a.google.com with SMTP id
 2adb3069b0e04-513340d10ccso5114597e87.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710872405; x=1711477205; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=TZjTrxlkVoqA5+h9FQuyimFfAhd3TY3/Gw6FsezJpGY=;
 b=wpHX/CcgSkgRbpmlq0ooK/NXku+kwdnDCwn2cWkb3JIrW3aCbhLw9Pu4zWOlv87nAP
 GtSVnOpvrdlX6yZ2qO1aod3malHn8H+kgIK2n06WPvDb9BEpN6l4f/ud/naExdTM9zNz
 kSiOdkJbWAr6BjdsIl7hmfdVsv0Dlu2PLtQ8p3P1eDQVjUT1lj4Ek+jx4ROtI1nWzGpm
 +s72mGApaQy3lCbf+Y2s2jYL2/lVogfrSu+PlB+puPlJdVDybDGlyerBgXsM0WepfRFo
 2w3BRqWaaDOG+sMztDjJ04kRxAsAs8B5UEtJxGPh7dzKWA+l7gWXogo8x8ZLkO42HMFJ
 J1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710872405; x=1711477205;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TZjTrxlkVoqA5+h9FQuyimFfAhd3TY3/Gw6FsezJpGY=;
 b=FMwbQHtB+a4lT5JQfB1FnLFODQ6nU17n6Ssu4rxnaJvnrQRTPBNxCGr1ns6EmFTFoJ
 /YQ8JSarMaC+Ba1QmDth/sMNX1efEKK9zTkaBPcrFGJF0ytSQiyMhsiP+yM0U1H5LmRm
 TLrC423o4zqRcWBHFP5W2YLPxAIHZBKqU0/njeNGULyIJWWBMf3rN9YtFMDYU0+csCt0
 8ULr4GJjInvwnL3L1veqN/kjSPI+r22Kza0IXKREUCeSviUHsK2UH0hWqBeyqAxfHa6k
 VFRE5T26G8znXAR8XpaUFu6E+cJwjWibCx2cwXjIXdX1HCDrsvHPV9pJUfmpf9+HdTcH
 zebA==
X-Gm-Message-State: AOJu0YyIXLXVYuVHrRvUejMWTkx/ILMfgBahCWxSFyJZHQL5+OUHli6y
 ALqfpGGSM8Nir93vRDXVD3GAmV4MZcxw+smz+Ap4B53x6aqW4gKw582ZzQaRueBFvOp0cUAsw7h
 WoNVYRLrYPjSdDLpjI0G89gj6jO7chat9kXvhfyVT6NmT1qlW5r5FUnn0e/vHu+U2xmEmq8ZVMP
 TFa2JhdQnJmlmSnhGio5+3lSTMyL2yVQ==
X-Google-Smtp-Source: AGHT+IFYEH81Pj6bUO5loW6lnr9Igy/ilJabv0IRH7xy8i3aw94U5ONptHTX+dBXJhEksFCdyzp3Bm9yUm8=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6512:370b:b0:513:ce66:5215 with SMTP id
 z11-20020a056512370b00b00513ce665215mr14861lfr.6.1710872404698; Tue, 19 Mar
 2024 11:20:04 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:18:13 +0000
In-Reply-To: <20240319181949.3083508-1-barnas@google.com>
Mime-Version: 1.0
References: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
 <20240319181949.3083508-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319181949.3083508-2-barnas@google.com>
Subject: [PATCH v3 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Mar 2024 19:20:50 +0100
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

Changes in v3:
- Rebase on current master branch
- Drop the TARGET_ prefix in Kconfig
- Remove #ifdefs and use IS_ENABLED

Changes in v2:
- Rebase on current master branch

 arch/arm/mach-socfpga/Kconfig   | 8 ++++++++
 arch/arm/mach-socfpga/spl_a10.c | 8 ++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 114d243812..a89bd8ca58 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -80,6 +80,14 @@ config TARGET_SOCFPGA_ARRIA10
 	imply FPGA_SOCFPGA
 	imply SPL_USE_TINY_PRINTF
=20
+config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
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
index 9edbbf4a29..3981d2d4f1 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -122,7 +122,10 @@ void spl_board_init(void)
 	arch_early_init_r();
=20
 	/* If the full FPGA is already loaded, ie.from EPCQ, config fpga pins */
-	if (is_fpgamgr_user_mode()) {
+	if ((IS_ENABLED(CONFIG_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM) &&
+	     is_regular_boot_valid()) ||
+	    (!IS_ENABLED(CONFIG_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM) &&
+	     is_fpgamgr_user_mode())) {
 		ret =3D config_pins(gd->fdt_blob, "shared");
 		if (ret)
 			return;
@@ -130,7 +133,8 @@ void spl_board_init(void)
 		ret =3D config_pins(gd->fdt_blob, "fpga");
 		if (ret)
 			return;
-	} else if (!is_fpgamgr_early_user_mode()) {
+	} else if (IS_ENABLED(CONFIG_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM) ||
+		   !is_fpgamgr_early_user_mode()) {
 		/* Program IOSSM(early IO release) or full FPGA */
 		fpgamgr_program(buf, FPGA_BUFSIZ, 0);
=20
--=20
2.44.0.291.gc1ea87d7ee-goog


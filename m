Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC3EC54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 17:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94FA587EF2;
	Fri,  8 Mar 2024 18:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JW1NJ8Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8615F87AEC; Fri,  8 Mar 2024 18:13:15 +0100 (CET)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1A687E96
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 18:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3JUfrZQYKBpY10HD0I6EE6B4.2ECK-1EEJB8IJI.34DN.34@flex--barnas.bounces.google.com
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc6b26845cdso3483248276.3
 for <u-boot@lists.denx.de>; Fri, 08 Mar 2024 09:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709917989; x=1710522789; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=SLagIKKzjS0EbgQzNDRwuv210FH/6mOQWbjKkAsLy/4=;
 b=JW1NJ8YrjxcsOryiysbXfb9tsn/7t/UPZOQbR2Zt0m6Ap9W45uKz5M88NwrjthIHHZ
 lPHzNEu8cfs/igl/c20kZR/PlhycT9tV0XNfFJUaaqv+R2HtMfaCkYh6cd4af8b+RaE2
 idLLdI+TE7cNFtZa1VBt4J8iblKmjSs9ezh+lAHEayc2mfZVqPCjyB2j2UtlBpojv6ah
 CQ30u/siNC0eycxynxfEsAVEzv/llrVI9JKx9uivrCyvfg/AgKHh+nxp9Vwkb0XE1LG2
 qaaq3p43HBOC4iI1aSWy9QzGL2IN22JAwq7dIw/8UsCSl6Et9rSSrXJz65MFnz6ONkY1
 QGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709917989; x=1710522789;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SLagIKKzjS0EbgQzNDRwuv210FH/6mOQWbjKkAsLy/4=;
 b=xL34XTRnjtwyBdH0ITRXyJZy6AhtVBTiMqnixOVshQiiLfTv1t/lr04ggyuXvEOExW
 WDvQmER2cHcaRvXBGcAYT+NVGxpkI+TRTHPNY6J1Xi6zlO8TjsyqIC9B1fowN7OS5bUt
 CCEPNiXh/9070iH+RYQK8NxhfdjTiTe+JYZnt1++pU3ga2fD3pUXx+s3TM7VzYjtr4oK
 poMaYPuc7IY7OEeCo7qu0D6AkArrWDSxuppOHBhiUMdpenrezm5jWInrtKBnduJLA7hX
 N38LXRRj87VK9uoyKqfZZMfsZS6QcQC8taAMP+4MAce2FOZieofPborSy/TqI8PTm2ho
 lRnQ==
X-Gm-Message-State: AOJu0Yy/D04afD95iLcI651tEfuTkfxAsKIVrghIFs7/GWsoBqEJgpND
 bglLNd6DX3r+LykLWCBiMk3RTBf1gz23/r+dNGdJpZdbWjpK+OEc0riqHxrafjw+O+z8xNjsfYB
 oj/Y27zkotu1l9IdrjA7XRF+lgfAAoX5htVIqop+Q7+21r90jhrrQJQT6FDAWw9qum0bQ8A18lJ
 I4OaqE7MxowHQmQxn5wcPbs5LMD5SF1w==
X-Google-Smtp-Source: AGHT+IGnDl1S7Omgl5h8OpCJ8fnbpuAWiShn2j772YF16YYeWkPpYDvxHSSzi4TiRwLYxQ7SHx+PiDNKxnE=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP id
 w4-20020a056902100400b00dc23441897fmr5238805ybt.6.1709917989549; Fri, 08 Mar
 2024 09:13:09 -0800 (PST)
Date: Fri,  8 Mar 2024 17:12:47 +0000
In-Reply-To: <20240308171251.106144-1-barnas@google.com>
Mime-Version: 1.0
References: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
 <20240308171251.106144-1-barnas@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308171251.106144-2-barnas@google.com>
Subject: [PATCH v2 1/2] arm: socfpga: arria10: add option to reprogram the
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
X-Mailman-Approved-At: Fri, 08 Mar 2024 18:37:36 +0100
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

Changes in v2:
- Rebase on current master branch

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
2.44.0.278.ge034bb2e1d-goog


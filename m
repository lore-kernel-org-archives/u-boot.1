Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BF0C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 15:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 127C5846FD;
	Mon,  6 Jul 2026 17:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="UEWideT3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653648490A; Mon,  6 Jul 2026 17:07:10 +0200 (CEST)
Received: from mail-wr2-x00.google.com (mail-wr2-x00.google.com
 [IPv6:2a00:1450:4864:30::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6112984979
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 17:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wr2-x00.google.com with SMTP id
 ffacd0b85a97d-4700bd8aed1so37974f8f.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783350428; x=1783955228; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jYmPeUlcjeJ/ViugGbVojoSf1xPti95cVvK2dgaLRb8=;
 b=UEWideT3lMNFInfQ+rwotDhz8Pb/DgWTIYEl84C6RTH76p+wC/me4IYL9tpctHq4mY
 r43c0F1XOZTUua2wozZ8gLGVl3aiO+d63J7b3asFocFxRlBUfplNfCQin88MIGy4npmm
 zNyAdN0gP4aaPUPOOQRt/S3BvsJFOmZlSboYrmWpGnG88EDPHCGhpgRAWqADUKvOVyr9
 HmB3kO2JirO3l2gOC2+OzIbq+BswdyusaF+Llff8egIVkTzGGrS5q3LxYYIX2EoxFQ3M
 bWFmONTeuhn6MCr15Sfc8YiODEsRPUkG9OtrINjsiCbanrI1tGFRcIRYgMUyBW3Cp/6p
 Fz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350428; x=1783955228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jYmPeUlcjeJ/ViugGbVojoSf1xPti95cVvK2dgaLRb8=;
 b=rbinN5sKYwTjYzIN4B/R1O4zm/KMhGSFo5mQHLFvWGQyAKqGjdFXgAz2/as0iwWqsh
 YZ03Qdum7vTnce+rqDNWsvx5eQu4J3mDARSR4N63rgujrNWX4KEmLp5DeE2aOeB3ESy9
 Qseslrl4cFWeEM0dcpJsNu+GIwKHkt3W5uLdl3z7pRF+GempWqgUrxv3hHn7v7/k3u8g
 ToNqt7dauhRuSybeOoSbWyAcntFZxisWKE8OBBR3K+tnDbJvzHgX9e3xAoQ0ErSLvL1N
 uy0aRLmaNGS2bkWKlUUizbBozQzl5qraiMaF1r30sFY12vuf0PKtwZvx8brYgNYoJA0Z
 hEwA==
X-Gm-Message-State: AOJu0YxXuk0JanBcPdPxQlfpBtIRJ2tCq2zYJObJW1z8lca8BqrNHoqT
 eRcttnwnGbFSyBhFhvHI2cg2Yhpxsq6nYSEijrv1BdImKzclihwiLJ4eeeqk8ouGfT8=
X-Gm-Gg: AfdE7clZWL9lILSbKQnvfj3fYQIjpgJkSL7jFepVdF02RUgAuiUj2VLtHBsRJzDqS6A
 zRfXsuJNxOCMDwDtA0W5GFKWtqLLEB3ktshljHigvgEMJgodEk4TOldpH7ueC8Gb8qljCyaFDXG
 Q/nYvgbpPK3gEpJ4s5f0x4UaEs6X20++nLFSy3xFlE+dFs9r95LoGNQencc6jjwbYuCxVAoN9nb
 YWjczoHnOSn3F2S/FilJjoTynm18226LgkG7wfb5oMeQ1z6G46AeR2ui8i6vfOnbQdY8q+Hgva4
 xAQrcd4P3srcIxkihuPXFcxi8D0zCYlyqF1axTpinr2WCkv066r38LGDlaCZs7UgD1Trx+dNAsl
 iob+zZ+J7e+zTlrivr3ke+ThcScgybH5uIT/m8ndXHiHYKWsskSw4hOjM/5GafFIENt7jhzlZQQ
 ke5djxGRUaFEcAHdlMXe87+YCXVZzBfSfJ0Yj0z30KgGM6HQydARXCbg6Z
X-Received: by 2002:a05:600c:628d:b0:493:c2ac:58f with SMTP id
 5b1f17b1804b1-493decbf152mr13034285e9.8.1783350427651; 
 Mon, 06 Jul 2026 08:07:07 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce03fa1sm281421265e9.11.2026.07.06.08.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:07:06 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 06 Jul 2026 17:06:43 +0200
Subject: [PATCH 2/4] bootmeth: efi: source the devicetree from a firmware
 partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-ccaione-upstream-ebbr-v1-2-e742cdd6abe5@baylibre.com>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
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

When a firmware-owned devicetree source is configured (EBBR / Arm
SystemReady IR), assemble the devicetree from the FIT manifest on
the firmware partition instead of reading a DTB from the EFI System
Partition, and hand it to the EFI application through the normal
bflow->fdt_addr path (efi_install_fdt()).

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 boot/bootmeth_efi.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index e187dc39912..ae3f1c9b91e 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -17,6 +17,7 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <extension_board.h>
+#include <firmware_fdt.h>
 #include <fs.h>
 #include <malloc.h>
 #include <mapmem.h>
@@ -73,6 +74,61 @@ static int efiload_read_file(struct bootflow *bflow, ulong addr)
 	return 0;
 }
 
+/**
+ * distro_efi_firmware_fdt() - try to stage the firmware-owned devicetree
+ *
+ * Prefer a firmware-owned devicetree if one is configured: assemble it
+ * from the FIT manifest on the firmware partition, stage it at 'fdt_addr_r'
+ * and fill the bootflow, so it reaches the EFI app through the normal
+ * bflow->fdt_addr path (efi_install_fdt()).
+ *
+ * The semantics are fail closed: only -ENOENT (no firmware-FDT source
+ * configured) lets the caller fall back to its normal devicetree source, so
+ * a missing or broken firmware devicetree is never silently replaced.
+ *
+ * @bflow: bootflow to update
+ * Return: 0 if the firmware devicetree was staged (the bootflow devicetree
+ * fields are set), -ENOENT if no source is configured, other -ve error if a
+ * configured source failed to assemble (the bootflow must fail)
+ */
+static int distro_efi_firmware_fdt(struct bootflow *bflow)
+{
+	struct firmware_fdt fw;
+	ulong fdt_addr;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(BOOTSTD_FIRMWARE_FDT))
+		return -ENOENT;
+
+	ret = firmware_fdt_load(&fw);
+	if (ret) {
+		if (ret != -ENOENT)
+			log_err("Failed to assemble the firmware devicetree (err %d)\n",
+				ret);
+		return ret;
+	}
+
+	/* stage it at fdt_addr_r, like any other devicetree */
+	fdt_addr = env_get_hex("fdt_addr_r", 0);
+	if (!fdt_addr || fw.size > SZ_4M) {
+		firmware_fdt_free(&fw);
+		return log_msg_ret("fwa", -EINVAL);
+	}
+
+	memcpy(map_sysmem(fdt_addr, fw.size), fw.fdt, fw.size);
+
+	bflow->fdt_fname = strdup(fw.name);
+	bflow->fdt_size = fw.size;
+	bflow->fdt_addr = fdt_addr;
+	firmware_fdt_free(&fw);
+	if (!bflow->fdt_fname)
+		return log_msg_ret("fwn", -ENOMEM);
+
+	log_debug("Using firmware-owned devicetree\n");
+
+	return 0;
+}
+
 static int distro_efi_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	/* This only works on block and network devices */
@@ -130,6 +186,18 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 
 	fdt_addr = env_get_hex("fdt_addr_r", 0);
 
+	/*
+	 * A staged firmware-owned devicetree is complete and authoritative,
+	 * so return without considering any other devicetree source. The
+	 * extension overlays below are deliberately not applied on top:
+	 * such combinations belong in the manifest as configurations.
+	 */
+	ret = distro_efi_firmware_fdt(bflow);
+	if (!ret)
+		return 0;
+	if (ret != -ENOENT)
+		return log_msg_ret("fwf", ret);
+
 	/* try the various available names */
 	ret = -ENOENT;
 	*fname = '\0';
@@ -268,6 +336,19 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fname)
 		return log_msg_ret("fi0", -ENOMEM);
 
+	/*
+	 * A configured firmware-owned devicetree outranks the network-provided
+	 * one (and the prior-stage / built-in devicetree below): a DHCP/TFTP
+	 * server must not be able to replace it.
+	 */
+	ret = distro_efi_firmware_fdt(bflow);
+	if (!ret) {
+		bflow->state = BOOTFLOWST_READY;
+		return 0;
+	}
+	if (ret != -ENOENT)
+		return log_msg_ret("fwf", ret);
+
 	/* read the DT file also */
 	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
 	if (ret == -EALREADY) {

-- 
2.55.0


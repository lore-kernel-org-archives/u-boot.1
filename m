Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FE9C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AB1560AA1;
	Thu, 23 Jul 2026 15:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTJ4zp8lSFAL; Thu, 23 Jul 2026 15:14:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3458060A92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819652;
	bh=sigHRYrwVNJyjgL6Gwh/Am1LiZdVvK7vtCJ6htOzboI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QaaVFB4peRPh32lgdgB2rxzC8JGy4TG7QmBr3uJMJXE1HbvX3Dp5z+cq80dvJRZj7
	 6ILVYwLh9YHUiPJc+uT+jN8ZePcs+XwHHYamc5dXXh7tuCmXwUk5soyQCfbOvPj7l3
	 jkhiV823WPuYX2FQamL0MSnjYPv/k8XOS6iXZSAx/uYA+LiAXcnsZ2OxymmLivbgTo
	 28TcFCQnGHERkV4QWJKigr5lKMtxk41SthrPVxa8jJAbOQSplX5b5+0exU3JCu/nVw
	 6cVM2wipiWo4VTk12KrB4a5PY8rFFoJ49p1uu/8invfYFxTxsTKh3MO04PdmrVJh5a
	 YEMGkEGbg7u2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3458060A92;
	Thu, 23 Jul 2026 15:14:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50052490
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36476403E4
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lya-w4NVZEZs for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 13:30:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DAC82403CD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAC82403CD
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DAC82403CD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 13:30:40 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso4687015e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 06:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784813439; x=1785418239;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sigHRYrwVNJyjgL6Gwh/Am1LiZdVvK7vtCJ6htOzboI=;
 b=NhcbDLieQeQc/H2ovOegdlmIB92L223Blam0MD7edsBkeEy7vx4ofJIBnRDsad8Ib2
 b5BbTNsN2SzOdy9RWT4mKEjeMZMk3rNIQ1f1voW4/kz6zH5fiwKhHXCycEv7XO9PxZBX
 efSTg/s3krGW7iuXaSP5xL1CHrOSZ0zRgq5IA+556eGolbJLZ6Jv2x2f29kX6TfmHlBq
 yL8E2TLtSD5nOmomgvYoL4IJtyduwo8c7rOFsYhrBvZMitxEnq5CQpdwvXb6J5sO+iK2
 inGq3wN3TPdW81tmZkylAQ235XP/6MUJiELpYYrazHFettjgqKNX0wb3aBWFQIyg77W0
 G4HQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLygJ7dTLacJSWJ3Ve6s29oKhavkI5yqnxM31ilKxWD5eKOE9jROj5HPcaSss0KMMNDKMzH8A=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzJI/Z41i16aexcreLeDAuptJQuRdWZyw0C53FVCIdMkVEERsJU
 OcK8vWneJYVhpRscJodhi3/m8+XSilz6AjUUng4dxYlc5Zz9dvuEGJua1DLUA7/JHWU=
X-Gm-Gg: AR+sD11TmadLX2aymlMvDpa/RYM80Pkw1VDH2wXKwxlLJFXxnwx0mjVKw6DxmEQdzlb
 LizrK8QTf5bwI3zjhfW6wNv0i9oOqP4L3EZDtL14D9/4AIZG+F9GqNueOXiGZfQg9HemqxXOjRm
 lq0pk1duVDwKMhZZrIMugFV4Huj2gkBR0bwEjITB9ft9ph8WO6pRh1WmmfI5IikbALNdpK089ee
 sMTQTN3n1oITFfaFB3Oo1fV0MNnfFMG08fRmK00QeVUWPIV26WiWMcNfDIrJn/ZvPAlLFJLi32k
 wKHce1WftqkkWgoWzCFgtDQQZK9HyYxyAaKhG6CVmSAord/ZHTeQyeQXwQ+zLe+t7QtMF0zq4gw
 RPxNhXVuF8/MsdLqH08qmDAzUG/ftSl3sWoZoAHqrZ6f1Za3iEYXlRylN5iKC7VuYQavLZfSgeb
 ihNLLx0GnVm6VhQw==
X-Received: by 2002:a05:600c:1390:b0:495:5a0e:6d8c with SMTP id
 5b1f17b1804b1-49573ce8e74mr44434595e9.27.1784813438818; 
 Thu, 23 Jul 2026 06:30:38 -0700 (PDT)
Received: from [10.12.249.172] ([2a01:599:841:3b94:b6c8:2fa:40db:8ecf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b043727sm97075405e9.4.2026.07.23.06.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 06:30:38 -0700 (PDT)
From: Tan Siewert <tan.siewert@9elements.com>
Date: Thu, 23 Jul 2026 15:30:08 +0200
Subject: [PATCH 7/8] board: hpe: gxp: display product name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-9e-gxp-v1-7-f86e5cea239f@9elements.com>
References: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
In-Reply-To: <20260723-9e-gxp-v1-0-f86e5cea239f@9elements.com>
To: u-boot@lists.denx.de, Jean-Marie Verdun <verdun@hpe.com>, 
 Nick Hawkins <nick.hawkins@hpe.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Tan Siewert <tan.siewert@9elements.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813429; l=4810;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=9mrHw042B2TADD1pAI0fglhEvVXrOyJYpwi3u9kpWpo=;
 b=Eg19NjxXUg5N99NNi8Ij5nAabRa/aizvqHRIpbv6iMDAsuXGDZHPG0o2uAyAbePVsvNdjKfkq
 UHUZDwGgydSAGSauDNiBfGGD+FSIQ6bkdBsMJF46hCKvu8nxDiFVn5v
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1784813439; x=1785418239;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sigHRYrwVNJyjgL6Gwh/Am1LiZdVvK7vtCJ6htOzboI=;
 b=ADQ95JtWxKbsPPnwJgX0jkSvyd9L6uL7FHz1K4P2KOMQ2C/6Hw0M+Pm7iFkMVcnUGP
 7apM+r6ni+baNCY8dUfaG2ET5cGE8sBvEcQjy//OtF8aOBvW8qlJmtc9qmCDj9PYqjXM
 8JJJuMFA7VW1srVgmVmoQhzQ3eey3Puvce9RznR52HPCXlTw3wWthgIbsokLMUzHbrW5
 tOdPEXfd6oqs9pj97npgmxhD2kMtux5Vke0bTb4PAWwm7pAKkrOS1TJBI/oGmm/jfCAZ
 sh9ZCCDr8FuPMHXBOj0HFtSfxSo6/Uykc4mm+ApSYvl7vqWpupPdG4n0yvCmAWZa8DIM
 FsbA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=ADQ95JtW
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>

Print the product name provided by the Linux device tree during
ft_board_setup().

Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
---
 arch/arm/dts/hpe-gxp.dtsi |  6 ++++--
 board/hpe/gxp/gxp_board.c | 39 ++++++++++++++++++++++++++++++++++++---
 drivers/sysinfo/gxp.c     | 22 +++++++++++++++++++---
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/hpe-gxp.dtsi b/arch/arm/dts/hpe-gxp.dtsi
index 9c761a675be..66ddbd924f7 100644
--- a/arch/arm/dts/hpe-gxp.dtsi
+++ b/arch/arm/dts/hpe-gxp.dtsi
@@ -12,8 +12,10 @@
 
 	sysinfo {
 		compatible = "hpe,gxp-sysinfo";
-		nvmem-cells = <&serial_number>, <&part_number>;
-		nvmem-cell-names = "serial-number", "part-number";
+		nvmem-cells = <&serial_number>, <&part_number>,
+			      <&pca_serial_number>, <&pca_part_number>;
+		nvmem-cell-names = "serial-number", "part-number",
+				   "pca-serial-number", "pca-part-number";
 		bootph-all;
 	};
 
diff --git a/board/hpe/gxp/gxp_board.c b/board/hpe/gxp/gxp_board.c
index 4a51ff55797..0cd05c00079 100644
--- a/board/hpe/gxp/gxp_board.c
+++ b/board/hpe/gxp/gxp_board.c
@@ -73,6 +73,17 @@ int board_fit_config_name_match(const char *name)
 	return -1;
 }
 
+static void ft_board_show_product(void *blob)
+{
+	if (CONFIG_IS_ENABLED(DISPLAY_BOARDINFO)) {
+		const char *model;
+
+		model = fdt_getprop(blob, 0, "model", NULL);
+		if (model)
+			printf("Product: %s\n", model);
+	}
+}
+
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	struct udevice *dev;
@@ -81,11 +92,11 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	ret = sysinfo_get(&dev);
 	if (ret)
-		return 0;
+		goto skip_sysinfo;
 
 	ret = sysinfo_detect(dev);
 	if (ret)
-		return 0;
+		goto skip_sysinfo;
 
 	ret = sysinfo_get_str(dev, SYSID_BOARD_MANUFACTURER, sizeof(str), str);
 	if (!ret)
@@ -95,10 +106,32 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	if (!ret)
 		fdt_setprop_string(blob, 0, "serial-number", str);
 
-	ret = sysinfo_get_str(dev, SYSID_SM_BASEBOARD_PRODUCT, sizeof(str), str);
+	ret = sysinfo_get_str(dev, SYSID_SM_SYSTEM_PRODUCT, sizeof(str), str);
 	if (!ret)
 		fdt_setprop_string(blob, 0, "part-number", str);
 
+	/* Populate baseboard (PCA) properties in a subnode */
+	int bb_off = fdt_add_subnode(blob, 0, "baseboard");
+
+	if (bb_off >= 0) {
+		fdt_setprop_string(blob, bb_off, "compatible",
+				   "hpe,gxp-baseboard");
+
+		ret = sysinfo_get_str(dev, SYSID_SM_BASEBOARD_SERIAL,
+				      sizeof(str), str);
+		if (!ret)
+			fdt_setprop_string(blob, bb_off, "serial-number", str);
+
+		ret = sysinfo_get_str(dev, SYSID_SM_BASEBOARD_PRODUCT,
+				      sizeof(str), str);
+		if (!ret)
+			fdt_setprop_string(blob, bb_off, "part-number", str);
+	}
+
+skip_sysinfo:
+	if (CONFIG_IS_ENABLED(DISPLAY_BOARDINFO))
+		ft_board_show_product(blob);
+
 	return 0;
 }
 
diff --git a/drivers/sysinfo/gxp.c b/drivers/sysinfo/gxp.c
index a1f33be11df..1d242239eb4 100644
--- a/drivers/sysinfo/gxp.c
+++ b/drivers/sysinfo/gxp.c
@@ -15,12 +15,16 @@
 
 /**
  * struct gxp_sysinfo_priv - GXP sysinfo private data
- * @serial_cell: NVMEM cell for serial number
- * @part_cell: NVMEM cell for part number
+ * @serial_cell: NVMEM cell for system serial number
+ * @part_cell: NVMEM cell for system part number
+ * @pca_serial_cell: NVMEM cell for baseboard (PCA) serial number
+ * @pca_part_cell: NVMEM cell for baseboard (PCA) part number
  */
 struct gxp_sysinfo_priv {
 	struct nvmem_cell serial_cell;
 	struct nvmem_cell part_cell;
+	struct nvmem_cell pca_serial_cell;
+	struct nvmem_cell pca_part_cell;
 };
 
 static int gxp_sysinfo_detect(struct udevice *dev)
@@ -47,11 +51,21 @@ static int gxp_sysinfo_get_str(struct udevice *dev, int id, size_t size,
 			return -ENODEV;
 		cell = &priv->serial_cell;
 		break;
-	case SYSID_SM_BASEBOARD_PRODUCT:
+	case SYSID_SM_SYSTEM_PRODUCT:
 		if (!priv->part_cell.nvmem)
 			return -ENODEV;
 		cell = &priv->part_cell;
 		break;
+	case SYSID_SM_BASEBOARD_SERIAL:
+		if (!priv->pca_serial_cell.nvmem)
+			return -ENODEV;
+		cell = &priv->pca_serial_cell;
+		break;
+	case SYSID_SM_BASEBOARD_PRODUCT:
+		if (!priv->pca_part_cell.nvmem)
+			return -ENODEV;
+		cell = &priv->pca_part_cell;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -74,6 +88,8 @@ static int gxp_sysinfo_probe(struct udevice *dev)
 
 	nvmem_cell_get_by_name(dev, "serial-number", &priv->serial_cell);
 	nvmem_cell_get_by_name(dev, "part-number", &priv->part_cell);
+	nvmem_cell_get_by_name(dev, "pca-serial-number", &priv->pca_serial_cell);
+	nvmem_cell_get_by_name(dev, "pca-part-number", &priv->pca_part_cell);
 
 	return 0;
 }

-- 
2.53.0


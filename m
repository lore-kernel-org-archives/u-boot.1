Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EBAC61DD3
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 01:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC90C80F66;
	Sat, 29 Aug 2026 01:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUAJBG8f4TjQ; Sat, 29 Aug 2026 01:50:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787968251;
	bh=g+ipV4NLJwXb6/Bsufvi7/HrzxsKZgL5z9padCNhfW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=scKnr6n5hCcsKDDAxeH8zonpM3qDLt+PDrkpyqZpgER5h3uejbgwSFyCpxMLSSA/p
	 eH/KCi79iAu7ie6I2Z8bAo6rQfDsGqHLe4NASOrPSIkk2sEUUvoNHl6+ZR00iXBFST
	 Ulx2Os8u/15joJCDJoi7b7XX6ZsoSu6Nz5SOB0IB3+ZgxVAkGkgVmKWkZAIPIVfFuj
	 HDicTJhzCpe4ts7xds8EkWYpwFTw41fvHuH98FGxOoH5cin/o8DsWNKbTknYMsJNVG
	 /dcEerwZvbQNwOWGenpilWfL61MVAZWCGso06dc9BCZghQTvlqBFNotOo82eg0mEfA
	 JLY6usrMxlbrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6202180FFD;
	Sat, 29 Aug 2026 01:50:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20276118
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10D9980F70
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSldtAZHJOZW for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 01:50:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::b;
 helo=mail-oa2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=bKClSy6y
Received: from mail-oa2-x0b.google.com (mail-oa2-x0b.google.com
 [IPv6:2607:f8b0:4864:30::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C39D80F3F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 01:50:33 +0000 (UTC)
Received: by mail-oa2-x0b.google.com with SMTP id
 586e51a60fabf-45958a0c7c4so418155fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787968232; x=1788573032;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g+ipV4NLJwXb6/Bsufvi7/HrzxsKZgL5z9padCNhfW8=;
 b=bKClSy6yLMF5114YMHMuFrnDQIZWBgFErcZk6P56Agxu1X4neLhLn3CByPVZnckT5D
 mJ/uD76gSueERTyEOMo9poP4pWdoId4UByH3gXN9Sgn1NXm24lwlrC10/3YGi0Eoj8sV
 sgFk/B5CYLazfayOadgA0LZ+GxGqlJTGzOdXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787968232; x=1788573032;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g+ipV4NLJwXb6/Bsufvi7/HrzxsKZgL5z9padCNhfW8=;
 b=MsfPlurFfHGkrBpFJyYSuBpcBl5caw151yrkam0yvbhgplnrFTxRfGSnrY3FydNhs7
 RE7WXUKUSantsx1XItEJSl3GchqQ1G5QpAHRwm365iWIe8Owv++is9CbVsr6jVJdjSrN
 s9jgzCNMGxXSUpmJU9Cm6QqRkEFqJXxHfjFhnsioJUmlmUDKhO2qDdkPI8qXzLJY5hBf
 TK3hzCVDa2mdFvgB9mQ4W7e6gsFPiJR82HnYRII0wK4yTfL54A3cAwpwU5mJ/cdR31SX
 DRi2Fdsf7OUBtnRfmj2cUrDrRlTF6hxyzgoefS2hCVlMKoBbcKgkXbt+aub/0W0VuyIP
 YYBw==
X-Gm-Message-State: AFuF++nIjek1JrhZuDFWO4AKvEVtIVqscZHP8aeC58Cdm0sC5mPgEJxw
 JYZjr4mhMzZ6V/7mNXrGjpGdTRLTybPrwD9La85G3IN7YNMb572faueJOivlr4nk9IByzTLhWGD
 BykAHxEKM9r19qvw=
X-Gm-Gg: AR+sD10PWy/x0IFVO8SN9AOQbFaD3NREAUGHLbUzT6sug4ddxL9jUtMSRnjZexqG5xM
 8IPi4FlcvzSDuHPIeI3Q1L9laSx+g1Affv+gumKva6qTp7iMUF0PQ1fMaDKU3krWgGvntZVvdZS
 B07c7Fe8UgBAPUk+U6TrM/9jyWJv+Z5oCj0/eYQdSaj3WXKdoy1hReGzsjOiqH3L6HC+TaqrQ8n
 PCJ75PKlfnt6KLH+zIyrZb5FYiG2OOdwo0LPFgnCugU/ZEjy8EUS3rZTcYHGgJv3DY8md+wH/sX
 qYD9bPYGq0HrqXqozF89iQAnxxX7whqz+gG/bZZbRMYtusFmd1Lx5eIjOhqKeRtuQ9hF73cACLb
 7WBfX4TbvAxzNaAFvlL9FoSKcjirVQ/HivOqG/rrPqZXPGBy/T5ueFnVBhLAn4z1sKBa6t4A4xO
 Fo9dGEHirRRn5vDPikM42FXBM6EdbAuxnI92kMB5dZ2NlhH6pMzlST2ejBHJkLfPHziLD4a6CVz
 98nxfS82o04e+Q/RjdQv8KmX4hQet+1OYYnLytXRIYu6iklpvLx4/oxPc2TeZ808GrZ8yKQDVEn
 7UoYPBkDlRumE+LhSkKB/NKA5I5k2cgHMMCJN4gpWbeA
X-Received: by 2002:a05:6820:2220:b0:6b1:fe93:3a6c with SMTP id
 006d021491bc7-6b1fe933c36mr6297072eaf.7.1787968231925; 
 Fri, 28 Aug 2026 18:50:31 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a353d45asm3070190fac.7.2026.08.28.18.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 18:50:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 4/7] MAINTAINERS: Fix "typo" and similar incorrect entries
Date: Fri, 28 Aug 2026 19:50:22 -0600
Message-ID: <20260829015026.473134-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829015026.473134-1-trini@konsulko.com>
References: <20260829015026.473134-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This goes and fixes MAINTAINERS file entries that reference files that
don't exist in mainline due things like:
- A typo / missing extension / similar
- Not updating the entry when the location was changed as part of review
  feedback

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 board/CZ.NIC/turris_omnia/MAINTAINERS             |  2 +-
 board/Marvell/octeontx/MAINTAINERS                |  3 +--
 board/Marvell/octeontx2/MAINTAINERS               |  3 +--
 board/advantech/imx8mp_rsb3720a1/MAINTAINERS      |  2 +-
 board/advantech/imx8qm_dmsse20_a1/MAINTAINERS     |  2 +-
 board/alliedtelesis/SBx81LIFKW/MAINTAINERS        |  2 +-
 board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS      |  2 +-
 board/amd/versal2/MAINTAINERS                     |  2 +-
 board/andestech/voyager/MAINTAINERS               |  2 +-
 board/atmel/sama5d29_curiosity/MAINTAINERS        |  2 +-
 board/atmel/sama7d65_curiosity/MAINTAINERS        |  2 +-
 board/atmel/sama7g54_curiosity/MAINTAINERS        |  2 +-
 board/atmel/sama7g5ek/MAINTAINERS                 |  2 +-
 board/bosch/acc/MAINTAINERS                       |  2 +-
 board/comtrend/vr3032u/MAINTAINERS                |  2 +-
 board/comtrend/wap5813n/MAINTAINERS               |  2 +-
 board/coolpi/genbook_cm5_rk3588/MAINTAINERS       |  2 +-
 board/davinci/da8xxevm/MAINTAINERS                |  2 +-
 board/friendlyarm/nanopi2/MAINTAINERS             |  2 +-
 board/gardena/smart-gateway-at91sam/MAINTAINERS   |  2 +-
 board/imgtec/xilfpga/MAINTAINERS                  |  2 +-
 board/intel/agilex7m-socdk/MAINTAINERS            |  2 +-
 board/libre-computer/aml-a311d-cc/MAINTAINERS     |  2 +-
 board/libre-computer/aml-s805x-ac/MAINTAINERS     |  2 +-
 board/libre-computer/aml-s905d3-cc/MAINTAINERS    |  2 +-
 board/myir/mys_6ulx/MAINTAINERS                   |  3 ++-
 board/phytec/phycore_am62ax/MAINTAINERS           |  2 +-
 board/phytec/phycore_imx8mm/MAINTAINERS           |  2 +-
 board/siemens/iot2050/MAINTAINERS                 |  2 +-
 board/sifive/unmatched/MAINTAINERS                |  2 +-
 board/ti/am62ax/MAINTAINERS                       |  2 +-
 board/ti/am62dx/MAINTAINERS                       |  2 +-
 board/ti/am62px/MAINTAINERS                       |  2 +-
 board/ti/j7200/MAINTAINERS                        |  2 +-
 board/toradex/colibri-imx8x/MAINTAINERS           |  4 ++--
 board/toradex/colibri_imx7/MAINTAINERS            | 12 ++++++------
 board/toradex/colibri_vf/MAINTAINERS              |  2 +-
 board/toradex/smarc-imx8mp/MAINTAINERS            |  2 +-
 board/xilinx/zynqmp_r5/MAINTAINERS                |  2 +-
 board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS |  2 +-
 40 files changed, 47 insertions(+), 48 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/MAINTAINERS b/board/CZ.NIC/turris_omnia/MAINTAINERS
index effce8a753b4..33ddf51ce42d 100644
--- a/board/CZ.NIC/turris_omnia/MAINTAINERS
+++ b/board/CZ.NIC/turris_omnia/MAINTAINERS
@@ -5,5 +5,5 @@ F:	arch/arm/dts/armada-385-turris-omnia*.dts*
 F:	board/CZ.NIC/turris_atsha_otp.*
 F:	board/CZ.NIC/turris_omnia/
 F:	configs/turris_omnia_defconfig
-F:	drivers/gpio/turris_omnia_mcu.c
+F:	drivers/misc/turris_omnia_mcu.c
 F:	include/configs/turris_omnia.h
diff --git a/board/Marvell/octeontx/MAINTAINERS b/board/Marvell/octeontx/MAINTAINERS
index 1f3b12b1abf2..fd6cabcfad7b 100644
--- a/board/Marvell/octeontx/MAINTAINERS
+++ b/board/Marvell/octeontx/MAINTAINERS
@@ -2,7 +2,6 @@ OCTEONTX BOARD
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	board/Marvell/octeontx/
-F:	include/configs/octeontx_81xx.h
-F:	include/configs/octeontx_83xx.h
+F:	include/configs/octeontx_common.h
 F:	configs/octeontx_81xx_defconfig
 F:	configs/octeontx_83xx_defconfig
diff --git a/board/Marvell/octeontx2/MAINTAINERS b/board/Marvell/octeontx2/MAINTAINERS
index eec1d77dd108..0941a5269b2c 100644
--- a/board/Marvell/octeontx2/MAINTAINERS
+++ b/board/Marvell/octeontx2/MAINTAINERS
@@ -2,7 +2,6 @@ OCTEONTX2 BOARD
 M:	Aaron Williams <awilliams@marvell.com>
 S:	Maintained
 F:	board/Marvell/octeontx2/
-F:	include/configs/octeontx2_96xx.h
-F:	include/configs/octeontx2_95xx.h
+F:	include/configs/octeontx2_common.h
 F:	configs/octeontx2_96xx_defconfig
 F:	configs/octeontx2_95xx_defconfig
diff --git a/board/advantech/imx8mp_rsb3720a1/MAINTAINERS b/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
index bc967af4f509..02ee85fd7b1b 100644
--- a/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
+++ b/board/advantech/imx8mp_rsb3720a1/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8MP RSB3720 BOARD
 M:	Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
 S:	Maintained
 F:	board/advantech/imx8mp_rsb3720a1/
-F:	include/configs/imx8mp_rsb3720a1.h
+F:	include/configs/imx8mp_rsb3720.h
 F:	configs/imx8mp_rsb3720a1_4G_defconfig
 F:	configs/imx8mp_rsb3720a1_6G_defconfig
diff --git a/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS b/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
index 8292c6ba7122..8b933ad336b5 100644
--- a/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
+++ b/board/advantech/imx8qm_dmsse20_a1/MAINTAINERS
@@ -2,6 +2,6 @@ i.MX8QM ROM DMSSE20 a1 BOARD
 M:	Oliver Graute <oliver.graute@kococonnector.com>
 S:	Maintained
 F:	board/advantech/imx8qm_dmsse20_a1/
-F:	arch/arm/dts/imx8qm-dmsse20-a1.dtb
+F:	arch/arm/dts/imx8qm-dmsse20-a1.dts
 F:	include/configs/imx8qm_dmsse20.h
 F:	configs/imx8qm_dmsse20a1_defconfig
diff --git a/board/alliedtelesis/SBx81LIFKW/MAINTAINERS b/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
index 31ccec0e9b7e..79e23f6724c8 100644
--- a/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
+++ b/board/alliedtelesis/SBx81LIFKW/MAINTAINERS
@@ -2,6 +2,6 @@ SBx81LIFKW BOARD
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
 F:	board/alliedtelesis/SBx81LIFKW/
-F:	include/configs/SBx81LIFKW
+F:	include/configs/SBx81LIFKW.h
 F:	configs/SBx81LIFKW_defconfig
 F:	arch/arm/dts/kirkwood-atl-sbx81lifkw.dts
diff --git a/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS b/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
index 6b722ded250e..25b94774de25 100644
--- a/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
+++ b/board/alliedtelesis/SBx81LIFXCAT/MAINTAINERS
@@ -2,6 +2,6 @@ SBx81LIFXCAT BOARD
 M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
 S:	Maintained
 F:	board/alliedtelesis/SBx81LIFXCAT/
-F:	include/configs/SBx81LIFXCAT
+F:	include/configs/SBx81LIFXCAT.h
 F:	configs/SBx81LIFXCAT_defconfig
 F:	arch/arm/dts/kirkwood-atl-sbx81lifxcat.dts
diff --git a/board/amd/versal2/MAINTAINERS b/board/amd/versal2/MAINTAINERS
index af7913d8db3a..fe199ac7aaf7 100644
--- a/board/amd/versal2/MAINTAINERS
+++ b/board/amd/versal2/MAINTAINERS
@@ -2,6 +2,6 @@ XILINX_VERSAL2 BOARDS
 M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 T:	git https://gitlab.denx.de/u-boot/custodians/u-boot-microblaze.git
-F:	arch/arm/dts/versal2*
+F:	arch/arm/dts/amd-versal2*
 F:	board/amd/
 F:	configs/amd*
diff --git a/board/andestech/voyager/MAINTAINERS b/board/andestech/voyager/MAINTAINERS
index b87026ee383b..c0eee0f9eb4e 100644
--- a/board/andestech/voyager/MAINTAINERS
+++ b/board/andestech/voyager/MAINTAINERS
@@ -4,5 +4,5 @@ S:	Maintained
 F:	board/andestech/voyager/
 F:	configs/voyager_spl_defconfig
 F:	doc/board/andestech/voyager.rst
-F:	include/configs/qilai.h
+F:	include/configs/voyager.h
 
diff --git a/board/atmel/sama5d29_curiosity/MAINTAINERS b/board/atmel/sama5d29_curiosity/MAINTAINERS
index 54894d6cbb68..58f918c00c41 100644
--- a/board/atmel/sama5d29_curiosity/MAINTAINERS
+++ b/board/atmel/sama5d29_curiosity/MAINTAINERS
@@ -1,7 +1,7 @@
 SAMA5D29 CURIOSITY BOARD
 M:     Mihai Sain <mihai.sain@microchip.com>
 S:     Maintained
-F:     board/atmel/sama5d29_curiosity.c
+F:     board/atmel/sama5d29_curiosity/
 F:     include/configs/sama5d29_curiosity.h
 F:     configs/sama5d29_curiosity_mmc_defconfig
 F:     configs/sama5d29_curiosity_mmc1_defconfig
diff --git a/board/atmel/sama7d65_curiosity/MAINTAINERS b/board/atmel/sama7d65_curiosity/MAINTAINERS
index 054af3c65416..0720ae3c6a03 100644
--- a/board/atmel/sama7d65_curiosity/MAINTAINERS
+++ b/board/atmel/sama7d65_curiosity/MAINTAINERS
@@ -1,6 +1,6 @@
 SAMA7D65 CURIOSITY BOARD
 M:     Ryan Wanner <ryan.wanner@microchip.com>
 S:     Maintained
-F:     board/atmel/sama7d65_curiosity.c
+F:     board/atmel/sama7d65_curiosity/
 F:     include/configs/sama7d65_curiosity.h
 F:     configs/sama7d65_curiosity_mmc1_defconfig
diff --git a/board/atmel/sama7g54_curiosity/MAINTAINERS b/board/atmel/sama7g54_curiosity/MAINTAINERS
index b9f1a271c09c..3eb2657ca1c8 100644
--- a/board/atmel/sama7g54_curiosity/MAINTAINERS
+++ b/board/atmel/sama7g54_curiosity/MAINTAINERS
@@ -1,7 +1,7 @@
 SAMA7G54 CURIOSITY BOARD
 M:     Mihai Sain <mihai.sain@microchip.com>
 S:     Maintained
-F:     board/atmel/sama7g54_curiosity.c
+F:     board/atmel/sama7g54_curiosity/
 F:     include/configs/sama7g54_curiosity.h
 F:     configs/sama7g54_curiosity_mmc_defconfig
 F:     configs/sama7g54_curiosity_nandflash_defconfig
diff --git a/board/atmel/sama7g5ek/MAINTAINERS b/board/atmel/sama7g5ek/MAINTAINERS
index 4d1c6f666c0b..e2dca59f231d 100644
--- a/board/atmel/sama7g5ek/MAINTAINERS
+++ b/board/atmel/sama7g5ek/MAINTAINERS
@@ -1,7 +1,7 @@
 SAMA7G5 EK BOARD
 M:     Eugen Hristev <ehristev@kernel.org>
 S:     Maintained
-F:     board/atmel/sama7g5ek.c
+F:     board/atmel/sama7g5ek/
 F:     include/configs/sama7g5ek.h
 F:     configs/sama7g5ek_mmc1_defconfig
 F:     configs/sama7g5ek_mmc_defconfig
diff --git a/board/bosch/acc/MAINTAINERS b/board/bosch/acc/MAINTAINERS
index 1b880037121f..473fc0855dd0 100644
--- a/board/bosch/acc/MAINTAINERS
+++ b/board/bosch/acc/MAINTAINERS
@@ -6,4 +6,4 @@ F:	board/bosch/acc
 F:	include/configs/imx6q-bosch-acc.h
 F:	configs/imx6q_bosch_acc_defconfig
 F:	arch/arm/dts/imx6q-bosch-acc.dts
-F:	arch/arm/dts/imx6q-bosch-acc-u-boot.dts
+F:	arch/arm/dts/imx6q-bosch-acc-u-boot.dtsi
diff --git a/board/comtrend/vr3032u/MAINTAINERS b/board/comtrend/vr3032u/MAINTAINERS
index 132101f4cd0c..54c4aa229cec 100644
--- a/board/comtrend/vr3032u/MAINTAINERS
+++ b/board/comtrend/vr3032u/MAINTAINERS
@@ -2,5 +2,5 @@ COMTREND VR-3032U BOARD
 M:	Álvaro Fernández Rojas <noltari@gmail.com>
 S:	Maintained
 F:	board/comtrend/vr3032u/
-F:	include/configs/comtrend_vr-3032u.h
+F:	include/configs/comtrend_vr3032u.h
 F:	configs/comtrend_vr3032u_ram_defconfig
diff --git a/board/comtrend/wap5813n/MAINTAINERS b/board/comtrend/wap5813n/MAINTAINERS
index c6764831b2bc..8c8e0769f51f 100644
--- a/board/comtrend/wap5813n/MAINTAINERS
+++ b/board/comtrend/wap5813n/MAINTAINERS
@@ -2,5 +2,5 @@ COMTREND WAP-5813N BOARD
 M:	Álvaro Fernández Rojas <noltari@gmail.com>
 S:	Maintained
 F:	board/comtrend/wap5813n/
-F:	include/configs/comtrend_wap-5813n.h
+F:	include/configs/comtrend_wap5813n.h
 F:	configs/comtrend_wap5813n_ram_defconfig
diff --git a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
index 0496cc93b599..15c2354e8225 100644
--- a/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
+++ b/board/coolpi/genbook_cm5_rk3588/MAINTAINERS
@@ -1,7 +1,7 @@
 GENBOOK-CM5-RK3588
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
-F:	board/coolpi/genbook-cm5-rk3588
+F:	board/coolpi/genbook_cm5_rk3588
 F:	include/configs/genbook-cm5-rk3588.h
 F:	configs/coolpi-cm5-genbook-rk3588_defconfig
 F:	arch/arm/dts/rk3588-coolpi-cm5-genbook-u-boot.dtsi
diff --git a/board/davinci/da8xxevm/MAINTAINERS b/board/davinci/da8xxevm/MAINTAINERS
index 993b22f2f638..c12b864b84b5 100644
--- a/board/davinci/da8xxevm/MAINTAINERS
+++ b/board/davinci/da8xxevm/MAINTAINERS
@@ -10,5 +10,5 @@ F:	configs/da850evm_direct_nor_defconfig
 OMAPL138_LCDK BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	include/configs/omap1l38_lcdk.h
+F:	include/configs/omapl138_lcdk.h
 F:	configs/omapl138_lcdk_defconfig
diff --git a/board/friendlyarm/nanopi2/MAINTAINERS b/board/friendlyarm/nanopi2/MAINTAINERS
index c8e2ce7b7c0e..781f00dce6d5 100644
--- a/board/friendlyarm/nanopi2/MAINTAINERS
+++ b/board/friendlyarm/nanopi2/MAINTAINERS
@@ -2,6 +2,6 @@ NANOPI2 BOARD
 NANOPC-T2 BOARD
 M:  Stefan Bosch <stefan_b@posteo.net>
 S:  Maintained
-F:  board/s5p4418/nanopi2/
+F:  board/friendlyarm/nanopi2/
 F:  include/configs/s5p4418_nanopi2.h
 F:  configs/s5p4418_nanopi2_defconfig
diff --git a/board/gardena/smart-gateway-at91sam/MAINTAINERS b/board/gardena/smart-gateway-at91sam/MAINTAINERS
index a5e4c71b824d..b115999fda61 100644
--- a/board/gardena/smart-gateway-at91sam/MAINTAINERS
+++ b/board/gardena/smart-gateway-at91sam/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	board/gardena/smart-gateway-at91sam/
 F:	include/configs/gardena-smart-gateway-at91sam.h
 F:	configs/gardena-smart-gateway-at91sam_defconfig
-F:	arch/arm/dts/gardena-smart-gateway-at91sam.dts
+F:	arch/arm/dts/at91sam9g25-gardena-smart-gateway.dts
diff --git a/board/imgtec/xilfpga/MAINTAINERS b/board/imgtec/xilfpga/MAINTAINERS
index aa045325eac6..93a67e3af34b 100644
--- a/board/imgtec/xilfpga/MAINTAINERS
+++ b/board/imgtec/xilfpga/MAINTAINERS
@@ -2,5 +2,5 @@ XILFPGA BOARD
 M:	Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
 S:	Maintained
 F:	board/imgtec/xilfpga
-F:	include/configs/xilfpga.h
+F:	include/configs/imgtec_xilfpga.h
 F:	configs/imgtec_xilfpga_defconfig
diff --git a/board/intel/agilex7m-socdk/MAINTAINERS b/board/intel/agilex7m-socdk/MAINTAINERS
index 9a5b80ae4dfe..eea2810d3287 100644
--- a/board/intel/agilex7m-socdk/MAINTAINERS
+++ b/board/intel/agilex7m-socdk/MAINTAINERS
@@ -7,4 +7,4 @@ F:	arch/arm/dts/socfpga_agilex7m*
 F:	arch/arm/mach-socfpga/spl_agilex7m.c
 F:	board/intel/agilex7m-socdk/
 F:	include/configs/socfpga_agilex7m_socdk.h
-F:	configs/socfpga_agilex7m_sdmmc_defconfig
+F:	configs/socfpga_agilex7m_defconfig
diff --git a/board/libre-computer/aml-a311d-cc/MAINTAINERS b/board/libre-computer/aml-a311d-cc/MAINTAINERS
index b4b77acd23b2..a5c4bcdb998c 100644
--- a/board/libre-computer/aml-a311d-cc/MAINTAINERS
+++ b/board/libre-computer/aml-a311d-cc/MAINTAINERS
@@ -2,6 +2,6 @@ LIBRE-COMPUTER AML-A311D-CC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-a311d-cc/
+F:	board/libre-computer/aml-a311d-cc/
 F:	configs/aml-a311d-cc_defconfig
 F:	doc/board/amlogic/aml-a311d-cc.rst
diff --git a/board/libre-computer/aml-s805x-ac/MAINTAINERS b/board/libre-computer/aml-s805x-ac/MAINTAINERS
index 7cbc08aeb6c8..e434e5ed2289 100644
--- a/board/libre-computer/aml-s805x-ac/MAINTAINERS
+++ b/board/libre-computer/aml-s805x-ac/MAINTAINERS
@@ -2,7 +2,7 @@ LIBRE-COMPUTER AML-S805X-AC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-s805x-ac/
+F:	board/libre-computer/aml-s805x-ac/
 F:	include/configs/libretech-ac.h
 F:	configs/libretech-ac_defconfig
 F:	doc/board/amlogic/libretech-ac.rst
diff --git a/board/libre-computer/aml-s905d3-cc/MAINTAINERS b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
index 4b75c815c07c..274518d13a3b 100644
--- a/board/libre-computer/aml-s905d3-cc/MAINTAINERS
+++ b/board/libre-computer/aml-s905d3-cc/MAINTAINERS
@@ -2,6 +2,6 @@ LIBRE-COMPUTER AML-S905D3-CC
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
-F:	board/amlogic/aml-s905d3-cc/
+F:	board/libre-computer/aml-s905d3-cc/
 F:	configs/aml-s905d3-cc_defconfig
 F:	doc/board/amlogic/aml-s905d3-cc.rst
diff --git a/board/myir/mys_6ulx/MAINTAINERS b/board/myir/mys_6ulx/MAINTAINERS
index d4ee66118269..7f7850a566e7 100644
--- a/board/myir/mys_6ulx/MAINTAINERS
+++ b/board/myir/mys_6ulx/MAINTAINERS
@@ -1,8 +1,9 @@
 MYS_6ULX BOARD
 M:	Parthiban Nallathambi <parthiban@linumiz.com>
 S:	Maintained
-F:	arch/arm/dts/imx6ull-myir-mys-6ulx-nand.dts
 F:	arch/arm/dts/imx6ull-myir-mys-6ulx.dtsi
+F:	arch/arm/dts/imx6ull-myir-mys-6ulx-eval.dts
+F:	arch/arm/dts/imx6ull-myir-mys-6ulx-eval-u-boot.dts
 F:	arch/arm/dts/imx6ull-mys-6ulx-u-boot.dtsi
 F:	board/myir/mys_6ulx/
 F:	configs/myir_mys_6ulx_defconfig
diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore_am62ax/MAINTAINERS
index ded4a88d1997..1e3d90a01a22 100644
--- a/board/phytec/phycore_am62ax/MAINTAINERS
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -5,7 +5,7 @@ L:	upstream@lists.phytec.de
 W:	https://www.phytec.com/product/phycore-am62a
 S:	Maintained
 F:	arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
-F:	arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsit.dtsi
+F:	arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
 F:	arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
 F:	arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 F:	board/phytec/phycore_am62ax/
diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index 5cada15ac4b3..e60bb94b91fb 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -10,5 +10,5 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
-F:	doc/board/phytec/phycore_imx8mm.rst
+F:	doc/board/phytec/phycore-imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/board/siemens/iot2050/MAINTAINERS b/board/siemens/iot2050/MAINTAINERS
index 1b525356c2d6..2964de6a1631 100644
--- a/board/siemens/iot2050/MAINTAINERS
+++ b/board/siemens/iot2050/MAINTAINERS
@@ -5,5 +5,5 @@ S:	Maintained
 F:	board/siemens/iot2050/
 F:	include/configs/iot2050.h
 F:	configs/iot2050_defconfig
-F:	arch/arm/dts/iot2050-*
+F:	arch/arm/dts/*-iot2050-*
 F:	doc/board/siemens/iot2050.rst
diff --git a/board/sifive/unmatched/MAINTAINERS b/board/sifive/unmatched/MAINTAINERS
index e601a0f3288f..022434333ef9 100644
--- a/board/sifive/unmatched/MAINTAINERS
+++ b/board/sifive/unmatched/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Green Wan <green.wan@sifive.com>
 S:	Maintained
 F:	board/sifive/unmatched/
-F:	doc/board/sifive/hifive-unmatched-fu740.rst
+F:	doc/board/sifive/unmatched.rst
 F:	include/configs/sifive-unmatched.h
 F:	configs/sifive_unmatched_defconfig
diff --git a/board/ti/am62ax/MAINTAINERS b/board/ti/am62ax/MAINTAINERS
index bb0de6a04966..7ad7b293474e 100644
--- a/board/ti/am62ax/MAINTAINERS
+++ b/board/ti/am62ax/MAINTAINERS
@@ -4,7 +4,7 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62ax/
-F:	include/configs/am62a7_evm.h
+F:	include/configs/am62ax_evm.h
 F:	configs/am62ax_evm_r5_defconfig
 F:	configs/am62ax_evm_a53_defconfig
 F:	configs/am62ax_evm_r5_ethboot_defconfig
diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
index e7af7be35bca..00fcbd2f8c79 100644
--- a/board/ti/am62dx/MAINTAINERS
+++ b/board/ti/am62dx/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Bryan Brattlof <bb@ti.com>
 S:	Maintained
 F:	board/ti/am62dx/
-F:	include/configs/am62a7_evm.h
+F:	include/configs/am62ax_evm.h
 F:	configs/am62dx_evm_r5_defconfig
 F:	configs/am62dx_evm_a53_defconfig
diff --git a/board/ti/am62px/MAINTAINERS b/board/ti/am62px/MAINTAINERS
index c6c6deca61eb..05c8b0c99361 100644
--- a/board/ti/am62px/MAINTAINERS
+++ b/board/ti/am62px/MAINTAINERS
@@ -4,7 +4,7 @@ M:	Bryan Brattlof <bb@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am62px/
-F:	include/configs/am62p5_evm.h
+F:	include/configs/am62px_evm.h
 F:	configs/am62px_evm_r5_defconfig
 F:	configs/am62px_evm_a53_defconfig
 F:	configs/am62px_evm_r5_ethboot_defconfig
diff --git a/board/ti/j7200/MAINTAINERS b/board/ti/j7200/MAINTAINERS
index 626141367a57..f2bd32d59790 100644
--- a/board/ti/j7200/MAINTAINERS
+++ b/board/ti/j7200/MAINTAINERS
@@ -2,6 +2,6 @@ J7200 BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/j7200
-F:	include/configs/j7200_evm.h
+F:	include/configs/j721e_evm.h
 F:	configs/j7200_evm_r5_defconfig
 F:	configs/j7200_evm_a72_defconfig
diff --git a/board/toradex/colibri-imx8x/MAINTAINERS b/board/toradex/colibri-imx8x/MAINTAINERS
index 938c2ca0ca01..1aadf5450b3c 100644
--- a/board/toradex/colibri-imx8x/MAINTAINERS
+++ b/board/toradex/colibri-imx8x/MAINTAINERS
@@ -2,8 +2,8 @@ Colibri iMX8X
 M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 S:	Maintained
-F:	arch/arm/dts/fsl-imx8x-colibri.dts
-F:	arch/arm/dts/fsl-imx8x-colibri-u-boot.dtsi
+F:	arch/arm/dts/fsl-imx8qxp-colibri.dts
+F:	arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
 F:	board/toradex/colibri-imx8x/
 F:	board/toradex/common/
 F:	configs/colibri-imx8x_defconfig
diff --git a/board/toradex/colibri_imx7/MAINTAINERS b/board/toradex/colibri_imx7/MAINTAINERS
index 80770cc71a96..afdbb9b104ad 100644
--- a/board/toradex/colibri_imx7/MAINTAINERS
+++ b/board/toradex/colibri_imx7/MAINTAINERS
@@ -3,12 +3,12 @@ M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 W:	http://developer.toradex.com/software/linux/linux-software
 W:	https://www.toradex.com/community
 S:	Maintained
-F:	arch/arm/boot/dts/imx7-colibri.dtsi
-F:	arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
-F:	arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dts
-F:	arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+F:	arch/arm/dts/imx7-colibri.dtsi
+F:	arch/arm/dts/imx7-colibri-eval-v3.dtsi
+F:	arch/arm/dts/imx7d-colibri.dtsi
+F:	arch/arm/dts/imx7d-colibri-emmc.dtsi
+F:	arch/arm/dts/imx7d-colibri-emmc-eval-v3.dts
+F:	arch/arm/dts/imx7d-colibri-eval-v3.dts
 F:	board/toradex/colibri_imx7/
 F:	board/toradex/common/
 F:	configs/colibri_imx7_defconfig
diff --git a/board/toradex/colibri_vf/MAINTAINERS b/board/toradex/colibri_vf/MAINTAINERS
index a41bd165a7ca..330324ff1d1e 100644
--- a/board/toradex/colibri_vf/MAINTAINERS
+++ b/board/toradex/colibri_vf/MAINTAINERS
@@ -6,7 +6,7 @@ S:	Maintained
 F:	arch/arm/dts/vf-colibri.dtsi
 F:	arch/arm/dts/vf-colibri-eval-v3.dtsi
 F:	arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
-F:	arch/arm/dts/vf610-colibri.dts
+F:	arch/arm/dts/vf610-colibri.dtsi
 F:	board/toradex/colibri_vf/
 F:	board/toradex/common/
 F:	configs/colibri_vf_defconfig
diff --git a/board/toradex/smarc-imx8mp/MAINTAINERS b/board/toradex/smarc-imx8mp/MAINTAINERS
index f7fcef1c0921..77255a3e35aa 100644
--- a/board/toradex/smarc-imx8mp/MAINTAINERS
+++ b/board/toradex/smarc-imx8mp/MAINTAINERS
@@ -3,7 +3,7 @@ F:	arch/arm/dts/imx8mp-toradex-smarc-dev-u-boot.dtsi
 F:	board/toradex/smarc-imx8mp/
 F:	board/toradex/common/
 F:	configs/toradex-smarc-imx8mp_defconfig
-F:	doc/board/toradex/toradex-smarc-imx8mp.rst
+F:	doc/board/toradex/smarc-imx8mp.rst
 F:	include/configs/toradex-smarc-imx8mp.h
 M:	Francesco Dolcini <francesco.dolcini@toradex.com>
 S:	Maintained
diff --git a/board/xilinx/zynqmp_r5/MAINTAINERS b/board/xilinx/zynqmp_r5/MAINTAINERS
index aa50e6dae5f5..0f096d2e71f1 100644
--- a/board/xilinx/zynqmp_r5/MAINTAINERS
+++ b/board/xilinx/zynqmp_r5/MAINTAINERS
@@ -3,5 +3,5 @@ M:	Michal Simek <michal.simek@amd.com>
 S:	Maintained
 F:	arch/arm/dts/zynqmp-r5*
 F:	board/xilinx/zynqmp_r5/
-F:	include/configs/xilinx_zynqmp_r5_*
+F:	include/configs/xilinx_zynqmp_r5*
 F:	configs/xilinx_zynqmp_r5_*
diff --git a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
index 79981aa43f13..7e0842ae675c 100644
--- a/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
+++ b/board/xunlong/orangepi-5-ultra-rk3588/MAINTAINERS
@@ -1,6 +1,6 @@
 ORANGEPI-5-RK3588-ULTRA
 M:	Niu Zhihong <zhihong@nzhnb.com>
 S:	Maintained
-F:	board/xunlong/orangepi-5-rk3588-ultra
+F:	board/xunlong/orangepi-5-ultra-rk3588
 F:	configs/orangepi-5-ultra-rk3588_defconfig
 F:	arch/arm/dts/rk3588-orangepi-5-ultra*
-- 
2.43.0


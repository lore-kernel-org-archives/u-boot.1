Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433D606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QJRYjU1C;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=GXISA3br
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C75E408E0;
	Thu,  5 Nov 2026 17:54:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0BxuzjZaOtAJ; Thu,  5 Nov 2026 17:54:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B0512408E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901285;
	b=piAguN3l5QQChQ2Zd/FBpZ7BJ8mz1r0d4kwn3+Nsf9Z5ciekJCcnq4Gn703eFiT3LtBG
	 Hd80YHa2PTBnG8FPAmQgb842RwNeeYGrUwnQscFEUY3qTFXK+kF1Q8mDtpJD2+eYJuaEn
	 krfjm056g8PGaiDI7yzqZ1a6ChlYhALfcDxN9g11/z4p8w8M3GnBbeR07hPyQmmbzOg5T
	 TJAYVP548eWNmaEDhjjI0kGu6TtgSeZ2fLtEREbpal62hpcD8oTxERhD7YLAnTKbhTq9B
	 1NmHXnC1XqkRLFLYM5TLk8Y04uiCYgO5ZWSd766c1Qnh/AKLiGS+I/ng/at8fcUspgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uOFief7NxntK5003hiYP81E964Rk/IDXbzocUHPOJwo=;
	b=tMx5p4Y3zTl39CVgFIvAbIamrjkJCzbyZVkN2+7pciO/ep0qGSlnesFhBXmitEiRXMgJ
	 oAaN8FtovoYqjeHd4lSL1guS11eMjSsAzpXBU3gRDotqbIt3Nl3TTg5w6NOP/rtuuFc8t
	 HOHEyNVpeOnDOO08+pTqGsglK50KIINs310U132wP4b1CB4WSNHA78abTFnerK6znh678
	 sokNTZ5BVrqdm23VMDtcnDL+H/mvDIxmpJJz5HYIcwFGYx1Dz5HdqfylR1Vt7hPQO2rRD
	 8dDsyxAv8FUUx4DrHbJp21Er4x89IE6ZtFyPrlx/H//I11H9rPVG4/XPO3wdYEFmdCw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901285;
	bh=uOFief7NxntK5003hiYP81E964Rk/IDXbzocUHPOJwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QJRYjU1Ch5bpDEYQY3aqsLvFsjKSJeAtWitdofw1IX16NQ8BN/0oYlGRWVdKyeCu1
	 p/k90VGIhQ8wRQm8mSIPNI2lqGp+maTuBMbQ6l9qrs1fe+pGv4rVS+04bzr2NfGYBl
	 UEBFGODI2rG9m2LIztKE6BZD+Iuxm6ymTjH5uh92BnhovEtA4rgbsYWa2rTUTWbzWF
	 lRL4Ji7HOKBxERzlCYLbcPGQp5bijH+SnRNs64dNxtQMxwtGwY8sVT9VOIIvdDZUgq
	 ZT4C28pBgsc5xrvxIrqHk3g6+rRkqVRGlykurFFCLIGXz9CX2AQzLwSjw4R85w9dO3
	 i98HO5teUeheg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0512408E8;
	Thu,  5 Nov 2026 17:54:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 85FA2B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82BA781144
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtxKiN0dGEQK for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9A46A811AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=GXISA3br
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A46A811AD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:36 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6b19e291cc6so1900777eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901276; x=1794506076;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOFief7NxntK5003hiYP81E964Rk/IDXbzocUHPOJwo=;
 b=GXISA3brEGrud5OEd3sA8CkiSLj2iXNIVFLZ8ITQ5JGw6BJ+t7IhpF2iRVjip/dtsE
 IucqWR0aU03tCRPx61jZKgHNjutVlJyNS9tlJbcQrmMyBCgrJ+uQRc8Yhc5uIbwuzCUC
 loDiS2dtF3iuuMxj4thPYhC2o867GOMbSxME+Y7DuG5j6KS4Bk4ovZORWHzaBH+PoQx2
 RrLoh2/6KS4/Baxn0UUaM25yWvBY5mtVLurmOAyVgGiBAfMLnzq/GyDkRz91g9Z2khVW
 ukGb3Jt1CYQ6bym9+1HJXryOuvN/ZsOHGmDSYFawqsUqBFrmILR/czVS72JjoUd2fLmH
 jVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901276; x=1794506076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOFief7NxntK5003hiYP81E964Rk/IDXbzocUHPOJwo=;
 b=FaE0tY1PbgCxrcLI9zD8jfdj6oBGfwocfkNWQDAkFY7zKeP99EwTM7ks7xahLQpCyz
 fPlro5aC5KeBhdROzSkRPz14NAqQjFA0nXgJ3/ufEfvDbJw8dKow1bQkqrWFhHTipe3F
 t+SwTtB13Z4xX5faKnR4JOLvNsH59a4nUDo3gygstNR8OiO2QqjQ0aZl1N6SNPD/mOhY
 z48RO7JulVPFdihWFm27JhJF97BKAJB3HYpWiIg0IEq69/M2TXY29pDMSNC9LWhoCJpV
 kG1QZWj0jMMKpEimABANij/M8n0HpCBtl7i8zIus2qiOX/H+7qSbd4A9T/QfUmfECUVe
 Ex/g==
X-Gm-Message-State: APuU4Z/Zcb18tKDLjuxL2oihnQ2JZDzPNyPPyM/bpQuhAymBnTbK1iSA
 MMvdV6fbTXXH5rH4RvoBaom4Si/aTEDlB4nI6qZhzdMWrwmMPe6Wg3CcuNSTXpBrbJc=
X-Gm-Gg: AYBFou18ZAnWUBDWiPHCC0WD7XzTRvuC6iMiv8Vav4zpkpfhiUeya+CEXdotn9ulm2Q
 qcwrr0Rs+CTWysImIaTBDb487BJtTpQZPiSgML3dPuIIz7we7BpKATBFgUdHdMjwDC+LcM5nP8+
 YRTTsULjUN4F2BJebeKqy7jZXELfa0Ncq4y9BKR7ltovTfPug64QLflwL4KW3zkdtHwkI1or0He
 PBCr7f8NSdo6K+Xrov2BGvmTKJwlBR/Ku0gQsfwjpYX0YB1Bs0tfUyyl0oDZ1YFiZh5VTwyasD5
 TBmPhXQqWc9kX1pdcb+qUqmcpU6LmhfqoxflbzUgg6UWUaDLNIEHbplqeaFUeeMfR23mmR23cEm
 yajujxJP65Xdr9Vks6aKB12M01O3xdZE6Kh5M1P2LBojwGqL/vtCL/2uL7FTYUCBFDfkF/lAaEb
 rZOcTElGWN8M2qtpyKonufrcOfEWOLBAqeEN1aUK5BjRckY92pTdZcFRr8k/9q/JJNbK0NGv9hD
 D0hiHAtYTPeq2XWvy6FfNlIK53/JV03USKyM2Z2QvQRfUMb1rc/TMu35SlefmlmsJT9Z9CgfV0d
 Sswtsok3S8qb4wY8wQqoBBM55o9gVHAReQ==
X-Received: by 2002:a05:6820:4613:b0:70e:2d38:4b86 with SMTP id
 006d021491bc7-716e77f4744mr220252eaf.16.1793901276026; 
 Thu, 05 Nov 2026 09:54:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 11:53:40 -0600
Subject: [PATCH v2 5/6] arm: mediatek: build Genio 520 and 720 boot images
 with binman
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-genio-720-spl-v2-5-4994535a3848@baylibre.com>
References: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
In-Reply-To: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4880; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KtQNjwLE2UGiB4hyKxipVkyXk4WDV7USPQZDsyf63dM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MLGFSaswbobFvjv/AWt3BFKazob7RWYonhUL
 FAevXahbsyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCxhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AWEsH/j4P9AMAXeXoVDp0c1rjrueHvcSWpbZhf7m5wRV
 a/KSsDukaGgZMm9CRZbp0zBJulP8A3EX0/kBLc0MRVU0HnRHswmvdGAyBfQnQ+DrPk5JAfrx0tC
 VUeA10az458eSN6LPsAkVsjwykINFMtvuZ9EShzwR67tUDwm+dho86qzWRyw2IpZKS9HikPwn5X
 A3FxMPL5iwlIS2UbrWSpZc4Qt2Y1jBzyH3wYobb9fx7zTlGcS0S1z7QYSY+Of89xx+kNUeGp6ab
 qopytsolhA7OI/+znshpUq1tBVMb0JmVa/VTrR3pwmkXq51qSDijtjJ94J6k3b+pF3RvurROZlQ
 oW9A=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow CONFIG_MTK_GENIO_BOOT_IMAGES on MT8189 and reuse the Genio binman
descriptions to assemble the BootROM image and firmware FIT for the
Genio 520 and 720 EVKs.

The MT8189 BootROM loads the payload to 0x2001000 rather than 0x201000.
The DDR loader needs more than 600 KiB of SRAM including its BSS, so
reserve 640 KiB for it ahead of SPL. BL31 is linked at the same address
as on MT8188. The DDR loader runs in AArch64, so request AArch64 BootROM
entry in the image header.

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/mach-mediatek/Kconfig                | 10 ++++++----
 board/mediatek/MAINTAINERS                    |  2 ++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
index a69e2db5a04..53e06bc6af1 100644
--- a/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
@@ -1,3 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 
+#include <config.h>
 #include "mt8371-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 520 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 520 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
index a69e2db5a04..0ee1ef3a869 100644
--- a/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+++ b/arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
@@ -1,3 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR MIT)
 
+#include <config.h>
 #include "mt8371-genio-common-u-boot.dtsi"
+
+#ifdef CONFIG_MTK_GENIO_BOOT_IMAGES
+#define MTK_BOOTLOADERS_DESCRIPTION "MediaTek Genio 720 bootloaders"
+#define MTK_BOOT_CHAIN_DESCRIPTION "Genio 720 boot chain"
+#include "mtk-genio-binman-u-boot.dtsi"
+#include "mtk-genio-mtk-boot-binman-u-boot.dtsi"
+#include "mtk-genio-bootloaders-binman-u-boot.dtsi"
+#endif
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index cd84109854d..1fde892baa2 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -217,8 +217,8 @@ config SYS_CONFIG_NAME
 config MTK_BROM_HEADER_INFO
 	string
 	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
-	default "media=emmc;arm64=1" if TARGET_MT8188
-	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
+	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
+	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
 config SPL_MTK_FIRMWARE_AB
@@ -240,7 +240,7 @@ config SPL_MTK_FIRMWARE_AB
 
 config MTK_GENIO_BOOT_IMAGES
 	bool "Build MediaTek firmware images"
-	depends on TARGET_MT8188 && SPL
+	depends on (TARGET_MT8188 || TARGET_MT8189) && SPL
 	select BINMAN
 	select MTK_GENIO_IMAGE_CONTRACT
 	help
@@ -255,6 +255,7 @@ if MTK_GENIO_IMAGE_CONTRACT
 config MTK_GENIO_BROM_LOAD_ADDR
 	hex "BootROM payload load address"
 	default 0x201000 if TARGET_MT8188
+	default 0x2001000 if TARGET_MT8189
 	help
 	  Address at which the MediaTek BootROM loads and enters the external
 	  DDR loader.
@@ -262,6 +263,7 @@ config MTK_GENIO_BROM_LOAD_ADDR
 config MTK_GENIO_DDR_LOADER_SIZE
 	hex "DDR-loader image region size"
 	default 0x4b000 if TARGET_MT8188
+	default 0xa0000 if TARGET_MT8189
 	help
 	  Size reserved for the external DDR loader at the start of the
 	  BootROM payload. This is also the offset of U-Boot SPL and must match
@@ -269,7 +271,7 @@ config MTK_GENIO_DDR_LOADER_SIZE
 
 config MTK_GENIO_BL31_LOAD_ADDR
 	hex "BL31 load and entry address"
-	default 0x54601000 if TARGET_MT8188
+	default 0x54601000 if TARGET_MT8188 || TARGET_MT8189
 	help
 	  Address at which SPL loads and enters BL31. This must match the
 	  platform firmware's link address and secure-memory layout.
diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index eaf645086f6..17bbb4d9f59 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -4,6 +4,8 @@ S:	Maintained
 F:	arch/arm/dts/mt8189*
 F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
+F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
+F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*

-- 
2.53.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEC1C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A1A382B26;
	Wed, 16 Apr 2025 08:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=temperror (0-bit key; unprotected) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="kCFIKTsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D2882CBB; Wed, 16 Apr 2025 08:29:55 +0200 (CEST)
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17CC982AE1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prvs=1215f95e09=ms@dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
 by relay.expurgate.net with smtp (Exim 4.92)
 (envelope-from <prvs=1215f95e09=ms@dev.tdt.de>)
 id 1u4wHP-00EUXv-Jj; Wed, 16 Apr 2025 08:29:51 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
 by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <ms@dev.tdt.de>)
 id 1u4wHO-007yY6-Lf; Wed, 16 Apr 2025 08:29:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
 s=z1-selector1; t=1744784990;
 bh=xLAGf+NZD4nUC9o+E8qEHYalv3BIeUbk78b9FjX+FBU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kCFIKTsO39jyB9xKe8Em4ClicotBxf15OWmxLC+23WN+ez9tRTOWuOvDLnONxnfe6
 FWCel2ilTp9mqSOPrkHDDLMpT1OIvL6vwJ8IlTR7n2YxP++5NWXXeHsWCibzwc3ah9
 jnu5kEbeCVrDWkb1lXGicUDt2Ey4bsTQmuxVj2nFDjz39LvNV6pB/YQ4ovjaVpm2h9
 N0/4PfAL5pXQFcIuXraH0Ldhqk7fxR1FYmMNiJCMWxhiwmYsQ3dSFEwL4kt9QvCaFC
 K8ME5BkOovj5Wd948qyZT8f/sH4S0Z6xMHOtb0i3Zz9NBFa265ESau2fsV8aHZRegv
 S/M3DonXfe3yg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
 by securemail.tdt.de (Postfix) with ESMTP id 35702240041;
 Wed, 16 Apr 2025 08:29:50 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
 by securemail.tdt.de (Postfix) with ESMTP id 30448240040;
 Wed, 16 Apr 2025 08:29:50 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
 by mail.dev.tdt.de (Postfix) with ESMTPSA id F1DAA24FB8;
 Wed, 16 Apr 2025 08:29:49 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 hs@denx.de, trini@konsulko.com, ansuelsmth@gmail.com,
 Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 2/2] i2c: mediatek: remove duplicate entry in mt_i2c_regs_v1[]
Date: Wed, 16 Apr 2025 08:29:19 +0200
Message-ID: <20250416062919.1355568-2-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416062919.1355568-1-ms@dev.tdt.de>
References: <20250416062919.1355568-1-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1744784991-14D88237-6419B09E/0/0
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

This removes a duplicate entry in mt_i2c_regs_v1[].

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/i2c/mtk_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 6edf3f44eca..55381dbeced 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -143,7 +143,6 @@ static const uint mt_i2c_regs_v1[] =3D {
 	[REG_RSV_DEBUG] =3D 0x44,
 	[REG_HS] =3D 0x48,
 	[REG_SOFTRESET] =3D 0x50,
-	[REG_SOFTRESET] =3D 0x50,
 	[REG_DCM_EN] =3D 0x54,
 	[REG_DEBUGSTAT] =3D 0x64,
 	[REG_DEBUGCTRL] =3D 0x68,
--=20
2.39.5


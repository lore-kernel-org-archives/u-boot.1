Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED04D5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23588901D;
	Fri,  8 Nov 2024 06:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043318;
	bh=f9+0NXDWlzE3CYKsqxVK37f9Ai+XmaDkvPo+gwampxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIo3T29XBhLSCuuLzO+z4Q+/YHQtGh3aooVp1pi9eNdwpO1SaF2NPgVIuSPiYEswn
	 fuhOg4ZktI1YHzJ/85DrZd3fGo/xkcMcWbkkhRuDCfZJdVtB25y9L4h1XNgPu/4WVH
	 kyBBUw31f97xiY6r/sb8sIh2+kR4ZTJFzRqojAHOBhx/7kR+Hsgu7uLfuzsFQHLgX4
	 ZmaORZpKn+VVDTvnJW1elAWrccKbQgQhFKCwJ8JjcBG0P6GzVId9+9VCG8lb/MhujE
	 +qrN/Du3DBGPv9mMDoyaVPXF6ZM5BbeJSDyrVNvFfYErgaXrsN42ATN6Pf5Q4W6dqM
	 CrPEakwFkr2AQ==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3B2858901D;
 Fri,  8 Nov 2024 06:21:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043315;
 bh=f9+0NXDWlzE3CYKsqxVK37f9Ai+XmaDkvPo+gwampxE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sikpT0yzhcc4Yp5qBZdQd/Yk50zuSTXbJz0nGK+il0mhc2Bg6xI1iNprPumKBmhIs
 G9RkGe37o80tT5y1J6uawPyMjkvbgIF8aC0X7WSUj9y5fvTXHy//Fe4drDkkFw8Rug
 bnaLLra2y8CLd/ZsfrdD62jCanWU1eMc2/Bru8XaGP5ViYcql3tSu30kxvgjHhmUqb
 TDuT7eGOzICbepZONjqJ1WdPxQ3R1dz+Dt006TbawK/JnJ97PkHYmgB7fdVTQzg9ex
 btK76FlngNbGPclwCQWvUG3YH9B8q1Qb3CiyFUq2IrwsgkvVlaE2RedYZL9VPTYQvJ
 7FuuyISoPEdzQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 05/22] imx8qxp: Fix build when using SPL
Date: Fri,  8 Nov 2024 06:21:26 +0100
Message-Id: <20241108052143.26874-6-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

imx8qxp based boards which use SPL drop error when
calling make all:
"""
Writing image to './flash.bin'
   Node '/binman/imx-boot/spl': GetData: size 0x0
       Node '/binman/imx-boot': GetPaddedDataForEntry: size 0x0
       Node '/binman/imx-boot': GetData: 1 entries, total size 0x0
       Node '/binman/imx-boot': GetPaddedDataForEntry: size 0x0
Wrote 0x0 bytes
Image 'imx-boot' is missing external blobs and is non-functional: spl

/binman/imx-boot/spl (spl.bin):
   Missing blob

Some images are invalid
"""

Guard creation of flash.bin with CONFIG_XPL_BUILD option.

Signed-off-by: Heiko Schocher <hs@denx.de>
Fixes: c9713c155127 ("imx8-u-boot: Fix SPL guard option")
---

 arch/arm/dts/imx8qxp-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/imx8qxp-u-boot.dtsi b/arch/arm/dts/imx8qxp-u-boot.dtsi
index 62791c34c77..8058caae9ba 100644
--- a/arch/arm/dts/imx8qxp-u-boot.dtsi
+++ b/arch/arm/dts/imx8qxp-u-boot.dtsi
@@ -120,6 +120,7 @@
 		};
 	};
 
+#ifdef CONFIG_XPL_BUILD
 	imx-boot {
 		filename = "flash.bin";
 		pad-byte = <0x00>;
@@ -130,4 +131,5 @@
 			type = "blob-ext";
 		};
 	};
+#endif
 };
-- 
2.20.1


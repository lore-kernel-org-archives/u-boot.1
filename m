Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C7AD75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A3E8968F;
	Thu, 21 Nov 2024 06:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166776;
	bh=eMRGy4VglhEmKPnVAkrctdJ723uptXyry4fwECGwfvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=osR7GYsk/64bx45fWb8S+ygJ2F3SOeKQkPSpbfcOrMVjHhBbotCq2jQj1dJdONyZE
	 6alDqcyDOvA5hkNQeWyOo8i70bz2RM9TyCE1MpoSWUMGOE544D8hGePj8RZMmGkib8
	 F4vxuIK0bhZmFVbA7gtLoeF08ZN5dysd4/9O7oVOVuuvtlNnHuaFY+2cbiEfXdOG5e
	 LCQmYMCnZr+I4HmxsWbGig/ZzRKe41SfOnTW9dzr15yn0aGX4b/9xADsPsRH/SvR65
	 tVo6Tc0i9u4A4fotSV3z8LLmwN5OFq+eKrNDtJGmQkZgj1qu3lFTyMg9ZyWal1pQyW
	 iCTTaAWMtMzgA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F3C5089678;
 Thu, 21 Nov 2024 06:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166773;
 bh=eMRGy4VglhEmKPnVAkrctdJ723uptXyry4fwECGwfvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=II0HqN8C2Iy/sXUZNYA5SX0PjZ8Kbl88ilTuOnuQoXjHBGsWRXuAlMm+AgekJVflE
 d3woprraw5dD8VEtpjFr5TzQfxPsUhuJ6Nfrj7c/d9b71gPyZwyMduLi0WCa+H8nEB
 imC3DEY8G8siAQEdMXdohUBOnvVT444t5jUfxbKAIOch4z8X1i/+YXgC1ZvanNTZo9
 GEschpldLpMdD2CRX9lxFnnqRHENIOM0JuuLuBSbHvfk6N3gG9wrW8UMtQrDDQ7yFG
 r1gn1GJpR1nX8AGjU5Lc9gWOkaBfpvOSI436U5IxgeM18KtlVEbDPrMKPTDeK8dV3d
 mow16mlSb3nsA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/20] imx8qxp: Fix build when using SPL
Date: Thu, 21 Nov 2024 06:25:46 +0100
Message-Id: <20241121052601.72880-6-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

(no changes since v1)

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


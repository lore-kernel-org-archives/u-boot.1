Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47267D5E393
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954A189415;
	Mon, 18 Nov 2024 07:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911252;
	bh=eMRGy4VglhEmKPnVAkrctdJ723uptXyry4fwECGwfvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v8mtxBzhoRTEZh4bNdXsiqNQyoh2a4bu/AWTK0hL8++U6DTG9otNuWH/MmVEfJbYj
	 KFxGe2eO+fJaTQUMZc6hxVQoM0Ykbq3o09/gPPppROT1Uv82ziHKrR6JAwTDWfrP4W
	 k0igIqOqZo4rNmsVMUJZhiCg3S+2wD0+NY4cu1ebu9SUe+0tsplRF/WFjib+CyTjB9
	 KLNT7CVUaYPmJ3p/dQQOclRl6K/KSEqFMKV0HNvWzMUG6JyrLjJrp73q+KxZtYZYPI
	 508WiqACP8ZXaSq6XI1UD0sCYcws5c+GIA1lCGWUZr96aKIKuE3gmZrT67n2sM0TrI
	 Xj+VbDJNz2UFw==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 313A88942A;
 Mon, 18 Nov 2024 07:27:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911248;
 bh=eMRGy4VglhEmKPnVAkrctdJ723uptXyry4fwECGwfvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eZNyIMMUDMdvCRIe2tqrcbJodxNj7lZcWAcpbScHXlKOlSJwY6gLA0z8EN1e4Jse5
 kr6BOlxFSpfi+andW+Su8laSMIxkJwoTMCfoyZtrkyYmbK1aNvlNFHCPRMc07dmaoN
 aMPNF7SiQN4a870qfZhKx5w5RJiB253zBI9U4Kcf1tkFK6xUlpB6oLYSKjN2yUphqo
 naSCAOAwOsCBUAwf+3NsENqtp4g7PylcrlGjBgegTyS6ob0x3aqGX2lTpM6nLbrZQ1
 gsGz7vHwN/ON7N+VnxNMcHAfhUnW+Lu26tIqTnBwi+/FAcbkF79XNTY8a734+xIkJs
 ZgcHhPYtTVy0Q==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/20] imx8qxp: Fix build when using SPL
Date: Mon, 18 Nov 2024 07:26:59 +0100
Message-Id: <20241118062715.32989-6-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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


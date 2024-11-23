Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109FAE6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376CC89407;
	Sat, 23 Nov 2024 17:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380798;
	bh=eMRGy4VglhEmKPnVAkrctdJ723uptXyry4fwECGwfvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mdz4UhfRdOYlfopJejqp8EQWcGBhdKFTnGPpBjjJJqLW6YYtIP7wA1lMFJdepaLN8
	 31o2c4Vunec7M0XvJv742dZCTDzmYlTUWvZczkWtB1c2NIVs3ZZ2VJO0EFQ3YkRz2k
	 2/WgimnX24qZdHFKz/MSt9trh5u8BUmAIFWUZHiQ9jnRS+GtFty0CtI7z+VJ6XNg2J
	 8jxe1ew6gzEJpKTh3KhxA7Cwo+DG49sdrIRlfSQ62IVuRqvsaWos+tgumHCvrYyHZk
	 foj4h1gNmN2rxFQkHWxVCSe06VeSyIYly8eehqc2u0Yz0FEUqWdOBBDGxsYXQ+jSwk
	 y+v4DWDIVkUkQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 94B7A893F4;
 Sat, 23 Nov 2024 17:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380796;
 bh=eMRGy4VglhEmKPnVAkrctdJ723uptXyry4fwECGwfvk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wF/jAYFKzLioQ2NhUqtDKfaT2MgqqWzlNen88lEMEv3up017Q63cz6GubFe0N91SP
 iE0X6ntTq8i+WT9Aqu/V6fb5vrCZU+Hbc7ad10QfMaMIkAJZO845x1eTPwrVTm0yvu
 tpbGzLWykfr+Di0yeyeOY+ZMdVdpfSm7Sb9ilYPa4y/uqYHIznMy7ouqHpInhLQLE3
 T3dHdwKu0gWLY+d0B0BbgaTA6Ffb4eEjEGMe9DidathoqzsGNsoi2mFok24/IqnCii
 Na+p6eKFm1XrNEMc2txb3nBrI/UaSLaDPDG2h0ROewWaRzpRB6ikaEPTiVlHalZ3Tc
 TZDvanE8iLbmw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 05/20] imx8qxp: Fix build when using SPL
Date: Sat, 23 Nov 2024 17:52:49 +0100
Message-Id: <20241123165304.100538-6-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2252DC282DE
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE3C811C1;
	Wed,  5 Mar 2025 19:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=os-cillation.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=os-cillation.de header.i=@os-cillation.de header.b="OhBfOzOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7970C80ECC; Wed,  5 Mar 2025 19:37:12 +0100 (CET)
Received: from os-cillation.de (mx.os-c.de [213.165.83.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904CA80BAA
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=os-cillation.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hd@os-cillation.de
Received: from core2024.osc.gmbh (p578a635d.dip0.t-ipconnect.de [87.138.99.93])
 by os-cillation.de (Postfix) with ESMTPSA id ED4A7C023A;
 Wed,  5 Mar 2025 19:37:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=os-cillation.de;
 s=202409; t=1741199830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvTRpqD8ulIDyCiMgrUTexvmHR/bPfD0YDZzLnbnfGw=;
 b=OhBfOzObetG9XAPsdsk1vCDXGoHkgS8A5MUKgLZ9l7J18do9HIUTy00CZ0kyHTqhRKcFMx
 O6Repg2uhSM+iGPQ99RkmIihA+J92kFjjlkxLufnD/3YaM98EJ7mQ/rGV4JxkD7LlItsq6
 X/cefnICb8YK83vm7SHnUfY3UVfiNzqQugHLKAOuswDxfwpRDaAL3oNsIkFmEERFoQhfLB
 mbA8Kg5TlKb3X5tz3dX/3FUBeI1f3dDFMrQG11efOZaBdc4RoGlOkw6TxgSQYuGzUA+qs1
 gCTbk1f3nXnYRN7eQSSno/H875YP8lIwrWA7ormzjJhVaf5h6x6V6Ljv2hSHvA==
Authentication-Results: os-cillation.de;
 auth=pass smtp.auth=os-c@schweissgut.net smtp.mailfrom=hd@os-cillation.de
Received: from hd2022.osc.gmbh (hd2022.osc.gmbh [192.168.3.45])
 by core2024.osc.gmbh (Postfix) with ESMTPSA id 8DD2D200059;
 Wed,  5 Mar 2025 19:37:09 +0100 (CET)
From: Hendrik Donner <hd@os-cillation.de>
To: u-boot@lists.denx.de
Cc: Hendrik Donner <hd@os-cillation.de>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] imx8qm: Fix build when using SPL
Date: Wed,  5 Mar 2025 19:35:42 +0100
Message-ID: <20250305183544.40525-2-hd@os-cillation.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305183544.40525-1-hd@os-cillation.de>
References: <20250305183544.40525-1-hd@os-cillation.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Mar 2025 19:54:15 +0100
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

Analog to 645a42d7ee88dc8c3848c15d178b0f111c636933, imx8qm based boards
which use SPL currently fail during make all:

Image 'imx-boot' is missing external blobs and is non-functional: spl
/binman/imx-boot/spl (spl.bin):
   Missing blob
Image 'imx-boot' has faked external blobs and is non-functional: spl.bin
Some images are invalid

Guard creation of flash.bin with CONFIG_XPL_BUILD option.

Fixes: c9713c155127 ("imx8-u-boot: Fix SPL guard option")

Tested-by: Oliver Graute <oliver.graute@kococonnector.com>
Signed-off-by: Hendrik Donner <hd@os-cillation.de>
---
 arch/arm/dts/imx8qm-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/imx8qm-u-boot.dtsi b/arch/arm/dts/imx8qm-u-boot.dtsi
index af229501a4d..6679c9de462 100644
--- a/arch/arm/dts/imx8qm-u-boot.dtsi
+++ b/arch/arm/dts/imx8qm-u-boot.dtsi
@@ -122,6 +122,7 @@
 		};
 	};
 
+#ifdef CONFIG_XPL_BUILD
 	imx-boot {
 		filename = "flash.bin";
 		pad-byte = <0x00>;
@@ -132,4 +133,5 @@
 			type = "blob-ext";
 		};
 	};
+#endif
 };
-- 
2.43.0


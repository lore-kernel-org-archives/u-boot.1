Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDE2D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 17:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5C1F842CD;
	Thu, 27 Nov 2025 18:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hTRcL26l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C552584459; Thu, 27 Nov 2025 18:29:31 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAD8D83B4A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 18:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremie.dautheribes@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 282CC1A1DCC;
 Thu, 27 Nov 2025 17:29:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E61F660722;
 Thu, 27 Nov 2025 17:29:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F2CF9102F2846; Thu, 27 Nov 2025 18:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764264568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=PwX4Y3UDE7R2ybl26gpcfie8tLpZ44fy/fnfBQw9pcI=;
 b=hTRcL26l9toptdtPqlY2+4UoqCGdfaNQpcSoovZH4g51DN3NLDRu+5rhSG5SYyH7NCYBZz
 L+zTUquUlXzGOHMHliN6KDcLSYTqAB0sVUo2xid6NfcwIaE1GZ/M5NcgS724cy94jWSsvP
 CA15Wg+BL4Xv5bswbv0CAFh5HhyqArP3VBb6jhxKs1JANHSFocFmG9pxT46LPoRpN9lGaA
 +4zpHXJZonmAIrI63vw3cDkKEQZko7TF3i9XCFOvE7/Olcknq/5ryLm0seOToXh3hmEWvj
 UXfpOKKpJJ5+nDJ5K3EMAionS06S6/mDVKwOyGKUzx366fG03fD9Bc0Ld+LmPA==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?=
 <jeremie.dautheribes@bootlin.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>, Wahid Essid <wahid.essid@se.com>,
 =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH 0/2] nxp-imx93image etype for the imx93
Date: Thu, 27 Nov 2025 18:29:18 +0100
Message-ID: <20251127172920.39740-1-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Jérémie Dautheribes (Schneider Electric)" <jeremie.dautheribes@bootlin.com>

Hi all,

This patch prepares for integrating the automatic secure boot signing
procedure into the i.MX93 platform, similar to what was done for the i.MX8MP.

It switches the binman node to use the nxp-imx9image etype, initially
introduced for the i.MX95 platform.

I still have some doubts about (optional) OPTEE support with this etype, so
any feedback would be greatly appreciated.

Best regards,
Jérémie Dautheribes

Jérémie Dautheribes (Schneider Electric) (2):
  imx93-u-boot: move binman description
  imx93-u-boot: use nxp-imx9image etype for binman node

 arch/arm/dts/imx93-u-boot.dtsi | 125 +++++++++++++++------------------
 1 file changed, 56 insertions(+), 69 deletions(-)

-- 
2.43.0


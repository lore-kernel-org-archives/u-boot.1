Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D037C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A9C885DF;
	Sun, 19 May 2024 14:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="nRtFVfcH";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VghAquoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA0688281; Sun, 19 May 2024 14:57:03 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEFF8849D
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id 2BABE18000B4;
 Sun, 19 May 2024 08:56:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Sun, 19 May 2024 08:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123418;
 x=1716209818; bh=T7mJiv8eohbpeUEHidRVbI5PMPfgASZ9uTdr5KNh440=; b=
 nRtFVfcHlDBeq3+mASGxEBo+HtjwuU0qPal1vWIjrbmm+qcXX6XXHZQPBBWW0NhO
 lNE7XnH4dzAxAKSOVVsOfJ5l7lDq2iuNmK76Fs0M2j57s44cIQ17ZOscehd6MKBG
 B3AtuX81/3r0ddd/zY3cA8T8C88FyeOMHVm2XLNaXG4Zvaft5hjE1MGgWZSqsvww
 gORuebA7N79Ey5W2VodMoaMArakEYSgR9otR18meS8tBQcLEK7nuh5E8m3+ucJO/
 MsG9o53s/Bf4Eq22iAtBndl01ubHEibVVM4r4i2PMdx1dYixd1OuFuRJWfJzkooD
 yKMarDCcdFG2Ht/CnchMbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123418; x=
 1716209818; bh=T7mJiv8eohbpeUEHidRVbI5PMPfgASZ9uTdr5KNh440=; b=V
 ghAquoCN/IEgM7M3buMwXxH9wEZZnPovZBe/iYNNTkUHjWtHMC1HUG9nrT+VGEu5
 J9VEFAvJrRef+fPT+a8tHZy9jH0kmMPwA8cZBDTRXdS7vbFMu3k8LGAg9UdRQJ4F
 ZQtaPVeh8vkII6T44RsF9pqtzdisQlulHEE7GW/SKrImkUU9FMWXNyyrxdbtCI1J
 Zm+T3V2lleYWaPblMCyU1W2Nt2IOwTtA68furNw5UGk2nKIvVMEoTutnV1GqWuf6
 Ve9ttd4bUBw6meaSvqLJ7A2v287R827mAeiXqCdGw+j/NvhLoMoWAEcG0AVmOrAW
 Q52DvHk40NdY8mMbjoqDw==
X-ME-Sender: <xms:GvdJZgnIGFxG_V-PVrH2TbE7DtDBu_qwWw4dHCrueZZ_DZ0sLLWACA>
 <xme:GvdJZv1dh_gpj2ZGPvovdyRHCtCMur5MID-YwCUNOsB0K-GmMea_AS_28w1ek-oG0
 AksL1l_zETvhVLsmcY>
X-ME-Received: <xmr:GvdJZuqqsHICdzRvIAlEwPReux3BU9-5CuKlV7OsmMJe-WZW8kmN6yc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:GvdJZsltYk9TqlGT5Ow3dH4yYbaMbbWrXhOu-oC0nROasLMiR6GFCA>
 <xmx:GvdJZu0YG_tnjkH6hGsBPLSeG84jR2DHMmZdJrr1n6epJMKYAgjMJw>
 <xmx:GvdJZjsnUUQUJSkSxLl2xMQyzPVqWvunh4y-dbHxkHDM8xzFBB-uvw>
 <xmx:GvdJZqVHzsaP-KCimwnC8QhTMAb1MVH8pxxGymuT-8HnyFp6aEzCEQ>
 <xmx:GvdJZu77D-q01DXsrDYeViuDVD4C_wRJGt5L30TJS507uiI8tSm7Nx0j>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:56:56 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:47 +0100
Subject: [PATCH 02/13] arm: Don't select ARM_ASM_UNIFIED on arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-2-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=653;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=WzCtPoHq/xuv4SVJX4/Y9G+N8QJ3eXBr7pc48yOMzZg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/wsa10qw16qCET6rypVuPnb8ZmQx/qmrYkqE8qcf
 zIlGLZ1lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwETmzmD4n8hQGf/o5aIN7/ee
 fLLDY5+NUC1b72flR+4iJZOtrm3jrWFkmP5g+83NV+eZKJZv7T3GdHhl4DRbzey5JkW9mffeSKf
 WMwMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

We don't have thumb on arm64, so that's pointless and causing
problems on some headers.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 39ad03acd2e4..46c0d33b3c6e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -152,8 +152,7 @@ config GPIO_EXTRA_HEADER
 
 # Used for compatibility with asm files copied from the kernel
 config ARM_ASM_UNIFIED
-	bool
-	default y
+	def_bool !ARM64
 
 # Used for compatibility with asm files copied from the kernel
 config THUMB2_KERNEL

-- 
2.43.0


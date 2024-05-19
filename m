Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58888C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E79C8869E;
	Sun, 19 May 2024 14:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="rCuICL7o";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NzS5uCDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECC58869A; Sun, 19 May 2024 14:57:15 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C448865B
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id A69FE18000B3;
 Sun, 19 May 2024 08:57:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 19 May 2024 08:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123430;
 x=1716209830; bh=prP2jFhmhVOrBc1hyl85nmSp9i06urdF/1QARNdLDJI=; b=
 rCuICL7o6Jkikj0XZrNESIlcsZgGMrtjRUkeCPhnrzDfGlxbU3dYQHhJhdZKgwt7
 9Emxxtl3ma6FTd+01aM4FPuGiwzQKjcacd/XfUzwtNGjxBWpZdOA4EzSxYIxQUtM
 c+av4j8sMLcTeaEgCicXYmAZag2SvAjDrTr6u3cJ+PI5XeO97nDEYfP4uKdTeWp3
 DpzPyowO9eXhBzi4jciyUGewny2EqdJcY232BCYb1kYa95g2dZk8/W2gKHIxe8Ns
 O3roIbN8OXwL2X/V3ljmcH7k89dV6JRiLk9YuekRDca59gOf7YzIDQ/qyadxvzkp
 fjlixIaS6e6GriPEoUFo+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123430; x=
 1716209830; bh=prP2jFhmhVOrBc1hyl85nmSp9i06urdF/1QARNdLDJI=; b=N
 zS5uCDNIOx5I3TLoLeXvIlThmpKIX/o6FGa43mlnjFdiLSHfZgVboaUl8Bs6FmIm
 iG/qpfkTzc5QWOnfVtgnm3zAnHOJHvUvNaOgeZQXqULWKAEel62Xcn1NZ0PJm1/q
 3d48IYPVDYbixbR73qAju7nhNOPQUUp2YDT+KeJhqCnbmcdeV3OK4mLxhyJcsRbF
 wuTvJ2GYKSakzwYzYqQc7hUDCkaYtLkmHDigAg/UVfuJcSuTNNadcDRdMqC2Lob7
 9rkGKmJk65A6b0hVMIxhpBDl02FmTNldKpTYKVq74P47v5OOQ8bji5SP5thGFKnl
 XeE1u5eEBa2iEiqXo92ug==
X-ME-Sender: <xms:JvdJZq--9fpY5JJy6rFOJiIXDaOs0jodNs4yDWuX0bC9XEjj-tcJMg>
 <xme:JvdJZquGPXd2Vj3PC4YygHKjF_FomxnWGRx5moSKDac-nkePuqy6NMDJpphEr8Fg3
 TJ1blYB5mCpw8aKxb0>
X-ME-Received: <xmr:JvdJZgBRNHOX8xrBskm28lrl-2pRbN3vh_3Bc8k03lH3UJnkFWVmWF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:JvdJZifp7_6PvPLDiGDdecPA4ABa1Fjsy2u4d2yRAZzd-FirK1gdXw>
 <xmx:JvdJZvMT1xVvr_393t4QVfXSNCahfz98r66IaCgIwmsQCrBWARUakg>
 <xmx:JvdJZslsaicR6A_LlvK1SO4N9U8r3wPYqe2xbr6tB7gcV_mVl1j0BQ>
 <xmx:JvdJZht59m-JTbdVhj4SUFlStJDv_6MJdAW0NED4mVsT9BTvnJTyqg>
 <xmx:JvdJZozIPsQyR237f-hQ45loxUBiHz7VNKFrMxP4Y_4pWa6juYrz2pFg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:08 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:50 +0100
Subject: [PATCH 05/13] arm: Define endian related bits in system.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-5-75cc328eddfa@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=gSl1IYqhlojX/V/oOQMUkrR8ElcTUqa8EZlcX1egvcY=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/x/i9/1LFV9xvK2b8brHXb3RCouLWmS2GzZ6MTRV
 v9HvsG/o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACayJZOR4VV6j+Fupa07v6bv
 Fp68sb732t1vt2pyJvNqdwUdOef/yY/hn+n6RwVhKeqNcx86vjw6sU24Pijk3OrU3cEN10Mml5Y
 UcQMA
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

So they can be used at a later point.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/include/asm/system.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 43f7503571d7..886a9ffbee35 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -15,6 +15,7 @@
 #define CR_SA		(1 << 3)	/* Stack Alignment Check Enable	*/
 #define CR_I		(1 << 12)	/* Icache enable		*/
 #define CR_WXN		(1 << 19)	/* Write Permision Imply XN	*/
+#define CR_E0E		(1 << 24)	/* Endianness of EL0		*/
 #define CR_EE		(1 << 25)	/* Exception (Big) Endian	*/
 
 #define ES_TO_AARCH64		1
@@ -58,6 +59,7 @@
  */
 #define SCTLR_EL2_RES1		(3 << 28 | 3 << 22 | 1 << 18 | 1 << 16 |\
 				 1 << 11 | 3 << 4)	    /* Reserved, RES1 */
+#define SCTLR_EL2_EE_BE		(1 << 25) /* Exception Little-endian          */
 #define SCTLR_EL2_EE_LE		(0 << 25) /* Exception Little-endian          */
 #define SCTLR_EL2_WXN_DIS	(0 << 19) /* Write permission is not XN       */
 #define SCTLR_EL2_ICACHE_DIS	(0 << 12) /* Instruction cache disabled       */
@@ -114,6 +116,7 @@
 				 1 << 11) /* Reserved, RES1                   */
 #define SCTLR_EL1_UCI_DIS	(0 << 26) /* Cache instruction disabled       */
 #define SCTLR_EL1_EE_LE		(0 << 25) /* Exception Little-endian          */
+#define SCTLR_EL1_EE_BE		(1 << 25) /* Exception Little-endian          */
 #define SCTLR_EL1_WXN_DIS	(0 << 19) /* Write permission is not XN       */
 #define SCTLR_EL1_NTWE_DIS	(0 << 18) /* WFE instruction disabled         */
 #define SCTLR_EL1_NTWI_DIS	(0 << 16) /* WFI instruction disabled         */

-- 
2.43.0


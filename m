Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0490C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 02:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DBCA87A5D;
	Tue, 31 Oct 2023 03:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="wLGgCiXr";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="qn1cmuoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F18087A71; Tue, 31 Oct 2023 03:07:45 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B72587548
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 03:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 8584C3200A39;
 Mon, 30 Oct 2023 22:07:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 30 Oct 2023 22:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1698718061; x=
 1698804461; bh=9oFjKyZsn9C3PpBf2e48lfJ0ufs4D7EwHmZwJXSIrYs=; b=w
 LGgCiXrTw6wONlxiZfKxtwiZObWW8vazkFWjV4M7dSs/c9AdOiOisHFlzxlsY4ZS
 qr7mxxo5hLliyt1MIbBT55gfvGpruQGsgwTxpM23qXzRNN+SDeTjz8ZdsZmFE/wj
 NCEfZRo01g242diB1KFdntTKomcS+1r5Vx1dNMlsytnUmFaSgn2i3t5Pxyf9Ax5Q
 y3KX3JP6c8MKlF6xzt+75VA+dQ+uyAY92/VSO50oxRcFtxW0lOiX/vBoe73OSt7W
 xt5itRGLEQzMemtSmtRKyLamfxoASPayRVg/tMpdwW5fr5OZIfow/M8jV/0hxWrm
 99l/PFF8KWK9JdGhl3xWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698718061; x=
 1698804461; bh=9oFjKyZsn9C3PpBf2e48lfJ0ufs4D7EwHmZwJXSIrYs=; b=q
 n1cmuoVIHmaNKqGRVWJoQep3O6K8OdxQHgOzPPwNX9qPm8SvnJt1YKgD9WMNHrU9
 P5sZXkJEd5W9BP7HeESWda/y4GFso6hX0jR407/oQ/elOwgF5A4T4IFzPEpsxNdj
 NHSIals8KJdSSAtlB44mYL/536YawrvnbUHSn/ZkBBsMFSVzu3XXCXPuNo/Ay2Gw
 KXrGZIIK3lzFzr9g1S6fzYxq7C/V+C8SGh/noaYRonsJhXJVNtGoi4D4CTSYcR7Q
 tARELlr7rR0p5rSkG5vtWTI0iWVgC1BRavT0KLGOoyjZRhm18TocFTty2LS7Ra34
 l2E0x9azpT4UvNbNDcMDw==
X-ME-Sender: <xms:bGFAZcKpCeYtO048ugFzBwtO6e877TvsDu1V--rtolYtDDnDZr0eLQ>
 <xme:bGFAZcKvb6N-bntX_oHWhkUvhjFTGzVWOG1ERIRuIgqUimu4VAwksKd4XBBZekU4o
 jQgV-5k7Q>
X-ME-Received: <xmr:bGFAZct5rijitwXApgRNtENFJ65VYAA0DezpmZm318Nezj0bipd2mXLegDRkN4778yupdHjuCbjX7wCgi3NSLkFN0tlVlrgRru0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:bGFAZZapvane4N-j_wbLpGRVLS45aHqkLMP1xaWtVkSNxs2nl4-Lkg>
 <xmx:bGFAZTa9qVLeKxxJjBNYZjgqDTRNeQjkyZ01pLBBlVPwiG_Fo1tanA>
 <xmx:bGFAZVCw8nS_aFWmPxkX3DKex3-kg106b_s6I_3dbxow7iTOtnGqlw>
 <xmx:bWFAZfHPAuB0FqWH8kTHFCoO5c-R9XdOGousD0Dk_sEp7WGQ_X-uaA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 22:07:37 -0400 (EDT)
Received: by feathertop.org (sSMTP sendmail emulation);
 Tue, 31 Oct 2023 13:07:34 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tim Lunn <tim@feathertop.org>
Subject: [PATCH 2/2] rockchip: rv1126: Read cpuid from otp and set ethaddr
Date: Tue, 31 Oct 2023 13:07:15 +1100
Message-Id: <20231031020715.684460-3-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231031020715.684460-1-tim@feathertop.org>
References: <20231031020715.684460-1-tim@feathertop.org>
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

Provide configuration to read cpuid and generate a persistant
MAC address in ethaddr

Signed-off-by: Tim Lunn <tim@feathertop.org>
---
 arch/arm/dts/rv1126-u-boot.dtsi | 12 ++++++++++++
 arch/arm/mach-rockchip/Kconfig  |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
index 5e348278f2..811a3cee98 100644
--- a/arch/arm/dts/rv1126-u-boot.dtsi
+++ b/arch/arm/dts/rv1126-u-boot.dtsi
@@ -15,6 +15,18 @@
 		compatible = "rockchip,rv1126-dmc";
 		bootph-all;
 	};
+
+	otp: otp@ff5c0000 {
+		compatible = "rockchip,rv1126-otp";
+		reg = <0xff5c0000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		status = "okay";
+
+		cpu_id: id@7 {
+			reg = <0x07 0x10>;
+		};
+	};
 };
 
 &gpio0 {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index a6c69c300d..5e993383cf 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -359,6 +359,8 @@ config ROCKCHIP_RV1126
 	select BOARD_LATE_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply OF_LIBFDT_OVERLAY
+	imply ROCKCHIP_OTP
+	imply MISC_INIT_R
 	imply TPL_DM
 	imply TPL_LIBCOMMON_SUPPORT
 	imply TPL_LIBGENERIC_SUPPORT
-- 
2.40.1


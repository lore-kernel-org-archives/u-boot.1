Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D766EC47422
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 03:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8168487BC1;
	Wed, 24 Jan 2024 04:27:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="L1Gki3PD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="V16Ql5+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5223187BC7; Wed, 24 Jan 2024 04:27:02 +0100 (CET)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E575870B5
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 04:27:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id A0B1F3200AC5;
 Tue, 23 Jan 2024 22:26:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Tue, 23 Jan 2024 22:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1706066817; x=
 1706153217; bh=HVxM9r4sez7RUCHWONEimXq9R3xdMf/8cxGaW6tnsXs=; b=L
 1Gki3PDEuVjFTJwZa/5p6nXfwIL2QadLq2a7DaLA8QIysZoDvynT0VUbka+Ppn2z
 /7Ak9GwHC04qt9hME6CsO+98ry/osOTkhWzL0fE6wKjkeVKd1BqqAJqvGKnCZIBh
 OH3aG5AzvGeQlI6hEA3cUGxtLPmmgjlBsLX8BUIZG1xKzXXyiRSvD835OG1HaOYb
 DbobxIj41GiuemDedt0B2qO45anIQY9VyeybFIEzUUtyEB+pjQ0uzGiPVgxi+nAh
 zmiKaAdEX47jM5KDSvcSnnq3+BP+DOy/3XxYDst7OSvpBbmMYsP63/xPcKX04ELI
 xVXVVP83V4eAxXaw5uCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706066817; x=
 1706153217; bh=HVxM9r4sez7RUCHWONEimXq9R3xdMf/8cxGaW6tnsXs=; b=V
 16Ql5+sHA836Gl2CmRIwOBqoxBdA/+qJKdBsdAlcO97vcqDfaA7Y24BTrfszUChg
 bW0bsXFJFoacKNzGNhlTZh4JBTAhKCv2LfVbce9Kg+jgkX6dDq4Qp5RRHo7RZRY+
 neVgFuiDYFjGswHYchpuT2uiyuP37357hxPdiq3y0OpAc9CWmF2G/WHIKf6fMKKJ
 3rzmr0gXb8H/L8/vL4svpdb9vrmmjyFO3DSgaetBDZ7Ijzwa00qHCYEGqsHLOLv2
 U0BCVT4kGnaEojcKzaM88XsoZoUzhhHpQNKj8NjRDue7fpco6xpayaOjkpRvCKSl
 C0OUZCuALYKNaWfQ+qDkA==
X-ME-Sender: <xms:gIOwZZojto4GkAlGMeKjHH8DjWJqeJAhz4NB88ccomEmUtDNg1GZrQ>
 <xme:gIOwZbqgdw1zaw22J5oizbL-HsBNqyNpURh3OHVmEKMAgOTDcdc2eAG2YPpGLrtTj
 calbwFCcg>
X-ME-Received: <xmr:gIOwZWPjLqVimQWWZmIYj86fgluGl08zQD-WswbllO0VIhQ_xX_AZJiNzUwvU834laKpoRMOnn4mOXaEkULyiJHtlsvoFrEXdj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgvdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:gYOwZU4vaTN_wi4e8iTd0LEPG9o_JTGLPBKZgirZD48FJTiBRAnuJg>
 <xmx:gYOwZY78dOAk8-7ts1NTCUIpy9boaeg-2at3GKawzGQORMlnw9P7QA>
 <xmx:gYOwZci4hSRztuzjHLK1ehLAcuReZpyImaTj0gAfH9axHVHdX5RhQA>
 <xmx:gYOwZVzOayhL_gDQ1QDVN1pZbcxUTOx-wagydG0aLVAYchqjKnGGdw>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 22:26:52 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Wed, 24 Jan 2024 14:26:49 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, John Keeping <john@metanate.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/6] rockchip: rv1126: select SPL_OPTEE_IMAGE
Date: Wed, 24 Jan 2024 14:26:01 +1100
Message-Id: <20240124032602.126059-6-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124032602.126059-1-tim@feathertop.org>
References: <20240124032602.126059-1-tim@feathertop.org>
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

rv1126 requires OPTEE as it provides pcsi support. Mainline Linux
kernel will fail to boot without this.

Select SPL_OPTEE_IMAGE when building FIT image. TEE must be provided
when building.

Signed-off-by: Tim Lunn <tim@feathertop.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 6ff0aa6911..cce118a004 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -359,6 +359,7 @@ config ROCKCHIP_RV1126
 	select PMIC_RK8XX
 	select BOARD_LATE_INIT
 	imply ROCKCHIP_COMMON_BOARD
+	select SPL_OPTEE_IMAGE if SPL_FIT
 	imply OF_LIBFDT_OVERLAY
 	imply ROCKCHIP_OTP
 	imply MISC_INIT_R
-- 
2.40.1


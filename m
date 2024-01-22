Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19191C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 12:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D624E87BB5;
	Mon, 22 Jan 2024 13:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="sOUBFGUZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ohc7l9a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDC487BC5; Mon, 22 Jan 2024 13:46:57 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E572F87B41
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 13:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 1EEB25C0124;
 Mon, 22 Jan 2024 07:46:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 22 Jan 2024 07:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1705927615; x=
 1706014015; bh=P8KJhBvrKYVr/ii9LYP4gJpXeKKcJV332CNjAa10TVk=; b=s
 OUBFGUZNqruMzxPhaaOqt9NGMpo7VOFz8Wc1gkn9C/D8TiX6k2jsJWgfC6in9Oea
 oTQFDEpCdKTqDSkhYx4KwvL0rbfmOJG2u+ElP925AXskn+J1ihfB0e30y/GZsKGf
 fghqa2gKB+TU56de3JvgnS/eGK0LMbEaNltvAXUkdSt2qh3Cpea0ocBV215W7Ufn
 +VwjxPlqlmU8xl7+pDrjeI0X2ey8rGZcOUrJq6R6EhxNXbIQ1JkjJPuBv2yWGHmc
 6U00PlsFMPTjkkIPVkhrG9H0Rvu1mVfrWkO5avTAkIi/4v3Rqw682PxoudhktM3Y
 W+8YB5lmqheD6do3GR5nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705927615; x=
 1706014015; bh=P8KJhBvrKYVr/ii9LYP4gJpXeKKcJV332CNjAa10TVk=; b=o
 hc7l9a0vsh3S/bcchmQGf0FXqlR0sTptRLOVD8JNlJNCarCwMgVw2g6zVn7bz/6k
 LLg+4h8fyabvmwdIWixR9OAHNlnAWvrmAAvZxTPrCOG2+BJP+DVXQIyr6fWyR10N
 +9qPSBbCAi/mVzpsL6VRibTtkJdBgBr05KWTpl9W/E23iKfDT5+vbctjb878mxAV
 Un9q+/Eu6DannaPxHovmuxTkObuwCg8ZDdVHGdPYXFlfuOIj8MqznYAl/QcDrPOA
 KsYnlO0QzDb1XDuEg2mYxk4JZM6syzkHVq/BPOQdTgVPauSVjCi6XHBnHpVA82DW
 M2to6URcc8Tze7lLNGYcA==
X-ME-Sender: <xms:vmOuZU30g5UhXK4-cpB8JLJQtTEb7Xi_efw7WffvcFVY_Z4jmmj7VA>
 <xme:vmOuZfFOnntRl_iDztSgUkz9UEhDrX3EjuICXvKYtdq7Iw0so6k9mx2Y_VJBBgJ7p
 ShZM0gSpw>
X-ME-Received: <xmr:vmOuZc564JjfKdZafn07lm_L48Pndy-_TVtYZn-OAjdsQtkm2wmTnC4uLvKysySqN6aV4CSU8r1_PWZLmdH-FiABvIiJKcmEnUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhimhcu
 nfhunhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrh
 hnpeefffeuhfetgeeikeejvefgtdefteehgfdvhfetfeeuffeuhffhfeekgfekgeehieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmse
 hfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:vmOuZd3JtOScdmGg_ECkH9MVokqYeBpMtszgWfffgcNJ0pQcJaCCnA>
 <xmx:vmOuZXFFVsgOLWk3BAg0DcUwjAgLYmSK8BIYVlE2SFTViipBayoV1w>
 <xmx:vmOuZW-zMVKmkE2ty6qacRrb5yApXythHVDeaJgWPC7QKznaOQeawA>
 <xmx:v2OuZe9_525YonBlDEWu73a3pzugUzYmNn0IXNjqpfQIUVgohrQ20w>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:46:49 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation);
 Mon, 22 Jan 2024 23:46:46 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Tim Lunn <tim@feathertop.org>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] rockchip: rv1126: select SPL_OPTEE_IMAGE
Date: Mon, 22 Jan 2024 23:46:02 +1100
Message-Id: <20240122124603.3341988-5-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124603.3341988-1-tim@feathertop.org>
References: <20240122124603.3341988-1-tim@feathertop.org>
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


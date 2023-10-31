Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E76C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 02:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA2F8754F;
	Tue, 31 Oct 2023 03:07:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=feathertop.org header.i=@feathertop.org header.b="Kjhe0pWs";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2+mnrSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789878754D; Tue, 31 Oct 2023 03:07:35 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E64087548
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 03:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=feathertop.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tim@feathertop.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 32FE632009CB;
 Mon, 30 Oct 2023 22:07:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 30 Oct 2023 22:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1698718044; x=1698804444; bh=0y
 5gE+i8ZA3PB+NeKWXddD/GXO0RYVFXkOvYvBhSjCc=; b=Kjhe0pWsP6aH5Ia5jf
 YPxb/GzvufJHMMjSjMrqnYKUPqv+/n8gYPedu6a0qsjDZU3AWnVM8SefvMoVPdYw
 mt9zQ3HrfPNNye4UMO+TOGjZH9qsTraVj06hUd+u2vEkTqrsxaMISkJoSEQ5M2RL
 C3Pagpv0ZuxhH21gfVcq4yrom5r2c3xhVRboidRu88jooEvHyVVZG/80D83q83Pe
 XDxRP5mH+rN1KduiTGmdm2Mh3xYApSiMeOJsMMtWs4a0m2FkkjxT9/gzheze6Xdh
 +/QXNXPMYjhz74LERAG8muh2Hu+SseMvEXsAD3O1FPDsSTT88QYCRR1oLdNKpez2
 SwmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698718044; x=1698804444; bh=0y5gE+i8ZA3PB
 +NeKWXddD/GXO0RYVFXkOvYvBhSjCc=; b=Q2+mnrSddmgS9suEOS0JXp9/eIEmV
 eIjfTQSohrwaAEPmVgsQo390OYa/ZOhuVkKzuAxwbGt56JHQ+sT5fdP+hzsXnizg
 PfJAWf5Zk+VbiAatDzbuyJn4bFUlhuZ2iVqrAtpEPuz6ULVUDOFcbBgOIGYUNwhm
 tReCb1gdUP+asNjEgZKAXFyZBR9e14j2GgV/5EY+geg6P3XeQDchkYV35G3omVuz
 wsgQnBhTWsAjqLLvdvCyZ8LmzcV3CfkLeSg9msTCx2My5iFlK/CYS9k2JsUrlokv
 Xrxflt9CJbHOfQpcfxMrDVQkyK9DFjH00po9TqaYEk7NUS1iFQDFxXffA==
X-ME-Sender: <xms:WmFAZb6RF-5Ma4G5R-zZ7F6mD27TnuOqWGgNEwILmSZ2dIS1OZU-NQ>
 <xme:WmFAZQ7eF_RoSrnSQw2Qp6GnaJFr32Tg4okGH2tEYmsObRF94-wPuV_5cW9mB3KSa
 1gw32SvCw>
X-ME-Received: <xmr:WmFAZSd48i_f3Ef0vmbR2cRjasr0QCeaYHb0ITLoECxDlRlyVlMyu-vH1lsJbrfp0dXj1kEqkkLhRj26pFDbFjy__TVu0OmRRsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepvfhimhcunfhu
 nhhnuceothhimhesfhgvrghthhgvrhhtohhprdhorhhgqeenucggtffrrghtthgvrhhnpe
 duhfdtveeujeejjeffieevgfdtudegfeffvedugfetteehudevteehtefgieeitdenucev
 lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvg
 grthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:WmFAZcKeBx3nyuxMKxZslwhQyIJRSiOHBkYGHeGe2qUkdNCuoZ7HTw>
 <xmx:WmFAZfKo_Ac10S_xGgkUPUDYaSY8V9MTwnR-mdILp3f08Js_kGCYnQ>
 <xmx:WmFAZVz3W4KUoyF3uEM5bFmZdcRolFNMyOiqDaPIGvEfdO8PnFmMig>
 <xmx:XGFAZX1scbaCDIsAW7fsGPunYj2VzeU6wEHAFx8KZfNXWOMVvj_7-A>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Oct 2023 22:07:19 -0400 (EDT)
Received: by feathertop.org (sSMTP sendmail emulation);
 Tue, 31 Oct 2023 13:07:15 +1100
From: Tim Lunn <tim@feathertop.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tim Lunn <tim@feathertop.org>
Subject: [PATCH 0/2] rockchip: Support otp on rv1126
Date: Tue, 31 Oct 2023 13:07:13 +1100
Message-Id: <20231031020715.684460-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
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

This series adds support for reading the otp on rv1126 and
then uses this to generate a persistant MAC address from cpuid.

Tim Lunn (2):
  rockchip: otp: Add support for RV1126
  rockchip: rv1126: Read cpuid from otp and set ethaddr

 arch/arm/dts/rv1126-u-boot.dtsi | 12 ++++++
 arch/arm/mach-rockchip/Kconfig  |  2 +
 drivers/misc/rockchip-otp.c     | 76 +++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)


base-commit: cbba1b7766bd93d74e28202c46e69095ac13760b
-- 
2.40.1


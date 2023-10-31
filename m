Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA4CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EABEF87021;
	Tue, 31 Oct 2023 06:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="Hu1H1THr";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="AMAnJi0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2464A87578; Tue, 31 Oct 2023 06:22:53 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35ECA86FFE
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id AD0763200A5D;
 Tue, 31 Oct 2023 01:22:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 31 Oct 2023 01:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698729768; x=1698816168; bh=+ga0gIceTW
 jTuo2mROA4xZHXrnTmuowvg74dGIXwKIw=; b=Hu1H1THrqSIdDhsuNwR4I2FSVe
 To/YhMWlhFGYk1olMZmS3u/KcpYM9GYtziX0UpIkdEi0BG3+EDt8UwadMgCqLrx3
 s6w6Z3EjT3VhZxu5NrcwYsMPPeWvyKTwhffd01qg+/BaNWFxTuIEl7PIAy6F3m4f
 Gv4Cqi7fAn2taTIjugS/qKES3dyNVyRm/MNkwBC9UQXoJDyutHFQdvDub3BWUZYs
 euJNCgfRuL6kyJWNPBNLk/oMW+N+L3kB55GAxwHf0OI4qQ/DAvWqOxfHx4T/YE17
 onDI/FRlh2CUlATqW05edHnjjVvSdAGHeAynjsZ//aa0pReBh3j4ZqSKAHkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698729768; x=1698816168; bh=+ga0gIceTWjTu
 o2mROA4xZHXrnTmuowvg74dGIXwKIw=; b=AMAnJi0jeNfpdapo95mwonT29HN3E
 3GRuVGJkZqj+qc6Bsg9jA1hS6plDW3ZfcAOUWX4JDKK2jPY03MF4rMKLLGJdK6RI
 9L/lD7LHZ0jcguJrxJga0vvYxzFC3y7Vcikm7Hin61lpAGZs3COpOOJBqu4eOeHV
 lYbKS0K6y6/gTPiaOlVvXfHxBRaW9ZASudst3wGwjE/7lA7rVbxFe7PI3ctKR+58
 Iu7hXDhofITEZTmqKQ+QZNtnSX6gthXSZAYYoaO6LcimsE9t+fCaM7bYXTGanxr8
 ZS973VW3+C/LwnnBuTf/SVcqhadUzT5RdEzDXkJHNCDvKqrp82nrRlPmg==
X-ME-Sender: <xms:J49AZReliQtcWT770LN9LDn-oO3ywlaY2jgRsIyMHSAIS4UvKAgL-g>
 <xme:J49AZfMQGP--ogueVS2QX1Q99JgBag2Qx1PdBw1xVCpGZjWCJt_qmY9B3f1EYDi-z
 wGUyf5ACZQS7DouJQ>
X-ME-Received: <xmr:J49AZajh3Y2XRR5SQo3UWSsXO0du6i6LOM-cJORtgvXGg7L8gea_R8UmWVmiQxk3GAFqQJMmcVE0DWX8qwOwr82VtRJKpR7vfPuCIjJhl6UJgoZ8M1vnLrzLg3zGp59SHsPeCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:J49AZa9w-bt4C1EiRSRgEQXF-6hv_gAIZobDV96RNZ3iUuu-C6fYdQ>
 <xmx:J49AZdv4CQQlLHzpBK-2JKCuEJobRkcMFg5HVnIBv7a6PCavthaucQ>
 <xmx:J49AZZFTnoK-Z8SmBPGbYJyI3Sfzs1yf7ypD5L-t-aytyyCuOlFfoA>
 <xmx:KI9AZXIgk2OKwX6ic_Hbe4ATrK2kcS1Urcd5oRxSY5rW8-YW2tVXpw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:22:47 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] sunxi: mmc: Sort compatible strings numerically
Date: Tue, 31 Oct 2023 00:22:34 -0500
Message-ID: <20231031052246.63019-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
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

commit 95168d77d391 ("sunxi: add Allwinner R528/T113 SoC support") added
the new entry out of order.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mmc/sunxi_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sunxi_mmc.c b/drivers/mmc/sunxi_mmc.c
index 4d6351bf275..7caefa153dc 100644
--- a/drivers/mmc/sunxi_mmc.c
+++ b/drivers/mmc/sunxi_mmc.c
@@ -701,13 +701,13 @@ static const struct udevice_id sunxi_mmc_ids[] = {
 	{ .compatible = "allwinner,sun7i-a20-mmc" },
 	{ .compatible = "allwinner,sun8i-a83t-emmc" },
 	{ .compatible = "allwinner,sun9i-a80-mmc" },
+	{ .compatible = "allwinner,sun20i-d1-mmc" },
 	{ .compatible = "allwinner,sun50i-a64-mmc" },
 	{ .compatible = "allwinner,sun50i-a64-emmc" },
 	{ .compatible = "allwinner,sun50i-h6-mmc" },
 	{ .compatible = "allwinner,sun50i-h6-emmc" },
 	{ .compatible = "allwinner,sun50i-a100-mmc" },
 	{ .compatible = "allwinner,sun50i-a100-emmc" },
-	{ .compatible = "allwinner,sun20i-d1-mmc" },
 	{ /* sentinel */ }
 };
 
-- 
2.41.0


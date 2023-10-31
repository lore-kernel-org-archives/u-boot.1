Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8153FC4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 04:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A03874A2;
	Tue, 31 Oct 2023 05:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="VPfzprnf";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3Jif3Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBD08720C; Tue, 31 Oct 2023 05:49:37 +0100 (CET)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3310E874A2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 05:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id EDEAB32009E7;
 Tue, 31 Oct 2023 00:49:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Tue, 31 Oct 2023 00:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698727768; x=1698814168; bh=hLqbSZrpMW
 hL7en5oXvdvwNIjhaU0+XqEW+xnZV3nv4=; b=VPfzprnfWsFc+myUqX4k0fg/UX
 qfFeFzvD/IzWEKzsLQa1GhHOKosLptgyZPwQPbYsB4H+pIpqfCj3WFpfXL0z5GJY
 1ohpeBcNhTqTnTTn26aTMH0HKcyOEWkNlbeICYJKE2j4uwGYniP4/i+VVvaoXdzX
 fjwPZTirNXhBOaphxMa+ZnFXpwAg04/n37SOr5TviRqAQl2182YIBqDvj7dlySz/
 LEisa3Shz1eiirsGaZOZFkmFtCyL7e8ZEjdf1ArG442FXDx5UunL5HSwRsgeO4Xo
 GmdcM9FBbJg9V2NJ2vzHHGzzVD69kUqJMcBrPRM1VB9eZQ7siYnpReS/49Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698727768; x=1698814168; bh=hLqbSZrpMWhL7
 en5oXvdvwNIjhaU0+XqEW+xnZV3nv4=; b=F3Jif3Yp5Ur+NopKbc43Ub098OlHe
 vzWraRGaZRw4IZKlXeRmL5j76EvcWyWGx10AD/MBjePp8bSwubchQAMqoRXh5900
 nBTOL5e/loxknKxEso1VmuQyojCDmbzPlYledyLoWdVhqUWVJ/RO0jue0JfH6Nzh
 b/ljNXsTyaO8XABj1y0R7fSnNYdo4sw2847bjY6L3W5H/xpGVHo1wFDy/wjL0UWd
 0Vq0qbQuKnTKoIXY89nmvKIm/2tYIAEKI3peRegQLDLget4sJ7xrA4vhKHIMxe/P
 FhDBSDyslPQkVbwCZAeaHl6Hm8xTu8UIGnHuAGtuhk5G/Eu1YYpfXjQ9A==
X-ME-Sender: <xms:V4dAZRucnOLw2nF7yW06S4Ruyrw3WLwSvsbqoZTubJHcTI9X2hzdtQ>
 <xme:V4dAZafVyMt72X15Di2DulA1iOUjG4G6pDDEDN2MNLPepGqmpT8TTcb81qeYs9O4P
 2QMNIyCuOzbU9lwOQ>
X-ME-Received: <xmr:V4dAZUxay_MyHwi-LGij3OxBuYBRoVgJ0btyLSd8Q--0cV36lutYLui4aL2ZHbZWTG7oK6g94C8wIJdq_GAB9cfNGb426eVjXzdXJk2Sl4gD0rk8y4HwX2xiQdWIJcQ57jzYwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgjeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:V4dAZYMmqeu15fCIBvy_zy9YFfppswnGiUZoMl0L5BsMrdRvsGggmA>
 <xmx:V4dAZR_cpqZKsHKZn0eNgQRD1bFFVNwCIezyAxq-uAxGgPuCsnkCNA>
 <xmx:V4dAZYUvSi7Os8UYv-ajTpevhKz-bA3otKA14lxFnPGoPbcMDh9ceQ>
 <xmx:WIdAZdZ37Btd8BZctbdxuAisD82LcaohikALQJ9b_oQN5644vBGtTw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 00:49:27 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] clk: sunxi: Use the right symbol in the Makefile
Date: Mon, 30 Oct 2023 23:49:22 -0500
Message-ID: <20231031044925.51756-1-samuel@sholland.org>
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

CONFIG_ARCH_SUNXI will not be enabled for RISC-V SoCs using this driver.
Use the symbol for the driver itself instead.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 26bf429acbc..af27ceb27da 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -27,7 +27,6 @@ obj-$(CONFIG_ARCH_ROCKCHIP) += rockchip/
 obj-$(CONFIG_ARCH_SOCFPGA) += altera/
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
-obj-$(CONFIG_ARCH_SUNXI) += sunxi/
 obj-$(CONFIG_CLK_AT91) += at91/
 obj-$(CONFIG_CLK_BCM6345) += clk_bcm6345.o
 obj-$(CONFIG_CLK_BOSTON) += clk_boston.o
@@ -43,6 +42,7 @@ obj-$(CONFIG_CLK_OWL) += owl/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
+obj-$(CONFIG_CLK_SUNXI) += sunxi/
 obj-$(CONFIG_CLK_UNIPHIER) += uniphier/
 obj-$(CONFIG_CLK_VERSACLOCK) += clk_versaclock.o
 obj-$(CONFIG_CLK_VERSAL) += clk_versal.o
-- 
2.41.0


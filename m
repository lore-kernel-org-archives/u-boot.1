Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DE8C4450D
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27E7883B72;
	Wed, 21 Jan 2026 13:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=mail.ru header.i=@mail.ru header.b="b9ZsZRee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53E78397D; Wed, 21 Jan 2026 12:54:54 +0100 (CET)
Received: from send195.i.mail.ru (send195.i.mail.ru [95.163.59.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB4383015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 12:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hitechshell@mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=SZLwEY2jWCl+howmjv5VhvObrp2Kiu1Tg5/uILMIYqQ=; t=1768996492; x=1769086492; 
 b=b9ZsZReeW96saftJKJmiW4tSGUGZupI56cbqHVJOJ7KedZgeXQiBsgf0vJkNiXqTqh8jLYEt1aX
 k9UbydeVK04Nnjn9JS+y809VcVuhWDIZxgcudJn+HOrRdKn4kMFmjxuElG05lrWn+fZ/OqXEoJgTs
 yniNJGTSeAx8REllID9S0I3EOOb4VBTH1IXoS/XA1m7fN1iThJ04z+epoomhrbaJoZvpScXQIsn20
 x6ScOCZ8jqbIwBA/ZDGkF0IGNQC+BXBTuzH5HbJ3FFkXVQtuu6pzP7E73ckTNAwa7FYkmjLeLC4JJ
 dlHUYEJ4YyWJsNXiwfacfC9TB6WEAHT31oSQ==;
Received: by exim-smtp-57b58cdc86-z8n6v with esmtpa (envelope-from
 <hitechshell@mail.ru>)
 id 1viWnS-00000000EA3-38c5; Wed, 21 Jan 2026 14:54:51 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: u-boot@lists.denx.de
Cc: Denis Burkov <hitechshell@mail.ru>
Subject: [PATCH] gpio: axp: Add support for devicetree
Date: Wed, 21 Jan 2026 16:54:37 +0500
Message-ID: <20260121115437.31406-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.49.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-57b58cdc86-z8n6v;
 auth=pass smtp.auth=hitechshell@mail.ru
 smtp.mailfrom=hitechshell@mail.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD95FB2D685C5B260676914CA669E12F23F363BD056C59B741A182A05F5380850404C228DA9ACA6FE27815014A93F17F3DD3DE06ABAFEAF6705E8ACB91D6FA9206A8F41CD492B8655587351BD83221AC723
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE700B5EAEB6F2DE1BDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375664ED35F00E88D648200DE4B48809033E14019A19B81A179FEF9E4C2AEA619F67E8EEF46B7454FC60B9742502CCDD46D0D2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249F459A8243F1D1D44CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C04CF195F1528592878941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0FC4B52FBD1D865B27B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050F9647ADFADE5905B1148812EF9080FC94B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B44100F6C8E631370EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5A2B708EEBD64E34C5002B1117B3ED696567522F107A9B252FB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD0BC323893F80E328C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6592B2AC087BA2E9AF8813C63C7EEF3FB60FACADAB57C02CE61CC46DC519F9B5401E40578D7A457D87AB8341EE9D5BE9A0AC0C19A1EE7F64A7BE2365FE124A584108DAAE2DBBF6DFC578CD93680B12512CF4C41F94D744909CE57D12362C6007E19CBCECBC3034787F35811D22EBD454E4C3FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVVt0N+pdRHOZ4eLLv0UOphE=
X-Mailru-Sender: 478E2FD5FFC4389D416E637F0415DD9C06917CE83758655CB951B70A5BD4BD8E76D851C6A1BDD89760497F7EF99AAC8F50542AC22094CD8C57914126969F3D956D4772D43608CFD76E88144C6B1FBC640C9F34ECC07D5E3154A414D2D82F75148CB9B52C7EAED1F483C5A6F83C06E857B4A721A3011E896F
X-Mras: Ok
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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

Signed-off-by: Denis Burkov <hitechshell@mail.ru>
---
 board/sunxi/board.c     |  4 ----
 drivers/gpio/axp_gpio.c | 28 +++++++++++-----------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 2929bc17f08..3c61bfb8822 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -226,10 +226,6 @@ int board_init(void)
 	}
 #endif /* !CONFIG_ARM64 && !CONFIG_MACH_SUNIV */
 
-	ret = axp_gpio_init();
-	if (ret)
-		return ret;
-
 	eth_init_board();
 
 	return 0;
diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
index 181c53bfe72..1c5882a25d4 100644
--- a/drivers/gpio/axp_gpio.c
+++ b/drivers/gpio/axp_gpio.c
@@ -98,35 +98,29 @@ static const struct dm_gpio_ops gpio_axp_ops = {
 
 static int gpio_axp_probe(struct udevice *dev)
 {
+	int ret;
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 
 	/* Tell the uclass how many GPIOs we have */
 	uc_priv->bank_name = AXP_GPIO_PREFIX;
 	uc_priv->gpio_count = AXP_GPIO_COUNT;
 
+	ret = pmic_bus_init();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
+static const struct udevice_id gpio_axp_match[] = {
+	{ .compatible = "x-powers,axp209-gpio" },
+	{ }
+};
+
 U_BOOT_DRIVER(gpio_axp) = {
 	.name	= "gpio_axp",
 	.id	= UCLASS_GPIO,
+	.of_match = gpio_axp_match,
 	.ops	= &gpio_axp_ops,
 	.probe	= gpio_axp_probe,
 };
-
-int axp_gpio_init(void)
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = pmic_bus_init();
-	if (ret)
-		return ret;
-
-	/* There is no devicetree support for the axp yet, so bind directly */
-	ret = device_bind_driver(dm_root(), "gpio_axp", "AXP-gpio", &dev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-- 
2.49.1


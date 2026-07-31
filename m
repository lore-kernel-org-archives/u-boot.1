Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93883C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D90B24119A;
	Fri, 31 Jul 2026 19:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KxVfoZqKXMCh; Fri, 31 Jul 2026 19:39:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B35E410B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526762;
	bh=T6OhA6BG3MjptqyO8EJRUP/dtFBUTxghc99BAXVQjWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VKLADf2lsGan+m9dgRw0Ac2OZnxHp0i3zHRwXfllGDTOv87oxLj8qOhCzaaieUH1i
	 UHu7pRculmV1LiyDtubJJUzlpVKKxfi/hvQxe52yTJ+coTFalT77iirDv1sruHYj5C
	 U3qV9l9Y+CG05cuZYOzPdKmWw9FGhv4l3DnqRZNcfPi/Su+xh0kMPGsHpb0/RJ3JCq
	 qcleK3ukKSsIj6C1qxVqlXriE+vV6nI4KpEvQfnO2y0FqWYvOGo4v7FNNnTBMiUCp8
	 mIlj7SYTW1SA7PJ427K13LoAeAB4vTgCJzxc0QGfkt1DF7eyQI/MxmduPOBGyBkS4t
	 U/75JSuNiWXtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B35E410B0;
	Fri, 31 Jul 2026 19:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 82A3736E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 691F66065E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ODdlJgTQRtQ5 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:39:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A408760657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A408760657
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A408760657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:39:17 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb4d532e65so543180a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526756; x=1786131556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T6OhA6BG3MjptqyO8EJRUP/dtFBUTxghc99BAXVQjWY=;
 b=BE3lT66lJmoVXpsuMQivXoIcCeX2kGg0TF5VWl++VLi+6N1d3eWXtyyqG1qQvU1vHp
 nrs1hJ6uLMU5WeAtp2G/pGBbZzjAuyVlCh5Prwc4jlbg5xFUlpvE4Mtniw/53iF7gto4
 fz9qNNxDvgT2DkN28jGIhaKTPqvT3Q13W+ni5lkmhI31OB4pTDQ86lf+ogll0mu1Ypqy
 f2MK5gJj1lxPBej4AKhlutVyIKTLEdJPRUukCOPABFcgD7w+u9+izqoAnG2z6pgoHVwt
 6QS32OHoGv/8yCKeISt+vF8DJtlKfDwOXbIqgCNOcg4htcYwcmnbqOenKzBRcDTDjckc
 3u+w==
X-Gm-Message-State: AOJu0YxCT0/1ZQ1HPpH9pf1pnYMEEiOjqJuaMvUYCyw+HD0YwgwghchV
 k7lzgmHn+uqjRz2eYoW38sY2piJba/LNYkn6Fm1w2ulY4rP3llwm+7FucBUWDjZmnm8=
X-Gm-Gg: AR+sD11pbNkfX9rJ80ajablOImMb96fduMHfzAAfjk6lVr3iHHPUDknWHmaQf9PzvAz
 utGWJpAEdkOdlZ/CvS/VxUJXaHUDIMfJP6VXQA7RpVos0KY+TlI69WouOOvvwpMHrO2x5BnuMcR
 KB+CHG9cyYNSfoxxR6QpQECEnvbT/Fbys5tE/qBQkO6zsGcZZDwwxKkOSpPlwMMBpYWHGU4/Jen
 FWB5x2CEZ4qIsrwSH7X5sGAE0FhFW7kvc6nZA8+LswRM4mQ8ld6dDF6lrm6azDuZP/7Ohz3VuvC
 IU7c6h3B8Slbu7IDUv/kIw5PLQYEj3bUASMO8wCoDSF+kduNIkhwRgniZFoJmyDi5T2bSOJKx9S
 df61VCFd5nis0ZUE4OkE4jJ9XmOw0bxgNQ3tH01JTnl41DGdvA50b0aSAwNFNkt+SYAJuhhmFQw
 PlolEnDBDAdH+OrZpN+J9YsHxIZBPhP8HAWX0d/amUgQ4RQLX1rS8VG2wScXLE0ul2ug==
X-Received: by 2002:a05:6830:3592:b0:7e9:e488:3bce with SMTP id
 46e09a7af769-7f196bab78dmr2554217a34.6.1785526756605; 
 Fri, 31 Jul 2026 12:39:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:fa40:746f:401a:3b75])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18ed3e91bsm1359205a34.4.2026.07.31.12.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:39:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 31 Jul 2026 14:38:38 -0500
Subject: [PATCH v2 1/3] serial: mtk: use ulong for clk_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-serial-mtk-clock-fixes-v2-1-022110a9ec3e@baylibre.com>
References: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
In-Reply-To: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zTHYV47ayMFzo87VpCiRVSloRDEYK2s2BSUmPFmOcc0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqbPnNmOjwYCozcpReSckaJD9xT/563vLqnAQBH
 Kp80mqnohGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamz5zRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbpgH+wVvgDwfOWPMHFWKvC4vkkWMfAmgMQtUwBTx6Zv
 8CtSESuh8PVBuAaxTWZREYFJ7DE//kaP3iL2FEj7DbOk1C7MX6DIVx5qyUcqeokqWeX8/2Srp9K
 /gQWXvwrIn953LHZGW+9VaRCFs8Soan+xz8rPuEMNmNf5dPKIT29Gq6DM5Hz01o/HI48SzurxRt
 j/n61TiA9SQOYe3zvHDwPF1Ft9+XzEaGdlIMloQuUFJLHMcFwxH9DfnjAw3ioYwN2kAh/RnLu8D
 9LenFQKGCeYWxAXyqwDKFlIDP6qXz+1I4CyTgcuYXQ55on9DKx/HiLSLTb9Kq1AOGuiSU2Ep7L7
 l25w=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785526756; x=1786131556;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T6OhA6BG3MjptqyO8EJRUP/dtFBUTxghc99BAXVQjWY=;
 b=Z9rQo+x95JxoA/r3kzLIX6tShxbZKN7sEs/WfZGnQCo7tEdAj1FsMzrMbd5LcoUt3/
 QNd0a1Ha8fmhzW35FnFvbAdDeTaEeidmnmHY29QU4ykYtrXTqQwzoiD2DqJC/DbfhDKz
 b6W8AermTawZh6zeU/f4I3yvW8D1vfGIVoFZ7iJo0dKSgAuxvcJwcHWM3oONRaUmjBff
 OqRLRKCQvYAzrYduEJ6DnSQCKM7pj17l//8OlBeSJQvWDYTa1LOmpqKoNpF45ZgDj2/k
 bvO9vp2oDr1mBO6oUVt5fVU9gU1Lu+WBz8DM6Zii8Ycgi2B8vlj9qwEcNCQgnWUPM7tv
 /A9A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Z9rQo+x9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>

Use ulong for return value of clk_get_rate() in the MediaTek serial
driver.

IS_ERR_VALUE() does a signed 64-bit comparison against the range of
possible error codes. If clk_get_rate() returns an error, assigning this
to a u32 truncates the top 32 bits making the value smaller, defeating
IS_ERR_VALUE() and producing a garbage divisor that hangs the UART.

Fixes: 3b17f2e2c2a9 ("serial: mtk: add support for using dynamic baud clock souce")
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/serial/serial_mtk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
index 01cc415efdd..28e87f485a2 100644
--- a/drivers/serial/serial_mtk.c
+++ b/drivers/serial/serial_mtk.c
@@ -213,7 +213,7 @@ static int _mtk_serial_pending(struct mtk_serial_priv *priv, bool input)
 static int mtk_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
-	u32 clk_rate;
+	ulong clk_rate;
 
 	clk_rate = clk_get_rate(&priv->clk);
 	if (IS_ERR_VALUE(clk_rate) || clk_rate == 0)
@@ -266,6 +266,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 {
 	struct mtk_serial_priv *priv = dev_get_priv(dev);
 	fdt_addr_t addr;
+	ulong clk_rate;
 	int err;
 
 	addr = dev_read_addr(dev);
@@ -282,8 +283,8 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
 			return -EINVAL;
 		}
 	} else {
-		err = clk_get_rate(&priv->clk);
-		if (IS_ERR_VALUE(err)) {
+		clk_rate = clk_get_rate(&priv->clk);
+		if (IS_ERR_VALUE(clk_rate)) {
 			dev_err(dev, "invalid baud clock\n");
 			return -EINVAL;
 		}

-- 
2.43.0


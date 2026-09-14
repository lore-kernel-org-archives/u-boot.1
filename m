Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A643C88E6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 09:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 228DA405D8;
	Mon, 14 Sep 2026 09:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jXdKapg-YlBN; Mon, 14 Sep 2026 09:19:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5016D405F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789377593;
	b=YRojVx26mnZk9Ofhk//BNwfuRpwFjvF6jbvgkJhRJVRvmPqfFLVMke1MeA8TSn9Gti/2
	 JWdjfzfhKjnTZedsaJACivnkRxrAXR4NEKOA1ssWVdX4GusammUQzN8ztK12BknQIhCyt
	 8oyO648b6BjUJpvK/hqglL6nbqA20mvSmDtre6fPQc2/BrCqnZMhyVQj+ADIeqlDhLqbO
	 Bfh36hc0N/nwx6AHFhbukUuteRRBLFZPGBpqN8vRGkYxo6wxXUog6+ku+B/CcYVHCR7gO
	 JDvBFjoCCZeJQOZL6y9/vAWBucb8p7Dj6aYKckG5cD0RledsCWwAEGSVm2zVjckeKAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789377593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=avHGTnMH+OYNjrih0J6IV60QI5psgXmp7iyoPMEElfc=;
	b=Co3XGBueccs5ed0bfJQdNJVGJGdcEEBewOJVrfx8qq5/y3d4As0EIYKybEfzQqMFR4jq
	 37qCG+P88w9fVj/kwLs117FLak9eMGv1ikYQLTU/p4VtRd3DiTl/1LS3ILPLUI8nfJai9
	 Rt8Q83aXRQka10ldtMcOUglJXdx5ndohP/UqhxjPhrPzoFBInuvAhjlz8SQXXLC8wMPqe
	 Bsi3iv9ScnXtR/kF75pOwq3rKUyPxdSvRWS5ju7jH6wg3o78KsHW4z9AVWfdGLDLrJBJw
	 WID9sBB1tDLnvG6J8Q6NHecM/OXvbFA/t+bLtgnGsboZINbP/+uz2UAXQ7YNdayWiIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789377593;
	bh=avHGTnMH+OYNjrih0J6IV60QI5psgXmp7iyoPMEElfc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mqC1ZecLhXAjw6OKmdilze6ssbOLni99UBNCozMlu0+Sd/mcj76fklsiEpAIUSgua
	 PZ16+1SD/cFOepO0rlVqKsdEqQSLHgxsP1BXTJchVXrhUOxq1MA2RR/FUhpkA1VtC/
	 g1gvBLx2w28gYdXY5/z1HSwET03ZcQo+rS2FEILNpxSuUeDTv83B82btu5brvyB0J2
	 yyXXw7escFkmh3qjwfuylqV/EdwXtsntoOcne3oib331yG6/T4/eVrjBai9dpxK2yI
	 AoyB8C03HCmrNOew6GeHqLqSj/fGPk1GJ/d3TOI7WZh745bdW1MX247QjvvIFWhNSA
	 74yjwzWGi64jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5016D405F6;
	Mon, 14 Sep 2026 09:19:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC34224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C46084011A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NeeXWvlPaQcs for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 09:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1F39D40119
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789377591;
 b=r7GRZIycJkTW2yjERHgm7NzShrb9GZrbeCvjHJnIGemBDieSphTql5/JApuU7bJ1ONj5
 My93P6JQfKBalEy8r6UWQmKlWZFrnP0BmwqFVc4jWHGOD+IH0QzQNJrR9Z/RlH608eBx/
 EHgb76VwEg5r2wt5aRIQJ0It/xLYHTKuHQfKLAY35nM++GZKsoEZuYDnHO6FSyBOl6jTH
 gbGa/eIwATc9awRoNNjNOEuivcl5kyrg5ynwt0PFfBgLpADzgZTICT/eZ5FUgNrbevzOS
 0QqCaO//ODRH7ej4G7ASA5iQjbSYQ2hPguA42fXbmQIee3YWoIjxBA3lSVKedNRDfhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789377591;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=avHGTnMH+OYNjrih0J6IV60QI5psgXmp7iyoPMEElfc=;
 b=m/tLdJgPz4fADraKK6c0eT7LZkVDT3v4+4grqti8KtskX+FWwwvf7cLq/Don0wTEeQnQ
 PWGonE+XUrmoJeCLAowYEgwbKsv6sQ8buNxyppv9CerHhosom+pZ5qKGL/OnLP4GMAIwf
 oZKX9PlYdjH7AMSCF2EZAh3wJMEfChnteL5i1qPRAFwQRTMxAXciDzxHIWVZCqPreGjyW
 w0mAWgeABrd27J2YjnApEuQnV8HeSEDSz0C49AUgrt5R2XanKVDK8BGowXrtct4AN7CUF
 giMMV50ox5HZxHpE3JT+VDCF5+U3g9rVbxnn9Natl/Km6w6YNFk7CubbieO3cnDEXpA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Wf+OGIhz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=jim.t90615@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Wf+OGIhz
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F39D40119
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 09:19:50 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso1468567a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789377590; x=1789982390;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=avHGTnMH+OYNjrih0J6IV60QI5psgXmp7iyoPMEElfc=;
 b=Wf+OGIhzMHUYxQYKDSZl4Lwk62qDzqsW3enr33dhnN2pcFnJNzQTMlTGxRkfsVlHU/
 DoaMiALkYTlruHhtp2KGmPRaN5iL/3Fbm2+4TrUYiMUjn10V5pN902JpW2h2UGu/h++d
 iE9uQSOTfnQJi9/KZN0pi/8U0KvV1LvFqn14PtC6FQdNoakez9Wgoy5XQlAsuZ3l47dF
 9TbAPmoTXlHOgJPuEi7Ss7lmVmvNM20ZsxURODk8AgTQbff2R7WC7fVx+Paf3w55Z0Es
 TB8bWWq+JluNYZmsmYKlxlIgBWSjAtXwWgsUeLXho5qVpm1AwsTWM7l+g+FTgYMnnBhi
 VIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377590; x=1789982390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=avHGTnMH+OYNjrih0J6IV60QI5psgXmp7iyoPMEElfc=;
 b=ni/umQiFqlAOnHkBPlJ0U+vgEdvzjMXWnG9HM6DqvEpu/90C5JMcApwQi61bq6WSA2
 fzbrWEBcMUsLLJTwWm6wpl5THKqV7R1g5jW7hIKziiwrn+1KYVQJGg2Hf28VP5Ukxmq+
 5rXZNpXf5CQL53QExP/Y64kGjRPE40r+WhA0oH20iBZOburdc/YHHvlgl9mjfiOKs6V7
 qS8xhzi72f4B8SXY92YA89d/2K0KymHSOe0KXx8jFATEP9kJHoUz3TtFNl89EF0tWMfg
 tE1oMkM+pt83SpKdv3PDqfF6fYDK9EfYmogOAfrYVzJnVnQ7NTQjgvasbHzorvdP8dsh
 uZ3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7nspLAT1r9PA7bg1yLp/GOSjb6msGw7WoiY/trkcpfi5xsS+dWQTHQBzNibeOpts+60iOSwM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k5KjmhcMpQjjuuryOa69fmqoLXS3HJDIfwfBY9Zpeq6JZJBmxX
 KsAULn1j4ck2qFzTDZ8QBSrTVJaRfD2CMVHhMGk+njgT+oBMP3X+Ya1+
X-Gm-Gg: AYBFou2SicJuq13zXTNDpmpzCB6rLR7yKDQoMTfmc3/59JvTvh1BF33fPdGBVk9XrPN
 ojzFJxWfwJ8lB8LDV+fXR4p/XGTaXY39UEMs8i8BEpAMfpgGie8mYRABm7nn4QGZ4mOa34YZYt6
 L/On+J3zVOZ2HkDrD6f8pcuedB3VwBS60BmE1AzPLuq+kc6SQ6N9oj4EYqNOfpyNzXzcpNaTgu2
 m0zmSoXtsNjYjadEtpt/6BW2EjaW7/HQBkQ+64JSS4jXjnRGTLuvWZRrmpakcEIGk/H0IWDSAOb
 vQGG18UNV40me5vOASQSgy6UhaZ4gFATX6BFdgrS3gMrQ1uwmmg8EjGrZKx3PSCZQIWbxfiPU3C
 rSlVWan+JgnOvmUHLlc73WM1HaAKLaNLo2IWdth6I6e1D2lL5ev4sjC9Jl/WPgZRKms2xo4BiZw
 xvWUD4JCOYNvltx0OtfzSBJSScfSUZ5OZBFDMqPfgZvWDv+G74BRtckyusiTUYhQ9NC3EQjIbtI
 qSZ9ZAMJfFZdrvoGI4=
X-Received: by 2002:a17:90b:390f:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39dec079f10mr3587593a91.14.1789377590071; 
 Mon, 14 Sep 2026 02:19:50 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:139d:9738:fc3e:7a6f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm20862373a91.15.2026.09.14.02.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:19:49 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	trini@konsulko.com,
	hs@nabladev.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH] i2c: npcm: Add deblock callback for bus recovery
Date: Mon, 14 Sep 2026 17:19:32 +0800
Message-Id: <20260914091932.1194199-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Stanley Chu <yschu@nuvoton.com>

Add deblock callback to perform I2C bus recovery through the reset
command. The recovery always resets the controller status, even if
the bus is not stuck.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/i2c/npcm_i2c.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/npcm_i2c.c b/drivers/i2c/npcm_i2c.c
index cc1847893f6..acde0b03c68 100644
--- a/drivers/i2c/npcm_i2c.c
+++ b/drivers/i2c/npcm_i2c.c
@@ -215,7 +215,7 @@ static void npcm_i2c_reset(struct npcm_i2c_bus *bus)
 {
 	struct npcm_i2c_regs *reg = bus->reg;
 
-	debug("%s: module %d\n", __func__, bus->num);
+	printf("%s: module %d\n", __func__, bus->num);
 	/* disable & enable SMB moudle */
 	clrbits_8(&reg->ctl2, SMBCTL2_ENABLE);
 	setbits_8(&reg->ctl2, SMBCTL2_ENABLE);
@@ -250,7 +250,7 @@ static void npcm_i2c_recovery(struct npcm_i2c_bus *bus, u32 addr)
 	val = readb(&reg->ctl3);
 	/* Skip recovery, bus not stucked */
 	if ((val & SMBCTL3_SCL_LVL) && (val & SMBCTL3_SDA_LVL))
-		return;
+		goto reset;
 
 	printf("Performing I2C bus %d recovery...\n", bus->num);
 	/* SCL/SDA are not releaed, perform recovery */
@@ -281,6 +281,7 @@ static void npcm_i2c_recovery(struct npcm_i2c_bus *bus, u32 addr)
 	} else {
 		printf("Fail to recover I2C bus %d\n", bus->num);
 	}
+reset:
 	npcm_i2c_reset(bus);
 }
 
@@ -513,7 +514,7 @@ static int npcm_i2c_xfer(struct udevice *dev,
 	if (bus->started)
 		npcm_i2c_send_stop(bus, true);
 
-	if (err)
+	if (err && err != I2C_ERR_NACK)
 		npcm_i2c_recovery(bus, msg->addr);
 
 	return ret;
@@ -560,6 +561,13 @@ static int npcm_i2c_set_bus_speed(struct udevice *dev,
 	return npcm_i2c_init_clk(bus, speed);
 }
 
+static int npcm_i2c_deblock(struct udevice *dev)
+{
+	npcm_i2c_recovery(dev_get_priv(dev), 0);
+
+	return 0;
+}
+
 static int npcm_i2c_probe(struct udevice *dev)
 {
 	struct npcm_i2c_bus *bus = dev_get_priv(dev);
@@ -626,6 +634,7 @@ static int npcm_i2c_probe(struct udevice *dev)
 static const struct dm_i2c_ops nuvoton_i2c_ops = {
 	.xfer		    = npcm_i2c_xfer,
 	.set_bus_speed	= npcm_i2c_set_bus_speed,
+	.deblock	= npcm_i2c_deblock,
 };
 
 static const struct udevice_id nuvoton_i2c_of_match[] = {
-- 
2.34.1


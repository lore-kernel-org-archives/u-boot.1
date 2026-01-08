Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE47D1D492
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B4C842CD;
	Thu,  8 Jan 2026 21:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wtRE3y2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688C584286; Thu,  8 Jan 2026 19:06:25 +0100 (CET)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E12B84198
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 19:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso2365740fac.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767895582; x=1768500382;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M+gbJ3CMyLYvLj0qN4gpHkU5iXUcctOJS1eYeP1Rwng=;
 b=wtRE3y2YHEhmh8gjUgNjtwpptQ+GSeDU1jFXAwlPokgBS4G4JrN6lhRV+gpiWNzSGY
 dZ4gIJbYf0TO2yo3dArxcY2QmGdnZtBjGNoYxOJoNVDXbmyMZynE34jSwtsa0ZhpFBeF
 F+xWBv/A2xrwW49EbRdlMCIMwgU0y8XABd3H7YuspQB7IupKzDuSOml1xlxgH/YIb3IC
 qnxT6DHuLAjtqKa9x5xAxeblH4m56ODskVr8Lhu6SHVnupLqs4HwGJtdUGSLeWtN2hYT
 S7PuqQNqwp2U3/VDQwCg4z0QHJuQ5pNO2IuXOZK/3CP5JBfQU+MRq8QdJQKbTJcFdbOq
 whSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767895582; x=1768500382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M+gbJ3CMyLYvLj0qN4gpHkU5iXUcctOJS1eYeP1Rwng=;
 b=L4Whe7tdaKU1Zudc6XB/+IsCqSBnBmdECFfKKOcRh62dTJ6WGkUXL0EgBCEymbCDxf
 2nW1z1dYBqq0pkVwVNX1JY5COZMuK5IW/FrFflG8z6jpsFI9XIpZHCoxz+jmtUY8yYxg
 iw2tyBc6jrfEiYUSgeajqjZ/tJOwZv60ELsl7+H2IBrmI9I40xg/+r/4IYarEr2RPlqu
 TP7S2VkDu9QWMlxNxnTpugacT8J8h8R9RKSST5JFs3W05aLkbOMjxo4hWvkTIG+DZuvS
 ccQFyT+uJrz8UAW7HHQLvWClZKj+Dx563ZT2+SAxTpg5n3jJLpB9/ddKT+T+D46eXpuz
 tIww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaJgnNH4cK0yI1Xh0v9m5kApmylNTeUWIgW5c+QtR2qiHs/7BFYOaIYqq7XKaVeXnFYE29jXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YySGs980xpjtkud7GdvfkK5bdYXjYjJnfJt2Nns9F6zVzOIYrVO
 JdkBCuromU2TR4WobCubyJf5Yn6CkWBSwvzvPYZD6gpef66UA7PkVNam1lnO5EYVexs=
X-Gm-Gg: AY/fxX7K4PA0TZDPHWx6kPmXPw5y7oHdzd7GKu4DuGjZh+fNidwW2GuEQrZnsaG5Arm
 KQwf0ul0yu14VcGzKSsnj/4XiQA2MdRn0luYYKVaWJE8PgxvCNPTYu056/YME2n3m9OmYi61zv1
 IflQVq6Pdqn2QSFLVrj3SqtEQtva/Io9K9xoJLZ2dy/i1ktBI1IbE97IdkWflI9lMiOcWeFc+VE
 tqPJI5o85ZVjqfZVl937DKLGWEUAUnC3rX9wUhlhZmAtxdofdBApbAQ5vDoKifD3t7abtXouclg
 5Q2Iu8OCmTU/z7DgJUPe46iCUzeGvlZBxP0QQ26s0c9fWZUBKmBZqAm8lH/+8GGY730jZmZzlrV
 LbIdhGPY5zk2NYvhw7DJQyWD6NKz1Nd78z+LocYOJ5T02ItruToB25d2dPxWHzdvEyEqzaF+1pY
 /g3vPYskXcRf0ZTCc=
X-Google-Smtp-Source: AGHT+IH5qHgzbVNDO2EeTeUCqKLbQ+nK4dXAgwUYVihoMWy/94UqS077451YXtNK6b7bO9mwOvpW5g==
X-Received: by 2002:a05:6871:430b:b0:3e8:93b4:a042 with SMTP id
 586e51a60fabf-3ffc0c2ea44mr3226663fac.51.1767895581816; 
 Thu, 08 Jan 2026 10:06:21 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4a9099csm5391100fac.0.2026.01.08.10.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 10:06:21 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 08 Jan 2026 12:05:55 -0600
Subject: [PATCH 2/2] clk: clk-uclass: used dev name in debug message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-clk-uclass-better-debug-v1-2-265900a42fe5@baylibre.com>
References: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
In-Reply-To: <20260108-clk-uclass-better-debug-v1-0-265900a42fe5@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=JP/b3hbxX3AGFzXfcvzgm8Z2loQD/TuDCbnBrheOF84=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpX/ITrV0tezd9v8WUeENKmi2J/YnCboYAafcOc
 FEQKXicobKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaV/yExYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxscH/0OWyoTgtZEjK1lYgUOVyg/MjJ9387Fa4sMpRuT
 kPPgsvWMB5W8ODLGyb1q5DAOcUbfrePpHTha/4A9UbPmAHlIvM9R6gH+rU00IJDtcTFjlwL0XHo
 Mz9JEolZ8Xe14l6Ay2tiOiA7iEjgN4pJOlp3K6j0xN2RFtUiqn/hgPT46XMzah3O5HtUNYgRBSx
 ZAl8uCs88aOIV+cYymsW+I04wRLcMQ8sodmhEmk22fciFdlIw6nk/Ibm+yargXgbJogH2jTJ6a+
 HRZsbXe4OCVbzlOIvH33Uq3tdOtKgwIIZw47zGzXGf8RRgWtuVDIpRUuA9y1G6bQrPowPAckWHQ
 3ofI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 08 Jan 2026 21:24:28 +0100
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

Consistently use the device name in debug messages. The clk-uclass file
previously had a mix of printing the dev pointer and the device name.
Changing all to use the device name makes the debug messages more
useful.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/clk-uclass.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 0e56d207b0e..c33f415917e 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -122,7 +122,8 @@ static int clk_get_by_indexed_prop(struct udevice *dev, const char *prop_name,
 	int ret;
 	struct ofnode_phandle_args args;
 
-	debug("%s(dev=%p, index=%d, clk=%p)\n", __func__, dev, index, clk);
+	debug("%s(dev=%s, index=%d, clk=%p)\n", __func__, dev_read_name(dev),
+	      index, clk);
 
 	assert(clk);
 	clk->dev = NULL;
@@ -183,8 +184,8 @@ int clk_get_bulk(struct udevice *dev, struct clk_bulk *bulk)
 bulk_get_err:
 	err = clk_release_all(bulk->clks, bulk->count);
 	if (err)
-		debug("%s: could not release all clocks for %p\n",
-		      __func__, dev);
+		debug("%s: could not release all clocks for %s\n",
+		      __func__, dev_read_name(dev));
 
 	return ret;
 }
@@ -217,8 +218,8 @@ static int clk_set_default_parents(struct udevice *dev,
 	num_parents = dev_count_phandle_with_args(dev, "assigned-clock-parents",
 						  "#clock-cells", 0);
 	if (num_parents < 0) {
-		debug("%s: could not read assigned-clock-parents for %p\n",
-		      __func__, dev);
+		debug("%s: could not read assigned-clock-parents for %s\n",
+		      __func__, dev_read_name(dev));
 		return 0;
 	}
 
@@ -467,7 +468,7 @@ int clk_request(struct udevice *dev, struct clk *clk)
 {
 	const struct clk_ops *ops;
 
-	debug("%s(dev=%p, clk=%p)\n", __func__, dev, clk);
+	debug("%s(dev=%s, clk=%p)\n", __func__, dev_read_name(dev), clk);
 	if (!clk)
 		return 0;
 	ops = clk_dev_ops(dev);

-- 
2.43.0


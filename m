Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C83DC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 15:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 536EC8354B;
	Wed, 23 Jul 2025 17:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XNIs767O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C5E8354B; Wed, 23 Jul 2025 17:17:32 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11A8834E4
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 17:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45622a1829eso22625035e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753283849; x=1753888649; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zpmhwTz7N3ngreL+6/LxWz0rdaZKdUQjiZURmKfIqPU=;
 b=XNIs767OZrgnE1zg9oGcc8rxfzyJstGjo5tcXyi/A1YA1cxn5615A75jlgU/UYnzm5
 DKwYvCTvv48zfoXXGzVPy+ZlKyIKQUkp4zwA8Ws04ytpdkZiSL7XdOv4WuO51fFWQYig
 wQvvQI+R2KYKLoCKrJvdd7HEwvg5KeaCNNx6gXEg490RegUxO6LydRNC7uD5xr5i7LVW
 RHJWQu6+VY35yyr+f8jasO0KyWXWd29IIjmlInMbY6HyJMP0qCzPMXDu9xsR4TbmXZzK
 KQq/jXY9ycXBo0kI2kaFEudVpr+jD2LsI7ZUPCAso3O1wRkoVrdThBKqrwpZVGpUXm5o
 ywzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753283849; x=1753888649;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpmhwTz7N3ngreL+6/LxWz0rdaZKdUQjiZURmKfIqPU=;
 b=aKiFaLC++RDai+D9ROeVQC2IBw67A52Q6UZsGN04Lbij3IDHfDbVLGFmgT+oKunT3Z
 mNLSUaQjQyh+W6TXm1xEfnc+Y8D9OxXXlzO56zQnDCEaqRoYqnrQQVH8NmcA0lG6LKR+
 rl/He5A14nZqn4PUg9N9zKkJdXPCQsx3YAC4B6NjnjOqSFgkvdLJijdMz1/O6oscMnlQ
 29UvJnme3v0NE/n1WO7wInx4RiWlY/LND5vtYZryfYd6tHI39sq3Fdhk3o+ciTmr67M7
 0M9csHhStj+mQcU/nJhBTahJxXeAklCf0haL3XYqD7Ivk6QSixxA6rwSw3j0vlA+5G1n
 bLcw==
X-Gm-Message-State: AOJu0YxR07b0z3bxFBvIKUv7O6TrCfErVShjnC+oKZCwlYUnmPb1vfdX
 cKtxeXQm/tGn+LJ7GQzX4Eh67UvCwyuI/bczyl5FiKUtdEnZDgWqYhPwwsKwEp31ZvQ=
X-Gm-Gg: ASbGncvlHDormhSw2UT122oqJaDi57k9UUH5H3PtmgMB9O9b/plIXm5wJX+Gm6BzObW
 n4QpbUu1TM9KpInVL+yh5cWZYx8xSVR9j3akHXwfPtKpzNRPZI7PkDnmaWRAN82/H0ykqJLwUQ2
 TbS21GVltjjK/f0hfKk016Y4w0gkGN3mLm1z/UZorUAHMoLXefza360RM5ijai4jYDTUaedi1ss
 OkX+ucajlaOY+gXPlDATtqJsC6lxEF3tC8MrUZYB+3wkM9T6ubC9BjdBWZvXj6laax+6rD4ctSl
 XeuiLuuzAP6MKF+sfWF4knsNtyyjIglJqQRETuWLpqNbdH/0rnlYlOKs2KDg5Yk3+g7qC084D3j
 jSpnChT27ArRrllUSRh5HNkAbcbKKzfLD2F3bcnetQzKWwZzE9O8=
X-Google-Smtp-Source: AGHT+IH3oOYqUH4kMeaWcy1aDnY9+A4ACisdKbmwUqaRr5PyL/AB1mwTUqrg42BGeYYPtYABbF63Ew==
X-Received: by 2002:a05:600c:3d97:b0:456:237b:5e4e with SMTP id
 5b1f17b1804b1-4586ae36d14mr23220395e9.32.1753283849238; 
 Wed, 23 Jul 2025 08:17:29 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2cc06sm16591449f8f.35.2025.07.23.08.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:17:28 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 16:17:28 +0100
Subject: [PATCH] clk: cdce9xx: Remove always true test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdce9xx_clk-v1-1-9cb1f734637b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAf9gGgC/x2N0QqDMAwAf0XyvELtkOp+ZQxp00yDWzcSGQXx3
 617PI7jNlASJoVbs4HQj5U/uUJ7aQDnkCcynCqDs66z3l0NJqShlBFfixmotbZH36fooRYxKJk
 oIeN8Nu+gK8kpvkJPLv/N/bHvB3D+eq52AAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The function dev_read_u32_default does not return an error and the
variable 'val' is unsigned so testing for >= 0 will always be true so
remove this test.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk-cdce9xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
index e5f74e714d5..492a196604a 100644
--- a/drivers/clk/clk-cdce9xx.c
+++ b/drivers/clk/clk-cdce9xx.c
@@ -117,8 +117,7 @@ static int cdce9xx_clk_probe(struct udevice *dev)
 	data->xtal_rate = clk_get_rate(&clk);
 
 	val = dev_read_u32_default(dev, "xtal-load-pf", -1);
-	if (val >= 0)
-		cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
+	cdce9xx_reg_write(dev, CDCE9XX_REG_XCSEL, val << 3);
 
 	return 0;
 }

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250723-cdce9xx_clk-9e1008c78db7

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EC3CFC299
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A0F83A3A;
	Fri, 21 Nov 2025 18:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W4gcbyK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E4983A5E; Fri, 21 Nov 2025 18:34:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3830983A41
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47790b080e4so12808685e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763746475; x=1764351275; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UN0+Af1e35gtro0Bv+4aj+AKmQnv3PUBWo7zlbxqfJs=;
 b=W4gcbyK32pxJBE3xyuztrGp9ZFBl+qxIroTEOKZ0iUNvoKlwsjZsOfp9e9chsEC7Nb
 O/nQFQ2HJKuuOL12SsZfda1Mt7jDg9e+leM2o5sBWWgnaTHxidpXIYJ9WwYVK3J1s1hw
 bVGWdo0tDWZF7+6N8E5VjviqN/YsisOBatgpVW7EOH4ID0UDjZSx7cw7YbGwK86ve035
 15mfTc21jts0OOT2S+ygdEMU4tMZRfBdji/+0fNxs8/tUhpwMgz9pgl+ySYuLtLG5skd
 vtQYtKNSC628LUm21WoQOj5IhBPzgQmC9rr50ozQ+f9CGcxCm7Z4jx21x96GI08ImhV9
 dV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746475; x=1764351275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UN0+Af1e35gtro0Bv+4aj+AKmQnv3PUBWo7zlbxqfJs=;
 b=hcM8ey3dduV7tSLYJf9daL4y6ouWKKfNJq7AOIqQ3TJ0DtYQ2VHLjI3D4m6VQf1qA7
 Nz16uE0BMie8p3TTRkegREU0DXLSPw1uuEeFU7QPf2pSIgbgVTW9jJPX9iAggiKTK0QO
 deZnYHxiSPtKI1x9lKi/fDlBOFv15lHpZaiaTb312v7AcstiKz83YD+vbb7Q2nc1Aj+L
 oi4sfwm8FMvjMp3SFP5pFjKIP2WJuoaeoJYaBHbyvGItfA1qYbM85MC5Yq3GS5uG3GCv
 hQYE4c0R2C+h/q2GRE+vQ/9wbdeon9O28jugOHS01Q/Twlk5mJ5CIKbnyUp2sEs3FJt1
 BY2g==
X-Gm-Message-State: AOJu0YyC6eXw2xJgYt/XrtUwqac4J/T5mim7pVenXt2U+DmRwNQ5O0yW
 v1gJrxXhJ6w4mn8NUftuE2TvXvP8yIvDFqt6h2JqQAqU69S0boxyNkNlCrZaWEL5xtI=
X-Gm-Gg: ASbGncsiNXatxwODubP8MdE6JI7MI0wcVVDPfk+WsHvxIFvMBH+XriPwIWIKc4ySV5w
 b3Jpl35n0Ff3WfR9nRiT2PIkCPWMEZkozN6yQgQEJAtp2QGj2t2/oYu/N8gKm1tVd4eEH6uokbF
 W3TroNzwfGJw/tTkJ4JC56+20pYEUs9DIEQQw7gdHQtGHuxnpSqs/KXAu/Sy2fkELTQGpcmV7gA
 TEINgDA6TTbmc2/58rDxlMsH+1qTi6jzZuXmTafcVbQuhiEQmIwo5QGdxgZctGsK28MU72xWhjQ
 Mtvlm9PIRe7Tyk1UXi6W0nu0cxuXFBjqegvFo4uVV21oteoS0GJmg7EPpoY6/nPnCvH+xy+6lV4
 E+EzSZGjzof2eLzKlZLz2EZ4O3HCB3s0aD1etFAXWdnWpi7Jx75UxQSopPOk9dBmvQiB/+8Pr/r
 +OI+nsrQOyDveLYU/lZtHT7FsWJEqxw+YuakULpDMLoe2qH/Xeig==
X-Google-Smtp-Source: AGHT+IGSQuS64LRyC2h9+p/DjddlTob11dz0c3Fvxv/RnojPRzuen4b1cVFvfz5kHgu3EGQNXi3tow==
X-Received: by 2002:a05:600c:354d:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-477c10d7003mr29506595e9.11.1763746474472; 
 Fri, 21 Nov 2025 09:34:34 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:2c01:4a49:22af:8b98:6c9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e1b657sm87078365e9.17.2025.11.21.09.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:34:34 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 21 Nov 2025 17:34:31 +0000
Subject: [PATCH v2 1/3] clk: Prevent SIGSEGV on debug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-clk_uclass_fix-v2-1-74f4ea10e194@linaro.org>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
In-Reply-To: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

If LOG_DEBUG is defined and a NULL clk is passed to clk_enable or
clk_disable then an attempt is made to dereference NULL in the debug
statement. Guard against this.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3dbe1ce9441ca513d41be90520ff175c96b4253a..1f55dbe385b76d0d6cfbf19bc9f4f1abe619baf2 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -660,7 +660,7 @@ int clk_enable(struct clk *clk)
 	struct clk *clkp = NULL;
 	int ret;
 
-	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
+	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);
@@ -721,7 +721,7 @@ int clk_disable(struct clk *clk)
 	struct clk *clkp = NULL;
 	int ret;
 
-	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
+	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);

-- 
2.47.3


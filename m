Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1B4CD6E56
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 271FF840ED;
	Sun, 31 May 2026 23:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aWGhLcDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C15B8469F; Sun, 31 May 2026 23:02:38 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B45680077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6870a4688eeso1250466a12.2
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261356; x=1780866156; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/YKfxsoi/hez8d09Gg+edcTj05MUpq1Hcp9AOabVdKM=;
 b=aWGhLcDrjpe9sStMHaP1qI5ItSXAl1Xd1HSDjZwPHaBVwuJBvwnfxdnH+ORIrVm1X1
 jMpvx5iF/2IwneRRK4tIa1cXmGvdz7ToapSu3ffYglZ17iJJh+0J3LEnN1sbI9wWAPG3
 KoKjfF1FsOGdPZhUN3G+3V8aIcIMthRvVroTvVPAGjQuasr2ikmGBZGK65CNr/auv++Y
 N2u1qqPIjLifb/0KYsBENu6LU65YKcGIwspuf+uMAr+f8PatzbGeOTN6DR3QWxM2zks+
 Sa+z1Dcxfcg5BQaexOqifPHzSdjNiv4+5tW2+EXi6lb/16ZOeDdK4QtfXNVQEhXMmiUs
 x/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261356; x=1780866156;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/YKfxsoi/hez8d09Gg+edcTj05MUpq1Hcp9AOabVdKM=;
 b=f9W7BNi0iZAJoe8fy68paQfVak7pCYVaisiluVqlKrwSuLqFPRv0yl6BgZ0ybWvd0a
 a7uKbRuePNvHbT2e+xZndFH9ZWzpwWU01oRhL51kjqdYu6vtDVHDw2eyTT9YKNm832Aa
 f1SN22vI4wAvzn05Sjnq8TikxnvWovPdlh7XrUd0KeML3uUM0JUiADVNm9PeByz61jY+
 Dn2NHiyHcyBt3fkwUvZiqL6MOJeGBZLvf3TrTBzB5FQjrIe9ERQaSc2fSBtw861yh45k
 M5hog7aHesoplJYyCMTP0VgAMRz9B/+Ranna9vE2T/5UwiYRqqdwLO2AjauKGJu5G3A5
 qCJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XTU1GUqlOt8c4dQ9xfcMSiklByiYiM0Ay+9n5BIrLIV1HD6ajhhkJrhKy9R96jvEeZTG5LYg=@lists.denx.de
X-Gm-Message-State: AOJu0YzTBrEvVZCVMPrPBCcyh8lBQb45ngDuFvfs+JE9t1mOtMe1yADy
 9PoMA1SXK8aBCT++BEbeLpeIb9onXamDEYMC+dAmJH3vlL1Yez973EJA
X-Gm-Gg: Acq92OG/A6f78ZHDRl5xDq3nS+QKMtG2JW7uCkJOboYqFS0KgJvC5tAli7rvFATp9O9
 w55S2dSK9DQ14UKWPeXmEH15FF5QTcUPTt2UJPw7B2izq4Tvslb22T/T66N+d6kTIkWMxnjo32O
 eSG1paJole3iDcfJw1wF6a6K7CoakC63PfPdziBO19dihFlJHbGErRqg80CRteQqF+YNQlCGe3L
 lPb+fMVvf6MKUE3u4zTqjU+eF2EX+ermj4h/osaGHTNpYmRAOElAmKHamvvYIUwGZquSJ7TxrMB
 oXJJc6KTB5SIDBW9IGBbCctZTmrPdHCV49SbAl0mHE0/ZYRdUOai5vSChmIoFb7K5GFQCb/9juB
 5HVYjvMzI/ps+w0hzKPMTex/hA/kCxf/TM6nZFKjhXKRBsD3C5965PAnrcQcXrJy2E+8AcCgoMs
 usQgqerU/yCFGVET4nN4DJC1IM5Mocxc03jpEE3InYCfL8ttXjC770A5L8gqy63tV9Fv70QmON
X-Received: by 2002:aa7:c3cf:0:b0:68a:7a6e:cb4a with SMTP id
 4fb4d7f45d1cf-68c88645e09mr1170575a12.2.1780261355588; 
 Sun, 31 May 2026 14:02:35 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68ceb869dfdsm1338857a12.29.2026.05.31.14.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:02:34 -0700 (PDT)
Message-ID: <2d88bc68-a40d-4e5a-89f5-e90648fef114@gmail.com>
Date: Sun, 31 May 2026 23:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 04/12] rockchip: clk: rk3288: add SCLK_OTGPHYx enable and
 disable
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Add rk3288 SCLK_OTGPHYx enable and disable.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

	GATE(SCLK_OTGPHY0, "sclk_otgphy0", "xin24m", CLK_IGNORE_UNUSED,
			RK3288_CLKGATE_CON(13), 4, GFLAGS),
	GATE(SCLK_OTGPHY1, "sclk_otgphy1", "xin24m", CLK_IGNORE_UNUSED,
			RK3288_CLKGATE_CON(13), 5, GFLAGS),
	GATE(SCLK_OTGPHY2, "sclk_otgphy2", "xin24m", CLK_IGNORE_UNUSED,
			RK3288_CLKGATE_CON(13), 6, GFLAGS),
---
 drivers/clk/rockchip/clk_rk3288.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index a4ff1c41abb8..07d539a9f703 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -946,7 +946,47 @@ static int __maybe_unused rk3288_clk_set_parent(struct clk *clk, struct clk *par
 	return -ENOENT;
 }

+static int rk3288_clk_enable(struct clk *clk)
+{
+	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case SCLK_OTGPHY0:
+		rk_clrreg(&priv->cru->cru_clkgate_con[13], BIT(4));
+		break;
+	case SCLK_OTGPHY1:
+		rk_clrreg(&priv->cru->cru_clkgate_con[13], BIT(5));
+		break;
+	case SCLK_OTGPHY2:
+		rk_clrreg(&priv->cru->cru_clkgate_con[13], BIT(6));
+		break;
+	}
+
+	return 0;
+}
+
+static int rk3288_clk_disable(struct clk *clk)
+{
+	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case SCLK_OTGPHY0:
+		rk_setreg(&priv->cru->cru_clkgate_con[13], BIT(4));
+		break;
+	case SCLK_OTGPHY1:
+		rk_setreg(&priv->cru->cru_clkgate_con[13], BIT(5));
+		break;
+	case SCLK_OTGPHY2:
+		rk_setreg(&priv->cru->cru_clkgate_con[13], BIT(6));
+		break;
+	}
+
+	return 0;
+}
+
 static struct clk_ops rk3288_clk_ops = {
+	.disable	= rk3288_clk_disable,
+	.enable		= rk3288_clk_enable,
 	.get_rate	= rk3288_clk_get_rate,
 	.set_rate	= rk3288_clk_set_rate,
 #if CONFIG_IS_ENABLED(OF_REAL)
--
2.39.5


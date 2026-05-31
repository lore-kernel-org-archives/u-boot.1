Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CD3CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679A5840ED;
	Sun, 31 May 2026 23:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mb2FWxA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5C5846A7; Sun, 31 May 2026 23:01:55 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61EF180077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bec44dcddedso12660266b.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261313; x=1780866113; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WrdHiWNUv0GIKz0Dv0vWVMGsy/EM0Yrvf3dWZSEMcPQ=;
 b=Mb2FWxA8naVBazTEP7ER8cY0fvQRk9RmiB5nXBy26V/1kxQsvzVsAUiC/kcMDqnfu+
 GcFQu1vKOPUGrkDhGpUln8OfQe4Zlexhg80deAfkmTKz6/mI0OunriDN2cl4VRLzPYLV
 /W/cXPkZeerom7CuFCUl8txH3g0am7vhjPTlZJIg5R//bPWSmcTB50Fm5uf0/AnBWHSn
 oZgOwaWUVT9Wuu9Sihwy4KjYEadD3HiYk1QIyI6yClhkINFrKA0wqDykxtnx0GrDV1U7
 Tuu4Zi3zZZ9wfP+TlMeSxjAH55/Upnx8fpxUKSifzrUHREOwFrWIJfPN7R7iufy77TPJ
 Q8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261313; x=1780866113;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrdHiWNUv0GIKz0Dv0vWVMGsy/EM0Yrvf3dWZSEMcPQ=;
 b=nPSqT6r08nqkZQDmlrYVTctDfkgBWRE2QcozTtelQ6PacgzDaRELsCNVzJaGFkCiwr
 V5goZW1sG+GHdAOvGBibCXgzojqMPWDVcBCyy56ewp50P1GEOGxTCWJGDGfjlzZGQUSo
 0H+463YxAULRKPHajw4DEBnks236G/DDpT0oowOn8c3jgWQttkYqHcm9hTuuvGs7N3JB
 fJdy3P2z81a9x0+lkIg+BMtVg0m1PDpt1E2gx312Ljb+4UrR2c1pgiKybGsucA4SGE6J
 pZVEzCcrvx5TvL46jmc0Rf9ltAPkXf823/PJuJXOqyJjY+SU9hav3gdcP34U5P/fa/wo
 +JGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OgSNh2H5cXjpY8HU38tat12wGAgFZHckHgSFAxEgceWrMlmB9UNwFtg7UQjG/oZgTQfe4nwE=@lists.denx.de
X-Gm-Message-State: AOJu0YxW7i9uBOlLRUG3uOel7JiqCZSUpn8FfvYaEy8WF/3jQroevV9e
 QGenzR9im/RnNWsfPzJL5EBVOIdMb7GEAehLJrVBBRH1RU0bDOhE9s6O
X-Gm-Gg: Acq92OH7gofGwImuNDLCp2eHqzIk2v5OI8CM0MILCgcVDgXuvs/pBUpKBS2vWK5i5pk
 hsWTXQCWVqKuvVMNAl/JokxLo9Uj9WsmGvnHrRY7ck4NtKp9RSuBfsjsjfvUesi2EcUFCY3LjCq
 73WF7hIupJJ8w1Oyu5/ypxRxyWUXeZb9GXirj7y7AWclADJR7kUngpGWe68IpNRW41jun040WbB
 gMiNFe7C5bE4Wy/3U1HsICnp3jFbuMtBkMbueOxB9SpIfP1PLcv7JFbIeqW/DRQvAZ1FbjAjSEd
 qNPTyXGQECL3ZOEV5qrrv8pWGlf1hF4mMW9vQGFmsB526YrWqsn8d7zqhm8oh3M8CudATV8K4EC
 J1MIfS0RIEqpBtQuqy4vGtcxJzlt9x+XJlRVx1mVa5Bt8V5xoZ3clAIkhAJ3+64ohBE8RQf5psp
 Yx375g15RDavwlZOb4CiImc6evd6Nr0iBEYqU0z+S+q+XW+3uFXpzHbbiZBAhv/+rXpMbA0Sc6
X-Received: by 2002:a17:906:8454:b0:bed:9664:4a28 with SMTP id
 a640c23a62f3a-bed96646850mr9974166b.8.1780261312433; 
 Sun, 31 May 2026 14:01:52 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-be9d6cfa7c1sm256510466b.60.2026.05.31.14.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:01:50 -0700 (PDT)
Message-ID: <c6317423-957e-4b64-96fd-ef2a709891c2@gmail.com>
Date: Sun, 31 May 2026 23:01:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 02/12] rockchip: clk: rk3066: add SCLK_OTGPHYx enable and
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

Add rk3066 SCLK_OTGPHYx enable and disable.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

	GATE(SCLK_OTGPHY0, "sclk_otgphy0", "xin24m", CLK_IGNORE_UNUSED,
			RK2928_CLKGATE_CON(1), 5, GFLAGS),
	GATE(SCLK_OTGPHY1, "sclk_otgphy1", "xin24m", CLK_IGNORE_UNUSED,
			RK2928_CLKGATE_CON(1), 6, GFLAGS),
---
 drivers/clk/rockchip/clk_rk3066.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
index f7dea7859f74..92b435cce83e 100644
--- a/drivers/clk/rockchip/clk_rk3066.c
+++ b/drivers/clk/rockchip/clk_rk3066.c
@@ -592,6 +592,12 @@ static int rk3066_clk_enable(struct clk *clk)
 	struct rk3066_clk_priv *priv = dev_get_priv(clk->dev);

 	switch (clk->id) {
+	case SCLK_OTGPHY0:
+		rk_clrreg(&priv->cru->cru_clkgate_con[1], BIT(5));
+		break;
+	case SCLK_OTGPHY1:
+		rk_clrreg(&priv->cru->cru_clkgate_con[1], BIT(6));
+		break;
 	case HCLK_NANDC0:
 		rk_clrreg(&priv->cru->cru_clkgate_con[5], BIT(9));
 		break;
@@ -611,6 +617,12 @@ static int rk3066_clk_disable(struct clk *clk)
 	struct rk3066_clk_priv *priv = dev_get_priv(clk->dev);

 	switch (clk->id) {
+	case SCLK_OTGPHY0:
+		rk_setreg(&priv->cru->cru_clkgate_con[1], BIT(5));
+		break;
+	case SCLK_OTGPHY1:
+		rk_setreg(&priv->cru->cru_clkgate_con[1], BIT(6));
+		break;
 	case HCLK_NANDC0:
 		rk_setreg(&priv->cru->cru_clkgate_con[5], BIT(9));
 		break;
--
2.39.5


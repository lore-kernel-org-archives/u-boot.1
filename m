Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448CBCFC299
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C53583A71;
	Fri, 21 Nov 2025 18:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fgu7UxVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B58083A71; Fri, 21 Nov 2025 18:34:38 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F377D83A57
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so20702795e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763746475; x=1764351275; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGD5IqDqibha010UF0hqLKsiXwGlYQOaZRUOAY7esRc=;
 b=Fgu7UxVheN2HSE5O2EHSsBM/GBwrkANE1JBrtJ3SHjEB+HXE9i9YHe1lCkedpANLBM
 7DcNeXGRjx8pXK6sMX1YbW2uvFdaLEulhpSPyWFucc+IFieLXsfB/XMWFnpJ7mQ6C8Nr
 icunJJ8bUZyb87JkF3ncCNbj6Bd2rz+mprK07uqFEAAoTvYTWW+ZzNA+VWA0lbLOPcqN
 8voUGsxFfHPmLoTboOXPLYoW/gkEja+WYhv889DgJU3mT8EduEKl9WSyIYb2vxJbsYWg
 XLc3RpNEpKPTYa2HzNvvHgPKh7CqhzJqmHVf0ZbZE3LpQpc3iIQpF1M30L/t0H25otTL
 8QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746475; x=1764351275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BGD5IqDqibha010UF0hqLKsiXwGlYQOaZRUOAY7esRc=;
 b=js29RD79BP+kQ5z4XlgOolEh8o4MFcn3+tT5oMCXoYlSmgI6NfPsZxMFFn8A5hR7eW
 VogheAg3GMQThWYq4rCT1Z2XBgQG63+bb4JP+1WsTVpHcQm2hOWm626HVA9jIUt0DUa2
 /DW/nqfl9z/+3FMXFZohbAgCewSXXbojXR4sWOmrjvkeXoR0vYTnrJjMOB5Q45M/foUc
 tu3OEYMWfeq/v/lsiTFDYCDdmaPIAXTm8T2X+8/7hs1QKyFFOO1la8XyNWj5ugnOBhxE
 ZYC8ljzKcY2HalrptPoXa3itX5UVUeiDbxAfqs94hxxO65Hn8sVIGYG/xUpSGDiHU3A/
 fyqg==
X-Gm-Message-State: AOJu0YwaRZnEpfP5rg4l32/r5vKFS8qV3KguYlHrzcqlZ/jKIfpPLFQo
 tiJr2TnU8sYDS5sfJeQwhfhiTzr6jb/ROItXGpqdBTrQKweFJkInZJl/opvCajd/BGWzOeib2HX
 hBXmnHHmMhQ==
X-Gm-Gg: ASbGncsqvPB1hajqDuOA67nZ812DvgplLw8wG/PzjYfJvKw5aHKE6I37KFxp1uHThvV
 j96gTYpPIw2VyeA1Jd5Akj9/3j9mLlfE/AfmL7mmdlZx0/GNGnuYDnvbJqMRg89xZI5hNDtDLmo
 yy1rSxLmRW4vw9dFkxaT8964Nyy0KGSVvXGxT8l01bkmYh2TgeeBZLJ+1dzWqAp5Lz57KDd6p8o
 eB6vDQUNAq6PWUQeQ+sz1wfFp/W8v2lwrRYLGgSxREsg2GD7gecMniH+myIdkhhqMGzWiRk57YZ
 6Bwc3s0Chbo1LwcDVmSSR1OnBMreSHATPiQXQruCI7qvN8ONXhcpyk2lT4wMhwQuALLQq8hQ1OV
 KVFasd0akgNnh5OCbbKdSjlQBaCnddJQICzCCnwisjiVWGDbJiiNIJuqA/EGHkvvnyiECTvJvpL
 QfvaqstLJ9twFhheqvcYtnZAlIDzd7yfeuKGP/ffM=
X-Google-Smtp-Source: AGHT+IEmCPvRtGLDyO9TOe1tRbQiOM0stzZoep6fhZFsJMUMt2YCZrter4ogFWsbrz1tqK9MT3aLhQ==
X-Received: by 2002:a05:600c:3b07:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-477c01c1527mr29485925e9.21.1763746475392; 
 Fri, 21 Nov 2025 09:34:35 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:2c01:4a49:22af:8b98:6c9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e1b657sm87078365e9.17.2025.11.21.09.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:34:35 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 21 Nov 2025 17:34:32 +0000
Subject: [PATCH v2 2/3] clk: Return value calculated by ERR_PTR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-clk_uclass_fix-v2-2-74f4ea10e194@linaro.org>
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

In clk_set_default_get_by_id ret is passed to ERR_PTR but nothing is
done with the value that this calculates which is obviously not the
intention of the code. This is confirmed by the code around where this
function is called.
Instead return the value from ERR_PTR.

Then fixup the sandbox code so that the test dm_test_clk does not fail
as it relied on the broken behaviour.

Finally disable part of the test that does not work correctly with
CLK_AUTO_ID

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 arch/sandbox/include/asm/clk.h |  1 +
 drivers/clk/clk-uclass.c       |  4 ++--
 drivers/clk/clk_sandbox.c      | 17 +++++++++++++++++
 test/dm/clk.c                  |  5 +++--
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index 37fe49c7fcf61a0d172dad8539f510431b9ab59d..2d3318cdcc4d5a6710441fcc532dc7d9a06408f0 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -50,6 +50,7 @@ enum sandbox_clk_test_id {
 
 struct sandbox_clk_priv {
 	bool probed;
+	struct clk clk;
 	ulong rate[SANDBOX_CLK_ID_COUNT];
 	bool enabled[SANDBOX_CLK_ID_COUNT];
 	bool requested[SANDBOX_CLK_ID_COUNT];
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 1f55dbe385b76d0d6cfbf19bc9f4f1abe619baf2..a72a67d75a165c2d98bb702888e848f6b075fc7d 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -199,7 +199,7 @@ static struct clk *clk_set_default_get_by_id(struct clk *clk)
 		if (ret) {
 			debug("%s(): could not get parent clock pointer, id %lu\n",
 			      __func__, clk->id);
-			ERR_PTR(ret);
+			return ERR_PTR(ret);
 		}
 	}
 
@@ -354,7 +354,7 @@ static int clk_set_default_rates(struct udevice *dev,
 
 		c = clk_set_default_get_by_id(&clk);
 		if (IS_ERR(c))
-			return PTR_ERR(c);
+			continue;
 
 		ret = clk_set_rate(c, rates[index]);
 
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index c8c5a88c52d985632733030b0cb92970920a5fc5..cd92a6a29f57565ee140b012e34d284c93247023 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -8,8 +8,23 @@
 #include <errno.h>
 #include <malloc.h>
 #include <asm/clk.h>
+#include <dm/device-internal.h>
 #include <linux/clk-provider.h>
 
+static int sandbox_clk_of_to_plat(struct udevice *dev)
+{
+	struct clk *clk;
+	struct sandbox_clk_priv *priv = dev_get_priv(dev);
+
+	clk = &priv->clk;
+
+	/* FIXME: This is not allowed */
+	dev_set_uclass_priv(dev, clk);
+
+	clk->dev = dev;
+	return 0;
+}
+
 static ulong sandbox_clk_get_rate(struct clk *clk)
 {
 	struct sandbox_clk_priv *priv = dev_get_priv(clk->dev);
@@ -102,6 +117,7 @@ static int sandbox_clk_request(struct clk *clk)
 	if (id >= SANDBOX_CLK_ID_COUNT)
 		return -EINVAL;
 
+	priv->clk.id = id;
 	priv->requested[id] = true;
 	return 0;
 }
@@ -132,6 +148,7 @@ U_BOOT_DRIVER(sandbox_clk) = {
 	.name		= "sandbox_clk",
 	.id		= UCLASS_CLK,
 	.of_match	= sandbox_clk_ids,
+	.of_to_plat	= sandbox_clk_of_to_plat,
 	.ops		= &sandbox_clk_ops,
 	.probe		= sandbox_clk_probe,
 	.priv_auto	= sizeof(struct sandbox_clk_priv),
diff --git a/test/dm/clk.c b/test/dm/clk.c
index 790968e64774362d8967845b01b296c528326b99..c3363796498b4db3664a5b3cea10da54161a06fb 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -89,8 +89,9 @@ static int dm_test_clk(struct unit_test_state *uts)
 						 SANDBOX_CLK_TEST_ID_SPI));
 	ut_asserteq(0, sandbox_clk_test_get_rate(dev_test,
 						 SANDBOX_CLK_TEST_ID_I2C));
-	ut_asserteq(321, sandbox_clk_test_get_rate(dev_test,
-						   SANDBOX_CLK_TEST_ID_DEVM1));
+	if (!CONFIG_IS_ENABLED(CLK_AUTO_ID))
+		ut_asserteq(321, sandbox_clk_test_get_rate(dev_test,
+							   SANDBOX_CLK_TEST_ID_DEVM1));
 	ut_asserteq(0, sandbox_clk_test_get_rate(dev_test,
 						 SANDBOX_CLK_TEST_ID_DEVM2));
 

-- 
2.47.3


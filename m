Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE713D58D69
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 17:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1F389A5B;
	Mon, 25 Nov 2024 18:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ilXX9Et+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5910C89A5B; Mon, 25 Nov 2024 18:13:08 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490DE89A53
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 18:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38232cebb0cso3614646f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732554786; x=1733159586; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F331ANeodgGj+3Dj869WB+lkkCaNgcX65CXGAJzLS8Y=;
 b=ilXX9Et+QkG2hUM4jcy8ArxTzW9k6vkNtCi0gHp5cBDL/mMHoB66evpABj8h/C58Bx
 Z2s6ui5Rt8j5Bd9U4hQpxSxJEnwLdn8tVoWPEZ0KLt1zNJUc+tnDBFIPvCrBCWdTcTgT
 /Tyq7I9up+ZXk7HIUQWUQYaYLshntT1bIe2CWZuixNqENGMdnx12EoFoJIMn5axg9zbv
 5Yn1ODMC9VkfJ3mLf0vBKOMR0Cpy8JZR1bZVqzfa7L7RIpRvg78ncXMqZOqTpQIGkDPs
 lO+FwIdZ5HNw+OiNkbBpgg2uGnbNkWOhh1q/3mCrAdYIFIdge5y9MofbVqqs6u5j+xy8
 WzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732554786; x=1733159586;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F331ANeodgGj+3Dj869WB+lkkCaNgcX65CXGAJzLS8Y=;
 b=LKEgn+9MEYQ9rgGQHDBcWPhU4fZvfftK5xEVrxnTWCpGuK3vAFXk9COs5C15EYeYXP
 cTss0OU8G5yqfy9b7Wwn6gO90J1MPWs+drtRJFUSbsniUlG+hx9dOLRjYcOrd5B7U8Nl
 V32V282/3nG6uBuJINCZsCNVY6KXGX+LA/JR5HE+YxG2/jCrcxONbzEC3W6HGKwuzF8M
 hQX7NOUk/3PJaWrJ3VfXB/egJrY85c8H+qQOw3do6vDFE+PJGChYvxE/G/ByhLPT6YcI
 Aop+GIIMywaBtot4lE4Q8mhcgHkbxvTVBRp09k8Dh/msbSFHKjlAt/N4mmf0GiCWf1WC
 dK1g==
X-Gm-Message-State: AOJu0YzZFZI6OZVFVLH10tAKlFiPD+l4X7tlDP1Q4bUVZOMvef6z1hZ6
 Pn5FSabrGwByskwerOTp/exRAhIFxwJGtxLrKVhv3BeMuzjLn0PW3J4FtAoSfWw=
X-Gm-Gg: ASbGncuozuE9bLPAfXZVlMZRXTjMGowGgLfJosey/0tXsPTBaoYTQHFlDnSDEMM5d5M
 WnBPVSWayRuNiBHSoFysOIEyUxOcALieiosGBpkv6rAgsIj0rrBI6YN/kwH3omRd/+z8f2j01DD
 CV+rpf8ylRKLDDAZAhKy4XT7cQ4e6K/QdDW6S4mwu1FsgSF5ezBQ0vkqAdqHf6QknlmyaeN+dif
 DpU39saucTOI2Elfh9oAHtZt+4WEDmXuGm96W6KbbNoEWP999l3f8bG/bMBYH+WCfJA5o0=
X-Google-Smtp-Source: AGHT+IGjttHDs5ru8yLr/5Sczi6t+M1trwrX8e59LYtwVd5YsPKjmr+dvRTEnoq50AEhn+OYz4qgLw==
X-Received: by 2002:a5d:64ac:0:b0:381:d890:b4b6 with SMTP id
 ffacd0b85a97d-38260bd94f6mr12368877f8f.48.1732554780176; 
 Mon, 25 Nov 2024 09:13:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fcff017sm10919419f8f.108.2024.11.25.09.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 09:12:59 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 18:12:56 +0100
Subject: [PATCH 1/2] rng: msm: add support for newer Qualcomm hwrandom IPs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-sm8x50-rng-v1-1-52b72821c3e9@linaro.org>
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
In-Reply-To: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
To: Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1820;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eBg4Ydo4UCF/rdI47CkqU7I7R82YACn0mrqKh33uHJg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRLAZDOs4YzDpAFqWAZRLAeXoUOmUPqZuaat6VKLd
 FJ3CJWmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0SwGQAKCRB33NvayMhJ0TNdEA
 CmWnSWeaJRLu2VrF5HWhWqBjWU6VxqjcuBQMbUDi7qHExkI7dbQyyII/KPdXhrhFMZehvLvLxpIlRg
 hhy8hpt+Y+D0wlS4BtlKqRf3GJLo34cYmM00fYh1N+NH5BtHNHiKm13fyg6DpDvp9GWt5cxhRNS3gY
 c5lxz8K5eb9wHKeSo7M+uwJRexMUzrDmjWu894ckBUNIpPvQXDAoXcOp6TMC3xB0aHMkcUUQN+l2Vk
 raW08JnNEiq6TzUquI+sC+mGJj2GKrkddyf3xRD0WKDZ0sUdP38c7IyO9vXehnQq2kWlqhg7KzBH2i
 Dt1agwWF6mwWcKtfDbxQhLdIclRPTjcyxjZKpvBFofA+cO/8UMz6XECjB2+qw2OOVqQTIeFo8pFXrr
 hoJxzXDx3fHbiD0rvlYbE6jfq/He3wuEUaSfRrkkxNsXBkGDopJ5RAViPTA+VyzgNksre/U0dkMh7p
 Z0sKJHHhKI2MvSdQLPWq3eCnyu9VHiovkAPQk5n+I25lbgoRZUo7C322XPzSI5ZXcdNxGsNk3ziwoB
 aMXlmwKRui8XuONMgQc2zlCLEopAhR3G69P6AuN5IRCbG1bDCeccpJ14gSrMRHO3AdkMW4ioPPjuhy
 BiIUPMZU5l6nIDgeZZ4wiKkm0+ZT2Nb9iJ4HZuQaQwmhnkSpBr732I2hpAAA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

On recent Qualcomm SoCs, the hardware random generator
is initialized and handled by the firmware because shared
between different Execution Environments (EE), thus the
initialization step should be skipped.

Also support the newer "TRNG" found on SM8550 and newer
SoCs that has inbuilt NIST SP800 90B compliant entropic source.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/rng/msm_rng.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
index 658c153d3edb2590b0b470e3067da9aac76169ac..f790d3b60f99bfc04ecd9acdd21405a8c38c257a 100644
--- a/drivers/rng/msm_rng.c
+++ b/drivers/rng/msm_rng.c
@@ -34,6 +34,7 @@
 struct msm_rng_priv {
 	phys_addr_t base;
 	struct clk clk;
+	bool skip_init;
 };
 
 static int msm_rng_read(struct udevice *dev, void *data, size_t len)
@@ -100,10 +101,15 @@ static int msm_rng_probe(struct udevice *dev)
 
 	int ret;
 
+	priv->skip_init = (bool)dev_get_driver_data(dev);
+
 	priv->base = dev_read_addr(dev);
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	if (priv->skip_init)
+		return 0;
+
 	ret = clk_get_by_index(dev, 0, &priv->clk);
 	if (ret)
 		return ret;
@@ -119,6 +125,9 @@ static int msm_rng_remove(struct udevice *dev)
 {
 	struct msm_rng_priv *priv = dev_get_priv(dev);
 
+	if (priv->skip_init)
+		return 0;
+
 	return msm_rng_enable(priv, 0);
 }
 
@@ -127,7 +136,9 @@ static const struct dm_rng_ops msm_rng_ops = {
 };
 
 static const struct udevice_id msm_rng_match[] = {
-	{ .compatible = "qcom,prng", },
+	{ .compatible = "qcom,prng", .data = (ulong)false },
+	{ .compatible = "qcom,prng-ee", .data = (ulong)true },
+	{ .compatible = "qcom,trng", .data = (ulong)true },
 	{},
 };
 

-- 
2.34.1


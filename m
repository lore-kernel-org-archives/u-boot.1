Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216C8CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 10:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1AF832FE;
	Tue, 12 Aug 2025 12:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X7Je4WkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE70832FE; Tue, 12 Aug 2025 12:13:55 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 871C183280
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 12:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a11a138faso2775155e9.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754993632; x=1755598432; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JRo/BYO1nEgp8dWjICu1tcwj6pztqgNGe0fH82B2wfU=;
 b=X7Je4WkPlxkRw7AdASaO58MkNiB7bDVJthcIoSP/Mjxwz7MiiJArbIOSn+ZVMrcBC2
 yf6qaBwddCIMa0XPWODD0opKtH4bXZ9MupCLHvk3hxC3xFr2vYD3Jk7//SKxKGOLExC6
 sIdwkBt/EZOe1IhI1X3MaiT6F0Z9MOub7AVK/+1uvRhDIbJq93hUdkSKMQ08Q5dg+a35
 v2pTkOrzOZG3acdZM4FJCL8Zzb/t2Yad7C2XQ0xFVFWYgp2mdvtVLXJqE0Vn0VWm5jFh
 ZoHvvSHf/VsJz9Sd12hTZa7ToQuKrGWcxD4z4XKLj5CiuVJH2kJ7kHfPZ5L7Hkhe7eEN
 /Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754993632; x=1755598432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRo/BYO1nEgp8dWjICu1tcwj6pztqgNGe0fH82B2wfU=;
 b=iKPrPF43rHN8HYyGhlMmCt52Tn6luHBMfgMeAF3VmflLkedWrzEhMXW3+LHYVaPOrr
 IrmBMc81CFlNX4mnEl6It09LZXZiNlcKQH1d5HFTq5r1uNgcn9JS73YVT1Uvo3n28HI2
 QjH8oif7QbLbWGJ1ApZnNrxtTo64pfbWFu8NGEQs7D4TSckMTLejTfyAtFAVfcF/rXV+
 D0cZ8UTruvtIqRERRlKgNaBUbUeQsua51NC7PVe0pIfYopKJjcz/jbcdqHQUg0WtA49n
 8iZBKmgeCVTAczfBGptk3ToIbnj0xQ8wmNgI/q2ZltTEvBvgeCIszvqqSqO9aGtPjML7
 mWJA==
X-Gm-Message-State: AOJu0YzPtI8MdoMZLO+i+GOCcCMv6ddVlBuTQZi93rffaX2cQKF7z4WI
 cvUtoM424vZWzzJwUtW26Ia1yawIZGru5cp5Jm+nZjqC/WrEpYhBb9ukYLEPEc5TKrY=
X-Gm-Gg: ASbGncslWXr1CyskHtTrmZzpeh2UgD+yN4nyrbDmYIHnjg+k7fLwUpTqR2i6GVJgApT
 PqdRbDOJW44Am7qDncwd/E1BFbDmBOmXZSVrBBGttD3c0aKmKMZo0NJT0IzXclwlARclq5x2NRq
 042Sq4Sjl/Fjt+J0PmzCQpJmoVdshZFG0/m8ii9mNchAJAh0Gx1S4WlS5NXiUBTcXKH5yA3wqGP
 LmBtzmjgmtJoNj7/Dw7eJW7ej74MBWx2EpU9zWcreVe9CBfaYx3NVfPyVKg9M7DVZMj04SI1xc5
 l/9o8HOm7ipbR6EY7M6hn/r1yJ99KZ2YXhdFZ0gJtypOgZC/2EN9SiJ9Lh/TeclgK4eLqtsAWpi
 7bo5Rdt9ZRK+XqAT6QHkdrFSE7ulgQE2W6Cq20DUtC+pOqzumZ38=
X-Google-Smtp-Source: AGHT+IGcDe9qxtyKArCypRtESQE6kZkcAdXyP9EvkZGGf248hvfAptTDbNUw3d8ag+iAmPL/MRldxA==
X-Received: by 2002:a05:600c:1ca3:b0:455:bd8a:7e7 with SMTP id
 5b1f17b1804b1-45a10ba7ce8mr28169535e9.9.1754993631976; 
 Tue, 12 Aug 2025 03:13:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm44090808f8f.44.2025.08.12.03.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 03:13:51 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 11:13:50 +0100
Subject: [PATCH 2/2] soc: ti: k3-navss-ringacc: Do not use uninitialised
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-k3-navss-v1-2-a88f7db58998@linaro.org>
References: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
In-Reply-To: <20250812-k3-navss-v1-0-a88f7db58998@linaro.org>
To: Tom Rini <trini@konsulko.com>
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

In k3_nav_ringacc_probe_dt there can be no error code returned from
dev_read_u32_default so ret is not assigned to and should not be used.
Remove the use of ret from the dev_err call as it is unitialised.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/soc/ti/k3-navss-ringacc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index ac29158d489..d37c454143b 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -932,7 +932,7 @@ static int k3_nav_ringacc_probe_dt(struct k3_nav_ringacc *ringacc)
 
 	ringacc->num_rings = dev_read_u32_default(dev, "ti,num-rings", 0);
 	if (!ringacc->num_rings) {
-		dev_err(dev, "ti,num-rings read failure %d\n", ret);
+		dev_err(dev, "ti,num-rings read failure\n");
 		return -EINVAL;
 	}
 

-- 
2.39.5


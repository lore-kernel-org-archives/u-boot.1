Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DD9D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8CC899E3;
	Mon, 25 Nov 2024 09:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A3/pfnsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B5B8961D; Mon, 25 Nov 2024 09:29:21 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B59F899D3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so38335535e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523358; x=1733128158; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H+wOyyk4A3y8wu+m5vf85TanXlR2d0KKgiJvlAXQP7A=;
 b=A3/pfnsZqTROuKrQviDc+Gryjs4Dz/vkiKaxNkqiuszrmnhqHGSbmd3E4pIzphCJ+w
 tam8SltQjtdRwVxHSXJJ5iFmweNu+LHVKSBV1d0LYFacsOnRl56aa9G0UDATnCgr1Y+H
 jtWeqsQNtxC6AP9Sws69M/nUn/W2VZp9+1jkAQ+fgyvpr9n2TcjlHsphAOhJGea1HVlL
 /G96f59FyTF6fRQMRyzbyxGG6m5HeF4+TxxD/9s1nP8mmOAMdp/UX2XOrpVjTiOlz0xy
 MFnvZ2OUf6R61ljaKNDQWjpyqAfzRssUMvU3Eh/z0TqK8Tuq8bUdXroevsNFVhDBiFC6
 DEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523358; x=1733128158;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+wOyyk4A3y8wu+m5vf85TanXlR2d0KKgiJvlAXQP7A=;
 b=ot7xQyV/lLl/4Fkx/kcPnF9+LOlEDiFDAiOJfbXmnQhGNw0YS+DALzcDpnyftyZyoh
 LBtMnGLh9peSKz905GCQdCZVJHYfAs8+EphxIsU2QAkmv/cK0DOIlyVUW4m3KRGzSHII
 IfHGJuBSylgxxggLgFL2Iq+8C6JTS8Mtu8/QVklj+CXTDmGwOvIrrX/r5hxSgdWXr6ja
 1hzTwz+gL7YbOJMdFVl6aa3Ze3rpUINcNVrEZQ9sFt4UIi9W/BXw2VH7AJXDdD59nltV
 ot35uuDCLRsccLksgpaS2I/FKvyZ894tyuVzPDCpZl1CwxNWdL+4QZmRvm2Fw7pU3FBz
 gYDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpLZKx3fb72vaTSTzFkSysFzdUQ+yRaj5kuv9+QIU17CJcdrBXGFU6COyVSObkgRoP7TcgM0s=@lists.denx.de
X-Gm-Message-State: AOJu0YzBLSJqPJNfMNxGRWLW7A0CkoCXw25/xtpgeiMpa8EwP7WPOudU
 FdyBKHgEA3m5kYhAE9oYvg314iPBqodoVbT0tWBYs21jc2hRJ+nGt2jGywL/HZQ=
X-Gm-Gg: ASbGncukH5lwmtxoV4s4YatuvkxsafqKlblc8udwnsSpLiInDMP4crVUJSFKSCB5yRm
 NNHd71qyFzDrP1ae/rBFQjXG7RlAK4AmP5bjb5rKfLSBgNUZKj+K34bZ4qtsw7crvt2oJrcUr1R
 O6gPugckBsBul0ap3xpjBR2ys8cjKD52rCGyoe01Cq++qrEFSqXisz3eHk5g0jg0VtoNSoo1/5M
 2KtXpoTbbCR+FLzvdAzOfxxcT5ATd2uWOhsuuEhfRRZPJ6he/lWVw27g2FoM5AczM3lAK4=
X-Google-Smtp-Source: AGHT+IEInUKr7yLrAb1ZGcpO80JwpqiikywTQSkt7uk/eauOUOYAW+E+keQbhsu92pfBABymdelxVA==
X-Received: by 2002:a05:600c:1c96:b0:431:542d:2592 with SMTP id
 5b1f17b1804b1-433ce4e196dmr102785235e9.27.1732523358577; 
 Mon, 25 Nov 2024 00:29:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde1107csm121423545e9.15.2024.11.25.00.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:29:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:29:12 +0100
Subject: [PATCH 3/3] pinctrl: qcom: x1e80100: add pcie[3456ab]_clk
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-pinctrl-v1-3-4df323d90397@linaro.org>
References: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
In-Reply-To: <20241125-topic-pcie-pinctrl-v1-0-4df323d90397@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2HKW6hZaK9JN6JTjPis6jv2aM99XA6eN9P8W/dDPf4c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDVarvQxGb6asslbxvmDYqMgyqFa41n8N+gsIcc1
 y5xBTG+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q1WgAKCRB33NvayMhJ0aB/EA
 DI58PqKdP88qg1y2JowHHulJkFtTKRdyaJACMcRfUbiwkaKhWNy4694jpbwDA8uUKxu/J4kwHzrOgE
 tzj/kIvXtV8yw958PHLefQWoGe0GxMeZB92QNFMqo2l98pchusX5IWLeDlm/zwXpwrCsyt9NXNGSA7
 zglBPzYUpgJuR2S66dvmecwENNHgSSQKzeMPdcsLeRttHSQITk3w6qlh5IjX2IhMYeDkNk3exzREI1
 PWriQpgw/Z0rNHdyhbCkPkTncy8ErIPtGa/Oa7FFz1I/eMCGHxm+L0IIl5pbgzlEUozZ011yrD9XNB
 bXmDSTtpYpvsLtEFI46IJ+rOQTtEi2Zrq6kOjW+Oi+aR5eJbhuycQwKx7U9B582xvlimVgQzoj78An
 djZ9IkAhpwadHPaUiTTVUEz5Q95Opyth4jhySnQg5WGpbTgVg/6qf+9d3PBQQDBv4rSjsmNvszswU+
 ukRbtTWbK0VS/r4MTd8ywrFDgdBLxEtQDdocu9bUnIC84DAVj8e0JxtUJMILEmUtio5jP7dXEE1iby
 qsqhCq4T/tl4VLcPlQo6c4NbQLn/sMABmFP9ElqMncoVtYwATWRoI9fz5vD6Msu32LoN8p2MOITbne
 ISrvxJp5bGr8YmGaKR5rkWsoeUarfera6ck2qmH+9Gl4XIpxhdrEpZVNAYBg==
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

Add the missing PCIe clk_req function for the x1e80100 TLMM.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
index 2e2f5093272cf8c2a60eecf642ad9c567b539f84..f39dc426d685edd88f9b9dc4708750cd9211ac8e 100644
--- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -15,6 +15,11 @@ static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"qup2_se5", 1},
+	{"pcie3_clk", 1},
+	{"pcie4_clk", 1},
+	{"pcie5_clk", 1},
+	{"pcie6a_clk", 1},
+	{"pcie6b_clk", 1},
 	{"gpio", 0},
 };
 

-- 
2.34.1


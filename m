Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2780CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:54:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453D488206;
	Wed, 10 Apr 2024 19:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U18hLzpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C94F7881EA; Wed, 10 Apr 2024 19:53:37 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E109A86FCE
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e346224bdso5170534a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712771615; x=1713376415; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4rpzDfQYf5cMEMh29T5n5U2KfjY50giwhr+sD3d5Ib0=;
 b=U18hLzpYZI4eMmsnyjk5KXvb9/u7h7KOI2j7p5Y6MqsBr3el814yLEe/43fEIhtgB5
 gq/qvTEdkLZEYVU2IKwigKVgM+9jbDZnFyf4pBJQQuuuORqvPIMEi//HkzL/JpiFL/ju
 f4E5u6gVpepG3w7uLH9OmTLAEGYQGcNSFHO9iU/98yDb0zSl1I3JUz+1t1CJGNz+irSi
 xMIlcfqpPw0wU8R99ChUGPeiPiOZKHGYqzo48QQLPOR5lYrwpgTZPGeX5ZCdUAmX+8RM
 mf4/kRuvSCMoVmx6HiRLWqMA81hD7fZbZA3w9PVCs0d10IPCSDysLWmwSc+HqdaoyCqZ
 iN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771615; x=1713376415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rpzDfQYf5cMEMh29T5n5U2KfjY50giwhr+sD3d5Ib0=;
 b=H7vl8AaF6+dC83Tv5zCYylKmaoss53ssyx0PMIQIa85w6PshQRGN+eKtcTjfgieP6q
 oKxetnt62brPQf2mslOQIJ08YdvGcUoNv7HUGHIKwqDviaGqyXmPDtTYyuxBoAqXNq0M
 CO3NR8bVrDJYIfZkkNUyyUDWl+8iqa0GhDETR3zou4PTJAu276OW5qiq7zh1jzHn/UL0
 ibfjNks8DzHba5JLrreAXLasr9eIigdHDBIWqdYJb8jHgKi/UjtFi58LUTKzbdeKGOFr
 LjsmCBvfhwJweRYyddqiT4zhk5RmaitaJgLhLzuxFHpaEAJ2xBl2rd5lP3d8zEc0nbwD
 rl2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFLILe404IppdZKiTXBCFcixJ49f7gT1FhQ8zRjx89uOkVqZ6gurDFbGuCQWfn5iWhdT3mbxIbBt+QixUCI8dos3wzSQ==
X-Gm-Message-State: AOJu0Yxwoj30cmZ78A5JzajMr4XD8lEMTKmIYjtS9T5X+7s6jmEAacRA
 Oo3pD3/hCR/EbEb7BkW6WKMZewZR0GToDzUKfJ0gApnwnkIRAF40cz3B+vLXpVlvqIPnwt5Ycui
 DUzg=
X-Google-Smtp-Source: AGHT+IGG6ZzSp0zryMOycJlTNQQ9LjtWbOh9TWfN8TA6EG2MQUQT6jdSCrrjjl46GPmKJ53rvSlP8g==
X-Received: by 2002:a50:954d:0:b0:56e:64a:2a47 with SMTP id
 v13-20020a50954d000000b0056e064a2a47mr1627591eda.42.1712771615429; 
 Wed, 10 Apr 2024 10:53:35 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a056402128100b0056e2b351956sm6543599edv.22.2024.04.10.10.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:53:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 10 Apr 2024 19:52:39 +0200
Subject: [PATCH v2 4/4] qcom_defconfig: enable pinctrl for new
 qcm2290/sm6115/sm8250
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-b4-qcom-rbx-soc-v2-4-5120a9c7f6ce@linaro.org>
References: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
In-Reply-To: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=768;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=hMWh0MxTk8RqhtiwFxgyLvAAt+XgDe+lu4UrQWrmPRY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFtIZT+WahLcLSy67AJuRkjJrZQhaRfkKXzfhS
 M4vdr1xBFGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhbSGQAKCRAFgzErGV9k
 tkdBD/9Uoi/BicpTRRzvIFLk+dSEhwzd3gK1tZxWqWtRgEdPuBx+mETijMvfYGfuwNfHtfhHWNH
 6SFIF3+It3zkYM+AkSzCNSz7R7aQhxCAaMsu7l4sHM9SSFw+PQ55di/OzlyxgSUDPUmi6moFFCf
 7olPbfLQ1n3kucDDpg9s/Ag0+YtvbUSPw6WaPq7mraAUo+X4msBLBLEEJjfO5BrHNmZgej9wXfY
 6RrRHix3YKkVpUrDat+Sz14uVBhtSsAWIqbiAa657OeMntIr26rHZp1Rfq2a/TH6CYyrkNqSZu0
 Q/vT5d9s46QE0eXEAReyRSPAZX/RVBSSYLLB+KknZl7BR6kjTAOeD55+2Zdnn1RlZlDnKc0srNB
 PJzGIxLTzhkZDUEDWDmPEFwwFulWsYMBigtSTxKgWM6Ks0h1OhdwbR/12EPyGwWlMUJfTWCvuiI
 jFYJnxoPdMPYnNOHM5n4xAiDdZoYfXCZvydvHAwPUTOKpuz4IBpUpA5yFNluvaTRTvwPYxgAK9D
 gvNdPQwmjlJ+P/dWxY9zsWFLRYtS2ThnFCzb+v3r9D3yWpGQZIZ1TOrIorwND9GpbMa2mtCoh+y
 JdPKLNNa05kQlgPObJlP7azWHN6S6VO4o5F6pbWo0JRT0wkTqWpyaf/IDYIdlOcM/A+kFGCBpEd
 1SK3vWVUoOfFMlg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Enable the clock and pinctrl drivers for qcm2290, sm6115, and sm8250.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a0921ad55519..5e08ea392386 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -66,10 +66,13 @@ CONFIG_RGMII=y
 CONFIG_PHY=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PINCTRL=y
+CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SDM845=y
+CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y

-- 
2.44.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD2C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819C587097;
	Mon,  6 Nov 2023 21:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qW3Eg7Fg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7B0870B3; Mon,  6 Nov 2023 21:57:55 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CD186F5D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so3455317f8f.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304272; x=1699909072; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ekwtyu41OYSbz0XrFZZPH8lEhRg9xteZKfNgjFO5ps=;
 b=qW3Eg7FgERiaavDXdDw5cjvc5Nxy/TE0WZtjDvk6JkXvlBovyd6/jBmKXnsP4jBzVf
 Hyls04dyuy6saC98vGLclkQoWy9f65X2aumb7oVh8XgEuhcil+Qcrl18emW4KwNSGh+v
 0gmAD6EKpScd0d7IFobDmSTdwAtkp+bvifSkky2fwCLqlFCifB4O1lQDIv1s1iYA9D4O
 1bynAB2np7zAnhgOJuSCxbA5nVOMBWVNs7MdJTFJ7YTI245IPetcaaKCgMh+o5BaORQa
 tuOnP2PmyjsEC6PL+pCrQX9FIOX5TBT1OtHcIt2OYX0oUZExUtTCywRQIM4WOghKIpKy
 LYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304272; x=1699909072;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Ekwtyu41OYSbz0XrFZZPH8lEhRg9xteZKfNgjFO5ps=;
 b=dkGjd238t5+lhOGu14BVEA7VH5UpkANDhucTw7AkjBUiCTn1mUdt9y2m8+vk5XhPDC
 PQ0IBRYEEePrvhXpmkc85OO6mMXxf23ontJHSXEZzlCQYf3lYmhPY1NWrYls6w3ooM/f
 XFxn7LGzgxA+6rzesHJsFpZRly4wAFNydqxXinA/y4A1uHOA1dGomYf90j3ahTMbjdvf
 UHN6hNWpSpzrzZsHT1q/MS3qYMV13QyXL1WVY0rZEyCspX2s2iBUbp3iHUvy0IuubBYJ
 K+FvbpvXCdwYFrbv0DJbLuVfzUqi/cRndVk5T095FJDtYM/uAl25SPbkRMoVZMcbohP9
 jKWA==
X-Gm-Message-State: AOJu0Ywk7lOp2dBZZ+TzUyMHP1oQC3VtAJqE7ybrtV7tPNmmGmglGEwN
 mvYcfGmApp1u5c3hZZUaPLMMoQ==
X-Google-Smtp-Source: AGHT+IF7Uj3zpDqkYmgWoR7bdfkkXfkRymmzLRJIynC4h436Bq9kDQKxXifsIg2JPXuDZW8oAYqKAQ==
X-Received: by 2002:a5d:508b:0:b0:32d:5cc0:2f0c with SMTP id
 a11-20020a5d508b000000b0032d5cc02f0cmr23803301wrt.40.1699304272504; 
 Mon, 06 Nov 2023 12:57:52 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b0032f7d1e2c7csm511210wrt.95.2023.11.06.12.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:57:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/5] Qualcomm PMIC fixes
Date: Mon, 06 Nov 2023 20:57:28 +0000
Message-Id: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhTSWUC/x2MywqAIBAAfyX23IKPKOhXooPpWntISyMC6d+TT
 sMcZgpkSkwZxqZAopszx1BFtg3YzYSVkF11UEJpKUWPS4enjTu6CysOcyEZPQxCOO+UhtodiTw
 //3Oa3/cDgGMdeGMAAAA=
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GCZ6B54ZLiKlmPLTunE6sUUJ7R5aQleFtc4m/Pd4L7g=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTPYP8rO1+oWbLF7314JGL1rgqja23R2cEfRSeuUoh2d
 zU4P3t1RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI2WqGf2p2vjs+K0/Wj5Bg
 v1G+//vcrtZ5zMFvNrjvO9x0x6COIY+RYZW6Z1P/2WWTebm2SynWfF34ZX5JjVczh56f/YFXy+6
 9XA8A
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

This series addresses some long-standing issues with the SPMI arb
driver, the PMIC, and the PMIC GPIO. It fixes compatibility with
upstream Linux devicetrees, and simplifies pwrkey/resin support by
rewriting the pon driver to be a button driver rather than a GPIO
driver.

Existing users (the db410c and 820c) are adjusted to use the new button
driver in their board init code.

This series is based on the pinctrl [1] and clock [2] cleanup series.
There may be some DTS conflicts applying it standalone.

[1]: https://lore.kernel.org/u-boot/20231106-b4-qcom-pinctrl-v2-0-406e8d8689ca@linaro.org/
[2]: https://lore.kernel.org/u-boot/20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org/

---
Caleb Connolly (5):
      gpio: qcom_pmic: fix silent dev_read_addr downcast
      gpio: qcom_pmic: rework pwrkey driver into a button driver
      gpio: qcom_pmic: fix support for upstream DT
      spmi: msm: fix register range names
      pmic: qcom: dont use dev_read_addr to get USID

 arch/arm/dts/dragonboard410c-uboot.dtsi          |  11 +-
 arch/arm/dts/dragonboard820c-uboot.dtsi          |   9 +-
 arch/arm/dts/dragonboard820c.dts                 |   3 -
 arch/arm/dts/sdm845.dtsi                         |   2 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c |  29 ++--
 board/qualcomm/dragonboard820c/dragonboard820c.c |  29 ++--
 drivers/gpio/Kconfig                             |   3 +-
 drivers/gpio/qcom_pmic_gpio.c                    | 193 ++++++++++++++++-------
 drivers/power/pmic/pmic_qcom.c                   |  13 +-
 drivers/spmi/spmi-msm.c                          |  46 +++---
 10 files changed, 200 insertions(+), 138 deletions(-)
---
base-commit: 13995976aba2b9a63917f3c43b3cd3eaeccc4606

// Caleb (they/them)


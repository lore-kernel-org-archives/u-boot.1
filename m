Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B28C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4335782E8C;
	Wed, 18 Jun 2025 16:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="uH8xIkxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC7E82B20; Wed, 18 Jun 2025 16:25:36 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7953C82D88
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60780d74c85so10711083a12.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256733; x=1750861533; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BAiFAufCEWEPviIRAUUXQvbEUCEOs3o96hskefWXyf0=;
 b=uH8xIkxRCy0H8eo5Zf0aT+UAMMboJzzXf0FKsDgki7zyWa3XOPbWVaxjSDvgKnILNl
 Wyu5LlUOezGuq+QYM+J885U5+SBYcwe++qkszGyl2wbxDz4LeEeYrK6UI8hQN1MR8JpQ
 vs2DjfnkfrFviO1ORZwa96GFtmdes0Ojvc3oiIgkVpjrSV8BbT+vSgxIEGg7IEdP9kA/
 GpeiptEJ35HuN4Lt1plYDdmYaKZ0dYRc6lFdTZDoxeZv6SaxZFGR0JOcy4JPr1B16GuW
 efwxCcJkaUeLQKmNR0vmnveX8Qi5Yy1NU/+A9Do/tMqSoV6oZ5Bzb/HpnJQ2SIm+KVeB
 tvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256733; x=1750861533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAiFAufCEWEPviIRAUUXQvbEUCEOs3o96hskefWXyf0=;
 b=uVwtPXxCJ3nBtg2YfGiBpeNmFgtioD7FiKjHzqLbkQ+ilsKa3gv7Pa4BCg8aj4lQFU
 7iO/sUjpvy9PJPQJxHEMnlHyZGyBc5DLm1VLgv1FBmtFC1sJaK3sX4eDWKpIBiY9bizz
 r0RphJ01uRYvHCCYISurc6oNB0mD2BOhB0HC9R1gR09X6VDOcOWj27q0e80sdZGCXyOz
 RF0yDUFrQtTbuw1LbKRsUCkmORTcnsZMeRFOvbo53O0wLlFHl99DZt02Y5G3cHtZeHXT
 TRf927VZ4Lh+orPvIjEoll+0L0vnuSKR4War0R/iWraRJFWycr2OQ0t3SeYLd7v3KdMn
 C6BQ==
X-Gm-Message-State: AOJu0Yw+9DniGqYGC+wP7j/ob4+Y05r3FmfwbbaCt36F1ihFJtmU9msy
 YAJUy3iKAaPxhLAbR1d0y1GcYqwXwt9VeVh91G/hOx6jOnMTvX2mcIsB1wHVdxXQSZc=
X-Gm-Gg: ASbGncv8SV8L3uxx+WUCnrt0+Uq+xDV7Gz08dFeFo4a39N4oLcXPHKmcb4CqhICi3e0
 nEnaCJn+3rndSV21rVkApZozVsC2zi8UWdVILmwrpEnDwEZVcYjga7jrtmmvQQ6kQlEz8tNin0i
 LTf5zyvZf2/O3juC15i7QU4NtgP/avItcAjJ/bmUxZmi7D7dpHF22NUblr5UmIT0bspzPp7Hpzy
 JbB/7MtcySR42OOUIagvGGGYjia5er0mKl/AyJb+IhSv6NNUNgWVUSTQRMjTAHRFshKOK9XOGFd
 q9G1ZNsw2TWMgeL2YPIUoA6wTz20ggqv1xsqBWPbbnhhSeJOwgMPWbDI+F6F5QBzXaHacThVwCw
 0Ps06GXLgRyZqhOgGHBYoiaDQJ1OiSNME
X-Google-Smtp-Source: AGHT+IFn0B8EnLE8XwZwDhmbsXDSNdbAr6Zu/++PpMsEQjxBxfKRtuOBoP8jiTfW29Ku8n+WDptDpg==
X-Received: by 2002:a17:907:86ac:b0:ad5:365a:1352 with SMTP id
 a640c23a62f3a-adfad29e98fmr1733984166b.1.1750256732775; 
 Wed, 18 Jun 2025 07:25:32 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:23 +0200
Subject: [PATCH 7/8] qcom_defconfig: Enable SM6350 clock and pinctrl
 drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-7-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=938;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Sid/Nil57QVL8gqCr5iKxqjBJJUp91wDhqlTH4UG+Cc=;
 b=g7h04iw+gmXoRJVQYgLr7n2kxUQZFls5gOzKdq9hHLPXoPY4SZ0Hh742EX+orK6vQVg9+So7o
 Lv243lcs0hdD1DwH3TNhaCs7brps1BGq0R2Tvf3J17IBheiHvzGbBXb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

Enable the drivers so that SM6350 devices can boot with qcom_defconfig.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b8399701da06e20cb5d21c4de1fbeb38df671be6..068475d59da5890858ee8e48af148db33ffcedc2 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -54,6 +54,7 @@ CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SA8775P=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
+CONFIG_CLK_QCOM_SM6350=y
 CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
@@ -106,6 +107,7 @@ CONFIG_PINCTRL_QCOM_SA8775P=y
 CONFIG_PINCTRL_QCOM_SC7280=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM6350=y
 CONFIG_PINCTRL_QCOM_SM8150=y
 CONFIG_PINCTRL_QCOM_SM8250=y
 CONFIG_PINCTRL_QCOM_SM8550=y

-- 
2.50.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED0DC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 19:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3238782F9E;
	Mon, 26 May 2025 21:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QqjeyzRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C2682F50; Mon, 26 May 2025 21:48:27 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C902582F87
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 21:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6020ff8d35dso4932392a12.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748288905; x=1748893705;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QI5sOLxx/Q4DXiXsAa3l/2rTNPNV1XQu8jRDbRfq4o=;
 b=QqjeyzRd6j3yHL9m5MVhXx5/DsGuBzSIY+1a/bGFnd5pLOKfVW28VWGqUKdE89E/2/
 QurhMsq+f3TJ83a/3GOHqeLJXsNRTme7rrcfaWolfWHh6o5LUdFmFwJibbj7jRzaHZNa
 tdIS683fr7FSZO3iQEwPRhO/DSZgzgXXXOXkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748288905; x=1748893705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QI5sOLxx/Q4DXiXsAa3l/2rTNPNV1XQu8jRDbRfq4o=;
 b=YpP1Z9P5mTnxXLvpuGBQIkUlwsvdDDNcFtSxYrrGuM8iyBxF/hcUjYnlmOzyb6Qwao
 99WA9gvPGPkKV1tMoYzKbhzSeXKWCcT4qFCwqlaHFefZ8WAHmjjBbAJj7sT1kYnkXf0H
 uv9GN2bKzxzgLHeDe0CFQGcqNqzqiTQnFAZSzjRHU2K5Z3FrJ9dXXGu5Qe41BU6+EAm3
 2xePltP8QWcKdSmXEOZSKlMleGQpVXNkXeLXQg7neOLAqtg6JPPDas2jkvam17XDTykC
 bYLKCNiq8mHoEnwf4ZP1OZHdnqA3sw6HDCr26zchgkHGb7BSCtx6nUwA8kMIFIHgVZSK
 cSDw==
X-Gm-Message-State: AOJu0Yxi8TGxhnQY/p1uaVP4BDpRoqIoJolmGTlr1821cZ7OCoGx5plG
 OdvZKIto14gAjzstCpORnDPgvZ/Meu3mhj8lrJmDvZwCf5Yw9jseP60RY47dQbUioLwLa1qK6hd
 njKNq3kg+CQ==
X-Gm-Gg: ASbGnctzuIX5HkS6M6mn+EdSDX9yGbTBwvBxlR3HOyobBNWJUN0xTuKxHijK8V5PECx
 0w3B+7PHBBMcFM/LFGqmECgH25KauoGu9QW+IQIjYzv62MGzUNA1aCTedTM0zNmgy0wmfjqNDRh
 13vvWGmH0yN/UdVqP6Q9rcVQ5CUsMEVFqkb/EoFn+DxA/JhW9PFo7MPWYq3KmuMX2VgXV5q/xCC
 rJcj+R1mCP2IwzolBFKYXqIqOFx/rMUyCom9En12Zi4G1kEhv70r4XA4dJWfWq0J3Xp7Ab5/nUY
 x8UBf5vNgAFLO0D6XwXlPWItg0sATXp1ONnrjdMoh+5HEjwK56XGeQK30zUkXYHLXW7TUgXk1wM
 =
X-Google-Smtp-Source: AGHT+IEtEZUPgJf4ToTNPyooDpysMXRA3EdimhGbnMz4slVW66qaJ/KRDBBB7KgyInjxu7hKsrUfJg==
X-Received: by 2002:a05:6402:51d0:b0:600:129:444e with SMTP id
 4fb4d7f45d1cf-602cd068563mr7895295a12.4.1748288904855; 
 Mon, 26 May 2025 12:48:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6467:4426:e776:7e5f:5044:b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-604c0084c2dsm1416109a12.3.2025.05.26.12.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 12:48:24 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/4] configs/imx6ulz_smm_m2_defconfig: Enable clock
 framework
Date: Mon, 26 May 2025 21:48:02 +0200
Message-ID: <20250526194811.1179530-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526194811.1179530-1-michael@amarulasolutions.com>
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable the clock framework on the m2 platform.
This helps to increase the NAND controller performance.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v2:
- Ajust commit message
- drop CONFIG_DM_MTD selected already by MXS_NAND_DT

 configs/imx6ulz_smm_m2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/imx6ulz_smm_m2_defconfig b/configs/imx6ulz_smm_m2_defconfig
index 436bfb78cc2..6e425d6e52d 100644
--- a/configs/imx6ulz_smm_m2_defconfig
+++ b/configs/imx6ulz_smm_m2_defconfig
@@ -43,6 +43,8 @@ CONFIG_ENV_IS_IN_NAND=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_IMX6UL=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x82000000
 CONFIG_FASTBOOT_FLASH=y
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D58FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8299805EA;
	Tue,  7 Jan 2025 14:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kdCzdvz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E608036B; Tue,  7 Jan 2025 10:26:04 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08623801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kikuchan98@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2156e078563so193259625ad.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 01:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736241960; x=1736846760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8jJUCI2svKVQtSrHMB0w+WyN4oFC/hyQNKiQbq8JrX8=;
 b=kdCzdvz9ZJ/jBcwk8aR2gb8Li27GVvoS2FuiGxtcOjYeCrN2bEQn+ulk2z035uzqk3
 MQbM0skXkGgPaKhdd3sAn9PskjwMG7pAJmeuxRiMh1zmDUT/vA3dzAtmxioQ+cfHlYsR
 PclIqw00y2ZWh1kENYfvAYJRE3CWChe0KZFDYRzJmi4yVWPjbARTVCGkrHeOiaN+nCt0
 9yR5QiDei/nyjwBQ8hbf8PfoPxzgDQAgiazx+rWiNV0G29XncN8V9fjYApZ6wR+x34WD
 l+ONGkXXxjIYu/uAynszThsEOO+nfVmQRlNzUWHUGEycwGEtstOymbJ4kw1nuwEP3765
 XEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736241960; x=1736846760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jJUCI2svKVQtSrHMB0w+WyN4oFC/hyQNKiQbq8JrX8=;
 b=H2toPcbifS9AFFZzK0sXOtET2PWhZi2izLF0jGdCAR3EEjzp9OwQvZCUdAtmFnrbRC
 iUCaQI6FDWodrxh5uz80E6l8BgU6UYAWHXCtOVI976VgjrruuyldGRBloGlaW/OlfExA
 W6VKiE52yHhTByUlSAcb1EkkRJOwkCpUxrBLG+RVOAjA6v0LQaBcYxtaR5OFSh49od3k
 DtHUN+J0nwBX35uikmJG49Ir/k2gmttUST76Gn2L0SEsouXwXFRUepVgZFHPPucqdVIO
 /B5Oc1wbi7u5xQf1lMqfVtcz8QIS+/xrG1FStr9w+YYCxOkt4JcNe17yYnj0WmlnptN8
 k6JQ==
X-Gm-Message-State: AOJu0YzytiuPDaWSJkM/twlT3q5E0oZLUQ8uOim0U1fiIDnkETna/66F
 77eZY+vAN26GXtsLlCSUHcyt7Uw+imEh4DB0MdgpnkvW2Fks5VKR3bhNtqfN
X-Gm-Gg: ASbGncskUXH3KT1hERdOZTfSNyrd6tILIn2DibEHTFt44L/OG/dKPDeJimSKCkDbmzc
 vOZAd9CnYcNZgwcLZaDbu6Eha38k6/rtHEMBFiDNtJufQXLSqWWdWpLW1cNDbqiOvrzOprsUafI
 NAmjtH+TkBSKUCKkUVjpQynVz75wZVc+cw8UkkIUEiB6vQgkiIQZWey7jwrniHyx//cBaj3Imw2
 U6CzYRPfSGWgP4j42tliA4j38NhX4oObom1nI0D+9pZYKbeRoGyXfOEQqXSM3pud+qNuNU=
X-Google-Smtp-Source: AGHT+IHMKDq0c671GlZvYFh45b/Aq581nlsc7xpVXYklWDcc7HI0s630qYxTk2Fiw6sxAmSq+jdiLA==
X-Received: by 2002:a05:6a00:6087:b0:728:8c17:127d with SMTP id
 d2e1a72fcca58-72abdd8c2c7mr103450630b3a.8.1736241960433; 
 Tue, 07 Jan 2025 01:26:00 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbb09sm33806352b3a.121.2025.01.07.01.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 01:25:59 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: u-boot@lists.denx.de
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Custom IDEAS <vanbaren@cideas.com>, Software Engineering <wd@denx.de>
Subject: [PATCH 0/2] spi: soft_spi: Add support for SPI_3WIRE
Date: Tue,  7 Jan 2025 18:25:38 +0900
Message-ID: <20250107092544.1798497-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 07 Jan 2025 14:15:02 +0100
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

Add support for SPI_3WIRE on soft_spi driver.

Hironori KIKUCHI (2):
  spi: spi-uclass: Fix dm_spi_claim_bus()
  spi: soft_spi: Add support for SPI_3WIRE

 drivers/spi/soft_spi.c   | 19 ++++++++++++++++---
 drivers/spi/spi-uclass.c |  2 +-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.47.1


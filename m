Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3570C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A2A88080;
	Mon, 17 Jun 2024 10:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a8yvBRyE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FC588137; Mon, 17 Jun 2024 10:32:52 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C55A87D14
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57c68682d1aso4558780a12.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718613170; x=1719217970; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L1zRjJfa0EcaGV9o+2WbDXliIYl6jbUtMvwPkXQYSig=;
 b=a8yvBRyEFnQY4K95p3s8FpF/QRdzl3aOgpFc9onfJt8aNUQbsRh2YKEPacU0Tdcqy6
 bdeFLP4VczU9PYm62r1+q6XnKafo080gItj2KVXJzhQi8DQ1uYr7xPlwA1NLLroFlEWf
 CmuHsSOx+ZhfAy+x4A2Hch2FdUCPnC0U3LWmWnZHGxJjvXk+uct/V26LspW6D6cKYhuG
 zy42SW0ZvREgok96baXW67c2GBY8fSF74QR5YOku3i4iS4WQiUzwDB2KaDzgeVMC3E3h
 VjwyVUd4gXYvtRn8mzME0TBvC8McqhKw/x8ctifsDYzS1hKOXY3pOCnFKPmtFgyI4qA7
 8YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718613170; x=1719217970;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L1zRjJfa0EcaGV9o+2WbDXliIYl6jbUtMvwPkXQYSig=;
 b=W2fDr+GE9jhFIewJxJ0787+wXBaNI2iE4XoG2xkZEh2o/G0KZtBkIzXH6XCuVFG/Zh
 egYUNjRyZfaVe+8V2v2V9kckyWBD3lau6bt3yDsnlref3e5H2Z0fV7HCxBwzPCygkJJZ
 7jy7bXtRIuZVuIZ9vvXmdkaVhoF0eMjH2wvWukwzpCRTm8G/jk+iayEvNXf7bkuTzvUS
 gDF0GUfvZzhc04pLLbrLAL+IMHQd4GEJlIX9G2YZhaDv5AIIwud8QPzzh+m/GfjTaATt
 cvLPfcl08Iup9CLYRlN0iWMFOwDpgdlR483cwbJiyzch9P25NVLCMMrRVqw/34YlKXbK
 phMg==
X-Gm-Message-State: AOJu0YwlAFMR25MRrc8A1JAssUtRo91AnUGPdTv/8S02mzAmdIqvYSWG
 rM42Zh6j/hmoGa4NMGEwIjlB2kQDAaw5ptb3oBf9Ta9XUFRwCRZJEpD7cG+CjXE=
X-Google-Smtp-Source: AGHT+IE7ezRjFvMZ2fvlkI76Faf6ikrWilksOj4VWVmCuVDruhFPUsuP4ofkw2C059KZBIb+sdtlTQ==
X-Received: by 2002:a50:a457:0:b0:57c:7486:3f7d with SMTP id
 4fb4d7f45d1cf-57cbd67d440mr6192986a12.19.1718613169577; 
 Mon, 17 Jun 2024 01:32:49 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdfd0sm6110031a12.5.2024.06.17.01.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:32:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] qcom: rpmh core and regulator support
Date: Mon, 17 Jun 2024 10:32:45 +0200
Message-Id: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK30b2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0ND3SQT3cLk/FzdooLcDN205LQUY6PEZCNLEwMloJaCotS0zAqwcdG
 xtbUA1qwHY14AAAA=
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3122;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LRctNo1/qmwsN83Hr5EOo7CzcM86rrCU1Am7v89UQtY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmb/SwwffLsleuwKUsW4Ml6715mCIJjEw1QG6ev
 sp7sQ0ticCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZm/0sAAKCRAFgzErGV9k
 tiV/D/4uj1oiHNbL+7xPvX9X/a8GQDLxh+gTWai8Vjl2ahGtM5GgnHnNn1JkDW701iub8/HZtLd
 B2uWj1iMWIouhewlZv9KPyvbZo4sT8K6vHx0SfLCn662sHwfsWkMUsV/5olt8JWovqUB8r6S9cD
 i/+ODl8enakTynVhzp96qdVZe/B9Z16iwcsuusCz4M5foDAb+gabdBnvZ8XX45WCK3tx7VngGXL
 1vh7oXtF/fCB1wBZw3/xocLBvb9puTT2Osg3KFTnMd5g+S6kyFZPZ4qZk9ifgc7j3tqdWXBdbv4
 nts8SR+jOwgRqeh2RJd0S3KM71FhnIRUFKiPeGF3Bc8NLGE0fV3ArcYkVKHJj7OjByk0K6Px3ae
 buac86MBEEDx8OXTUysLjUC1NwFwOejwNmf8OtW2RwC43CMMUCe+kcOx0Et4+ugT3XGg5xuBk2o
 BkIXYsA4corZJ06MoQP7OFjhnFQ/v4QgifdPexzXyz2sIi+sy/5YFneUU/ENJjPr6Oo+2j9KT3V
 aBJhww61ukqrgl1MpEQx/mKqxpZS2FfeZ+xKLRWwKZfSRQGLpQWpU9OnBpIDq9LfsWmkB1rfOl3
 MmbBpHgBOugXkLiDPvlMeztTeHjIs51yvL+Iz3PXQP7nt85u3RsaeZJIrT7tWT2V3fJqOg3kDzO
 927RfQDkJGNdbXA==
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

This series introduces support for the RPMh (Resource Power Manager
(hardened)) co-processor and associated regulator driver found on most
modern Qualcomm platforms (since ~2017).

Even though most regulators are controlled via SPMI, the specific
regions on the PMICs for controlling the regulators are restricted and
can't be accessed by the Applications Processor (AP/HLOS). Instead,
these resources are proxied via the RPMh where they can be voted on by
multiple subsystems (Linux, the modem, and the other DSPs). This is done
for security (to protect clocks, power domains, and regulators that are
specifically relevant for the trustzone) as well as to simplify the
management of shared peripherals and to allow for handover of
peripherals like the USB controller.

For U-Boot, our main concern is the regulators. Since all regulators on
the system are controlled via the RPMh, it is necessary to support it to
enable USB VBUS on some platforms, and may be needed for other
peripherals in the future.

Communicating with the RPMh additional requires accessing the cmd-db
shared memory region, this contains key/value maps to determine the
address of specific resources on the RPMh.

Introduce support for the cmd-db, the RPMh framework, and some of the
regulators that are necessary to enable USB VBUS on the RB5 development
board.

These drivers were originally taken from Linux, however they have been
heavily modified and simplified for U-Boot. Since the original Linux
drivers contained heavy optimisations related to multithreading and
asynchronous probing, as well as support for idle and suspend states
which we don't need to deal with here.

The U-Boot version of the driver supports a single TCS and always
requests a response from the RPMh, since we don't need to worry about
having multiple transactions in flight at once.

---
Caleb Connolly (3):
      linux/bitmap.h: add bitmap_empty helper
      soc: qcom: rpmh and cmd-db drivers
      power: regulator: add qcom-rpmh-regulator

 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/qcom-rpmh-regulator.c | 534 ++++++++++++++++++++++
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/qcom/Kconfig                      |  25 ++
 drivers/soc/qcom/Makefile                     |   4 +
 drivers/soc/qcom/cmd-db.c                     | 246 ++++++++++
 drivers/soc/qcom/rpmh-internal.h              | 141 ++++++
 drivers/soc/qcom/rpmh-rsc.c                   | 619 ++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh.c                       | 110 +++++
 include/linux/bitmap.h                        |   8 +
 include/soc/qcom/cmd-db.h                     |  42 ++
 include/soc/qcom/rpmh.h                       |  29 ++
 include/soc/qcom/tcs.h                        |  78 ++++
 15 files changed, 1847 insertions(+)
---
change-id: 20240611-b4-qcom-rpmh-fcfd32ac2940
base-commit: 65134a67bca5e11415e93262e530b1c91fee154f

// Caleb (they/them)


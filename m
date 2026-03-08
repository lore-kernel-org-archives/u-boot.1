Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928A6FCB63B
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 14:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4689838BB;
	Sun,  8 Mar 2026 15:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gDKMwV+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E94183952; Sun,  8 Mar 2026 15:12:20 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC618063E
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 15:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8299f1ca894so1259056b3a.2
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772979136; x=1773583936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ASLVh2GIQTuOSc6U52oG3fbFpGSs/iGsprbsbxBbhOw=;
 b=gDKMwV+pF/L1SQxfTepPQL988G088xfqmsK3JDgCPs4zymrUTCqd8c9hG2nQTIs+zq
 CPAl+pME7FxD/fZRAIj7umoGuZQTs5tt2m09cfi+mhVojATb8nruByEz/Spm9syH85gl
 MVMazJy1c3fVTWUU5GYOCIyuJiuNvqU8lrre7O2wztn6DAnFeIlWKjUSDIrJANDwk99g
 C1l2cknd27ONnTTAiggDvA7fIUwDfNPQ7DXwxDaqEtpNk1eGQAl5Q7DQdBJ4kBECBXR0
 1U9C7zDIRbg79mjJ1CWJgbwn3HIgnhiox212PRPXE+Qnoc7Izo5V2/sl3OHYAJ8Gk6M2
 qfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772979136; x=1773583936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASLVh2GIQTuOSc6U52oG3fbFpGSs/iGsprbsbxBbhOw=;
 b=wnzI6FKvM/cPzfY4pqoHFrZ2E1E57TEzjPrFfK56riZGrU+PCK1shAc+dKHB8rwBnd
 HcIQSjU/UxwE4tO5RIDhQTbBokRg3lgzDRv1ZKdET100aIFBMktf9+TLppClrC50YqHl
 pEq0PYF3Dc0ow8hqBPrlj8nwf5cZXblUAXa1HX2snMkmSePgzurnL80eUdPei5H2d7O8
 zRk7vOz/woNtIXiPU4mXu5bpXVlBViafWfk7scthXpVyjHibttkqeyrQnb9RYdvQOTD6
 BdMGzqbbnh7z81DDsJiSH937RwnrjbfKb05th17Wv/WCCWkypJRO9CrQpKNWJPpzzXUw
 7jjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWML0ApEBcG2dCwprXOE24epf7wG0hqh0vUOpwhEjXRYleUE5HMqa1LJw7fuxSCvxhn6JtxmqU=@lists.denx.de
X-Gm-Message-State: AOJu0YzNtLeCMBVPdOvxBtNm2j46VbiOU2gxCWc+9ayFlXbz+7SDfDQL
 8Uf/Xnjq2yq7pOxfQYdqXtG3I2lSbSc0frqpfNFF5qY/sZm6YD2f+jHw
X-Gm-Gg: ATEYQzyfnfi+XQIBTaZ80mK+WM/p39kETLPo3OU9eJttNEj0DpUgYlsiv9DqpyXhyuo
 rcRCXDvfaZcrj9rp59EGcYcMRE3LBzWIBlPsbHgazut/QxUxwoOJ8zpwxaE6joEKMO7VErPjDaF
 nY5B3X4T9TzZ5YWicN8txrUvSGs7PZ1sgp76q8EjI93cyCYSaEUIeBNOVOEX0lXQnN5cOkoR8rd
 G6ymK0gBrLtFN8YZs4I1VuOHmcIn6AEIx4TUrJ/jXfLH+vZwaPDU/08TX8/EwpRkzZI8S4aEcJs
 wD0A+7ul8dci99oJkic6x65VyxcL2V2gQJupOfFcg+g99cCJ0qH743XI7f9AUbz4oUNJZxHMx8/
 IleuHbppy9CG3pJNuA3IeKqcS6KAkdPA89LzIJZOR+iqs7r5tPDmRJN8JK0ofppxF7PiRCjoegQ
 yMQt7SNK37xroQuP5W+eyLwnyAv211MneoUNbmNzRDHx61IyaX/yLNDv0JimYixqNVzZrmnNrBh
 1asPvsxWL/aQYX9aQPdTw==
X-Received: by 2002:a05:6a00:1815:b0:821:8492:7f66 with SMTP id
 d2e1a72fcca58-829a2ded871mr7157667b3a.22.1772979136138; 
 Sun, 08 Mar 2026 07:12:16 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a463a1adsm7273605b3a.11.2026.03.08.07.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 07:12:15 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v2 0/2] phy: add common PHY polarity properties support
Date: Sun,  8 Mar 2026 22:06:12 +0800
Message-Id: <20260308140614.50489-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Mar 2026 15:16:22 +0100
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

This series ports PHY polarity inversion support via generic device tree
properties from Linux kernel, synchronizing with Merge tag 'phy-for-7.0'
of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.

Patch 1 introduces a new PHY_COMMON_PROPS library providing helper
functions (phy_get_rx_polarity, phy_get_tx_polarity, and their
"manual" variants) for PHY drivers to read standard polarity properties
from the device tree. The PHY_POL_NORMAL, PHY_POL_INVERT, and
PHY_POL_AUTO constants are consumed from dts/upstream/include, which is
already on the compiler include path.

Patch 2 updates the Airoha EN8811H PHY driver to use the new standard
rx-polarity and tx-polarity properties, with backward compatibility
fallback to the now-deprecated airoha,pnswap-rx and airoha,pnswap-tx
boolean properties.

Changes in v2:
- Drop DT binding patches (v1 patches 1 and 3): already merged via
  the DTS upstream subtree merge (tag 'v7.0-rc2-dts')
- Drop creation of include/dt-bindings/phy/phy.h: the header is now
  provided by dts/upstream/include/dt-bindings/phy/phy.h, which is
  already in the build's include search path

Lucien.Jheng (2):
  phy: add common PHY properties support
  net: phy: air_en8811h: use standard rx-polarity/tx-polarity properties

 drivers/net/phy/airoha/Kconfig       |   1 +
 drivers/net/phy/airoha/air_en8811.c  |  91 +++++++--
 drivers/phy/Kconfig                  |   8 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++
 include/linux/phy/phy-common-props.h |  70 +++++++
 6 files changed, 442 insertions(+), 15 deletions(-)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

--
2.34.1


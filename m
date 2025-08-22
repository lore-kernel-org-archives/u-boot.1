Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD25CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 23:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CB681D5D;
	Sat, 23 Aug 2025 01:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aSNmttRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E9C8006D; Sat, 23 Aug 2025 01:29:42 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350768006D
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 01:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b9e415a68fso2208902f8f.2
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755905379; x=1756510179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=U0aAiXrTpjD+Sw0LhAcpYatzGil94Xathgq0jvKYS/Y=;
 b=aSNmttRIwq3knMXNX1a55ZLwqToJCaW1M45FQ/w4p0pPFGMQn81HbVB3jZxpzSVQck
 /M3XzTnCXa51IlU5+Niea9IaQ6k2jIcV6MVhXWEa/nex0a5STuD36a+MoQruBh748pyT
 tRywIEk7bDKwWVooUNspuSawEPGBBqZNdoom7YFZgGlJwY7X1Yhj6hmxopC3O4jLqLeo
 86ebY91YBYaiQLvmpU86OV6J3UGKN0CORcbQ2b61mihBbhX/lB/CcuFwCXtzjkfzdZV0
 cNTd8B4memNbhMk2wBK2UBFM4oY9v10AdU0oO09ePR5zYTaBlHE6LZvvyOw1y5nSJDAR
 rk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755905380; x=1756510180;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U0aAiXrTpjD+Sw0LhAcpYatzGil94Xathgq0jvKYS/Y=;
 b=XAFh0zIvm2dUNJi7osZdNrpQQa0FyE9fixYhFA+1CbPd+PkIXOqb6Iawo2YqHMRZta
 GE9V9vriJyeycZXIORUY2T/t9yNEeM39VPy2lRLSezRaZ3LMEm5FAlbjumL6Z1LKUwKu
 qdLjoZRGAYoSEVfjv2WLvSK7kgU27zXx/djUT1qmcWKtgNcHt30iRNevJt1n1JTytrLb
 dx+hs+Pn0dQFsdQNA6WEB38ZTFcHSfnuxoJnwGLhU5M8BZiJP2gbqzELREzVrwBJttQv
 CtOQ/a3zQRtJHPM/aFHbxE//qfW27raZxJG1haZWq7YkV/naMcmJnw0q7cQ9saVap3jA
 fLDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmhIMpJ6ResQWoaLLAHQatOqUFZ7iDknr4lJ9tNOOatWFMEjaIW5CEUC8n5aCYAkCH1Sx3xBU=@lists.denx.de
X-Gm-Message-State: AOJu0YyZabfTL8wsy3xGP/5T/4BhVwdopJN+UmK52jPuzh18gc8QKnxw
 TlMrBHp2ZVWJnbAF1+zllQhP6YjvaVSjN4YrnCN986u8J64vlQfBDII3
X-Gm-Gg: ASbGncvIZ2lzxYY2BZqnj/JicJ+GRzP+7lFgFCaG3ELxtXQxHXTj89fNE0a+UC+CKPf
 V8y+k7YPctbHfxwbEp/ryQx1IGLTx7W1iATMVXEJOuYgMbhBoH8nAXf5eClZv232+zg58lj9gBV
 TB79OqJdW5h9joT/Bsso/JzY7GWyTVczf4g8UZv70xEmBmLb7zO2aKF57wCtr+gfrkCFmT2lz3i
 GyvJipzaXQexNLQpcLY7esXOFBdmAjEjS/z8NovkaXckjBRflhYFEX4I6cd/3+jWzZqJWlfm18n
 9urhWGAUm16gEwZUd0M6kdCeDtuVzDz70KcV+Pwf905gWM4sPktIjm0fiiWw3Nbo3553opOhBkZ
 FK55OefsLDmc/Xrhi1tJAaXK08peevIylN4rPZ/1krthPwvbsvVrS5EF+8/l7MY9j2idq71Y=
X-Google-Smtp-Source: AGHT+IG3ueWYmOAqvwaboLafgMXduknn8kSBNbRA3r99kwB4FELBB5/bpSbcMrFnbwiYQayoKy4L1w==
X-Received: by 2002:a05:6000:400e:b0:3b7:9c79:3293 with SMTP id
 ffacd0b85a97d-3c5dce05162mr4269383f8f.58.1755905379353; 
 Fri, 22 Aug 2025 16:29:39 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-251-209-58.retail.telecomitalia.it.
 [95.251.209.58]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1483sm1216970f8f.50.2025.08.22.16.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 16:29:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Subject: [RFC PATCH 0/5] airoha: add MDIO + PCS support
Date: Sat, 23 Aug 2025 01:29:14 +0200
Message-ID: <20250822232921.30076-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
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

This initial series rework the MT7531 to a dedicated driver
to add support for AN7581 (based on MT7988 Switch).

Also add support for configuring the PCS to setup the
Serdes port.

Posting as RFC to have some comments about the rework of the
MT7531.

Christian Marangi (5):
  net: mediatek: move MT7531 mdio to dedicated driver
  net: airoha: bind MDIO controller on Ethernet load
  net: airoha: add support for Airoha PCS driver
  net: airoha: fill in support for PCS in Airoha Ethernet driver
  airoha: add PCS node for AN7581

 arch/arm/dts/an7581-u-boot.dtsi        |   71 ++
 arch/arm/dts/en7581-evb-u-boot.dtsi    |   18 +
 drivers/net/Kconfig                    |    7 +
 drivers/net/Makefile                   |    5 +
 drivers/net/airoha/Kconfig             |   12 +
 drivers/net/airoha/Makefile            |    6 +
 drivers/net/airoha/pcs-airoha-common.c |  803 ++++++++++++++
 drivers/net/airoha/pcs-airoha.h        | 1216 +++++++++++++++++++++
 drivers/net/airoha/pcs-an7581.c        | 1369 ++++++++++++++++++++++++
 drivers/net/airoha_eth.c               |  115 ++
 drivers/net/mdio-mt7531.c              |  140 +++
 drivers/net/mdio-mt7531.h              |    9 +
 drivers/net/mtk_eth/Kconfig            |    1 +
 drivers/net/mtk_eth/mt753x.c           |   29 +-
 drivers/net/mtk_eth/mt753x.h           |    3 +
 15 files changed, 3784 insertions(+), 20 deletions(-)
 create mode 100644 drivers/net/airoha/Kconfig
 create mode 100644 drivers/net/airoha/Makefile
 create mode 100644 drivers/net/airoha/pcs-airoha-common.c
 create mode 100644 drivers/net/airoha/pcs-airoha.h
 create mode 100644 drivers/net/airoha/pcs-an7581.c
 create mode 100644 drivers/net/mdio-mt7531.c
 create mode 100644 drivers/net/mdio-mt7531.h

-- 
2.50.0


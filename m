Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838EBC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E5587A70;
	Thu, 14 Dec 2023 15:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="lziODBn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F4687A6A; Thu, 14 Dec 2023 15:09:46 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E8687657
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zong.li@sifive.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3720f3e18so1726255ad.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702562982; x=1703167782; darn=lists.denx.de;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wczgByHYIbFtOJbjTB2oHa6ARRYEFppy+b2YsOvE0ws=;
 b=lziODBn/DumI67cenTrF5j7K7fOeg/VGcB218BcIAYfMJT4lNliu+8luNxE8MOWTeC
 BXPBwiAGx6wdgm3YAd5HkRcijkKP6n/ckbjJ12M5+PY1LD3PJCnYIRB50nvSvXei3nvq
 XTFuHU22sDdWM+hTREGWZhRrWxoRTE5eawKGewZT87ikyu8vleQBWCcVlHer4fIUu2oY
 pYzerKFIF8YipuDMt8u1NQjkVzJFCMhrUeRNISK5plFdjX41m1iM1+Fph1YrbHo7aRnb
 0ZrBrVtMqE5JMToWOC5Piw7TcRm63+vw3cH49NC6gNUiM1SGzjNgHUI4AoBV5H3Y4MRP
 biPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702562982; x=1703167782;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wczgByHYIbFtOJbjTB2oHa6ARRYEFppy+b2YsOvE0ws=;
 b=G1U0DQug5njKvoGknOXIHSURVQkbRdtNe5z7QDdhD4pPZI8BNwOCTMJ4SmXOXO/MuM
 elEAx4SiMNSJ827uGJDoHXYsmor9B2XS90t25X/phbCZ0Tm3ITeSK4Hvg058mkYQXXh0
 ek8R4gznxrrbFAd6MNfPzJxsgPsvH/m6qF83Dz4uVo2X6DrjF9lJOSqPiLWIAS5ridmA
 Rc/p2ljLIxfX8QlUYC9dLTkIC/FfDh+lRR0ilZjRiHVqtsf1lnLPivvklqCyO1za45JZ
 4K+tV5KrORtEbnTSf500y8j+J2OoHXrua6xc77RGN1DGA0jfyCJyf3bFT2or3pyUmhHj
 EiGA==
X-Gm-Message-State: AOJu0YxEoy8nUt7TCrgvZlpsJMGnG4xOJI+0Ppe9uM1YCr+1X2Eazri/
 0PHEZ8qLNtkt88JJ1LPbkTuHuA==
X-Google-Smtp-Source: AGHT+IHOPu6KyOy+cSCmKcVgvgBFcNh8Fpfj9S9VERCreaLtFL0QkaGAd7Leh8YWtXgceEuF4j2XRw==
X-Received: by 2002:a05:6a20:d41d:b0:190:5e69:c9db with SMTP id
 il29-20020a056a20d41d00b001905e69c9dbmr4067583pzb.85.1702562982448; 
 Thu, 14 Dec 2023 06:09:42 -0800 (PST)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 16-20020a056a00071000b006ce921da705sm11800644pfl.136.2023.12.14.06.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:09:41 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: rick@andestech.com, ycliang@andestech.com, peterlin@andestech.com,
 u-boot@lists.denx.de
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] Add SiFive private L2 cache driver
Date: Thu, 14 Dec 2023 14:09:35 +0000
Message-Id: <20231214140937.27784-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
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

SiFive private L2 cache is per core cache, add this driver to control
its features by a MMIO register. In this series, we try to enable the
power gating feature of pL2 cache in SPL stage

Zong Li (2):
  cache: add sifive private L2 cache driver
  riscv: cache: support cache enable in SPL stage

 arch/riscv/lib/sifive_cache.c    | 21 +++++++++++++++
 drivers/cache/Kconfig            |  7 +++++
 drivers/cache/Makefile           |  1 +
 drivers/cache/cache-sifive-pl2.c | 44 ++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)
 create mode 100644 drivers/cache/cache-sifive-pl2.c

-- 
2.17.1


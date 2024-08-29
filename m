Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E533C83F14
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35FC88B31;
	Thu, 29 Aug 2024 14:51:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCAxSFCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7050A88BC0; Thu, 29 Aug 2024 14:51:32 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADCC88AD7
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d3d0b06a2dso481965a91.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724935888; x=1725540688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=otbri4EorOxCXAC/lB8iG3512qZtwvoAE2st5hYUch8=;
 b=TCAxSFCl8lXn+5D9sHNNe0w5vTvLbJqJKheH6h80bGADT7JFm3ll1N9y5CG8TXdXDx
 ZK2Mg0ooVn7YNkEsGHqNjbKByleuVIxC3JNjU6bRb1n+lSPS9gPtbbsmVJA6p0vHINK6
 VJsH4CNQ0hDfhx5YaE1GZ/bFS68zwASuFEJQ3n1iiBFGHZPtnkH7FkXuEkdC+55wmhcs
 J8VYzUdDOjPf69tm1ugX1CSfsz5Nle1T5GtCI61eOY2xrPA2xXaaXvmQTDOsfnd2t0Vo
 SKuwmJOqOAXLkWJmrEm0bGSHGzjNUmjfrvxrQuvO2DUMhvnqwNFgPqbjSn6s3c6MnRP4
 Nm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724935888; x=1725540688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otbri4EorOxCXAC/lB8iG3512qZtwvoAE2st5hYUch8=;
 b=TS5odBuzXf8njXilbp42uBREuWJGwM2V8lFYXfKnjOi6Xw7zKlPCl/bx2Gax9rCYev
 ip6Bh158zgqfy5w3531NoYV2/FszPp68KunXjJL+sa3lPfYYbtTYSj4Ipt4SL82ZFdk+
 CeZ8u4uLMi4g4m4yg4M3wi0I/lQeMIUNqd12B4zfRqaH3p1xvb54IwLH9tLe1wsu9VXk
 SX+ifnk/kEyTq3E9N9kIOqrRUBFWKR3aOufYLS2alxVk/5l/Ei23sMIJ9a2g74WFdpDG
 ecte2UMPxnsfnMYvkalXvB08eI+37l9rrNRxapGzIdkAag9ShdakQ5JkYrZwKNB+5o2l
 SFQA==
X-Gm-Message-State: AOJu0YxcmjCMl3rk8WYdlzSwR6NZVUGYno9n6i+ozCNIyTQh5+GZ5BPV
 vr1OjorkuXczI2+/lCxM1lCdxX+tHCH+wyd+kr4oggmGVYeRcx6sdTKanw==
X-Google-Smtp-Source: AGHT+IFp4FdhfAQw2wDXTNot3mGNYRFZMi6C3et3PX9/fZs8G6agrTAqbTzOoC4JDIDYMvpbfJYUQA==
X-Received: by 2002:a17:902:c94b:b0:202:38d8:173 with SMTP id
 d9443c01a7336-2050c343658mr28519435ad.29.1724935888285; 
 Thu, 29 Aug 2024 05:51:28 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:adb0:3b7e:78c6:e307])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b0fe17bsm1505263a91.10.2024.08.29.05.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 05:51:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240829
Date: Thu, 29 Aug 2024 09:51:24 -0300
Message-Id: <20240829125124.3339348-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit ee2af844ba1b27b2e959c4e649e4b769fbeb4074:

  Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi (2024-08-24 14:03:28 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240829

for you to fetch changes up to aec0015a52d3faf723fec9ed9fe1d1af0b89e996:

  mach-imx: do not use if_changed more than once per target (2024-08-29 08:34:46 -0300)

u-boot-imx-master-20240829
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/22162

- Fix an issue with "tools/buildman/buildman imx8ulp_evk"
failing every other time. 
----------------------------------------------------------------
Jerome Forissier (1):
      mach-imx: do not use if_changed more than once per target

 arch/arm/mach-imx/Makefile | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

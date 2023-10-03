Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80469E75428
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F168287203;
	Tue,  3 Oct 2023 08:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N7p0AK8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4456B87214; Tue,  3 Oct 2023 08:34:03 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6228885E44
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:34:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c1854bebf5so6138121fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314840; x=1696919640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iBqW1tDZUcR98zXBMORfMcBC0ukT6Cp9mm4KaOuwONc=;
 b=N7p0AK8b4HDSN8i62+dm6n5IqIZFh3IxGCg7MOD1GdV2yUPPsBJ/atnS6naSpB4R2F
 r1o6JKcoFz0WkNt+wu17ISx6jMIUs8qU/vONPY+yP+8/Ie6WhDr1fbZ4IL7gCoJ2RlG1
 AG4/7aGYXSMWlEHrxMdbQK61ZeV7BhUQRLEgiGaE9sxjXry59DnNqXiqAOfqKDGs20FL
 tb7wbMeRShFJFlVn6aR3O12n1KsjQZNiyent3sTFtFhQ0r9yra28xu9tCTqDOthZIvx1
 X3+LFRZUnaHwx4JMbCD4zR/zSrxEhN1FcXtfXQZRC7nOv/zePHt21nxybLFpyca1P3T8
 djrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314840; x=1696919640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBqW1tDZUcR98zXBMORfMcBC0ukT6Cp9mm4KaOuwONc=;
 b=S4POD9B0MAQ1WM9hu4BFG718HUHIkx2MDn4YaJzQJ/YnsszwortCAIs3Mn15T7KeE6
 Yljg7c26IBIrG6K/7UIBmyu7iMlTTBeZii89XYXOjbU3w7ePBDLQG0n2mmcpHZZPb3t9
 RHjORz9IP6yw5wvpwGfKjwbDrBiupXzFPGpbdEevHc5Y9jTyKUha6XGwrg8UpJje0fXa
 Cxeq66i2fgIGsNR8eQ1KZh3KqMYMQgPLnCbBmn2hGZ30XBA39QASLqXK8YYF9CVUHVmx
 p0yGKORByEuoeyIOQKfvOcnckEXkuGDLG6FY5AptrEKlBbWLWCXsHkAkNf8aNyOBqiju
 3Yuw==
X-Gm-Message-State: AOJu0YxUGP4XIrvoxJMbuHddrmzU92DATyQQM9OL9a9j9tcvPlDQ/Yx5
 yBCPAlr9qKrDEFIvWAC24eM=
X-Google-Smtp-Source: AGHT+IGwAxVN7WDdjhGFqXzv8ABxyvS20ZIhsNgpzdWQfDleOWGT2nXEPA2HnltAJtfWHZLWyzASaw==
X-Received: by 2002:a05:6512:32b5:b0:502:f2a8:d391 with SMTP id
 q21-20020a05651232b500b00502f2a8d391mr9668199lfe.45.1696314840451; 
 Mon, 02 Oct 2023 23:34:00 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 a10-20020ac2520a000000b0050309ea3a62sm75769lfl.277.2023.10.02.23.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:34:00 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 0/2] tegra_mmc: get tap and trim from dts
Date: Tue,  3 Oct 2023 09:33:50 +0300
Message-Id: <20231003063352.42660-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Default-tap and default-trim values are used for eMMC setup
mostly on T114+ devices. As for now, those values are hardcoded
for T210 and ignored for all other Tegra generations. Fix this
by passing tap and trim values from dts.

---
Changes from v2
- no changes, re-sending

Changes from v1
- move t210 device tree fix into this series
- switch dev_read_u32_default > dev_read_u32
- if reading of device tree tap/trim values returns error
  store error in entries of driver structure
- apply tap and trim only if they pass error check
---

Svyatoslav Ryhel (2):
  ARM: tegra210: set default-tap and default-trim values in sdhci nodes
  mmc: tegra: get default-tap and default-trim from device tree

 arch/arm/dts/tegra210.dtsi                  |  8 ++++
 arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 +++----
 drivers/mmc/tegra_mmc.c                     | 52 +++++++++++----------
 3 files changed, 44 insertions(+), 33 deletions(-)

-- 
2.39.2


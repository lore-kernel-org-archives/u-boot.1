Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8305CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 09:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 116BE833AD;
	Mon,  1 Sep 2025 11:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ckuLb8mA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8908397D; Mon,  1 Sep 2025 11:00:45 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7C583192
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 11:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-affc2eb83c5so309685266b.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756717243; x=1757322043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JxikSnTMmvTfdliW7HdZAdKrm1iGT036cuI3cc8GuBE=;
 b=ckuLb8mAMDWze1I7FpPretc5q4RQLho4ZUTwi70/jqB0OQrd4B4oFGWAcfRhKD2Usj
 xQ/H2Vt8opTWjRLVucN1AbelD5J8a/0AzCjvqMA4hlk1+6I/Xaf7GuHF40DV+FD/ia8j
 BcpgduUdpgEkI+d+ENkFM8dV5VuZlN7PGiSmOodzFYb2SpWtNDfBmF1CgmO4mFXGuwZ5
 YLAGnwsaH7GaAs2hESd49ynwzpFg/HbE4qmK9FhIkIhQGeQOD0eiZQgbR6DrdlfCRgPd
 Ut6palvD0fu+4QqBHUiRWSRn7IaqxuMjFDoIIinulpc7HNIbkE8sRH9Tgq+NiKOK3jol
 PBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756717243; x=1757322043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JxikSnTMmvTfdliW7HdZAdKrm1iGT036cuI3cc8GuBE=;
 b=BcPvI6dYNuZp3Ln3qjIHi0GikOqFwX2IIQzNMSIr4h1frDu6adkHywiG4KkcPUQzXn
 0Sz3guXdikumm1V1gffZOZ/kWG2Vp2k/Hv3KAVtwLE8UqoKyrKQpVjLrYwUpc/yzz/IC
 ToiXK6TzJK80DCnZJNXVGoqoqhOEUayAg2XlwLVUA2j7Ia5RA2hK1hrCWRxm5H7IKLS8
 Xs9wLHgcH+woXeUhsv3yFz3Qfjc2tiAMfmsMWs57Ebn7k+CM8V8Xu+SuRuI3uD9ZIG0P
 64egzq/0PfC2dd8ejdiaOBHhesFz+zvqGDGhv0NPMRB6sUsv8oFPgPqePeLSK+y7LJH2
 cgGg==
X-Gm-Message-State: AOJu0Yw0ZImi3hu5JzzEcSvO3ME5j4uH3SvqUZLVWXsKJPcKDBJHAaVK
 jFNINzoVLAWY4pO71ZoM6+4HNXSMhxsRVL+z+NN+8qhVq9W6qFaAVVSp
X-Gm-Gg: ASbGncv1dZLtPTx0YUW7TZGaRg34IC65NoGMqcOUJ/QiuhROtxCrQdyJmS5NpVj20TT
 Uz+D6r8XWp4G19JV83XrSqmAbAjoTxUZMFV5tW6Y1DkILlCfibugzIaO7KIfhwFSdZDaRtvaVJK
 VTPs3wdeQaWkIYDpXiCdpVJKx3t84NUZI204wxyzZn5b+5pk5+K9UlO9EZUhRx8ksWJjBtDVKp9
 KWh+2da0dpW5xzpBEfg2fl1Qijvn+vCAMhX87cjWpE0JgNMyIOQc7N2ChDvDvtHRU94T/bNkbNj
 L7Ijld98z4pODxTN08D77D4ITgSYOqMAT6O9PKXj5mJ3nxpy785/Bo/c6vF4Ot3D6M4bg5Pz0AW
 /PqEkAzpXJwL1NA==
X-Google-Smtp-Source: AGHT+IGDV9Ps9NeK/SB4EW4ykAARWtRhz8WmSPPAY6uM70gIYc6gCjsbi20+8L3c0edQNKkq6OyPDw==
X-Received: by 2002:a17:907:3f95:b0:afe:677e:a61d with SMTP id
 a640c23a62f3a-b01d8a32731mr655101666b.6.1756717242659; 
 Mon, 01 Sep 2025 02:00:42 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0428f88a61sm215152566b.70.2025.09.01.02.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 02:00:41 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Tegra20: sl101: fix Hall sensor behavior
Date: Mon,  1 Sep 2025 12:00:17 +0300
Message-ID: <20250901090019.11930-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Hall sensor found in SL101 is not used for closed dock detection as on
TF101 or TF101G, it is used to detect if keyboard slider is out. To address
this, lets move Lid sensor switch into TF101/G trees and add Tablet mode
switch into SL101 tree.

Svyatoslav Ryhel (2):
  ARM: tegra20: transformer: fix Hall sensor behavior
  board: transformer-t20: add separate env for SL101

 arch/arm/dts/tegra20-asus-sl101.dts             | 10 ++++++++++
 arch/arm/dts/tegra20-asus-tf101.dts             | 10 ++++++++++
 arch/arm/dts/tegra20-asus-tf101g.dts            | 10 ++++++++++
 arch/arm/dts/tegra20-asus-transformer.dtsi      |  6 ------
 board/asus/transformer-t20/configs/sl101.config |  1 +
 board/asus/transformer-t20/sl101.env            | 15 +++++++++++++++
 6 files changed, 46 insertions(+), 6 deletions(-)
 create mode 100644 board/asus/transformer-t20/sl101.env

-- 
2.48.1


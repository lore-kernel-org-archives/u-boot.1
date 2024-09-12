Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD5EE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CEB88E3B;
	Thu, 12 Sep 2024 08:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bY7NUZSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA4B88E64; Thu, 12 Sep 2024 08:13:52 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD5B88DAC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20688fbaeafso7589695ad.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121628; x=1726726428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V7P1FP3Toxk3YVFjOmlR0CFkePSpJbxqgdgcg4QxMZs=;
 b=bY7NUZSsL8B/HHNAt02WI2+KIew4H6AhbHctr0tEpuqfe03PmnDX8d/jzlryG+sq2F
 AQiHvbkaWc84juajy0W9cvPc3NIQMiMiqE2stzbYQLnGErzAZe5ua1tFdp1CZ5zEATxN
 F5CV8kMnILZ7Hb/2soWb3Wf1LJR44LyFDdk0dKPhaz4vAHRgVGOGHFFIxUPy1QGdnhNv
 POUiB5w6aN8Qyc9KWlrqHVjwmnOEEz1Xx4tsU2ArYJwTaEmSNUm9My6gqqw35wJPPh1r
 7AU8kSeskUr+kXaVAASoYmIB6guy4WA9lRML6XrUZkT40QNd8oWQq5tUVbAZZR0sLSEJ
 w3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121628; x=1726726428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7P1FP3Toxk3YVFjOmlR0CFkePSpJbxqgdgcg4QxMZs=;
 b=Q4Rdl/QwEXRpYUKWkt6ld/rmIpSTLDbu0ZMT9i/9v6YwUXCePpyCAth+2nBK5jAasZ
 RykbIjfWRxfrh1Q7WQBOi/OJnn08rWpSL00UHH4wYzOxosT9g6OSZKixukV4ktVVIXr1
 x06iAKAO9ykWry2a3hiOJ0FSzwyU97xYfWxIZrp1sAGfeE2KokMJAvkSvrwDjabfWeSW
 lrPs7IVWHQ5012iSACnZidKmWeXtOXupZzbJ/MeBoQsFtexQYNRAMjuq+TH8YGh1O8jx
 96jGgnsHc7EzDR07tWPMZ9D5A+sB0N0hW0nH2SK47O386qX1v3j9QCquYEo9yLvw68yf
 g2Fw==
X-Gm-Message-State: AOJu0YznfnHrTeCGj1KzJgSOJJaeoFwV3fNHnxDr/Uhnp/c8cd6TWKyw
 X/IU1jtnNnN+leIj9+XlAjQJLvfCheoGSZ/N40azybJ43B5s3y4nbXB6oQ==
X-Google-Smtp-Source: AGHT+IGmkWRP94JYU0DPaMtGGkNmKwBjPwfp5oU2sWXyRTrCvRlqrK69+ob3rnsgkz042oLQ1UrW5Q==
X-Received: by 2002:a17:903:2282:b0:205:56e8:4a3f with SMTP id
 d9443c01a7336-2076e488bcbmr25496195ad.61.1726121627996; 
 Wed, 11 Sep 2024 23:13:47 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afdd046sm8214065ad.166.2024.09.11.23.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:13:47 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [RESEND PATCH v2 0/3] mtd: spi-nor: Add support for S25FS-S family
Date: Thu, 12 Sep 2024 15:12:58 +0900
Message-Id: <cover.1726120686.git.Takahiro.Kuwano@infineon.com>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reset after rebasing and collecting R-b tags.

The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
Flash devices with S25FS512S.

Datasheets:
https://www.infineon.com/dgdl/Infineon-S25FS064S_64_Mb_8_MB_FS-S_Flash_SPI_Multi-I_O_1-DataSheet-v10_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed526b25412
https://www.infineon.com/dgdl/Infineon-S25FS128S_S25FS256S_1.8_V_Serial_Peripheral_Interface_with_Multi-I_O_MirrorBit(R)_Non-Volatile_Flash-DataSheet-v15_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed6b5ab5758

Takahiro Kuwano (3):
  mtd: spi-nore-core: Fix 4KB erase opcode for s25fs-s
  mtd: spi-nor-id: Use INFO6 macro for S25FL-S
  mtd: spi-nor-id: Add S25FS064S, S25FS128S, S25FS256S IDs

 drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++++-------
 drivers/mtd/spi/spi-nor-ids.c  |  7 +++++--
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.34.1


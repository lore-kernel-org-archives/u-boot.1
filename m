Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ABBC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 06:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25B28812B;
	Tue,  9 Apr 2024 08:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UC3mc2Oy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32EE88145; Tue,  9 Apr 2024 08:20:40 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A2487FBF
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 08:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e46dcd8feaso2540794b3a.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712643637; x=1713248437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aLLOPlKgNyXVGiAIZ6Ne0/5FdfNn/Yfj1mNRsk9bX5k=;
 b=UC3mc2OyUW2P4rIfM/waYPp0dDQsudHRzcViYTSgP3pbD9GfqjbHgWVE5wPo6S4Cv7
 LN6ijHhOJco7nbQAra5d1P3mnSq1XihC8zenDjVhOwRH7k5M9wTvUX2yBfD13l5KhguO
 nVAos0yPKp3dpNpSV5dZtcR6d0OkrFhRJbM238U015IzpA3KChbtwm8yjlIoyFSr9FSY
 yd+8FplPcSCOuoV3iwnSWa3MB3w3wUlwGDQkB6KIvuAy2oVcvvT00bRPYnu3ElsKKjHA
 KFZNIdqZgBaDsIEftF9ufxqCrQr0tpH0UywwWIdw8qeULJmOuw3F57JZyM6IPu5nBdjg
 MYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712643637; x=1713248437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aLLOPlKgNyXVGiAIZ6Ne0/5FdfNn/Yfj1mNRsk9bX5k=;
 b=TspZr9XSbzA8X28T77wKurR/pGxQgHfIZgRti5fw/uspN7mTx8y+3/v7Drni1xw333
 YTw14wGuG8c/o6wCN2yWDDV12LxhR2p2wO97w0poDxDSKTu2HPUnY0ZK0sw0lg8ygtLf
 9eY2bPvWXnX0eRTXNrpILAhuxvMCOGfuKpHHmeDYP2WikWzFB25Re28tHHK4tnQopGbb
 Vh7oLT25tgeehffoFXyIg3IZdhtnMgu0UE9BbsNhmL9NlvYZ69ypkKryICYBge4I96u1
 UFD1GHERYYpAa3lrBDjePR1Rc39OKToP8S+UfBT+4rqwG/VMooOQmzFiyZchNaok48kt
 oswg==
X-Gm-Message-State: AOJu0Yx8KkiyDbKeDdxjiYCN/qDet1jB7RM1q2rNJGNcGd4O8oBUB9aa
 Uldnj25JKMUDc97ADH30+BU1eVEleeaWKMS74ynwySEBIrmYknYDQ8OkMR1G
X-Google-Smtp-Source: AGHT+IEzIEn07ShxjwQMsrDUlopKqDL9ePeFcQ764NPf8jToW1q4hpr+nEnLzqF7hbR7KqxeCvs6Ew==
X-Received: by 2002:a05:6a20:7343:b0:1a8:2cd1:e437 with SMTP id
 v3-20020a056a20734300b001a82cd1e437mr265759pzc.11.1712643636815; 
 Mon, 08 Apr 2024 23:20:36 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 x3-20020a1709029a4300b001db5fc51d71sm8037985plv.160.2024.04.08.23.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:20:36 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH v2 0/3] mtd: spi-nor: Add support for S25FS-S family
Date: Tue,  9 Apr 2024 15:20:19 +0900
Message-Id: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
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

The S25FS064S, S25FS128S, and S25FS256S are the same family of SPI NOR
Flash devices with S25FS512S.

Datasheets:
https://www.infineon.com/dgdl/Infineon-S25FS064S_64_Mb_8_MB_FS-S_Flash_SPI_Multi-I_O_1-DataSheet-v10_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed526b25412
https://www.infineon.com/dgdl/Infineon-S25FS128S_S25FS256S_1.8_V_Serial_Peripheral_Interface_with_Multi-I_O_MirrorBit(R)_Non-Volatile_Flash-DataSheet-v15_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed6b5ab5758

Takahiro Kuwano (3):
  mtd: spi-nore-core: Fix 4KB erase opcode in s25fs-s
  mtd: spi-nor-id: Use INFO6 for S25FL-S
  mtd: spi-nor: Add support for Infineon S25FS-S family

 drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++++-------
 drivers/mtd/spi/spi-nor-ids.c  |  7 +++++--
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.34.1


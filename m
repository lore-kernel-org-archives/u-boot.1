Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DC6CEBF66
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 01:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E6C88FE7;
	Fri, 27 Sep 2024 03:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HBE+oapx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5703F88FC8; Fri, 27 Sep 2024 03:11:32 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7B388F92
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 03:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7db299608e7so1089197a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727399488; x=1728004288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X0a0/F5gveFy7hMWUGAaQ1ovnr8JvP/jyzKyhtKxdZQ=;
 b=HBE+oapx+9cJLvmd/xDixh841wZF5/GtBkUHAYZRRVkR+sLAhIjcESVga0serQI12J
 MLnNeAAJO/mUZxskgsnYy9Y+lt6HhoE2KLp5lxCZIRGVmY/q+Vs8D5JIDS+Qvm9voWfH
 QEFAFR8OTrdJsB+PuF3rGccaR8eUMZVUaAy6bffgsIhAnlxdqYlSgVt31nw7oo/VbQAn
 A12BoD2/nrkPlUX4YQH3845PObWccUwW2xl+m+8MrMoqZ3wLn3tKKssO2cU/JsriA0k/
 YP1zi3J9zZHmCqW4e37Obqn1qAoB3vOWj9RMudJF1oiw96NjRPNuuiRkm54LMhi9yaiP
 OWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727399488; x=1728004288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X0a0/F5gveFy7hMWUGAaQ1ovnr8JvP/jyzKyhtKxdZQ=;
 b=TPNi/37AcECnkqM0Fjvg0ZGg9WjT8QKxUe0BbxM/k4JogVo3q6WNi10CdvNsr8JA/a
 4wERccsPgKs8WNKiQjXAy6s0QMtlh/+K13kc1rZOgITn2SaYjn6c/SW90DnFKSe4a0Zl
 Xpp+ZN4vk93BE5EGgzjdnuEfM5k5bTor7ybRDdUmfCyiFOlQDCYOTyjYXdZXHl49OEoB
 m33nauxvFMisqv2ANyg9g9thIqqrIhcpgxovUh9YR/+loodfB8Dz1M/a6SUwk18meo7W
 ERFw08ccVBEk37hLYiaWTfH/C328m3yGjkoDzoKMEgt1xIrYEX1GoZNod0G4R2gciYQP
 uRDg==
X-Gm-Message-State: AOJu0YzRT0SjLc0+DZAI6Nn2AESju7hrrKRgvghmZWvyZUFGYzLi/gWV
 bQpuKAHQ4n6XzxwGFcH4OqMWyPhLIip/UU4SoYET7s7wLZcdOfX7YfEsEw==
X-Google-Smtp-Source: AGHT+IHi5BNwjraiwcfkjze4T1ZbDmDGmWyhkVj404HNAbGodtc8MfYBNi4EyyPLzuh9tH1JcQ/m4A==
X-Received: by 2002:a05:6a20:4998:b0:1d4:fc15:ac4e with SMTP id
 adf61e73a8af0-1d4fc15aed3mr1365524637.5.1727399487690; 
 Thu, 26 Sep 2024 18:11:27 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b264d86bfsm524068b3a.95.2024.09.26.18.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 18:11:27 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH v2 0/3] mtd: spi-nor: Add support for S25FS-S family
Date: Fri, 27 Sep 2024 10:11:16 +0900
Message-Id: <cover.1727399216.git.Takahiro.Kuwano@infineon.com>
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
  mtd: spi-nore-core: Fix 4KB erase opcode for s25fs-s
  mtd: spi-nor-id: Use INFO6 macro for S25FL-S
  mtd: spi-nor-id: Add S25FS064S, S25FS128S, S25FS256S IDs

 drivers/mtd/spi/spi-nor-core.c | 28 +++++++++++++++++++++-------
 drivers/mtd/spi/spi-nor-ids.c  |  7 +++++--
 2 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.34.1


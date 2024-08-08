Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9596AC52D73
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 06:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F0D880A5;
	Thu,  8 Aug 2024 08:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P2SrtTqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A24889E6; Thu,  8 Aug 2024 08:00:27 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE00787E96
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 08:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70945a007f0so287328a34.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 23:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723096823; x=1723701623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeEKjBBc7ji7irvtS1760a1C7tQlLj7hH7QzGBP8nVg=;
 b=P2SrtTqyUK7Av76EIY5A9kKZ1shXnjtmPasEjBQe4q/nAdgkLqcvWC9X6FQo9SQoGP
 YToRidKGtuJhN9Uap7EvV7z4I9ybeC2RgOgNdlZoAOE9VnML+Brp5HvPIDBTln/YaFZC
 igLVLF9JKbb5CD+YUys+3oAvfsmdm1FiEYXyYzTUFDidNv13rY4bNBu4B6MneQXuLqcM
 uJpxmAqiY2yMhmU5JRXOxd3MEQY5Gr2QQcD0+bfqZ4aIVk1h31IaI/WdF68/4lf/YkSI
 Qbw/YqRmxj/oeH/vczyYFYhIlP9aHynd3MyjwZu+h1Kf1h+gMXMGVaC2OOyoIvDFtDYR
 I7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723096823; x=1723701623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeEKjBBc7ji7irvtS1760a1C7tQlLj7hH7QzGBP8nVg=;
 b=USHNgD0kwLX9fURCd3jDzsOvwZepbvMFdP03G2o6ABQFSM4Pum7H7FLqFQAvrv3LGg
 s3qULVw8U4hE3UzCHQWRDrUxMroHDlj7ZVSGv8jKBTZDwMuH4Ty78P8JT7csmOtrG5kB
 ddfgiB5/uenZvQ0OB0L0apruD8HXM2S/m8+nSqTC2Tr3fORF7acF+1ZyRhqLjzOYTNw4
 91kS9Q96IqyHNUVe/K8yMM0zPXI644IPPtJRpT/aVkP0lzS28ig473mNfLkqUpK4hXcp
 dhFfH7HSm4VV/0t6z9Bzfhr+x+HOjANxTuClgB+iSlUR+pKn/oI2aqm83ChdIBvE6Huv
 w++A==
X-Gm-Message-State: AOJu0YyzPu1Il6eDDbgRZ4OQuYKGHy8rsP4v14BvvgirLWbt+qMeNoFh
 2eFXj7dXEnogUBA/Az6uDSCvMqintGuu+SSpubpvbzwrAoMTHjr2RwnWZQ==
X-Google-Smtp-Source: AGHT+IGiHGMvU2v7VqfACpyrhRZu5gSdZX1sb0Tg6zKJEPziU5Vlugr++AjdOXZwi9ehEEVgw38MEA==
X-Received: by 2002:a05:6358:93a5:b0:1ad:471:9b7 with SMTP id
 e5c5f4694b2df-1b15cf87748mr125957655d.18.1723096822578; 
 Wed, 07 Aug 2024 23:00:22 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7653b4d99sm7819055a12.84.2024.08.07.23.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 23:00:22 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 mwalle@kernel.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 0/4] mtd: spi-nor: add generic flash driver
Date: Thu,  8 Aug 2024 15:00:06 +0900
Message-Id: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
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

The goal of series is to port spi-nor-generic feature based on SFDP
parsing. This feature will suppress the increase of spi_nor_ids{} size
and reduce our effort to maintain it.

We need to rework 4-byte address mode entry/exit functions and enhance
SFDP parsing to select proper 4-byte address mode method. After that, 
add spi-nor-generic structure and fallback logic in spi_nor_read_id().

Most of the code in this series are from Linux commits with some
modification to address gap between u-boot and Linux implementation.

It may be better to sync whole SPI NOR framework with Linux. That will be
done incrementally by separate series.

Tested with CYRS17B512 SPI NOR Flash which supports SFDP but not listed
in spi_nor_ids[].
https://www.infineon.com/dgdl/Infineon-CYRS17B512_512_MB_64_MB_SERIAL_NOR_FLASH_SPI_QSPI_3-DataSheet-v07_00-EN.pdf?fileId=8ac78c8c8fc2dd9c01900eee733d45f3

Takahiro Kuwano (4):
  mtd: spi-nor: Rework set_4byte()
  mtd: spi-nor: Set the 4-Byte Address Mode method based on SFDP data
  mtd: spi-nor: Remove SPI_NOR_SKIP_SFDP flag
  mtd: spi-nor: add generic flash driver

 drivers/mtd/spi/sf_internal.h  |  10 +-
 drivers/mtd/spi/spi-nor-core.c | 317 +++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h    |   3 +
 3 files changed, 252 insertions(+), 78 deletions(-)

-- 
2.34.1


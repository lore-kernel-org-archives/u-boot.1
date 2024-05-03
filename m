Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DB8C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 09:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1008827A;
	Fri,  3 May 2024 11:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k3PoHvH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFFF882C9; Fri,  3 May 2024 11:00:51 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4568823D
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 11:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 15430411AB
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714726846;
 bh=uQdBVXmBga5IL1T8lz1cmu3bW04Ykzi7YQyC8mmqYwg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=k3PoHvH35kFhoU5reioe5aU+zaksKRPgI6pymfe+qYcQWN3L6vR9Dny8/BAzC2cBk
 SYAXyjUnoOR6aVbNGOoDsT/PHchLgOHBOAZElORqprdVB+pW2eOQrgM8dxEC2TGETy
 cY9k6Dc78cD7X1aFN4DDwJJYYPCVHlmgjPf+nRh7Ipq0qqug5vGGiJGkVAKBVpY+/3
 36+NB/5sH1Xr6ud2IAEAk1IvEU4Uma+FjkCxSxo8B/mep5TXYUmPpSbrTM3VpboI0d
 8EFjTUVuot+/4dRjQKfWyukf/pRwMcAbQ32IccUWQG03g6dmsr2cLeD9TmKcikSOVQ
 gnCKzmIHCw97Q==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34dc6410028so1562769f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 02:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714726845; x=1715331645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uQdBVXmBga5IL1T8lz1cmu3bW04Ykzi7YQyC8mmqYwg=;
 b=BLRZQukpEJtuPoYVAgHh8NSwIb1aoXC2lpSJLk8QKZWot7+gMI+bEIfryVOBcCTs2A
 c6UNWWO+kKdo2ncfTZTsPP7bIPkyLjzZz6vIzFPqPvGczkiP7ZckS05pHMPF8vP+xUwY
 cDlNVXbgq7chRQ5vIJJ0LrIbWjU+efV51K09urSYnfwpY6QPIg0N/InT4Rh2mlcxLyVN
 pihoxz+8mJ5pMn1x1sQyMHKxLsQiY65eYGtTGtGzzQAy00n8X2hOetjtkUB4c5LV03Db
 5zN6Lk/AuOSR0KRtZMeo/uSStuzt1F0ko3N2N96gFtdFfS+YRUlaaEUjGOxezPr8djVU
 ONNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaipUlyV5biWFFFA3bYM0ynELFHs2f8uwfnyztbxcDsDjf0XRilNKaGSlz8FKsUJFcuJXgjWmfFGs02ofSdN28oJMm5A==
X-Gm-Message-State: AOJu0YzghkQPtua2KhP+KnS9DhZmTOGLdbjJ1LDGqgVzYbBxEbrvU7jr
 DwnAVSf8fdRCEsmk0LcBpo6TLjme35DnVtI2KF3Rmz0U57uKL0PxbPiJzeO5ANWvSb2zP6Netaf
 ZrdOnD2/crzUYUZPPasDtE2RJsntjthcrVlg0k1v8OdqoMq7w90XnPWIB7vsQIgRtF/fhjzV4De
 I=
X-Received: by 2002:a5d:570e:0:b0:34d:a75:3a44 with SMTP id
 a14-20020a5d570e000000b0034d0a753a44mr1526191wrv.54.1714726845366; 
 Fri, 03 May 2024 02:00:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkr9PILUqKOl8Epq5Rv1+1xVBiQBrrTrDiL5XEwx+bW5/zwUhSowNc+6M3IHrEkT6KHuvVCA==
X-Received: by 2002:a5d:570e:0:b0:34d:a75:3a44 with SMTP id
 a14-20020a5d570e000000b0034d0a753a44mr1526158wrv.54.1714726844956; 
 Fri, 03 May 2024 02:00:44 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 bf9-20020a0560001cc900b00341b451a31asm3247313wrb.36.2024.05.03.02.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 02:00:44 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/4] board: starfive: add Milk-V Mars CM support
Date: Fri,  3 May 2024 10:59:59 +0200
Message-ID: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

With this series the Milk-V Mars CM board can be booted.

NVMe, SD-card, Ethernet, UART are working but not USB.

The first series Milk-V Mars CM Lite board (the version without eMMC)
uses incorrect series numbers indicating eMMC presence. For these
CONFIG_STARFIVE_NO_EMMC=y must be set to indicate that eMMC is not
present.

Thanks to E. Shattow for all the helpful discussions.
He figured out what needed to be patched in the device-tree.

v2:
	fix typos in get_mmc_size_from_eeprom() description
	rename spl_fdt_fixup_marc() to spl_fdt_fixup_mars_cm()
	rename device-trees for Mars CM and Mars CM Lite
	change model and compatible properties
	refer to tio as tool for booting via UART
	describe how to update serial number

Heinrich Schuchardt (4):
  board: starfive: function to read eMMC size
  board: add support for Milk-V Mars CM
  doc: Milk-V Mars CM and Milk-V Mars CM Lite
  configs: visionfive2: enable SPL_YMODEM_SUPPORT

 arch/riscv/include/asm/arch-jh7110/eeprom.h   |   7 +
 board/starfive/visionfive2/Kconfig            |   9 +
 board/starfive/visionfive2/spl.c              |  28 ++-
 .../visionfive2/starfive_visionfive2.c        |  11 +-
 .../visionfive2/visionfive2-i2c-eeprom.c      |  18 ++
 configs/starfive_visionfive2_defconfig        |   1 +
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/milk-v_mars_cm.rst         | 183 ++++++++++++++++++
 8 files changed, 256 insertions(+), 2 deletions(-)
 create mode 100644 doc/board/starfive/milk-v_mars_cm.rst

-- 
2.43.0


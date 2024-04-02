Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD86CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287A788315;
	Tue,  2 Apr 2024 10:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tPLjc08e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2B08808A; Tue,  2 Apr 2024 10:49:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B00687E30
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B68463FE40
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 08:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712047759;
 bh=pzBj0eEQN5zCkGXluN0FfG49Pdke6D29BadNZf6gcw8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=tPLjc08e/vQDnV8LMfmxGmJrj5GDdWYvEcBGPfJgEx+AxrjHJMXoH/mMSl1OWsGfL
 rQqj0LhzIh5JDspqSjtRwBm2ASQlcOivK11Y4R1xTPc+7xnKUHt6nv7QNrJnkDl4Iw
 rXi13uDL+GWXeGBIfoq2EklTyOUMH/O8TIkNMoXw9zBRWyvyAcm/ZRYYGUP5Z1s7M0
 2BnLtsH4GXhw2wx6P+IVWt/dCBzhkW+Yz7o25uk48rhNy68sWCBJsXldMiGcdABtmZ
 itIs/NXOCmQG184gRNfrfX4zVncz4RZaJ+MQLtFy3OQ91E4H6hkezhYr6n+8koWf7h
 e0Bu6RtEgEuEw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41493ba3fcbso21564705e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712047759; x=1712652559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pzBj0eEQN5zCkGXluN0FfG49Pdke6D29BadNZf6gcw8=;
 b=oQc6CdJXaYSJOxULUoDrEFJRKvgrsiBe/HEppoh0gYalaKFTZMuonxW8kx5syq4jS3
 GcjQHoIn7Ht9Q/OPZjAztex4DsATtMfne9ckPveVpfefNc7KZ8Ou8gG5Yr5s6RoHvX1P
 VPl4oXUzsU+vmXsAcU06xipVNpX9bayuMr7Z1BJH7/A4+PEfYsaF3z0JGNnTiuEgKTqL
 nirKqhZQfYKjymIzR6vfsTX/hgqddLGeUpkFIt0mJ2SgqZtOZ/+MKe+AFht7LHHh2bcT
 0YjhnpZLMnbPnvIj20eK1XJWUTsQvU8VyXQPativDfFx0NiB3Jqw05muHROVcnDvAxkv
 WG8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhz4NBa6Hpdu7SX50CwD7bVi6zOxN9aJ6kHboAs9VglzUvpGWIik1RAFOKDZT1ZmBuH3+PhtjFnMbJ/HObsEIzPUOeFQ==
X-Gm-Message-State: AOJu0YyXJcAmBymzecdZ7JK0Z/OVrEGcXgAyUZ23AFBVkYSFGE/IlAHZ
 FwEVs8mgY5HA2c96MjC7N8sHEiYeVw407hV8CINyV+kZG70/p5GFzOOulzH1k1yjz7HmmSCeVLa
 Eziaa4e98N85FueHFvBRu8fInMtJZS6CP3IGtj+FnyXTXuzjr/0ibQMdwmO4hHUoBdbA=
X-Received: by 2002:a7b:ca46:0:b0:414:9072:98dc with SMTP id
 m6-20020a7bca46000000b00414907298dcmr11879581wml.41.1712047759384; 
 Tue, 02 Apr 2024 01:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKCU8pAoN5Hikeial5n+wGL+TBQ0sSB2QSIXFr1rPM3N+cqNL7PFqlZzNpjaxmVzsKbUgk+A==
X-Received: by 2002:a7b:ca46:0:b0:414:9072:98dc with SMTP id
 m6-20020a7bca46000000b00414907298dcmr11879569wml.41.1712047759046; 
 Tue, 02 Apr 2024 01:49:19 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004148c3685ffsm17409318wmq.3.2024.04.02.01.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 01:49:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/6] riscv: add support for Milk-V Mars board
Date: Tue,  2 Apr 2024 10:49:06 +0200
Message-ID: <20240402084912.43228-1-heinrich.schuchardt@canonical.com>
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

The Milk-V Mars board is technically very close to the StarFive
VisionFive 2 board.

With this patch series the VisionFive 2 U-Boot SPL will detect that it
is running on a Milk-V board and patch the device-tree accordingly.
This is the same approach that has been taken to handle the differences
between the Visionfive 2 1.2B and 1.3A revisions.

For the mmc card-detect a separate patch has been created:
https://lore.kernel.org/u-boot/20240328214615.21501-1-heinrich.schuchardt@canonical.com/

v3:
	
	Rephrase last a sentence in doc/board/starfive/visionfive2.rst
v2:
	do not set default fdt for VisionFive 2
	do not overwrite /soc/i2c@12050000/eeprom@50/compatible

Heinrich Schuchardt (6):
  riscv: do not set default fdt for VisionFive 2
  eeprom: starfive: function get_product_id_from_eeprom()
  riscv: set fdtfile on Milk-V Mars
  board: starfive: support Milk-V Mars board
  riscv: starfive: avoid including common.h
  doc: describe Milk-V Mars board

 arch/riscv/include/asm/arch-jh7110/eeprom.h   |   9 ++
 board/starfive/visionfive2/spl.c              | 100 ++++++++++++++--
 .../visionfive2/starfive_visionfive2.c        |  48 +++++---
 .../visionfive2/visionfive2-i2c-eeprom.c      |   9 +-
 configs/starfive_visionfive2_defconfig        |   1 -
 doc/board/starfive/index.rst                  |   1 +
 doc/board/starfive/milk-v_mars.rst            | 111 ++++++++++++++++++
 doc/board/starfive/visionfive2.rst            |  18 +++
 8 files changed, 268 insertions(+), 29 deletions(-)
 create mode 100644 doc/board/starfive/milk-v_mars.rst

-- 
2.43.0


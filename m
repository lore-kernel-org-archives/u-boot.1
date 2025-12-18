Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29042D68BD9
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 04:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4753D83B55;
	Thu, 18 Dec 2025 05:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CaHKChy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0FD83C28; Thu, 18 Dec 2025 05:22:57 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E33A83B49
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so205162b3a.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 20:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766031774; x=1766636574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Z/24Gn2ad/h7883MXUwgYgkaIU7ZkLifF5fGK0jEds=;
 b=CaHKChy8QnULyQiZ/b9vnIvQIVXsKJfnxW+wwMbrQOj/Hlzx4HB68Lhh2+g1NUhQ5J
 RVedPBg3dcGw51beia6zjkmjz+aXaOy5Tbl5VbdT3nirsQGwCa2ct1IabcSdtROu7vN6
 PL9lgXrDDIlUZ7aL/Lfi3kopfZZhW1XgYbIrFf6Vc2dXOr2kKJ9ujHjIsiFvdPPnPE7D
 yfyPaEhvcYJmfJvKAlZgKgQESh1fxoJ8hkmVsII8Tngr4qjNaMD2nUHpAb1ozkDNauZx
 kQdG/P8remg6aGr/iyq62r5DfTg9NFjexrtIxxfvC6UWELOVdRmmfkp0E5+OeXXam8V+
 Oc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766031774; x=1766636574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Z/24Gn2ad/h7883MXUwgYgkaIU7ZkLifF5fGK0jEds=;
 b=Moq9mx/UcPDyGv+wVJx2YzpiU2SlCVORHH4OlAYEKI2en6fZo1u358VjXtnaJ3fkoK
 c865RBRIGcEucvek4Ntw9VmE8tLyGRMuC/FqUhuCNHs5AFcrnkE+vLrsMbXsso95p4Gi
 eKBf3ifkHP2/ZdeFbt3qax3YqsRXI0/9+lGgIMfLB1z11aCMiK3Gt8sLuB5WL5IzcPrV
 jbqSLHk/KXSu+62nVdCQI3wSvhMB/PzGWzCyLK9tFxWnnJh1bOJ5zS2BnjGG+smy8BP0
 2skiJUuqz2BYdlwQUZkWkFZ8JfN1LdzDCDbVXH8Tc/DSsLx+3YidvgvRrvRvJaiE+Shn
 seCA==
X-Gm-Message-State: AOJu0YzpVtTvDKjXDemDZSEEy9lLgOOh/hNCPCTcFjOxnibwGzsuzj0Y
 myTuJP5jTvEV9ZlXnrnx8NLig+Qh0hGbORuQlw9KtBe+ZpxdPqlZKJKX
X-Gm-Gg: AY/fxX5HvnUb7RZ8yHtB9VyIs7NOPE9ST5ObO9tdkxRS1qEDdobbcQm704LoKjMB3EY
 qMA/FYDp+kSre/146Wiz/58eyX/1aBojtQO9OzIB8czi/JGTJeDWBVx0V7sIKrGQhhVFIvAt0mM
 xz7GxVJh6DUhJq98lx8ruQf8A+O3zTZdjr2aMytOnCZnJ/G0Mb0dNtYPOaq7qyUMSgw1A3tMkDq
 u0yx5xxNXb2mcyTrMNy/gZ943CgG5on8lE+zEgaocPskvIrQ1ialY/fZ3cX8aY4eu9RoY1a9US7
 iBTISUF63sbDF/mUdgGepJz/gb0XwBBDO4i642ikGZxaNygG+MEkLs967+r95BpXsSsOIMwPT5G
 pVKGM3qk5Vj1sbdZtkZSyLCxzCORaRxYxc00ECErQUDQNhNGo8DbTjTyrVJnMicSHCRSQSW/WNq
 u3xpKy+9oes+FQsuu/Edo0hEJ9T9nxEhrItyo=
X-Google-Smtp-Source: AGHT+IGTYqu9sRTtL5cVx7t02/zRxBCe2E3n5qf25gb5s/Ry7cZpy2RilAuPoqVDSFnH2HBmaDr1rA==
X-Received: by 2002:a05:6a20:3949:b0:334:97dd:c5b4 with SMTP id
 adf61e73a8af0-369adbc9f1fmr19898551637.27.1766031773588; 
 Wed, 17 Dec 2025 20:22:53 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:73ef:52b5:685b:7c64])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d087d485sm9305655ad.16.2025.12.17.20.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 20:22:53 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org,
	seanga2@gmail.com
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 0/3] arm: mvebu: Updates for xcat3
Date: Thu, 18 Dec 2025 17:22:41 +1300
Message-ID: <20251218042244.1833380-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.52.0
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

This series fixes an issue I was seeing on some xcat3 boards. I've also
included a new board that we've had in a downstream fork for some time.

Chris Packham (3):
  mtd: nand: pxa3xx: Use pr_err() in some places
  arm: mvebu: db-xc3-24g4xg: Remove marvell,nand-keep-config
  arm: mvebu: Add Allied Telesis x220

 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/armada-xp-atl-x220.dts           | 162 ++++++++++++++++++
 .../dts/armada-xp-db-xc3-24g4xg-u-boot.dtsi   |   1 -
 arch/arm/mach-mvebu/Kconfig                   |   7 +
 board/alliedtelesis/x220/.gitattributes       |   1 +
 board/alliedtelesis/x220/.gitignore           |   1 +
 board/alliedtelesis/x220/MAINTAINERS          |   7 +
 board/alliedtelesis/x220/Makefile             |  14 ++
 board/alliedtelesis/x220/README               |   4 +
 board/alliedtelesis/x220/binary.0             | Bin 0 -> 423 bytes
 board/alliedtelesis/x220/kwbimage.cfg.in      |  12 ++
 board/alliedtelesis/x220/x220.c               |  67 ++++++++
 configs/x220_defconfig                        |  76 ++++++++
 drivers/mtd/nand/raw/pxa3xx_nand.c            |   9 +-
 include/configs/x220.h                        |  20 +++
 15 files changed, 375 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/armada-xp-atl-x220.dts
 create mode 100644 board/alliedtelesis/x220/.gitattributes
 create mode 100644 board/alliedtelesis/x220/.gitignore
 create mode 100644 board/alliedtelesis/x220/MAINTAINERS
 create mode 100644 board/alliedtelesis/x220/Makefile
 create mode 100644 board/alliedtelesis/x220/README
 create mode 100644 board/alliedtelesis/x220/binary.0
 create mode 100644 board/alliedtelesis/x220/kwbimage.cfg.in
 create mode 100644 board/alliedtelesis/x220/x220.c
 create mode 100644 configs/x220_defconfig
 create mode 100644 include/configs/x220.h

-- 
2.52.0


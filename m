Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE70EC2BD09
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 01:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 098FE885B3;
	Sat, 29 Jun 2024 03:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gyUpLiM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91EA8885A5; Fri, 28 Jun 2024 19:35:49 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BFF88214
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ec17eb4493so12689001fa.2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596147; x=1720200947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tVEmC0DbGNg0mVpjiWzOBumvBeYIAawJeHuhcS4UV0o=;
 b=gyUpLiM/EgWCkUfeYNeGzgnWCKqojXlUfrKKLHh6PTZ0faco/AQ2ccGgEHfPP9ZhH4
 /ijxvkTT+lbf1rXUuNYTHwV8JYI6aXSmqY9tsdRZz1jj/FO5EpHjQRbI1EDGMDibvQTI
 k3/MyGTO9qbD0tTTK/RZnCdH0sASurH4o9LaIFuJz4Yh7oBzBBpX8e4kObNHljMMkG47
 9O0zIoOKSuGkER6Ny1P4B0X1YEh51LWIWzlz5xASwwEY7qbAVZhTbaxYOD4MMpyc2ExA
 nX6EBAhpBLybbMosprSD8gKcUXYK9wVNvwnH9mHSxqk3e/xq359hS2bbTx+SN/6vU9Ab
 DASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596147; x=1720200947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tVEmC0DbGNg0mVpjiWzOBumvBeYIAawJeHuhcS4UV0o=;
 b=JGs8kWw8AJ4HeYZZIVyAXwyq7xUkj3vXh/CNy8rpz0+0J4TSXt4WhAIQbtcELNNpNp
 HTuPuUYqH+wchJwDH4KYiQS8eUCtfPg4B/Q/2eYYvSDePwaSOFkDxLvk823ueV5f5TXT
 u4SGLCOlENmFnnpaisu8Z1xym1RMFtgQBEpyHMqr3Qzr6IbIknh9xffp/IZH1+94plDO
 XQ82PN0LvlpocA4k7m53ZF5hsdstcq1+C8OEBUluxu2iW9lYNN8W+Vxbc1fs88YmvuGB
 bxYkE8Mn/m2mHRDJRpVQVEOyKykcNxrgErMEwK/bPuns/YJ8x6+q1+Rue7mhQSLP4GDF
 NMgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUmBfClgpJeWufssB1FuHIaYUqZpWd8ax/gt3Yhku2qRQ8Xb4vgiZ0E+phfsTl0UW9UPBK5EtBsgMB7e1bt9HzpNINuQ==
X-Gm-Message-State: AOJu0YwQLznNq2ptuAtkND5oKvXN/usIASqTpUh58RwccYnFmJ67qKMc
 +KSqrloCyldVvwWeTxN8yHxq25+dtil3q+eSnUNjVZxMThGw/lNZ
X-Google-Smtp-Source: AGHT+IHvOMhoqPeyPqnkYMLmHW6CIHzfA3luzTNSRxGPDOA+tIQQlgriUD/fkWtNVMCMrRoPER/zTQ==
X-Received: by 2002:a2e:8612:0:b0:2ee:4cd8:94b6 with SMTP id
 38308e7fff4ca-2ee4cd89665mr42010451fa.15.1719596146300; 
 Fri, 28 Jun 2024 10:35:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafb9e4csm96214666b.95.2024.06.28.10.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:35:45 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vassilisamir@gmail.com,
	quentin.schulz@cherry.de,
	u-boot@lists.denx.de
Subject: [PATCH v4 0/3] drivers: bootcount: Add support for ANY filesystem
Date: Fri, 28 Jun 2024 19:35:40 +0200
Message-Id: <20240628173543.129207-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 29 Jun 2024 03:11:20 +0200
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

Changes in v4:
	- Add bootcount.rst in doc/api/index.rst
	- Fix typo in documentation

Changes in v3:
	- Remove specific CONFIGs for filesystems
	- Add message to prompt user to enable required write function
	- Use tags from previous rounds
	- Move documentation to rST

v2: https://lore.kernel.org/u-boot/20240610185116.353604-1-vassilisamir@gmail.com

Changes in v2:
	- Use generic code by utilizing FS_TYPE_ANY
	- Change filename from bootcount_ext.c to bootcount_fs.c

v1: https://lore.kernel.org/u-boot/20240605181041.68317-1-vassilisamir@gmail.com/

This patch adds support to save the bootcount variable in a file located in
FAT filesystem. Up to now, there was support only for EXT filesystem.

The reason I put this as RFC is because the file "bootcount_ext.c" will no
longer represent the implementation for the EXT filesystem, but also for the
FAT filesystem. Should it be renamed? If not, wouldn't it be inconsistent?

Cheers,
Vasilis

Vasileios Amoiridis (3):
  drivers: bootcount: Add support for ANY filesystem
  doc: api: bootcount: Convert to rST documentation
  drivers: bootcount: Fix typo in documentation

 doc/README.bootcount                          | 53 -----------------
 doc/api/bootcount.rst                         | 58 +++++++++++++++++++
 doc/api/index.rst                             |  1 +
 drivers/bootcount/Kconfig                     | 36 ++++++------
 drivers/bootcount/Makefile                    |  2 +-
 .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++--
 6 files changed, 84 insertions(+), 78 deletions(-)
 delete mode 100644 doc/README.bootcount
 create mode 100644 doc/api/bootcount.rst
 rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)


base-commit: c53b344475734d0d29f522b7b1d80c5b8204442d
-- 
2.25.1


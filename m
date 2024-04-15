Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78604C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 04:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB4488093;
	Mon, 15 Apr 2024 06:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dc8QL+fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 440A48811D; Mon, 15 Apr 2024 06:33:24 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C176D87F4A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso27147995ad.2
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713155600; x=1713760400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+mYtvO3WAMcrsWd0olrimNtFRI6Qr9yx/g9zZpVx3zY=;
 b=dc8QL+fy24sJrIAGnbT0TJhsyexZWqc50uwIyT9pSQCOixZXXinbFYeJVQZBUFfQ0x
 S8/+Rk/UpG3XTiCYxAMcBjjKCjJ4/RNcygWgz7nfsfD6ml9L1LiM2KFpfxOZcSRgBJ3y
 wyRGm0qmdISILZeK+d2B0uZoibftg1zQ9n9hubwxru8iNdm0/vZezSmOms7UrEl4A9wt
 TqwjLy2e6UENQ4XPkIq4RvEzhs/DcCpVJAVkaYkLyU8tLqDGoPapBAHpiIOUUumecajL
 qnTE52tvuCE+9F6bRx5dGbCvdR4UxI2IH0qWmE7DnJoqwPcIs+IomsprdUZLsNcLOCTS
 7vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713155600; x=1713760400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+mYtvO3WAMcrsWd0olrimNtFRI6Qr9yx/g9zZpVx3zY=;
 b=bfYKKpw61USXwvXFlU4XVTaPNI3Fw3NLn7k2UemBFoG54a3doV5ycy/smzRnE99suJ
 wqlj1UJgdqdYCQkZVH8KklmUGdSr6IKTB756+TNf69vycYpDicp6IYRD/IzsCZb1yDJa
 KeKTC40Nf+gEioZW2IEcvArpv5QlufxjZgh1szgJkM97yjIocyeTIckGOJpKpKY90Mgh
 pTfkby5eYZd90BCmJ9xGHjtlcMpaEBWYmbm+xaJlTUistzIUyLwzbmX4XY3O8jOjG125
 0C3giOomqxl3VcasQwP2t0Ufw+JDj8j4ZLEl8+R2hq4ycMO9QqEU+Yb6AP2wVTNDTagI
 SLFA==
X-Gm-Message-State: AOJu0Yxz9CXjP8PqgesVC7a0nPXlXA7A1YKhpsLTWsv9CMreTqtlfBtA
 57hbov9TnNtXNnexbS6iyvNEITnXPG8RiZSXPtJTQHeo2weqMWuXjukduA==
X-Google-Smtp-Source: AGHT+IHs0qlG3479kEdAxio0QgPhg++yL4z02a+dlertKV4DR10ti7Q9oOAUHmnYHjUVI4ZHcXsryw==
X-Received: by 2002:a17:902:d504:b0:1e5:4f00:37b9 with SMTP id
 b4-20020a170902d50400b001e54f0037b9mr13620533plg.11.1713155600152; 
 Sun, 14 Apr 2024 21:33:20 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001dd88a5dc47sm6902682plh.290.2024.04.14.21.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 21:33:19 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, d-gole@ti.com, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 0/4] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
Date: Mon, 15 Apr 2024 13:33:07 +0900
Message-Id: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
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

This series is equivalent to the one for Linux MTD submitted by
Pratyush Yadav.

https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*

Takahiro Kuwano (4):
  mtd: ubi: Do not zero out EC and VID on ECC-ed NOR flashes
  mtd: spi-nor: Allow flashes to specify MTD writesize
  mtd: spi-nor-core: Rework default_init() to take flash_parameter
  mtd: spi-nor: Set ECC unit size to MTD writesize in Infineon SEMPER
    flashes

 drivers/mtd/spi/spi-nor-core.c | 45 +++++++++++++++++++++++++---------
 drivers/mtd/ubi/build.c        |  4 +--
 drivers/mtd/ubi/io.c           |  9 ++++++-
 include/linux/mtd/spi-nor.h    |  1 +
 4 files changed, 44 insertions(+), 15 deletions(-)

-- 
2.34.1


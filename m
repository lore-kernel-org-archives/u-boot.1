Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE994D70DF2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5EC880050;
	Thu, 18 Dec 2025 20:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cfFrzaDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3E5800AB; Thu, 18 Dec 2025 20:42:37 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558E78003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso861420b3a.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766086954; x=1766691754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4PP8f/u4McnacIk3O+Uypo03v8WZFjfVUOufUDXiK1Y=;
 b=cfFrzaDpNnBxrWYAXiNcZR+omIFCfqtIB33+YsjYxRR1MI23zpKfhsjY1T896AjzXa
 6P7aUv7+GupENwI3FIjomcQKXlzU6KKq05iyNipHTfmMBxv+l0c5t2/AarFXJCVpGd6X
 iaMxDVNDL4jk4uzQ2vmPQv9UgLOBEclKGzGS8SsuEWHjiEATwEpvSKInVc6WIkYIXSut
 IYhJ5SrMVsjTderQaA1ZZnRwgVq+7KR21V9K8eHLvj6ZkRB3PbSgO72CQ3P8SVTCShGt
 QVk/Zr5IJL0IypUO+8OjU45LyZsBQ+woYS7jC8NSsQvpINM9O+gCPsY6fKCbGRbTrnyf
 ONgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766086954; x=1766691754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PP8f/u4McnacIk3O+Uypo03v8WZFjfVUOufUDXiK1Y=;
 b=a46jTlSZJJJJ4N0mVcDB8xRcyA/LFE7+XVT+IrbqeFoixyumVJVU2ivA/dAB7etkOO
 yhZEQN+dySkEVZ5gmddpAjd68Lrrodznhjl/HuwV6W7/LJsTHWxLHuU0Mfm0nUpaXLmY
 FuZrgo2qafG9CHdOLcNBXQas/R/0GQg8OO74BO7bCDw74i5cuNtc8HcWQgD+Vi094WLo
 8AENgVZzIadV4NNCRiJ1Yp0JzQ2oVHSWBMoKKPP6pAn2nH/YaCSEQA/mMF3jjzSdwFmb
 4hKSY8gVnBzfoB5TRb/toD7iLeCT+S4s8ztLgHhlN8tEkHH/MW1Se5aYx1YR2OVBGdrK
 LzNg==
X-Gm-Message-State: AOJu0YxfavS+N8KwKy2u3Yg5Ncd2piM7Jy/0hhLGIVKW4A5ftthJs9Rs
 +dj0x+R4LG6CQfUoMx7HubXWCyrvkZaipN9+ULoYcpDr+aZPWvjDtJpA
X-Gm-Gg: AY/fxX7cZz0IurJdg26rm8wCo4kWzIsR6iHxnFmrPlxQIZsinMojUOb78X5WmYRS5Kb
 8DU7AKOuMB9bepdQnbNKrkv9hhbBHwuYgJ7JPJPPteM2rjXE/vkP7FlUJzj6iruD7hd364yI/wV
 f53A1BQqg24yhrhZg4ct6JgSe9HeehucPUXJ1Q6WSgfyK0QdOeVY1nbg288nmc2OCWSLpxssXG9
 EscJw/RjCKgf0LQY2ca9hNKlDU8Zf9vBYXflcpOlGMWBrEsW5CIIHb9+HkL6bFQgbD+3176TbYK
 fDMT5NxcxUNtJ69rlV2v/OezMmlZQ1s5nxctShRxKEbcRM2rgEVb3ZbtF4r8UdKvIvcVN9B+C1W
 73D9U/9Twht2uoi1SCIDshMggLllo/X531JfVKibBx2bvU30TTPyP8NVkAcViWb14no6KvNEpyH
 0428TLYPATiXNHTwugLg+z9yWH51LEgJRpT/0=
X-Google-Smtp-Source: AGHT+IHJwqcJbYQXDA0tlktJHO3I+laaWuqjcg8FN1bRpRVYn8VAvJxIC8bMo626LnDoEuxkD0qPxA==
X-Received: by 2002:a05:6300:50d:20b0:366:14af:9bd3 with SMTP id
 adf61e73a8af0-376aa0f02b2mr371579637.73.1766086953694; 
 Thu, 18 Dec 2025 11:42:33 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c146aabsm116413a12.25.2025.12.18.11.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:42:33 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 0/3] arm: mvebu: Updates for xcat3
Date: Fri, 19 Dec 2025 08:42:15 +1300
Message-ID: <20251218194218.1972757-1-judge.packham@gmail.com>
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
  mtd: nand: pxa3xx: Pass valid dev to dev_err()
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
 drivers/mtd/nand/raw/pxa3xx_nand.c            |  11 +-
 include/configs/x220.h                        |  20 +++
 15 files changed, 377 insertions(+), 7 deletions(-)
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


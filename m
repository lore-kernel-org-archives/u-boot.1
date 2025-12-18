Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA94D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 22:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D4980077;
	Thu, 18 Dec 2025 23:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XqqvBXCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1704E800AB; Thu, 18 Dec 2025 23:59:48 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D267D8003E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 23:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so1087272a91.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766098784; x=1766703584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4PP8f/u4McnacIk3O+Uypo03v8WZFjfVUOufUDXiK1Y=;
 b=XqqvBXCZCXCPNjP6Tp4HSiBQLZg7ouyCr+HAPrxdWIHRLZXM3CdtTX52RBHmFECXSX
 PiRNdJpNeVWDCyBPWshPKUEAOy/RG93etkqwEivnrVTIV3PpoiEM5LsORs0v6qCaIoPd
 RK7ET4UlgnvzpOOl1+GcjVT4GgV7S5NVwsJGLrwtdsrd2p22ZrMN11jyKKDAGjtMRcW8
 lxAhPlAvZ1LBzzo5ieZmYgVWvcohjObSgz0+U4FD4oCHJnlS+TYbok7nB65cB59SpKrk
 rz3KCp9D2/aDmnyMB5uVHNcRBj5Wachxj4TPk8ZCDvI+hgw9ZAVFOe7PIhT6BJFcgkIU
 YbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766098784; x=1766703584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PP8f/u4McnacIk3O+Uypo03v8WZFjfVUOufUDXiK1Y=;
 b=f/lCpdHUDL3a9fs4OkPO5tffXgKNhQPxY/LmuXYahHRICDUFhWq2NSUQ2jVNr+j71w
 u4M6BqOEaeVxnvDh8+JuZIilm02iqL4kPbuSiD7uzWcLA/bB/2nqtj2tMtxoaJQ6njiJ
 LnW3tekqj4YrCsP0IHe/RyoZ4ugdnXe+4b4GlnA1WeG2PhLhNqUjwWicvNuIpslEFJel
 DvTN8u0ZkdU2+DLaLrqmYI/A56XchbLO6sLPR65fLZNEjOKbqdVO3SnI56Dvt6Z7yEgA
 R62tLfNyXHCQKRYMzErfnn1nY3K6Gf4/EombZuuInrZG0++7kbL6sGNAxatjTo7Uh/X4
 qxXQ==
X-Gm-Message-State: AOJu0Yzw4qx9K3k0kzN28+xXyBQ2mWJfUNgFGehoxr093iA9U55d4ry1
 Szovnl+zPRURMNd4znSqQs0N8yIlMPP3rORs81nQFFwOlEgF+o0Cruml
X-Gm-Gg: AY/fxX7PHfPcIK2znmwWrAWFtdcw6FXGNM2KuhEwsCoqOmSfkjU8BJXM8b2GSiC77SY
 oNseqcXfoFjTs505ODmqeeg+pi0zKY/fxRFZLITguRpY2ZLT8pKKYwgQbv+12vEKaTVFVcmY/Ld
 Wev7Aozh7ilw5jFBPmW7h1wraW8P2mzTPbFC1T5Xib+JYDQQLq1UlP3EekAHbrnrpg6NTR5qrlM
 +nzb7OdPU+x39bPfq1oa97rXd9IzrBLmQ2b7UKTZ02g1opiqbr5nv45WpOu4T06FCk1B7Ox4Ap2
 6jvAjGuGPULOUdutKqcb/ANUO0LLw6xLwaSCbsfk98hAe/H25RE9Wx3iWEqxhjK9yKGti08ue/b
 Uqx5n9G6GS7tYLckDVoun/jXpK8o2Nwy435SjGIrLXRkn+KnYtrRXyK+jKngMM0PJSukCpgS+3N
 0asT/8tJuJIyBE0wWdr8XFIQPg
X-Google-Smtp-Source: AGHT+IGCHf516dxL+CfKdVzOxxrWNfynBwPwFAPRmoe2UpaoPeNg5rvkszlzJ45Y9tziJgn1lr8ndg==
X-Received: by 2002:a17:90b:548c:b0:343:60ab:ca8e with SMTP id
 98e67ed59e1d1-34e921bec08mr780031a91.17.1766098784144; 
 Thu, 18 Dec 2025 14:59:44 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:dc63:c226:257b:b4c4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70d6565esm3431356a91.6.2025.12.18.14.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 14:59:43 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: trini@konsulko.com,
	stefan.roese@mailbox.org
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH v3 0/3] arm: mvebu: Updates for xcat3
Date: Fri, 19 Dec 2025 11:59:33 +1300
Message-ID: <20251218225936.2016920-1-judge.packham@gmail.com>
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


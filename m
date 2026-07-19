Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B82C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 13:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF3C849BD;
	Sun, 19 Jul 2026 15:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HT5lGBa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15E608488B; Sun, 19 Jul 2026 14:18:06 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF9E838D7
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 14:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prasanth.padarthi10@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so5184387a12.3
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784463482; x=1785068282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BMLJkil0IdgABfdSB+xdWXIGEEOsQFpukF8hCOSXdb4=;
 b=HT5lGBa9giFnmXCQtui0IPYMgoDQO8pNdD3YEHSb4LzURw0NTzH3yl9wVrtnEjVNUj
 zyFULK9NZ2nIWX+CpYfK6+FtmeMlDiQ0LJNSaBOE6zw/a93mQfObL0BOZr786sqWfg5W
 MhMbUYONzmtDhEC5wXI1hxWJdGaR9NJdjQqYNLLTEWDB+Qt4CrG/EG0ttsMkA6jMA8ug
 tDcrXuUJgPSxzfVPQnTVvIV/F3FI+nq6CNjPKJh2dBBiolLkr4AmdBkuJqcWEmY0AF8X
 mxVx5yNmvwDPQ27mZGiXd0idxlO/MQ3DpLLXylZ6NhuowHOUwAg6mrSylu47bV7q5vhi
 KbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784463482; x=1785068282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BMLJkil0IdgABfdSB+xdWXIGEEOsQFpukF8hCOSXdb4=;
 b=VdyMBFJ0umov6Oe6EdVFtaiwI084PnGms6GQNBZ4TlLkmtG8Xyy/FQvo+RKWtB5a+j
 uQqMpDqU3w5ErC+du5LUo3zY/wwNRdGRvQ6NpXpIonFJbTeJqdTWQqZsrS87TqoI3lvW
 K1xJDGefDs9VVK6YeH6W23EKQJE0djXNsB00Mvqjv9DBXqg0+UMbeY799vRYTh/sMlTP
 jARzMv/EKM7nim+T265Dm0HlI2zTH47xg6xQRSK7uiK/glIPxe+ABekqyi9vHBWw8r+G
 rMwmh+8GN7IegzvXZQEYhZ+2gLF0HST5RyqmSk63DVK8QaRx3DJOag57g4vb6ae6xKZY
 q/Jg==
X-Gm-Message-State: AOJu0YzpcSdMdcYoa64UfgZXJHhxq8q1X5YA01AQ5s0F7jZv0Y/KMvj1
 75SCAPUPRdNTbcfXTgdklHMrkT+HiK7TDyvoEdzpVDY9ZLYmuEysyuTkNAv6HQ==
X-Gm-Gg: AfdE7cnZu+4AMo+dtI3TMQ9oBXA36SUE11cEe2vKIER4m96utBZCVmvCaLQvcsu952m
 t6tp3ovFLuw/4bpzI3vB/9uEr0D2J6pZ4mY4P0IS7w85H1xCpyKYdDivitYYrqC7pUnXly3DKGl
 blNGviCthusLQT3DdIh/szvSKf5sGANhDr0kLR95i67xBcA6IYZ9P8ty6WvXtbYrwPcZSfVCZWo
 lv+MSgHm6/px6qMR9/Y9x/t+Ab/1K0vaeJ2WweqqIuTWv051Cv+vb+9L750OJFDkSdOR0gDJUAN
 bsWy6e1en3XC+rrbv1rBlTz5W4Xd6WW+OzH2im0z1yfVeNfuasZRcQ2EtU86QgA78+QSGfP04aY
 sH8iGF2qkcr/74aPh8Pfm7NMokqV9MtFIaMcPKhEvA8rPvALlcW+0+ZZvMQJQVKimlhlFxWu3hS
 oZzDjRumfytnxYkzyx3wKe
X-Received: by 2002:a05:6a20:ae2f:b0:3c0:9c1b:d0b3 with SMTP id
 adf61e73a8af0-3c3ad99f4e5mr9372365637.62.1784463481740; 
 Sun, 19 Jul 2026 05:18:01 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.149])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm28364130eec.29.2026.07.19.05.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 05:18:01 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au,
 Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [RFC PATCH v1 0/1] arm: aspeed: Add ASRock Rack B650D4U BMC support
Date: Sun, 19 Jul 2026 17:47:51 +0530
Message-ID: <20260719121752.88393-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 19 Jul 2026 15:11:38 +0200
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

Add initial U-Boot support for the ASRock Rack B650D4U BMC,
which is based on the ASPEED AST2600.

The board description enables:

- 512 MiB BMC DRAM
- UART5 debug console
- AST2600 watchdog
- 64 MiB Winbond W25Q512JV SPI NOR
- MAC0 connected to a Realtek RTL8211F PHY using RGMII
- MAC2 using RMII/NCSI

The environment is kept non-persistent to avoid modifying the vendor
firmware environment.

Runtime validation was performed by loading main U-Boot into RAM from
the vendor U-Boot using YMODEM. The following were verified:

- UART console input and output
- board model detection
- 512 MiB DRAM capacity and 440 MiB usable memory
- SPI NOR detection
- MAC0 link at 100 Mbps full duplex
- bidirectional ARP and ICMP traffic

SPL execution from reset and cold DRAM initialization have not yet been
validated. MAC2 is described and the NCSI support is built, but complete
end-to-end NCSI traffic remains to be validated. Therefore this series
is being submitted as an RFC.

The build completes with the existing AST2600 spi_bus_bridge node-name
warning from ast2600.dtsi.

Prasanth Kumar Padarthi (1):
  arm: aspeed: Add ASRock Rack B650D4U BMC support

 MAINTAINERS                      |   6 ++
 arch/arm/dts/ast2600-b650d4u.dts |  74 ++++++++++++++++++++
 configs/b650d4u_defconfig        | 115 +++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 arch/arm/dts/ast2600-b650d4u.dts
 create mode 100644 configs/b650d4u_defconfig

-- 
2.47.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21F7C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 423F1864B7;
	Thu, 24 Aug 2023 15:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X1SeX/Cp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05112864E7; Thu, 24 Aug 2023 15:27:44 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7397286430
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a1de3417acso190023866b.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883661; x=1693488461;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1/zlCjxRDq62vroj74qt6HhBerE62FD8hD0wt+AnJg=;
 b=X1SeX/CpStLNf4yhqL6dslfTkMcdrnFh85lqQ5JR6yz2q1vyHyJ3GSFGKjM9Yxayyo
 hl6nSpElB3AsmV0ZHkXX5hhBkBpRwVIAiFLOgOTFFosQ7bs2Xxb6ztNvxXMOhAK3dpvH
 kidfKlJKXHwvq7RMb2g5YQI6oUtUFy5MYwFkzxvSShJfIR2+mA4YVPH5c4oMYyFaiYXX
 lYdk6cDoBtXJDO4aKIKkSMhE+zHSjkkddu0Ot61BTVo7Eo3bQCUHBk77c8JchbSAJzvF
 sSLGf1YnUCY+Lel+BV4vjK30fT0h1YaQLjX0Ebgu/pHPb7/SXbJl4z7Wv6Dg7+EIsYH2
 KAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883661; x=1693488461;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y1/zlCjxRDq62vroj74qt6HhBerE62FD8hD0wt+AnJg=;
 b=Jh8IYTYIg9X6LMMwxN9WvONVSPSSJwy7qz/ev4TQ9Py21MjlNJ7ywEHLI6RWDgaiqq
 0Rg6WnQuqVeZnQI7DsG1ZbiyGROF79qoQAng3s16JgctBkEBEXd62mO0BDzzQma/HlA0
 0VhWGLywBECNsqxp+g0h0rOEIC0cPna7ALxdltrwsKyOr5v/QHhtHUAqCpvYPihYdS2D
 RLTrGChxXizfijmIv/1zL2fAWSLppGdFqrhC/fxUL7l6Oo4kdu+R6UidFa6TfBP9ewLa
 dTIcHpxcELMsYo1teCslyvMS9hs/3EURVG2YesnPl0UjMS7yflM2+xjqekp9zGp5dmGE
 aHnw==
X-Gm-Message-State: AOJu0YyOh7fHQRc1XYEJCbtNFtv3yCbQCxxO/E6t9c84yGvjnkZsVVXH
 DA8CqWJt141HSTlkb2jLAWbxg80/Lcs=
X-Google-Smtp-Source: AGHT+IEQRUTh3BvfAiNghRpONUwgGJYDs2gfvfqI8B2WZ+kPxAgBeUWS7buBUeEst5hkmcAsIaCINA==
X-Received: by 2002:a17:907:6093:b0:966:1bf2:2af5 with SMTP id
 ht19-20020a170907609300b009661bf22af5mr16353770ejc.22.1692883660748; 
 Thu, 24 Aug 2023 06:27:40 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a170906269700b00992b50fbbe9sm11045409ejc.90.2023.08.24.06.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 06:27:40 -0700 (PDT)
Message-ID: <cbbaecb0-19fc-018d-df63-c5f265156024@gmail.com>
Date: Thu, 24 Aug 2023 15:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/3] Add rockmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Rockmtd creates a virtual block device to transfer Rockchip
boot block data to and from NAND with block orientated tools
like "ums" and "rockusb".

It uses the Rockchip MTD driver to scan for boot blocks and copies
data from the first block in a GPT formatted virtual disk.
Data must be written in U-boot "idbloader.img" format and start at
partition "loader1" offset 64. The data header is parsed
for length and offset. When the last sector is received
it erases up to 5 erase blocks on NAND and writes boot blocks
in a pattern depending on the NAND ID. Data is then verified.
When a block turns out bad the block header is discarded.

Limitations:
Support for Rockchip boot block header type 1 only.
Pattern for listed NAND IDs only. (Logic still not disclosed by Rockchip)
The MTD framework driver data and NAND ID must be extracted at a lower level.
Only tested with rk3066 NFC v6.0.

Available rockmtd commands:
rockmtd bind <label>      - bind ROCKMTD device
rockmtd unbind <label>    - unbind ROCKMTD device
rockmtd info [<label>]    - show all available ROCKMTD devices
rockmtd dev [<label>]     - show or set current ROCKMTD device

U-boot settings:
Config to enable Rockchip MTD support:
CONFIG_MTD=y
CONFIG_MTD_RAW_NAND=y
CONFIG_SYS_NAND_DRIVER_ECC_LAYOUT=y
CONFIG_SYS_NAND_USE_FLASH_BBT=y
CONFIG_ROCKCHIP_NAND=y

Option to keep existing NAND data unchanged:
CONFIG_ROCKCHIP_NAND_SKIP_BBTSCAN=y

Commands to enable:
CONFIG_CMD_USB=y
CONFIG_CMD_ROCKMTD=y
CONFIG_CMD_ROCKUSB=y
CONFIG_CMD_USB_MASS_STORAGE=y

Linux Host (PC) tool commands combinations that work:

U-boot					Linux
rockmtd bind 0

# rockusb
rockusb 0 rkmtd 0
					upgrade_tool pl
					upgrade_tool wl 64 idbloader.img
					upgrade_tool rl 64 512 upgrade_tool_rl_64_512.img
					upgrade_tool rd

					rkdeveloptool ppt
					rkdeveloptool wlx loader1 idbloader.img
					rkdeveloptool wl 64 idbloader.img
					rkdeveloptool rl 64 512 rkdeveloptool_rl_64_512.img
					rkdeveloptool rd

					rkflashtool w 64 512 < idbloader.img
					rkflashtool r 64 512 > rkflashtool_r_64_512.img
# ums
ums 0 rkmtd 0
					dd if=idbloader.img of=/dev/sda1
					dd if=/dev/sda1 of=ums_0_idb_0_rd.img

Johan Jonker (3):
  mtd: nand: raw: rockchip_nfc: add NAND_SKIP_BBTSCAN option
  dm: prepare rkmtd UCLASS
  rockchip: cmd: add rockmtd command

 cmd/Kconfig                         |    7 +
 cmd/Makefile                        |    1 +
 cmd/rockmtd.c                       | 1429 +++++++++++++++++++++++++++
 disk/part.c                         |    4 +
 drivers/block/blk-uclass.c          |    1 +
 drivers/mtd/nand/raw/Kconfig        |    9 +
 drivers/mtd/nand/raw/rockchip_nfc.c |    3 +
 include/dm/uclass-id.h              |    1 +
 8 files changed, 1455 insertions(+)
 create mode 100644 cmd/rockmtd.c

--
2.30.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0E1CE7B1A
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 18:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A6986548;
	Thu, 28 Sep 2023 20:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b8gj34Q7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13473867EF; Thu, 28 Sep 2023 20:49:32 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2451A86545
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 20:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso136041845e9.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695926969; x=1696531769; darn=lists.denx.de;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmtNeCwv0X9AxdsODzvrUsnKfChRL6gKodXlw6w9YoM=;
 b=b8gj34Q7BhfcYUhmFUogx7F245VXWdorRguV4l5f3LE+sg0tYIasSJmTM9QegIHx/j
 bTAyPpI+BiPj5AjJoFYgSFPErHWmPiAc7OQd/Y/LmOZizfOPxvaM8PPtEgUtxWRCtzw2
 jmY/tGXYI3jUpBZ0IcnkMTR4CLbz+kdvXCC79u+lXC5EDLuprvEg/LfCumWokzfPo7WB
 reTv3d6F6sYp6fIRhipOB/af6iIq0K265qxacRjscbBDmKSEp8PKi09/RCXN+h/nn69j
 X65ITkUp+OuW4/L1zDwNn04HokTEQvzWHOxXiJTCLWOZJbSpMIOWxB2N9M/954v8f95V
 wktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695926969; x=1696531769;
 h=content-transfer-encoding:content-language:cc:to:subject:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cmtNeCwv0X9AxdsODzvrUsnKfChRL6gKodXlw6w9YoM=;
 b=fmIYV0JpXB5OC7ELL5X3vvcwkjYJ4EVxrWd7ctXZyy5PyEdeh0zixFy5PlyZ+3TkUT
 nAKV9DQ5MdcAGv++qHdOKJd3AO08FOOan0Yi0vgC94aCvhTmLP5oQGQA6E/lWw6P4CjV
 nxMDAfOijuiWxiavPJNL7L74ouzA8092zjtmgakfN3WJkZFBGtiJBBceSF1kS0L1q78g
 ksEXrgSjrnpEcYQrVQ7s3PqOINYZWKbyXA9xfUg0Alv4oUVffSqkrzcbCa2nshi/uiN7
 lKVX5trhjDpYxhbAXC7vUHWU8R0SeSMCb1B/b13+rxSFBBFrpW5/WrUEg8z9f2XlGNft
 cD8Q==
X-Gm-Message-State: AOJu0YwcBJGwl6rYkPFXmIm8ulpEh13gk7D7Pr9e+48FE1VnnWcMMLDU
 BvLn5cAtJF1UmnzhrCfzXBg=
X-Google-Smtp-Source: AGHT+IGTTrKht8KBhCIqK6YWuLLwJIw5iPTRgo9dmwbnn+yxpCJBKhlUu87t77EBnc7sbax6qjanPw==
X-Received: by 2002:a05:600c:2205:b0:401:b0f2:88c1 with SMTP id
 z5-20020a05600c220500b00401b0f288c1mr2222623wml.29.1695926969323; 
 Thu, 28 Sep 2023 11:49:29 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a7bc7c5000000b004060f0a0fd5sm7959995wmk.13.2023.09.28.11.49.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 11:49:28 -0700 (PDT)
Message-ID: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
Date: Thu, 28 Sep 2023 20:49:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 0/3] Add rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
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

The command rkmtd creates a virtual block device to transfer
Rockchip boot block data to and from NAND with block orientated
tools like "ums" and "rockusb".

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

Available rkmtd commands:
rkmtd bind <label>      - bind RKMTD device
rkmtd unbind <label>    - unbind RKMTD device
rkmtd info [<label>]    - show all available RKMTD devices
rkmtd dev [<label>]     - show or set current RKMTD device

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
CONFIG_CMD_RKMTD=y
CONFIG_CMD_ROCKUSB=y
CONFIG_CMD_USB_MASS_STORAGE=y

Linux Host (PC) tool commands combinations that work:

U-boot					Linux
rkmtd bind 0

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
  rockchip: cmd: add rkmtd command

 cmd/Kconfig                         |    7 +
 cmd/Makefile                        |    1 +
 cmd/rkmtd.c                         | 1432 +++++++++++++++++++++++++++
 disk/part.c                         |    4 +
 drivers/block/blk-uclass.c          |    1 +
 drivers/mtd/nand/raw/Kconfig        |    9 +
 drivers/mtd/nand/raw/rockchip_nfc.c |    3 +
 include/dm/uclass-id.h              |    1 +
 8 files changed, 1458 insertions(+)
 create mode 100644 cmd/rkmtd.c

--
2.39.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE987E77371
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2CE87021;
	Sat, 30 Sep 2023 14:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lAT/Dapv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412328702C; Sat, 30 Sep 2023 14:02:19 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A109F86C0B
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7E3F23F6F3; 
 Sat, 30 Sep 2023 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075335;
 bh=eG4MLTrR1h9SoIXF13TxiqvlGh2wYHRCSxo8q0qcE+M=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=lAT/DapvuHn0lisnUxVkhOz1/+u8IVhNVECcqD12ZkjzT1QZvrx3oRBrWPzvXdcFW
 1ZhJtHtak3zW7GVuEzM5i29k8EjX+6IdapxS2IeKHV3ZMcv1msIRN1PUgU5rCjykt6
 A66/j4sC5js0PWCMfwZ39D/4mQY7cUZA6OLQQOcy/hctxKIwz0M7fp4XsLipuCACHj
 32iZrMuk6G2fb+m0ltYQ+96WvkzZuL8vIuTZ1LdfY5sMPOP+Up6ymCE7ififJTM3O5
 w4wrDikXOf9T1OFJugGoyIddrEKWJRX6XaXGZaZHehPgOaPiqHok+wi3Jh6/2lKWlA
 nfAu5d/x6fXQQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/6] cmd mac: separate implementations
Date: Sat, 30 Sep 2023 14:01:41 +0200
Message-Id: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

There are three implementations of the 'mac' command:

* Freescale (NXP)
* SiFive Unmatched
* StarFive VisionFive 2

They all use different sets of sub-commands and hence should display
a different long text help.

This series moves the command definition to the three implementations.

The following fixes are added for the StarFive implementation:

* Provide a hexdump if the data format is unknown.
* Provide a raw sub-command to force a hexdump.

Heinrich Schuchardt (6):
  cmd: move mac command
  freescale: fix long help handling in mac command
  eeprom: SiFive Unmatched: re-implement mac command
  eeprom: starfive: re-implement mac command
  eeprom: starfive: raw dump if unsupported data version
  eeprom: starfive: add 'mac raw' command

 board/freescale/common/sys_eeprom.c           | 30 +++++++-
 .../unmatched/hifive-platform-i2c-eeprom.c    | 30 +++++++-
 .../visionfive2/visionfive2-i2c-eeprom.c      | 68 ++++++++++++-------
 cmd/Makefile                                  |  1 -
 cmd/mac.c                                     | 33 ---------
 5 files changed, 98 insertions(+), 64 deletions(-)
 delete mode 100644 cmd/mac.c

-- 
2.40.1


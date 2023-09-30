Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD73FE77372
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425098706B;
	Sat, 30 Sep 2023 14:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MON6ZeoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1973C86F96; Sat, 30 Sep 2023 14:02:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E2868701F
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 45BD4440AB; 
 Sat, 30 Sep 2023 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075340;
 bh=TkTdSZq9kDadojQGkrZZ6Cptma3RecLqYKmd4dH+xmE=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=MON6ZeoDcX8hGsazh8B0jf1nhR6Me8gx/hHVOZPb6D23VX22mz0yzgOud4RTlWD7/
 WCBpnm/CcRGepYMsY/1ZyXIM1YvBnjUn3aLZkbYjqop9mWqs10v89Qefmagqky4yzD
 tEujsgEX50zWIjGdQ/UHGOGAJxMUST4DR9SJH2hDXCRW2euME3aBfAhRk+xO6nFtve
 WUEuVu+9xV0V9HFRnLkFQAELA1Xjb+OFq8sEDnIlf6yaVlpBc7eOue+3UEoAdnt/sn
 FIed083Ru3RnXaXPw5H261vXwFD1I2Yrp2I7F91eDj0W+Pasd3y7F48fKlYUalnqsm
 m3GArzQ7zT0xg==
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
Subject: [PATCH 6/6] eeprom: starfive: add 'mac raw' command
Date: Sat, 30 Sep 2023 14:01:47 +0200
Message-Id: <20230930120147.59482-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
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

Add a sub-command to print a hexdump of the EEPROM content.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 329fbf6644..710044a235 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -428,6 +428,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return 0;
 	} else if (!strcmp(cmd, "write_eeprom")) {
 		return prog_eeprom(STARFIVE_EEPROM_HATS_SIZE_MAX);
+	} else if (!strcmp(cmd, "raw")) {
+		dump_raw_eeprom();
+		return 0;
 	}
 
 	if (argc != 3)
@@ -550,6 +553,8 @@ static char booti_help_text[] =
 	"    - save memory data structure to the EEPROM\n"
 	"mac initialize\n"
 	"    - initialize the in-memory EEPROM copy with default data\n"
+	"mac raw\n"
+	"    - hexdump memory data structure\n"
 	"mac mac0_address <xx:xx:xx:xx:xx:xx>\n"
 	"    - stores a MAC0 address into the local EEPROM copy\n"
 	"mac mac1_address <xx:xx:xx:xx:xx:xx>\n"
-- 
2.40.1


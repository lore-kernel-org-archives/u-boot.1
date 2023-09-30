Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ECAE77372
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1703687067;
	Sat, 30 Sep 2023 14:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="WAULtkr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE2DB8704A; Sat, 30 Sep 2023 14:02:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 795DA8701F
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A1540440A7; 
 Sat, 30 Sep 2023 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075338;
 bh=1zNmeDlNh1JoKtc5BSz826c292+j+wSQm6gY9VrvWnU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=WAULtkr3hxhcxG96GJtBk7Cn1SUs38YpgvNFwZdeasHZvRr685Qd5kIOxeyfYBdL3
 geFVT43NKVhhP76O4+kLTTgOzn4T56wL05x5zR+nkN3L8SfrfXEG7QnLbAPkrtw6eY
 on8s0Ddb47uNE28aIIxXruc5GYejGyltT8szFbSTgkHPju1HtpZbYsN6/sj/avxxZw
 iDbukvWOLKPN7cRZYEmxNsELLaED11V3LVMEKwks2bcLglAeJ03XeAEO16UZUQnMb8
 M6i/UStZwdBppekni2Ale2xiFY683xc4iu8LoTwrtFzA6LSSmghI9w3HmjEC/WR1XI
 qu1tM7a574w8A==
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
Subject: [PATCH 2/6] freescale: fix long help handling in mac command
Date: Sat, 30 Sep 2023 14:01:43 +0200
Message-Id: <20230930120147.59482-3-heinrich.schuchardt@canonical.com>
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

CONFIG_SYS_LONGHELP=n we want to reduce the size of the U-Boot binary.
The long text should be reduced to and empty string in this case.

There is not need to call cmd_usage() directly. It is sufficient to
return CMD_RET_USAGE.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/freescale/common/sys_eeprom.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/board/freescale/common/sys_eeprom.c b/board/freescale/common/sys_eeprom.c
index d4a00fe920..9363251dc2 100644
--- a/board/freescale/common/sys_eeprom.c
+++ b/board/freescale/common/sys_eeprom.c
@@ -424,7 +424,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			prog_eeprom();
 			break;
 		default:
-			return cmd_usage(cmdtp);
+			return CMD_RET_USAGE;
 		}
 
 		return 0;
@@ -624,9 +624,8 @@ unsigned int get_cpu_board_revision(void)
 }
 #endif
 
-U_BOOT_CMD(
-	mac, 3, 1,  do_mac,
-	"display and program the system ID and MAC addresses in EEPROM",
+#ifdef CONFIG_SYS_LONGHELP
+static char booti_help_text[] =
 	"[read|save|id|num|errata|date|ports|port_number]\n"
 	"mac read\n"
 	"    - read EEPROM content into memory data structure\n"
@@ -643,5 +642,12 @@ U_BOOT_CMD(
 	"mac ports N\n"
 	"    - program the number of network ports to integer N\n"
 	"mac X string\n"
-	"    - program MAC addr for port X [X=0,1..] to colon separated string"
-);
+	"    - program MAC addr for port X [X=0,1..] to colon separated string";
+#else
+	"";
+#endif
+
+U_BOOT_CMD(
+	mac, 3, 1,  do_mac,
+	"display and program the system ID and MAC addresses in EEPROM",
+	booti_help_text);
-- 
2.40.1


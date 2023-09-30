Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F41DE77372
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 12:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E6686FBC;
	Sat, 30 Sep 2023 14:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nk/X1tUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3587D86C0B; Sat, 30 Sep 2023 14:02:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA9C86C0B
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 14:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 40533440A8; 
 Sat, 30 Sep 2023 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1696075338;
 bh=LjMCh5p7KBtXQ0H4KRUPsb1Egg9c4IshPCust/akme4=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=nk/X1tUgr8CaulNbBkpD6VN46b5VXzmAXEvCMxbv6rpalpLNmTZ5gBifR7p9/bNhN
 qCnKHf+aM1yIMDybrGALh7oIbCZlWvuOIfEkpt50XWuFinhpomcAuP6i4C3Pgg4OC6
 lAn4UhGFKsKWU1uBOdyKzYaQ2qRo0kC0y9iYPoyLbGeg4kygRVji79nibYIeAhp0bP
 tHcLnhhdbApiTKLXNpn3vOBQOkaitgHwG1S1sw5DKF7pJMbNW6oJ+av1MtsjZ+d6hs
 fXHtbEHg6naSKuhYCSH12IoLgik5njLSn8EBRrj7XhhGGmCHB5M3AnqUhMoSEuptEb
 fAxDrjDC4vaEw==
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
Subject: [PATCH 3/6] eeprom: SiFive Unmatched: re-implement mac command
Date: Sat, 30 Sep 2023 14:01:44 +0200
Message-Id: <20230930120147.59482-4-heinrich.schuchardt@canonical.com>
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

The different implementations of the mac command have board or vendor
specific sub-commands.

Add the command definition specific to the SiFive HiFive Unmatched board.

Don't call cmd_usage() directly but return CMD_RET_USAGE instead.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../unmatched/hifive-platform-i2c-eeprom.c    | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
index 2b985b9b22..3c7ba4e0d3 100644
--- a/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
+++ b/board/sifive/unmatched/hifive-platform-i2c-eeprom.c
@@ -426,7 +426,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (argc > 3)
-		return cmd_usage(cmdtp);
+		return CMD_RET_USAGE;
 
 	cmd = argv[1];
 
@@ -443,7 +443,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (argc != 3)
-		return cmd_usage(cmdtp);
+		return CMD_RET_USAGE;
 
 	if (!is_match_magic()) {
 		printf("Please read the EEPROM ('read_eeprom') and/or initialize the EEPROM ('initialize') first.\n");
@@ -470,7 +470,7 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return 0;
 	}
 
-	return cmd_usage(cmdtp);
+	return CMD_RET_USAGE;
 }
 
 /**
@@ -551,3 +551,27 @@ u8 get_pcb_revision_from_eeprom(void)
 
 	return be.pcb_revision;
 }
+
+#ifndef CONFIG_SPL_BUILD
+
+#ifdef CONFIG_SYS_LONGHELP
+static char booti_help_text[] =
+	"- displays memory copy of EEPROM\n"
+	"mac read_eeprom - reads EEPROM into memory\n"
+	"mac initialize - initializes memory copy with magic number\n"
+	"mac write_eeprom -  writes the EEPROM from memory\n"
+	"mac manuf_test_status [unknown|pass|fail] - sets test status in memory\n"
+	"mac_address <addr> - sets MAC address in memory\n"
+	"mac pcb_revision <rev> - sets PCB revision in memory\n"
+	"mac bom_variant <var> - sets BOM variant in memory\n"
+	"mac bom_revision <rev> - sets BOM revision in memory\n";
+#else
+	"";
+#endif
+
+U_BOOT_CMD(
+	mac, 3, 1,  do_mac,
+	"display and program the board revision and MAC address in EEPROM",
+	booti_help_text);
+
+#endif /* CONFIG_SPL_BUILD */
-- 
2.40.1


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DABC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F10D40855;
	Mon, 17 Aug 2026 15:38:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UlRQcydxcG0s; Mon, 17 Aug 2026 15:38:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CE98406BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981095;
	bh=am0ogsMBTmMmlTzCKCoRRH4H/lVOjrxlUkhgPuUIEwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qp9iA6e6aPuEnRcTjK30j7DMr1J6YPeQqKYAD8xpzVQWxSqXDelMT9JAmesoNcXq9
	 9Hanub/se4oTYyEZBRVWR+VsG7UGm1ZabR8Ac1vpjuT9Ii+u1mdTLvHnIdcEB9nSbN
	 /eODzofSq35aLEU55O73/Ha1SBzOukg3XVWqxFtiXTa+2jW/NvTBwwAVTOWResaIJx
	 8XwbfhOLoIoMQDDr4G4p4VCZP+2FoQNyTKQRBWVcSXSYAfPc/e5azlYjIjWKHvog3v
	 6UF7PdZmy/3KXklkvcoPOm5INf/B95eWpMz/rNL2L/AGShZknV2xuK6bgUaIlCD0fr
	 Gx8gXuaWG6C6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CE98406BF;
	Mon, 17 Aug 2026 15:38:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A04D2B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B7E880F8C
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWovlj9PJTgU for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:38:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 710E680F6B
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 710E680F6B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=IUEeeqrh
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 710E680F6B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id BC183B0053E;
 Mon, 17 Aug 2026 17:38:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981090;
 bh=ghlL86nWjgx9mzaSd6g8GFcNSyzhpo+e2kbDNtjU4rg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IUEeeqrhskVDdjVN31JftU0cSrf16FHc2UKa/mbUB3gIPOk8SPiyYUkqOZyOyjsfH
 Js13+YrlnitmF6L/uYxNCelUdW9rYYf4fwXVAtbHzc0MIGTkJE32iVZdw58UGNzHaI
 favkEPUthuE7sc0P8Q5yJW1Y8BpfaSBnIU/xzoWIMiZmCPAYIACAg4yBZEeIUtV+eJ
 Bzeii0pXt8Z4S+FAi64BnD2zHyZko4jfE/LHLoRT1s5AU4o0RQx6YcTuhyU6bwci7s
 XmLL4S86fKCgusn97jngXtajXcL1FdASgocTrZAfRuTnLQ5QR9pvzBwJpzVLH/1eAH
 zb9Uc6NU5MVeQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 21/23] board: nbxv3: add operator commands and JTAG
 semihosting
Date: Mon, 17 Aug 2026 17:31:39 +0200
Message-ID: <20260817153144.1951036-22-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Extend the u-boot prompt with few helpers:
 - CONFIG_CMD_DM, CONFIG_CMD_CACHE, CONFIG_CMD_WDT, CONFIG_CMD_GREPENV:
   driver model tree, cache control, watchdog control, environment grep.

 - CONFIG_SEMIHOSTING with CONFIG_SEMIHOSTING_FALLBACK: a module with a
   blank NOR is provisioned over JTAG (`load hostfs - <addr> <file>`
   from the debugger host, used by the provision_openocd_fit macro of
   the boot environment).

 - CONFIG_LAST_STAGE_INIT: the board hooks run on EVT_LAST_STAGE_INIT
   (already dispatched since DM_EVENT selects EVENT); make the intent
   explicit in the configuration.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 configs/nbxv3_tfa_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 554e0bf20ac..040353c4a03 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -28,21 +28,26 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_PBSIZE=532
+CONFIG_LAST_STAGE_INIT=y
 # CONFIG_ID_EEPROM is not set
 CONFIG_PCI_INIT_R=y
 CONFIG_RESET_PHY_R=y
 CONFIG_CMDLINE_PS_SUPPORT=y
 CONFIG_CMD_HISTORY=y
+CONFIG_CMD_GREPENV=y
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_DM=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_CACHE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
@@ -86,4 +91,5 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_MAX_CONTROLLER_COUNT=2
 CONFIG_WDT=y
 CONFIG_WDT_SBSA=y
+CONFIG_SEMIHOSTING=y
 CONFIG_ZSTD=y
-- 
2.43.0


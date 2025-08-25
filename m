Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DA2CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17A7831D5;
	Mon, 25 Aug 2025 15:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="fPYI2z3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6877683102; Mon, 25 Aug 2025 15:55:49 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719AD83145
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E3986C994E; Mon, 25 Aug 2025 15:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1756130147; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=YPDnzbY0nfNmJFqNTf2PNSYXZw4TaKmPfQzWqG9QOm4=;
 b=fPYI2z3/bPOJiMRCE2U2VvnFh0svBu3t2GHpB5LIrIFH/XQvA8U5X8MsSkn8UYTDQrrf72
 bdEBUvJR35vWxISujXX+74bzNksKCDZ16QUDSkDxVKcqG7JnB9fDhF7Qj5xN2Hm+BpjVtp
 ecuNRmjFTy7cMnYsDtnVxuy4xNh5EbNiaJH/YzE4j3IKat97/1e5zmzWyewpMqZ1/5iTTU
 8Mr4jKq0viXFIKWlZXhmv5QLYo55z4JiSg954oIo6djVEp+ogLBfkIy1RwprhFhmDaPCZ3
 lKUiyDDDgipVIMSQrbg2z02UrZpQFjGiR9u+rwhgYSwu7leUgDZXJqjJ/I3Yig==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>, Marek Vasut <marex@denx.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 08/11] imx: kontron-sl-mx6ul: Enable watchdog and sysreset
Date: Mon, 25 Aug 2025 15:54:32 +0200
Message-ID: <20250825135504.193004-9-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825135504.193004-1-frieder@fris.de>
References: <20250825135504.193004-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Enable the watchdog and sysreset drivers and the wdt command.
This also fixes the non-working 'reset' command.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index a5ee4d67c00..fed29e77936 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_SYSBOOT=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -107,6 +108,9 @@ CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
 # CONFIG_FSL_QSPI_AHB_FULL_MAP is not set
 CONFIG_MXC_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_SYSRESET_WATCHDOG_AUTO=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
@@ -119,3 +123,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SDP_LOADADDR=0x8f7fffc0
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.50.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96DFCD8C8F
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 15:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E628A83E76;
	Thu, 13 Nov 2025 16:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d3V0P0zN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rQhv+fpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6384B83EC6; Thu, 13 Nov 2025 16:19:06 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E0683E3A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 16:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d6kSl4hX9z9tRB;
 Thu, 13 Nov 2025 16:19:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763047143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4adypZAzUNyMxY59m+U9ynslrNuZ1xt4oKmBqnh5g0=;
 b=d3V0P0zNnEk8Qbs2dd/yv3dyDa/OJ/rgyfzadiRjEb589nSkoRRhWbCHz9qlOdaQavtcIH
 3U/aEaRd67MuUKlbSTOJqNMiqcmRSJAqtqNESzq2FPZKpQY4MvoeD+90MGeGwlVxr86pzL
 n5ZqF5V1pCefoaSPfXyuLtepnJ69nUztQfmIjNbovMN4USSTPOZw3imz6/u6gGRItVg4lP
 9s4E7cZ3Cztzr5BYpmRx37zhLtE58gw0uceHHtztzjqihyONQ+jvCaq7d1txuOANr6jIip
 X0w16oLBGNnP05pxIjW+Zma2/K3G3LG23C6mZTvYaeG/G0Sf2taoAf+skO/ySw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=rQhv+fpJ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763047141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4adypZAzUNyMxY59m+U9ynslrNuZ1xt4oKmBqnh5g0=;
 b=rQhv+fpJ/MWzeX6c+1px4b1M5L2QUy1mIWsZNCanfQbLacc/zZ3WUBuzYwzj723mpNhqbU
 MFEpi/+KbkLAHnV9hPWRB9tDAYx+VVXnwSflsv+Qk4aVC/w4UMOkJ4GU/u2bIiVp2PUDRW
 7MvdChQx322gFtizpEr10SLh6Pb3o8cV7sFavyxrdubqffEgVCZ7CU5PmhPKgneAthaplP
 rgQGRqiaydmom9lAcTAKzsHFRCoqTpXAcxPbs7Osq1FVH2MCvaugjxnJCzDMBuBC+BEWo6
 LqGigBA2A/eMHouAQbSTayh8smQeTAhKwfcERWGDM7HJCUy4FVnC7JenppqBAA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dragan Simic <dsimic@manjaro.org>, Soeren Moch <smoch@web.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: tbs2910: Disable EFI partition, MP, sysboot,
 bind commands
Date: Thu, 13 Nov 2025 16:18:39 +0100
Message-ID: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ir41bkgp4twzbud7uyngxnrhh93hkju7
X-MBO-RS-ID: 34df19e5ee65d97f57f
X-Rspamd-Queue-Id: 4d6kSl4hX9z9tRB
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

This board is just short of overflowing the size limit, disable
support for EFI partition since EFI support is already disabled,
and disable a couple of commands which are also likely unused to
keep the board below limit.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Dragan Simic <dsimic@manjaro.org>
Cc: Soeren Moch <smoch@web.de>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/tbs2910_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index 070dce234d6..ef7d5ca3e2c 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -38,6 +38,8 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_FDT is not set
 CONFIG_CMD_MEMTEST=y
+# CONFIG_CMD_BIND is not set
+CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADB is not set
@@ -53,14 +55,13 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
-CONFIG_CMD_SYSBOOT=y
+# CONFIG_CMD_MP is not set
 # CONFIG_CMD_VIDCONSOLE is not set
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
-CONFIG_EFI_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
-- 
2.51.0


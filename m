Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16172606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H9Bfym9p;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=YAigap4E
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7EB860751;
	Mon, 23 Nov 2026 14:04:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKNE6f52MxAK; Mon, 23 Nov 2026 14:04:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3925B605F4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795442685;
	b=EHmP8t7csZudy/8RKd1AjXjODgZr2V1EczvlTT8lSIeRWrUGIl5cKamyFl99T3phNk4j
	 tBSVUM5dHoIW1/mYCwuV3lVvRX9gNHb6WK2kBqL7PFWxXJOkSnano1baYqXzTGomqp0KC
	 VRXkxT5RIqJAQsLDHa8IZyrgqrj4ct1Qj26RF/g1eNUJOpO4VK47JU19Ra+G086I3CQ47
	 OmXDqsGCFIRkkZO+EshRfxxYHqUK4WWeqVbcZuqJVDvxzJbQmDx9bB9/DSrlFshOVmr9O
	 U084+l00gUkZTDK+Cxb62XA7QwHvgvXxLNbSuixJ/DoPjIIioklyovovlY0CRJzcQ1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795442685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7S4zuaUc7iRbzlcjQ2JakfJiG7CTWRvRntUBsBXRluo=;
	b=spGQRzZb2+bxQgUMd7KR2zQ8k2N38SvWhXuTSdD4mHgfec2VyhvXYoAG7JhnHLiWyhSU
	 jalcPXmziddos1o2tKFJisdF3Fl4jo7xqxu3I6yS74oZu9AwLd7/twxCtsKBkQscCpxvj
	 47mQ1sRmJ9Fxu23EWWxHHp5Yks3qPzlk9bkvnk1AZ2jZDpehlOfz1KA9qZOZSXL5wMQNB
	 pOT4Qi+o+XMuuw7IYyZPZ2xA3RbfHnYyWLJZWwUa73SlW1MtHAnCfGOqakVcTX2rVmS7G
	 Y3gQR9m6rHf1XaKAlZ2jzFTgg3rMXkU7Uat06AOkB9ZqMfRu8H9rhwzQGoZOSDMwRNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=norik.com;
	dkim=pass header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=YAigap4E;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795442685;
	bh=7S4zuaUc7iRbzlcjQ2JakfJiG7CTWRvRntUBsBXRluo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H9Bfym9pPZle9M6r4HQWcwwUVisli88MXw2cZxIO0cGPrXXhrp0IOrBIN9VLkW7kN
	 Rc8d17spJvZjlIbuXJRzsMu/nrNWzKgjnvO9aptMUl5aiOiFZc4qvBmae0QYdpsL+W
	 CjyGlHqyQNmQSTzG92gk1DHkEZgVziVpfMj9RQsEEwLhejbfDIp1EJFET+8I7qDKdU
	 jfxevpF/+LUM5l+9Q0Cc9C16DdoTR8nMiyraVxK2I4FLQbgGWM2gxdrn+6AkknGUc2
	 ge0MThY49NfH8YG923UvC8whN0nkptQ6lc5riKV77kGgXWwenm9y21kguTEKpKsZW+
	 pxsl0O5VzFZ4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3925B605F4;
	Mon, 23 Nov 2026 14:04:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF71579D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 959FD605F4
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9E4aNiqgfojV for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:04:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B930605E5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=46.19.12.180
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.19.12.180;
 helo=cp2.siel.si; envelope-from=primoz.fiser@norik.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256
 header.s=default header.b=YAigap4E
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B930605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7S4zuaUc7iRbzlcjQ2JakfJiG7CTWRvRntUBsBXRluo=; b=YAigap4ENLNJ82JY00/qrtk4Dh
 +CIpZAM+E/Blhe5UzyQpnAZ2niuSOlEX+UW3I28r1ix62CU+5tBs7ztpZlq4MmCYliTVQ2a5Qqju4
 8q7HOWxeQmkgezBFZL4q8+dHdmpky//EGYylfzp1tyfbCsW41UZfHLMTsZnB8tMncdmWOv1bXQmi2
 s9seRzcc0jy0tWgNEgLXtJxRlNQYtZE3Be9+yJaK81fTuFXMqDMZIMQ6C+B6Jv4pt1zgtcffcuH3d
 ovp3qsSjle7gUazrNCljzR9TeWBwM9bTJWvARaRT0cSdp/3jz3j4RYQwSbVy+cIswBoe8t//wrXyG
 skd8DeiA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:59646
 helo=z840.taila37813.ts.net)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <primoz.fiser@norik.com>)
 id 1xVUet-0000000H57M-0yRv; Mon, 23 Nov 2026 15:04:37 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: upstream@lists.phytec.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH 1/3] configs: phycore-imx8mm,
 tauri-l: Enable overlay and overlays.txt support
Date: Mon, 23 Nov 2026 15:04:35 +0100
Message-Id: <20261123140437.1526666-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123140437.1526666-1-primoz.fiser@norik.com>
References: <20261123140437.1526666-1-primoz.fiser@norik.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CONFIG_OF_LIBFDT_OVERLAY so that bootm can apply devicetree
overlays from FIT configurations, and enable CONFIG_CMD_IMPORTENV and
CONFIG_CMD_EXPORTENV so the boot script can import fit_overlay_conf
from overlays.txt on the boot partition.

Do this for both phyCORE-i.MX8MM based defconfigs, phyBOARD-Polis and
phyGATE-Tauri-L, similar to commit 0ff9141fb88e ("phycore-imx8mp: Add
overlay and bootenv.txt support").

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 configs/imx8mm-phygate-tauri-l_defconfig | 3 +--
 configs/phycore-imx8mm_defconfig         | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index cacfe5b35b3f..e4674eabdce6 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -10,6 +10,7 @@ CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phygate-tauri-l"
 CONFIG_TARGET_PHYCORE_IMX8MM=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -43,8 +44,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
 CONFIG_CMD_ERASEENV=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 7d4f6005dbaa..a9858f5e2291 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -12,6 +12,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mm-phyboard-polis-rdk"
 CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
 CONFIG_TARGET_PHYCORE_IMX8MM=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
@@ -50,8 +51,6 @@ CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_FLASH_MTD=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
 CONFIG_CMD_ERASEENV=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
-- 
2.34.1


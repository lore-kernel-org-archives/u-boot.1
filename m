Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AF4D66B85
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DB883B49;
	Wed, 17 Dec 2025 21:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SMJmhOt/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FguN+WEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A490583BC9; Wed, 17 Dec 2025 21:03:19 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9662183B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dWl910rkCz9v7P;
 Wed, 17 Dec 2025 21:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766001797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aSes1mwNUvNesbp4L9/QiecNxOJWJDuAkeUCuFU2do0=;
 b=SMJmhOt//64z8a12KhYGrXrCmB6Bx/ZAvgrjuIBmgv3putyIbGBBd4q1i64NO4P+Ekpk9R
 VT0+nGbinBj65KAci4zXBxOdqAFGKixx9SidA81k2DKitU5P9XE2uEtyKtuTr+T+m0hQER
 C/6ZIvcbOyFOO9ewTYg3Q2V5KYEUvlfo5ILhPPc1UeA/bi9lXaYAQtvJx5QApV8E00wx2F
 vDyfaseRm+mKjwKIlk/khOe+HGEZLUp/++Z1ctSVUu3L4m33okaPXqcKXt5/Ic+o8/DjSn
 nTxzIjiuGAI0OvZ466y6tV9m8trs2CHaL/gqmQEndFYGeUtnOx9blDEHQ7fVMw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FguN+WEg;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766001795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aSes1mwNUvNesbp4L9/QiecNxOJWJDuAkeUCuFU2do0=;
 b=FguN+WEgZ+oGBdnUWBmCMzTqWXgUjLeO2iDrBN2wiX8ty4VjDzF06rHqihSTLje7SXD6vd
 w3N3jM5TC8sSC4ebxolCbuUJq0TFCv8K/E9fsxjtZoSddxXCVxWq4BW+9iPIjOVJx0a98E
 rw15JLgd/vIhxYUHI6cLiCF5Kh5KHR7Savbg+lslaiT/ketOt8/4G1B0WK6S5K/A6/N+Uv
 Dz4EHGqj+oemr2X44Uh67O1U7P4lw/AX+n56h9zCYlO18eyFI42DY607RrH938mgSi3Cbe
 lF9aKUZemKt4N1qy0N4ZYiW1GoPewoyeJgbzwupqlG+ZdRuzl7UOV+6vZqLXYw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: sandbox: Select environment in FAT FS support
Date: Wed, 17 Dec 2025 21:02:50 +0100
Message-ID: <20251217200313.755200-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 6b6d8d25ade3a22c3e3
X-MBO-RS-META: rmfn8nmwca4gaeyrmwb7mmq53isqncig
X-Rspamd-Queue-Id: 4dWl910rkCz9v7P
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

Commit 2a38e712652f ("sandbox: add FAT to the list of usable env drivers")
made environment storage in FAT available on sandbox, but did not enable
the matching ENV_IS_IN_FAT in sandbox configs. This leads to environment
driver lookup failure when env in non-EXT4 is selected using 'env select':

"
env_driver_lookup: No environment driver for location 3
priority not found
"

Enable the missing ENV_IS_IN_FAT to fix this.

Fixes: 2a38e712652f ("sandbox: add FAT to the list of usable env drivers")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/sandbox64_defconfig        | 1 +
 configs/sandbox_defconfig          | 1 +
 configs/sandbox_flattree_defconfig | 1 +
 configs/sandbox_noinst_defconfig   | 1 +
 configs/sandbox_spl_defconfig      | 1 +
 configs/sandbox_vpl_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index d3fe64c5a83..70c757640c0 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -105,6 +105,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 2055321025e..dfdaaff1eff 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -153,6 +153,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_ENV_IMPORT_FDT=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index ed70075b135..8818d733aed 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -82,6 +82,7 @@ CONFIG_AMIGA_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 2d1476a88a3..7030484a3f1 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -121,6 +121,7 @@ CONFIG_SPL_OF_PLATDATA=y
 CONFIG_SPL_OF_REAL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index f4bfba0d2d1..03781b3c3d1 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -99,6 +99,7 @@ CONFIG_SPL_OF_PLATDATA=y
 CONFIG_SPL_OF_PLATDATA_INST=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_BOOTP_SEND_HOSTNAME=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 1b6b02e3c0e..0e03879e960 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -115,6 +115,7 @@ CONFIG_TPL_OF_PLATDATA=y
 CONFIG_TPL_OF_PLATDATA_INST=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
+CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_EXT4_INTERFACE="host"
 CONFIG_ENV_EXT4_DEVICE_AND_PART="0:0"
 CONFIG_BOOTP_SEND_HOSTNAME=y
-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E30C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D4E987527;
	Wed,  8 Nov 2023 16:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="Eq1cz82M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D876871C7; Wed,  8 Nov 2023 15:53:36 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 542AA874BD
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2023110814532706f03752d475882149 for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=/6R0ijDIIJ+FN9esn4gqWVRLd55E+6cqqQjRvNJjGqE=;
 b=Eq1cz82MK+z3nnA5sAQWdd/Bi9BtFd6eRYZSAjj6C6jb1eQbnVj9tFnYpougzMtj9tt9GR
 T/ekF7N22o0ZAasVfaqzYV7P1vv0x1DrTCKEcQYX9BL7MsTVBVxh0uRCtyZsvlxSMTj5mNgk
 +pCcq+WJYKh4AoGUEpQd0L42jcKxg=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 6/6] configs: draco: restore clock driver
Date: Wed,  8 Nov 2023 15:53:22 +0100
Message-Id: <20231108145322.302927-7-enrico.leto@siemens.com>
In-Reply-To: <20231108145322.302927-1-enrico.leto@siemens.com>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 08 Nov 2023 16:10:16 +0100
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

Fix 'failed to get fck clock' error on boot. Add missing configs.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 configs/draco-etamin_defconfig   | 2 ++
 configs/draco-rastaban_defconfig | 2 ++
 configs/draco-thuban_defconfig   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 8180bb004cc..eade2297229 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -82,6 +82,8 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK=y
+CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_I2C_LEGACY=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 539ead3d862..252cbe3d78e 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -80,6 +80,8 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK=y
+CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_I2C_LEGACY=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index f919754c2e4..d8b80b83f10 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -80,6 +80,8 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK=y
+CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_I2C_LEGACY=y
-- 
2.30.2


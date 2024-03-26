Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06803C54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 14:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFAD87F2A;
	Tue, 26 Mar 2024 15:26:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CFwnXUbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20BB87F39; Tue, 26 Mar 2024 15:26:55 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C847C87F04
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 15:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1711463213;
 bh=UAXJ2xQw1DGAKppFWfeCwR5gXChUy/0+nz94afnK7TI=;
 h=From:To:Cc:Subject:Date:From;
 b=CFwnXUbqOrauYwEL/u+bRr+ykiLCxk6uOWB1N1rtozz9V9dgGwzWiXSvxNCF9GsFW
 YGfKRnVvi2meg0g23Ow9Z0f3j49jg3sTzOfeMk+54c7+pMVyfXAhpmyHeSJIMsMcGc
 GGKAUqGOaWgXnj2d72qZCUIv13CoRicowtKoupz2GdI+QiBqx/dE4TFyZZq4j3rDKw
 2Yv+ncXqf/qEWowskPreuZz9G62n4z0MOy4YPQxpZLTKbA/qYMOmnk+2jpxYeEX++w
 nWUJ8xg3125sUVo26auBtb4nlGgHnp6WWKs4BkXg/CeSti5x4avdMch8zAdE+m1r62
 tt+o9Dq7e9/7w==
Received: from pan.home (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com
 [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id E98FB37804B2;
 Tue, 26 Mar 2024 14:26:52 +0000 (UTC)
From: Martyn Welch <martyn.welch@collabora.com>
To: Dave Gerlach <d-gerlach@ti.com>,
	Tom Rini <trini@konsulko.com>
Cc: Martyn Welch <martyn.welch@collabora.com>,
	u-boot@lists.denx.de
Subject: [PATCH] am625x_evm_a53: Tweak boot command to set fdt
Date: Tue, 26 Mar 2024 14:26:33 +0000
Message-ID: <20240326142634.2043539-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.43.0
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

With the current config for tha SK-AM62, fdtfile isn't set in the U-Boot
environment. When using bootflow to boot from a block device, where the
extlinux.conf file specifies `fdtdir`, a fallback device tree is being
constructed from the `soc` (`k3`) and `board` (`am62x`) environment
variables, resulting in u-Boot trying to retrieve
`/dtbs/6.8.1+/k3-am62x.dtb`. This file doesn't exist.

The environment variables `default_device_tree` and
`default_device_tree_arch` are set in the config, the `findfdt` script
can be called to construct `fdtfile` from the environment variables set
by these config options, however this script currently isn't being run.

Calling this script results in the correct device tree being retrieved:

   Retrieving file: /dtbs/6.8.1+/ti/k3-am625-sk.dtb

Many boards are calling this script as part of their boot command. The
am62x currently isn't. Rectify this so that booting works correctly.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 configs/am62x_evm_a53_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 78287ec18a..e373e44a93 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -30,7 +30,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_BOOTM_LEN=0x800000
-CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
+CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-- 
2.43.0


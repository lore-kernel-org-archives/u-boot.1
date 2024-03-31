Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8578CD1288
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 02:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F7987F1F;
	Sun, 31 Mar 2024 04:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jbPiajLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E3FC87F4E; Sun, 31 Mar 2024 04:37:22 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD9087ECC
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 04:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DC2B43F2AE; 
 Sun, 31 Mar 2024 02:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711852640;
 bh=XBZE1cmykqY7L1Gbt4QVat+tFJeSlrbU1y/FACB3PaA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jbPiajLn6a8uW38TZpdnKirZHx10XieB/9riPQRGRA4rI7qc4YOD+TmAtVkj5qB6n
 U98OaGP/0e9CfYVDGKkmY+8Js6QDFoiRzJx3Nomv55F3IkaQj6SHmfLM5yzwRfdv5z
 knGgBQfnHGdy3nI6aTy7rTAjjT8hMVCVHLqfUs50Fo8mHCPlfscTTk3C92+apWR4kP
 T3veG7HkN47w6AKjvxzURcpOpG2FizidrIrc2ytv+/5AsoMXJZuBSx/QHKPUKQKYgF
 PateOZr+QFLjj9qh/csbmFNgMApvQwzfLP3r4ItRLFqF5UDxiiKTYo6gvq4J9yHCuC
 yV34tqZZZiJNQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] sunxi: CONFIG_SYS_MMC_ENV_DEV undeclared
Date: Sun, 31 Mar 2024 04:37:15 +0200
Message-ID: <20240331023718.52064-1-heinrich.schuchardt@canonical.com>
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

When enabling CONFIG_ENV_IS_IN_EXT4 the environment might be stored on
an mmc device similar to the CONFIG_ENV_IS_IN_FAT case. Enable
CONFIG_SYS_MMC_ENV_DEV in this case.

bananapi_m64_defconfig with CONFIG_ENV_IS_NOWHERE results in:

    board/sunxi/board.c: In function 'mmc_get_env_dev':
    board/sunxi/board.c:535:24: error:
    'CONFIG_SYS_MMC_ENV_DEV' undeclared (first use in this function)
      535 |                 return CONFIG_SYS_MMC_ENV_DEV;
          |                        ^~~~~~~~~~~~~~~~~~~~~~

Check if CONFIG_SYS_MMC_ENV_DEV is defined.

Heinrich Schuchardt (2):
  env: ENV_IS_IN_EXT4 should enable SYS_MMC_ENV_DEV
  sunxi: CONFIG_SYS_MMC_ENV_DEV undeclared

 board/sunxi/board.c | 2 +-
 env/Kconfig         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.43.0


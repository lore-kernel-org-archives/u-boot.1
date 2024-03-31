Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3987C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 02:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 817BF882A1;
	Sun, 31 Mar 2024 04:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EwVrBOjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5699287FA0; Sun, 31 Mar 2024 04:37:24 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29EC87F41
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 04:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CB47941DB4; 
 Sun, 31 Mar 2024 02:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711852641;
 bh=MbYY7Pafw0jS1V1XBs3UwCyHl/aN66/0vkEYVzy+FmY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=EwVrBOjU70I9bo/Y+TVBl3zEZq2QWiQaudQA6KD91wFBKEGGlU/Ex7q/gtkTp7jwR
 QzqEHXXoWn/BH/nhZSOaDgk85JFN1gBiGHPhOvSf3NFBi7//zFDAa7JCvXEASCgWap
 05k4/9qTsiXr2MEEX09gwQA4ac717qWMdyBcOMtrx7s7MI8W1jQ8jtjAWt3nfs5nbn
 B2W3Md169Bb8Z0msCOGiazVMQDXyOMngwXFZg7IoAqLnOkULWNfVeUjfU6D1dVJqOJ
 U0luB53hXuO3xnv29SjWilq7XbRzvYbg8UlZRfCdTkNW6FAv56VQSwgMJp1KuwfSLM
 FuJEVM7Nhjo+w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>,
 Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] sunxi: CONFIG_SYS_MMC_ENV_DEV undeclared
Date: Sun, 31 Mar 2024 04:37:17 +0200
Message-ID: <20240331023718.52064-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240331023718.52064-1-heinrich.schuchardt@canonical.com>
References: <20240331023718.52064-1-heinrich.schuchardt@canonical.com>
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

bananapi_m64_defconfig with CONFIG_ENV_IS_NOWHERE results in:

    board/sunxi/board.c: In function 'mmc_get_env_dev':
    board/sunxi/board.c:535:24: error:
    'CONFIG_SYS_MMC_ENV_DEV' undeclared (first use in this function)
      535 |                 return CONFIG_SYS_MMC_ENV_DEV;
          |                        ^~~~~~~~~~~~~~~~~~~~~~

Check if CONFIG_SYS_MMC_ENV_DEV is defined.

Fixes: 1011ebc72bda ("sunxi: Select environment MMC based on boot device")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/sunxi/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 8c12c8deade..c849bbe8267 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -523,7 +523,7 @@ int board_mmc_init(struct bd_info *bis)
 	return 0;
 }
 
-#if CONFIG_MMC_SUNXI_SLOT_EXTRA != -1
+#ifdef CONFIG_SYS_MMC_ENV_DEV
 int mmc_get_env_dev(void)
 {
 	switch (sunxi_get_boot_device()) {
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A17BE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4456080245;
	Fri, 13 Dec 2024 11:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n3IzRh6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38E58022B; Fri, 13 Dec 2024 11:23:40 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE977800DF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BD9D5A42A31;
 Fri, 13 Dec 2024 10:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65210C4CED7;
 Fri, 13 Dec 2024 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734085417;
 bh=vgU9NzIheGFg2OZkw8n7pTPh3MkzAg/V+NZzgWgfqAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n3IzRh6FndsyiKaiW+0QJACefkxWJl34qHLAILN9S84x9kLCLtBSs57eUYdsgEMGe
 eJWtKyCCTda/FR8ywWCxBA1iDxOuh0iZ65h17Pjr/MC9xIQgC98h5Q/Ptme9xBZKlm
 2oGtyNt9VqHBAqzDuQ5zNZozbRn4PiP5WOFkdjiyQ5ufWWjxRLlX1GfZGh6BHwwV4H
 LUehltrw6owMZg2s1DBDDsILylMpfGCjDSAEkaNatubrnQI5ldOqbsDQkcmdJR3psY
 UsTLA8GY3cILs9rJnQKVbkhUSjp+MGdWMKjb2RUOaFougKR/hfzwn1KT8N7lTntxJd
 JECZMWj7WAPvg==
From: Michael Walle <mwalle@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, heiko.thiery@gmail.com, thomas.schaefer@kontron.com,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/5] board: sl28: increase SPL_SYS_MALLOC_SIZE
Date: Fri, 13 Dec 2024 11:23:18 +0100
Message-Id: <20241213102321.2166920-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213102321.2166920-1-mwalle@kernel.org>
References: <20241213102321.2166920-1-mwalle@kernel.org>
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

Increase the malloc size to 2MiB because our FIT image exceeds the 1MiB
limit either if BL31 mode is enabled or if another device tree is added
to the image.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 configs/kontron_sl28_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index 35894a10cbe..eae06b546da 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -54,6 +54,7 @@ CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x900
 CONFIG_SPL_MPC8XXX_INIT_DDR=y
-- 
2.39.5


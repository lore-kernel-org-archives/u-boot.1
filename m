Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AAAC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D00BE88423;
	Tue, 18 Jun 2024 17:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aRyazklG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21896882D4; Tue, 18 Jun 2024 17:34:56 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B4BB88354
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 64ECCCE1A46;
 Tue, 18 Jun 2024 15:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA139C4AF1D;
 Tue, 18 Jun 2024 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724891;
 bh=6aksVOZlMysEOi1SakAthvb7yb7+cSiEqKe21FMLcKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aRyazklGp66tvBV5bbPO9IPrTmUpLk7OW1IKUpMbxCwqbweqcv3ZVAk22QE+/SIiM
 nOxjkydRp/bY5Y3ylJecZMZRxSeMhF05l0DG/y4mjKFtTxSnt7oXxqAJ0cciSgC9hg
 uD8qXDbNSVYCJefimERzEhm9aYb58yhGBX+8SI5V3rOakMzOiAZMwS7hstqNFeNi0p
 n1zqGhKA8eKnn4xuH2ugnxCz1zzvlgwOucUVZ04MwKFOK/4oqdTQNvMixR9K/FIGyB
 nNXeJoQh0yah0nsaozO9DDE6FUrCAOw9EIA7qS8sNrU9eE+f4cLwjQJ5hDYZ+2x9cT
 cbMYPLaXKUzNA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 06/16] arm: mvebu: turris_omnia: Enable
 immutable debug settings in DDR3 training by default
Date: Tue, 18 Jun 2024 17:34:29 +0200
Message-ID: <20240618153439.9518-7-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Save 10 KiB in Turris Omnia's SPL binary by enabling immutable debug
settings for DDR3 training code.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index d5699782d7..938ad88ae5 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -10,6 +10,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xff0000
 CONFIG_TARGET_TURRIS_OMNIA=y
+CONFIG_DDR_IMMUTABLE_DEBUG_SETTINGS=y
 CONFIG_DDR_RESET_ON_TRAINING_FAILURE=y
 CONFIG_MVEBU_EFUSE_VHV_GPIO="mcu_56"
 CONFIG_MVEBU_EFUSE_VHV_GPIO_ACTIVE_LOW=y
-- 
2.44.2


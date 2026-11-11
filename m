Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B299606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YL2DUCTk;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=jlNGuaj3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14B278127C;
	Wed, 11 Nov 2026 14:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeaXI-PS1m1b; Wed, 11 Nov 2026 14:21:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64F188143D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794406903;
	b=j6O/Nrp6FP0SwK+WTVWNN8WDBy9ZBpW4ipHsM+vxGnj6UrXx7U7W245O8a08ODy7FaHR
	 SUr9CSZSsRDyGOiUVBXIXbEBXg7we/TogDxEIf+Xb7p3XO1rYn0FgPWPNipG3UGsHx28Y
	 Oj0kNcLBqwJ1VeqLx77kFJNANy1eCX6omuLmAVnfRb4C1xj2bCEGSvtes8a5sgIF5A1IZ
	 GqHM+cbkH1a+iUi1GO9q2AhAA62LE6m8SfgOzq8S0t6f/Xb04lZ+2DFjYbzTqurJwtl8T
	 /H5iZcywo8glPs5AiHfF9zEl/x/4R3m5ezQPxhaq4A0Th49JZsB+8ZrN/ciom8s2mmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794406903;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ol6MkOcY4xwdkOAWNTyVKBALFQaZJzc/xexZIgfxv78=;
	b=XSvwEpwK4KqqrSj9lzGvq+L3v2BhhRJfX3hTmkplPQPPYCS6SAcr0YArt17bT3LvgT2s
	 DxUT2IR77z1a3b0ENnfWFZSc++8arvvCsNnRFA66RtSSF/8hjmOucON3tRLXcF0oOdkZm
	 +ic+dCf13jrXfYlvjvvOPWT7DiF2LV3RDmZas86oJujdnnoJwywdeGBkYbTvcs1VQyZ4I
	 enNwz7TqcKuBsO8nZ9lcrqVvO1Y/WC0Z4pjwjWU6iy06o6k0z2X0UKRcaXroe//dl5lJB
	 sIT8XLVwVEDV3Ln1ZC5xSzT8LzdtunvGSq4oqKsqZqNqFQewUxswvt/FJeh/ngqx5xg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794406903;
	bh=ol6MkOcY4xwdkOAWNTyVKBALFQaZJzc/xexZIgfxv78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YL2DUCTkwI/JVe0r3g3I9xy8dak3UisElvtFYLuAixC/RwWRYRX8pUO2Fob9u908W
	 yX2h6eURtUHsvZ0zcYKWXimjINqShBgMUKcAfVvyj4DBYHVi7i5EmiSXKe+iamKzpQ
	 dU9X8KIPQGuoP65VQeawcA77XNBWkkT6mVdc7zgFQjjx/+5iGyDbwgRW1mVQdYBYNi
	 adONp10ti3HGDPHfveptvdtrkMchY2H0L1Azsj2fuy/FVT2+hCBkm79wb5ynboS92O
	 vJdHCw+4LuypvqsdhnsdZl78rLDQbF8LWWGFmEnRoJ2KZLfHXuiLIRt10Hz9tchJKF
	 L8FWYkesQf90w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64F188143D;
	Wed, 11 Nov 2026 14:21:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 06E9A31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EBE1F408B0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RHuUUDDMcCni for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 14:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C624D40891
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=jlNGuaj3
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C624D40891
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 14:21:19 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 68F822315F;
 Wed, 11 Nov 2026 15:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794406876;
 bh=ol6MkOcY4xwdkOAWNTyVKBALFQaZJzc/xexZIgfxv78=; h=From:To:Subject;
 b=jlNGuaj31sHwBiWkubZ8PbQ5wwHpoUWBywvzmw6LcQwzKpAc3NGK5BwVNoJys3Vit
 DNde/bms2Z5Lf57EECdfaY6Db02Wuo6wnCKSxTsITNhuzUbMdZklDOc8yfERp1mH+0
 n8rVNBs8hJrcb4I2A8GnQZWKaknqfVVcNfOSNSue8w6s0NEuQbZNdzPlT5LCzwiCO1
 lqslfEbgyCYxdGUcfMyUtz/jbm0W37aODWpdp9a3tagmb5bryGlUIMi4snXev9Ooo8
 o9JqGuG2PUBUC/KWZS2MYYAqIG8pFlkh+s6NR5mp3A33Ym6jQ58UCIozZJNeBQ3Ryi
 GQFbcAnVUU4LQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 12/15] board: toradex: apalis_imx6: drop dead
 TDX_APALIS_IMX6_V1_0 Kconfig option
Date: Wed, 11 Nov 2026 15:21:00 +0100
Message-ID: <20261111142104.109139-13-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111142104.109139-1-francesco@dolcini.it>
References: <20261111142104.109139-1-francesco@dolcini.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Dolcini <francesco.dolcini@toradex.com>

All code reading CONFIG_TDX_APALIS_IMX6_V1_0 was removed when V1.0 HW
support was dropped, but the Kconfig prompt itself was left behind.
Enabling it currently has no effect at all.

Fixes: 405c97fd1dc8 ("configs: tdx: apalis_imx6: drop hw v1.0 support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis_imx6/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/board/toradex/apalis_imx6/Kconfig b/board/toradex/apalis_imx6/Kconfig
index fc4cbe3323c7..8da291e59642 100644
--- a/board/toradex/apalis_imx6/Kconfig
+++ b/board/toradex/apalis_imx6/Kconfig
@@ -39,16 +39,6 @@ config TDX_CMD_IMX_MFGR
 	  If executed on already fused modules it doesn't change any fuse setting.
 	default y
 
-config TDX_APALIS_IMX6_V1_0
-	bool "Apalis iMX6 V1.0 HW"
-	help
-	  Apalis iMX6 V1.0 HW has a different pinout for the UART.
-	  The UARTs must be used in DCE mode, RTS/CTS are swapped and
-	  thus unusable on standard carrier boards.
-	  This option configures DCE mode unconditionally. Whithout this
-	  option the config block stating V1.0 HW selects DCE mode,
-	  otherwise the UARTs are configuered in DTE mode.
-
 source "board/toradex/common/Kconfig"
 
 endif
-- 
2.47.3


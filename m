Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FA9C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C8B881AA;
	Tue, 21 May 2024 11:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716284554;
	bh=GsVRHUUiZGJy8JEjCM6fBkX/evR2uGb+cA2WwRzxn4E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YtRUXVUvvdAfRwAkxlCKAvUYEQTP8tGK+IovcyauypyK7/YHKxWHd3RRPokrnJ2Da
	 ayiBIydBoydPvjoGmi3OPmbGb7g0PQ2crJ8ajWLPC8nsXw8d5302pSkW0vwdoy6e1F
	 JWfzYeLcVfkmUx0YYttSQvgiesNOOOKSrMzCrndN32SQ8g8nAe5Zu1R01+DsUDmzPt
	 4l9VRz0q1u7MkLpV9uhaH8COkGAwh5KnRV/5deyK/jmVg8RxYm2Ua8w5csqb/aOgiU
	 Ujb6HkVzLQlHOsk0uCQ8Q8mZLm7j0vUK/jQ8+yA4r/UVSM3E+c/6bsrRfRU5aQd6s8
	 +uo58W3nfZUaQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0E5A288131;
 Tue, 21 May 2024 11:42:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716284552;
 bh=GsVRHUUiZGJy8JEjCM6fBkX/evR2uGb+cA2WwRzxn4E=;
 h=From:To:Cc:Subject:Date:From;
 b=xSzRopAuy2FzpV8rDgarcELlcmyH/yWunkhRvjz71ez+ZxNPsrvRKDaFOvHFB+C7J
 hcR+RaLwH0afXWg4xUOlciIXGvzxbZfiYX34bm9cfFr51SkgjRNWxtA0P4XcmPa26k
 qG3cYWuHDb0krw3qkspapFMPWTVwJ0wgv7ceGNaWQe6DZ0g0X6981NSVriBQFlXFFv
 uyPnDU7mAtGX73R3x7fVPEslUm/J5bVF5Ubz8Ovcthyj4ZLWHD5UnoTVKSaJXiJiHm
 VoA0RZbfzsl95uoH3IHE+BA5zmMkCCS5LVY9JSyTXtTx1Bs73moWrWW++uBLyexQ01
 hEjyTLHROzruQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: mx5: Enable BMODE command on MX53 Menlo board
Date: Tue, 21 May 2024 11:42:06 +0200
Message-ID: <20240521094216.8919-1-marex@denx.de>
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

The board can do primary/secondary boot switching, enable the bmode command.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@lists.denx.de
---
 configs/m53menlo_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index b06a614dde0..d6b47240c10 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -22,6 +22,7 @@ CONFIG_SPL=y
 CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
 CONFIG_ENV_OFFSET_REDUND=0x180000
 CONFIG_SYS_LOAD_ADDR=0x70800000
+CONFIG_CMD_BMODE=y
 CONFIG_FIT=y
 CONFIG_BOOTDELAY=-2
 CONFIG_OF_BOARD_SETUP=y
-- 
2.43.0


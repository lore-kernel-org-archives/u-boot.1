Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB224C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:27:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033A688155;
	Wed, 27 Mar 2024 17:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TsR/dl7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B03488129; Wed, 27 Mar 2024 17:24:25 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524FE880F5
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2B2426160D;
 Wed, 27 Mar 2024 16:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29C8C43390;
 Wed, 27 Mar 2024 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711556661;
 bh=j77PdZKiThGejZM8DKgctNyKXdulSrWTB8m+40ByHDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TsR/dl7RYkF31QfUiXnW1VV/HdrujEn04IoCBAqPAdzcYJIWyxyORVEXAkobkP6yU
 K/dVuBioxP6rnUuGFO7KzJdvbETp48Et0iIOiIsw7FiNfpPyg+JyIRJ+omJv7UmB2l
 sh1tfDklJM1xSuVnnME4tx5Pvn1FsVa0mJxDizofEJwnlCR8Df4mGUP8vIYfnLOOnV
 RMTCVL+r1BcVNMypN6Dff0chzK6htmd3SIsFOREw12dplyFkto4i3gU4Gi1kNZ0Mm4
 feK0SXX7J87IGsjKvS/RLzG8vKB3Sb9kHU0z8/S07dcG3da3/A/+b/qxkl/tKr6fTD
 gi9zlnfyka7/g==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v3 18/18] arm: mvebu: turris_omnia: Enable rng
 command in defconfig
Date: Wed, 27 Mar 2024 17:23:55 +0100
Message-ID: <20240327162355.24584-19-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327162355.24584-1-kabel@kernel.org>
References: <20240327162355.24584-1-kabel@kernel.org>
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

Now that Turris Omnia has a rng driver provided in the MCU driver,
enable the rng command in defconfig.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 4c21635ec9..f2b39115fe 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -73,6 +73,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
+CONFIG_CMD_RNG=y
 CONFIG_CMD_AES=y
 CONFIG_CMD_HASH=y
 CONFIG_CMD_BTRFS=y
-- 
2.43.2


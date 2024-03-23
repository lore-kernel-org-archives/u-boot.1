Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1A7C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E9D8804F;
	Sat, 23 Mar 2024 19:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OKm4jsbR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD7287D1E; Sat, 23 Mar 2024 19:07:49 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E36E87FCD
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B564CCE0934;
 Sat, 23 Mar 2024 18:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27771C433C7;
 Sat, 23 Mar 2024 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217259;
 bh=j77PdZKiThGejZM8DKgctNyKXdulSrWTB8m+40ByHDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OKm4jsbRmfNJNDrgXilQyy9ltllalfpXgJh7rIKi09sDnAxzDOfKJsqddcS5YIUfK
 DiIawrJ5i+ACRqaH/vIsdkw8DAqEtLOi3JQXl/c7tSzaJPRxr47Al9973Pwzg3pEl3
 rsxc3hdxf1R8Q+MCP3DDqsqV5pkez4P9ENdwnG6Dbq4U9EBLpW9XYSGhoW1znPH5Th
 X20ocG0UdryyHAq/AvoUoZLSlMjEYX/ZEV1AF9M8bErci1bAAHXAFrb9/pD7sbcjRE
 o30tW/rlhxKI0EL9GXkZmfGMeOt83FSmXKTKTc806RONvie2M+HtO9UhGtBCEhTJp5
 vnwkBucixGBnw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 18/18] arm: mvebu: turris_omnia: Enable rng
 command in defconfig
Date: Sat, 23 Mar 2024 19:07:11 +0100
Message-ID: <20240323180711.5498-19-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
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


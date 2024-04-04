Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2ECD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA1C88406;
	Thu,  4 Apr 2024 09:51:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N7cotPHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADBC883FC; Thu,  4 Apr 2024 09:51:37 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA5B883F6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3C123CE2FB7;
 Thu,  4 Apr 2024 07:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C648C43390;
 Thu,  4 Apr 2024 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217093;
 bh=7IUVj0OTOunbq0jGcVHZ4qhwD5SBB+xJAXuAVEsWrQw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N7cotPHjFrro2EWoANElXM5K4XZGamNB1cTHvZLR3x56h79V2anSn338fkRPO9DrQ
 2TyyCbQYe/SmNleDgAD8zJMZRX0gR4Pg3tCCkL5IPh3l7hoGpzyh6EpmKAFDPaOnhF
 wgkYWcskPp+XLveTtCQpDhD3D6Ie70Az89jY3H8kywcD+YEeUe41YBBxDDNfQqXOVu
 +vDBax/0O056CRnpijM5AX1euCdxvBVOn4SFbnEcSv/EzHdscWoQlt5VDo4OFvs0BC
 UDExRTPStDy0gmdIcM4Tnf66uezHZZmLXQB5etTV1V5dBqZX7ofkeLyS77NlNtM7dk
 i3xO17mWZc13A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 18/18] arm: mvebu: turris_omnia: Enable rng
 command in defconfig
Date: Thu,  4 Apr 2024 09:51:07 +0200
Message-ID: <20240404075107.19636-19-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404075107.19636-1-kabel@kernel.org>
References: <20240404075107.19636-1-kabel@kernel.org>
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
Reviewed-by: Stefan Roese <sr@denx.de>
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


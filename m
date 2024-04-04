Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E23CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67EB6883B9;
	Thu,  4 Apr 2024 09:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FmDG61il";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B98A58825D; Thu,  4 Apr 2024 09:51:17 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA90883A9
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E8828CE2AF1;
 Thu,  4 Apr 2024 07:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCF7C433F1;
 Thu,  4 Apr 2024 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217073;
 bh=nGEPUOJ13I57fdN0+Kx2EoA4x1qfdHku4yRzQxr2gi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FmDG61il2ufH6QsM6bkEczI3phnkkTOMf0g6fnTt9L1NiqkaqGSkAMsSsjETJUxVb
 bSJ4Rd+5DGMhw+7aEUZ6DTqsoF8mQ1vYoUJmjtUVX8x0lEY8BdVaU6Y08tSrIt+4Ik
 1EPvdYFGikcOV2sgZ1jbdUJriT3ib+IB38J/XCBo9igKUovbDK0JO/0CbLfTI0tyPK
 Q1c17Hd316hPTAut9G2784exosmJNz/hkLDjkkyiNUG5yJ2X+drW/c8bnGIiCpZe0f
 Tj+EorC0NejpzuKuB1/g0KZUrjD2DU//gRYCb9FTX6hCamTaaVIuq2ZgNzGKtz9vmx
 tUUAOSviXs+Pw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 01/18] arm: mvebu: turris_omnia: Enable LTO by
 default on Turris Omnia
Date: Thu,  4 Apr 2024 09:50:50 +0200
Message-ID: <20240404075107.19636-2-kabel@kernel.org>
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

U-Boot builds for Turris Omnia are approaching the limit of 0xf0000
bytes, which is the size of the U-Boot partition on Omnia.

Enable LTO to get more size optimized binaries.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 configs/turris_omnia_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 29148402a1..39e15043df 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -31,6 +31,7 @@ CONFIG_AHCI=y
 CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_MEMTEST_START=0x00800000
 CONFIG_SYS_MEMTEST_END=0x00ffffff
+CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=983040
 CONFIG_FIT=y
-- 
2.43.2


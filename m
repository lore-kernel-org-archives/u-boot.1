Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B96CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA69883DC;
	Thu,  4 Apr 2024 09:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nrVtVu7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB19883F0; Thu,  4 Apr 2024 09:51:28 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A7A883A9
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D69C3CE2AF1;
 Thu,  4 Apr 2024 07:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A21C433C7;
 Thu,  4 Apr 2024 07:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712217084;
 bh=Cj3zAsmd8KE13w+KBg0t2Eg4eG+Kt/NDreXvpP4FhcU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nrVtVu7KqWWZyPBs3pidizqV/zJuiDcNx+9KukpFcK/tnAm8bmCzj3nmVWy4Y4CwN
 YhR7Tt5lXIJQUme5mu+U5fL/sBJfzW1iSAjwBkYxuTxEfPgtz6pUVDwgTsqvE0eSOC
 hJ2WnCkTwzJQ40s4IzhtvNGIKJ2zgtirAzUcQzg/oo+oS457CKOsikb2LIQNd3BWLT
 s8zlTchW/Vx2HOQD7g2606Dyaxdf0gr6OqQTzJwgjfkm3U2p5bwX9Tkj4oxgZVB21C
 SyVnuGZX9a4wsnzygscfqmitTYBrrO5TtJSoA+MrjwrICuCZDAaJwdVWN6qPF+ATod
 +kmQH596evWUg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v4 10/18] arm: mvebu: system-controller: Select
 mvebu-reset if DM_RESET && PCI_MVEBU
Date: Thu,  4 Apr 2024 09:50:59 +0200
Message-ID: <20240404075107.19636-11-kabel@kernel.org>
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

The mvebu-reset driver is only needed by the mvebu PCIe driver, but
currently it is automatically selected if DM_RESET is enabled. Add the
condition of PCI_MVEBU also being enabled for mvebu-reset to be
selected.

Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Stefan Roese <sr@denx.de>
---
 arch/arm/mach-mvebu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 62a2bc5958..623432a60e 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -18,7 +18,7 @@ config ARMADA_32BIT
 	select TOOLS_KWBIMAGE if SPL
 	select SPL_SYS_NO_VECTOR_TABLE if SPL
 	select ARCH_VERY_EARLY_INIT
-	select ARMADA_32BIT_SYSCON_RESET if DM_RESET
+	select ARMADA_32BIT_SYSCON_RESET if DM_RESET && PCI_MVEBU
 
 # ARMv7 SoCs...
 config ARMADA_375
-- 
2.43.2


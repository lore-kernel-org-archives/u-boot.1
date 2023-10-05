Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9EAE9370D
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 13:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE55686516;
	Thu,  5 Oct 2023 15:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fgxfXHcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DBB86C89; Thu,  5 Oct 2023 15:07:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415C9864DD
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 15:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4BBFC6192D;
 Thu,  5 Oct 2023 13:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26101C3279E;
 Thu,  5 Oct 2023 13:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696511213;
 bh=7s4JrC4+zxBgvErPBhwmZr9v70u+nIAUscoOJ4prcOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fgxfXHcGw41Hvj5yis2FStKnWMWdRYnQ+9y5B5rNHcONuyNwovN0bAybXyF71jlBA
 eR6C6Q9cYyP70xjJHKBXxZFiTxxWkhqejgI6mBoAxlkWIzCQAazsKCLNbGhBLkAz/D
 7hKaWzcjTW1RqMZmuYGRZ46hOSSZtNyah9WgQubDCa+LYNH+rlpNTMeZgXT5BN0H6f
 R7y/igsSS2AMwK8PjrOuI4HkdTZlLCw4vwXrdahHUfLnywYNy582wockFsc0JPSn23
 tDk+PdyXfTsWyho0ge0nwWi5xtDln1h76oB2YdgdtQIHUVO42uu/BvMYn1gfHURr72
 bx5zz1e5j2nfA==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Date: Thu,  5 Oct 2023 16:06:41 +0300
Message-Id: <20231005130642.21402-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005130642.21402-1-rogerq@kernel.org>
References: <20231005130642.21402-1-rogerq@kernel.org>
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

ti_mmc is not a valid boot_target for standard boot flow so
remove it. Prefer mmc1 (sd-card) over mmc0 (emmc).

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 board/ti/am62x/am62x.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index 22a6c2c91b..e53a55c38f 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -8,7 +8,7 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
-boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
+boot_targets=mmc1 mmc0 usb pxe dhcp
 boot=mmc
 mmcdev=1
 bootpart=1:2
-- 
2.34.1


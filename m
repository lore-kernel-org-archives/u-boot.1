Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD32E7B60F
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 13:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0D186BC5;
	Wed,  4 Oct 2023 15:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U9VvKFwB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1237F8751F; Wed,  4 Oct 2023 15:23:39 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1A286679
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 15:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 7F7F9B81CB1;
 Wed,  4 Oct 2023 13:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D48CC433C7;
 Wed,  4 Oct 2023 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696425815;
 bh=vpRaFD/BtYa0gUxpjQK66mU9VJO99ibxaoGeWwZnu2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U9VvKFwBn9taKOlqIqRBvRQTFG33SQfiTHAmRi8IYTDR9g+29wEePb5JvQr+VGIhB
 OJnJCgGdQjaiv7IBOOswMd+OSU0q/wtmcYrteyfSpHGZk3OVAOciStlmAprKHTfhMk
 6iIAdHYW6mEAUYBH0ST2EQzPkRT/5PQPSN6eOiPEsJMhlbTqbhJYJX3Zrx4cEIvmdn
 Nop/ypIZNWJ2C7mhiXe2iHhUPuOASmJjAUvWV1Hsq5M8IXcqVLoQW1AVY/WyXIN1rD
 xTUcvAFsadBcaDguAE5JRL4q5bzAKXtU94XsAs9xvcVL3t0eyaIc7jJdPUR2C/bGR4
 /X64isjX7zcVA==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com,
	nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Date: Wed,  4 Oct 2023 16:23:23 +0300
Message-Id: <20231004132324.44198-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004132324.44198-1-rogerq@kernel.org>
References: <20231004132324.44198-1-rogerq@kernel.org>
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


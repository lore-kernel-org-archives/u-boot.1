Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46985D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B39989125;
	Fri, 18 Oct 2024 03:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LK4vrm3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C9389150; Fri, 18 Oct 2024 03:30:26 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98CA8911F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2C51F408C5; 
 Fri, 18 Oct 2024 01:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729215022;
 bh=i5YkmmwirwR2brIJrDQV6DOI7tqpBh/6gfehxJBsfaA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LK4vrm3TYEVZCm9+oLwfNVNhtscUbasLSPH2EZs1ygP1JDpRMPLih/GPUnzm31iLl
 U+2CjkZhnXdG+3bv19LHfqigaKChs0w/C9UrtO/yZOwSYcJhHPxRzeoL354vmO7Lms
 PPgelO6MtmQGfvkPcbkxdTyQ58ZpJe4AwphaSrH3d/CLCdSxOrobno01B3i+sBfYKo
 vbwWtDUTRYejZ/ZOvzYU1K05Rj70OAdywKFiUeR4cn41b/sGAe5kCmWIGHtR6IcQt3
 YaBpP8QlxsC6MwhjJJ8MkN7fGRDza+6LLkXURtKiRL6SvGildciibdEQ5hWqjT+wCN
 aHKqgrOfgtbCQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] efi_driver: use blk_create_devicef()
Date: Fri, 18 Oct 2024 03:30:14 +0200
Message-ID: <20241018013015.127620-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
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

The EFI block device driver is the only user of blk_create_device() outside
the block device uclass. Use blk_create_devicef() instead like other block
device drivers.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_driver/efi_block_device.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index 34a0365739d..19a5ee24794 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -133,15 +133,13 @@ efi_bl_create_block_device(efi_handle_t handle, void *interface)
 	sprintf(name, "efiblk#%d", devnum);
 
 	/* Create driver model udevice for the EFI block io device */
-	if (blk_create_device(parent, "efi_blk", name, UCLASS_EFI_LOADER,
-			      devnum, io->media->block_size,
-			      (lbaint_t)io->media->last_block, &bdev)) {
+	if (blk_create_devicef(parent, "efi_blk", name, UCLASS_EFI_LOADER,
+			       devnum, io->media->block_size,
+			       (lbaint_t)io->media->last_block, &bdev)) {
 		ret = EFI_OUT_OF_RESOURCES;
 		free(name);
 		goto err;
 	}
-	/* Set the DM_FLAG_NAME_ALLOCED flag to avoid a memory leak */
-	device_set_name_alloced(bdev);
 
 	plat = dev_get_plat(bdev);
 	plat->handle = handle;
-- 
2.45.2


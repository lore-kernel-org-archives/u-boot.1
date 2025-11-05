Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0021CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 12:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D77383A1B;
	Wed,  5 Nov 2025 13:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fQAVOEed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357C983A2D; Wed,  5 Nov 2025 13:24:35 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB2A839FA
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 13:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 66D884029D; 
 Wed,  5 Nov 2025 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762345472;
 bh=/1Q7aBpOdw9dZ/z+yUugy1cjFBcwrlbJUtVpXH8CgIk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fQAVOEedrxrh1mmn0D4IweeJkTAQq2Kmo5bcew0ie5oG1FPcguhzRLTWHhmJIEH3y
 lYFj0sayOeNHFbfKbH1VAdF6XlMwf0v3KyCAHNC4wUpZOqmH15AfzkxKyqdtQjqNPq
 M1ETvXiIJWl0HshRb9hwTvzNL7RmobEm+slgklQzsHP0PyyBWIyGhQc89FeENCqq0T
 5vR+2WQ/V+sGOFMyUVZuNrrTBusafsNOIXwXj+TybxawjRX1UTQFAevHXrhOUOYFi1
 OjvIL+poDB+kiyX+K5KMcCuw2D8C4NT/OtasE7JHxdPfGJKI5PrTIhcDqYH2QIp/kN
 Yav0i0YSKtxpuJoT7zhV8CRutDM4lJdpASHOrpnWF7nYTyDhGq0T1L9ORVFUAL3gBm
 iRF7YcQTiXbiEMYmwcTbwWFTCBCpYPkeSc6DKhQOGAXtdZ3UAOeiECLZE/AJMQ0Bhe
 O7ia2J+4Pnqdt7dqT2q18AbfNL3Kim/cd72AxuqDlyUTSdcoSMrf4i4KtwA2DqEhwp
 jWVqj18vfEO+VzoBfNVOCKlbhzxJboNf4jkpPUt9kv87efB0GDpiSkAkj+09talajH
 jVzDbxa8/YovVRKoD9je789pOkqIX+e5K5xq4EiJ0Rzi2Ap5XPaxqZq6PB1t/Pgn3X
 llrg4+u3hgjfOiOGcnZH1qts=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_driver: don't leak name in
 efi_bl_create_block_device()
Date: Wed,  5 Nov 2025 13:24:26 +0100
Message-ID: <20251105122426.59479-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

blk_create_devicef() uses a copy of parameter name.
We can use a local variable.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	use local variable
---
 lib/efi_driver/efi_block_device.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index c389b1920a8..42843685b71 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -124,7 +124,7 @@ efi_bl_create_block_device(efi_handle_t handle, void *interface)
 	efi_status_t ret;
 	int r;
 	int devnum;
-	char *name;
+	char name[18]; /* strlen("efiblk#2147483648") + 1 */
 	struct efi_block_io *io = interface;
 	struct efi_blk_plat *plat;
 
@@ -136,9 +136,6 @@ efi_bl_create_block_device(efi_handle_t handle, void *interface)
 	if (devnum < 0)
 		return EFI_OUT_OF_RESOURCES;
 
-	name = calloc(1, 18); /* strlen("efiblk#2147483648") + 1 */
-	if (!name)
-		return EFI_OUT_OF_RESOURCES;
 	sprintf(name, "efiblk#%d", devnum);
 
 	/* Create driver model udevice for the EFI block io device */
@@ -146,7 +143,6 @@ efi_bl_create_block_device(efi_handle_t handle, void *interface)
 			       devnum, io->media->block_size,
 			       (lbaint_t)io->media->last_block, &bdev)) {
 		ret = EFI_OUT_OF_RESOURCES;
-		free(name);
 		goto err;
 	}
 
-- 
2.51.0


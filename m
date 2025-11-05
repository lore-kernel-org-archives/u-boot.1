Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A33CCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 01:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF8883981;
	Wed,  5 Nov 2025 02:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="raQqeUOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860BE839E4; Wed,  5 Nov 2025 02:30:50 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBD783968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 02:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F05BA3F1C6; 
 Wed,  5 Nov 2025 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762306248;
 bh=+IIcAZEqT7IFhukXWa2RsjY1RV7BwJa0Pe1LbsMn5a0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=raQqeUODaGqOGepZtm27L5Kn+l3kS+4ZS95QNIx5YBoEDEME16BtDMFHGNXK8lt+9
 Mo02e/ArbIz2oafIkZW13wKSH6O05agmBFvKl+E6jdSPn3UWkk5J3a0GYeVpFJf70w
 fCD2PppYyXAGgVeOssb4ZlRnrVjqUGOOW3eg32fd+x8iuj28MCxViySlCGi0iAUob6
 Z4/q+/8vqHO75Wym/9LTDknnkVsRvBCwzkWKbyIBqsxb+++dP4f/olpRASBpsaqW8X
 yrKI3KZccWo0vcFkPfdRDiymcBqY37pFDiYmETPHW5+NYj6XTlfRwERjdZ++p2TBUy
 442d5GRRl3G7apizZzmLVgpoMj3Eqt2n+wza4KfFAd/GINgf13g0cKQJbSnZ64r53N
 ZZg9wAmm7LIOvmTOOyyjZ6PKu8wao5FwknC1wb0hw9i/jL/ZcY27pxg4/EbN+rJ6dG
 wJsIxmTCstoBjHgKrHnzJEnrIqsjUkTHcLmUe2MFj7tFvljjm61qAwl+Z+IcNZECF2
 upsgUCmZ7qkiswLE8LORyLW2KwJg814Q9/ZQvoA+CVeOAg8qYNHz41Se2b/8nwkYJ+
 trlX35jUbvp067EK79hKa2j04vCUOXll5Zzfj77spXZnEKGJBxMLqZ3ME8+/r+rvHB
 +hmVeJRWfDn6VB6V7zRxsbRU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2] efi_driver: typo 'to be write'
Date: Wed,  5 Nov 2025 02:30:45 +0100
Message-ID: <20251105013045.11283-1-heinrich.schuchardt@canonical.com>
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

%s/to be write/to write/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	use 'to write' to match blkcnt description
---
 lib/efi_driver/efi_block_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block_device.c
index 070747de515..c389b1920a8 100644
--- a/lib/efi_driver/efi_block_device.c
+++ b/lib/efi_driver/efi_block_device.c
@@ -84,7 +84,7 @@ static ulong efi_bl_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
  * efi_bl_write() - write to block device
  *
  * @dev:	device
- * @blknr:	first block to be write
+ * @blknr:	first block to write
  * @blkcnt:	number of blocks to write
  * @buffer:	input buffer
  * Return:	number of blocks transferred
-- 
2.51.0


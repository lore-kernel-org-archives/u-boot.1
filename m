Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D17CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9703E83981;
	Tue,  4 Nov 2025 23:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ov7m1o2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41A78398C; Tue,  4 Nov 2025 23:56:42 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD9F983968
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 58D9F409DF; 
 Tue,  4 Nov 2025 22:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762296999;
 bh=E/w1IdBIYIm9Hr/zPveM+bXDVHHCR1ZF6O8qV/z9oEc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ov7m1o2PaLbmF2NVsXPXOxCPrilkw7PtVmQmYXTjAhDtBLtoAT6aAFlUW5GCkF4qJ
 B3rt1bN5IyG+kKLziO/ZGp7rbQLdWDvDnhayBvQklhHXJC2SsMjvh8TgHzqlm60Ovs
 36oOhyFb+RY5g2rUIB0xI1YC6j1EgIrhcn0Bdz9EdCBIw+8sSwywnvnB7EQONgEY/0
 Qs9q9B/GihpoN0XT8mswRbxlJXwRBQFUAasfXPLXoQOgRnfKMnb1k7rBfPjToB8F26
 FpLYexbgP5eR9N54CJPH73/bsSsc+e/c2b0tGlocLQOX+9NvJzxjXpJive72OPlpUF
 vVyxE6J43kasSR+Zs0fo5Yq2+m1MqolNsrEFm+mSREwHfvrSUvkX9uGxCOSKIc2Nom
 8POsJRhHUqtYLijC/aRe65uLA8aLxGUR7mr+xTN4wdDNd9lWtcTajNuL4/YFlNmbld
 tFc5DKCDoUvo33YE6kk+pHeu7YM0Zn994arC4rXaddrCISYf0Axt4GbzpEIGq3fMO7
 LjkJKPSFA3DjckIOmK0WtkYxNUtEyBQGosa9/bNzDYDZwDIr1rd112DFp4IYN5OZqF
 vjtmoZgwHnN8aZONrrgJZ8ynW3OHrVEa9Y1KJhmYITRwZT2VVygnXqmQBl0RDPIxec
 D8UmX8uWwmrYPqVp/HKRHXa4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_driver: typo 'to be write'
Date: Tue,  4 Nov 2025 23:56:36 +0100
Message-ID: <20251104225636.49890-1-heinrich.schuchardt@canonical.com>
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

%s/to be write/to be written/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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
+ * @blknr:	first block to be written
  * @blkcnt:	number of blocks to write
  * @buffer:	input buffer
  * Return:	number of blocks transferred
-- 
2.51.0


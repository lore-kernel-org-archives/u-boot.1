Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32702CCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 01:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05EB083981;
	Wed,  5 Nov 2025 02:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I0wdQYZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A48F839CA; Wed,  5 Nov 2025 02:26:54 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC70883968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 02:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CC2893F1C6; 
 Wed,  5 Nov 2025 01:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762306011;
 bh=ALMC9Ta+F3Vk8sgChouAhiRxdylgCR6c5NiRiTB3xd4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=I0wdQYZL3qSkd0gn2AWTNOU8uCBfKI2/xqGqGNNi/lOYeCrBhSZz+EPE4fSCOU/b/
 3yAHDxYXLmT3aC+WkIUuuGvUEJ6U9ENThZzWtllMHioHVf8eMgOS/z4bEpm1Mou/CY
 cDPbu7N9AI0Q04IQGpBA7VVn33o4+GwyL9BVE7hb9kdzSOO8iTtRwEbbHvF/dSAVOa
 mlatrJ8D4sXtXIqXXA2owSrKJsqj+d+twnw5VDiua/8NlNYE03CyvAi/G8skHclJ05
 qHlLyNxLEIfe5Ga8UREDQBkEWyhKUOyvMHsBGYEhl8M+If5PBrs89/egl7t1TZKukM
 FeiQh1V4exOvPqloh4c801zdS6OmPzoHxNgM1sPEWpkm3P2BNOWBs0zMxgUSrG2hTo
 rm7Fy1KJp3u2zZ7mONk+7Kg7v4wjf24IEpA/grncp71ugyfLRpSvXJatA8uGEwuyVM
 DI33qm6hj5v74GHMCOZl7bDAM2uue53bElB5Ph3EBJOAeJp1bw9Ss2IQoFgKZeBk9Q
 NAt2CaiFsA56C+383MVwUSiff0unrRtZNpM5LvurmYXk22RiSHgyXPuWYalz+Zh3sT
 Lu4xCRzEOcDaevafFEMQWMSaJRynwv0wTofy7Av5idVfzve/M3FkIffGJi0gRFXAKM
 12as4ELGrIWfCj5gCYTtlUvE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2] block: typo 'to be write'
Date: Wed,  5 Nov 2025 02:26:49 +0100
Message-ID: <20251105012649.11067-1-heinrich.schuchardt@canonical.com>
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
	fix typo in subject line
---
 drivers/block/efi_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
index 9766cd6f832..02286876f77 100644
--- a/drivers/block/efi_blk.c
+++ b/drivers/block/efi_blk.c
@@ -49,7 +49,7 @@ static ulong efi_bl_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
  * Write to block device
  *
  * @dev:	device
- * @blknr:	first block to be write
+ * @blknr:	first block to write
  * @blkcnt:	number of blocks to write
  * @buffer:	input buffer
  * Return:	number of blocks transferred
-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E222DCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 22:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337DB83981;
	Tue,  4 Nov 2025 23:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GunIwWrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C790683984; Tue,  4 Nov 2025 23:54:11 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC50883968
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 23:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 42116409DF; 
 Tue,  4 Nov 2025 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762296848;
 bh=65KhHxuIFu8DdakLoYIz+dOLK5Inod8VjJ0xrV308+k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GunIwWrbgTDvI1/awNMyQJq4TwIuKg9yo/rNAZxhyfwXvXyyeg/CeU42wMukv2WJn
 fuEU36eG+JwigPKuhUNE0VeCF5Gf4dwl6pII9etqsJXxzkgcQSk7pgU0K25FB7Qtah
 kGwVWcBk9r6qfYnsvTQZ67hr+kKJlg2XKhYE87pewFYGW7UaZCf/QvFWTmQR4B70a+
 fgbcBC7RDWxM6aesUcbcSxZS5PH2vAtmCLDfytVQ854VlXkFHS0C+wL5qpNPiur5w/
 1IEa72aZB8YfwcddfPwQSrVoaXpcfWbtjdV6ANaSUPtAye3ymUdwlqE7Y36QkFFrE+
 Y9CTks+2w/LdQkmfbY2XItuWHoqGdazd65JGUzqHOAbybLZVPWAVZram3xZAIgYVc0
 PA+IkFeV03EgzanT6d1fqYZunq3UCUM2c3MH467nBDCtYlyzEnFbhKvz4BrOshNdBB
 k3TQG3fwSRn0QnMO9Mo6zsF+c20caWqyJxOTXZSon1uSkUeHd/QZfmUilBHNw0m8S7
 HSV8xKT3Gk9j6kGvWDV8+fX4CVPF2EaOc7OzNzSRSIOz5zWzPr6yeZGrYCns4avso7
 WoP9Brvovpu1BWY7DH/5ef+PwHQIRdT1Ss/kY7XbQRkCb+FYNoslOk5C8FH8zlmjqO
 fLlnbuSqxXaySkAt9Q4L5g8s=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] block: type 'to be write'
Date: Tue,  4 Nov 2025 23:54:04 +0100
Message-ID: <20251104225404.49618-1-heinrich.schuchardt@canonical.com>
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
+ * @blknr:	first block to be written
  * @blkcnt:	number of blocks to write
  * @buffer:	input buffer
  * Return:	number of blocks transferred
-- 
2.51.0


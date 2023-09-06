Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EE6EE14D7
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C40186A97;
	Wed,  6 Sep 2023 23:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JOjk/dmC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IcpwfaaG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DB086A74; Wed,  6 Sep 2023 23:30:58 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D61868BC
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXc1txBz9tTZ;
 Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIFQlXzKS+EN1Vbdwpr/tzL5UHP1sD0AjKVfs5UFilk=;
 b=JOjk/dmC7IcIBUkrK5bIMt8X/7kFHrHtRpmeSY6wnJOL+xn2F9zPFf7wLzHBsLClTRX+4v
 lrnSNRx1ioy1Yw4/rAvj1pcZcKuaAnNjgJsExExPizmawLe8VV3pYKS0d4V1eoIF7yAkOO
 zOpty1QkhVCyFG4iamf0/4/UPPTTHaoHLYGDIfFn/SkHE5X9C0Ry1izPh942VCU+9cYEFw
 z0D0n9oF6OE4MNApiLHGJOsIQjgFM7ER8z5ztn3zmEIaiOolp6e56MqMRKj4y4rYy8Sd0b
 /wRgUTeM2E2FFtN4W7KjTbpOkZGiaxU8RYQ2B4m8FYTjMDZvpjF09dDIZohqtw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yIFQlXzKS+EN1Vbdwpr/tzL5UHP1sD0AjKVfs5UFilk=;
 b=IcpwfaaGWrriwMNlmyVQRWzzZ2bXGGl/m+J5eY2R9sWaEGocN65iRD3pml5y/uSVfUCxbD
 lhkLvl1OZ738OZZaEBG9UqlCVVCF2FASZtypDeV9o5A0u/7z+AFp7Fr4HJL/r1XfY1KAfa
 AZRepFdt7wId77HRdMgT44VYXgUpSHV6FQFoVc31eU5oTOtXVobealTFSAYZIUVcqMxo9f
 nTzBKDTB1WOPQ6XwpsfAj28i+vcL5KJVQnpvOlpDuMGcKqQ116zCodCuNUugg1/uGa8cM8
 LKhKkztxB5Otp/+wGB46yhx6/pslr34JAJKdo9F57MEnoEseGjbX55gSfEkhIA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 25/35] sf: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:30:05 +0200
Message-Id: <20230906213015.203437-26-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f104b089c0716a9dc97
X-MBO-RS-META: 6c8trc8wed6c4iaw3dn6dw6at33f58fs
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

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/mtd/spi/sf-uclass.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/mtd/spi/sf-uclass.c b/drivers/mtd/spi/sf-uclass.c
index df1f75390c4..2da0cf0dcf9 100644
--- a/drivers/mtd/spi/sf-uclass.c
+++ b/drivers/mtd/spi/sf-uclass.c
@@ -96,22 +96,6 @@ static int spi_flash_post_bind(struct udevice *dev)
 			return log_msg_ret("bd", ret);
 	}
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	struct dm_spi_flash_ops *ops = sf_get_ops(dev);
-	static int reloc_done;
-
-	if (!reloc_done) {
-		if (ops->read)
-			ops->read += gd->reloc_off;
-		if (ops->write)
-			ops->write += gd->reloc_off;
-		if (ops->erase)
-			ops->erase += gd->reloc_off;
-
-		reloc_done++;
-	}
-#endif
-
 	return 0;
 }
 
-- 
2.40.1


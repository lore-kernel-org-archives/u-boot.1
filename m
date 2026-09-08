Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A6C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 12:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D1AF60717;
	Tue,  8 Sep 2026 12:44:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oA70AeW5ru69; Tue,  8 Sep 2026 12:44:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B1E360709
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788871492;
	b=P4P5cw2eTK51gXRlGOVIWRpXeBriYiZy+Zo7eaejfzqpuq/j/BWdL6EuVVrWGdNb8CCU
	 Nbp3lil2OLGm4J8ArIl4jDGdJgik9jO598EOe9nVOyT2srhSJGOuoNwr6MziR3ruhQAP/
	 o9sY8b2+0OhAGz09+h8KMsHWBmd4c3PJpxSjYEYBGa5T6dZTQr9EDCHdDf9VgNXrz+k7u
	 BCPgjdGM8y1kFqy6b7GYg6w+pNE//6gIGHhAOqI6mSLWBFkEptRLlckpQsT2qPGf59/mW
	 /EcVYYMiub7bttM9UCmVxsG//F4Bm/oijvkKlgdk//V7Pg0vrBvy+Yd1a31M99oRukg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788871492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SmPzSnRlqeAo+pmaN8pbdQr5FH4etYnCSiRq6WRkL4w=;
	b=czPBX/bAXdryYtzQq5sFgE+DoiSGIL8c1OsdWDP3k9a9T4bywbHXsX+aAwFeyRL2CdpY
	 FL5IIF6hwY9MafjWL8foZfpWjpMbcnke9NZ+XjuEGbWrbGkPcsnfnzjkqKKxHZzC65Pfn
	 W9n2zO9UzQhWIIJ9dHGDg4+7AXeDI3caglA/58sza1L9XYQzj3wKpkrQUebrH3MMB8jU6
	 X1rTXKr55L60mwNSJ3Gi2xbG3+fVqlFiKWBMbjT1py0/Ip9NOJlInpSem+y9TJJQqRTXB
	 LmgAWyTI21naYEhhi7BIYquks2EjaIoIQsVCwREcmPjDP7bVKB4Z4hwPQlGuVD4LutQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788871492;
	bh=SmPzSnRlqeAo+pmaN8pbdQr5FH4etYnCSiRq6WRkL4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kkhy4mjZKAiRIL6jKpEzcUCtXy6LhNjWWe2fpjPv99J3/5iMk1NJTNthQ2njzlIIp
	 o75WOjGhiUvqlESMFm0TXnRFowJix/CCmMhCSOmhnSUc7iAHSsVoP094rgysovLCm5
	 bdutWqsHBE06txqx4YAVa56479EpmxuOewSLvTef6gXH2HwOmZIomrG3qawExEn3pO
	 VhOPOKSkB/CUrfe54pznd6q78+ClYwRgEcQXkf+h5YrsuXrZzH9unnk9nvBjGQ9np4
	 Y+tJHt9fl31Ikve7INSt1uG3JgAMVuRFwSNMUwBTxkB3tuyjtDzSub1e9hjK52PrWL
	 ih0SrpNtGX3Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B1E360709;
	Tue,  8 Sep 2026 12:44:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35909990
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C12B403E0
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hxbYnAhTjfln for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 12:44:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 85279403AA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788871488;
 b=WaMXJNu/OJbtiDJiRatiWs7rGIItgtFIis76JQyLbvSeXg7Caon83YQQn4snJT/bnGNv
 jwb9Jqc3fo9KnOc0kTbx6f9BcZuaxx4rx+I4wM9WIwjp0EK/kJAFpVW8QK35HxAGp96aZ
 WhnB4IulzvYbwJ4mMnLU99gA8qiQ5ifLENntsOOTWkn41g5eVk4g+0/RokBuMq7jkG8ie
 q/LLIKkp9+Lfj5ToN54KFfyXKWyTQRj/PSJn6dTRaziSGUx9XMNAELTGISGQmZwXoGKm7
 NWZgXYY3dVbcNN5jApDN1E1k9ptWLuPbgZIkVnAKZ8SmL69B2GvG9Z/JU+FlObP098A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788871488;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=SmPzSnRlqeAo+pmaN8pbdQr5FH4etYnCSiRq6WRkL4w=;
 b=ppKc8lJbPxDO+/mH8JpIsF2nfoe5ue6qfBlVTJ8w7oxZiryfObgbWJ7iguNWaJ2Mbxvi
 K0/Uyn9uYcF80NpJBO8b1k2dw6cjHZq4FuF0N4Y8AXePYHQLt7wJzFe2EupJ6nfzMIW5h
 F++FaREhOfP9XWCgWTRuAnqTe/oYPlzBrLcFGivIRQlAcQYUzGJOaLpSo/YyYVg+c6Xpk
 uy4CKIP1a2rgk3TmEzDIj33S5u44Hrq7uNl+Qdnt4srBTYlXqxgc3NYY85RJT2fnhcI4A
 R4ZZViNpun2Da0qSsmV1e2ZsdjfDSnv2dDT/JGdqWplkvd8XBxIZBxN1AXtkG5EZvNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=ew.tq-group.com; 
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=onrPSlK1; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=alexander.feilke@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=onrPSlK1
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85279403AA
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SmPzSnRlqeAo+pmaN8pbdQr5FH4etYnCSiRq6WRkL4w=; b=onrPSlK1Jww62OuOCfBxBPUZOn
 ydgxti76kuCMlpF4Lr1C/7ShSYQ0D7LjFoQ0qTwG4ra5+OLoPFwE9ivB6rNOvmBBhjHdQlPtZrjxQ
 tJV97xr/lFJxiHctEMA1aupiivFVy+z7n69rlc0u0zfTQYIfrCxBsx9n0jQ7154YDP2FPD/y6Sxr+
 b5zGYlRpQjrUJJM3W6S6U4M3KpGjdwT0yOiyhTNJGpCA1Li3hfa8FBPJHy6M6VmzbB4nlrZduhPJK
 nBGr240Eyr5pS4KVaHP07kpN0CoIVvEB6HH92QnN62dzWDZk/VOOOCSeE2PqjNumHI4jf9UGLtckL
 wWQF6btg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vBr-000Buo-1E; Tue, 08 Sep 2026 14:44:43 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1x3vBr-0006vC-0G; Tue, 08 Sep 2026 14:44:43 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org,
	u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] configs: tqma6ul: rename TQMA6UL_SPI_UBOOT_SIZE to
 TQMA6UL_SPI_UBOOT_MAX_SIZE
Date: Tue,  8 Sep 2026 14:44:32 +0200
Message-ID: <20260908124434.894275-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908124434.894275-1-Alexander.Feilke@ew.tq-group.com>
References: <20260908124434.894275-1-Alexander.Feilke@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28117/Tue Sep  8 08:26:31 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Clarify the intended use of the variable.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/tqma6ul/tqma6ul.env | 2 +-
 include/configs/tqma6ul.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/tq/tqma6ul/tqma6ul.env b/board/tq/tqma6ul/tqma6ul.env
index fa172caca23..aa42aa6e3d7 100644
--- a/board/tq/tqma6ul/tqma6ul.env
+++ b/board/tq/tqma6ul/tqma6ul.env
@@ -29,7 +29,7 @@ uboot_mmc_start=TQMA6UL_MMC_UBOOT_SECTOR_START
 uboot_mmc_size=TQMA6UL_MMC_UBOOT_SECTOR_COUNT
 uboot_spi_sector_size=TQMA6UL_SPI_FLASH_SECTOR_SIZE
 uboot_spi_start=TQMA6UL_SPI_UBOOT_START
-uboot_spi_size=TQMA6UL_SPI_UBOOT_SIZE
+uboot_spi_size=TQMA6UL_SPI_UBOOT_MAX_SIZE
 
 #ifdef CONFIG_USB_FUNCTION_FASTBOOT
 
diff --git a/include/configs/tqma6ul.h b/include/configs/tqma6ul.h
index 89bd8102500..34378b33a22 100644
--- a/include/configs/tqma6ul.h
+++ b/include/configs/tqma6ul.h
@@ -19,7 +19,7 @@
 
 #define TQMA6UL_SPI_FLASH_SECTOR_SIZE	SZ_64K
 #define TQMA6UL_SPI_UBOOT_START		SZ_4K
-#define TQMA6UL_SPI_UBOOT_SIZE		0xf0000
+#define TQMA6UL_SPI_UBOOT_MAX_SIZE	0xf0000
 
 /* 128 MiB offset as suggested in ARM related Linux docs */
 #define TQMA6UL_FDT_ADDRESS		0x88000000
-- 
2.43.0


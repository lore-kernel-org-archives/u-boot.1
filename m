Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF8606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sn2Ita+l;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VAtEC37W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BABD080E20;
	Mon, 26 Oct 2026 13:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-I8V7EnHckp; Mon, 26 Oct 2026 13:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A6C4380DB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022475;
	b=CsiIMDqNvqste6r+wycDBFmXl+tD4csuPTcQC94j498Fn9kqGsehT1tu5gAIlt7zMw2n
	 qSbSn2UNgLgTa0r4XN9cR7BwfWQ6ORpjgYbqTWFAboHF3JHZd8D0AnPPGpZ5Tr4kMS9iY
	 4yY33hP4sTo+tmx8Pkbo/0CyUtu3zpn0S3gNtM6laM0iHA8rHzt+EomdkBb0Jy4eW0M54
	 eyDYRvDznDu0FV5SYA2WXI9cDdJRCdTSwVWuyhnKS0ArOmN8wiTTYIhkRAPPut5ydUAra
	 u+gf+0BGDqDbYfdVqhL4q1sUsfIMpDkNQs/vsGEV6ve84LhRqcDjTECqjpvH+H5pLAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ylH8sedBtnEeqv9EjpCCCssO5nDbGLV89aXha00cLm0=;
	b=BbUYm5ON8Df1vIt+ElGXTVGKsQOPRrvI+/vgdVkgnBBOwtGF9UG5rFI8EwTA/UeN1hWh
	 mhYz9yn+BrM/mrhb3H1UF7MlVpkClUL6Hqwe5bkvLcAFlkyn9c6AED0ePuo+5ZOTHe0aP
	 BhoPAnPHJGb60rXiUYip70LJij/wXsN56ObMHbdC9KdeWZ71IhBbolKS2T0auSBjAY1m0
	 k4BRdcjzzdM3jxrL8XtrL3Bn7tI8zfGgcw4A827h8f2DXyj1gBz2LWmWbgdmZOVUZb6zD
	 0JM1xanEmdaOQXSVCcf4qTmg9K9rjVhalPkpbulqli30n3bTRoNR/sjDP3TplwLt4ug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022475;
	bh=ylH8sedBtnEeqv9EjpCCCssO5nDbGLV89aXha00cLm0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sn2Ita+lvbzuDLreT65+du3ypI5dIGgCOKqtJDymZw0tPB8VLLRLyvuwvUZSi8cth
	 DMDkhLYlqokjZvX7skQbk5FvFVWBTHoalp88BFZHZc6BQdOGv5IwPahxl7julGkooW
	 2d5Q/63Fqf6Hfy2r2IgaBDryKj9NOqtkfjxk/J2+oSLvlXEcLfn202fVxB7Bt1Mkcx
	 pL+TNoeDZixfaGSqy7VGNotU97qBBB4ncouDdEMcryCLrGTT282+bllMt47kiZeH5O
	 lBDSzQVOKM/QpFbLeQiP2Sw9c8UXXsGKHruM1eH71fwwASB/I95U6yAQ45Z2/2NV1G
	 dlILZft2qkodQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6C4380DB2;
	Mon, 26 Oct 2026 13:47:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCCD14B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA52B60608
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hd5sf-WRll4C for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:47:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 564E960603
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022472;
 b=Lb8HsNvSegPgF0hE/R+iPWXx7jIeIL8szggRR/anX9pVowZ10fY2cgPEqg0d3ws47XYM
 t/hzVaHPO1iwJl3rk9dPel60kgejIpOhjTla2Lz+qarKsUDIWZf4QHTkXSn3tS8yIe5yi
 1XcMyh4byjtF7Ovqx2l/nJltehU+Z7hDS2n+N4OW06IujK95REFD+i6rQGcUpcOkdmEVn
 nZexdKW9NwhBdQr64jBrKqqD933jGp7DY3RvDXetizIrVTyQYGcEil1z0kzb/4mZIbryr
 p9DwQvvP2jqpV73UbVneeAVM1nKq7D3S0cOcYF1BwilQRGIICR4w/2cng3QVOwHiyWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022472;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=ylH8sedBtnEeqv9EjpCCCssO5nDbGLV89aXha00cLm0=;
 b=NaQdNCsLqRuEZSTi87AHPDACpH22oOBRuSJi17zBRMKB6XCMUCiAQHe2aJSNWXBSXxGJ
 HvIqueVtogdUuRJwFsvu6MabMinciIYzJuNT8+dGtY4N5kGXFHSKnRjPOBw5OcYvaLss4
 +ewKLT8nRW4UYcqB7L/VmCwQqkDTMLFO91sffsjfYTyJ3O2FlNwpXMLlkl6z32akyukuh
 DLh6MzEahL3NnpjvJshC4inOIb84FQ2n7kwEDhxoJbBtwElwvyQTGEwN0vZ/nqQ/9bbTx
 D+ljhmTqT6r/pJpM5nMHYERwPoYgn7WK+WwzyTJXauo1UuPJpUwvpZKpEa8UdsVBGVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=VAtEC37W; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=VAtEC37W
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 564E960603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:47:51 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jCw1H33RtzKmQ6;
 Mon, 26 Oct 2026 14:47:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793022467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ylH8sedBtnEeqv9EjpCCCssO5nDbGLV89aXha00cLm0=;
 b=VAtEC37Widg0rmbHdnZGDJMg4YS14uOY+ayA4J+i0c14QR+Wh/D3A0dE+WfM1DB1gB1OSr
 jIkwyqqYxHIvOuReX3kvKRX18+Iot8yvhw5Lyi5+REkWtS67x/J1fHRtbj9vAwOrqbVvv0
 3zcXFeAiy1RQZa3OrEpt68VFK/XLzsrUlqXj4h3blC0ktZ/JamY7cPv4qy7b8wZ0Vr3FAL
 nbx2E9nDkSF+2KuMtwEcISWUEoT0YDqyPrYg+837XP2uuPqIgxvfnVVbw7FEQ7UD6Uhedd
 2V2brFsPXgbcVTVSJESNU3B4gD+k0ss4KqDsFqoD5MWHwFuYVYHwmLkrON36BQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>,
 Vincent Jardin <vjardin@free.fr>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Date: Mon, 26 Oct 2026 14:46:10 +0100
Message-ID: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xteskzeneadsuae7ny9weif7ccn453rc
X-MBO-RS-ID: cedf5a3f44194028c4e
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Kenichi Nagai <kenichi.nagai.ry@renesas.com>

Add IDs for Winbond W77T51NW, 512M-bit Secure Serial Flash Memory
with Post-Quantum Cryptography, SPI, Quad, Octal and DTR . For
details please see vendor page:

https://www.winbond.com/hq/product/code-storage-flash/trustme-secure/w77t-nw/

Signed-off-by: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Kenichi Nagai <kenichi.nagai.ry@renesas.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Vignesh R <vigneshr@ti.com>
Cc: Vincent Jardin <vjardin@free.fr>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 67486d7a945..fce22300b61 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -670,6 +670,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25q01nw-im", 0xef8021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q02nw-im", 0xef8022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("w77t51nw", 0xef8e1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XMC
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-- 
2.53.0


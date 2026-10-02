Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EAACA5FD9
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 07:59:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D6F740C03;
	Fri,  2 Oct 2026 07:59:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CWMC0ZyePpiW; Fri,  2 Oct 2026 07:59:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4500140B02
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790927950;
	b=Xyb2ORvm7NJf1gRpGP2qh8f5mfezE7vrKwg+DhOiwZIjkgzHgPqgN1jO+vArvktFK4G6
	 hYu/o+rIG4/GodkmDwlkn002KGv/4RXoEC9+ga1jTnZaN8tqKfoflQVOR2gb6GqssKtSd
	 G2CRNqu2Y7QdxTu+yHPC4VYSDKzHoYVzEOTi5e2cY7H/MnkZ4sJOb/6gND6ZX06QhSy1S
	 U0bbgBk2sgwzo7DxaZOICkMLpPLkzWP13bgOwKvFA3RRQ2v2z47pwZbdqQBY0uakVyYh9
	 ByJqR+ji4jREWNkTU0t9sEMxPAS/xF89mQjyUBruf8Nbcd3oKou8DpO9fLd8CQKJ3bQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790927950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O+shRQ8r0do8Qc2dAUAzoPviNnPjR/PpDXOEjynVYMs=;
	b=L2F737UsVPl3jKX0bAliEQJxoq1c/tVTqkpsiYomqY3iNQYMWu51ct8sNQ7OD1n4rTeh
	 eaEjZ+ybjuD1rtk+9DmzH27Ox7CuxxZAJXLJDfbgZ9cWxFaCOnuOZCsEXvHbZOSDVR0uC
	 CjE7q8f8Doatw+akjJmDQIpB5nFPJBlxamgUlJK7cMmkRytyGQmtoqQgRIogeqYI/Jm0h
	 di06E5xR0n9RVoVZQuxdSyh57UmPiDCvCYxtbmLT3D3IrQWfZX8ucTSzWm8RzrYlgzB2L
	 kaqAj3p68PQ05aBYWal1AZZLIgGpY+PVZLE+HHkVUENecH31HaI4j8H/VTy7fyYGuVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790927950;
	bh=O+shRQ8r0do8Qc2dAUAzoPviNnPjR/PpDXOEjynVYMs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Xg1zQTXpAMBVe497jIDPWR5+q6vG0oT8i/fSHL3sTng9exnxf085HTYS1Yria0Kck
	 KT6obqeia6S6xiKdQresHz4OvFLe4XGEhhwS0ifBCvJD4jI3i74FNWvHT0qAJ7YtBB
	 ShagKvVJcBRgOpQvkvwNfUHBLSBZ0QZfR5Ol4kur4+B/b1bcKrU3HMQs/9ez87jUIM
	 hKoX3xRuX5b45+MZfwpbW09bljFSsxSf9UV039msJHfos4w5tRh/0MHn60yJmsod0f
	 nGA/qvUSKfuok2uBAWLez7H6GxpkI7PRvLmN35KfoXPbAZwlfZW9HoCsA0GD/GXRyz
	 rULBfyv7O7fUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4500140B02;
	Fri,  2 Oct 2026 07:59:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9155032F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 832FA607CE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:59:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLuhQxZzScYX for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:59:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4A564607FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790927947;
 b=id3ZvKpCSWAbc52WlRorbrNrbkuVxQXk4DMTzdZ043k4x4vCibLmOJO/3sEuH9nZ7EqZ
 2v7TMmbnVPKF9bxBEHEh//8A09EluRigy9EOZAMTm9CCIQd91EwIFhJ5gFeFpmgAM+Dwm
 0+KaPFawCWhMG3AGcebXF533iD4Hfk02DSZ0Di20yEmquaLHwljMWnmbNHp4V6Y3Q+3zS
 vskIwCRbywYBZKLeV8caRbNKJ5V7Gv9pAf2+0ciOhlY1D1SAhfQDJuXhH7x1Qf273YnLY
 AR8GoZNXGVhi8F2ZV5ion4PkvuzpTJhPqg7f6XZedhdHOtEE8ik4S++14UCJIqGqgyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790927947;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=O+shRQ8r0do8Qc2dAUAzoPviNnPjR/PpDXOEjynVYMs=;
 b=f6yC4fjZriYBdhCroN/+HL8PYSs+5Uy4+Ik5x1eTX6Ntwzd/4NOE+ZKtV/f4oG9dId3J
 KX+KAZxA/J93fQv4l2KuDvRuoZfAj5dE734VFn5N/2P5zfD/PHyQBQv+0b+2ZtTXkww9O
 85hSmeqXtHs7DG9mpAD00Y0Y/sC3eko+y6tbPuyV/ugs+G8hcfCWAiT1JkmPwBSiGKldm
 FkauPk0aFdR0bKWkIxLz3eo0Mzu4rEinXxFviOlxiwYTWpcD3j2XyVmpjvhVINAv6IgVu
 78gaBMHGbkRUxssEyjqVDR07ImRxChziq2Ck1Ge8btlHXu3MUkjKgfKgux6chI3XGPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=NK4jb00M; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=NK4jb00M
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A564607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id BABF0B0054E;
 Fri,  2 Oct 2026 09:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790927944;
 bh=kzLipzxVCIH1Km915KJLh1ml4UFUzuAvn7VF6yW1id4=;
 h=From:To:Cc:Subject:Date:From;
 b=NK4jb00M/cNUPNMH9Q27rarinM36k0HzM5JxKhQEi8Q9C1gdYTj3OXCgZc8w2h42J
 N5J3K3Vc9lfUsNv4ghHCjHIHgQzXeldPCM5JN4XVKwJA1evzUKxqGWkTJ6JoSd3dFD
 bmRb0O8fXA72KtITiqc3ys/hlW8YwUVzr3DTX/WR8vti4UjZH3ry2sowOIkCZv1G3I
 jFDs15l9efBvKnfRW/WMPpnRnYWt3iBAPE6sFz7nCVibC9oYRF6cO4+23qsL6IlwUf
 +n10E4bxqi+yfwTtvxGazcGyzh41q+oJdkRqnZ3q7YXxJXmB/zxrBbeYnAvF5nru5F
 MFLplzEmElHTA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2] mtd: spi-nor-ids: gd55lb02gf: add SPI_NOR_DUAL_READ
Date: Fri,  2 Oct 2026 09:58:54 +0200
Message-ID: <20261002075854.1828080-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The GD55LB02GF supports Dual Output Fast Read and Dual IO Fast Read
according to its datasheet, but its entry only declares the single
and quad reads.

From the datasheet below, see:
- section 4.1 "SPI Mode": Dual SPI cmd are 3Bh, 3Ch, BBh and BCh
- section 8.16 "Dual Output Fast Read (3Bh/3Ch)"
- section 8.18 "Dual I/O Fast Read (BBh/BCh)"

Link: https://download.gigadevice.com/Datasheet/DS-01015-GD55LB02GF-Rev1.3.pdf
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v2:
- Add a Link to the datasheet and sections (Takahiro)

 drivers/mtd/spi/spi-nor-ids.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 31a2ba49a87..59247b3f4b9 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -233,7 +233,8 @@ const struct flash_info spi_nor_ids[] = {
 	},
 	{
 		INFO("gd55lb02gf", 0xc8601c, 0, 64 * 1024, 4096,
-		     SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
+		     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+		     SPI_NOR_4B_OPCODES)
 	},
 #endif
 #ifdef CONFIG_SPI_FLASH_ISSI		/* ISSI */
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
branch: for-upstream/mtd-gd55lb02gf-dual-read-v2

-- 
2.43.0


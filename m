Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE712606A323
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hk7NIkzO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jkm+avgs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 261FD4064E;
	Mon,  9 Nov 2026 04:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmsQ5HZyB8Z3; Mon,  9 Nov 2026 04:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 73BB940636
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794198837;
	b=NDdrka7Ks2RILQXhm2yyI/0MOvX3dnz+JJQoOIORD1a/pr2cQPiZ3RinolUOv8k3tQcY
	 WbWSllmRbBxa2Q1QE7aye3JI5ZTpMpBe/nPLq8OBpP6YK5K5fEiDfAZBdyAH6d1zhBjks
	 NSNR34VftvlGkO6yl0gyG8t9ty38Xkdmd9iuHrUR2eYzWYSidSQBWSUWSIvh4PuCBLGEK
	 aAK4/f2g9f27n8QeSLT06dGE/cPYltnoVJBwWJL11T4+l5nL39ja7JKuCeVM80WK0vjdQ
	 kmhkE5mzP0lcWwqyIlhD3swyczc0za5PM1tuVpcwrZe7POhDrQMpTEWW+Ax0w+BvYQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794198837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=3ZhQPgy5tVjNkaHYmVO794xVSt2KatNPLb9FLz6aAak=;
	b=tXDbOsNitLMYrCiIGCjI8MxwJutBklo1zwRIZb8QBKDh4IfyLpGFV76Rw6Ch/pMpqpyO
	 7HY2IMrYvhYkd/eQPLAr5CcAkUjR5p3sFQG6PzGUf5XzZqwUfYctgJOFeOqACGDEn1SKF
	 ekOm9Jozzcahz71YsU3nNvK895NDf4e5t9matPMzLYm4QQ04IS98sJCKTDgtSRYMRi6kA
	 sgo9aPevkfvG2rZ5EuZe4wIS5eQRe6u6NdsRiDOj7HbQ+TqG6b762KKiVI/Lrkvi9EQES
	 oSE25SlLZ/HeeHsLTmS3Q7Hyt5G0ES6DA5B70lIG7WDmxvl0yUkNvfPpvtlxiL4/gLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jkm+avgs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794198837;
	bh=3ZhQPgy5tVjNkaHYmVO794xVSt2KatNPLb9FLz6aAak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=hk7NIkzOeFistR3oF0Cld45jyShGzJPANmYWudk//P/Vkj+8Stj+71ZB/xVG0CjD+
	 rzsbLlXryKzPe7LEulDpwGVebdmED5T7p4F1a/ZbQIbGo+GUlCmtvX8L+8yjOlihl/
	 shart0jsLMO5gmnck6bDQZNx0LxgFK5XiuRIEXvfZej/MKstagd4yl5mtGlDek5jb6
	 LU4PuGOX91DADWUQmHE7qGp25+yzgCGwTDE4FNJof03kHXIuaO9EsfguuWnbDxqLOK
	 uDJd7g8MKQ7VHxsjlYArl+lqXCNFaJzIJHUJ26PsTZDfBNrJUG5J1AvwYjrzHUyM6h
	 1tiYcuMT93/Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73BB940636;
	Mon,  9 Nov 2026 04:33:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8587111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A57DA4064B
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9RoUrY6VcSw for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB93140649
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Jkm+avgs
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB93140649
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D241143C41;
 Mon,  9 Nov 2026 02:58:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D7D361F008A4;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794193081;
 bh=3ZhQPgy5tVjNkaHYmVO794xVSt2KatNPLb9FLz6aAak=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Jkm+avgsPPa8J8MzYpieBmQfUwp5Ud0z1QdRPZvFqTGdvcCMa0yxLOJu8ysjiohcX
 BQouL6fbROSZykZ6e7zvWPZ18dk/wJkW6GmngdPryHSdLBv/ICIG2mwr12xd6a+F7G
 x0A8fpOHjyUlLYrhUpoqHt7EIotoCcVCgXn9we2GFbj/b3cO/a8ZHR/Yy6oS+mu4C7
 YuaqzmwRI1UAGW++H/1vGLxQbowsSYBg5hAiCBMHgcCJVy4HoaLt00o6jNZqtDYboG
 HvJmOJDEp2OLG86Ty95N1yJ9xN4q08Buf2GH/ENhOlvDAMmZRV+r6pNY1/0GCRUiqW
 4F+SXyisMQk8A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 6C35A48258;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Mon, 09 Nov 2026 03:57:59 +0100
Subject: [PATCH 2/3] ata: ahci: return the last LBA from emulated READ CAPACITY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-rk3588-sata-fixes-v2027-01-v1-2-e54ca8e68f18@pardini.net>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
In-Reply-To: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=TpqtpTeordKsp8pC6pBN2hKI/3qXUwYzN0QB8smmshU=;
 b=owGbwMvMwMVoHWf/eN7xty8ZT6slMWR9NNu+MUzaKeyqY4/lKqnCsARzPbsXM5y/P0+f2Pgk+
 omtrPGuTkZjFgZGLgZZMUWWNRLKPN/Wvzp1x6NjMswgViaQKQxcnAIwETkV9v8RZfaXJnP6K6ed
 2rFq+xXW+4uNGK9z3jPxWf8pZaeK4CW3L27Jd6O91pY9qTgSr+xTE/gp8YzH6ov/F4jMvzq1OMt
 VdvJPjjoR/a+yche+a71U+1RifHXj3eLdYqEqk/RW+9Y7rr91IdmzuLUn6czRTYsyLDcHp0UJ60
 2vn8JxtszGc6Nwxf+X34yDeyYKGTPKvZzq8Mtycb6JWx5H/UX+LK/PevoyL1SMWm2mHgwv4Iksb
 baJy7gRLmSg8eV2WejtVKGm4E0O9ZHvWB+b5O0+ws0tN2HF7KICma8pXapN4ZnPFDWr23iZ5kia
 RG+If21lGiz6bo6Dc8Bj6aOTU9+6vf2/2bWIMfMOR8l5AA==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 04:33:56 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: ricardo@pardini.net
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ricardo Pardini <ricardo@pardini.net>

SCSI READ CAPACITY returns the address of the last block, and since
commit 5f7c06bdc3c6 ("scsi: fix disk capacity too small by one sector")
scsi_read_capacity() adds one to get the block count. The AHCI emulation
returns the sector count instead, so AHCI disks are now reported one
sector too large.

Reading that non-existent sector ends in a 10 s AHCI timeout. With
"ums 0 scsi 0" this happens as soon as the host looks for the backup
GPT, and UMS exits.

Return n_sectors - 1 from both handlers, keeping the READ CAPACITY (10)
clamp.

Fixes: 5f7c06bdc3c6 ("scsi: fix disk capacity too small by one sector")
Cc: Julius Lehmann <lehmanju@devpi.de>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 drivers/ata/ahci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 38e953ee79c..c806ee55d70 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -759,8 +759,9 @@ static int ata_scsiop_read_capacity10(struct ahci_uc_priv *uc_priv,
 		return -EPERM;
 	}
 
-	cap64 = ata_id_n_sectors(uc_priv->ataid[pccb->target]);
-	if (cap64 > 0x100000000ULL)
+	/* READ CAPACITY returns the address of the last block */
+	cap64 = ata_id_n_sectors(uc_priv->ataid[pccb->target]) - 1;
+	if (cap64 > 0xffffffffULL)
 		cap64 = 0xffffffff;
 
 	cap = cpu_to_be32(cap64);
@@ -788,7 +789,8 @@ static int ata_scsiop_read_capacity16(struct ahci_uc_priv *uc_priv,
 		return -EPERM;
 	}
 
-	cap = ata_id_n_sectors(uc_priv->ataid[pccb->target]);
+	/* READ CAPACITY returns the address of the last block */
+	cap = ata_id_n_sectors(uc_priv->ataid[pccb->target]) - 1;
 	cap = cpu_to_be64(cap);
 	memcpy(pccb->pdata, &cap, sizeof(cap));
 

-- 
2.47.3



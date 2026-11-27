Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAB606A332
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XHMjhwvp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODEixYdP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7DCF60AC4;
	Fri, 27 Nov 2026 13:25:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xm70NdRa6ZRT; Fri, 27 Nov 2026 13:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C0CE60B11
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785954;
	b=EKKe6ak+54B26nzgulul/2Ut/L7aQ4MpzQ+C2Rf4tE1jMd72xltLON38DNR4nWuAOkVC
	 8D5GDPo4+lUcZINsTSePBzVlOr4YpKUzyq7eb4WW3IsiLi4zf5zWLtqRiP4I1/ZKY4gos
	 +2Mn1Oi2zKGQ9CrPabH6kDskZ9CoF4Tn2IW8y1VMmVaPCg0pXjhqTyqyH2Bm8i6bqXzdX
	 mkZj572hP6isXrWRUpeJlFRHvVHrC9CgQm8VVnUfqB2I8qNk0OIxBSbIUc/gpltPqgYJc
	 vk+PuXWOqvE3P3NjTJh2u5SlJFW/hq02RpeQ9uu0M5eIzad9DR4w5GV824MykuM7TQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=nbS5CZdAcdYAV6LvtGEdyMQwwhaCFouRkno2EhRik3Q=;
	b=eh5tv9cPKQ7Cgsx+uiKVwNwfK7c4IvoqO3RD7kOBw8rI7UKtlrbTgMsh45y1KrvWzA6J
	 2Lyv2YHwseV5kIvrSvx00uCRM3uq6Iq32xIV8I7Q1KS9R+yABui4ibv9QPP8//mQiRUda
	 06MKeVltVnpy5fa0uBx638WmU/40pJrNLcYRoHhj1Zr2Y6FGhEc/LDS4D31/1kgTMVl2F
	 A6VsSDbJgYjbdQx0mSSueFeT2Jy3IF8tzBqF/JEgbzsyNagTkMp+QPx4gI16MtfOXG/Gx
	 g7EycpM5wzLw5Z/dsBkCnGNuZKMX6m2z3ZqLvoiiCEwCpf5hCRofRe/xUJZaVdsilEQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785954;
	bh=nbS5CZdAcdYAV6LvtGEdyMQwwhaCFouRkno2EhRik3Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XHMjhwvp3V+1+Yk0dJYHr0UHBatpxxKb2u8XPeBvNDQlCTXFJYyMHrYfYNbPBb/Xc
	 3lCZqvuULxar/l1MczPg7UHm9cO5+ECnN4ZQXUIea0jYHzCbs+/2uH/m5mENgOA3RA
	 elmC9Cy2b3V4AWaeF848voEHNhVhVTu9ytowsWNYe2qq0zcC9+XWd5WTLOEwhTzLJJ
	 R66j3dkwaIMvFAzZ3Awl6p6EtjZDcHbJYCF4UZ5XVkLshFxOG9px3aAZgIms5o0k/q
	 oiNXodwcvsjAm1dpvOXPSyih8bG25VAiyw6naOExcd4K0Uk6dvSA+FcpFLcrwNYd5N
	 Qj3eJ6dBlT7OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C0CE60B11;
	Fri, 27 Nov 2026 13:25:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F334D3D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E50DD40571
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nt3R5LOqV01J for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 14954400F5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ODEixYdP
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 14954400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB32A621AA;
 Fri, 27 Nov 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 673571F0089C;
 Fri, 27 Nov 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795785255;
 bh=nbS5CZdAcdYAV6LvtGEdyMQwwhaCFouRkno2EhRik3Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ODEixYdPIxqyfuHGXhwC2/Y4vgM0n4mGCQ7RHuv7+FGDgoQlLxb5dCW2cV5AnR76o
 2a03M2/MvQ9FhS08J3KpjGf0lI5maFN24FVLYVRbMtV7U1aqqQYlbzwDBT/ImIedjp
 Xtvxp1bLmKv8qPtxYlgh2ZWPTOaOAtW2w0ng8fZxEndz7Ei7vqmjDcZemk+QT1LRQZ
 xKjLs6EIwSwb3XeANVyVAFpaLmGMbX831AqUL8ZcQu1gB+v9vyy/QphTUM4Fz2tbIO
 ysr4LJCqYDgvVd2exMBdS4xS3w2X5Iqf8SAaZw8KFBmBDEoIC2s5DAjmDHcot6T+yg
 WZeLWpwa9T2nA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E88244B7EF;
 Fri, 27 Nov 2026 13:14:03 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Fri, 27 Nov 2026 14:13:00 +0100
Subject: [PATCH v2 3/4] ata: ahci: return the last LBA from emulated READ
 CAPACITY
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-rk3588-sata-fixes-v2027-01-v2-3-dbdf7770972a@pardini.net>
References: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
In-Reply-To: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Heiko Stuebner <heiko@sntech.de>, Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=9TIiApzFn3xQtzGU/fV7KRaSTT+cb2gTL4l52MT6QlY=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBrCYIa2sv7PQWFUDvqq7FQRJ1X8BXafGqvUCpsb
 fhOUI3YlbWJATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCawmCGgAKCRA7Xj/jnsft
 6eWJB/9Bl6kDQkGdnELraR1J0aAJI83xCH+5LO8CKlqrj/f5SoqqqKTtXgd8ZCISfNMiQd/l77T
 Ml+FHNWd+SAa1rn4UKQID3djbnRZ6oa0SmALHcLF8UmWIeXss3m+IlhwHKYvUwFliVhbpj5Bqcs
 MiSATZnca6uB6eWzwcztJUxxYi9XV2R/IJWU01bhev6xiM2wlE7fw+oFlnXcoYlL6gTjuO5lNs+
 kCwA6fvlNsWilR3mv64DQqv9lwdqmvco2MdfawAvX+QMVanNdgtpWbkFBesMsRSgJ6W4KX10HFO
 WmHnes/BNv7LZmC1ggyTZXwM1QvZzN1ivTb25/4uBRlbHjMp
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 13:25:43 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
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



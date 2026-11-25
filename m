Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B9606A32C
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YYISBKe7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fu0KvaPM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD59F608B6;
	Wed, 25 Nov 2026 12:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCV_kFe4mUI9; Wed, 25 Nov 2026 12:43:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E990B608A4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610595;
	b=Uac2IOf1D5Cp8tXlpCzL/cd2/TZ7l/sjkIJdMklIfsScxFz3k65C6AkoKv6SZi5xhPiL
	 zwa8F//yRtCB9iDoxpU/flhYKqrjy3g1gBM/wqMBwahO/umBwgiu3yiATmbPlZE6Dlyok
	 iXN+I4/JUvIBkFvijbT7rMcjoUNyFkywDoR7FTieLt6Q3683iekbDswLzS4qadp22ZZpC
	 PbNv4oW1AV5VLM8Ip7IhVOwCBS0n+5Egbq9Y528QZzspx1RtpkWWytaucau1xEhuss3vL
	 p/fuT79RFWzc5vB7uZ/jHPKqVg1Vt2IdfrJqZdDeEKDX/svPQdtofBVq5Bhs5yLOD2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610595;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w9MN85mbtD/R4qaDzKDUQgMCfbcpRsy6NBQooABWbhM=;
	b=QbrB/iCPs60rxlrxHSkBe2bT7/RHnCrGfSlt/zWc/XiWU1e1n/t6YM1OywUOxSkqteFz
	 anXPCOlL/v/PjDQocbTmItcs9GylZc3HVfY+DRIihxLKFc3RpAzNNGv8EmmI1GcV3oXLj
	 9S1rTKh1SxAquiH6Fkd4p8UqjhaaeT9ASvMx8Ma4zZR1NefhHUzfwC94lEkc347A6Jt8L
	 sVfxPLfwUZ/WnRXrdcifvSZVG9qNs4ZzW/d/nbkG4kTySu7S3DCD+lxFJfz2VkUq6aT5Z
	 mLFkynjKkYf8FDAzM+Y91R12FEvkmsxB4WGCDviL3TVwbCbsRHnLg/VqiSnCDyOHS8Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610595;
	bh=w9MN85mbtD/R4qaDzKDUQgMCfbcpRsy6NBQooABWbhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YYISBKe79EU14jsR1t/gEodGI4XtuVlvmPszvLntSD8/iz4LNGzrDXEXMGj1trPpf
	 gfUqeFCSht+2aywDEx2XzKL6waPfFnTSyotlGA+3MUJuJx1nIuTPk2rcQjx5EEhnxB
	 gVKhg6b5DjdGJUIzVbQ0KbySLLkN7MsdE+PpPGlKuU7v8oMXwbXjLffL24ieWvTE+J
	 aPWWBbg0xQ4BhwQjFifgatHkagovcWnq/uiw8xOGqEIUkpEa/qlZP6xpOQIF2BS4Fb
	 kE5hoeYJ9iGUJRwS6Nwr8eH9SD2GIy2/q7d28WRDPl5d3QiqNmh1THwoAmsS/2pLFx
	 Zi9AhuCQsByrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E990B608A4;
	Wed, 25 Nov 2026 12:43:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FEBB1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6205A405C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlEpDMWokYsE for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75627405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Fu0KvaPM
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75627405BA
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so50995415e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610586; x=1796215386;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w9MN85mbtD/R4qaDzKDUQgMCfbcpRsy6NBQooABWbhM=;
 b=Fu0KvaPMmLKAhXdDqFgfaGeT8iFSAy8nDl1dSTMtWcfW2py5EHryOfTARnyIZw9mQP
 naYFi9WYXPml/ZV0ukEd84yfgjL1MW/NPoQQA2VpoILrmKg5Nor4kI1pm5VY6wbxFF7n
 4HpVJZvXxGfQOzbUlFl/KXS8E33n0U550IBy36Z2jazOYnh8l09h2UEOlRI7gmybTY32
 1I3FRtp44h3WjNYtKu8YToP+cL2yaQF18vMAEshgWR4TuHVqk03ONzwadsjEHZ19B4nr
 w+rR3OqC0ZbwgMas2rgdSCV1HpW/0ZdO9Wr7wYoX+u23a5n4NwMpvtBwVVtcKD5qipFA
 HhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610586; x=1796215386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w9MN85mbtD/R4qaDzKDUQgMCfbcpRsy6NBQooABWbhM=;
 b=QeXqD66yyFdxRFT6e7tfmKSEmf+04InOMOTd2UY065doz+SfoOz0ZZ95rFY4PahOln
 N+wwwsTDE6rERgWeF6COUjyuFTbqfYNM/qj9h4d/VAgsWpfARUImB8WTVxqAAiRWLVR4
 i+PNo/v3g/Vw6KrH9aVp/3DDsnA2CArKcvSvEPDWEhVT35VKU21H4tLyfGp7bkSmwqwo
 G2sHGNOLcz7gsOLc6QXgOG9Km6vIZge/GBali0R303UZA4Ks/R4sLDK0wESDMOBxNLgF
 8BijzRms9tqLGfSq3W1iTq4yLD+Yiyi9Qrr9Mc14FbV3enggCOWcAT8vMZUj6R+bZbuN
 IzmQ==
X-Gm-Message-State: APuU4Z+n5275Bs8o0w/roTbVJVFnyf9Ri/ieW7M+QoDRs1u7iWAqLiAV
 O6lQGiVbQ3D8anbhfYqkPbrWwwjh5u9/6jQnhIUvSNIcjzoTBL0DD4GN76mpMu8Q
X-Gm-Gg: AZFdTZcODacrxMnqIZ0EsuqlC1cxhBqGgHHj8KlIfqk2tByEKZkfSm/CQqNZr1JYBr4
 KGj+nPGxzV1ZKW2deDL2+0ByevEgefT1X0BM+SPRl8jJz1NWkU+VbJjh0PjZEtpp6dItYRiFQ2d
 +ccAz4BeFVtFJeBT67c61696OW0JmftLpW6VkC4WmkfM23aAvFx97ZItSvnYCkpbCqiZbxfJczK
 DJCa00KYenPh6EEYBVSqnwcuXAnw5HznbUnFr4bDmnLG3wlOr0NcgvYTUCfLb8BmZEPwv4xr7nt
 QeMmtEz9lMl59PQwF/o6HlzfQWgWw6lQU/EqepvnCTgSA/veVLE+3LuNND6cq6PCOa9t8hfXcWX
 uw8hJi7uknBFyeswVfb0/mduEEiWHAoX4FNqeiCLn62o/MEoXg7cZHcKrtBF6PrxtbLVu8pPcci
 UnV7oaCKdKSWH5DfxDzz1ntmVC96xm84TqRPoPyR9loejumhNUUxkvUNNQCCz0i4JWRsvHNHBb1
 7KIWaXZm/0cm57oCmOmAMBBFBv1TBAyt1gu3cVMJA3+npGdXHju5eUf5IbzmwPlbQaZeKtSMlJB
 bq32G4dewgTzD6Pjv1jm8Fk1f3SEPvvgKL6YfWkPN1keqU79VC7QCVr7TiR1nQlNoIyTbFLNj9L
 U0zc3p2JiPfGLUOAhyPkE1pBrG+3olr9HV+bnMby6VpczN2YUgyTF13st9A8ETUgstYQgQtEoPg
 nZwAS1eA0ITW5nz+DxwmMSRzccgq1lJdsHZ41FrN780l4g6FKHzJ8S1FA=
X-Received: by 2002:a05:600c:a11:b0:4bb:69f2:87f7 with SMTP id
 5b1f17b1804b1-4bb88812c92mr373558055e9.18.1795610585887; 
 Wed, 25 Nov 2026 04:43:05 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:05 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH 3/6] mmc: Use div_u64() in mmc_berase()
Date: Wed, 25 Nov 2026 13:42:56 +0100
Message-ID: <20261125124259.95636-4-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With CONFIG_SYS_64BIT_LBA, GCC turns the lbaint_t division in
mmc_berase() into a call to __udivdi3() on 32-bit PowerPC, which
U-Boot's private libgcc does not provide.

Use div_u64(), as the remainders above already use div_u64_rem().

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/mmc/mmc_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
index e739720b77c..ce0592aa659 100644
--- a/drivers/mmc/mmc_write.c
+++ b/drivers/mmc/mmc_write.c
@@ -126,7 +126,7 @@ ulong mmc_berase(struct blk_desc *block_dev, lbaint_t start, lbaint_t blkcnt)
 			blk_r = ((blkcnt - blk) > mmc->erase_grp_size) ?
 				mmc->erase_grp_size : (blkcnt - blk);
 
-			grpcnt = (blkcnt - blk) / mmc->erase_grp_size;
+			grpcnt = div_u64(blkcnt - blk, mmc->erase_grp_size);
 			/* Max 2GB per spec */
 			if ((blkcnt - blk) > 0x400000)
 				blk_r = 0x400000;
-- 
2.54.0 (Apple Git-157)


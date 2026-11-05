Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA9606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RPIE+4eO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kykm4dZW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BECE78115D;
	Thu,  5 Nov 2026 13:48:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5uQu51j6xiV8; Thu,  5 Nov 2026 13:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEBD081160
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793886481;
	b=mQM9Wte7rDBPavQQCd2YbnS8wO6UCZ9Tf1471Qe8o25+r5+Jc3GggtAd6EXCa8BDvXKV
	 CgO00JS9M6qNhHYzlsHDjqNx1s4ww7dKc7uv/uP4OzwOmAoXB4cmmnx5oaxsVJvB9NopJ
	 blfcktMLwRzhQK+9NpgpPDBlLNxgzHCIaiE4udFik9G4ekw0aeAnnEHKe61w8LtByb+vo
	 nYcoU4ZNdLHt1vnRpmjMUkWbSlFQCD6NtAGNlKREnpYNGdD6k2d9vsjsJVGWsTpoFnBSA
	 qO07JYaxLM4rGrd3IAtSqHBHNKahKpFD3vG85sV8qLKD8LuVkW7r3oBQbIQP1pRtw4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793886481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ESwoamtcZvHueuu1xQBEv6Q9p7oNkWBusbkRgADhJ5o=;
	b=mc+E9G5R4tPPzsMj/N4ZnzQS6mIj+3qVf4IW90W38Yccy/iIWYbHW6BFEpyTqeArP8fr
	 9HHQaZFWhEmL9tLc/JYemjv58sADpcYXLFqU1ZHUxBzJ/ViVwYKLL947HV/Hx/JReZM1Z
	 YDYnVR+TpIDaFpStT4LP3oMYReMgdUlc2345wmfjuKM++KwCQl8IBDwVdXPHiVXMFUItN
	 V3dmyF88SHEur+FbUbXwb0x0kaFTCcFDYwbraMqFiC51SZjRD26721LTWQatjPoF/vtXx
	 QANdH4or6x8mdavaHOYPfb8orabbYWhofXBdPA2p+ajg7atSxQwcHIlnLZ+hCTE4Meg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793886481;
	bh=ESwoamtcZvHueuu1xQBEv6Q9p7oNkWBusbkRgADhJ5o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RPIE+4eORnrc/tg6dHfs2K8u0DwCKAF0kUnAKHkzdhhiz7J+IzIR3wJi/fKkPwfny
	 A+9qAUoTg/swt1SKFz/wfBwC1ZLur71ISEpxq/ngh3iLqZjUuUrTryxvKnNGPaOOf2
	 FhMW00zhfeI9T0+hLtc+h81mijsjVcdfKL0Q2HfeYasLUN1WpaIRtsMCcrK5a2HIUg
	 nipCIUOnfUo0asajQwW5K53EFtrXDIfURNFBi5SkMuEKaJyut2cNJmbZB7o0QRHZwY
	 EKWrpkw+eev1pjHAc5VH/UPrHtzrPLtdPXqQqPo/n9AE/I+Fw7YvEaqOazF6DpDmlt
	 WJMCIM4XNlm/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEBD081160;
	Thu,  5 Nov 2026 13:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2839F2AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 13:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 198B5607D5
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 13:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frhjWUHvrsDI for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 13:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1038A606CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=odeschamps.mail@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Kykm4dZW
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1038A606CB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 13:16:14 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so575748f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793884572; x=1794489372;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ESwoamtcZvHueuu1xQBEv6Q9p7oNkWBusbkRgADhJ5o=;
 b=Kykm4dZWoaXEKGMgDKwSfis1ejxCS/p/VoxbVyt39EqFh+BeH3eIWRsFjDGDkHBUpO
 8uFSXGbwH6EtCMAM6H/R9m7Ds6h5cMtoe/VPfXb5nrDQ8EPzHE0PMGyTCPdrjYXyTqcb
 2hxMmoVVNOQyGMrQlTCa3xEsrDGTz6P/nVlpaZCS/eZ+FTN2I5keXyvqAq8uiwX7M1JQ
 bkIhCru0+jcI5VA4SpHQWFnyDlqSrDObGbROnmYX7RxV3jWFzZ/KfvZXhG7Su0bFyIWy
 zqI43eE+LKHZ6untbSjMd1m+aSRpq3iXVkhJuoF8YYHL2QaSR3zYT6Kuy/HtDEea5Aym
 +rUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793884572; x=1794489372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ESwoamtcZvHueuu1xQBEv6Q9p7oNkWBusbkRgADhJ5o=;
 b=WY91LC5Vj/H5ITXjQB8yNYHyGKyWEXhMPXcnwu3/wllnNu4fj0u8Jqkx0yvDze0C/H
 xOS6xUqG73a4uiMVf62sV5SCOg0uDwUrZGhB+3vsrmoynPgKZVNv6CgD99Fjt8HbswMB
 FIefAdWVE59GDbp/ZgLQI9sR10eUmtS0PPemuyB20OQSqOL53+kSqoHbNtctL5DGD2nT
 6zMd8bhJkTv96MUpMgenuuoqpWc62PAIV2WnTmg2QBKsMqv/2AU+E/p2fF9K/WNRKYDD
 XmjEWeFjqApXo4I7LHks4Th2TPrLdyuF5IGjBxnrTWv+7Vg2zv7Rd7TMWXvW3F57HnnK
 pPow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMRcU4HDGpg4UG7WC/s3khy51JrClVDHZdQEyz1HgumsezdhSEAEsK8Uev5MY0NqfpPxiz83Y=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/WMhJVz6XOe2fjhuHh7NVtpk7FnL87b7t2Dq1hJdt1HB3dn46z
 hDuB3ki+S05mVQ9v9PN647WEIOz2g1AjdVlc9/na/XKQlhezbCF5cU2D
X-Gm-Gg: AYBFou3k4GbvQS4PuCyqQB3rjjCABf8ezRfSG9+f22CX1vR1LAZKmTcDFPMVFWiYOc8
 K65zd2kjr3Halq6bS0WM0mUoESehHYVgPl7mILVfE1hnpQUSaqmjXaSp8cVsJvl3bm6/e4Ztk9O
 kIJWkd//vKGM4jcHBfbtO4fH+6Ol390VZ/5O8raCfGvIcKeODPxjvn66iaeQ1ydEn2pfElfBuDZ
 Tav0/liq8xnw4PFK59HFCIAYwzpeuAzNm6RjTV1gjxAzPl8e++k9ykzIiwX8f573V341gSQHz5V
 0XQOmNO1VRgle/G4OLygAPwvtgNOkbCnIZKaCaJ0bhPPVMfiOTrd/o5i+r5ly+wdY4oWRj7LPJ8
 WH1MfjrltuJTaGERPZCDgxeUiRcK+IO78IMPqgmHUWD5W1XBXMh+2udvAB89DUB1kju1EK7rj0Y
 O7XfTvHGc3xXhmvwfCPy6YWQRYbTMUH+M4S55eNP11mh9yIqtb69q0k7nDWdXCXxO4s9ABcUK/7
 b9UNdv3/8lFCEkPyW6lAa2oXMH4nKsqslMrby37Tn8J/eB6E/l2Hn0WOPJ/9G9sANBrlbIulA3w
 YqE6q7MgZowU+GtwriJLgGmk5jBGPteANsuq/UpB1Ey+GSLq/8bbnsH9swU9d2ldNm7Pl9U=
X-Received: by 2002:adf:e199:0:b0:488:8347:a110 with SMTP id
 ffacd0b85a97d-491153f604cmr4767502f8f.7.1793884572143; 
 Thu, 05 Nov 2026 05:16:12 -0800 (PST)
Received: from test-Standard-PC-i440FX-PIIX-1996..
 ([2a01:e0a:ee9:fa60:be24:11ff:fed1:a152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda1ffdbsm9663470f8f.50.2026.11.05.05.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:16:11 -0800 (PST)
From: Oscar Deschamps <odeschamps.mail@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Iqbal Shareef <iqbal.ams@samsung.com>,
 Manjunatha C Achar <a.manjunatha@samsung.com>,
 Oscar Deschamps <odeschamps.mail@gmail.com>
Subject: [PATCH] fs: ext4: bound extent-tree depth in ext4fs_get_extent_block()
Date: Thu,  5 Nov 2026 14:16:01 +0100
Message-ID: <20261105131601.1854572-1-odeschamps.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:47:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ext4fs_get_extent_block() walks the on-disk extent tree in a while(1)
loop, following each interior node to the next block and stopping only at
a node with eh_depth == 0. The depth is re-read from every block but never
required to decrease, so a crafted image whose index entry points back
into the tree (for example at the block itself) keeps eh_depth non-zero
forever and the loop never terminates. Reading such a file from an
untrusted ext4 image hangs U-Boot, a denial of service reachable before
any authentication.

A valid extent tree has strictly decreasing depth down to the leaves, so
require eh_depth to decrease at every step and reject the image otherwise.

Fixes: a1596438a689 ("ext4fs ls load support")
Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>
---
 fs/ext4/ext4_common.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 9e1d574e5b1..9eaade545a6 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -1539,13 +1539,26 @@ static struct ext4_extent_header *ext4fs_get_extent_block
 	int blksz = EXT2_BLOCK_SIZE(data);
 	int i;
 
+	u16 prev_depth = 0xffff;
+
 	while (1) {
+		u16 depth;
+
 		index = (struct ext4_extent_idx *)(ext_block + 1);
 
 		if (le16_to_cpu(ext_block->eh_magic) != EXT4_EXT_MAGIC)
 			return NULL;
 
-		if (ext_block->eh_depth == 0)
+		/*
+		 * Depth must strictly decrease towards the leaves, otherwise a
+		 * self-referential index block loops here forever.
+		 */
+		depth = le16_to_cpu(ext_block->eh_depth);
+		if (depth >= prev_depth)
+			return NULL;
+		prev_depth = depth;
+
+		if (depth == 0)
 			return ext_block;
 		i = -1;
 		do {
-- 
2.43.0


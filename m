Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AC606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eHRbdJwD;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=Jxk2Hytg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 746C3407CC;
	Mon, 26 Oct 2026 17:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8kbX_1izk8vW; Mon, 26 Oct 2026 17:34:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 277F2407D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036092;
	b=ldHDbEambeoTO5PZ0KRmw2pNAvZg0Ki+O+pJpyLCGCT5HqZZCtVtZBgjifZB04amZzVB
	 Vl8KJveHOg3Juf+vpvcvaagoGFZ7ZimXzDNNCCIC8RbvPNKyECBOD7oGG2PjcAPLvAIma
	 Hkt/tSNw7QpB0ov3cKoscGwTHQhzhf8o9UgBtLTb6PORLo/ph9XuZ/4Q/sA+LcGKn0qsS
	 z9QTy/6LZJNLKV+neZVEaKtfEOnwQyeJydHcbLPCDqk/17Xd21kZNUq9/cy3FEvz9T2nw
	 Z9TvaHUFVbMRg9RK+BRby8WuN5kSamzsl2uQ0sPjbTrM4biMofDuJG7YiLh7VL5YLXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Flowmailer-Platform:Feedback-ID:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UsYYAxCC4JvMyPeSVyIbjlbqTSQxYioyyX45FRhZSU8=;
	b=VSP9/2++CGgm+gwACnIRT3EIxTu0X+qhtV2oc3z3xLj+Dz6NUcl+b37YYphcmFlZQcA5
	 9JJuHHojqTBtrTSbNlX+qIkYgHO4NTCBJXBzEUm/xLqqh+cBDOyn1W4rbIVmPYJOUPAth
	 RMkaOymXj0Az3aM/NpUGhMCdun17HSeR8qZ9+qYkxFjQ7gZaSQMn1+HEzhihugLnAU56i
	 ZD9qaeCZFSa2GUWVp9RT0tZN96GBXRIp2wSu/Gm6H+mBa18+jBdqIJOLUgNZuptA7vQKz
	 Czeok4EQmKL73BnVPt9jxcA4Gz8OgN4GKr7dQ1xG+s7Oqfc9kcQZEtkU8xCZ9vGU3lQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036092;
	bh=UsYYAxCC4JvMyPeSVyIbjlbqTSQxYioyyX45FRhZSU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHRbdJwD+Wk3AI1JXN9k3c/9+VQ9Ue/U4cfGDMCj4G2pUe/7TihnGKlXnhBfGFwEt
	 pKuJu+LcuF6Ot3EuBZPsLDb7ZE/Jq+4zdg79Agy7oh2LOoDLyE+Mzo7VISDFEn9s4+
	 CNOax4G5NSNI2HLNITG58rHFo2EFlgd/JpNPLEF7ZgsNC3mqcouA7BHrdcZY9v5Pay
	 kF7oGQXbNAf3aq7MMt5GX454UgDz0IL8UY7oJeOmMw9sNqIDshr8QgK+eLs9XlFMeD
	 Y0d0ZDeRA9HAcuHn372v8fn+nA62a6wyoEZw5qv6KTG7nOrnztB2x8EMXOZ1zwQoMV
	 /munZWe4hvZ2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 277F2407D1;
	Mon, 26 Oct 2026 17:34:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E8843A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 345D64022A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id levvw-uLsoIU for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1E1124020B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793032687;
 b=Aq8MElAY4LI5OSdXjkv8otvcw+QhdaV4G2YSkCZQnru0DNKkkjn59hAQxTlxgubKhVtT
 U6bKRRyXZV+KGR4KD6tzJKn4u1tQ73pt3IqipIDYpOiorQ8kJ+LHk0N7FQ3pKFJXtdzda
 wgHzcZFgMTcmPasvlmrwqEIbKn116oDIb+6BtiUij8FjN8ISFQ1dAFq7xzO8WqhydakSK
 wo6pl7NqQi0y0i/RKAtDorSOQC20dXcLTuhxqxihYK9UyyQGlvbVvv1J07QooZwph9hx1
 brW6ZySSwlgEz1K21ZY58v21TqqfpiLMat3XQp60cW1Z/S//9aTohgOOdrovjIMA/6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032687;
 h=Received-SPF:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Flowmailer-Platform:Feedback-ID;
 bh=UsYYAxCC4JvMyPeSVyIbjlbqTSQxYioyyX45FRhZSU8=;
 b=HNPu+eaeL8dBmsOsdXLSdDMzpLzY3hOJp+jpyY2kP/i4e7EvHcoOv3fXhiX2x/xbwQNt
 72ymhmPm54+XZmTm7S7bcQI7nNVcfAThAaMmcDr0BbwFvCemWPgaCl3ZOhbq0WGC2dg7m
 WCcsbCKwyrmAze1W1xXqSNSsaIsfgN8dRvsLAIMwHmSfo+uVk6gn5a/jplN/yRBITm/rU
 wJdF7p1oUArwByFXXgOys2kynAi5AXexke/9BwUr6iOKSN4TDg8Q5EB2jHiF83+C9pdWm
 jMzAn8z9yKGsCNeioc4RVSGl6WZqvzwEr/GRLhn/4IB77c/vgBEwfNovvWd9wU8jA/w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=Jxk2Hytg; 
 arc=none smtp.remote-ip=185.136.64.226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-1212295-202610261638028dabad32ad000207f0-cnc1wr@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=cedric.hombourger@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=Jxk2Hytg
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E1124020B
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:38:05 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 202610261638028dabad32ad000207f0
 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 17:38:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UsYYAxCC4JvMyPeSVyIbjlbqTSQxYioyyX45FRhZSU8=;
 b=Jxk2HytgPd0xQwTWbs0fqGMXYIQhlB+RwyArDi/MOvHHs9bojaUZfMFNaoIM/1u6CSn7LG
 TWOLpL+ximTah6OxUYXwIuDgCOPZAKSFIJlhBTdgvGs+Q11sGqweb0c5NwWOmqhjWD3+0E/+
 CeexryjNo0UKFzTic6nOWsrxe/jK4rH7q3GJaGBtb+xkV2Z7kX7s8Dm9i4VvKgkanLqXuWug
 NyDEd6sDDCzGIoo37rur5boJVhMI8/xzuESml7MEK6Eiagq4i5ngV0DkVyZVBwEqub8BpOJ5
 qciz1/b/xZ8EHii54Y0pk8iqQ2q+HiRcavY4+XEr96uweiJCqfNnj6Ng==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
Date: Mon, 26 Oct 2026 17:37:26 +0100
Subject: [RFC PATCH v2 3/3] efi_loader: do not trim files in Write()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-fat-fs-fixes-v2-3-41ae696cd353@siemens.com>
References: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
In-Reply-To: <20261026-fat-fs-fixes-v2-0-41ae696cd353@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Cedric Hombourger <cedric.hombourger@siemens.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Qu Wenruo <wqu@suse.com>, Alexey Charkov <alchark@flipper.net>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UEFI describes Write() as writing the given bytes at the current file
position, growing the file if required, with partial writes only on a
data error (EFI_FILE_PROTOCOL.Write(), UEFI 2.10, section 13.5.6).
Nothing in it allows a successful Write() to drop data after the
written range.

The UEFI SCT checks this: its Write() basic test writes 50 bytes at
position 0 of a 200 byte file and expects the file size to stay 200
(SimpleFileSystemBBTestFunction.c, BBTestWriteBasicTestCheckpoint1 in
edk2-test). EDK2 behaves this way too: its FAT driver only grows the
file when a write goes past the end.

efi_file_write_int() calls fs_write(), which trims the file at the end
of the written range. A write in the middle of a file loses all the data
after it. For example, a 256 MiB file written in small pieces ends up
with the size of the last write.

Call fs_overwrite() instead.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 lib/efi_loader/efi_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 7dee57d594a971572f09c6b6be6727a15acf0f77..fdefaa1b0604d5313f8b20f3d31f477e1d3e40ed 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -686,8 +686,8 @@ static efi_status_t efi_file_write_int(struct efi_file_handle *this,
 		ret = EFI_DEVICE_ERROR;
 		goto out;
 	}
-	if (fs_write(fh->path, map_to_sysmem(buffer), fh->offset, *buffer_size,
-		     &actwrite)) {
+	if (fs_overwrite(fh->path, map_to_sysmem(buffer), fh->offset,
+			 *buffer_size, &actwrite)) {
 		ret = EFI_DEVICE_ERROR;
 		goto out;
 	}

-- 
2.47.3


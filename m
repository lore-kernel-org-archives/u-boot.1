Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7155606A330
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ziy3OFxK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PI2Rn59q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E69A04063A;
	Mon, 23 Nov 2026 04:03:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJnB8fMP9chV; Mon, 23 Nov 2026 04:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9B8A4062D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795406615;
	b=ebnXAxBPJ/ZaVrfzesnrSNAfXaQc1M26jibgaUepsTqnWQJ6UUww95BB8FYqcYuPtql3
	 lcbyoU8UH5d638gZ7YhfWTr8969hq1POqZHdggzjwK/n3yx4bblGlaKlZC0Ktt+068Ygi
	 GM3nkI57rXxsUqG28EhuV7TcGlfLDrwoBGFhsnzIFeHWRlN1ypfJQ92IRuK6QjwHD+LuD
	 xBICKFtHMqWdnqa+s4JetAlFWUXjrK4JwA8MoLcKEPWPVxQZykEVQaroWTZZWN7+j7biJ
	 p9BZ2xgoeB+brhXqW6SdbAwWeiCVNwZI8PWocOy/Vo2GpboPpMgTu84t14G/mVGn6Wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795406615;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jx/gOdnVmoOW1OhGLN6pVIh2UGDzpQaBrr1m/ymjOXg=;
	b=Ia+wvu5Jo2YZ+5/wozNpb3I042dO4ngVj6Pbhy49Xe3RDArMl1g5YIR+qt634VkKWYBY
	 mWLqrc1vzWY2iLa6pIiaIWD08YCtoz8tbrKbOircOnm9rl6DjUA3tJOwH3LjwvirrxTj3
	 Goyfz3FLc4N0WbtoFcYokVOVEUFNwZdmmE3nFuoskwl/vTw69TqJ7hC3p7YyIOksthGiv
	 vKQEdXMmpLhpTvqAizXA7LsLw0/LCrrm9L8Xl3b4utr/2EfBR7VPrJJRvJ6fFx5w5jksU
	 XUJS9YgrPb13R4AkER9tg1e/QTnIXzgA2oVUZr0ktgvP02+wWGCfw6bWfANXcxZSb8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795406615;
	bh=jx/gOdnVmoOW1OhGLN6pVIh2UGDzpQaBrr1m/ymjOXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ziy3OFxK9PshgvlM2hKNT5ozqnYsbd61nhVYnCUjAi/n/QOouXh2Hg1++UeXmVFFY
	 K1u8OccEBtd8B9gz3TxUg0mRE/pCbSP8Vx7+yb70mdJScQvY/O83u8yjvmnYQHiqRq
	 dHS75EPqyeLPZrl3jnNIRibxWEQwAn7ZmnCb0LpWVoXJYUMmLyxL5DaULGzPG1GUZx
	 JnvnxbYYl4kKhl+rLU5XfbhkthGT9AjVRCcUrERtiX7w9kvoLfW9vT/N7mEuHBW6Op
	 1gS83DszlKNxFUN1HBLmISLriM9y0zIm+rUH1sRt9l+3F4XuTUHjXOmK+B9Gjn/Q9+
	 T5RoD2sHiCl/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9B8A4062D;
	Mon, 23 Nov 2026 04:03:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97444392
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 859C5400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUF3UW42mtmP for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 04:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3CF0A40081
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=PI2Rn59q
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CF0A40081
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 04:03:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 591E64477B;
 Mon, 23 Nov 2026 04:03:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D853D1F000CF;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795406610;
 bh=jx/gOdnVmoOW1OhGLN6pVIh2UGDzpQaBrr1m/ymjOXg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=PI2Rn59qYDFdVePtD/KWkg9Cl34Mmh4QOIqd0GTka3l6GEh4DJk0Cj8nl+oeNlmNK
 a+n8RqTPl84ufWcNRaq7Idg+iZPm2cP4OTQJZl8E7nlrNsS3HwDWooojS0X16WeiKc
 wO0o7UTt+HWvbtLBpoMznhhbvpVJEY9tjk1AVRznh3u7MbUW1Ko9gQZEm1dXMSFLcQ
 WtnUogfF6JFbB19s5brqTpivwIA30KEeRd1kIuHVFqaWK3GTcHtc8zCvQpNd3mf4bT
 LuXJzF37iPk9XDMEZH37lPUTFN/+wyAvXI7JmtojbS7RSN/doEe84MlDLVx7ZCg6BY
 jEilrVWfTWHZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 668E04C325;
 Mon, 23 Nov 2026 04:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 23 Nov 2026 04:03:17 +0000
Subject: [PATCH v2 2/8] net: lwip: wget: accept a reply without
 Content-Length in the size check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-wget-blk-r4-v2-2-073d800a5aaa@iav.lv>
References: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
In-Reply-To: <20261123-b4-wget-blk-r4-v2-0-073d800a5aaa@iav.lv>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=ETSxIbVEcwmENePM4/U6sbJkihZFPwM4HjLMia8Lmh0=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDNnMu9m+7Td9KpzOkWKfsl22YkrwvN3ua3kDn8i1WycvT
 jHh/pHSUcrCIMbFICumyDLhkMatjCVX//p7mD+AmcPKBDKEgYtTACbydj/Db5Z/YUWXGa0cZFWr
 Hwttq+3rNA4V37hw/9440UT/qytbGxkZzh6R6uqaeqmAp0TVqZLpTvgO2aydYg852n135s56fD+
 YFwA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

lwIP passes 0xffffffff as the content length when a reply has no usable
Content-Length header. With check_buffer_size set, wget compares that
value with the buffer size and refuses the download whenever the
buffer is smaller than 4 GiB, before any data arrives.

Skip the check when the length is unknown, as the legacy wget does.
store_block() still stops a download that outgrows the buffer. Writing
the download to a block device, later in this series, sets
check_buffer_size and needs this for a reply without a length.

EFI HTTP is the one client that sets check_buffer_size so far. lwIP
wget sends its HEAD requests as GET, into a 64 KiB buffer. Without a
length, a body above 64 KiB now fails that request when the buffer
fills, with status 0 instead of 200. A GET without a length still asks
for a 4 GiB buffer, as before.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 net/lwip/wget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 96ee600c5e1..f0ba9b3d1ab 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -285,7 +285,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 
 	wget_lwip_fill_info(hdr, hdr_len, content_len);
 
-	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->buffer_size)
+	if (wget_info->check_buffer_size &&
+	    content_len != HTTPC_CONTENT_LEN_INVALID &&
+	    (ulong)content_len > wget_info->buffer_size)
 		return ERR_BUF;
 
 	ctx->content_len = content_len;

-- 
2.43.0



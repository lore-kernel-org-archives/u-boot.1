Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CEFC5DF67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D16C28128A;
	Thu, 13 Aug 2026 15:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypZMXIrXlrY0; Thu, 13 Aug 2026 15:57:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0272481247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636632;
	bh=PB81JLhwiWFmGoZEbwCVu+aKL9M+NtHny5NHwMRzxlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iIkZWdorWG7w6pOMfuBjk2DNpC3756/XKKTfkMc9EtwI38KuvI8m7+mBx/eq5q7g8
	 hqhAwaXX0TeFJGIy4hexs3CRp2278jJGezRwRKyPeRkLWNMBsFfT38IFz/6cdx0ku4
	 h3G5H4BHoUWlpKb+5ndilGIz+ff+p98gh7uGt1vCCzueDfcKJMAjfpy6Tvh5PQhDj7
	 MoE5TPi+MHgQipTBeZ6GneN/bhDlLIVHqgpy5Bf+tpE0aJFeTbnQk7nR2wBgtVmKm2
	 3HRknItSXHfKorHKvXg/ce9lKNMJkBb2odRoj7dJevqBkrpDoXMbLZA0HWZD1OTLAy
	 Ku+x+x5pWlq6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0272481247;
	Thu, 13 Aug 2026 15:57:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C42DC1B8
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B60FA40158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6t3mFp-kiJGR for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:48:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D0C4440133
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0C4440133
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0C4440133
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:53 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso3696164a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636132; x=1787240932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PB81JLhwiWFmGoZEbwCVu+aKL9M+NtHny5NHwMRzxlk=;
 b=lmztjuifTec8Hh/Ya75dYsVTqJ1Le0qiCSYrfPLTUIRa5iDZ/zZbcLjZm+f0VbE3bA
 PkIEE6KZIOkI6PEXelnw1kT8QhKYZNW9TU72Zk0/DXKkUiBo+9pjnA7lpzhnQwT8l26e
 3pe7T7GCWHsyfSmDGid22/ZPRh7cTC2B5A8ufN4DyR0gA88I0M069EvBxGsK5proVThq
 /bOD3CyYKZ1ywSD8zc1HxZBzrGOlhDum5JiAzZKaeGq2QTbQF/IaD4etT3ByNX+h1fVk
 HczSFP4AdbVNVntVicWOcOfbaMD0yGFAdGa/MGZxAhpFQxqpm2Z2WBvbnYDmVXmcI/xM
 3u+w==
X-Gm-Message-State: AOJu0Yzt9PZKRue24VXmvtnVeweK+eKOcOv8oFoCLdO8pHmRGws0H+hV
 O6RK02SZ3oULpn7gx5ln4b5W8yt8izoE8udBElVAxfZpEYhnE763sUqJTQSU47GndkY=
X-Gm-Gg: AR+sD13b1nfZFO548CXnUrq0MYSoUhyJXZtTupmrPYZN1d+cHrClNq2u7leqTrQHNzZ
 yTdfSnhAwmT85tqODAzGoMJ3ukXAskZZhMKgF1vUxNVK2W2f0XVr/HNll/LaaIsAFVDBZ9qaZFq
 FlwWerXOHZvd7u5qF2CFGrkGJlr5+C+So1T+cFrtrn0kigUGB6fflc0cxVnoqiHf6CzHO19tRol
 zZInKC02FWcgy4P1xqgrPqcrrY/qmLBdnH9BRG0pLiUyqFbgJ9Nj//jNKrHUVk5IVWIw/PEPUSO
 CAV7nfecy2QqvFrWHO1Djshkd/mciBqR61VquhATLJdTxW3YWVVSqW8RB9sB9MKCtwuWhG9d1wt
 XK9zyPbFQyRspqtiqDlFqJdwRCEbUr1Qqjg8z2XW3B7sVc7s0kUjJV+LXq+H5YO6S8lb3NdudQF
 Ei3KmL/yMhoDPUIARugzSJUQPBW5xt9xy89DtTi7c2Q3o9MYfbheBHPsjNGr8RhwYQ1pA3ZfUqo
 r0AtTrVFef7SctrRtRca1J/NTK8RDd6BC55xROucftQ4P+Ae63u58SN+d9Ao2so
X-Received: by 2002:a17:906:794b:b0:c1c:72b:e65a with SMTP id
 a640c23a62f3a-c210900c3e1mr310916066b.26.1786636131782; 
 Thu, 13 Aug 2026 08:48:51 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d8d9sm8151066b.40.2026.08.13.08.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:48:51 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 17:48:21 +0200
Subject: [PATCH v2 1/3] net: nfs: reject a negative or oversized NFS read
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nfs-oob-fix-v2-1-80993770518e@byteray.co.uk>
References: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
In-Reply-To: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636132; x=1787240932;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PB81JLhwiWFmGoZEbwCVu+aKL9M+NtHny5NHwMRzxlk=;
 b=yiN/reXh7210kzyGiP3rjDgGxWvgxhHrUsYLb7sz00dCSdAv9D12NRDf//8vK03Bwr
 FURLpvrosFQVSPhDofttfgyoC5YSzFYH7ZMHOrfPl0YvadIgHL/8R5jEDmF/xFOFEnCp
 Yrm1u1DH7DsElYHqJfIa1oCBnbg5DhHjmtZeFpotISeq/0Dkgvmf2eFbQBDp9u9Phf5E
 Gm3Zf5R2DKW4pxzaqGmbWTiByLwwQRScg9uEPTND42XyoGXNnSjJe7xsq6Pw0uTzVQxa
 aFmpu8ROn0CqlbRX+kqzUk6yiZNX9+BjFVxfmQ3iiY8PJ+kTiaNDdth07mNsVj7SCPe7
 hDdg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yiN/reXh
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

nfs_read_reply() stores the server-supplied read length in a signed int
rlen and checks it with:

	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
		return -9999;

On an LP64 target the pointer subtraction is a 64-bit ptrdiff_t, so a
length with the top bit set makes rlen negative, the sum stays negative
and the check passes. store_block() then takes rlen as an unsigned int,
so 0x80000000 becomes a ~2 GB length. memcpy() reads past the 1152-byte
rpc_pkt stack buffer and writes past image_load_addr.

A large positive rlen is also unsafe. The check bounds it by the packet
length rather than by rpc_pkt, so on the NFSv3 path (data_ptr at offset
128) an rlen up to 1128 still reads past the end of rpc_pkt.

Bound the length by NFS_READ_SIZE, the amount a read ever requests,
before it is used. Both the classic and the lwIP NFS clients reach this
through nfs_pkt_recv(), so the single check covers both.

Fixes: aa207cf3a6d6 ("CVE-2019-14194/CVE-2019-14198: nfs: fix unbounded memcpy with a failed length check at nfs_read_reply")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/nfs-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 72d8fd823e3..020b0185ad1 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -738,6 +738,10 @@ static int nfs_read_reply(uchar *pkt, unsigned int len)
 			&rpc_pkt.u.reply.data[4 + nfsv3_data_offset];
 	}
 
+	/* reject a negative or too-large length */
+	if (rlen < 0 || rlen > NFS_READ_SIZE)
+		return -9999;
+
 	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
 		return -9999;
 

-- 
2.43.0


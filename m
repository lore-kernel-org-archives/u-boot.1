Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFAA606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nrZ0nl0Y;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WLAIlgVm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05E1880F71;
	Wed, 28 Oct 2026 11:23:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDPHLWZVvTOD; Wed, 28 Oct 2026 11:23:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2A13880F6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186599;
	b=E+VqZjxgFmwKCZQwfnDSugnGC8dRWCjbz46oALYYlZzva3I7vSvmPVa3YCyKKC94BhUt
	 Q+93unZQCQb3GwYVqAMWvt8eVW81ht8wdxu0ng/3SUKyqCwRbul3/o+p70qVhudDu8w9u
	 Ngebu44lPnIAo+0TDmxJd4kg+n3hys10uKEkjtyoN93XAjUppiKS0q+3s+yoig21gp2U2
	 pha5YF9k5VKn9V1zAFSMeJBa1Xv5ssGGSiG/UVmeWiviUUURVWuRxWs5rD/7c5oAYhKIF
	 MusIa/rRMGd5rqf8z22VxhtOYqQXhRLz8sLtZFmUx8+uruEvrB+v9tScbNNmnxaBWjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=z065CJP71LzWefaUrK2ykP0JYytD1B9LpT+E7QO7ICw=;
	b=FauszIkjrg8Qn1PARUfnUMwboodaQkKTcQOC61o+JKUiaVS6FxsMu12/cWsGlb16/O5J
	 dAP77Zl0omsTuJvt68QEZXpMj77SykfTPW9uCUVJQzonfGvdRvg6mK0fqRBdK4Xpov0+w
	 abN2Y4+pFUIqm41fhifenNcAraXql8C+7+XiqMq4J02bqfxdO4CFBfHSaM2ynfLPiaPd4
	 /JR2YeFxRmAKYR0I3+oCglD8/8e6BIqGh/xNRfXf9Lt9fPvt+kayPpUkt9eAFfWjcSPEj
	 BASnXmeOMfPnD533VNUQv2H/7jrVeX9aRgOgus0vWdZzk5o3QZdAsNpRv7Ux9H0lzPg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793186599;
	bh=z065CJP71LzWefaUrK2ykP0JYytD1B9LpT+E7QO7ICw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrZ0nl0YCr086ykJi5kuZftLT2z5pL3oCOy9TmBXr3pPseeADMrVZaMg5dKA+b1Qu
	 nbTgK4kbK1tic6JAPIBEFj+DFNS+9uNNPxmMgWWv//Ms5GzehUF7V4Og+Tdyz+jwN4
	 clbCbAkAvGycm3MDfHokFccVOaw+AhRHeHYx2dqG2bdNsKPecJ1/V2MD4VyGuHCEDl
	 El7yLMAhLVjRN3hpQfKesdemW2hB0Q3oyiXMTsXYB0jNNrR0VzjEpS5yX88aLIgV2Y
	 CptQWpI3Kc2cpzKN+JfRbX5AjAs6KHf4AgNuc5nJrPSPGetlSqPwSHA+PO5dIPFQDy
	 l/wyhaZJWM32w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A13880F6C;
	Wed, 28 Oct 2026 11:23:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91FBD235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7496F405B3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC9uQm8vWPFQ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:23:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B11F405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186597;
 b=Ete7L9fx6u+icba4qekKU863+asz96pPV1A2louA1g9BF8M+7CASKN68qbon549obXOy
 eEPpW3Tjz7sv/O+19Urua5XzgfEAkRKpm6MPf20CTwMsDJ65WtRNR+i6n8kmlPVjvYs5O
 qsGBRSuidkbBwNUN1/c5clLwoMcAxq4VE6fRlW1nK73GfJJLcmWwkqolaBJwFzO0J5pZA
 WU4TGekPUQb3QnL6euTC8oCetdwT4wpq2GivUG01ax8STEitt+38Hf6N/WgW4eCfxDIQx
 sD7z2hvnYWxKh6FN3YdKt3LCTXYcDGFbDcwj1DS6GyH6CCEjUu5b4HC7/jJz2ZaS1iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186597;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=z065CJP71LzWefaUrK2ykP0JYytD1B9LpT+E7QO7ICw=;
 b=JZBQNfZmMPlk54EXHPiLALNco+iYtCjmNhJL0nYZBCWW+ljyED2lSXUf0bJuL6WKohS3
 2zr42WvLmKN22E9UcfIdAToLfnwrAaqDXSHjriR3BidYMPvgxxynhlmcGwFaOK9m13+VJ
 zjSVu2HExkX/CH1xxtPJA0ffgZSL1fG7wsdRkh9aeMZn/Yp617G55tGlZt+YP2jxtQNFk
 U0frLO2vnLCkiFjzp28UCbV/w/svoLjQOJ28e1ncYDIGqD8jPnKkPNsBGfxAHGFoPDHgs
 PiqpSP9xuA2bprXc9K/+WafSkpHZXiSR8WzViBMGlgQKiJ5f43UzQ8lgEpOuQk2xk8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WLAIlgVm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WLAIlgVm
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B11F405E6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:16 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so936226a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793186595; cv=none;
 d=google.com; s=arc-20260327;
 b=EQA/HXJbFOcy6h276WK52OuBqivMDYSAdOGmwzdtdZGs81bHNBbVcrLs2z+Wputw1q
 NQ1LI8rnzK8X99BUvUqUY9vBaQGXQz0sAM4jgXD1PoNJMrPVWobwSx5ALZLzHJ+S+o2B
 O4wbXFJZMzVlNAdMc7PPforWuuAad/dTy7TD+RUxQ6pMetlOpRZiT/vqGqLmBslgsr2i
 8LN2R0wuUC838oszgiwzvjXX7Xq5vaHJWihQgPCnkKtbNrUpoEZs4GulgDS4FHTFEOyD
 HTxDXXpq37i6GBD5+dKOVQEdwzkFwbwGP0AWapH/e/x00S8+d1U9mSnoJm17jIdE0h1M
 bBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=z065CJP71LzWefaUrK2ykP0JYytD1B9LpT+E7QO7ICw=;
 fh=x1xN3TD75kdR6GoVWNDEywBUO60kpzifwaVx8G5f66w=;
 b=VIKRat/Q0qIVIg61pDZGY4NWpKovzj9juaICne1VgbcPRNIXUufzo+vdHWCgPPFkdY
 9Y29fB8d0N9JnfujvhYc6ks/ciOzmDfAcqRAEZ1PIOePZrThMS6tPLQXwwvrEZWzPeZo
 6lUoA9sY8IJtWMWJeNjkOZmCXUqcSAnrHgREz9umsbaMilFzfbMrZAMOiboFLNuteh/O
 BhanwxWC+tf59nRdcy0S8IhJMtshARSjhFO3zj0O1OSGE6+hr4SDWi70Csm3wQWUkSRv
 jmetIKF7CIuKGGNR9LzVD65YoDf9wa5l17gnDh4t7rXZtBuFekLbmI1BZDyAITmUvum6
 cOtQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793186595; x=1793791395;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z065CJP71LzWefaUrK2ykP0JYytD1B9LpT+E7QO7ICw=;
 b=WLAIlgVmjd4RSWiKMSIp2IBU0IJNwd49PSHgXN3RzCTdcVY05mFGix4tLKtfJyTMuq
 kKHDbtVUR8KB2nmMEMyLi8qhNZNGJ8rUQHZkS5ZZVf7YsDGhE6/+YzJ50zv3PQ8xCBy3
 ls5EaBneJSs2dWi7C3CLIAM8bzU+igCzQ4C4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186595; x=1793791395;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=z065CJP71LzWefaUrK2ykP0JYytD1B9LpT+E7QO7ICw=;
 b=JqxtOvRe0tT2p0ZJIatqPGJa3SLMyMwNf05TSgXgAam54FCsBVTanuXe4u2yebxDd/
 ldwwXATob+Dpj7Vfa/EqPRjsZxirAbrG+VEmsxb+jbrnfHIkJq6EV/k7BWeiT62iLBMO
 KqxZYoy8p+SkkENat7MvOCX3xokc4W0hIizb6SkcOn4ES0A/XEy/lrDVn7gsxb4KMl8v
 JnsyevqbLPRX9+txHa3d/PQEUeVzw/mggvZvdJc4mbLVCJbcG6By/j+e74QdBtmLUzAe
 v8sX3NBlPZuU4lYsHWX45/HPtf2St6Awn8qxvlimOF659M2MAPaaTuxoGCwVPWjCiTrL
 wS/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvCjNXHVwY5idEnTNdDMsJE9leWsKweMKkGRCwilDhMqp9QOGtMoKK5x3eXOieGo+Myv/IeeM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKTnb/Ovvn4i6bfPbF8ecffPg15gGqD1dwepHKpMOdZ7VndIE0s
 y5jw1xcEy6mz3lWLIaKsgXh5EQJkGgyWdweHOhohGA+Zixxwj3Bvix+zcfJ0UQ9WY8EmHwbBYw8
 EV7BwMXY19wfcz6jcjLZZbab0cXyhXLOn+q4T5e1O
X-Gm-Gg: AYBFou1EvEYEX2s7GKZfiE8xsR1RsQXN82FHCDNkDy5C2Cxgg6988JdO4WfEUTRu5QR
 FFdsaj3eLqVjdeOTfXS50UnAKziHDlxePyTah1JmbVtmYUt/+tbGZflEhWcpbm/50jRZ3XiZ1mQ
 7SHKLnTb6bH4LeomSWJD6khmCR4Lk1L+UaaLq8oEkEo3xK7c76RByOkr4HFbaO2Edisj7jBAytO
 g2z0jwb6T1cEqyflpPbFFZN9G/xKPoOroYm36IQd07S5zMDZlcMHIxRVu29A46y5tTtH3QmJYih
 ph7/ZwcJqTEOnFqu+IZcUbQPC/Jo6ocn60TVbU8ldixZSf6dwpTLR+FhY0uTsaRLa2J9oHy/SNK
 o5eWbpjMoEnjZLJycJzyudKL7t+wnwX0BhfQ=
X-Received: by 2002:a05:6402:1a30:b0:6af:8a4b:7aad with SMTP id
 4fb4d7f45d1cf-6b49cbfc3a1mr944755a12.28.1793186594986; Wed, 28 Oct 2026
 04:23:14 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 04:23:13 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:25:17 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ae545f37-e920-4b9b-a85a-404f41f3e58e@gmail.com>
References: <78892543-03de-412e-831f-de840765be59@gmail.com>
 <ae545f37-e920-4b9b-a85a-404f41f3e58e@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 04:23:13 -0700
X-Gm-Features: AclHuK8SbVyCU9U7MdvrCx8pVSPB2iyMp57z_Lb6gbKjAcrpnAI0Ry6XEKo5aXU
Message-ID: <CAFLszTi6F8ekd=5FNGdmtYLjnfYmvWb4sY=E8S40GB5LxkUmLQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] fs: ext4: check block numbers before releasing them
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:47, Ana Bobillo <anabobillo3@gmail.com> wrote:
> fs: ext4: check block numbers before releasing them
>
> When ext4fs_write() replaces an existing file, ext4fs_delete_file()
> releases the file's blocks: the data blocks found by
> read_allocated_block() and, for a file using indirect blocks, the
> blocks listed in its indirect blocks. Each block number comes from the
> inode or from an indirect block on disk and is turned into a block
> group index used for fs->blk_bmaps[] and ext4fs_get_group_descriptor()
> without any check. A block number past the end of the filesystem
> makes ext4fs_reset_block_bmap() and ext4fs_bg_free_blocks_inc() write
> outside the bitmap array and the group descriptor table.
>
> Add ext4fs_blk_to_group(), which computes the block group of a block
> as Linux ext4_get_group_no_and_offset() does, from the first data
> block. As Linux does, it rejects a block that does not lie after the
> first data block, which holds the superblock, and before the end of the
> filesystem. Use it wherever the delete path computes the block group of
> a block, in place of the open-coded division whose special case for
> 1 KiB blocks stood in for a first data block of 1.
>
> Make the delete_*_indirect_block() helpers return an error, so that
> ext4fs_delete_file() stops rather than releasing blocks of a corrupt
> inode: -EINVAL for an invalid block number, -ENOMEM when out of
> memory and -EIO when a read or the journal fails. That includes the
> reads of the double and triple indirect blocks and of the blocks the
> triple indirect block lists, which used to be unchecked: when one
> failed, the zeroed buffer ended the walk at once, so the indirect block
> was released and the blocks listed in it were leaked.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  fs/ext4/ext4_common.c |  35 +++++++++++++++
>  fs/ext4/ext4_common.h |   1 +
>  fs/ext4/ext4_write.c  | 115 ++++++++++++++++++++++++++------------------------
>  3 files changed, 97 insertions(+), 54 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

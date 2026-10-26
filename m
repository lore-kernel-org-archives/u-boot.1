Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B81606A31F
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ik0HqXra;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=X4Sn8a6d
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5864340743;
	Mon, 26 Oct 2026 16:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4IKqPrUL7dt1; Mon, 26 Oct 2026 16:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8AE5F407C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033522;
	b=UOHI+UyMxmlFzDDeuBJN9A4TRktCPkyPkBzQMHsQYmLEWMz3b9hJQ1BYvbLf8WKTiM3l
	 T3E+FFG4CUvrTtT8mIAzu243zWAawA5/io6R2d2zH1ZFv1za4WBA+51rj4utB+WiWbieO
	 HiaKaBOuJnPMW9YBLmxu+VKVRcJju/6uFhV3armeNxUKdgw07RUnJbBHHe24Op+wHTHIy
	 OQgwPg3GNtf0dI5NNdZ7Ba60lV8M6bnVHGtjFgeaybe7kFtgjotPaU2y4Ay9U8F+TrXcV
	 5mX5huqiTfllUYio4AtLVsCdf8qk2jkT+1s9G41ZH604+PMhtDe6AKEs2zWpGSTiAXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=co314sSeXKuhO/ckSYsqJ3sjiwHpdeNUONXPAATOUyw=;
	b=RXgTr1SBl60vSrNp7j5dz08gPwpJbvXFGArk7TSsnFqrP7R3icL7stBqNN/xDm1umO0t
	 ScYjPo+6wY/n8znrSLZo9wsegBGIt62zzgrE0XeiOZ/uGg92YZg9qqP2Gczr+BQTN59/t
	 3VZFz9x9VMukDwdpYA4ayCQ9o5gm/1vTLiY1zjPABd2tXmTrT5bfa1u8an4GGFKDcE7j3
	 T3/tSSED8ZjK91ajk5KbePf924q+Xhg7X6b1pBI66j+qBeYhzCd34aAjp7SOZuAelR//F
	 SjO7P5E1czcHByjtzp5xLjUK9jZhWhO1ExDFyl/TpjlxNBp48eogfRZOXgYImqFmadw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033522;
	bh=co314sSeXKuhO/ckSYsqJ3sjiwHpdeNUONXPAATOUyw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ik0HqXranKPIfPGSnl6rtAAqUCkMucS6pJn+K+9eqsndhL0oormJOKeJFrUOJVLIo
	 ebyGvsVm2vffUAvx3SDLz/ZDuUOOelPAPDfYs6JchFgXpD1s3STVqt/w6T/r8vOnYh
	 J+FUqy8k6NLa6gRmFiRfDFV7IEcCbswipglNO60nZMeNR4k1LeMrnAKNBsXU6DH088
	 gzYHsWVWkDijyO3PBwRxZlRiy+9nxsCA9we89qTrJXBAy5COTKT9CwkXI7nM0V0QWq
	 daWpR++CFxyPUCO3E/4c7sYeLmdLix/7W/wFAYWygHNMHbLR+R8wv4NNc9mQ3i5Rig
	 xvuRo0ixmXiLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AE5F407C3;
	Mon, 26 Oct 2026 16:52:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 204F92AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11B8F605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xisL_1avvkl4 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1481460607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033520;
 b=miT7F29LwnQA+Kn8EOVi4xC3YuujSvxYUqXW6rcdReNxVnGjKMVXssIs46WPkwMg/1c0
 Cm+m0PM4KztvDS72SM9WQaUgMF3F8pfeV62txB7Nuofb5E1kdBN7uIJ6Vu/Fvtgo6FYGt
 o6Zc0ophmNFpqvaMX6o4+Zj+OMfTmpeXgyefrm6r20Z1MiYWeqKHgfeTwNICUWJHa9N1j
 ryXmB/X3TgIwOSkPataL1Z9RMB26gudJqWmpkw5S+/t79SFI5vEkWylcm1Krm0wUYHA7D
 BjeeGBEuxaM6diKO7Ouow/WCzcKiNz1mM2OX1CauF8Kkgxvb2LHhOlZgG7eytWbrNbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033520;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=co314sSeXKuhO/ckSYsqJ3sjiwHpdeNUONXPAATOUyw=;
 b=QEeV0EiHrhjGwzcIKe6jLhAgIWOTGY4onJF+bKvS8lvxCOF5dkl+43ocl6TuxDbG4V2t
 ZFUH23TTnUsvDmcQ0EUiBxSFDB3chHiusOH7zhO5OJO/KwGzxDlSAiUFcxpd17Ja+hvEg
 vG0IFLnaGJ8sdiQL8pZ3ZenPBM0GQSoFo5wm9F0T+6h17AX+V4ZFlIDA1Nzcz7eXP2MVG
 g8awiEk64b+42GgTtqBBxuxO/Rl3Ok9fBknKiZEGff3RFSZQIqwKfDqM2VNQWWE3XlVoC
 Se8dmNtRb7TKghJOTYwStpMqDyj1KNcRcRPpF+OcnpaaghT1fcuVzCNCPF2HS1VO0rw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=X4Sn8a6d; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=X4Sn8a6d
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1481460607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:59 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso142680a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033517; cv=none;
 d=google.com; s=arc-20260327;
 b=aXY7OvDKJmhMuPUFXcjMPbt06ZV6fIsah4WcVbqE7sPhnGTPDh3+5mvlIFiHNjsw4b
 KS5RqXj7QjcgY7DqctFUZore2lATJlNuHFqIvlW3YcRnR3SNfx+Gg3NRsRAC4Qz7vw96
 qKA3XYhLE1BP3EuwTrt0ugLicYqyETXTVrXWqmoH1OzbfbswLIfNhmi3RyaiSEarXKK1
 pthduAxwQy6HILkqfNoqTHp/NrB7SCsKCNxTvb9WVNRuC/QMcOoQTUfdZ9PO6l2CKnTz
 MpX4vxLBap9cAjbOH2v7DeP/mimScjbRptabvLIJTBv4vWodlR4wihpYXzg/bTzgXTxu
 8rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=co314sSeXKuhO/ckSYsqJ3sjiwHpdeNUONXPAATOUyw=;
 fh=Yd3rmjVpr6Eov0trqRUrt9ks5ejNU4qeOTWBcvipF6c=;
 b=CjBr6YxbfOf1zE+9AHiUXLMBKsdS0cHunp0qHHDCPU0QDQ9NBJPaVsWv3zt26IaW6T
 GCmDmK8Scs/Mm7097dYk7+Kcp5WQeR55uIjeYWMrGq1EQJzYRnhr7ezEh4nAcuPR9JZY
 Xg/Es5blLfCSbslRiALiEW6nwfFb4rRIKol+7EMhYs4DIkD2CQAz/fTJIzf/su+vOJQM
 b3zOIAjpEUjSshfvty7c9U/Ms8BP7RBZpbiCGZOCHp1nZyN+HxlmfQoGPLtsYdJJa9CF
 4tLh918fH0q+yADNfQc1dD45pq9aIMdx6sLG0LMnX4rnKrp10+A33L/jGlO0GH9QWIVR
 lmVw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033517; x=1793638317;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=co314sSeXKuhO/ckSYsqJ3sjiwHpdeNUONXPAATOUyw=;
 b=X4Sn8a6d4W1eKLiRZj+V/eJKY+6yRlspPjAf8e9YfkykNy8s4Ps+Fq8cTyRACeOusB
 Gn1Kbb01jgCRiJTBIBy4kpwJSGFJ3/UKDANwcLoF6sZYxJWm8LWvjsNwmJAns8wmM7gm
 VhvnGRgI++U3E8RqUD1ZP9w7Gr0mp17MXL3D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033517; x=1793638317;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=co314sSeXKuhO/ckSYsqJ3sjiwHpdeNUONXPAATOUyw=;
 b=xNCuuo59mQb1VlrrVLeEsiq8dj0ahW4wt+2BBVmWxcYthoCck/HT/fTq2PT6AGk8Ay
 YlZng17bpFzWFiZlEsexBCR42aZrfvO9RDzYlDWIUibwcdAjLP4S6sE7XQKhxDRO+Mxp
 bGjxjM0re5TXDYFeBPtoehoIDnNQFOxThrtqAAVFp8OIDqWDsvc6h284cwzHPGBgpRQg
 9Mu6sTrAdJRz9TBIB2o+TnEiSW9kTFPWG31imZSxuWYtOGTonV5lLFnH5qlFVym3WyUo
 fcSx9aTETzU+NnMxV3FLAYGC1A7NRA8HH3bY76JP20ORPEapJhKCNHNXcCBfy6Q4Kz/9
 eCow==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvEvQ43nqBhUPVrlRW7LY6r92ACOEPRSci1SZNB786ilViQ8eXTBZleCKt/sFK7fXCRUsVzEM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJT4hwnxeWNk2lAua6+DxFaaTNXu4w2W+GyQquJGwy+ggP5j4hA
 b3buAWPIgjhjDICEQQxHJkM8YPDc81b4+WnHLic6hmN52uIeQCaTE5gOpfiHBACDA6AsXVhkJA2
 cI8SScmbvW40B0H5azCdTXYjEX1YMyTdehdFRijOR
X-Gm-Gg: AYBFou0JHQOGgPbBeGIY86Ez8PnD/5fCIeKuaiJZV4xJfhCz3lCV2MhCCNixAftAePl
 L7pea8lhk3UvTxx24GFlBSri9rHiX9CCdEYG5ZUn7NQUisgP1xDey50lbttTj4Shot3Q6qL18Pa
 E0NEH5PIw52xogZj9bdVX2F0fvSggcsOKInQgFM+0jHPvg37NBU4uRfCmaVQAS8nFYJCnJxAYDO
 D3JL+c8dfCgFupKNBgbHi51k+RtUs9DaN0OQveCSg9ceOn/MThemKuFnW5uMF/GLHeqNz7PUZHj
 jfzAqKtGiVl/L2gDwleYPQT8V15q3eKikB0MNDk+IzVd/2mMwTuI+RCH1oFRifj0P0T36Xj+chR
 WB0UzCfdDkfIwjVhBKNItA8RMJ6NOzJUuZVw=
X-Received: by 2002:a05:6402:1a22:b0:6b3:b716:e99e with SMTP id
 4fb4d7f45d1cf-6b47bccec87mr110631a12.16.1793033517601; Mon, 26 Oct 2026
 09:51:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:51:54 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:55:44 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <701a5402-c9c0-4bd7-b5fe-36d5747a467f@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <701a5402-c9c0-4bd7-b5fe-36d5747a467f@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:51:54 -0700
X-Gm-Features: AclHuK88CulbmGR8gvizwy-qoVU3GuA-F2j_TiUC721MUFmG_lI5hsOgZB_8JrQ
Message-ID: <CAFLszTjGBi=fA=8iLR=631GkizqWCBVfhmHRi61hh1d9feBDEA@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/6] fs: ext4: fix the block group of an inode in
 the write path
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
> fs: ext4: fix the block group of an inode in the write path
>
> Inode numbers start at 1, so the block group of inode n is
> (n - 1) / s_inodes_per_group, as ext4fs_read_inode() computes it. The
> write path computes n / s_inodes_per_group instead, in
> ext4fs_delete_file(), for the new and the parent inode in
> ext4fs_write(), and in ext4fs_get_new_inode_no(). For the last inode
> of a group this gives the next group: ext4fs_delete_file() then clears
> a bit in the byte before that group's inode bitmap and zeroes an inode
> in the wrong inode table, and for the last group of the filesystem
> the index is past the end of fs->inode_bmaps[] and the group
> descriptor table.
>
> The inode numbers given to ext4fs_delete_file() and taken as the
> parent inode come from directory entries on disk, so also check that
> they fall inside the filesystem before using them.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  fs/ext4/ext4_common.c |  6 ++++--
>  fs/ext4/ext4_write.c  | 16 ++++++++++++----
>  2 files changed, 16 insertions(+), 6 deletions(-)

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -485,6 +485,10 @@ static int ext4fs_delete_file(int inodeno)
> +	if (inodeno < 1 || (inodeno - 1) / inode_per_grp >= fs->no_blkgrp) {
> +		printf("Invalid inode number %d\n", inodeno);
> +		goto fail;
> +	}

The same range check is open-coded for the parent inode in
ext4fs_write(), and (n - 1) / inodes_per_group now appears in four
places. Please can you put this in a helper next to
ext4fs_blk_to_group(), e.g. ext4fs_inode_to_group() returning the
group or -EINVAL, and use it for the 'ibmap_idx' calculations too?
That would also make the parent check print something, since at
present it fails silently.

BTW Linux ext4_valid_inum() also rejects reserved inodes below
's_first_ino' (other than the root). As it stands, a directory entry
pointing at the journal inode (8) passes this check, so overwriting
that file releases the journal's blocks and zeroes its inode. This
isn't a memory-safety problem so it could be a follow-up, but it would
be worth considering while you are here.

Regards,
Simon

Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEFB60A2605
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jycXJmtD;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iRJDhckT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B255740763;
	Mon, 26 Oct 2026 16:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9FxIgVviUQs; Mon, 26 Oct 2026 16:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D65F340743
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033520;
	b=SvA1XzMSxHBNxGH8Se+LB0ottlmUMzYyS/HhVkKR+kQBQMVI1yUJj0bDM54FRCo+Lpuf
	 ByVvSGD2OI0jWDLGAJZr4TQEzz4UZB+o+IWxaujOOlmGI2Ut6Gzvr4G0CjhsDFjs7XgXH
	 YvUfksznfsb0Bj16Zy1+3FpqneyXCiuSPCm/PnDsFwfzYGAiLESxETiQzaF0QkNcRiaP+
	 Hsx6tPvLMCSo8B6fBiVr3EFMEgi6gx3eq/wcQNF6MnIP0cV8BPKT4mwXCOM6FqOMfzgNl
	 ix1vUKrpR5yKCi3FO0DM3xxV6MMiAGFz4eYDVFi0UMCgd2bNiITSz79ym7qRgyWuDzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NGkx0QfdfS1F5OXOt+cwBQIjcbN/LWE3V14kKJ4dYrE=;
	b=hoCCKQWevTa+vOz4bH3t1ZK4zG4sgPFfPv+4F4MSQRZd7GNu0auUzVGimaj4edpLbU0w
	 YASMcaUJ0EcdVCXKF0Dfdt+TInyaRzHu/CDm7qHo0HHL8K3XJjCVCCsUdi0eiffKkfC7n
	 ocAwCAz46tevhaBS0FYSF4Shy2QTEfAsve+407Zut5eWq1PLW9Q62dJGa905UlX44RTaZ
	 nd1kNJUVB3yxIN4vUKGK/pLT9RGIJJEMvXbKj77nxw/KDv2/Ne8+7PxtaRf007s4dDLJF
	 R1gDfFkXD9+LB5IqCJgSKcpVAiWmWtjTK9hmygOZHVYjkJn4Bjgcz9/SLoJqeNZo6GQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033520;
	bh=NGkx0QfdfS1F5OXOt+cwBQIjcbN/LWE3V14kKJ4dYrE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jycXJmtD3bekNgQmgIR3SQxNfGht1etO8JYbNujOd7qJi52NaKbhZfeYnvnnO/Mvh
	 rmsU9zBla+aqwNMAzDy26qGR2fCXbXMbEj/gaD4c3+8PJhRT63A/QDOtVOnZZNPJQC
	 lLBUiPx6Giq7bT0BTVGjWowYGciaz1X3Fn2nAgrAmGXokYP2xkEc4GiZjeS4ht4RIV
	 cyyK/djRCWwN8ahQ01nC5w7HOL5yRup99tghMAFuqGSmfxWJGZh+A7cpaKmOimyrQN
	 P/zTTBPj9B0lqKT2LMTh5IQ0Z3FwJgK3vI7MVpkcYJYUu/DRM9uPdd0jDDeQj5rB4z
	 1oYE7SgwJfOLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D65F340743;
	Mon, 26 Oct 2026 16:51:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D56F2380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C718180A96
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfc8AEB6MZpz for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:51:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA43B80DCD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033517;
 b=GvWLnZymFqXRCtp8gXQvK5aVQjso3cTyD9D0WbCDKQEkf11S470qo4L39E+iHVCa7Ptu
 IsrZZwvDse0GAXOyTp3sfJ7kKGGg0dzyOtoBqr38/69AnHpKYzYPNxR4/LTGJ1590dMq5
 7jHh2lXWNDwknZxEGkivRsvi99GA5b98raAIo5Os8au2cQ/ySN1cwHvKloTc+rP5IiHLI
 ep9TCnezGRpzEEqTFBkY6nXFW+iazIk8wDJGnh/SRoVMFPXKCi0ddVKq3uk/DlpxCT0ON
 PJZeBXOCgDXNdmSGzmreEpxahGv11WGzKptuBvhRnZBIysYg9r2nd6zRQZ2+xjja3Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033517;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NGkx0QfdfS1F5OXOt+cwBQIjcbN/LWE3V14kKJ4dYrE=;
 b=ZZJ7PBkkcLPr6DxVW8wK9Vyuml+5fdxANdbkKGxRpE7kZ3nY24GjuWPzGg28oIO7CHLo
 8rLU34Yi0utGNWtl5W+1F9Sr2nXRFwWo12KABq8kKGJadSnOroT3OpV13qfEdOXjCb5e/
 9aVgEfGnK/JqG8mIMpysnlRJpqdt0EyVvbNFEqLInQQBE4/r6a34HC652/byyMcRDbdUP
 /RNJ4pU5VuMc0L1BtkwkBZrqxhnaxBvs5hrQm46ZuOPHpC4zLmh+IO5GPHC9qkA3cSpjS
 wb04DVcqfq04juzugJdFnSqSDWTaGRYZtmfWjpuc/7g1SRypYb+50Hfxxelue+XYE9A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iRJDhckT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iRJDhckT
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA43B80DCD
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:56 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so5476922a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033514; cv=none;
 d=google.com; s=arc-20260327;
 b=n2UvDop6gG/tWyu6EutZ+vD/DU2/22I8sf1gkBc7HokGfkFDMjyNQO4caTN6uoyYNG
 Oy67XgMPeAxP2gLRb/CBDWseHJWo1fx3KFipVVAgNaWHetcLwbCpT5JxQWtCisX32q2u
 2gI7a52mIfQ3MtsEa1Bqc59iNTWEe0H91kziYMYwx3Vrpm1w1G8qici7bNJ66IZDBRnZ
 RRx1geictMlngLfMvDDLm3WEAkhgS1WMzukoBszIBwU9uuo4w599SqbbP3wdta1Mj37j
 JF9pXUYKMlXai81P+VR8PFoSl8FxWXtlSwV+XQdlsBU7noNLmExo98/DfO5sxNOApcXr
 opNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=NGkx0QfdfS1F5OXOt+cwBQIjcbN/LWE3V14kKJ4dYrE=;
 fh=HkjG7QvHL6Bzz+FJL+4wcNdXdt6rtH23OPpx9JtoPp0=;
 b=nnhjLcEZ9TF0fbEsmF1J0M9fHixkZebVbWfOB5/ecQtlBCxs/a+EK2QNdXUh9dljCB
 ISleWlZiRdX4+Xq10gm/3P7m5WTvP4A7BRwozp0vUIahSneuWhNPN7uBBD/YGunLqvyE
 2bbm7lTVuNwKriNAQadCenH14mVQtbTa0EyZrzPwGQa/9knDTMtRCDm/L5x/Abj/09Mo
 gDNf920sHvmsTYjuW/Y/DhOz4kWws5IRaEfSko8SIlIV4zdZf3yMtOdiagSOfb7TwRTf
 680Df5nx7mvZJpxJ+Bnr6+mNNvZLxM93zfnCm2uqOpk0JH00J+Jw3QEAZaJHNqwigTeS
 qd3Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033514; x=1793638314;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NGkx0QfdfS1F5OXOt+cwBQIjcbN/LWE3V14kKJ4dYrE=;
 b=iRJDhckTu34WBXkuw+Wbu7qLN12OiIP3KWvqrNq70DRVpnXSG1r0qDCnPsfnzlpu2q
 g0b4xbFuUUxmNGyAh8abnhRfHubWS1m80vGnPNA+6OSrkaN9kKKAU5qCNxOwvoy68sQA
 voNNTC0tGmZNvH2b+6cl0hEBgEWgkHbYNI2TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033514; x=1793638314;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NGkx0QfdfS1F5OXOt+cwBQIjcbN/LWE3V14kKJ4dYrE=;
 b=axfIO86LSeLQ56vZH6S1hr3tKTg8hAb0lWixDdQWY3SxGaIwStB1NoDtjG1xnu/EgO
 4HLFteubEnkt3pXsj7N5MszFWAGV5aCWm3sbHQa4+Io7FfakbUCAc34kLILZRFTu10Cy
 E0Fb+MCJXSQJCuIxKJVnQzBU6tU5gpOd6TwFmvPT66P25lmOcaSTFSefdA2iSBefnNXI
 y7ihZbuilR921889o/jWOTJALNa/SjVjwLi46iUiKFYrCu5joskIV2rnN7VqEkHYVjfH
 COsDqQvhT/8hoflEKXOP7AKN34cUg3Z/CJD2/SVkhqX17E/ENyViL2c3Fqnfm5uZJIHW
 5A0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBaZ9fqnmdx+9REmiH1jHsCvMWqdicyQGhl8jwWr5QLcNOhYXo81TusloeiuO0SC3h8p7tlhE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLq4500f1So+MoA0bZGHH40Cmfj+zgOudTQV+6TqDhzs+ZxCpIw
 2ym08Z4hDMdmxS7FAeeht5Y7EkAULO5lKOmR0aB4azC+RcwWUV6Okt5/13gX2mS7Ix4vjjkPmiP
 sL8UkmzZoNWzSJGdcHRlc0Y20P5bVDkqg4TC1ihnE
X-Gm-Gg: AYBFou3Fif2cT9h7oeRoNx5IN3NkNbs0420iXMiM8jLSJWZB7w5dW/T+jJvXKaQRlSm
 5a9udEnTchrcMP/zN5nvBbwtocLbjFVcQqAq4U8rG9xNZ/tQW7kHbhYRUIYtBpI7GRHJlY4Wxc2
 seFdnDXYN2KqkfhvLsAniYYPhmtU4S0o8CIY5W+kqJ0w/bD6QdftX5mecc8TU2HjbpZEEOKJ6g3
 4zgVKkcHCe0++L8QXLyb3R5WE0+zPYHA6cyJ5hlOErQNMThmlq40Z2Egt+hYMjEnMjzMvKUL5aj
 +yjrAgQsEhI+hKENUh+LP9O8HMQOn+Jci8wE2vnjw+YAG1Ll6GxiL0toEroQiblvo/RWjAuU8cK
 3GoDT/m7DfZ9m8PL97qbCCa24P10KN5i6zGEs8oqNeO1J/5zYVHKloG22
X-Received: by 2002:a05:6402:b16:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6b442fcbd8dmr5721423a12.11.1793033513965; Mon, 26 Oct 2026
 09:51:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 11:51:52 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:55:43 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f4179b61-421a-48c1-9d1c-2774214544ef@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <f4179b61-421a-48c1-9d1c-2774214544ef@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 11:51:52 -0500
X-Gm-Features: AclHuK8Y99UMWLeIxN-OlmyOxASdnN3bdGoh6kUEWsnUzOGn0T26WEpyKCPHeZQ
Message-ID: <CAFLszTghQMccGjjeeO6aQANDmgWxLzpZvFdpvWvSk83b1Bhc9Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 4/6] fs: ext4: check block numbers before releasing
 them
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
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
> Add ext4fs_blk_to_group(), which computes the block group as
> ext4fs_get_new_blk_no() does, but only for a block inside the
> filesystem, and use it wherever the delete path computes the block
> group of a block. Make the delete_*_indirect_block() helpers return an
> error, so that ext4fs_delete_file() stops rather than releasing blocks
> of a corrupt inode; their out-of-memory, read and journal errors,
> which used to be ignored, now stop the delete as well.

Not quite. Only the bitmap-block reads for the journal stop the
delete. The reads of the indirect blocks themselves are still
unchecked: the ext4fs_devread() of 'double_indir_block',
'triple_indir_block' and each '*tigp_buffer' block. If one fails, the
buffer stays zeroed and the inner loop ends at once, so the parent
block is released and the blocks it points to are leaked. Since a
failure now just discards the in-memory changes (ext4fs_update() is
never reached), please can you check those three reads as well, so the
commit message is accurate?

>
> [...]
>
>  fs/ext4/ext4_write.c | 137 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 78 insertions(+), 59 deletions(-)

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -140,32 +140,62 @@ fail:
> +	/* blknr is below total_blocks, so it fits in 32 bits */
> +	bg_idx = (uint32_t)blknr / blk_per_grp;
> +	if (fs->blksz == 1024 && !((uint32_t)blknr % blk_per_grp))
> +		bg_idx--;

With 'first_data_block' already in hand, this is just (blknr -
first_data_block) / blk_per_grp, as Linux does in
ext4_get_group_no_and_offset(). It gives the same result for the usual
1 KiB and 4 KiB layouts and drops the 1 KiB special case, which is
really a stand-in for first_data_block == 1 (it is wrong for a 1 KiB
filesystem with first_data_block 0, e.g. with bigalloc).
ext4fs_get_new_blk_no() could then use the helper too, perhaps as a
follow-up. What do you think?

> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> @@ -140,32 +140,62 @@ fail:
> -static void delete_single_indirect_block(struct ext2_inode *inode)
> +static int delete_single_indirect_block(struct ext2_inode *inode)
> +	int ret = -1;

The helpers now return -ENOMEM, -EINVAL or a bare -1. It would be
worth using -EIO for the read and journal failures so all three return
proper error codes.

Regards,
Simon

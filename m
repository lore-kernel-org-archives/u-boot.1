Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D27606A324
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r7h4105J;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RkR0ly99
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9110240792;
	Mon, 26 Oct 2026 16:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U7TVR_qhHHoZ; Mon, 26 Oct 2026 16:51:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C160E4078F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033515;
	b=iHwpLosHfByFKrCbUJdoKxSmW8Q1d/H2oPVs4pbH5F2K1yYwFj/vwBcWU1hSSrWuCjm9
	 lhShNE0BJKCg41EhhNYQR+cG6GgnJZcbnYXG/8I7qVwdjwzuEmMIr7fUBjorGTRuEcR99
	 HpfZ6W5nvEFEqKKiEMEmaZVa98pfA66jNzdlaU10YU6tFotvJx90hp4Q/W3h0zmDG5jM/
	 f9uDZ4pgUpYDcfA0aDPBE2R4wxEcd9xpnUiJVxszvoEu7bSEZDWcmEoieW7M/MrFHjWlZ
	 i+vlAjJsBh9jEJwx6GBI8uI0E3jOuaZZQJG6D4h7VOQIJphGBWHxVSUcNNrC5Kba0KQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793033515;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GvLdr7x5i+qGYHZxXSb4dh0uAVgrCOiDH2h5g8RZYlg=;
	b=K6W0dF3s4QcbAcV4NbhMDNHCofTNu6KDOiFnf44vuj6Cg3RqYiVb6kZZJeK5lCR5yce7
	 JecxdqFG4RZ1JCz4H8yaDoEdH15MNO43msC/C8OxLnM7s5essXKPfA1beR9ZMRVaOQ3qH
	 7OaipU8pcMs6MxC4UFHrufSZ63LBc244aih0wsvZOfS06g7NOkIg3CcZAhjKIcMQ27U8K
	 /55EPoHbVA3lzhAjnzMS3aO3EyqyajCCsavJJN15yF+SYBY8m2Jf7ejOZbJstxygjw8rl
	 JJzCC9NTYaSganA3ZgeUFhohHnGdKMFUFBP5/G1lj/wCWUj+gzhXscBSTp4L1/attNQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793033514;
	bh=GvLdr7x5i+qGYHZxXSb4dh0uAVgrCOiDH2h5g8RZYlg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7h4105JcEt8fPfLkrepWE8gtP9f6pM3CWiW7Gm3vGx3AVSy2OZp1ayW0FKwsztTa
	 rgzGGgPAB1TKFbv/0Ti9QiQu+UDO7jaZmCxFMfteo7BWpK9V5Tv42rH5ah44CZlMbn
	 rKj3a+9p5CqA2rv9f46XxPMylTq7mxNWZgN+T7wRnoJI93hTIRlLoT7CvtMwWq9jQR
	 3Y7z4stENLM/n6g/XkMNRJbTKkPUneiqG3l607Mn6frVKHM3dgZOL/e8MRpjCQY8GW
	 V2XgMGBRIpzgoe9JMIMD33wuLD1m1I6TaakCmvfgqqBXwbF801+NpuzGbOSv/2ru4S
	 9XscMhya24sLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C160E4078F;
	Mon, 26 Oct 2026 16:51:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69E0F2AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BA0B40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WOYx6gampXV8 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62F8D40075
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033510;
 b=jqgffmhZw9Fm/Vt07SIQRmElQYSVUK6S9bEwlwL0cRuOZhGlEHFxyu3cnkOPRbWiBbB0
 SDm0tEz2y7/DcMi3E2F+kWXQBcn2Z7vk+j5wpar2+reETOmsQBBZwu+lhk1Zg7T0JU8US
 4QRi7sxAxKtNYrFjx/k0rDrIBduf8/AaFVpGD9j+2HIh0rBEhkv8phZ2AM4RONgqw3sl7
 AciQSVSur+IExCus1Vlf4c+ig4uOpLjJ4VLvtUIUZHJm88ZBWD+2W6Hlea2c22IOMd3Vx
 EGLYBoqIJjUKcqwfwEZA3bQJDmCA8q2UMmDzT1b6c9L1NYyTIbZJyO0pBEnXl7Xq/OQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033510;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=GvLdr7x5i+qGYHZxXSb4dh0uAVgrCOiDH2h5g8RZYlg=;
 b=okBKz2GVNM9waepuom6Xxo0W07tJAs99i3l7L7ignTMRJk64zIfFGs0GdrE6QUMhDB15
 KbSA33HjtQYRx4cZFWUTPsxDXR3HCsg2iTAF07pXqvY5zRIMGt9846n3Cw6lk7vnPQzwg
 aI6MQ0v5eAqy8Egp4Ce2oane+FGsYOocx1m9vgunkY4qOAQWt9ZXhNDgasseoma0P/I7D
 B7nCnR1Zy5RDYrdCn6IkF2mXcLJQWPvtQeRDE2kRpgYJ5Qi14pJvyTCICIkwIGfsIMQnj
 DrN/xqG4TcC8W08ShMzZnL+iV16zxmnAhWprOjI0blCPVJGVVGLAWyoIef5Dl70hSNQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RkR0ly99; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RkR0ly99
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62F8D40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:51:49 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c413dea9ca6so514166466b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033508; cv=none;
 d=google.com; s=arc-20260327;
 b=VM+MBeKRzyykuybYlDBMOj/yGLxRBjZmDHxj6qFi0yGDPXwuH37ZmDC/RmKlDAr1yL
 a5eCneklTq8eTqxYr5s6km8lQzP7NV+ddkFurCZ1QbCBgWLOimgkrUMyWa84nDhAlrTV
 nNklUVw6xd4qR9Lj7dKkv5f0rlwsOgIlB6/bFqLHNX63aRk/acEltv7Gdsp9Ddl8nDgG
 AdNo6jc+a01IeWC42FJmrs0mpDUFk+GmW3iRXDosgI++OFEUKhA8attIdGzXR8Q4RKLV
 oV/kAxxVdQKbqa5E4ugZAinNYTAJyAHIg19A4fylwzQqGVcMiF7/eHO5tOuKv3c0pxUK
 veng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=GvLdr7x5i+qGYHZxXSb4dh0uAVgrCOiDH2h5g8RZYlg=;
 fh=eohBOdHgyhgj401eX6stnbvzeX90qmZWe81vjA5dS1o=;
 b=qLH/BIa7obuCPErnxcRaj+zijetlOhwvJA/ot03CvpJZvR+YCyLgYDkWq0McSZCxbl
 16oVETQ4Qp4r7NOcjZyOd1ZcSunvcvYuGxetZnSF44jQW9XyICeDLNmbGW+GSKlLiAxo
 VI+tKJ4TT7c6GSzpafbHko+bOm/tYjaG9ej9gEjQZLtRX0bL98a+Q0d6iCmuCB9ff8Nb
 o+XD8EKwqdtc2gAyAHJ/pP5zYK4W+1ua3VtjK0OwA3Fkr48TV4BBqdNmnsXJnYXP4U2X
 xT3f7PnURyQGroulpLPdnotOp/uJckNRn5HYTYBdywf9GpfsXyGIjsUl80tUHiPXtBmt
 /KaA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793033508; x=1793638308;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GvLdr7x5i+qGYHZxXSb4dh0uAVgrCOiDH2h5g8RZYlg=;
 b=RkR0ly99/r1+d98cs7KbBSw0xFZdpK+hpHFEofb/FFH41CUZLdFIJN62uzezKOvCOG
 Ncc2eb4N0MAExmsFjbtnfqnCqw9nC0wLbvWTEvpumOm24cixekJs7XZ82pVA6MXOvrqJ
 OWg7naPjfosJVCFmXGQwanrPZbJCm0fEBLkbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793033508; x=1793638308;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GvLdr7x5i+qGYHZxXSb4dh0uAVgrCOiDH2h5g8RZYlg=;
 b=hTY5MqtioULpULeP3LD3julrL871Tj0rqOxzPP87Q4TBSy6g+qAL/QhF2vvxQzkM5k
 h+9D75DXMHFNL7aNf4Gkct0fU4YnOwsVIHUVjgYAxoKNLrsDaTaRuVY0kFlc6Fy+wf0y
 78AaAPwBAagwreZhdQpoqESIdcVRxbXNMw86kCewbNCzrJQRgsiZbzb08WAZwrI7Ox8d
 brrwgStDyAyPGdva+AR/SnCFZwLK6BuPefLWkAZOWO+Otdtwv5RjR+OSBSAnCPMG82oH
 TGBDrMpupwUSaSGHeQQvBAMJedano5Ap8xZ/9TjiN9Bx7BIgLTyAr5sgTjP6hbhcBxon
 kIFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypzC+MdDenmAv0dO5RSLXHNKe32mXyw6ZWg5qsV98IPEFjZjyS3Hp4iTGN67/fSNy9Mj9oe78=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKPVjz00UrMZjo77BAqTy6xp07Vr+tj2FniVU92951DrzN4zJn2
 3yC4nQW4Nt2YPeauEfjkh7K+Bh7EyK5Nxy7/Tlh2O/STNh7Hs7f2QbwT8HL0WHU/u8ieudpHMWB
 dOfYSEY2nLHatT3G0KhznKxnsDbJCEZRFZdeq3Vx6
X-Gm-Gg: AYBFou1Uwnu6qJGCdythJ/slyvtYy8fdHseDQVpKoovE58Km/Ot3nCS9mBwtkihMkzc
 IbY/zSpV+U6RmmvpxOYBI9Hqr1as17gkFQHKrHCgNxyGsymXi9EqyRATEJIsrIzNGXzlfrsDv7h
 3Nox7vkBoqcRZ6bwFHW+VtXOLRsYwJI+51+GtSwgn9YaPPWxsrty7smXeuJi19LxbdqTrucUP/G
 kWiuPRV9Ks9Yqv0PAVrf2+DP4Q/9sb5w/QnX+DmUOBmkhZqzByk/itwarKDd1O2SiOzMUabzkwu
 zws/bvAA+6cx2cb59OUCjbzVgEobxeJHzDT8H3Gw1A+yVz8cfLEY/ock36a+9zdup7+4HbfyNy9
 Ejh+j/lTcaNTruIN+RJNtr+UmkCBjnVGo9M0=
X-Received: by 2002:a17:907:a909:b0:c41:44f2:f7d2 with SMTP id
 a640c23a62f3a-c46bde5469bmr841269866b.24.1793033507882; Mon, 26 Oct 2026
 09:51:47 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 11:51:46 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:55:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cf14a3b1-2f94-4546-a7d1-541838c13582@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
 <cf14a3b1-2f94-4546-a7d1-541838c13582@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 11:51:46 -0500
X-Gm-Features: AclHuK9fipi_UEzkt07HblF51rqidMUkC-8LxpaYweDDOdtg_qR04stbiWKwa6Q
Message-ID: <CAFLszTguxMHwbrOL9DrX1yWknAs=K9NqVWsG4bs_YjRiEhF2Nw@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/6] fs: ext4: refuse to write with an unsupported
 block group layout
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

On 2026-10-25T13:04:03, Ana Bobillo <anabobillo3@gmail.com> wrote:
> fs: ext4: refuse to write with an unsupported block group layout
>
> ext4fs_init() divides by s_blocks_per_group from the superblock to
> count the block groups, so a value of zero crashes the write path at
> once. The bitmap code of the write path also assumes one bitmap
> block's worth of blocks per group: ext4fs_set_block_bmap() and
> ext4fs_reset_block_bmap() find the bits of group n at n * blocksize
> bytes into its bitmap, and ext4fs_get_new_blk_no() numbers the blocks
> of group n from n * blocksize * 8. With any other s_blocks_per_group
> the groups after the first are indexed outside their bitmap buffers.
> s_inodes_per_group likewise cannot exceed the bits of one bitmap block.
>
> mke2fs uses that layout unless it is told otherwise; it lowers
> s_blocks_per_group for 64 KiB blocks, with -g, or when many inodes are
> asked for. Check the layout at the start of ext4fs_init(), before the
> journal is replayed, and refuse to write to a filesystem of more than
> one group laid out any other way, instead of dividing by zero or
> indexing outside the bitmap buffers. A filesystem of a single group
> is still written to, as before.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  fs/ext4/ext4_write.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

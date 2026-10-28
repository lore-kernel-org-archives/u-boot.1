Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D233606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bZ791PWv;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KmG/rqUh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1EF080FAD;
	Wed, 28 Oct 2026 11:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uy-8N1yp7vrD; Wed, 28 Oct 2026 11:23:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19A6B80F70
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186606;
	b=bL5YgqHklpqZLSts6muXRtEof0MLBoeYffp3m6PL1IxJsrRok1kdXmLh+lCaer63t7I2
	 aIawxjs7n5KK7XjO8I+jj1JsCa7ItZCRg+FxUgr69g5y3jfQiIcZ3ZpkDLZ+tUJkp1M6L
	 nAApzLyUnm0Jyv0JUic53N7Y+krxRp/R/Z9psrSTHf5jbwKOxXU2pL8dz+dNKU/9BVfXP
	 BpzXaQOauu3Z0P94DOHOY3O4Njjcw/8ZlPOk+9hfWCv6nGm8uL0aVjabtdNqMfKVcGSkY
	 M4l5QZRqarnDuhGqG4e5tRGjv9tb09LfCjYhH4j8mBaCUBStrMec6S90vciCH6gv4tA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jEvVHPPoLXlkSG80eiWwtkkUKdZA0g6x5NHnaKnslR4=;
	b=DK7bqpBt6mp7idfCiiugkmM/5TxADb/02l3StdItPPxFnncIUxN9PdR47z9ZuVZIk+hC
	 nZBcMHGIzdwDkM+5+gunnVnJUgpn7efUMNHa4UK8ErdyultrNbmG70i5m2wB3kynjCDvH
	 91uTLAFqpMyJFTxHVCP53li6dgRvQ64OhqXpNJtTflc9gl0rdHXNlvGGCnzeVnb+B6jRA
	 V1u06YmxtJBpobjTynGqqk9P3QsEGfBT5HZbGPHCeq8ylZox59mP58Yxuf46UBMSy6kM4
	 q5CdDsfDTPB1OWl0IqOo4mHxceEqkaGcpQlT6rBct6woRy/juaCoZmP8QHZoYudExQw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="KmG/rqUh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793186606;
	bh=jEvVHPPoLXlkSG80eiWwtkkUKdZA0g6x5NHnaKnslR4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZ791PWvF8NifoxHGQWI6E9ItM5WmxZvVIcSmaLQnElGkk0tBbznPNcwYmrUJm2tN
	 PfizDb6C6eQA6NJurObVDiEnNhIyIBA03wGTARabYfBn71MaZJNQlwW4o+c6edhi6C
	 kxrMTRW9vRPlwuQiSi5GH23fcObM25YESTvt6Zy+4QUyU65KAOYxs7clDS5ntVEVPB
	 dniTYMLZ20Z0qfj/uzXdfxKNi7zRF8R9soCoh+XpEnYNwtwIhJC4h+hqgX++b/yJ7z
	 +zbk48mT48pEKAxCFb6f1S5BWnXoYvJkLws/9ln1Kafh8cHnjOg12IHB5hQm8KHjWa
	 Y8cgr2L4cjfjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19A6B80F70;
	Wed, 28 Oct 2026 11:23:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3341AD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24DCA80F70
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCN5kILBn3dD for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D04E80F6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186603;
 b=QG+G8zg2zBQpayl7rk4wfzrB4ZIzDrWhmIAUDec+Mnx60+n5imrexbi/MeALl8747FsK
 FQYs6RVQ/OlvhddSPCoCtMyb295L4kHXfiStGj3ER/DLz5odypWyVti3ENm3MEl3nVFJO
 WCVQClZlfNNK4wzj0PZyy4SBwh46fPA9XQ3hF+CZ9JLp4vNRfN0qnz3C+r1VDNKu5QM5Z
 ZD7bRHqljhm9yIrqaKDZzK4qkw7SSr03amWdtHvzEkbsCgYJ4LavdJKtufSlLLQwMe4Eq
 TXjJKtgQSbgPNLP+M/M+RyJynXl3TZtVnRIQGEVmNEzElcD8MVeza12kske9AYyto9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186603;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jEvVHPPoLXlkSG80eiWwtkkUKdZA0g6x5NHnaKnslR4=;
 b=cIsKhRaIspiZqY6KkufQXAKZaq5j9yGX7AWITgKe8NF8Fl0T3/ORrjmXx6CytP2CEN3w
 1jGZN6ZM2yiWQl00s3icU/BQeNrn9ccUrc8kQT8SGPiYIGGWJlGiRNP+umtuX6HEivgEu
 RShu0dgVd7XrXPO+6oDgWlBJg4mmR7zn5HVHw3bmHkP2WOYAzSXzkckkjYbKD1609OTjb
 6AvqU5RzfTCv5jtdVxnJsnlT7rX5RZyN3lN3q1T2g9n7sJlgvTRrk+O1s1F+SxxdpZZN0
 30VTsTlbJ4CzMCkdPh2qIFU99eoino7/Fnrq3EJVXXUZMBWGIpXUB9tXswhuo5/MT7w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="KmG/rqUh"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KmG/rqUh
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D04E80F6F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:23:21 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa27963eso2998119a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 04:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793186600; cv=none;
 d=google.com; s=arc-20260327;
 b=igu528TzYBvmQ3E1vmJJDUEfgPhn3OB5wXD0NmrCtmy5KYDeoGOWvoVjntZezR7ro0
 Hlc/ZWeBPJ9pHBiGwsDR2p02cO6iGgQmwu4WuLSRUj9WNSF/FUxdo9mDbkuxS6c45k+w
 FvOd9m8hj5/8Eb9Kd3vWcL/P4T5W0oZTJmi6utSKE8UOgdBx/niZtB/Sgk88NtRwpQLm
 KRm2taNUPsY5nH+2vdXrLRHQZPnoIA0vIYamEWBfzfeveGUsZ8Vg4t38K7gQc0ALRvME
 UkJtaKCgMUhl0PC4wQLTCo1/Z5o6SGDlJrY8KRUvBUsHeIvj5rAlxHdtVKHoEKE6d2pf
 OdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=jEvVHPPoLXlkSG80eiWwtkkUKdZA0g6x5NHnaKnslR4=;
 fh=LJ+Fy6PXv/dYGBu0kFcFDUPnkpTHODLk4DAjawps1Fc=;
 b=c/uJH4RWboe+S6Yu4R9+6ycAOCdWEnxVwO09IQEXDnVqzpcI1+8Wkbfz1sPshYzoSW
 vDmI0hsX3oAAcpUErl/E/c3tqYE3PGjHC4hYtrrrwSRge3f6dsUs03gyUx7thkomouLm
 uNsmjgkvlR7bGO/jckME1wiPAJMsChqHKVpDFEk9wQ6CphQ1AOw06gPDaSFJRqZch0fn
 X6cNtqjZ5NIOqDjqihbGzfdJH3BWnUWqxvEos2Ham9EiDHQo4/TxkCEG2Z3lPgEBfXXU
 sHxFHzvqVp1Vmm31HLJO1/NQOOX2g3hki/IwKceLGENRHCFkdR/gOAuCuBr+l6vNm33n
 EETg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793186600; x=1793791400;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jEvVHPPoLXlkSG80eiWwtkkUKdZA0g6x5NHnaKnslR4=;
 b=KmG/rqUhn+BBbln+T6KRbcQbvCVz9znsSfAyhitjxCoa6ip/z91rtxdcrOANC2MDe5
 XoG+m9gJFxDMTMWZAMCojlJmBfXHo9KK83Zx9qDT2kSxw2UbF5APNOB8ZZcUTVME4Dhq
 teVxNYu4RHjeRC74be3WbL8R2IMhiFGecKeXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186600; x=1793791400;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jEvVHPPoLXlkSG80eiWwtkkUKdZA0g6x5NHnaKnslR4=;
 b=dVMinWyxh0pOT6vca9KWNYht8ait0yxDecWiN8Ls/7W6JWI+6Ag2W6/mSU31NlDt6b
 QGGE1PGnpG6rtaXhKXjEpPHI9+LDORWjH+2e9PWwCH1u7+VzI64h1EB0Pv0udivsksKl
 vv3UC4ky70MTYnYkPXTjVt3R8sh7yShSFe1MT87xND71DwzqRvUdJK/f7esaTQfqtIuH
 86HLEOFS3sWx4eCxd4s8/4HFP1s3AKCgjrjP5PEKdv0jt/W5Hjg5QsMllGPpIjP1+yqu
 arpjCAV0q4D8mmnmDV9KjXKfb1DINvFWGGeHK+W4IFYZWuJ0FLP17OEPqY0sjRS8tbFX
 GXxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTUbe9Nvi0Z2p6Jfz6LSSiZEUOHsySBicrUmgy6pfd9vYw9soXwYIUgttYCcKOqT3LYXvRDYw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLc0S42N4iOz85gmFrV27BbwLzr9LFWtmJRqXCZGrEGpRiL9isq
 67K/3ykobqWpEDOFtfPA8gjT5cxFq4yu23ysFrpBtCjsIm3rsbvdnvlJFdfqX6lpgsfUBRIL+vT
 I9VLcCuMRzZg61sD54P9sG+/Ie0PaRmkF1dS44cct
X-Gm-Gg: AYBFou35hcGJwvxvNRnSySYYlChVyjRSRdwSD2i6+ODLFGd5GxH0CmL84kEGenj3IvA
 oucRydqCZJpM2znbWJbD5eWsuRj6UwGQRj4ZTNu9kCMxbza0nv9WNCEItPUN0ta5xYBOr02y8LS
 3LXF0B9Sl2B4+waijsd3+UA8A2SuNmXU7HzmqXkjSjJdtTa0Bgxqzl+YPAcFst72Y9EEJIZyHKR
 V1pu3nP+ew93TtxpEQo769GNXQzic5Caoozmy/YyJClpaEuTo5ovP5DQSOFU+W7xJJ3FuSe4WXO
 mvGd6POZhMolWhN7yCn/i21MIORbAttVZc6rRFJ/GhpQkvjYYT8SbHN0dslaIqZmg5Nerfk8pbM
 dEMcp707G6RymcqmpIVsT+GSkY83YMud847k=
X-Received: by 2002:a05:6402:4045:20b0:6b1:e072:763b with SMTP id
 4fb4d7f45d1cf-6b47bc84c5cmr3670263a12.5.1793186599967; Wed, 28 Oct 2026
 04:23:19 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 04:23:17 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:25:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <497901c9-56b5-4e94-9f9d-7430c7cbafa1@gmail.com>
References: <78892543-03de-412e-831f-de840765be59@gmail.com>
 <497901c9-56b5-4e94-9f9d-7430c7cbafa1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 04:23:17 -0700
X-Gm-Features: AclHuK_iIGrBEXpbKOJqhlFRp1REUoIqctVotI-5W7-ZwoNuFihjnZpd4TjMS-Y
Message-ID: <CAFLszThAS+yMkLW-TeK6ph+pkgxcakd_UyN3g9L4WpdXN+4bDw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] test: fs: ext4: add tests for corrupt on-disk
 indices
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T05:50:47, Ana Bobillo <anabobillo3@gmail.com> wrote:
> test: fs: ext4: add tests for corrupt on-disk indices
>
> Add tests that make a small ext4 image with mkfs.ext4 and check how
> U-Boot handles the on-disk indices that the previous patches check:
>
> - test_fs_ext_oob_extent_header: an extent header with more entries
>   than the inode can hold must give "invalid extent block"
> - test_fs_ext_oob_extent_loop: an extent index node pointing back at
>   itself must give "invalid extent block" rather than loop for ever
> - test_fs_ext_oob_triple_indirect: a sparse file must read back
>   correctly through the second and third entries of its triple
>   indirect block
> - test_fs_ext_oob_group_layout: writing to a filesystem with
>   s_blocks_per_group of zero must be refused
> - test_fs_ext_oob_delete_block: replacing a file whose indirect block
>   lies past the end of the filesystem must fail with "Invalid block
>   number"
> - test_fs_ext_oob_delete_inode: replacing a file whose directory entry
>   names an inode past the last block group, or the journal's inode,
>   must fail with "Invalid inode number"
> - test_fs_ext_oob_last_inode: replacing a file whose inode is the last
>   of its block group must work and leave the filesystem clean for
>   e2fsck
>
> Each image is removed and host device 0 unbound even when a test fails.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  scripts/pylint.base                   |   1 +
>  test/py/tests/test_fs/test_ext_oob.py | 310 ++++++++++++++++++++++++++++++++++
>  2 files changed, 311 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

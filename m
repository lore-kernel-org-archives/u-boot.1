Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3707606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T54sIEip;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Lv7h+8Hs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD04940707;
	Wed, 28 Oct 2026 08:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZCUa7Rvi-wI4; Wed, 28 Oct 2026 08:57:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CEF7540641
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177834;
	b=f96db344PpjIkXznRsIywEZJxlQn5xdW4owOfHjEf4FELVP7Pa30T2mt+KlAdhiFHsXC
	 K62ofy0zDiXrd4Qz0Bu5py7HUs4cqFuGWXA7L6ms67uvKh+F7WLh8wQR1NEB9Ov7moqs/
	 jdV+Cg0zXmSYoiTtSSnabFAggy2dBIH15GzHERdPgOmP31RSQ7FzDebIxO96Pz2alVKCP
	 2I+KZRtWgei17BiGtdAxkFVEiBBoCu9D4o0dYER1y6tIk2Vg5qHQKhHq4lEo2EeJGGXFI
	 AdINIMYNH1iuIS2Qfyh2W4xCPsYMiEBZ2+R0DN5EXruPUuc7vkX1JJUfNiSKcbkjEBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177834;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=u25JjEZK+5drCTMnK+np9BZBNyznuorOI8V3LP4wj9c=;
	b=q6ErgREEcE3WQGZ6szMVWcMaP59jgLpCDGIWis7Cchv44UBOCYBcTUh2AYQOs++BOg5K
	 wqk0AqmPV9nIcSU2LkM+lgM2QXz0ByCWmpCfSFHc+h+/yjHuGjKJzNpJnbXrxKOZan86z
	 kL7ZWcT+4ALqN9zDWy8eUKmoHM6KU8yfi+NWb8mi7yGmIf+Je1edtoNO7giKDnhCD/U1b
	 E/iLqbzxKRoX47sxZ7U+awsVptIU83+xjTK5CIAw405lxY8pd7IQxQfwaICw83YNt31WQ
	 qZZr4EvEz11534gMowl1fgCdOA1/jijTk3zd3UL1fB0l/HZHqEovMr6ZXSAOENWmoeQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793177833;
	bh=u25JjEZK+5drCTMnK+np9BZBNyznuorOI8V3LP4wj9c=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T54sIEipz3baB4hMJ7Ry77JQKSCX0cdvhKmSE3q3UfxbcBs9TZS1uHhBbUppzQaKH
	 DqFkbhGldtaKbilrIRqV61uJveB617+mmFAhAMDzbWp+DHIItw7/+XIvHjEVonjd34
	 5ND1oC7XPwaj5nblvTRVgVZELUu8Yg6LpvY+yQsPgR+J5uvUr0hvtT5sn6clQRbGRm
	 tO5Ny74KwOHSPbxIkkPfcmVCcRlGMnXCMMt03spfu+95z19yBegMWkKJ2wIXWvZ7tp
	 lNNLO5oHAcSgcM4whQFLG2rqQRm/BqSh/DqNSfyjkXZcArI8ElPz9krwPYmUDPPZr9
	 gSvtgoNMUFCyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEF7540641;
	Wed, 28 Oct 2026 08:57:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70D23473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62A6F4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lzx4gCciIgeX for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:57:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 992384004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177831;
 b=G0TyEdDmXsnuBXjgALZONoqti2tZqkjH3uQou1k1KdHPu/ZzidfpxQm3/Q+Mu9VZAf0D
 mOoY+UxMghHeJFubDAY6b1xoirMBii1B4ZutEPdPzGEBisUGdpAIM38TzzHLzpRXZons1
 LTCMGTr+onRe6BonrdW0z+Rbncv9tYRcdpH/+zaND3Dy6Maj/kgakUIyaxu43Z1shEFO4
 SbCx1coUNAR9mLpqeEk2Avesw96I0m/k9Cpt+6oJdQoLs56+E/B6eD4Jt4K86bImnq2Dy
 V0VQHi471K5YOvNqGd7SVlRlr5Q7igiNaUXnj5gEd57f96mJhRP+a3/MxudRq22y9wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177831;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=u25JjEZK+5drCTMnK+np9BZBNyznuorOI8V3LP4wj9c=;
 b=VDvsZBizfQmmI5OeT3fHQq7slRHQaafnvTQ5z+SqFsfWqij6LmrMmcIqR9RT6KHIAg6E
 LS251k38t4v5y9258769mKJ1C5I7NtUMJt5VHekyd5eGk8t8LPYaottSb4yuNI8MBSQL0
 R5dcVQ4ryMdgQ7hMh12lfySyUwBLlZWp4Agz79z3xS9n+gvtxiCfsu/pa245fEJeVzdgu
 Fvb8DsqxthhPvYhfz7DjY++vsgVz4usX3d1Brozp36uHwMmsR7E0WXd4EMRcggfS4e3E2
 Fw12nULb8r8zjG7QYKdbz0B0kxmDALfiLIS5JWrEUK1IUlawru3gRSV/FVbXqDxO1aw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Lv7h+8Hs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Lv7h+8Hs
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 992384004A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:57:11 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ad2b3b1c02so395832a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793177830; cv=none;
 d=google.com; s=arc-20260327;
 b=sM0ZBeB4dYvq2Gnh9HGXRVGVtJrF1y9iB1sUDzKlylnTme/6uqfOK+rnyU/NvhukRD
 PtfUfckbzD/mwBHAB5kxvPyuTN70rL6+sZEQGscuEGjncpv7HjRgXLMGPem+rLvj64Ke
 ZRFng/xipumDASTrvYjRUHD7qCTtWDWI6szZ+H+8WIYhVPTFg0GtVZrCx6Kaon3TtoSL
 5JOEGTCmvhrse0t1WbFi2EEWM4NLA+ZaiefYNAScpsNJ9UPJ0dKepKgDT2nRKWs3I9wd
 C7n02TEA46ztliJPODzU1pfDfpdlmIAnPvyuqFyw0ICkWloXmmn5+GzrRpOugt3k4Vf9
 Ujmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=u25JjEZK+5drCTMnK+np9BZBNyznuorOI8V3LP4wj9c=;
 fh=xKmn1IxuPtLNhTdUwgNdl1rcuepKZY28rtAosjSIjeY=;
 b=WGZtaw/OCAlPayqqsaqFBBFdA6xCBTtrWv0ORA+vd91sZzl7cFApkZgAvrX99ivMDx
 ZVNPWiJ2frM5g0E1o5CvnFjBiOqjKoknv0OP5DkmZyM2xggjjWSAv71fklBlGDSZeAza
 PR0bMt5RaRjnUlfG1FWsVlY/gH/VqYqSpv/A7KKEK0+yRyZuw1thnxLn97MVv2eDEjgs
 iVNNGHzCKykYFRZnn0MbvtuqKdNVjW94fQH4/EYcQjY0VOIfWq1mEdTVo1lQRt1bBFBP
 dEG7ygAgr4Y1gKL7nPq/yCgFsuehNu879DOXOhsJeJlZMg8EoBri8VTbZ4OkAe/fdwIz
 PbAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793177830; x=1793782630;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u25JjEZK+5drCTMnK+np9BZBNyznuorOI8V3LP4wj9c=;
 b=Lv7h+8Hs6K/TT+ujIopX5qqKLBOyzQF9RxnXnAskEZQAmeSu6wa62yKuBAxJZ0fPgL
 3Htu+i9ngda4/5baJDuew3bZpoKwQuqcyjS3aH3ysqfYXgYYO46J/sYX4OBVW5fIjBgd
 R4Apj/MKv3HUIcRqoyD9smipy5EG9QNxV7tiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793177830; x=1793782630;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u25JjEZK+5drCTMnK+np9BZBNyznuorOI8V3LP4wj9c=;
 b=x5KUec61auozriAUZxh50+I83UohBkYgvHr6KPdfe+lJmtpnqPOWJzTYGQnp88ILN3
 GWcksvj2N51CfWlLJxdX2V8dLDjxdX/A/FcOre5tvqaO6BdtYl817gup2BBrN498Jb7y
 8yNMuVX28ceG53S7kN0a7s95C3n1+/fOjv/9Webn+t6h8jX9MaDXQ7binQ9JW4gvjNT+
 Ypy2E4adc/Uuvm6nEMhfDya2uEwZInlk9nNO4amWsFcGKAzX72Cehjvxn6Rf019BidhQ
 yrxLbGYse+Qh1cT9Ti2j/3EenDRkYcr8tuRvJGuPcBWpsMRn9fCLnMhUuHyXNk5sBD3w
 kJZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmZzp6v+2apcoKuaEmZeVVz7wDcU9DSaQymvcwGos9KIa5Cp27ygl9UD8IWEZ3hffhkKeFYS8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJPLXefUnGsqsv82b0bRuUuu8MkwWcoQZO+GACK2IxlAL9EyylW
 82VBO5ZoxJnEcwxmy+8ZzC7+xoqY5W6NCbTQgmAYBZLr3HqvGcGCYydwLfNN9vh9NtVB7ZkUY07
 HROmXzUzxNXmsw4kGz+6TLcBc0Xlu3jbbP5mcdsxo
X-Gm-Gg: AYBFou0AqT4xtAVp+f5I6QmzjaT57Bu05rL28aDC6CYRCytIdeu/76Pf7ka7PkI7OuS
 SoKbh8TluYIHlow1t2sc0M2Nwk+YqROQtNnkKeC9TNEZ864UYq90HXcPrxtCB5RYbYL6GuTn+rW
 7jLR8TTRHNgDsFGvuHX5RaIABhuQSUnPBkWV7IZQDFZ4GGv7EA4OeiA4g/e++Eufc5obhoILU1H
 2VW+B1ZvacrOoh3E6KXJWo6X03ONeuax3xLZdP0hCEM2KQAcvZwDE5XQaueL4fVqqo4kj07tbLI
 xeKtYwjSB+RP0dqL81EAa2nv1A+j/BzDs3dDJFZ5xKIeqgPGf+0ciDAui5LKjruA4jNyDsuK0On
 TsinoqodBoPWQCuU2f3XaP5x/mCQZdS/jkTaU
X-Received: by 2002:a17:90b:3905:b0:3ac:7449:40b4 with SMTP id
 98e67ed59e1d1-3ae5822d883mr1192717a91.45.1793177830610; Wed, 28 Oct 2026
 01:57:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:57:08 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:29:48 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8dcede4f-fba2-4635-b8e6-93fb35ae07ce@gmail.com>
References: <01ba3f81-06b7-428b-9224-bd887c35e1c3@gmail.com>
 <8dcede4f-fba2-4635-b8e6-93fb35ae07ce@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 03:57:08 -0500
X-Gm-Features: AclHuK_u8phXbNXG6jy7XivhlPmh59OVguyGLMWtcaEh8xGjZjN4iyjVp0NN1x8
Message-ID: <CAFLszTiprHQ7o0DFL2fZPZ5OK4zb6LB9jNAtuT5SU5uuMGuXJQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] efi_loader: Measure the GPT the partition driver
 uses
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-28T05:50:48, Ana Bobillo <anabobillo3@gmail.com> wrote:
> efi_loader: Measure the GPT the partition driver uses
>
> tcg2_measure_gpt_data() measures the GPT of the disk an EFI application
> is started from into PCR 5, so that a remote verifier, or a key sealed
> to PCR 5, can tell whether the partition table is the expected one. It
> reads the primary GPT itself and measures it without any check, while
> the partition driver checks the primary header and entries and, if
> either is not valid, finds the partitions in the backup GPT. PCR 5 then
> holds a GPT the partitions were not found in. Unused entries are not
> measured but are covered by the CRC of the entry array, so a change to
> one of them leaves PCR 5 as it was while the partitions come from the
> backup GPT, whatever that holds: a disk whose partitions were changed
> that way still attests, and unseals, as the original one.

The commit message is very long for the change. Please can you trim it
to the problem (the GPT measured is not the one the partitions came
from, and its sizes are not checked) and the fix? The EDK2 comparison
and the test-case details could be a sentence each.

>
> The sizes in the header are not checked either. The entries are read
> into a buffer whose size is num_partition_entries *
> sizeof_partition_entry, worked out in 32 bits, and walked
> num_partition_entries times with sizeof_partition_entry as the stride,
> so a product that wraps, or an entry size smaller than the GUID read
> from each entry, makes the walks read past the end of the buffer.
> [...]
>
>  disk/part_efi.c                |  21 ++++
>  include/part.h                 |  26 +++++
>  lib/efi_loader/efi_tcg2.c      |  51 +++++-----
>  test/lib/part_efi.c            |  42 +++++++-
>  test/py/tests/test_efi_tcg2.py | 222 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 334 insertions(+), 28 deletions(-)

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -875,6 +875,27 @@ int gpt_repair_headers(struct blk_desc *desc)
> +int part_get_gpt_primary(struct blk_desc *desc, gpt_header *gpt_h,
> +			 gpt_entry **gpt_pte)

The name is a bit confusing, since the GPT may come from the backup.
Something like part_get_gpt() or gpt_get_used() would fit better, with
the header comment saying that a backup header is turned into a
primary one. What do you think?

> diff --git a/disk/part_efi.c b/disk/part_efi.c
> @@ -875,6 +875,27 @@ int gpt_repair_headers(struct blk_desc *desc)
> +	/*
> +	 * The partitions come from the backup GPT, as the primary one is not
> +	 * valid, or is marked to be ignored: give its header as the primary
> +	 * header that gpt_repair_headers() makes from a backup one
> +	 */
> +	if (le64_to_cpu(gpt_h->my_lba) != GPT_PRIMARY_PARTITION_TABLE_LBA)
> +		restore_primary_gpt_header(gpt_h, desc);

This comment does not hold for the ChromeOS 'IGNOREME' case. There
is_gpt_valid() returns 2, which gpt_repair_headers() treats as valid,
so it never rebuilds the primary header. The measured header is then
one that no 'gpt repair' would ever write. Since the primary header is
deliberately ignored, I wonder if measuring the backup header as it is
would be more honest. Either way, please can you correct the comment,
and the matching claim in the commit message?

> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> @@ -1202,40 +1203,36 @@ tcg2_measure_gpt_data(struct udevice *dev,
> +	if (part_get_gpt_primary(desc, gpt_h, &entry)) {
> +		log_warning("No valid GPT read, not measured\n");
> +		ret = EFI_SUCCESS;
> +		goto out2;
> +	}

It would be worth including the device name in the warning, so the
user can tell which disk it refers to.

BTW now that validate_gpt_header() ensures sizeof_partition_entry
equals sizeof(gpt_entry), the two loops below could just index
entry[i] directly. They also use num_partition_entries and
sizeof_partition_entry without le32_to_cpu(), which could be tidied up
in a follow-up.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66913C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 21:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7318D40695;
	Tue, 15 Sep 2026 21:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j__b-UePpW5K; Tue, 15 Sep 2026 21:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8703040688
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789507411;
	b=q+19QkhJPdOfHaFYI2p45tWwo9GQPba9lDRkpIaSC+07RrD3VfKd+ljQ13iWMK74oY7t
	 NgpTuAQxuEWHI3Cink+oOgGZEDQhfLY7Wy+h81R60kE2XMwT+yiJrXqMxvYD5iUiXyFey
	 YtHvVJm3JHM+QNxG9BXjrg8UYdWt7iQeb/wZz3cP3hcLgaVs7zsPrEEquYeEpRFf+CNqq
	 o468LJdMI4vbUzHPQVfrTLGPcrqMPeb4YKxoy/g2s6nUnExz67YzE782fzUCZAJiE6vOR
	 2sDAl+GHaqTxKty+kxEgKlPPn8NQFkHBUPtjDcnpdobFzF+tTrLcdB7miS2TvjAZqqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789507411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5imiqvAA0aJ4fDogHrq2jW59qFAm4PBUJFWdh7gljeo=;
	b=LCRdglc57246qrihwB83XNYPAGXzHA3aBmCWV50xn2b782bc2PoyAXg7iaitLmnimqV9
	 Nwsf2FBuX1onM3fb82cZ1bSRxE1NlSfZ1gvEjAXxYrVfFkSKLMFXZOIJ3AmtPPZU5P91R
	 cKq2oXvBdB6S6wRha3WOLpPghgPiWwn/Mrls4AhPg1SsTjR8c8+BFGJdB7tGdR3K1KLnD
	 tV/obpP4r+st5sOh9ZGV+U83SoMixgNHVjHYtHYbtPMWwJfflPx+Gwtc15k6Sfk7lpglQ
	 T39pM8SpFypxaMcvcbreYa0hqBeM24HPEcIuaptJbgiTScLZ/Sx8NZZyQreEDcKCgvg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789507411;
	bh=5imiqvAA0aJ4fDogHrq2jW59qFAm4PBUJFWdh7gljeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p/fcl9qPPytY5Yrbm5SZZCNdTCoSz2sl7vv5+feTLuMtYyBU2t+kgWzNGw3dpvLrv
	 S7Y1LExYRymZM4STN91HUjQyPi2Z02vYonVdeddK6aHKzqezivogHW1n1ArcZpF/I7
	 Y7qjNi8W94e8BM7/T/oGUzdFlkKpESynMva77z/tiDMDsYhzlgSe/rXEMGdCfDzBHZ
	 CrPZho1eoJobWXKWcVZMtVR9SCT/gaVqyClHNZrfm1BrTZ0xBaQ4MxgwTG74alqaN5
	 UvG1huYKURX+DtApmvDxA8Ji/uROb7qATqP96JC8apE8QGjwiNl1yUD/LcE7YWJAeQ
	 nn6rhAyY0lDNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8703040688;
	Tue, 15 Sep 2026 21:23:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E88282E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA00040248
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:23:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFFM3PVInIPe for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 21:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AC97440232
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789507409;
 b=dlRAhzLIWvrcCrhpQd7KmICLvhQM04YLFWsYNrxqcukKr1lA1ai75ogjCG2klYsJPl7V
 CuLjzexQAc85Asesuxvlfwsm6HCQfxlPb9HGx5KtI1yxKVEoSEbX8YIZYCdzoTdagv3uz
 /L9ZOlASrPUy7FRT6oq4XrFMtZj0jcwM8Q1v6K5R1wpfjXCvGk7PBj1lteOAiLw6jjHXX
 Jtywi+Ym8iipIOS5ZX0hZMLlit/nZzTUE9WtOwWmy+4BE+NFjewRUmos6G06pvYn2QDIZ
 rFHv3TLqfxbTUUqjyXyqR2NrbEkCh741dtyIpI4zp7mqXnWLmE9GA3Axvlr8g/jDoGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789507409;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=5imiqvAA0aJ4fDogHrq2jW59qFAm4PBUJFWdh7gljeo=;
 b=siS658pHrFdsdbiPhgiIrSmIHBn+3xcZj9F7SGHaOfwf8s1+ELR1pIKpeRj0yJTUmWw9
 MSHvoZIwJEFpKlMuNzupxYkLmYL6FOfGiLpa3ggAKEUJ7fFiUY4XOMQAdnGucn/uY4DDQ
 wMsQQyG7yfrWEm+xFFfouxSxq/Yztt0N6g42PTDLJQ3sdcjHrgRAoMj9I23nvfdSrLrQA
 FV0w0b++curq2oXpfIzPh9iWdCtCbT6KiX5lBfjgUpBMAXp+SIFo8WOu2xs41prxig+aR
 DYs1Bv7xDqfPVavQSRH8msbbrfSitL4gYBYS/HjkcvHg7/WWUJy+CGzbHNQjHg84nBg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rU27i2mz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=mibodhi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rU27i2mz
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC97440232
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:23:27 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d4ddd17a0so2289997b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789507407; cv=none;
 d=google.com; s=arc-20260327;
 b=gTaV1fXwKgQU/PBedPgYHKEn2lcY/z3x+SLXcAxn0TdocEzYKC5AJyB1sMS5peOjEY
 mgpWXcnXV/D+62JznTyL0Bm7hha1ohq1cWqy0eYFSjtt1bXo3yS4NOzssuSiu8t3n+cI
 jeaIeqkTRsC7v5Mphjf+8Auahs13RQch0mHfZJtiVwOtH7afZcqCw+YPLyk+Ivw1FCFa
 uuWTMFK6YTrQBpz/NdqPIOplsl5ckQyH+A5cOZn/AUnabvDLvsaJBn1mFNeH6InAVlqg
 SYTH6e+5uTYWncNsDTZRePO7cTPZMHw+rL+CC/u0BoGaEU6OMKXxerngC3g46KgV9Rmw
 C/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5imiqvAA0aJ4fDogHrq2jW59qFAm4PBUJFWdh7gljeo=;
 fh=ugAcomUZU4t8+dxpBrkmWgXtyg4eB4e4P9A8F8jomUw=;
 b=rVku/gMAeItd/lgVHQx7CamnWSHFGp3wbga+R0oMIkwsICum+khcR4BkYFJUiMBMKn
 nDbd9bDi+iC76t1YSB4A2ckpNTF4dwPjtd341Whw1Jp3R60E4vwxBxosq2HWwyYSRHQ+
 cIDp1z0GajujUzKm8GAse95tvItqOjmvYZCH4EjhEorfxfCfNXBx0koICdlUCgfXeIzg
 htw2OeWgtJGh737F2HmsXuiv2g6v+mTXEeNWlAtoa+OXn5SETyL1BE3EF61GJy1EM8cm
 0GLRy5x5ImxA5njMGjSvVtuiORGtsk0dqBPvBlRwe3lxpIt0lqWkkHFcW5XxIzwWGJQx
 5obQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789507407; x=1790112207;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5imiqvAA0aJ4fDogHrq2jW59qFAm4PBUJFWdh7gljeo=;
 b=rU27i2mzEjPKfwqomX80Y/ILFsQ8xCEx/tZwhZZZHZ+iOIJuAtn3kaCWThx32pOB8V
 uUVKQEEVm3hWoflcWW0PMT/4cG0eq9yFaGCUaJEQcnEad0DC3Ii+M91ZDN1uN94yT+XA
 CnskQSYt6iD/P7kV3EvZb7aJwXT/ohkG7XlAqTsW+ilHTK/dV6mM2fQlM8JMb924MXaW
 2Iwi1hBLzS0dmHPh9MSzo8NyOpFC9l4GX2tcEaMCf3C6qD5QRQvtF57bwTOT8ZHt35VG
 6Omjr4+GnyKyjSptuDevccJYE8Mx6YfdGKehLCQoHsMezznAtQ9rXj+j+NpPG3HF3eQr
 A6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789507407; x=1790112207;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5imiqvAA0aJ4fDogHrq2jW59qFAm4PBUJFWdh7gljeo=;
 b=CN24B7quqLuEdrbBnR9IXcZbBEfztB00f4CsIirWU0LQ+WSg0AVYn1sFNsmYVjVDzj
 4ah8lEYJjjpgm+ThU6uiPt7d9WVClxESFmoEgx0u23rQ0R1b/OLIUylXK+0vbOuBfDH1
 M4q+OnLLxL+uzCvwTI7AcS93cZ7CO04aPZN1JVRUHZ7bF7dc2458B1l/YZzjD7JMp/61
 cn3f8yHQTRncljDUzlUmZ+W++GC1q1kNIHB1NMy8MSBBnC1svxv9o5fqWlfH14Zfgemt
 mg0Hxk0v4YHe8+2Ieh8kM1FN0hq3STY5RhYk82Z4wUu0Kam7GBymIrgfMZd1nuCHKJ0O
 FRhQ==
X-Gm-Message-State: AFuF++l54fF2RbHUG94vI6H9aqQ1OExVGkzRhFS9keiLyYWCfxvB2WX1
 7sBPEgCQbPc4IL2HfzwtyrmQ+Shod0qTOAwZYlud3QPn7/Y1IGDje7Mt8cQ89uiloLIeB6G7c6f
 QS/do6i3XqLT7QBXe98DmZZLdPpYG+Yg=
X-Gm-Gg: AYBFou3EwcZqOrWYZhOQpk50OmN8ECU4hl/wpxfX/7/evj2PBI45jJuiloYwD7ZMt/X
 1jVm01fXTZwM0QOcxoaAsp8e94UhW8RmDi7vJasORAFeW/B+oyggRiLs/qJ0QGcoeGFUHkKQ9xN
 gGk4zgwM4fq1W/k+vd+ozkSL4GZBH1/vSDkXgTk1aMsYJuvuFZ635UOxd8/3LUM26qIzvPBmwKI
 +lA80x1wYODSZJxLru+Xqwvwk+xvItC0IQEuf0B8pDGRbhNy0KaImhwZqTB6YOtIau+yX4NTpbo
 8dixLK3bh28lj3gIN/FaZZ1KSEZbc7ID9FdRh4JyhX7B12skQ4eL9Rjw
X-Received: by 2002:a05:690c:31a:b0:7e8:a091:6c4b with SMTP id
 00721157ae682-89228fb6e39mr1699037b3.24.1789507406716; Tue, 15 Sep 2026
 14:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-4-sriramsriram@linux.microsoft.com>
In-Reply-To: <20260915205210.260404-4-sriramsriram@linux.microsoft.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 15 Sep 2026 14:23:12 -0700
X-Gm-Features: AcwNN1VIEsQxBN1tNj8eSGl2R-ViH5K018_93HJO9nuIpIGUfAkFDVZHeboKahw
Message-ID: <CAJaLiFxMbEO1hk0o6ja6w1SKN-hVK4tGkvUo90uO+eFgAc631Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: ext4: widen ext4fs_update() block-group loop
 counter
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Drew Kluemke <ankluemk@microsoft.com>, 
 Daniel Munic <v-dmunic@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sriram and Daniel,

On Tue, Sep 15, 2026 at 1:52=E2=80=AFPM Sriram Sriram
<sriramsriram@linux.microsoft.com> wrote:
>
> From: Daniel Munic <v-dmunic@microsoft.com>
>
> ext4fs_update() iterates over all block groups with a signed 16-bit
> loop counter:
>
>         short i;
>         ...
>         for (i =3D 0; i < fs->no_blkgrp; i++)
>
> fs->no_blkgrp is a uint32_t. On a filesystem with more than 32767
> block groups the counter cannot represent every index: incrementing
> past SHRT_MAX is signed overflow (undefined behaviour) and the
> comparison against the unsigned no_blkgrp never terminates correctly,
> so the bitmap/group-descriptor write-back loops misbehave. The mixed
> signed/unsigned comparison is also flagged by static analysis.
>
> Use u32 for the loop counter, matching the width of no_blkgrp.
>
> Signed-off-by: Daniel Munic <v-dmunic@microsoft.com>
> Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>

BTW, since you are testing this ext4_write, it might be worthwhile to
see this commit:
https://github.com/u-boot/u-boot/commit/53cc4332b3b37218a7cdab8bdb953da57ee=
c2668

Thanks,
Tony

> ---
> Changes in v2:
>  - No change, rebased onto current master.
>
>  fs/ext4/ext4_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
> index 1abedcede72..2fba2197c19 100644
> --- a/fs/ext4/ext4_write.c
> +++ b/fs/ext4/ext4_write.c
> @@ -67,7 +67,7 @@ static inline void ext4fs_bg_free_blocks_inc
>
>  static void ext4fs_update(void)
>  {
> -       short i;
> +       u32 i;
>         ext4fs_update_journal();
>         struct ext_filesystem *fs =3D get_fs();
>         struct ext2_block_group *bgd =3D NULL;
> --
> 2.49.0
>

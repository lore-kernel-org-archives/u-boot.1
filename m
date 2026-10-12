Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D807CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02038404C1;
	Mon, 12 Oct 2026 13:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5zqgTPDAVwx; Mon, 12 Oct 2026 13:57:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 302D640467
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813458;
	b=J0bQT3ZaIp+SxJ2lNP7vKdoF6Buw9XU+pm6f2FsPxFOqjmPWyjEzdz/7xgguzjEb6HJO
	 Kee7xWuT6ojw6EU6BI3cccXq6nJ5KWbCQQY9A3kDnVhNUNOTyTLlBhrEunU8fdqT4pILN
	 +hUoV3fM3+WH9MlzOGrCztghlX9+0PWleKIbdqc8Pdx6Uy9EfnmpC5WCFQ3d0smc5ORVo
	 M1SrHpumNstMWwc1GVayOw9/8gTMHu1w2GMB3aFBNWs9fhoDPKUIAbQdQjtilnOOE/rcd
	 62ALo+9u/s+FRZJCYbz8P28ZGqudHDT1lMhsLZ9XOZJVx5+WfEeOa3CWM/SummJ+rqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IcPZwX0GOCRODbgDTWtpAp8OmSX6p/slAC1EhlGzNxI=;
	b=HCNpPQLk/TfPmDkaaRoQ0WO3rx5kPE7NvuoCCeMnHCvJkwx6mSV5Z//BPH7jJ6EKaywW
	 blsLtXq5CQVV5bFzjpjm7cEQuoeYiTdPsOpTbFR241RqokZ5ld1SwVSDGKFL2VLPvkP3o
	 hkRwGm3JO1JEMUyP6cHLyJCAis3cF2vZSfZazjXNIpK4POx4y6UA3Jt6p5NSF4xnROVXy
	 8xKKLsWs4P9RpRoZaCsKZgDsoYCiNJ/mF0+EHXCZjGm7Cm+0TjkrLKBpXXLR76VhNHsNu
	 NKeAVAV7gS+MStYSd0UBRMduZIut7c0anegiqO/9Vg9Z4GyzFRPBqarNp8tb2Emq5MA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813458;
	bh=IcPZwX0GOCRODbgDTWtpAp8OmSX6p/slAC1EhlGzNxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fpf2cNEFvVI+oajpoA4Jrv3Ra3MaMxJTPXsfxloVr9X/ptivc7N3C5LZvUv7cEOeZ
	 0MrACIZYGEFflBOgFic5OPxJVa76FnaU4PjbgbeqZbHZZUDcwcicoF3xufQIQS19mk
	 iO7+6ZB0VJfaKw+DTy8UghZv/rq2J2ScosVE9S585h+A9H9uj00IVa4w0UwLwHrtDn
	 wrTufgiJ7EpeS79OzHfXHguZC9oU8tQXVy/kct9Lb/YeriBj/7nGoffEYUHGhNCjhG
	 KbHgTlxv2DTtLDzMw6dIL9bdKtBY6Zwz4awJEyZI9729ToO2j753GI8xm8yIJEfmop
	 zvo7hH1QE8Ocw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 302D640467;
	Mon, 12 Oct 2026 13:57:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28E7D156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2699E4010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fd5ASGlntQF2 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:57:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BCEDC4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813456;
 b=Y/3fI6NJ5Nm+ftOKUw2A40/KYSL/MITl5jAyCp94ZkA5i62i0Hw+7uv47M9lRxqN475S
 1HrsNsIZuP17LnZ/jWwCHjSR9xHnFkRyHrYLCLPU7zTgAMPxi7bOm2KyEHRska08fIDxk
 vi54ZtpAqBH3mzpWQhsR8yjJmIiE7ktvLcfKSnGvznX+nLWfSmvjY9ItIiOuZWo8Hje/r
 2/XNbzZeCgrb7uBMIuAWfsDkCBlLJysXpKUZBBjrK3Ve6mkGg4q2Zo7Ze7InSAu632V8G
 ImNn5xrs3TOgJykTNR9D0rNOrIwweednkvrQMy9+MyAsElC/INLEoriYVywLsbJY6FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813456;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=IcPZwX0GOCRODbgDTWtpAp8OmSX6p/slAC1EhlGzNxI=;
 b=EKoqQkh0CcHagWDbVFfnCZfTwX00tEAhj8HeLzidFuaY0bHlCmb/8osCinAdnQiJsN+v
 aUeAcHtA9weGF9R1ckA1+ys8q/HyML+o3uxmnIwsEUwXpUnw+GcarEiw3+K67bACMxA6f
 6vKf9wdm2rD1ibQUXAkjCHILW3EuyG9Af2LnUAuU+NhLW+kSMu+WhDfabJOEWRkK6Oyyc
 24ahlsua/kfc4KQfrXDtG1xraEQ5Tjd+/LeqKjBhq3fGr0c9AuRylFBT8SY59449CWdCX
 7PDmEyJTC/GfuE9uMv/1gBEMF4g8IwkUlPPbsPEwp6cMEYtbxxTT+aLPZBU0J15VXhA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ljTYLrc+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ljTYLrc+
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCEDC4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:57:34 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab02ba4dso1846654a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813452; cv=none;
 d=google.com; s=arc-20260327;
 b=GuJKmgUPIBJzP/uz3uuTk9B66baPlgKcJS8UmjziC0XgCD1zR0qbc7b2+yHOA3YZMp
 DLfG9USda/9u93Sw7qfhaqTP6D2mXDG62RGqmzc9Wc29v95+1kPHdCcN3VHIVP0F9nor
 sw4j2Akbii3noi5eKK2njPLY66R7nmrkXQsYxQl2090VaPDANXku6zd/3piQXPKKkJvN
 pDH8xnODpaIGIJIz46KLa5nj2WqKMd59l8kcNJYH2FoFR0VR/J7JkXvFEu/ZM2W6ORji
 iuJEWOTUHoaToTSXWfSMcaf06U5TX+5I/K4sIIRm2RBMi0JjiXat/yvG1OFh2OTHsG2X
 X3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IcPZwX0GOCRODbgDTWtpAp8OmSX6p/slAC1EhlGzNxI=;
 fh=8kLy8Cchkv6HU01zDgapzB4SRbyqUfaRhLrjroAK5g4=;
 b=Xd2cIW0OzU7Pnys17uJSyR/DCGhkCkk/mBk+3Jx39Nw1pFF4iaxFl5MBNXEGHuBVe8
 Vi1y2Ob5WX+Rey9o2Yb8GKzjYjHTOgugMLWIobroh5Pmaxi2HzhIkSzJqQ+LArj3BGba
 NgR6BKxtUJixWjCsT1QpWaJhBuahtW13nV6SqHJRWYPNVMAvc+72TmbDmbIy2jHxkUfX
 G11sEAiXp7/8hqqUa6wYoaExFzN74DJnQnOJo9NgkR7eu274ZWVi7EDGkZb+9ebcGJVx
 HJgSfhDkeHcZz9zUMIQsnRI6qwRiFLdMyfV4LCuy76Q0gHTqeRMzvgv9KWgypRbFBB2u
 xDuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813452; x=1792418252;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IcPZwX0GOCRODbgDTWtpAp8OmSX6p/slAC1EhlGzNxI=;
 b=ljTYLrc+C8IU542SxN4CUSyPaZ/NDGSbp+0SH1Qc9ftvs8qgyBdp4x9l4+NfR22Hj7
 hC1SBp6iPugY0aNU7b3Ho0Ogr1Uc0dgpd/FXWbuaVfv9RLqHvseya3A/Ko8bszfD6nQw
 g4IG475zi3052DHY3fWcOx0y3Y1KeaawOC4aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813452; x=1792418252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IcPZwX0GOCRODbgDTWtpAp8OmSX6p/slAC1EhlGzNxI=;
 b=kSRkbfO1QX1Lb2FFVRyWvCfHTcXjNu5XsR9WoVM0rEb+xUM17p8foNHeWpqMcZ2y8s
 YhB0zmLx8jpGkjPuZrZRCcWpk15De+WodUpgrclrga0g4/fK2NLBb4g7qrgJ98vFozX2
 NHW8JqsF6LF7df1qYhZDRnGCCVXtv0mG/s10HDcKpiTBmS/NpvCjzUpB4ssxKcNph8GH
 PQq0BM+7EUKNFshWDmLHkNHZPJJR838OWoRv4MkQDCucaPsMgC0ztrxpzHmdRMNu07xk
 a/Fc/GVe1o1cuI1EzK79UKGsX5x90P0H6EtQoOSQPT01VXKIEpY0nwoZL+8j+Am3TLIE
 V0kQ==
X-Gm-Message-State: AFq9FYJybiOly3lu8lhlzPCTygXwmNJa1svGLbQL2y1mHbq+v1IXlVb4
 ylExfLIs0llTpntFkHAxx2y12siaANajbyU/iHgBR0H5SG4CwNIFY1Wj4cnydBtTcEdaKyUT3R5
 655hD3ChZxBRseRGg5HIhB/EUNEEzIWPxmV7xx6o4
X-Gm-Gg: AYBFou32rjtVP28sWyYIXIpgXyzjmwYX+vJRk0ooRU5x1TH/YHZNb0tU3u8ZYKgVuJW
 QSZF5RnSrbfVJuitzZ+x1TklSZLuRxTYCBCxz0gDD03ZEFUhGug0flrS+NEBudbU6EO7KPfUNR9
 4Koc5xo1Jvgm7jltrmwV6UsMod2xTgbNrSFTEI8bsiXonA3f6c1GKu2q1lUNiCsXUl3Ft8ZLDyT
 RigHc4CxF1G/Uiog2RTLE9Ps/CMaMjVuQjVqC9boXZx0AG6kxQjJjYxDSgxH6ABmCCJKaXjbhi8
 LbxsEDTSolt+60XkN1aBf6yxuEnT91KCJ6vrH8rk061C8vgab20ODK8wKEld0beG8t0=
X-Received: by 2002:a05:6402:378a:b0:6ac:73f8:2e5d with SMTP id
 4fb4d7f45d1cf-6b17c269479mr7943818a12.30.1791813451553; Mon, 12 Oct 2026
 06:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
 <20261010-b4-binman-fit-fdt-compression-v1-2-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-2-4465558758cc@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 14:57:16 +0100
X-Gm-Features: AclHuK-w6fkl-XDXF7dvw5Z7MeA2wrYj48B_mEH1NOXZcCxTz831LjBeSMwEHgg
Message-ID: <CAFLszTibc0W+nBdprG-9GWM9gHJjgdytZTEVtaTKp5DKdNQGww@mail.gmail.com>
Subject: Re: [PATCH 2/4] binman: test: Add fit fdt compression device trees
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-10T14:24:46, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> binman: test: Add fit fdt compression device trees
>
> Add two copies of fit/fdt.dts whose @fdt-SEQ template asks for "lzma"
> and for an unsupported algorithm ("bzip2").
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> tools/binman/test/fit/fdt_bad_comp.dts | 72 ++++++++++++++++++++++++++++++++++
>  tools/binman/test/fit/fdt_lzma.dts     | 72 ++++++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+)

> diff --git a/tools/binman/test/fit/fdt_bad_comp.dts b/tools/binman/test/fit/fdt_bad_comp.dts
> @@ -0,0 +1,72 @@
> +                             kernel {
> +                                     description = "Vanilla Linux kernel";
> +                                     type = "kernel";
> +                                     arch = "ppc";
> +                                     os = "linux";
> +                                     compression = "gzip";
> +                                     load = <00000000>;
> +                                     entry = <00000000>;
> +                                     hash-1 {
> +                                             algo = "crc32";
> +                                     };
> +                                     hash-2 {
> +                                             algo = "sha1";
> +                                     };
> +                                     u-boot {
> +                                     };
> +                             };
> +                             @fdt-SEQ {
> +                                     description = "fdt-NAME.dtb";
> +                                     type = "flat_dt";
> +                                     compression = "bzip2";

These two files are full copies of fit/fdt.dts, differing in only one
line. Most of the content (the atf, uboot and kernel images and the
hash nodes) has nothing to do with what is being tested. The error
test only needs a binman node with a fit containing fit,fdt-list and
an @fdt-SEQ node with compression = 'bzip2'. Please can you cut both
files down to the minimum needed? That reduces the duplication and
makes it obvious what each test checks. If you keep the u-boot and
u-boot-nodtb entries in fdt_lzma.dts, the slicing in
testFitFdtCompressed() still works, or you could drop them and use
FromData() on the whole image.

Regards,
Simon

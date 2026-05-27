Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1719CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC4D8341A;
	Wed, 27 May 2026 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GCitX+DE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82375839A8; Wed, 27 May 2026 11:35:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660A38056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6353A3F96A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779874516;
 bh=m3ZfUblgroZXGVtaEw2k6ucJuBGRt8iqIvxlIr6IQ4I=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=GCitX+DEBLHS8B5BjoDkQXZrxxQSy52HRq9aoK55xpZQ6Arud4DnrldO6eoHeQp9r
 3VkcsUN+vuBfp/FRkyT7Y5v+ejjvv9La2Zk02C7yFnoI9cmzS/EzekTpDXxazxzD8W
 IVyv9C17rQadGaOPnp23b0H38e04XJSVnNt0sbooKHGVOIp00hR4Cdli1O8hW+DX8s
 nQcjFN+VOX9UJs87nPhZfUAlpginIX/1oB+G0J37dt87yI6duLp0OPngIFWm7Uc2RJ
 yYcb1kbkTHw1SBYLCT+oXbKTc018aYh+LMPD8reK2b04qxFOMWM7CSFE/H+6uvF/Dn
 kw+VPu1dqi+H78Bak/zpl3J0wIyCVo6LrGENCJASII9QbKs647mtJGJ4AsY5Y4Wxrr
 BwxEWEdJaWKkiLuOHb0D+tc3PwSwaaK0nYiEBoJdWW3e+j/qfCxbPl1KeLtt7Nk3We
 qYeXK/a0dHzhGkvZaln57idG0UwoMx1UVBQZdRYZWHki8IPVyQDZ9JJYEuVwLTOXPc
 lxF9Mq+/0WmgI59fIztXreGRbJF3FQn1f1Od5sn0Hfjg8cmu0gR47FFTDfZ4ER3E4+
 lcJTJ563m2oM9UkDFJ56ccewL6Sd//Zr0cFJG6Q2mH47yL9fAeKt1egp249YEvHIYd
 9/Hr6LzvSttcHiMTvIbgf7yw=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-67c2ce99bc4so11523526a12.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779874516; cv=none;
 d=google.com; s=arc-20240605;
 b=Cl2XPHcCZsSjMzrBwDuPHBAL1ejYus7NlfQ/RijY8h1tjZwV2n2lDW3FADIJiBuUoz
 yPatCDgcn5IMnmLpn8ktZXXasBSEqK5KasydkhfDhbdt9vagMb+LotKIYsNTHdfud7kh
 xvOi+rsV/JEkw454YO9oauAypdfiGXtZC23RT482T7TTeeUBuUth32X1HHv2GYAdNXkv
 Z9xovpbts4CcwLWsKlrvygpHyt6AGQYrHwmJoFAhpTgYUxhSBhTArtbvaNzhlFXg4ITI
 KrNo5rgdlFviwm9+my49qAn1edRsR503bntzG+8Zzb07rr2VNCtBo6DieeaN8gsfuzNy
 yiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=m3ZfUblgroZXGVtaEw2k6ucJuBGRt8iqIvxlIr6IQ4I=;
 fh=Qjr6Pb174X52BXgAGhHwqAsN33Frk73aPFS63OiMcjM=;
 b=TmBWTO27qJoLXxQIaZkCUs57bCeObOZndHifrJ/x/NIQR7D7lWva3yzFnoCBhVIaBW
 kWhBCOCMFD8dLuIJ7e9KTc+bRARHAT/xqtsD7iRrxtD3VHdwJe8OINT3lUAgAZOX4Tih
 Ly7AQexiKBrU3ba964eM2v8HkHHKWZioyxmorVqSAaMQrvuaSM+SJJEsWyE3JkMJgyx9
 7I7HbZxOSPMpu8LGyMmn7VKdnIH43ddjAN/tTTicDZYWoMCHVuBZUGukDER1gpEuy2v+
 pMv3Z64hOMlsh5wao2OUyEMyTIcjKbu7dsmK8GmfteSE4iQgDOxt9tnOmRbLRyx9KCE/
 40HQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779874516; x=1780479316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m3ZfUblgroZXGVtaEw2k6ucJuBGRt8iqIvxlIr6IQ4I=;
 b=PgJBEFfv9clMHnRyF80uONCxj78buuwtxEXayYFgjEE/dA4pT39eKeyW4soDr+4EoV
 vfQBfwdsu89ydgI/VpNg1Jz6ChEAFt3mou4BkGy/CYC/yeRlJG7870Oou4NFAdrupD9C
 5j153bZK3TjYaQn4oU6Voen57sU3mMHmSRiCh44lbuW8/68+xjlaiTlY4c5U762NAPwO
 u/RGupk8Wh9Ol7tboLAPrgsIT1JjKwH0AsLvz3i8mP0iE3PX6IBgA4TTVYSbYjD3VgPn
 wGf3UkvD0p9CAwsBNjzLnzv0xPEVLfKysu766hODro+FSLZPay0ISpe5cq4J5+NCOArO
 ftIQ==
X-Gm-Message-State: AOJu0YxasLx0ynaSOI1GXONF61ASr00kFVyHtGwW0QMG/EGzZjCj84wF
 rthKOy9EVDVdqXQgJjdoNEzDsxgNWFx/1TEusVIcPmwzGW12dy9E09DEI/q5BvX+GspVDuMc/7a
 ERMk7IryFY8Q/NaOnBaPmQM4I1fJ/fF+Knc/qEtvFF5iMD52mQrVCvVOD08MG2/c+ZLnLV36R3a
 AOuqdfw04vQh/N8qzwzum7kfZzZeCo7r2DQBPPI/ABNEkphA==
X-Gm-Gg: Acq92OHnP4NJMLEl7sgVzSrS+xTO1mSe2ScTpxnMKkLqHiI/YinjVllCr4n9mF2Cjy+
 TlwdHJp47GRnOHnVHEutp8pT+DRTnronjy4gGBQlHYZJ6/YWSgn6veO1l1KtNzplYcP3cSYdH00
 AAQP4XA7hMrHWNcZgq9ulksHVKwW9drRHu4OdFiJ2uQEto7N1poyizvkrPevvLPjAjnzMSGy6Tv
 eyMNs8=
X-Received: by 2002:a05:6402:43c5:b0:676:9c6d:5c59 with SMTP id
 4fb4d7f45d1cf-6889c406c91mr11382133a12.2.1779874515545; 
 Wed, 27 May 2026 02:35:15 -0700 (PDT)
X-Received: by 2002:a05:6402:43c5:b0:676:9c6d:5c59 with SMTP id
 4fb4d7f45d1cf-6889c406c91mr11382118a12.2.1779874515102; Wed, 27 May 2026
 02:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260520044554.15373-2-aristo.chen@canonical.com>
 <CAFLszTi1hPmXbDa+8hBXVU+oLxgwC087Fr2uafdcu6ViFxasYg@mail.gmail.com>
In-Reply-To: <CAFLszTi1hPmXbDa+8hBXVU+oLxgwC087Fr2uafdcu6ViFxasYg@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Wed, 27 May 2026 17:35:03 +0800
X-Gm-Features: AVHnY4LbMcCZjKSuVu0NAReZj9UMzSaVBj38C5Mna2RP2EgCB0xEVEfWMeTckhM
Message-ID: <CAA=k7=k=BZPEkG1PGmJaN1vEt-iR+SbOKK60HeboVvtK6OMPzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] bootm: fix overflow of the noload kernel
 decompression buffer
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Ludwig Nussel <ludwig.nussel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On Wed, May 27, 2026 at 12:59=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Aristo,
>
> On 2026-05-20T04:45:49, Aristo Chen <aristo.chen@canonical.com> wrote:
> > bootm: fix overflow of the noload kernel decompression buffer
> >
> > For a compressed kernel_noload image, bootm_load_os() allocates a
> > decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
> > kernel compresses by no more than a factor of four. It then passes
> > CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
> > image_decomp() as the output limit. The decompressors honour the limit
> > they are given, so a kernel that decompresses to more than four times
> > its compressed size is written past the end of the allocated buffer and
> > corrupts adjacent memory.
> >
> > Pass the allocation size to image_decomp() and handle_decomp_error() so
> > decompression stops at the buffer boundary and fails cleanly when the
> > image is too large, instead of overflowing. The regular non-noload
> > paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN.
> >
> > Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > boot/bootm.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
>
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > @@ -635,17 +636,17 @@ static int bootm_load_os(struct bootm_headers *im=
ages, int boot_progress)
> >       load_buf =3D map_sysmem(load, 0);
> >       image_buf =3D map_sysmem(os.image_start, image_len);
> >       err =3D image_decomp(os.comp, load, os.image_start, os.type,
> >                          load_buf, image_buf, image_len,
> > -                        CONFIG_SYS_BOOTM_LEN, &load_end);
> > +                        decomp_len, &load_end);
> >       if (err) {
> >               err =3D handle_decomp_error(os.comp, load_end - load,
> > -                                       CONFIG_SYS_BOOTM_LEN, err);
> > +                                       decomp_len, err);
>
> handle_decomp_error() prints
>
>     Image too large: increase CONFIG_SYS_BOOTM_LEN
>
> when uncomp_size >=3D buf_size, which is the path the new test
> exercises. In the noload case that advice is misleading - the limit is
> the per-image ALIGN(image_len * 4, SZ_1M) buffer, not
> CONFIG_SYS_BOOTM_LEN, and bumping CONFIG_SYS_BOOTM_LEN will not help.
>
> Worth either tweaking the message to mention the 4x noload buffer, or
> printing a separate note from bootm_load_os() when decomp_len !=3D
> CONFIG_SYS_BOOTM_LEN. What do you think?

I will prepare a v2 to tweak the message

>
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > @@ -623,11 +624,11 @@ static int bootm_load_os(struct bootm_headers *im=
ages, int boot_progress)
> >        * Use an alignment of 2MB since this might help arm64
> >        */
> >       if (os.type =3D=3D IH_TYPE_KERNEL_NOLOAD && os.comp !=3D IH_COMP_=
NONE) {
> > -             ulong req_size =3D ALIGN(image_len * 4, SZ_1M);
> >               phys_addr_t addr;
> >
> > +             decomp_len =3D ALIGN(image_len * 4, SZ_1M);
>
> It might be worth updating image_decomp() to take a ulong size, since
> now a read per-image size is flowing through (perhaps a follow-up?).

I've written it down in my notes; I will see how to tackle this with a
follow-up patch set

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Regards,
> Simon

Best regards,
Aristo

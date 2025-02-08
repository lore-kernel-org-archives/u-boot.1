Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5F2C02199
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 01:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102D680756;
	Sat,  8 Feb 2025 02:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ePFtqB9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2318D807D9; Sat,  8 Feb 2025 02:26:24 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB84F80737
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 02:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5dccc90a4f1so5588930a12.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 17:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738977981; x=1739582781; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NCXS8KJht2AV5Lkl15A8epYBk/bQkU4TkrmNddLmas=;
 b=ePFtqB9AttWi8K0zNZLDZSv/XQ/10X4kZ1n2bUWjn+cTTaoY+Eyq1N6YEkG+cJXYzQ
 ymGqDkluNiXYhTCvn9nlENung8Uhf0i92kDPY6XV+Q4MTDCXgFLOPtzI+Epcvq2Vvd9s
 OECFlCiJscNg1jNVcIUQrVDzPyuV7ZCyT1zWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738977981; x=1739582781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NCXS8KJht2AV5Lkl15A8epYBk/bQkU4TkrmNddLmas=;
 b=ukwir+Wqza/mallFM5MLz0ujLjr1Nll1E5upZ6sHIwZl+kPlQ0mOSXWS5+oeiuxwl/
 3Fr/4gkmlmcjx86RwVXp1KaNgGVn9uNd2fjY8aJ5MT5uSaWTm+IGF8JeCNsaUk4a0rcc
 6y8YvyEps47MYL99OVYmVWQDHgGNpH3RtSYAm1MKG0+3+sLdFOVvuX5ITpS1Om9hyTWZ
 4WMjHUoDtu4KFvqJ3aDZOKGKJslIie2wGqrQg3TATYKzY7dPBPhhJU2z09kvEAyAl/Am
 ULriuABZv1/hbWnQeh/GSf1cQMmZ4NZVXlLgdPhF1xO0rFRhw/82luK9WaO4yrNbBR5M
 v5kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6/ayWKe+nmNZXEaFcuABwjLFSXwlEcNNkLX+wLBHVAL3k20YThDuJgLpMZFlDhkCm+fLhO/M=@lists.denx.de
X-Gm-Message-State: AOJu0YzpaipP/dkwuvEGd8TLZErWAxD5+cxNKSQtXOzEhODFI8/zX8A6
 QiYVf1FlDdtp98YSAw+mjkfhO+fpN+efOC8wXJPLv+WBcmJP642jCQNs0LGO6/8meNVcDg2oyNJ
 bdzSjEMcp6ttGW1yD8CfgxKg8SJVk71o6IKOl
X-Gm-Gg: ASbGncv2bDG82PmTpq0rDSJuH3TE2zl1FLHSus6PD4JQN+1NFqxeMR3mq+mUOHEpIt/
 HxA4lC1G1TvhEkcdTlTsbNT5lBz7bmneI/TWgJdOaOdHA7CaUwekXUBapMKBSMp8fAh4D4g6VCQ
 ==
X-Google-Smtp-Source: AGHT+IGE+ukM3gfJBdmlXXogprR0CcaBRp33n5TAuZyxUZI2iVMCSVG0kzbTwvwYNJqrMtc23kFMp7jUW31wTikdYrc=
X-Received: by 2002:a05:6402:210e:b0:5dc:ebf3:b967 with SMTP id
 4fb4d7f45d1cf-5de451074f3mr6264371a12.23.1738977980780; Fri, 07 Feb 2025
 17:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
 <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
In-Reply-To: <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Feb 2025 18:26:09 -0700
X-Gm-Features: AWEUYZnGeQDXcnIocM6_IZByPcDIiT3Dm-qjnta4oLfVBe35e_wyeML5MeEPppE
Message-ID: <CAFLszTiZdbMu64_+=LV3gxUf_Jm9Ngxdmg=+XrVhGNHR9FDAnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sam,

On Fri, 7 Feb 2025 at 18:11, Sam Protsenko <semen.protsenko@linaro.org> wro=
te:
>
> On Tue, Jan 14, 2025 at 7:14=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > On Sat, 11 Jan 2025 at 20:42, Sam Protsenko <semen.protsenko@linaro.org=
> wrote:
> > >
> > > Free memory allocated for 'order' (array of bootmeths) on error paths=
 in
> > > bootmeth_setup_iter_order() function.
> > >
> > > Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths se=
parately")
> > > Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > >  boot/bootmeth-uclass.c | 16 ++++++++++++----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > How about adding a test to check there is no leak? You can see
> > test/lib/abuf.c for similar tests.
>
> That might be a good idea, and I already have the test code handy. But
> frankly I wasn't able to successfully run the current bootstd test in
> sandbox, it fails before it can get to memleak check I added. Firstly,
> when I do:
>
>     $ make sandbox_defconfig
>     $ make -j32
>     $ ./u-boot -T -c "ut bootstd"
>
> it says:
>
>     MMC:   Can't map file 'mmc1.img': Invalid argument
>
> and I can see only empty (zero size) mmc1.img in my U-Boot source code
> root dir. Then I was able to trigger its creation (I guess) by running
> Python suite somehow, so it generated 20 MiB mmc1.img. But even with
> that added, I hit this error:
>
>     test/boot/bootdev.c:218, bootdev_test_order():
>         0 =3D=3D bootflow_scan_first(((void *)0), ((void *)0), &iter, 0, =
&bflow):
>         Expected 0x0 (0), got 0xffffffed (-19)
>
> I've read corresponding doc [1] ("Tests" section), but still don't
> understand how can I successfully run the bootstd test locally. If you
> can help me out, I can send the memleak test you mentioned in v2.

You can run the bootstd tests with something like:

test/py/test.py -B sandbox --build-dir /tmp/b/sandbox -k bootstd

although it sounds like you have already figured that out. After you
do it once (to create the images) you can run the C tests directly as
you did above, but yes, sadly, some of the tests are affected by
others (with bootstd). You could take a look if you like.

Regards,
Simon

>
> Thanks!
>
> [1] doc/develop/bootstd/overview.rst

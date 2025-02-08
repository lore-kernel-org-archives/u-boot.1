Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A976AC02199
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 01:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C89807D9;
	Sat,  8 Feb 2025 02:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ub88tKmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47991807F1; Sat,  8 Feb 2025 02:11:46 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A067780737
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 02:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so2033508276.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 17:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738977100; x=1739581900; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBbUoFoxCZuVkqWmljpveuR1LdtWHALFxbQpHiirXi4=;
 b=Ub88tKmCRjoca49NOAHhicv0WkONYBsTeK0VHvj/FFVR0dQIojSMPDo65udk4ujB5X
 BwJEyuGxbqHva318ZHEwvpjRLMGF/R6zTFnlZ70fMbZHrN5p5PoN94mZUX+4uYUkHA5N
 bk6gcL6sO6NnRbUx8Ir8rUFtChqK3YU8VSe11ecW20BkqO+YwRHppV7Q0fmwG/Q8Qqnf
 xLFKpsafWxR/7EGWHn+Yc5VhmWtX4xsxocxd9mo6c4WY0iqN9O6lUL0Tr/WaliDacgvP
 n4RmMFHv33TSHyqRU6X6f+R461ebi4MgOhM/vvt9M3Fz7ZDNHb2RUuGqcgSL1uTDWsZf
 v3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738977100; x=1739581900;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBbUoFoxCZuVkqWmljpveuR1LdtWHALFxbQpHiirXi4=;
 b=N7NizBf66fISkYEj+gTjfP0mMLsuKnF9+H+t4lpWpPq6pOJ6j+wfnXy3hCRcfIJaAI
 NQg+o6eqZdCuQ1JQfT2JwbasK5NCwPoYqxkE0IfX8hzWKFWE9jgBFq2pcZwJgVSN1GUn
 B1aPMuIF4jAWc/R8XRRr/H9wxxYuyb5xQFF+crJYQsNrKW3JGYJutAPdaSr0doAM/OLn
 kCEa8OdfYPj/eWSPj0EpIb1FXyqRw2SvKrMPdVlX3Tc53OIe53SzUM0B8bgekhOfCeNG
 fi3f/SvjDHV5rz5O8hwfWjkciOxobtgcmaJ3el9/rn/6wDPNtk3vprNB6J9JUpLlRRJh
 yY4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFnhDrqZUQjnSRzkP3kvW5Wb+LyTcvASPpDveNzOzFk5cfIyeTO+f4/mNP2xoKcqU5dbqGzyU=@lists.denx.de
X-Gm-Message-State: AOJu0YzWec/tkpeehKUlVCMxChM4dPmj9AH9aoLKgeC92hoHngPsZLk+
 DmGJ1WasQShL62ZaIYh6n5d97FJpiwAr4s1mJru5bNg660JdPeyG0X5Yzjp3O60LH+uj6h+Gu+r
 XQepv3Qs6EnRqQhqI58Oyw3zHE42ltlq4tblYcA==
X-Gm-Gg: ASbGncsoRhfM+2qqH+b+XGSy1w3xBr8Xaedu1+TRN6zxs/3I+1AQ7KkuBTub+EyHYS6
 5A8blojN2N46Wx9uqFswgdcm6psPKxSBR3iYVU75U1aS6EzSJMsIf2MkGvBsdCX6YNvkboNCS
X-Google-Smtp-Source: AGHT+IF2iBWR4a9QA5MFW0izo4oTWYCcKnpySHHAO7Ngkq3VdbIuUXTPV2aKDiKDr25FxEgEklMoE7gMAoJvmVSDtnQ=
X-Received: by 2002:a05:6902:2009:b0:e5b:1c0a:6cac with SMTP id
 3f1490d57ef6-e5b4625401fmr4943719276.38.1738977100001; Fri, 07 Feb 2025
 17:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
In-Reply-To: <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 7 Feb 2025 19:11:29 -0600
X-Gm-Features: AWEUYZlp_0A1ZrVTgxkBj0mEcW-Qy-Jy6rKaEXnStWg5MpSHHiWFGG-JhwyEqLo
Message-ID: <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Simon Glass <sjg@chromium.org>
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

On Tue, Jan 14, 2025 at 7:14=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Sat, 11 Jan 2025 at 20:42, Sam Protsenko <semen.protsenko@linaro.org> =
wrote:
> >
> > Free memory allocated for 'order' (array of bootmeths) on error paths i=
n
> > bootmeth_setup_iter_order() function.
> >
> > Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths sepa=
rately")
> > Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  boot/bootmeth-uclass.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> How about adding a test to check there is no leak? You can see
> test/lib/abuf.c for similar tests.

That might be a good idea, and I already have the test code handy. But
frankly I wasn't able to successfully run the current bootstd test in
sandbox, it fails before it can get to memleak check I added. Firstly,
when I do:

    $ make sandbox_defconfig
    $ make -j32
    $ ./u-boot -T -c "ut bootstd"

it says:

    MMC:   Can't map file 'mmc1.img': Invalid argument

and I can see only empty (zero size) mmc1.img in my U-Boot source code
root dir. Then I was able to trigger its creation (I guess) by running
Python suite somehow, so it generated 20 MiB mmc1.img. But even with
that added, I hit this error:

    test/boot/bootdev.c:218, bootdev_test_order():
        0 =3D=3D bootflow_scan_first(((void *)0), ((void *)0), &iter, 0, &b=
flow):
        Expected 0x0 (0), got 0xffffffed (-19)

I've read corresponding doc [1] ("Tests" section), but still don't
understand how can I successfully run the bootstd test locally. If you
can help me out, I can send the memleak test you mentioned in v2.

Thanks!

[1] doc/develop/bootstd/overview.rst

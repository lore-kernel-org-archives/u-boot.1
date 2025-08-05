Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC63AC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 23:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D0E83933;
	Wed,  6 Aug 2025 01:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKUr0eUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2835F831E4; Wed,  6 Aug 2025 01:05:59 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92638334D
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 01:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-33253a73769so29660531fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754435153; x=1755039953; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgTWdcWkL5upKRM6IOvoP3ixHNxCTLZVRIqne4+2Iq8=;
 b=dKUr0eURQif1k82m6Ob3ZnfP+3YgHRjBTAFYiwhkZUnD4VNW4xLjVzYuwU3cLLNGA5
 aCO8WQf/V4l0US7Dy3KvmzVX0Cy+ebsxcsgTk2gOGVYs4lrON3n7fNucHJXJC2tsAPNb
 9+E5ZpxHWXSRn1VKk20WYgensmlizLrCm/IfriumBUYAelx2SrNZjNDnDpdi9zTtV5R8
 vI7U+dgmQkF4cc0ZKa6k9YbjIFRSEkHeRvcOn5UWZcSX0A/EhlILnc9FE0ABh/A4ZbLs
 60YiCKaiy9MmzMUTxkrHyZo9HcF633/ipJDnVXC96uODzh99jOQD+ijR+aE5FNfeHqqC
 4r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754435153; x=1755039953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgTWdcWkL5upKRM6IOvoP3ixHNxCTLZVRIqne4+2Iq8=;
 b=VRyoUZLSwJfQZrBLW4/qo5uXoVbf25Qm/DC3HBMZnkcuyu5BzbXI1QsW1B7e6vs+Ns
 xnG0w61MegguuSz9V+s54pTdmjpgvnzkxWY8DgF+asd24C+bJAY95+A4KoRshTJUt37k
 M1ZWSQXGhD6qcJyAI6TaqEXKE1A/cjQFVtF90X3KqQ7CEJB46+uIw4w2iXobiKsAhbk6
 8lQKsB6PjNQvAt7azA0xGDNtwsPEfMXKBnaR9teHuLM5jlqNXnSU5I5LE9waqw6kqEGP
 K4dDl+K/WDps6Qr11/8dH0Vv6MoHIyNuqxV8s/BSI55+WpnF1WHUy6Ei88QGnWLb0HvF
 /AoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhI/kWFy/F8QXTt6s1uMIkmH41JiLpTCZwhMDVZllG7lP6W2oWMfUtGC3BrUwMqx0phoMJN/E=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4wyKqjAfejzZy7g0dvy8je78hB9DxNuWi27Gsj8Bd3yRqpNLH
 a0URRnPgmtYwqHL8OfIuinJvrxBgbeujrnD7Ii+QCibDY9XNMUg4yY5Fxz6cky8+9qSzxddLgb9
 gRH4j2eGIdsT3rcD5tH1m+6uUwh1rsuU=
X-Gm-Gg: ASbGncvZmnNn+mwEb8KsDfwdLXfKnAD0KQyEGbGsQQQgr2GxN6Z3rIB2vpoUOX90raV
 1Bu/N35st9lWp46dllo8aaN7o5kpyKbeDFuV8riI+zD1i54+C8NSg3lW5g+2Af11DEOlYV5K3o4
 0/PzV7XKnD1G+op+bOPsaH40H1SYja5NGcHcflp0djVCAcin4BIx+rSutEeiB/kGu//FnQCq1O4
 6DutvkkRhSkLM3fAp+mw/dHVkMjU/2Mm717+oY=
X-Google-Smtp-Source: AGHT+IGmdkJFc/RfDNgSGvyEk1dDgGc8f1RAwjFBm9fw4Pyksa7JMSVSIqIEme62x4721BATzYObuAi4XQn5946aqBc=
X-Received: by 2002:a05:651c:211d:b0:32b:720d:56f8 with SMTP id
 38308e7fff4ca-3338146ab9fmr1123641fa.40.1754435152625; Tue, 05 Aug 2025
 16:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250731-imx8m-optional-optee-v1-1-5b5ea143468f@phytec.de>
In-Reply-To: <20250731-imx8m-optional-optee-v1-1-5b5ea143468f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Aug 2025 20:05:41 -0300
X-Gm-Features: Ac12FXzFoBaQ17JjGGrADgw0GC9D6yL131cnVlmTcSQtdDo_zE_5XZ7urtj5cSw
Message-ID: <CAOMZO5DXGve7=-+x3y9aV4N=1ztwObn2LKyPomSmFFi1JLkHyw@mail.gmail.com>
Subject: Re: [PATCH RFC] dts: imx8m{m,n,p,q}: Make optee packaging optional
To: Yannic Moog <y.moog@phytec.de>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

Hi Yannic,

On Thu, Jul 31, 2025 at 9:34=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> binman can omit packaging an optional blob when it is missing.
> This allows us to not bother with config options.
> The core challenge is the interaction between tf-a and OP-TEE where
> U-Boot/binman does not know whether tf-a was built with SPD=3Dopteed or
> without. This is important because tf-a might jump into the void when no
> optee_os is present, leading to boot failure. Thus by marking it
> optional, user is prompted to recheck (due to the warning message)
> whether they really have the right combination of tf-a and optee.
>
> Note that after this commit a warning will be printed when optee is not
> present for a binman build.
>
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Due to a bug in binman, we had to guard binman tee.bin with OPTEE config
> as builds would error when tee.bin was not present in path; Even though
> optee_os was marked as optional in the binman tree.
> Since the bug has been resolved in
> d4f61eae2ab7 ('Merge patch series "Fix handling of optional blobs in binm=
an"'),
> we can mark it optional again without getting build errors.
>
> I remember Fabio disliking that a warning would be emitted in builds, so
> I marked this as RFC.
>
> @Fabio what is your opinion now?

It looks good to me. Thanks

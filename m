Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0849CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 19:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A83583A32;
	Thu, 14 Aug 2025 21:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="G76C9LEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D19D83A32; Thu, 14 Aug 2025 21:55:16 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DEA83A31
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 21:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-74381ff668cso642137a34.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1755201310; x=1755806110; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfjfVbPoiie9l4cuDvGyoB/naunt5tIjCo+txjpWbp4=;
 b=G76C9LEmBg3SxjPNRZwGFuhGPg7HtiYXjVTrDR2MD22DjRwU/Wt1fJH3e9ADQRR+oY
 MvgSEa8wqQtnJRMHc4m78N3uv5CrzSH/az8Hml50Hv54bEW4SpQGzEvcIHOMm+0KtQCR
 nUUusiQ1yX0XZjd5Np3wnjhK35Ea2y0Eqe3wMw6RJyOO3nn5nfr5OLcl+OMW/kseBH5Z
 OlliKqAuV9SAJSsaKRjm+mZpqG4QH1bp1IXRbEYpCvi4oQaF0mgNqS1iSu9s/Q+U57Qo
 2KitXLzksJmwgLILR/KawRFww2eepyZXQAxS4pOb+92LgBa/QwgXitvOgwbJcau6FXcJ
 zYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755201310; x=1755806110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfjfVbPoiie9l4cuDvGyoB/naunt5tIjCo+txjpWbp4=;
 b=ipYd2dPBLKnFLDTLLd++Vyitxt/9dXHssSbmKVHjKhPAyC6S6Uj22hOuhSuVAYfn2O
 cTbAX2sWr5djnZ6D22+oB8me4fMp83P5wmTeBT2QwJ96gK9jrZfGAzDSSNzpKQ9+OJgI
 E/kLoM1KU2s/wzYTHoIR3gTi740oiUsYGGf00TC5oCYVvCUg5rBmeYLRxITgrApSRXaB
 mc0nt8yYmeihfk3+WUs9pWtsXs8LOqUUnoKmuFesG+XzY2YWhTbZioHfO8qo46Pv2Kgl
 01zuDvMfQqjuvzswdtlnd3+pKuVTQDIcFxQWj9wEFK3ZoAVKudDOYcewoNQXVZ1Eb3OK
 GzLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdBB3kJ+4XHcwjIBDlkukDWEpXzsmqtWvSfS8jjMEedG0nGR6eCogPt5jDk8xF/0XP7HLpx+g=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu3SrID6Xjh8aURM6C2vHh9GW87Ylp3u8wZzA7wbyy6xErNTiL
 FhYyeowZ9cW0QnFkr2vfAxio/ww9OQpHrwFWIx7qBpA4Rh7I3EUuInDl9axsR9JuyZuoft0cHyK
 9m99jS5wqg3jeuLRExlAKKy1GoRCTnjla1/JQ0T5mbw==
X-Gm-Gg: ASbGncsPlKkbe5dBxMcuxnM5TZOTbOddKtpYFcGqIQUrRHQCUBxnFQ657TThayw1BST
 nYpT9CRD6sKh4gUj8twWnSOW8EAJRBRRv73QBCkCXfYNXSqkjKIx5t9cxKQ8E26fyw1OPXVeNbR
 I7oBhyYUkbsaSaDRgcv+1cbYGLhwVjacrpAeaOPX/xyXP2NCCfH4n+1rKMHaLBcnKcl6n7d1tM8
 pA2led63OLrd2NAMA==
X-Google-Smtp-Source: AGHT+IHgG9HntuYo6oxsSEQonE33Q3tyeDWYopadAMG4ZD9TCgXbVoG6nNigqojgzKZ+6630aw7JOovHxsmUd+GjeiM=
X-Received: by 2002:a05:6808:3996:b0:434:d9f:f8ea with SMTP id
 5614622812f47-435df6f6917mr2888140b6e.14.1755201310581; Thu, 14 Aug 2025
 12:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <175096060477.1879961.6525302263431603846.b4-ty@konsulko.com>
In-Reply-To: <175096060477.1879961.6525302263431603846.b4-ty@konsulko.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 14 Aug 2025 12:54:59 -0700
X-Gm-Features: Ac12FXyiLBIBLxh-HZw2R5GliUsBlPEeL18v0dv2XHHo8SgJL0ROd9eSuHhEZ7A
Message-ID: <CAJ+vNU1c6RchWTjX+A1dUi-WQ+m-60QacY+-dA5ScodFsc95_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix handling of optional blobs in binman
To: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Thu, Jun 26, 2025 at 10:57=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, 13 Jun 2025 14:02:39 +0200, Yannic Moog wrote:
>
> > This series solves a contradiction regarding ext blobs packaged in
> > binman. When they are marked as optional, by default they are faked, tw=
o
> > messages are emitted. One says the image is not functional the other
> > says the image is still functional. Both concern the same binman
> > entry/blob.
> >
> > Binman is set up to have fake external blobs in case they are missing.
> > This is regardless on whether they are optional or not.
> > The implementation does not allow different types of entries to overrid=
e
> > the faking decision; at least there wouldn't be much sense in doing so.
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>
> [1/6] binman: drop "faked" return value from check_fake_fname
>       commit: a657d87f08789c4c50423897bd5ee052c6223ee6
> [2/6] binman: mark optional missing blobs as absent
>       commit: 3ae668b9d2101d111d257ee7d8912c19cfb0e102
> [3/6] binman: rework dropping absent entries from packaged image
>       commit: 21bc3433a43d3add3430543c9eee2a95d4dee2f6
> [4/6] binman: add faked optional entry case in CheckForProblems
>       commit: f5817e05efd39dd455c2e6a0f0622d709fe7ea2d
> [5/6] binman: ftest: pass allow_fake_blob to _DoReadFileDtb
>       commit: e749d64b4622806072c56a839cf9a36a5081b575
> [6/6] binman: test: assert optional blobs don't cause non-functionality
>       commit: 0dbb0a8d1f2aefb2a7fdd8e627edd955e4fe8d3a
> --
> Tom
>
>

Hi Yannic,

I haven't had time to dig into it in detail yet but it looks like
imx8m boards are failing again in master due to tee changes again and
perhaps its this series that is causing it.

Here's what I see with today's mater:
make imx8mm_evk_defconfig
make
...
  BINMAN  .binman_stamp
Image 'image' is missing optional external blobs but is still functional: t=
ee-os

binman: module 'importlib.resources' has no attribute 'files'
make: *** [Makefile:1339: .binman_stamp] Error 1

I thought I had read something about a warning that wasn't an error
but above is clearly a build failure.

Am I missing something here?

Best Regards,

Tim

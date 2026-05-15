Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A2CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C92484812;
	Fri, 15 May 2026 22:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hQ0hT7QO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D86098484C; Fri, 15 May 2026 22:58:07 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DA584812
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so70303766b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778878684; cv=none;
 d=google.com; s=arc-20240605;
 b=ehi2OHCK0hs2zzqTO92Kl+sFTlwhuNFqzq7MFgQ5KnwLNiv6XHI/O3zCt/CvOxKW9m
 G/QNs1Purr9pTIvEiClBWTsZZWo1/I/XayBa2oWLozMUE0RsJLEh7wC3bgBZ8SykQaG7
 hcFgyCOU3iL7U4qEMkJQQor6Ry5t/KcAqOArHu0SrTD6O5uClxFd6/B2p0QjE3wz5kOK
 33kIk/m0Ri7tLe8U4MBH7/+DEMcWEealXUts0V7KZ6OeSF/4H14SUYrA3W26TgDRMVfa
 HU2d1W4scA3Bs8nlXVQFHZK9+yy40AwaWV66cSz3LqmHytZ9XHUvgreY95lGtFAGJpWu
 sGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v/+sLlSFlW3S2/+BTlJcRwOO7myufrATI+IC+lYuMm8=;
 fh=1Rj5Iy6AYTVFICKN1ytNA1aIol2wPtRnCaE60wRA0L4=;
 b=QcbybQBK/xraQafEbdwVtXpfvpY6LiGGDn+2fE+bI6SU7isgHw+aEGwmIrni6NNsNG
 bRe8+31ocK9FpSDNPyjqNZSkzwlE/j+Q8A3A6wLZZSEi4upcdUgNHgn0S/FqcgRcuUVw
 sBZbgCBuMrt4r2fVayqb9gIxfvMgECSo8/mOB+CUJ0tmnU3Ce5OOlFyht6JhemcgGjCt
 uNcBdVCwZmRJ1fb7fXzm0US3ZLlC/ncaVZlyjqR59AdFR6BTeF99Vx49EEcNccG3LboZ
 geUjoDw+YJ6ghPJMvdJQtq1pKhU9aR+XjxGi2aDUOBczsPoCssD93mJhCJfExWowX5t9
 5ovA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778878684; x=1779483484; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v/+sLlSFlW3S2/+BTlJcRwOO7myufrATI+IC+lYuMm8=;
 b=hQ0hT7QOJS9NNv3pqfu/1LG03I82eaw4xHu3hnY/QNYa8bcVve7YewSJBqUyIQRTNJ
 yyshDooJSnKzLVcyUX3MU7DHBCdkNLmFe8D/tvrovenMqkbq7CiPu4LXMoY76b1l5auJ
 XbZBtE2rH26UHTj5Nqu/08+pn62ZOjZn1oMtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778878684; x=1779483484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/+sLlSFlW3S2/+BTlJcRwOO7myufrATI+IC+lYuMm8=;
 b=RsfLuO7NKu0gdCDnAlu4TrRsx8qz80tLgqLL0nbhShzblyJ79Gbebx450j9lSdiUcM
 2QR78fExWLcP+AGNRqjE1DljMNypgMYh0YIQuxDQlBbQOfbRKDbd108ToxlCYsL65i9u
 EF6m2nFTPQjLYWYZqdqB87PvETD9qrCdHxyNwrz9c3nJblk03b/UfqU5q0E+Kqn/mG+a
 tNlXgNQwZ3Q5/OZk42uTF2aXv7fnHqsTl9QuKUzqZp8kQ9YW4xOqnxV381wRmc33yq5f
 aO7VTK3qQF9VbGXhG5QUEU/NIUg9ym1TCxb6xZ6qHC2dEWnI1NKPzFAoWu1W20Qe8jPo
 H7aA==
X-Gm-Message-State: AOJu0Yy+QGNOanydmfGMlkVogmKrzLTUBTDHtazuWkPqsVF6heCEfajb
 FaDXQ4zCpfukBtuh3pRCMT3XRppRFfqbK7OToVyPL2gLnYyreqUhoaPlwNKxi8a5bi9YKZoEtyx
 w3/pljkZmQlM6dFkvog37xtV/x+lXqQ0sIu/8G1LGUih1K9MZfrs=
X-Gm-Gg: Acq92OHHYTONZgSft185bmFLv08wMa1EA4JtC0xFE4bg28msbAokIJcyCEQo8NOMnhq
 aHea8uOkTNgzGlhijVWRkzrnAte/imIUHGHLx0fCGUP38Pc+gYaekOXF8LzsLxvrtyJen6jJezT
 MrBTf2Cgy7B6vO8Ik1M7deL/B/2n9FAY38UGxCweBiHga2+aFrXmAWC/EwhvNMpoNVl2S3DFv1w
 OK5bLTcbEPKvSyBKfQEK3MBntVmKWaM9qt4fVOh6UuGGmbnnDdCbeFw/HjIL/ty5uS2Cx8cIIsP
 nEbveA==
X-Received: by 2002:a17:907:7f9e:b0:bd5:25bb:4e9 with SMTP id
 a640c23a62f3a-bd525bb09efmr223870766b.11.1778878684295; Fri, 15 May 2026
 13:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
In-Reply-To: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 14:57:52 -0600
X-Gm-Features: AVHnY4IWir3TSYzcrfmdI6EiXrP6P5q_YWjx_G3WHdjp3ecCCrQNqs67uhxYJxI
Message-ID: <CAFLszTgbu6Q3r5D4-ijH5Vqhwp6p1j3PMLZhi0QnYxyuUzcRmQ@mail.gmail.com>
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Mon, 4 May 2026 at 06:16, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> As you know, I maintain several tools which are part of the U-Boot tree.
>
> Tom has previously suggested that it would be better to move patman
> out of the U-Boot tree, e.g. to its own Github project. It is a
> general tool which can be used with Linux and other
> mailing-list/patchwork-based projects. I have never been keen on
> taking on the extra effort required, but I've recently added more
> features and am wondering whether now might be a good time to do this.
>
> Buildman is quite obviously designed specifically for U-Boot. I have
> made some improvements recently (a large code refactor and distributed
> builds). I would like to push those changes to mainline. Do people
> think it should be in a separate tree somewhere?
>
> Binman was written with U-Boot in mind but supports other projects
> (such as Zephyr). It is generic enough that it could be separated. The
> impact would be harder code review.
>
> We also have smaller things like qconfig (which I have substantially
> rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
>
> What do people think? Of all of these, patman would be the easiest to
> move, with the least impact on existing workflows.

Are there any actualy patman users on the list who have an opinion? So
far the replies are from people who don't actually use it :-)

Barring any other comments, I'm going to try to set up a new project
on Github. Re u_boot_pylib, the easiest thing is to duplicate it,
particularly as the newer version includes claude libraries not useful
for mainline.

Regards,
Simon

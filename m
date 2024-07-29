Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B773CC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:26:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421138880E;
	Mon, 29 Jul 2024 17:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OoB9UHwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5652D8855C; Mon, 29 Jul 2024 17:26:26 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A41418880E
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6b7a3e468a9so25421636d6.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266781; x=1722871581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mr4a6Kbp6mB5Ky7DOvLDPvO56g+v1hyYITKISBlmgSQ=;
 b=OoB9UHwRObQyEx19c1J2U+Yw12ONZ7P1kAV535u86WDObYiA2wUMafZbOj2qtoE6VP
 clCUyi/ly1C4Q9EUWTQP89jjYNDMa1xVXZanPRx0b1XK8okXBxR4N6Or1bvoQjzR7Sbr
 r041JAVwSG6ogmI5J9oGp0UBJyf8ZhkNsrFGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266781; x=1722871581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mr4a6Kbp6mB5Ky7DOvLDPvO56g+v1hyYITKISBlmgSQ=;
 b=vOBRR1IbCMWrG1yPzMuxf+qC+FJZjMGIfrGIw2M8C8x/xwUPubbjpFzeHWo4QnwIIW
 fWlrxjoxl/cCNyfW+s9h80csv5tznSuSpcrW+QqP58JoYYaR9xS6vq2hxn/FNlyPrcQA
 0b4GyFVqeVp5K1Pi1y/Tzv963m0ib33BcjB9q/cUg9j2ySrfplkdj/76m1nNyPLba8m2
 A89JOq7rlLgWFi2tPMmK2fBOydFLQIpxHAJNM1/BIiyn5wUxoBTbPxnElX2WlkjokQHq
 iWcWEJtvIdWuRK5s5VZEknBi7V/NVRvKXTCAY85RHfcSIvqw63NVNBPdkGWjxilawles
 5B7Q==
X-Gm-Message-State: AOJu0YwW7iSPfrGQYuiXNO5k92uAVxVa4MMRojW33P5ICD9Q0x/mRMgA
 kxF16z40y7zkOi1jJ4AIfHItcGTeRmS7lcKNstfftDhV4Mh1vKoLFRR8FHSBMkggBZJI53t2LGo
 CTZcEgGA08sQX5YZU+p5+DfeNZ9ijE6ZYpX/9
X-Google-Smtp-Source: AGHT+IHBosUd4FDMevnBb+OAm+/eN0l7R9qWplS501bepaHp8TNj9CEQb8fav6iSxKojsFgqES3OJDjrkiTK8YOBMkw=
X-Received: by 2002:a05:6214:226e:b0:6b5:485:ea30 with SMTP id
 6a1803df08f44-6bb559baa81mr99309306d6.3.1722266781502; Mon, 29 Jul 2024
 08:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-6-sughosh.ganu@linaro.org>
 <CAFLszTjCUWWZ1at-NWR17NJu1V3JjksFehy2=QgX2xf98SfXug@mail.gmail.com>
 <CADg8p95aqMAAHjJwtwkq2JJGEcYLE9thnzR-EdHYD9v0PEd9oQ@mail.gmail.com>
In-Reply-To: <CADg8p95aqMAAHjJwtwkq2JJGEcYLE9thnzR-EdHYD9v0PEd9oQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:26:11 -0600
Message-ID: <CAFLszTg5T9a4-HVfucA--9aj8hH1x3DXqv+kaft-ZgX460yKCA@mail.gmail.com>
Subject: Re: [PATCH 05/40] spl: alloc: call full alloc functions if malloc
 pool is available
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Mon, 29 Jul 2024 at 01:46, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Wed, 24 Jul 2024 at 00:03, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > If the malloc simple functionality is enabled in SPL, it is not
> > > possible to call the full-implementation alloc functions even after
> > > the heap is set-up in ram memory. Check for this condition and
> > > call the functions when enabled.
> >
> > Is this because you want to use lmb in SPL. Is that needed?
>
> Yes, there was a discussion on this, and Tom [1], and you also [2] had
> mentioned on the earlier series that we do need lmb in SPL. You had
> mentioned that this would subsequently be needed for VPL too.

OK, well at least this way we can make sure it is disabled if not
needed. We can worry about how to pass information through the phases,
later.


>
> -sughosh
>
> [1] - https://lists.denx.de/pipermail/u-boot/2024-July/558250.html
> [2] - https://lists.denx.de/pipermail/u-boot/2024-July/558644.html
>
> >
> > BTW I'll send a patch to allow alist to run without realloc().
> >
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since rfc: New patch
> > >
> > >  common/malloc_simple.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)

Regards,
Simon

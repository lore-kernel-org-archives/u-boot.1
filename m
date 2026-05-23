Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3646CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B7DC84855;
	Sat, 23 May 2026 11:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jkIw8nCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF2384865; Sat, 23 May 2026 11:32:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE167846AD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bcd3c190f71so1327470566b.0
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779528765; cv=none;
 d=google.com; s=arc-20240605;
 b=H8qiN8mECeFQTPIhHBFwcv7aH6NocNpok8YfMmgkb3edgYyRUaG4zcBGtucTdDeC7e
 55wEtWFZQSWP5ZNUnWsGHLr7pQ0O5Fpvjjtgf4qLyIJNQYMuUzVoOqcw2EpP5NPxxH9Z
 9zOm3q6DAiEhsM7o3W+MQdn9eIFxxlqiAIlZFmatbIP9AnEvRILr0dlmrXo8JXY4wA75
 5ktDADqtUoU6wwjwnEQcX6ufr1xmCdIIf9ta25XEaMWraX4polAq7TPGwaAuPjYdTyq3
 hs4HH2PGu+sAmiGFEwrtJeXtShrwTvTlEIpvFVKE3+8/2VteI1tuxWAt2DeT+YptYQzd
 fz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LSFCYP1Mpgkpxdy5MxLGh2DghiTMzurGe1tfdfb9uzw=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=FJ9imlqS7MK0UBbLZtfvk1SlV8a9Z9x2o+X0gF+lj6aaqm58KzPXWqjm62XReDN8+g
 qj9E3eVn/41a8C9ZxLbRDMg/2M7cAdm2+v7Nvq4bYDqiy8FwqUJJkHewIaZF5FhDac8E
 zXb4mlAqjVH4Y4QEE4pUxJAMmd1jSa8eJXGGZgWYOjrNb6uSWpG8lZEkeVJrh9Vpr8qs
 j+mXnbzQSy9TbjA/yamKABw3XJZXKxQOzn5zBGNDCEC5/8oy3M+zkK99JASwP+m7SGhm
 s8taEAU6iBwxXKvxJLDHfNpj1/UxmkES8gmSJvAlDcKxaUA9YVVrYNGQnDsopfqtwxOd
 kqyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779528765; x=1780133565; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LSFCYP1Mpgkpxdy5MxLGh2DghiTMzurGe1tfdfb9uzw=;
 b=jkIw8nCdvh+PPqT1UzY6Tnv88Gajbo19JgNJIv2EwU0UYQpreV+rgAjHH/SrB9/8I5
 KPIyDmYX5JX5HcoJfam6Zckuc497zPuIHB8MB3pHYi36wPZOyX64WdcgJrWbls//0Gf0
 cLm091SyiSHQF7e6i8c1dVqsLKG97MIFzBPZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779528765; x=1780133565;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSFCYP1Mpgkpxdy5MxLGh2DghiTMzurGe1tfdfb9uzw=;
 b=fOc+RXwkJ+OvjD3B5PQQq+FHudq5T5p9xyviDZnyzPtwZI8cb3EyashP+M82+1nVmL
 sCdPdGZ/fQn61f+k0qTCexQxDQAiUw1nsYBGWcZxzwFTP4mHjJn6r5DRac7ojAtvlqfP
 rTnBVpnj5C1QhlIFK2sMfb6bbngWcRllllLEMTBMQlVNxicADIAwSDX8Ze/hbXenyZM6
 KXToOY9bSmJIvSQxgMCQUTKZ9d+r48y2oD0g3jWn/VXFpaGXfqU5p4Y/Ki7NC0EGKUoB
 v486/QZq8tgpFwHUTRyRhovvlRjuwkJtVxZmbdZJJJJj1SwSI4swcJUR2TyQJGLAj8dS
 m7/g==
X-Gm-Message-State: AOJu0Yy3LB1qTHtI6XZpL36mLT9oWkkQszRCey8jBv9Wk/mSt/JXj/ir
 9h/s53HjMPSWE4qYnfSbB9EokCraH1qwyJVkEwZJnq4qqxIX8cLo2TWkZBi9dj9gWNpRFpD48Vw
 GwcJeXRGUiiwlo1R/CeF9sN7AP8sQoUJ8mPGbfTRc
X-Gm-Gg: Acq92OFfpDhWcsl5zrUfG0Psi/Wu3EI2MWGLcR2bfHtTscU8Tt3v7UP/T97rE7uPsid
 n8v7/SqHU+7yLbRmWS4+tBoNc0+imFHZDw4keUcUmuhC7YhFC/buwc2PYfjujAMCQROfkj587yw
 OMxJT/y7ib1vSUsJpoHALTM+gFi9GOT5Rv0BxCiExNeIVSK2K55XFxw+lngm8vIKkE9k4I4xSan
 vheTvDoffbp+cZ5iQfQx6e8Do0uan1HkLEjhnZ585rgJNo4vtEjBN46A2KQSaCTvfu3y+JGcj3N
 slgs0Q==
X-Received: by 2002:a17:907:782:b0:bd4:a849:b13d with SMTP id
 a640c23a62f3a-bdd2580a0d1mr404493166b.22.1779528765251; Sat, 23 May 2026
 02:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <CAFLszTh3vk3FbrOXWrxY1JP_Se7ewuoQhHETZhjrkKcQLZ5pzw@mail.gmail.com>
 <20260522150014.GQ1858239@bill-the-cat>
 <CAFLszTiNu_pQb9Lzuy3R6wy5-KE16NSh93EUcjfJRZhLuVSX3g@mail.gmail.com>
 <20260523000533.GF1858239@bill-the-cat>
In-Reply-To: <20260523000533.GF1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:32:33 -0600
X-Gm-Features: AVHnY4L5LUztVtjrsTNAw65_YNMuFbdBcwzbALGk-qQX-3x99gJoVy9iNjYugrE
Message-ID: <CAFLszTjK5+e3CyYjd1Rbi7kvxxPiESBGSV9cSGAuEcgUnDMdnQ@mail.gmail.com>
Subject: Re: [0/5] Remove some empty bootdev_ops structures
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, 22 May 2026 at 18:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 22, 2026 at 05:14:54PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 22 May 2026 at 09:00, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, May 21, 2026 at 05:30:12PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > This series fixes bootdev_get_bootflow to not require the ops
> > > > > field in the driver to be set and then removes the empty struct from the
> > > > > places which had been creating one.
> > > >
> > > > Two more empty bootdev_ops structures fit this pattern:
> > > > nvme_bootdev_ops and usb_bootdev_ops. Please can you fold those into
> > > > v2 so we clean them all up together?
> > >
> > > I'll follow-up and remove those later, and also update the doc and
> > > remove the mmc one.
> >
> > OK
> >
> > >
> > > > > As part of Marek Vasut's work to add static and/or const to structs that
> > > > > should have it, but do not, it exposed a small problem with the bootdev
> > > > > uclass.
> > > >
> > > > BTW for patch 1 it would be useful to update the comment for
> > > > bootdev_get_ops() to indicate it can return NULL - normally, we don't
> > > > allow this.
> > >
> > > Don't allow which? I get the feeling you're saying I need to audit the
> > > reset of the uclasses for optional ops fields and then see who is just
> > > setting an empty struct and fix them too..
> >
> > No, I just mean that there should normally be an ops pointer, unless
> > the uclass itself does not support any operations. The case of using
> > NULL for the ops pointer is really just an optimisation. I'm fine with
> > it, but it might create confusion for people, so it would be good to
> > document it in the uclass header file, where supported.
>
> I'll make sure the documentation is clearer in the follow-up series. I
> think at this point the majority of implementation do not set one, btw.

Loads of uclasses don't have operations, yes.

Regards,
Simon

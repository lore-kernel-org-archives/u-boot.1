Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11182C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 12:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E27B88667;
	Mon,  1 Jul 2024 14:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NTz9DiCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E7B88676; Mon,  1 Jul 2024 14:51:11 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B55988660
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 14:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c9cc681e4fso1603853b6e.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719838268; x=1720443068; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8JHTQg8puvkGGujSemL4NbJyFi5rdEVXD5osYcdLe/s=;
 b=NTz9DiCiL0Dc8VqwBaSBDoxN0dPYBn38EgbfUiRI6/Icxuoawp2BBTdELipqVcnkJP
 v90P3DTlHJCGsIynlqwNkuw5noJ7I7P1obe9iIA45YxUULKS7QNolwz/mJC+jfNgY00F
 sa5YYpJHFrMRynLRwx+q1jSruIan+5RRBR0Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838268; x=1720443068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JHTQg8puvkGGujSemL4NbJyFi5rdEVXD5osYcdLe/s=;
 b=gPoeKAeEixc5mHMkJm2Fe6OFRJoME2UaDqiMyFuUkosyXf+rd9Iv7NjTz/kJaST+YP
 EmRy33/KBCEuJd2oNBULEJxHJHuvxNLaoygtc7/wybLgls9qpoClqadSZn89z5cbwRio
 qnJ0lxA/RERuL3Raw26G0s/T/RoR+V0yKcBMPHM3E8278wiV1wwI00eodhWOVxSeKYA9
 dTrke6txEliVWUshfPUyPy5a6kmwY73mO+cgIuv/6ynca9Aj7fF/CG1ZLq5m3BixJkKT
 5mYLA3XyWsSXj2Qo0PxWiUqR3fGjDG5Pqi+w+rArcr2b22+/+keYz5g224LW/LfMS4Em
 Dm8w==
X-Gm-Message-State: AOJu0Yy+uZQKgtgnpcnQFv7SARym0NbnQrMPg0pWdQ0Bd/nrV/RaF2Fz
 MS8ipdceUX9q5GGOLyRRen7+xaIJUc0/G0FLvm+0TGZTKIlzhsB/p3cZEcKuGctmwe2ltwOKdAQ
 YLFkWZU5NuLoJERPpCByBlDMTwSTzFDiJtZOk
X-Google-Smtp-Source: AGHT+IGLv0UPcGcnnvcv7Yi013UAVNOsip74ID/Ppis77CvX7yEfv3I6j5ECaHIvGPPaVwUZnyDWCscvLfa6cqtxrTI=
X-Received: by 2002:a05:6808:2288:b0:3d5:64d6:9f12 with SMTP id
 5614622812f47-3d6b2b25c7amr8836595b6e.3.1719838267734; Mon, 01 Jul 2024
 05:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240619123453.720600-1-sjg@chromium.org>
 <171945114145.3478677.13570700547612365560.b4-ty@konsulko.com>
 <CAFLszTiaqv7CXZg639JybryyaUerjJX=vn+gdh2nCeEPB2PH6Q@mail.gmail.com>
 <20240630145750.GI38804@bill-the-cat>
In-Reply-To: <20240630145750.GI38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 13:50:56 +0100
Message-ID: <CAFLszTjxPmNC=rT=rcjBZ4PD6U=kQwWNOdHiC7V+1cpU5yhdzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] pxe: Add debugging for booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Menzel <paulepanter@mailbox.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
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

On Sun, 30 Jun 2024 at 15:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jun 29, 2024 at 07:56:00AM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 27 Jun 2024 at 02:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, 19 Jun 2024 06:34:50 -0600, Simon Glass wrote:
> > >
> > > > Show which boot protocol is being used.
> > > >
> > > >
> > >
> > > Applied to u-boot/next, thanks!
> >
> > I wonder if this could go to -master since it is an important bugfix?
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=411595&state=*
>
> It doesn't apply to master and v2024.04 was also seemingly broken. I
> think it's clear enough that it can be cherry-picked in places as
> needed.

OK, yes it was broken in the last release too. I'd be happy to rebase
it if you do want it in.

Regards,
Simon

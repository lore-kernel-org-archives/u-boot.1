Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77DBFD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F28A83E61;
	Fri, 27 Feb 2026 00:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ccVh2gnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8817F83E81; Fri, 27 Feb 2026 00:45:10 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A668983D1A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so2633063a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:45:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772149507; cv=none;
 d=google.com; s=arc-20240605;
 b=gL1NLsfGdaS65pyitIziHIEAB9sZDfTu6eSu1OFA8+M8hU4svPdRfxOlrglSo5ZO+1
 1THIPpzqMYuWkEEgCgfdINDBXipbNHG895FHQRdEN+QM7VBeqLl+2/n3ZeUxLWDgoEoP
 KBco6PFwDtrmvH3T46BUnPoUKfxzje/pkW1E6RLQjQm57QCVyy1d6WY9R9V+zYuG57XN
 nRaTtUKQVTGIkQvm4/t/UcXZXzy+bCnyhRhAPB3myWXO/a9UIhz4m5DNdIGsFLtHfLIm
 /XxPKFzYY5wSkFVp73TDbegVRFArdack1+I7Es2Jgj8g4ATKNqlQot4pZq15dI9g6g38
 6ZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xn75lOmn20KSMQzPcoN2xVPamcl2m/fsWDeIJ0lZAxk=;
 fh=mn5V3Z3EQoSFeSjXpIxLtWYvp4nMGxThUgcID4Uu8+w=;
 b=I3jGvZm+KT/vX8dbTkrbgQJkNM6CxaXAmbv27aMf/Xvp5QsfM2M0XEae5gunz0opUC
 KkmEOzG3vwz503usowKnHUIkDvCuEF6kwSlEtCEtz/zl48zigwewQKPaO6jzSp4FaTlM
 YGo5Rac0j35Gf8CW9UZj3JJ+62+4VNR4l3NQXo8vEvS9Mt+mvKiu1gsc+KEZtRSnPfNz
 QvfPAX7So032JUsMKWzXF7Hfw/33IUXJFH7qx2WwzvVPLHdL48OSIivEangE656xKh/Z
 T3XYZtRlRDtjnDDiNT9TynePTJsa0XVWqR0/hWP19VUFD07RIDqPJ5kh+CBXec463nBq
 bAOA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772149507; x=1772754307; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xn75lOmn20KSMQzPcoN2xVPamcl2m/fsWDeIJ0lZAxk=;
 b=ccVh2gnf1+9/FGZEeyKZ7yje/QXa8wPAdNuavHi4EYAxz0IGRWxJ8etoVAFPkjqR1W
 k75ftRe+THRdaKyD8YjX9h4CzHgicpSMwW4Rd3xnBZHY79TX7mGVzX1VJ+Ywj/C3p5/4
 tcL3d6phyqgvBGaCo70YQKlOvZ2jrLWWtZAo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149507; x=1772754307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xn75lOmn20KSMQzPcoN2xVPamcl2m/fsWDeIJ0lZAxk=;
 b=LIn2CeT6Yk8BIi8y2dswf01LVSdmJ/3ehoiG0PRCPtqkyDr8D5Q2E5yIFhuoKgpP/5
 H+GUffH2Vx5BWolhRK7KGhlNr50lwphX9bnjUpm1mWQgBY9lZxmI14NIlLirAWlFaGet
 I36g6/F85u1cLWaY/4R6tBmVD3HkbtdnFgp24+6bIjG5KWzXQLEfwD11G7UClKSPMJVv
 hwuU7M5CYJlUD9DiJORJl4NZT+8EZYSx/2lQ9/xbfvUhloaww0opSwYolzEXUEChg9Ds
 d2kapcXEzx0woZ9ayRA0wKBnuk4YzOj1PRpxq3rgDzpbPxSqQwi0TdCrcrKJGn+J8Ifz
 vf0Q==
X-Gm-Message-State: AOJu0YySTt86loKuKQMDVbPPn13jZIxXZnLEzA/mnRYRjofmb/J/0Xoc
 8/GDfask+wOVUAnbD7mwjYubKlT/KOzfHOftNNcn9G6ZcWtgNx6AtCDOnbZ3vVBYhqR+scRRD77
 Ji029psxvMqI+e6nhUC9joDsFR9aRr0N7yQrWrl6M
X-Gm-Gg: ATEYQzwZrU7ZuSNO+2027rUMJDOa18zj1QewznL/uQojxuZqRZhm4xjbjp9C/OaDZK8
 lbI7hifAx1aiG8nwTLZKI3bS/6M4CiNw544rS05hHRvdmdzR4ki9LT2nvNbU6UNQG2Zgf7HKc2L
 g4FtnTGAec4azc5oE0lqP8f7ygP32n+sztfiLbrTG1gRDyXx3sDPNV7cFC57zxYDRMYwEr1Tvy7
 wAovWA4QZ9ymsMr6C7HhAE6Gou4iceFtesgYPwkDjuyNtr+r3/HDNyw+4KBxrApY9/Rslvk0jiA
 jMlCQ+GSpoiIsBGY
X-Received: by 2002:a05:6402:5211:b0:659:4295:970 with SMTP id
 4fb4d7f45d1cf-65fdd6d7431mr664108a12.8.1772149507129; Thu, 26 Feb 2026
 15:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-4-sjg@chromium.org>
 <647a1ce4-66c1-42f4-8841-69828cd665d2@cherry.de>
In-Reply-To: <647a1ce4-66c1-42f4-8841-69828cd665d2@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 16:44:49 -0700
X-Gm-Features: AaiRm522yV7DPAuKoYe3XRY2jrbxLdnFiPk_TYGPZoMjS4f2VDz3WTiN7Bblcik
Message-ID: <CAFLszTjcJc_WNRfz7h_rxAKkY-UoUAYD0G1PZh=eNccjBPGqoA@mail.gmail.com>
Subject: Re: [PATCH 3/6] binman: test: Capture output from tests with warnings
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
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

Hi Quentin,

On Thu, 26 Feb 2026 at 09:44, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 2/25/26 11:50 PM, Simon Glass wrote:
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Tests are supposed to run silently and capture any output produced.
> >
>
> Fair enough. But how about making _DoTestFile() and other various
> function calls actually eat stdout/stderr by default such that test
> implementers don't have to remember doing that?
>
> We can always return stderr, stdout to the caller of _DoTestFile() if we
> wanted to be able to parse the output.
>
> What do you think?

It's actually quite painful to develop tests when output is captured.
You cannot print state or see errors. So I try to capture it for the
smallest possible code area.

I did actually add a 'patman test -N' flag to help with this but have
not plumbed it into binman. I'm not sure if that would make the tool
even harder to develop in.

>
> > Fix testRemoveTemplate() so that the message about the missing openssl
> > is captured, along with the invalid-images message.
> >
> > Fix testNxpImx9Image() as well, since it is expected that container.img
> > and bl31.bin are missing.
> >
>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B04FFCE086
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B7783D1A;
	Thu, 26 Feb 2026 15:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MMCBZW94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5551383E61; Thu, 26 Feb 2026 15:16:29 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D4E183AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9362ddbee2so70466366b.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:16:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772115386; cv=none;
 d=google.com; s=arc-20240605;
 b=hS/DdAELcu41f/FSQYD//DyVdlJCqRK6zvtf3cX3TYs8kFMGgpappwREBhv1NQ2U6x
 I5JkBw9ju7zMr+aHgC5Is4bfvO7/YIj8VHK7P/1K1M6pLlAFW5kNO7Ovbs1TqhEpDDuw
 6wEbL5ZQZNwSw6ycUuASjdEXrlFPKLEO76QQ03cAU/scD8mh7fpAKNReren/f/16/dro
 WxnP45Rd+Ott33SaFJ2ToeSK4QRkyyBfN0dcn6kDamyfhwyyQPjH1T1RIzXn7M1wfgdv
 LmsC718S+LaH5c3ie+gW8PaH22JBqnrUsjHpev2RztYUF97k2KQZmoLNsFVY37XzANAQ
 CEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WpuRRZvbIxBasiq4BywC9RMpCHcek+C8LG2sD4F5Bis=;
 fh=HB2HrDgSfZYRQEw85TEie0bnLKnCVl+8/W0cJwUF4ts=;
 b=dzisSGpsL3bLgjQqFJ/NZ55ds9ssio1tUQszhSC1iqLaQfCXlx85lvTOcuhXPuo2RD
 AAqc5Wj7nuBcsXLd27xoP4gOCMbAB5CK7p26JyVflIePULzlnQ9xFGiMqCmHAcH+QFeL
 l1mQ6Icl1xDYIvtwueszwQ4fmgOZLQp1tZnZdSOylR8d/kMOEEnuitxWqudrE7dVAQwr
 vOw4VCF4K0nWdaxMpYhxmQrfm4dAyctQO5eHJaDAR99zsZOu0s8cqtZsmtgsvTlLd4FI
 +ablqAB3OysS7zvmI8cv3V1QzsoLltaXT05gmxxeNY2YD4Nk+bjb5OWyT1pIvVbSP8jy
 WaBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772115386; x=1772720186; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WpuRRZvbIxBasiq4BywC9RMpCHcek+C8LG2sD4F5Bis=;
 b=MMCBZW94QzcYkEIG56qYsKWE6Ji6Pm7YA3+pgXsXCQD8s7+iC0kmNQnFg1lTxS33uL
 ZoGSzdUOOktqxdheEcBIxcldb1SAmxwgIQaln1lOSSMs5kqLA+ldcbpZIL+bGmy9w73r
 d6XInpdn2wk4th4VYJXn2Y+LqX+Eoa0wJ2YdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772115386; x=1772720186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpuRRZvbIxBasiq4BywC9RMpCHcek+C8LG2sD4F5Bis=;
 b=GMCj6ACNCbqHZ4XCh7NjxdB1spNReSMZYt59HwBTj73WV+5k0z+XQ9JE2qaB9yx0Ia
 aOQ0ki8kGrmudOBmyrlGpGiVBrr9gY4OSgu9JXg0Y+WhVIFvaOkbJJPpZ0p1sqTnicZG
 x3h3RINpb4HVW5Pk1/OR4YosThs3Omwvw0Siwti+z/1I7EJBqAOEIs2ffID7yd9EQGVs
 rSlQaa16LDSKhb1vzQicN/yOp25S4/p39WVGLf6/FcvpQYOpIKs1WAOA+wuMZqa5r2jk
 isXClgzl1RVQXy3zgVUwtIBIePUDyEU+057UIf3VMRP9fHrDSWobY+U7q7i0pc1F4PUp
 NAuw==
X-Gm-Message-State: AOJu0YwKfIdyCrB8L+74Tkt9lIFnvLEAktAsBc8dLIaEbxEcPjQ7x4kh
 qIqQpmnhRXx0Rj9DCrxM9SHcj57SM3ExeF+f9/40JSMVrfXh1CTJgi1nDQ4BTbuoPK3Z35c38Wc
 AvF8kqxsZI4bx+ypt6Wd8Zzci8XCfmTqWB7czGSbf
X-Gm-Gg: ATEYQzxQv2JgKyTjsGQwihbGDz5vi+4e7din6/497BisqU5Cz5z7OwA4KNlsUKdlJpY
 ltQ5ciitBflQubFguLrcqowFXG3X6fxctpac/n4Az+668NQaDytpJN4HQRLYGu8aSWZTpmKiprc
 LjfRS3Z0Hm2SzzI1beo+6dc86vsHGIQueStbZpYBl0MpH8q3wRvNat3lHf1Aw751dy99af3jHAt
 Hj0MWffQCEGNl1xfY2HiOkOxcTtCZhpA90tdy0eZGGPdiiWl5NaVD6hoOOva5PvH28f0myrgCJ9
 tkst/g==
X-Received: by 2002:a17:906:f59a:b0:b88:5ef6:17f4 with SMTP id
 a640c23a62f3a-b935b4f876emr145569266b.17.1772115386370; Thu, 26 Feb 2026
 06:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-2-sjg@chromium.org>
 <20260225225453.GZ1593142@bill-the-cat>
 <CAFLszTjp33ygXW0NYXwan1VP_5RwXytiFXLfStKGF4gv6vA7OA@mail.gmail.com>
 <20260225234043.GA1593142@bill-the-cat>
In-Reply-To: <20260225234043.GA1593142@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Feb 2026 07:16:10 -0700
X-Gm-Features: AaiRm53_AJMxjDdP0pQebfWZrtiAKRTOJ6y6qmmut69WUf61zlNLcQuCNjwO3AU
Message-ID: <CAFLszTj1jEwc9Y617G-UXhwxy-V-vH3Jy9A=86FM4aA+oq9s3A@mail.gmail.com>
Subject: Re: [PATCH 1/6] binman: test: Renumber duplicate test-file prefixes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Alice Guo <alice.guo@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
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

On Wed, 25 Feb 2026 at 16:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 25, 2026 at 04:34:37PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 25 Feb 2026 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Feb 25, 2026 at 03:50:30PM -0700, Simon Glass wrote:
> > >
> > > > From: Simon Glass <simon.glass@canonical.com>
> > > >
> > > > Quite a few test files reuse number prefixes that already exist in the
> > > > test numbering. Test .dts files are supposed to start with unique
> > > > numbers.
> > > >
> > > > Renumber conflicting files and update the references in ftest.py
> > > >
> > > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > >
> > > Since the numbering does not seem to matter, can we move forward with
> > > some other scheme perhaps?
> >
> > With so many files, the numbers are the only way I can easily tell them apart.
>
> Sounds like we need another scheme then, as collisions over numbers has
> happened too many times. Some subdirs might help instead.

OK I can try subdirs and dropping the numbers.

- Simon

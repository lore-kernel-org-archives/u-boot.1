Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F13C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB4DE8198A;
	Thu, 20 Mar 2025 04:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6EdDWaP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 438338198A; Thu, 20 Mar 2025 04:43:32 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A50308083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5cded3e2eso514989a12.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742442209; x=1743047009; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf1MJucvdfQdi3IfjZhpXlb4dI004EMaZYIG2L30Ibc=;
 b=c6EdDWaPO2hwO5D9wIh4K7WaLJf6ZDrZ4aeg6lWo9ZYovhKCiQg87/r/1af0Xitr21
 qCPe83ko9MJhUwqoGlY9TfHa6bXMtNsfaGOO+xnHPcFRpJKRV5H11G834NqyATCtwv8e
 MW22GnhZreWFFOozCO3fUWXjsTipZVigB4xoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742442209; x=1743047009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mf1MJucvdfQdi3IfjZhpXlb4dI004EMaZYIG2L30Ibc=;
 b=nGe+i+4I77Pn/4DeOpQ8imfrCWN/P9xwwHM0yayBfbtuXVisnKJVfI0A0SJ5vvdb5t
 Dejg6z6G7LxLEkf2qn/3/g5lFSMMVemIxT92fpGi9bw8QWB3cXF0d9x+xGJTJEhzFp0E
 xZg1/RR3BOXDy/pCtWf6nNyMCcUampbSCp9muylkd3aTbb5tGfi7EtHqSivmJtT14yEB
 B9VDWRP2F9PE+8vLz5Ad2nCQjQcoZTfeLnA2aJc5x7Eo9vJOYKOpklCGGmGJxVJ8gVRg
 4w2TnEE2jNtw4ikLuvdNUJq5ClYfrsTv4lr0f2dF6EvzzEoVecGfWVJNDe78JkwcdLTT
 acMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCz2IkQzc1OkaghDB0KiGD0bwmj36tHlkowSQuZ/z2SNBSooToHL7Tx9l/eT9oznuk09NwUGc=@lists.denx.de
X-Gm-Message-State: AOJu0YxDDvsdkTvDjxwAsXirUS8D5HLZciEsIa/4bi7wayGxkWzYknbc
 DQwuTuCyklg/hpC4M8InW0gzQXKyAiIk/+OKBj55vvsjgrOP6BhPetjwCG6Qmvl32qLe56D9Fn+
 Vxa4f71mC0s5Dl/vFVWzID03uuVIJxqBKZtGP
X-Gm-Gg: ASbGnctvlpEbER9Omhw7qZyVmRW6nqhtbn7qelEfV/G4BfNaUkqSTj3EgU+mUlWkMLh
 drmDDdTKj35kiUX/65aEHcEDe6IxFwjNbDT6jYrFjC3qKpqPAIFmhgCPwzpvb9jOT7Khcjv4Gea
 aMGU9FGc4AjZP0F0fihl1UfBWhilohVHnhp1L4Mw==
X-Google-Smtp-Source: AGHT+IEhaIwyyh9NNPmJ4486jHa/ebIA5WWuW59Q4OjMiNzUcJcq+PsChcBMQaQ+FH4sHO3MIpLTn2bpfnYeCrwX/5M=
X-Received: by 2002:a05:6402:d08:b0:5de:dfd0:9d22 with SMTP id
 4fb4d7f45d1cf-5eb80fa48bamr5008159a12.22.1742442209215; Wed, 19 Mar 2025
 20:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
 <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
 <20250319142038.GE2640854@bill-the-cat>
 <CAFLszTg17Q+ovvc2MeHLadsSdK+LJuHsXhf=fFybkbf=zLy36A@mail.gmail.com>
 <20250319153621.GK2640854@bill-the-cat>
In-Reply-To: <20250319153621.GK2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:43:17 +0000
X-Gm-Features: AQ5f1JpMCPxzLJx6OQlS7PRSy3eMK7zAfyy2bFqLZzLMi2xi99euhWUxzLGfbto
Message-ID: <CAFLszTgTC5bG=tLeHQ8CYCymLND4bykiWQCgBhszcUORhT5LGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

Hi Tom,

On Wed, 19 Mar 2025 at 16:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:04:00PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 01:12:30PM +0100, Heinrich Schuchardt wrote:
> > > > Am 19. M=C3=A4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromiu=
m.org>:
> > > > >In some cases we want to show a signed value to the user without n=
eeding
> > > > >to use the full printf() implementation. Add a new version of the
> > > > >simple_itoa() function to handle this.
> > > >
> > > > Where will this be used?
> > > > Why can't printf be used?
> > > > Why would this fit into this series which is about test improvement=
s and not about functional changes?
> > >
> > > It would be more fair to say that only one patch in this series is ab=
out
> > > testing and 5 are adding otherwise unused changes to functions that
> > > presumably are used in some later as yet to be posted series.
> >
> > Sure, would you like me to change the cover letter?
>
> No, I'd like to see the test by itself and defer the unused additions
> until there's something to review it alongside of.

So you don't want simple_itoa_signed() or abuf_printf() until you see
the series which uses it? I'm struggling to square that with your
request to break things up into smaller chunks, though.

Regards,
Simon

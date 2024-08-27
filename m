Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E5C5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 19:25:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514B988A47;
	Tue, 27 Aug 2024 21:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V4H2xDBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A72D0888C1; Tue, 27 Aug 2024 21:25:14 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A1C889CA
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 21:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a4df9dc840so345466285a.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724786710; x=1725391510; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bL7EnoB1zE652nJoVFy4zXTQQWfES++I8YLw4oX5V28=;
 b=V4H2xDBKFMPGsdNrwWBlTdJT3RtUAdxJ2StG+k5hSdZfKyshBwdr82+xjJc9NWzBU5
 PUbM2v4oxSfqbXTnG86G8sD0xUYVDgHjsydxMJ5tP99s58IdFvAOGmVAnYquT5bfEyJ8
 tQSA7Y8tPEiFeToR396WopZY5d2NPyvLDndEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724786710; x=1725391510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bL7EnoB1zE652nJoVFy4zXTQQWfES++I8YLw4oX5V28=;
 b=b92Z6AXJoXMQZF4xFaA4F76pIlSd7Kb+pEn+Fuf49ccwjXbNbKkGIgADQrD4IoUx1Y
 Doh1vvRQPocNCsmP0db9nAT5ceL2UW0OYSsBs+h1o4BCBsJMIXUlt0Fw5AtF/TQAlce/
 wIdKWZ1qdvlj0tpQpL8dgKS4Fv/VsM4aWShjndvcuIKMXO26EvgSgSxn2TsI9H2ah//K
 Xu0wX606mstP37sYARcB6WRPgZPSNALPPbVM9JPEIC0FIR9D1TGoOjqqBSdgaOwlcd73
 dwOoqrh4VYYaKu3tBBI2CQIeai7Gl61+w+fdWJRC71Jce7DqrcRlF3gTaaOTc/7h7ntY
 kvBw==
X-Gm-Message-State: AOJu0YyBNrP1yySS0dVp/lcoyUVvPES3l+PMldUBaeE3ul9Pb/ANoZqb
 ZxFT1R7xsA3ldrvcd4dROZ/9zIvZEeBKbPKsuhT3q82hNZB1vi+hq3Z3EuxBy8KP0AdVtPJoOpO
 I6pK6mYg6rq+USIKPzkav13AlZbMwEwJ+F1+OV8j60GjeX6s=
X-Google-Smtp-Source: AGHT+IEvkvIlN8A0OfG1B2P0ZWEl+RFJnP7EIbzkNzzvittpaOMzj+BC60+9ZYG50Yy6LzyK7MA//OYRU7Dhg7gFaqA=
X-Received: by 2002:a05:6214:4304:b0:6bb:a16d:279f with SMTP id
 6a1803df08f44-6c16dcb7b2amr167851676d6.38.1724786709836; Tue, 27 Aug 2024
 12:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
 <20240827165025.GN2479150@bill-the-cat>
In-Reply-To: <20240827165025.GN2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Aug 2024 13:24:59 -0600
Message-ID: <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
Subject: Re: xPL terminology
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
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

Hi Tom,

On Tue, 27 Aug 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:
>
> > Hi,
> >
> > We have the term 'SPL', which has a dual meaning. It is both a
> > particular phase of U-Boot (the one that loads U-Boot proper) and a
> > generic name for any pre-proper phase.
> >
> > You can see that in a few areas, but for example CONFIG_SPL_BUILD is
> > enabled for TPL and VPL builds, not just SPL.
> >
> > I propose to rename the generic term from SPL to xPL (meaning any PL
> > phase), leaving SPL to just refer to the phase before U-Boot proper.
> >
> > The symbol would be CONFIG_XPL but in documentation we would talk of
> > xPL, with a lower-case X, so it is more obvious that it refers to any
> > phase.
> >
> > What do you think?
>
> I still worry this is just another part of the long symptom of needing
> to re-work how we configure / build as we have 1 case of "build things
> this way" (full U-Boot) and N cases of "build things another way" (SPL,
> TPL, VPL, UPL?). And really we need a way to short-hand
> "fooboard_defconfig" means "fooboard_spl_defconfig +
> fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".

IMO my XPL series does this, at least for some definition of this. I'd
really like to get that in as it would make all of this much easier.

>
> But on the flip side, I also suppose replacing CONFIG_SPL_BUILD with
> CONFIG_XPL_BUILD would be less confusing.

Yes. What do you think of E's idea of renaming all the options? I
quite liked it when I read it, but now I am thinking that having
everything be xPL is quite a nice convention. If we have SETUP_... and
TINY_... it is less clear that they are related.

Regards,
Simon

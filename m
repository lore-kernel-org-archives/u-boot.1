Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524DDC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94BFD882E8;
	Wed,  5 Jun 2024 16:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VNqox3ZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E0D88300; Wed,  5 Jun 2024 16:28:43 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E4C1882E6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c2039db0c6so746557a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717597719; x=1718202519; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rl3S/Pf8xhpQO8KuxKEPiZjZ5s8k6PsJHsTr4RMCKOA=;
 b=VNqox3ZTQO5z76EZkoVWUl+keynd7+vi2csKG258397N8fBrgJTHtDuqWx55peMbJT
 61cNUA30paldMiCzCFt51kGL0yjlz0zUE32QFsm6tsVReK62TkNtO5B+RnMwEqXvQl7w
 zr+wDpTJSC8uQs8Rf2KqaGCkT/OeCvoBxb/7dllkfKtsd+sMsq00I4yQTsx5/vUQm1zG
 BBDgNFVQjLGgeb6TWjUd/ekcqgsL+iGlJZlCmKrbrqTUEKRCtXKZM6248t393poU0okz
 12nYBNUAbUBMFeDC9SpfjcMZxQUkJPkCUZHP6Ht1EWib5ZDkdhRNPdNcIkVycFgUJ7gj
 x1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717597719; x=1718202519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rl3S/Pf8xhpQO8KuxKEPiZjZ5s8k6PsJHsTr4RMCKOA=;
 b=MJ3jSze7sitp+XPLYa73nKh+kCnro3guloGrjAleY0cZGANN4/zVD9UApbUzE11guP
 WIs8MgRBhU49MSXo+p0aGQhVU2UE0mQ6i3DhPnXJVdEb5RMxNSHfv2z6jK8k+Hr+QOW9
 zuRHKfwmTo9FLaD5nfOZn/KlJ88wPRxru0wauP9bA72P+btWHL39TdNFmm1KEWbVl7GD
 CnsJOmZ+UWJsSxQG+HGiFx4fiC1FR3zES0orz6OBvRN0xupgugyTxXnYr/zHmn4J18nj
 hf3zYNljdjcn367aFp2HTmdpb012X9S6pVY3vFY75XY6soUh+xrP9fslwSxyizlscxnS
 7KYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULu8IUaYKpFAmbrX4AVw8Yh5Pgt+hbMxoJD6JCJncqgymldl8C0+dn9QACivpD+padljUro9CsBpBRoR1wGLyJx0rWiQ==
X-Gm-Message-State: AOJu0YzliaASWwDegq+QUo9sAmGVNZt6U+nEHy4ObQonxcFC8+te9t+z
 xLpeIUVT7qB/33cpi0iGzS15G4ePBhSzjF6reZSLG6lltuMtvDry0TF233g7i9cuoaH1psdoQYy
 8emLV4YK0rGnrdkztz7wRWvkF+aVcHCTR/turFQ==
X-Google-Smtp-Source: AGHT+IGmPQMGRV7SDc0KEJdPoAScrWu6zS6wQChUITrQXF1o6xU6tJ0Z5478QcA5Hp6asUIRTAv/c7840Zqn1+Ov2yo=
X-Received: by 2002:a17:90a:5ac7:b0:2bd:801f:dabd with SMTP id
 98e67ed59e1d1-2c27cbacf69mr4191173a91.3.1717597719424; Wed, 05 Jun 2024
 07:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
 <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
 <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
 <CAC_iWj+PpUurGLqMw42ALHV6fOLnSwscG4KB2k-55eO2HuLwCQ@mail.gmail.com>
 <ZmA7NgxcSS315jrK@smile.fi.intel.com>
 <CAC_iWj+B+X2BQP403X6wz7dj2HHUO_j0rXb=TjAwh6zCMEgGNg@mail.gmail.com>
In-Reply-To: <CAC_iWj+B+X2BQP403X6wz7dj2HHUO_j0rXb=TjAwh6zCMEgGNg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 5 Jun 2024 10:28:26 -0400
Message-ID: <CAEfUkU+VxkjaOxk8YCk=7jL8mKbnNg18qxUAY1LYFRPiN4Vn5Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Andy and Ilias,

On Wed, 5 Jun 2024 at 09:31, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Andy,
>
> [...]
>
> > > > > > Is this approach maintainable?
> > > > > > I don't remember if we have similar in Linux kernel, for example.
> > > > > > (There are few candidates like compression algorithms that are
> usually
> > > > > > being
> > > > > >  hosted elsewhere)
> > > >
> > > > No answer?
> > >
> > > subtrees is what was decided on OF_UPSRTEAM as well. If you have a
> > > better idea feel free to propose it, but for the sake of conformance
> > > we are better off doing the same thing on every external tree we pull
> > > in
> >
> > How do they will (or already do) maintain this?
> >
>
> There's a script to do that in dts/update-dts-subtree.sh
>
> > At least it's a good to have a few words on the choice made in the cover
> > letter, so we will have no questions on it.
> >
> > > > > > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > > > > > we need to convert the CRLF endings to LF and do a commit
> manually:
> > > > > > >
> > > > > > > $ git add --renormalize .
> > > > > > > $ git commit
> >
> > ...
> >
> > > > > > >  lib/mbedtls/mbedtls_def_config.h | 4262
> ++++++++++++++++++++++++++++++
> > > > > >
> > > > > > This is ridiculously HUGE! This is unreviewable. Moreover, this
> is even
> > > > > > hard to
> > > > > > configure by the user! Can you rather make it modular and maybe
> create a
> > > > > > separate documentation for the most important options (I do not
> believe one
> > > > > > needs _all_ of them to be set / tuned)?
> > > > > >
> > > > > > This is a file from MbedTLS and follows its own style.
> > > > > And this is how MbedTLS is configured - with all features listed
> in a
> > > > > config file and
> > > > > commenting out the unused features with "//").
> > > > > The modification here is just to control those existing options
> with
> > > > > Kconfigs.
> > > >
> > > > And why should we blindly follow this nonsense?
> > >
> > > It's easier to follow up future changes tbh. But I do agree the config
> > > file is huge. Perhaps splitting in 2 files is going to be easier
> > > mbedtls_def_config.h -> contains all the options that rarely need
> > > tuning, which I assume is the majority of the header
> > > mbedtls_usef_config.h -> contains the imporant options, crypto,
> > > checksum algorithms etc
> > >
> > > Thoughts?
> >
> > The problem is on who decides which are "rarely need".
>
> Us. Sure it's going to take some time, but eventually we should be
> able to isolate options that rarely need a change
>
> > The feasible (to me) approach is to split per domain. Like you listed at
> the very end of your reply.
> > We can also learn from managing MTA configurations, such as Exim4 where
> user
> > may decide if they want a single file or split version.
>
> I am not sure tbh. Let me backpaddle from my previous suggestion :).
> Looking at it closer config.h is copied from mbedTLS, commenting out
> features we don't want.
>
> What we could do instead is either trim those comments out and only
> define the options we need for now. That would make the patch easily
> reviewable. If in the future we decide we need a more modular
> approach, we can retrofit it without breaking anything.
>
> Alternatively, we can undef the options we don't want in our header,
> but I am not sure how often these change or how scalable this is going
> to end up being. I prefer option #1
>
> I can remove the disabled features and only keep the ones that should be
controlled by the Kconfigs if you don't want a huge list for user's
fine-tune.
Currently most of them can be regarded as default setting by U-Boot.
In the future if any of them needs to be exposed as a Kconfig for tuning,
we can add them back.

Regards,
Raymond

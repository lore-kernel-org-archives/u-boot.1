Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA8BCD4939
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2136286D10;
	Thu, 21 Sep 2023 03:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lReS/LPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C5886D11; Thu, 21 Sep 2023 03:05:38 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 475E2863D9
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59e6ebdf949so5503057b3.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258335; x=1695863135; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGSKVK/mJ46w0VFq0QOUVqsLGnKm9343InHz/aSWRVo=;
 b=lReS/LPRx0j6ukDluvDBDUaF95ChP1phiGH5DgEhOssbC3h+dqc5LuT3zB3Ansd8qY
 k5P+NnbnMe030EggjC5dCLLNaMfTCpKxIKNHv93kreBA3apkxwVSlwobxs/zkbiLC9NW
 uZd4X2+C7hEnul67OP22B2gvJ5jKkZ66hry6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258335; x=1695863135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGSKVK/mJ46w0VFq0QOUVqsLGnKm9343InHz/aSWRVo=;
 b=maDBJ3FpVUlFijrouDlVD23R1TtTkkttJuAVEvmxnLJ52qKFYjv+8qqA20BV28/mX6
 Of9KMypUHbKmyKeVWq6GaNyChCHXQwuAVBJGoOsKhh1BTjE9Blz74UoRlz1SQXj1QZjK
 vz0YUmLvjHMEf+jxrh2iVor30lWUTuczxdh8ozAy/1jept5yBcORZ0bQsNJsZXHE2gnC
 eQpS/fSyKpPWAnQ9YJuhmxX8QIqgQ3BQSij6tox+Hw19aMux64nfMqAgGuSDDD6TTBcD
 vlN88ob5hnqkXmi9NpidGWNABQ09JlMGugZ9tElZj2QpazQZ2GkeDBLCVLSIYYaR0aeX
 rLxg==
X-Gm-Message-State: AOJu0YxQ9qdwAW5gJ5oYKb44fnx+Q/+zOmNtyFbwYYKFWE4V3gucWzqS
 5oqaVInQi26BcUH2ETpUEfWu1/vF0oVa6cWt7EX/S/qYYok/85fPGUQ=
X-Google-Smtp-Source: AGHT+IGMdz6e/hSeGws1f/e4SftAUf8E+urCUU/gIDZ0TYuJH6FcVpR81jDgeEEZFad1jWxpNkdyKyQ32Ecxx6MqkzM=
X-Received: by 2002:a0d:ea41:0:b0:59b:cfc1:8dfc with SMTP id
 t62-20020a0dea41000000b0059bcfc18dfcmr4023901ywe.0.1695258334797; Wed, 20 Sep
 2023 18:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230915002147.797352-1-sjg@chromium.org>
 <20230915194832.GF305624@bill-the-cat>
 <CAPnjgZ2Xo2+wNkH+hrKL_FetmD7vpB8dHi7mtSRNPMWHkqQLcw@mail.gmail.com>
 <20230915215449.GG305624@bill-the-cat>
In-Reply-To: <20230915215449.GG305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:25 -0600
Message-ID: <CAPnjgZ1KWxNiZ7=dnQry=Shw-Q=791Bo44RLvf2DTaekdu6ebQ@mail.gmail.com>
Subject: Re: [PATCH] common: Drop linux/printk.h from common header
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 15 Sept 2023 at 15:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 15, 2023 at 02:01:33PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 15 Sept 2023 at 13:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 06:21:46PM -0600, Simon Glass wrote:
> > >
> > > > This old patch was marked as deferred. Bring it back to life, to co=
ntinue
> > > > towards the removal of common.h
> > > >
> > > > Move this out of the common header and include it only where needed=
.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > [snip]
> > > >  317 files changed, 322 insertions(+), 3 deletions(-)
> > >
> > > So, going back to the original series here, how did you determine tha=
t
> > > the files changed here need <linux/printk.h> ? I can see how to get
> > > there with some grep'ing but I think my original complaint was that w=
e
> > > added the new header too widely.
> >
> > Basically I used ctags to get the symbols from the header file, then
> > grepped files for them. For that one, it is:
> >
> > KERN_ALERT,KERN_CONT,KERN_CRIT,KERN_DEBUG,KERN_EMERG,KERN_ERR,KERN_INFO=
,KERN_NOTICE,KERN_WARNING,__KERNEL_PRINTK__,__printk,no_printk,pr_alert,pr_=
cont,pr_crit,pr_debug,pr_debug,pr_devel,pr_devel,pr_emerg,pr_err,pr_fmt,pr_=
info,pr_notice,pr_warn,pr_warning,printk,printk_once
>
> OK, good.
>
> > I was a little miffed that a comment along these lines from Heinrich,
> > with no actual evidence, and no response to my follow-up questions,
> > caused the series to be dropped. It isn't easy to do these sorts of
> > clean-ups.
>
> Well, I know earlier on I had concerns and spotted specific cases where
> it was off.
>
> > A lot of files include things like net.h and image.h which bring in
> > many headers...but we should clean up those header files up too
> > (particularly image.h). So I think the standard should be: "include
> > what you use".
>
> Yes, we should first get rid of common.h and then see what we can
> remove next.

Are you OK with this patch? If so I could send another, but should
perhaps wait until this is in -next ?

Regards,
Simon

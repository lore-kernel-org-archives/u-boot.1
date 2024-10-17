Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F287FD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8164789157;
	Fri, 18 Oct 2024 01:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A/WRE6v0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D79891CC; Fri, 18 Oct 2024 01:18:18 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 693FF88FA4
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so9687556d6.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207095; x=1729811895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k9ozN0YofCT8qt5UW/J9xXrtmRflOSpaecwV6VAVadE=;
 b=A/WRE6v0TUtuX+mzF5L5VqajzDiaDDqI/PNEOo7JQa7ln5b3RzbsIrn51GS37oOnxp
 AVxtEp3iG2cIDPAHqgWzHQ0Rycc5HJJKIyRtLTwib9SjseWUFfzbExzLZ4p+HX8v7Ujv
 0/8plTZqXxWR2ijV02HkyxwU3MTkr8NLP98kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207095; x=1729811895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9ozN0YofCT8qt5UW/J9xXrtmRflOSpaecwV6VAVadE=;
 b=vouX5XFPDj0ZgGKEaynrk1uOnOzIspPJXADt2LWJPhmYqjv9gcslZgE+jqIrv5AONC
 SN5sg5Er6rinPM6b3JQBNVOaP1Zj19l/JTvnOV+j2n6lYVfe6fq1GEe7fG8RfjQ5m6LI
 U8BvmSxGYjaG2NjvV5qwvMhTujji2hmb4KEsWqSDujdZKJQm6i8mgGYmXpVjkFH3D4l4
 +6D7C+f+B+g7nTL82rrZy5J/I+faLyXebPL6qXdeNpTa3GUewmBMYogkTumHJqdkBKPl
 hGHOGY+Ux+OiOtmYSq21ARkN0VDuL4cA2JQnmoN+7ggE2N5s7Kv0MHNM/F7vv9bs9QKt
 Bp/Q==
X-Gm-Message-State: AOJu0YyW0OM/qfku9ltOeR2G5hnnVUMAvSEtzMYkCTXewJJ/R69zXCxO
 wrd493r0ETCm0aNQTuqZsHvloozbjZeB/owvk3uWOU7gdyeA7lB2lwI0EdU1WCW+D+qtqrrEP+n
 V+LB0Q+I7CFA2YxmJjyWd2eSO59MYCLrc7YPq
X-Google-Smtp-Source: AGHT+IHfSl/5D76xjSxRp3qwt5nyyzeYUaPV3wa+H8er+X/1fnzCG9eIwspmWEz1InthmsuaISDWbPxs5QQKpDCfNF8=
X-Received: by 2002:a05:6214:2b83:b0:6cb:e952:8096 with SMTP id
 6a1803df08f44-6cde160bcd0mr4635646d6.50.1729207095331; Thu, 17 Oct 2024
 16:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20241015133304.2874735-1-sjg@chromium.org>
 <20241015133304.2874735-3-sjg@chromium.org>
 <CAC_iWjL5+LN4ReAo7LNhRrC1==V8ciCd4M73kUXktV7ufQEhng@mail.gmail.com>
 <CAFLszTibyH0jEbZ-G6VifrcmpXmxNq00TnZM3cEAxWpQGQpBZQ@mail.gmail.com>
 <CAC_iWjJBq58rY=3Pv90dy7RFGVu2-Z4EwbLsfvy+sAA6ibK=yw@mail.gmail.com>
In-Reply-To: <CAC_iWjJBq58rY=3Pv90dy7RFGVu2-Z4EwbLsfvy+sAA6ibK=yw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:18:04 -0600
Message-ID: <CAFLszTikQvs9yWjuVSzLmRnye1k8LQmiNxYJpGvLkwYPuPRLPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] common: Tidy up how malloc() is inited
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Artur Rojek <artur@conclusive.pl>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Ilias,

On Tue, 15 Oct 2024 at 13:24, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Simon,
>
> On Tue, 15 Oct 2024 at 18:28, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Tue, 15 Oct 2024 at 07:38, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > I did review enough of this series in v1 [0]. Please resend it with
> > > the proper tags added. Did anything change and you dropped by r-b?
> > > Because the changelog says no changes
> >
> > I collect tags with patman...it still doesn't see anything. Which
> > patch are you referring to?
>
> It's in my response

Oh I see, I missed it from the v1 series. Well, this is on hold for
now as Tom has asked for lmb in the memory-map listing. But I've
collected your tags.

Regards,
Simon

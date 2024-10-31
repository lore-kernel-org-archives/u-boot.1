Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE11D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC36088B8F;
	Thu, 31 Oct 2024 19:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O5/ooTcc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C51FC892DA; Thu, 31 Oct 2024 19:00:59 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C8E88B55
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso1747447a91.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397656; x=1731002456; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rbsb7IrKyLzm7ENBV6ALWXJZg6lnuxjUZpZtemQGmY4=;
 b=O5/ooTccZcdl+SUqeNQe8QXZysy7VqhGxPLzO0hIghYOReA85zFxfik09jcmk2Laas
 v3mXoXJLDR438rVyQCWe4mATTgiiIWwR7HgKV+DPLOmIrinLc25MXh7LXuuw3+dawg5a
 W2+gL2N2Sp5eNJ6taObpDA4uGSQe14h8+Yohk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397656; x=1731002456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rbsb7IrKyLzm7ENBV6ALWXJZg6lnuxjUZpZtemQGmY4=;
 b=qo3JgYhQhnzHsPnHg6Fp2mfXRbCVPBIYXzlfkFIM/XdNgNCNSaMxsJQQ4JedcPVnR7
 7drYk5+B/FMtCaMjemiBqn2cyrNBmwnh2pyRji+jPV2ivcOh2nEpWBN5MFIuFPlFaTe2
 1Ls3TsDIbXPlYj6kEry1jDXXtS3yXA2/lNmU9HFB2CSfPbulj3vM7FIiyRZOaKwLvnSz
 Qy2nY7lCm0wLSFivL1w2Vr6nhOcxuQMzEowUq0a8S0YaAdZ+noT3WiCIAI7/u8LJjkJ9
 5HwzlwNnbn9ULPpRUjsqAu6NSusTfttpo8B4tUDvs89T3VMO7JE+RHs+Knt7lSYpYyYz
 1o0Q==
X-Gm-Message-State: AOJu0YzjwzXsFw/Z/xZR53G7epOAnN5boyRPdeihvbF8ZSNfl7z9W/Eq
 A8Kk7/1BOGXC4o3BzJEjG27FHJFJaLj1CeY2GkLCwNZBguqyqFR/TemExEqaNGRV+VXEpf2rT5y
 N7My9I63gFNpdYpp73h3cT7cXg0ShIa8ZIpIE
X-Google-Smtp-Source: AGHT+IEYvwc661TQRL1kRtBgY4weIk3ldPEnw0gs8/xTOsMUyIb38Xu14ZuF3UWPqpfzXXB67WrNGKDW5TCc1d6+reA=
X-Received: by 2002:a17:90b:388d:b0:2c9:6abd:ca64 with SMTP id
 98e67ed59e1d1-2e93e0abfb7mr4888746a91.9.1730397656059; Thu, 31 Oct 2024
 11:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
 <20241028193310.GS4959@bill-the-cat>
 <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
 <20241029163642.GA4959@bill-the-cat>
In-Reply-To: <20241029163642.GA4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:00:41 +0100
Message-ID: <CAFLszTiXXXNFUeGoe+0ivyWgh-9MDYdCETFoWDcskYwHd-c9bA@mail.gmail.com>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>
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

On Tue, 29 Oct 2024 at 17:36, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 29, 2024 at 04:45:40PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 28 Oct 2024 at 20:33, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:
> > >
> > > > There is no particular need for bloblist to have its own test suite.
> > > > Move it into the common suite instead.
> > > >
> > > > Add the missing help for 'common' and update the docs.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > This feels both like churn and weird. I would think "common" tests are
> > > for things that are kinda legacy and too catch-all to have their own
> > > subgroup.
> >
> > It's just chosen so that the test for common/ is in test/common - i.e.
> > it makes it easier for people to find it.
>
> Then I really don't understand renaming bloblist from something
> descriptive to common which is not.

Old: test/bloblist.c
New: test/common/bloblist.c

It is only the directory that is changing.

>
> > BTW this series removes all tests from test/*.c and moves them into
> > appropriate subdirs. Some of the tests are quite old so have just sat
> > there all these years.
>
> This is good, yes. But perhaps needs a bit more thought then about how
> strong a mapping between filename/directory structure and test suite
> name there needs to be.

OK so what do you suggest instead? This series was the result of my
thought about this :-)

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1F0C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAFE2800B3;
	Wed, 19 Feb 2025 01:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+VjTseX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9B380F18; Wed, 19 Feb 2025 01:04:27 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA86F80077
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so58081066b.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739923463; x=1740528263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lNMT+t/1z2YO11fE1SNGDKNPd2VVaDB5oW8EeVnNDnA=;
 b=T+VjTseXsMd02egsxSGOn6TMvpuHM2JA2Q0KcQduNiYLlyEyVyo1j4sXPPe7yukv8P
 vdvgZbMGQEv0FYw3JQFZC1UYJa56QamXtEKC9+C2JgB/mIkvk6xxypZe5Z66/IWQWwAE
 mmCUdOWHGj2f99LtA1Az+7th1XWuXxwXVUAcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739923463; x=1740528263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNMT+t/1z2YO11fE1SNGDKNPd2VVaDB5oW8EeVnNDnA=;
 b=ezv9RAILyNtbhH8LwDMKaxBQ7Ike3i3hJOemBEFNYU/ukqvgj+1tzZ5VZgtZ+7FECm
 0FXJ0rmmkZah9X1cpFwDaVWU2GLwk9Z/fyc9wnFj3M69q8op5/k7LQ4BrRC1Hp+MAmUM
 t/QxMV0Up17qq6rZx1RsqxxnYFidl/o38l+J4Rx3pTu1WCAU1pGMwVkDRDp/mt0G+RMY
 xKM2OwgrheP7TKB52ODltH+Hz89MQlGrbYlSICmIsF4+89J6uffsyVRPU4mvuQaE/3Xo
 OsYqXPCEDNSVxXUHye6R1JZD6uQut4NbAHA9HLyX/CbnpAhyQc2cefok39zeLbXlpNFG
 YKrg==
X-Gm-Message-State: AOJu0YwK8GAWs+9LYAtOLm6tlWWyexmHvK9TqEwaC1piQdjQT7ASdUGi
 SqlhVQcEGDi2kkMCP/cZhlfDPX03KlGDjXUPTklPFKK5RGRxUjXKwG9jr/91tQ7H//x9WAx0GFF
 dvBGXFChOxplIMQM2LDRlpJCSbFBilhdvvWbq
X-Gm-Gg: ASbGnct/G1nhc+wIWpi1f6uHIFsjoXHXhgJxCC5bxDZU39LRoexhaZOKfhtpiaZrAS6
 89ZM45EExJr6fXnF4G22A2eheqN0vt0AlPOh8iGR/gVOkMlRBq/UD0miSGigK0C911pf9HYdoJg
 ==
X-Google-Smtp-Source: AGHT+IF2S6xHyLfxdgFbcq/lKC5+jm7bR2jASjXjsS3OjaSx3DxMRok0kM7lwV8+/s1gEn5kXQ6z546BYJ01lDwAeHU=
X-Received: by 2002:a17:906:311b:b0:aba:e1eb:1a90 with SMTP id
 a640c23a62f3a-abbcc36e46cmr175321066b.0.1739923463095; Tue, 18 Feb 2025
 16:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
 <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
 <20250218151224.GE1233568@bill-the-cat>
In-Reply-To: <20250218151224.GE1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 17:04:09 -0700
X-Gm-Features: AWEUYZnkJlYtsARDTkBjBCUmpqPQL8iZv6TKHtxzI5DSwrGKWJPF17e5lKWemkA
Message-ID: <CAFLszTi132O0-yODOVOZ0_8HOKwA1JPn=xZBMovLma42GM+eng@mail.gmail.com>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

On Tue, 18 Feb 2025 at 08:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:09:06AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
> > >
> > > > Some test can only be run by a particular board in a lab, e.g. because
> > > > they are loaded with an OS image used by the test. Add a way to specify
> > > > this in tests.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Add new patch to allow tests to be filtered by role
> > > >
> > > >  test/py/conftest.py | 22 ++++++++++++++++++++++
> > > >  test/py/pytest.ini  |  1 +
> > > >  2 files changed, 23 insertions(+)
> > >
> > > This seems duplicative of the existing functionality we have, all
> > > hardware tests can only be run on platforms which configure what the
> > > test requires, in the boardenv file.
> >
> > I was afraid you would say that, and yes you are right, it is duplicative.
> >
> > With my lab I am trying to use Labgrid's configuration and not need
> > anything else. For example, the params on how to launch QEMU and where
> > to find the OS file are there, rather than in u-boot-test-hooks. It
> > allows me to run a session interactively just as easily (and with the
> > same flow) as I run the pytests and gitlab.
> >
> > In my lab, I actually don't have any Python things, apart from what I
> > added for that tftp test.
> >
> > I wonder if I could create a way to pass the env__ stuff in from Labgrid?
>
> Well, I was also afraid that was going to be part of your answer. A
> challenge I see with the way you're using labgrid is that details are
> kept there, instead. Is there some way to publish your configs so
> they're also available for reference? I indeed have been lax in doing so
> for the way I use it and so posted:
> https://patchwork.ozlabs.org/project/uboot/patch/20250217200638.356583-1-trini@konsulko.com/
> yesterday.

Yes, that's great. It is a big help to have all the lab stuff in one
place and not being able to get things into that repo was one reason I
gave up with my local lab that used the hook scripts. Just too many
local branches and hacks, and too hard.

Anyway, yes I'd like to get it in u-boot-test-hooks. I last pushesd it
to Labgrid 7 months ago [1]. I thought I did it at the end of November
but must have imagined it. Perhaps I could put the config files, etc.
into u-boot-test somewhere, like in a labgrid/sjg directory? Could you
give me access to that repo?

>
> But then also yes, I think you need to figure out how to have boardenv
> files so that you can have pytest tests that read from the config that
> they expect.

I can have pytest read the config from Labgrid, like it does today.
Needs some thought though.

Regards,
Simon

[1] https://github.com/labgrid-project/labgrid/pull/1411

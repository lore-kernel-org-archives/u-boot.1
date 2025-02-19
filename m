Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130AEC021AD
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48DD2800D7;
	Wed, 19 Feb 2025 01:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gcUVLB6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F6180646; Wed, 19 Feb 2025 01:40:10 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662BB800B3
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aba868c6e88so749908766b.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739925605; x=1740530405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJhnRsoDUEOI+Xd6oEJIKO5nNwr+81zDhK9AIZtVtDQ=;
 b=gcUVLB6MXIRiy9WKtkDaBsp0SRIGAgl8oC8uxYr5Zqh/P7PePDBrT/zsaehkuYavQo
 +LS5/VhaFPjS4oyNoO90pBQ/omTvaobGGv2/GSGrv2gOl3oNXPgxESyGYKBuj1w3qAMV
 qwB3bPRsgVGLK8/FhckpeCe2ys0zBrtQIRGnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739925605; x=1740530405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LJhnRsoDUEOI+Xd6oEJIKO5nNwr+81zDhK9AIZtVtDQ=;
 b=YmCnDbMzFyE9mNRaUAFulTTA0FLrf+UEIzo1i1Gl6wOCpsABOTkp4+szJYpaAndi2z
 WEx5s6SsQjHs9k0mdDoZb6z9JGa6BtKDI2yJ6LRoqeKSDAeNlZrNkEUZdSuBvytXxJ/y
 A8XAo5LSbaBUULMF8VlavVrOZR0N5W9kDfkaFnp349R+QpYnsawp8YsvB7xT3Q4wx4QH
 ZPavIWPIG6SWfOIf9nU3gE5lII+306OVUB7nqJ9PV9oVu/7CBEOTEh25qlz0cTeiaLtV
 1zzEMfEmrUMevFJREqvR1nawxBTWeYhc2VOsiXtJTEcNSaEOMf1isZyD7q8LlUIdczKA
 utwQ==
X-Gm-Message-State: AOJu0Yx+lS7a/68ghb5P6uNmfGvanu365/k+lmaaxmkD1Gk/K37bHzFd
 dMd1rt8tZfgIPco1eYb4NnZGpfzdmcH/ZoxOq8OJfpCyHpk9g+VPBBiraSB3yYr+8tAZkNldGDT
 4Tr4RT18puvfF7Dh8JTm5xM1tZ57nz+ibDgwj
X-Gm-Gg: ASbGnctCoxY58xacnOy/1ZA1vX3Z5bqB4kimbR606ZtrYXLL8TbdY+KidYeA6gzQdzV
 axrYObvTkBI/EvtRhf04QGtUlQm9O2O/G66Dp+lSIiSdtw00k3NFJ8TImr48VDTYEXpY2arJ0Pg
 ==
X-Google-Smtp-Source: AGHT+IEFzrrax3JuuQLnrI39TTWCO+2rDx5EeSeUrWi6rLW2R0jW8TayGVCZwLu1oK6ZMX/oaJyMBzbHJiPxT44MqEY=
X-Received: by 2002:a17:906:dc8e:b0:ab7:aaf2:f7f9 with SMTP id
 a640c23a62f3a-abb70de28d4mr1740573666b.42.1739925605474; Tue, 18 Feb 2025
 16:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
 <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
 <20250218151224.GE1233568@bill-the-cat>
 <CAFLszTi132O0-yODOVOZ0_8HOKwA1JPn=xZBMovLma42GM+eng@mail.gmail.com>
 <20250219002526.GP1233568@bill-the-cat>
In-Reply-To: <20250219002526.GP1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 17:39:53 -0700
X-Gm-Features: AWEUYZnjve0I98xTzvRHDKW3FL5defr1u_Emirsm7d6WzxeeIDUKNMHefRs2MTA
Message-ID: <CAFLszThBbe0K5mz3YmkpsWUCFYXys_hp6ERyHpVqPLETntwKaw@mail.gmail.com>
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

On Tue, 18 Feb 2025 at 17:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:04:09PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Feb 2025 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 05:09:06AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
> > > > >
> > > > > > Some test can only be run by a particular board in a lab, e.g. because
> > > > > > they are loaded with an OS image used by the test. Add a way to specify
> > > > > > this in tests.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Add new patch to allow tests to be filtered by role
> > > > > >
> > > > > >  test/py/conftest.py | 22 ++++++++++++++++++++++
> > > > > >  test/py/pytest.ini  |  1 +
> > > > > >  2 files changed, 23 insertions(+)
> > > > >
> > > > > This seems duplicative of the existing functionality we have, all
> > > > > hardware tests can only be run on platforms which configure what the
> > > > > test requires, in the boardenv file.
> > > >
> > > > I was afraid you would say that, and yes you are right, it is duplicative.
> > > >
> > > > With my lab I am trying to use Labgrid's configuration and not need
> > > > anything else. For example, the params on how to launch QEMU and where
> > > > to find the OS file are there, rather than in u-boot-test-hooks. It
> > > > allows me to run a session interactively just as easily (and with the
> > > > same flow) as I run the pytests and gitlab.
> > > >
> > > > In my lab, I actually don't have any Python things, apart from what I
> > > > added for that tftp test.
> > > >
> > > > I wonder if I could create a way to pass the env__ stuff in from Labgrid?
> > >
> > > Well, I was also afraid that was going to be part of your answer. A
> > > challenge I see with the way you're using labgrid is that details are
> > > kept there, instead. Is there some way to publish your configs so
> > > they're also available for reference? I indeed have been lax in doing so
> > > for the way I use it and so posted:
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250217200638.356583-1-trini@konsulko.com/
> > > yesterday.
> >
> > Yes, that's great. It is a big help to have all the lab stuff in one
> > place and not being able to get things into that repo was one reason I
> > gave up with my local lab that used the hook scripts. Just too many
> > local branches and hacks, and too hard.
> >
> > Anyway, yes I'd like to get it in u-boot-test-hooks. I last pushesd it
> > to Labgrid 7 months ago [1]. I thought I did it at the end of November
> > but must have imagined it. Perhaps I could put the config files, etc.
> > into u-boot-test somewhere, like in a labgrid/sjg directory? Could you
> > give me access to that repo?
>
> I've updated the permissions and you should update the "bin/ellesmere"
> directory and add "py/ellesmere".

OK, thanks, will do. Where should the labgrid config go? It is three
files and perhaps a few systemd scripts. See [2]

Regards,
Simon

[2] https://github.com/labgrid-project/labgrid/pull/1411/commits/6d3b4a0cfc7e35e0547dcd14065328df4b4b5e1f

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15382C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 05:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FD582114;
	Sun,  4 May 2025 07:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ecSvdtlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7278211F; Sun,  4 May 2025 07:28:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A888210D
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 07:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D82B83F277
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 05:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746336476;
 bh=BcsqrVwKpwlBdXedqYiGY/IJF+92pogaCnSru1rhlY4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ecSvdtlbge/uP3MdLIclPtYE9EAdVNbphUAoC6ArcSIjYBH1va6Hb3Xbq39uXhQh3
 +LvKG2v9a2a37TVRIs3zSLb3PnSAeYiq+Ab6lLRjrwqRXe9O5mskgpyYWuUOQZEOus
 6v0vx7wHVwdog0UQP9GL/NiFwtRaaM0hrysludKtLTvEiOZPXTAo3L8D0RQe3aD+XD
 BXAweIHbAydGCvj/VDlSyzf/dY5UqjgzY7sV6eyNBBO4OQy81NpGgzA9MiPTMvkJzS
 BLHtR+hxEj9xcZCwHgihnXUh3BbfJ/s9GtO4oIMdG+eh+CxetJpajNobJEEZvddXJ4
 PcQYMlXtnts3w==
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2240a960f9cso33879655ad.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 22:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336475; x=1746941275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BcsqrVwKpwlBdXedqYiGY/IJF+92pogaCnSru1rhlY4=;
 b=qmEvPrptRS2TYGECWJnm2Zl5R+DpRX5IMGiZNCa+hcAR3c6pufwzhQDA94mVeKW1HN
 x5yW1xLlOc3w9PDrXfS78e0LE6JIkNcKqJWvwhXsR9c0BmSJ508W24K2T8Q+DQkC7HI0
 jdqArGsaxW/ReMKNiqS2Z4diJv7zf0Pfdkt/wqGBL4Cyz7csub8PVhiKpk7DALUj3ypn
 8cxRmK/pVyV8/XmHbv+jDkDNnXyK6KYzI3meV86VMOwIjyribDizrt0aWg62DESI8ADx
 HxgBX4Pl5oe2JmB94+/phfAuzEUprutciRTMfb6YIuWYDgrVZ3Yfh5cy05OqH6uWKanx
 yL/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ1Zl47BNxRdPmu5gmARutWFXPqYc1DLQecwBjPZvx9gBhzCahsVj5gKgoXXMBpaS4Jydt6Tw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy02JC7OZkNd9BHy3kN6tmUBtdegHGxRVL4xNdsPPhs2v5BTlwA
 ya0QN0KPBZ8pQMOdQjkXoS1BpBdtRZzhIdZwQqQ2VOBRDZVrUTYFESsE2Dpzf/Yj/gS20PTWg7f
 /XhuddKV9zwb6e0TUiyXHX8bhyRlmT9hNe+6pgvc2TYR+rMoSpglMRNrpTU4T8wYXOOeY1Ft3cR
 Yw56qJ3s63HN33SCxZvrIoN+zAkX1uE+VXAvWktnmnkQ==
X-Gm-Gg: ASbGnctTrdE9mLo7O65v1UCy5yKqLePCT1PTjQit58y5Lu2x9b40xmU8W/3ulAtdBMW
 kLRz1l/IKuO8e3MscbXaq9ExvvzhenXB3bbby8GMfa958dhKG7x4i8Yn4hv2Fa0VPOuDLDXZxf4
 oSyImh0MuskRXOa6u59kQqvbD9
X-Received: by 2002:a17:902:ce8d:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-22e1eb25039mr43274235ad.45.1746336475102; 
 Sat, 03 May 2025 22:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv7mHtmX2hUGsOmQr7ZycUilpjooVuyGZ7aTfZh6+1bOPMausMr9xCEy29Z5OYOngJNpp8cGAR2zkIRNlXCLY=
X-Received: by 2002:a17:902:ce8d:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-22e1eb25039mr43274095ad.45.1746336474783; Sat, 03 May 2025
 22:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
 <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
 <CAFLszThvh+fzrDoODdj7kYqVKXkL6xvAFcz8biOh3c-LaD2CFw@mail.gmail.com>
In-Reply-To: <CAFLszThvh+fzrDoODdj7kYqVKXkL6xvAFcz8biOh3c-LaD2CFw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sun, 4 May 2025 07:27:43 +0200
X-Gm-Features: ATxdqUE6XH1LxJGisM1CHyv8IVaDYcu4gNXVs9dvErWzVJ3hQOpwXB8QIIWxfsU
Message-ID: <CAM=mAOkNo=kuNNo9fDEfUNOXSE5cQc3zhx54BAWNy--tt1u3Lw@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: allow multiple config options in buildconfigspec
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 3. Mai 2025, 23:27:

> Hi Heinrich,
>
> On Sat, 3 May 2025 at 07:32, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > In some cases we have alternative configuration options that supply the
> > same functionality, e.g CONFIG_NET and CONFIG_NET_LWIP.
> >
> > Allow to specify all of them as arguments for buildconfigspec() and
> execute
> > the text if any of these is fulfilled, e.g.
> >
> >     @pytest.mark.buildconfigspec('net', 'net_lwip')
> >
> > Update the documentation.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  doc/develop/py_testing.rst | 24 ++++++++++++++++++++++++
> >  test/py/conftest.py        | 10 +++++++---
> >  2 files changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
> > index 217ae447035..7dbed8833bf 100644
> > --- a/doc/develop/py_testing.rst
> > +++ b/doc/develop/py_testing.rst
> > @@ -514,3 +514,27 @@ of the `ubman.config` object, for example
> >  Build configuration values (from `.config`) may be accessed via the
> dictionary
> >  `ubman.config.buildconfig`, with keys equal to the Kconfig variable
> >  names.
> > +
> > +A required configuration setting can be defined via a buildconfigspec()
> > +annotation. The name of the configuration option is specified in lower
> case. The
> > +following annotation for a test requires CONFIG_EFI_LOADER=y:
> > +
> > +.. code-block:: python
> > +
> > +    @pytest.mark.buildconfigspec('efi_loader')
> > +
> > +Sometimes multiple configuration option supply the same functionality.
> If
> > +multiple arguments are passed to buildconfigspec(), only one of the
> > +configuration options needs to be set. The following annotation
> requires that
> > +either of CONFIG_NET or CONFIG_NET_LWIP is set:
> > +
> > +.. code-block:: python
> > +
> > +    @pytest.mark.buildconfigspec('net', 'net lwip')
> > +
> > +The notbuildconfigspec() annotation can be used to require a
> configuration
> > +option not to be set. The following annotation requires CONFIG_RISCV=n:
> > +
> > +.. code-block:: python
> > +
> > +    @pytest.mark.notbuildconfigspec('riscv')
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index 5aea85647af..6c3ac67979a 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -711,9 +711,13 @@ def setup_buildconfigspec(item):
> >      """
> >
> >      for options in item.iter_markers('buildconfigspec'):
> > -        option = options.args[0]
> > -        if not ubconfig.buildconfig.get('config_' + option.lower(),
> None):
> > -            pytest.skip('.config feature "%s" not enabled' %
> option.lower())
> > +        nomatch = True
> > +        for arg in options.args:
> > +            if ubconfig.buildconfig.get('config_' + arg.lower(), None):
> > +                nomatch = False
> > +        if nomatch:
> > +            argsString = ', '.join(options.args)
> > +            pytest.skip(f'.config features "{argsString}" not enabled')
> >      for options in item.iter_markers('notbuildconfigspec'):
> >          option = options.args[0]
> >          if ubconfig.buildconfig.get('config_' + option.lower(), None):
> > --
> > 2.48.1
> >
>
> I ran into this problem too. Would it be possible to have CONFIG_NET
> mean that we have networking (either option) and CONFIG_LWIP mean that
> it is lwip? The current Kconfig seems a bit broken to me....
>
> Regards,
> Simon
>

Hello Simon,

Yes, we can think about reworking the network configuration in a future
series.

E.g. have as choice

* CONFIG_NET_LEGACY
* CONFIG_NET_LWIP
* CONFIG_NET_NONE

and CONFIG_NET := !CONFIG_NONE

But I think it is still valuable in its own right to be able to express a
logical OR when defining test dependencies.

Best regards

Heinrich

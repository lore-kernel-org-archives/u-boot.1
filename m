Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EF9CEE350
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73B988D8F;
	Wed,  9 Oct 2024 23:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PlQ0ZG+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD3588DCF; Wed,  9 Oct 2024 23:14:12 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0AE88C98
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e290554afb4so224407276.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508448; x=1729113248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B1ZzFY8ew3PgEyyA7L8n1a58td38iOPZJavZPfRIK2o=;
 b=PlQ0ZG+oedSPbxxmAN6HNa2BZLHNMbpKu4PCIGwWsqn/5l9NnJWhJHIdk60jdiJOpS
 07nyQY7d+mkvWs1bbodhjTz6/sZw0rCViRuDOxc3DYRe4gil57Eom1/nEOA8Cp5JjQy2
 Qw5pKMFU/4YWlOpEFwQ4m0ZVauWgYHHMRJk90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508448; x=1729113248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B1ZzFY8ew3PgEyyA7L8n1a58td38iOPZJavZPfRIK2o=;
 b=Xx8ipDMaACI/+HYjepbtVmQzPATm5aWGAZfm8zqwRlGvfeulSJtg3IbUGu7cM6RlmH
 PtML8QMphvBMBd4XcYQsRJ9TwtAcdfdY3hOK5RP0x5FXSmJKJ5iInNHY1Xi3Bs2p/s7v
 3xvwI1AWF3jGR4BTc0/ifcJwv13pKmfGmYSNxEfaeBRcViVMZ9D3HvAisSs6H4COenNF
 J+z0Ldqm8xU6ZqI2xBy15VJyfO+9h77isyOQ/UMMk+Jw9X072jLig44aw4lXq4wE213o
 FutsCjQmshGvu4zJDUMojUy+f0rLs700CRIeb4QzUg86FKJJHUhSHvEfiL3DRLZUMGZb
 vfhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYD5Q3/R6BcoZf70uKPIiU3LBXNv/auV7GhOuqzxBdz860/17W3JQvOuUJpYXpl46585TUP+g=@lists.denx.de
X-Gm-Message-State: AOJu0YyPHOLXRkVNwHjcmDAtV8At4OvCQ7iFmA8KZXrgMKdHe+5W/Iff
 BmJiKtTnpLyj3nc/vsVOMfgsj62GSNKSkS4j7kCA0wEF7SV/+jABHx+DeNw5ODo4Q/GBDSjcJba
 wpZiIwyF8mrDGf32FBBIHmp0/vDG47f3qQy9N
X-Google-Smtp-Source: AGHT+IGMmgFMOhIRUZWbRUVbY8B2v8wdTyV6Y3CTd9wc4tIg5PMLFEwTYB+eogyHnkvX7GhhXaqpNO/01ajFFW+4VR8=
X-Received: by 2002:a05:6902:c06:b0:e22:5c14:4c4 with SMTP id
 3f1490d57ef6-e28fe4f1395mr3223189276.56.1728508448391; Wed, 09 Oct 2024
 14:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241008-android_ab_master-v3-0-f292c45a33e4@salutedevices.com>
 <20241008-android_ab_master-v3-4-f292c45a33e4@salutedevices.com>
 <CAFLszTh7qjUN__MvAbcMPL+W4V=mfBrgt9zcg8zyfx+WBN=9bg@mail.gmail.com>
 <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
In-Reply-To: <20241009132614.mlkpfkdni4cp2tgg@CAB-WSD-L081021>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:13:57 -0600
Message-ID: <CAFLszTgr-qHXF2QU7toZXOU0FgRMPU0XXnQ6SzMq32a_pguAww@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] cmd: bcb: introduce 'ab_dump' command to print BCB
 block content
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>, 
 "Andrew F. Davis" <afd@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, rockosov@gmail.com, 
 kernel@salutedevices.com
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

Hi Dmitry,

On Wed, 9 Oct 2024 at 07:26, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
>
> Hello Simon,
>
> On Tue, Oct 08, 2024 at 07:57:15PM -0600, Simon Glass wrote:
> > On Tue, 8 Oct 2024 at 14:18, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> > >
> > > It's really helpful to have the ability to dump BCB block for debugging
> > > A/B logic on the board supported this partition schema.
> > >
> > > Command 'bcb ab_dump' prints all fields of bootloader_control struct
> > > including slot_metadata for all presented slots.
> > >
> > > Output example:
> > > =====
> > > > board# bcb ab_dump ubi 0#misc
> > > > Read 512 bytes from volume misc to 000000000bf07580
> > > > Read 512 bytes from volume misc to 000000000bf42f40
> > > > Bootloader Control:       [misc]
> > > > Active Slot:              _a
> > > > Magic Number:             0x42414342
> > > > Version:                  1
> > > > Number of Slots:          2
> > > > Recovery Tries Remaining: 0
> > > > CRC:                      0x2c8b50bc (Valid)
> > > >
> > > > Slot[0] Metadata:
> > > >       - Priority:         15
> > > >       - Tries Remaining:  0
> > > >       - Successful Boot:  1
> > > >       - Verity Corrupted: 0
> > > >
> > > > Slot[1] Metadata:
> > > >       - Priority:         14
> > > >       - Tries Remaining:  7
> > > >       - Successful Boot:  0
> > > >       - Verity Corrupted: 0
> > > ====
> > >
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > > ---
> > >  boot/android_ab.c    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  cmd/bcb.c            | 35 +++++++++++++++++++++++++++
> > >  include/android_ab.h | 10 ++++++++
> > >  3 files changed, 113 insertions(+)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Can you also update the test?
>
> I apologize, but I didn't quite understand your point. Could you please
> clarify? This patch series includes additional tests for the 'ab_dump'
> subcommand. For more details, please refer to:
>
> https://lore.kernel.org/all/20241008-android_ab_master-v3-6-f292c45a33e4@salutedevices.com/

OK, thank you. Sometimes it is easier (for reviewers) if you update
the test in the same commit.

Regards,
Simon

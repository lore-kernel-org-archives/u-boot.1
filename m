Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CCCC27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 19:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83288884D;
	Wed, 12 Jun 2024 21:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GxctPk4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4445F88861; Wed, 12 Jun 2024 21:27:40 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA498860C
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 21:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52c94cf4c9bso294502e87.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1718220457; x=1718825257;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoBIbRZ3aQZnKFtMWpu5wohldJECvHBlW8JQzGK+F/0=;
 b=GxctPk4BJx10V4A09dNn1s2lhjMp5y8Ph1FepaIJMMnNTcnVh5NpV30OuCdU/viZwd
 n1vzvTjdEKkVfX8/2oAWTZw/4ptvTmygtyqTgHqBz4AJpf0iM4TnKAJ/bSSTYlVjdNxt
 83QzzI4iMzPhafN3nF9IchKBoLuOBPFOIvk0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718220457; x=1718825257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OoBIbRZ3aQZnKFtMWpu5wohldJECvHBlW8JQzGK+F/0=;
 b=Yimpt1MncjaddWj5H75ewg2f5fQXPbrOdyBEeO+Cg/Srssy+ZSMRMGk6wegLfXfeV2
 qYi0nm6qOS0rvTIz8Y0F56Ouu4wsjflw0eYf8eN0zm875yChYs8x9NHqMjHhBFQRf4lu
 6bnxJGMdvQFsYO0J9coZbi47kCWnyLPY13/lteBg3L/OTuzGMrkRjLIpadQa9ubhD6FV
 XS7ADoD7gz6YeD7+azinFBqUJBV5b2d4GQ1s+OD8nDFRUYqKzl/3y3pi+UHP8yn6E2Jn
 7kz1GZijgiP7hbfLC8E0Bk50BilowH3EBeqT1E2Ljs2KlZLgwjgAiAigcIdjN7G5Dy5A
 mnOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKnOlZYrNvLMXyIWZ2xQwXpdBVqsGFG8tjKZJNSnRMjwu1q4VWEHrb8v3RZNpH+ghUHazN3Io6obtHR0d0edVShZ5VIQ==
X-Gm-Message-State: AOJu0YyPh0K6hanwWSyNhn9ghJpVwgDMkGjIkdmlxPTaBYPTLqVbQ/Tw
 Q66vhQ9tDNak2RGHtQBKTJUZ2k3Bqq5v9qRtKHoDBY77yw9Z0aG88pu5MpvAHDP9kdLlzROG4+J
 ksp6yaZtRjWqLOA+q7Lun9pO2pf45aUofARsigQ==
X-Google-Smtp-Source: AGHT+IH5kwDZX3ds09OM6QtdPM98NwMuAvUH1rpbFAE46+YYjKADkgjUZ8IDs965djjWMiNY9+i+4D3NER84Buk83TE=
X-Received: by 2002:a05:6512:49c:b0:52b:c29e:7052 with SMTP id
 2adb3069b0e04-52c9a405567mr2031014e87.62.1718220456928; Wed, 12 Jun 2024
 12:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240603150749.507797-1-patrick.barsanti@amarulasolutions.com>
 <CAOf5uwkjz0qNkvsWzEQ+kPy66X9Eassq0b1PMDG2r7fYv94_OQ@mail.gmail.com>
 <20240612172527.GH68077@bill-the-cat>
In-Reply-To: <20240612172527.GH68077@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 12 Jun 2024 21:27:25 +0200
Message-ID: <CAOf5uw=quLMOhD5c2_ZbEkmV9KtHsfNW=HFfuJOLiwCfLtcS+A@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix include directory for OF_UPSTREAM
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 u-boot@lists.denx.de, 
 sjg@chromium.org, xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, 
 sumit.garg@linaro.org, afd@ti.com, bb@ti.com, mr.bossman075@gmail.com, 
 leon@georgemail.eu
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

HI

On Wed, Jun 12, 2024 at 7:25=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Jun 12, 2024 at 10:17:12AM +0200, Michael Nazzareno Trimarchi wro=
te:
> > Hi Tom
> >
> > On Mon, Jun 3, 2024 at 5:08=E2=80=AFPM Patrick Barsanti
> > <patrick.barsanti@amarulasolutions.com> wrote:
> > >
> > > Always prioritizing u-boot includes causes problems when trying to mi=
grate
> > > boards to OF_UPSTREAM that have different local devicetree files with
> > > respect to the upstream ones, if local DT headers are not dropped.
> > > At the same time if local and upstream files are the same, migrations
> > > can be, and have been, introduced without dropping local DT headers.
> > > This also causes problems whenever upstream DTS and DT headers are pa=
tched.
> > >
> > > For example, now migrating a board based on `imx6ul.dtsi` to OF_UPSTR=
EAM
> > > breaks it, as there are some missing defines in a local DT header fil=
e
> > > (`imx6ul-clock.h`); the solution would be to drop it, which has not a=
lways
> > > been done in previous OF_UPSTREAM migration patches for other boards
> > > because most of the time the two are the same. This solution is also
> > > vulnerable to ABI breakage, although this has not yet happened since =
the
> > > introduction of OF_UPSTREAM support and is unlikely.
> > >
> > > Maintainers assure backwards compatibility for DT headers when syncin=
g the
> > > upstream folder with the kernel.
> > > The problem is that, at the current state, all boards that have not d=
ropped
> > > their local headers when migrating to OF_UPSTREAM will break once the
> > > upstream devicetrees are patched, for example, to use any newly added
> > > define which is not present in the local DT header file, even if thos=
e
> > > changes are backwards compatible.
> > >
> > > This patch fixes these problems by prioritizing upstream includes whe=
n
> > > `CONFIG_OF_UPSTREAM=3Dy`, while keeping current prioritization when i=
t is
> > > not.
> >
> > Do you have some comments here? We would like to move upstream dts for
> > imx6 boards
> > too
>
> I've been waiting for the people that wanted the commit message
> clarified to Ack/Review the patch. Did I just miss that? Sorry.
>

Agreed, let's wait for more feedback

Michael

> --
> Tom

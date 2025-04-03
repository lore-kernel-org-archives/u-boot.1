Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C5DC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF9782140;
	Thu,  3 Apr 2025 19:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VC4kf1Hw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA36882149; Thu,  3 Apr 2025 19:57:43 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C9482139
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso193704866b.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743703061; x=1744307861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FCwiIE95kvRayJJJDblxPps4Vu4aGEEpWWoJSWbYy48=;
 b=VC4kf1HwrOB5wg4oPMjWq4yfSR/qb7KgdhiZxXk3dQzR3Z3vjzkUcZ5D+omGunplyF
 IpapJDd+/XQwDMY3rnC8+bx1mlAQ2i8hpQhGVX//GM3To8kdAMZvJgqD9S/E2MqRnmZn
 yoqbOVd8M1vq5aWYToyrreAiE5eONiwJ5S1DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703061; x=1744307861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FCwiIE95kvRayJJJDblxPps4Vu4aGEEpWWoJSWbYy48=;
 b=FDW1cDwsXDfW+0pxhM52HfHfO4AxByh0t/xlrOsJ+ldlqeIcNz0ZYtKYSscYTdVsrB
 WwN+11cfUBQv+uNHJ0sBU2LRRha9lAMsIwxNC9d7/liKhmW8dOSBM6VeffGm707sx+x4
 Z6+E+J26Fcl9cLIFo9r2AbukJj3XRV5zulv7sHiW2wGAi3nRpCU/3Cg+GtZeEoJcc8FP
 P8rGIuByaeSqxc+MHCGMy0spRrK8M1SSMBqNlcaSz/0N90wQhsiZ+Fig9v38KsWF8tJH
 +fIK9ncyqLSuCLQH+vHqR7zJjCMnAYG1zLC7AJ5nqApSqxlG7l42Qr/q3nLEQK65JUIE
 ZZ7A==
X-Gm-Message-State: AOJu0YyVd7xQkUsm8jQPnFeRultxEaqWMHRX3zANLaNt6rqPrsVyztuE
 tUqqIRlqyQ2C5hmiX5hYK4FW0FZI93t9X3J0C8pnpYjnL7iTGRX6bJELRRddKgX257jv9bdwjGX
 gbmyfj5py8JdaSxDEXo4J/G7MpZ+XHkw9N6V2
X-Gm-Gg: ASbGnctaZo6dpCzNDPn9q0rj3cRnQQd/82IfXFrbs35BuE2i8PBbQbQQh99jOFYV7NA
 n8+Pil/OsHOmSKSoLuz7xywSm31iBxYT1Lz43jTvoVhmObGr0b/JNB6NF1y/ji5urUMFxU6+Ud0
 BBZf1VJmRbIWIMdvxvIfNhlgLwpO6E
X-Google-Smtp-Source: AGHT+IF7RLKQrVMaF4uu4nbTwrOINmXJQW4UI4MBNh8h/k22LaFC6GMC0Y63I+1ktivhay0im3muYq8QzUid0vRJR5o=
X-Received: by 2002:a17:907:7fa6:b0:ac2:9683:ad25 with SMTP id
 a640c23a62f3a-ac7d17f0ea0mr46887066b.34.1743703060568; Thu, 03 Apr 2025
 10:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
In-Reply-To: <CAEfUkU+=bhM_Ba5Eu_FVA0-AoHO7TJBGyaO_w7o9rxTzB7SgGw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 06:57:26 +1300
X-Gm-Features: AQ5f1JrQ1Z4r1roVXKrmUoUqvzkq-r-YArYHffsz-Xa0q6ufDEiT6BvwOqC1raM
Message-ID: <CAFLszTjPzP-++P1vf7pFFwU5AHdfr2d3zs5QaQMf95uN4BbO7A@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Harrison Mutai <harrison.mutai@arm.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
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

Hi Raymond,

On Fri, 4 Apr 2025 at 03:09, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> >
> > The bloblist code took what I consider to be a wrong turn a year or so
> > ago. As discussed with Tom, this series proposes a way to arrange things
> > so that it is simpler to understand and manage.
> >
> > - Unwind some of the nesting in bloblist_init()
> > - Avoid needing to init the bloblist just to get the FDT
> > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> >
> We now have a kconfig BLOBLIST_PASSAGE_MANDATORY which means
> mandatorily use bloblist to hand over everything between boot stages
> including fdt, creating OF_BLOBLIST is not necessary.

Yes, I noticed that, but BLOBLIST_PASSAGE_MANDATORY indicates that
there must be a bloblist, not that it must contain a devicetree. So I
wasn't sure about removing it.

But actually, thinking about it just now, we can remove
BLOBLIST_PASSAGE_MANDATORY, since U-Boot won't make it that far if
there is no bloblist. It will die in fdtdec_setup(). Take a look and
see if you agree.

>
> > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > CI at some point. In the meantime, the standard passage series[1] could
> > be resurrected to give some coverage.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> >
> >
> > Simon Glass (4):
> >   bloblist: Simplify bloblist init
> >   fdt: Introduce OF_BLOBLIST
> >   bloblist: Provide access to the FDT address
> >   fdt: Obtain the FDT from bloblist without parsing it
> >
> >  arch/arm/lib/xferlist.c            |   6 +-
> >  common/bloblist.c                  | 102 ++++++++++++++++++-----------
> >  doc/develop/devicetree/control.rst |   3 +
> >  dts/Kconfig                        |   8 +++
> >  include/bloblist.h                 |  16 ++++-
> >  lib/fdtdec.c                       |  65 +++++++-----------
> >  6 files changed, 116 insertions(+), 84 deletions(-)
> >
> > --
> > 2.43.0
> >

Regards,
Simon

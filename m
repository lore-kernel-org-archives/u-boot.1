Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AEDC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 18:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C11888BF8;
	Fri, 16 Aug 2024 20:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fKs8h6s7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4080088BFD; Fri, 16 Aug 2024 20:49:36 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCDC288BDE
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 20:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7bb75419123so1796880a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723834163; x=1724438963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BpqQHXufZW1PDIe7KwsIYz8TvN6D/VaWfkmSdhaoQ6g=;
 b=fKs8h6s7oKrj7c4y0bEbLMKgXTffYIBE3SWLSYGdh94iEBiXgKVjVK9CsV0OW2FS38
 1ZN7iGV0yUj3ckMH+zgaZizJloAKGxqy9MjwIgOGDzv+9lVPx+npSZwQKuQGe2T/sw1z
 7MGNI0pAQO5JeJtYYMwKUWksI+AyUnUY7yRvHSMz9Qm6zH8AftTD6Ruw0hL8saHV4Yes
 8VBpSYxbP0H3HT6DsnDoVcyTLftSTnyp3VfirhAIAa9LkkkPkZlYqHXV5BGF998B24xD
 gTlCEJlYOkauxcxW0rZA5ei7V4fiCtG13LQJEjv2f2txMyy58nwh66ZF7mQmRAcRG6Gs
 Oo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723834163; x=1724438963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BpqQHXufZW1PDIe7KwsIYz8TvN6D/VaWfkmSdhaoQ6g=;
 b=jTYXEa/fcLmskqdKTauuQ/jEZ7lQ8neSAUH1AFfx64+9uMnRqCjq1Z03wKD8dUoOgH
 Sb8qTrQW+Fmn0jWx7IY9G1jeo4pAOrsToKbq2iGxjvnnm2CMDh8T1nM0TLmVwBV7rUeG
 tkOY+htKH7/38/AwQ7e/XR78yfUpF6Du2oXrK3hgdLY1255KA35HiO2HWxN8LNR7whVv
 Da81/qPMI/ROZbsMWlucn3g+LpRyY7KsgzMjQmfWOScvYxY8mkhGf2HPDi6Xk6rzIlI0
 +NhPEiQK+ZMQcayW3HEQzusWP//DpzlW9Rwhk9gjYrPeBQIWs7ZMDPaBzqHs3y9pL0t8
 6HYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNHSH4Y7w2F8ALRCRy0eRBFESLSISOHjQqmOPD7b/qma6KF4hplytkCXgqMta9V0D7zuktfHLoYPBO34WfJskoftxldA==
X-Gm-Message-State: AOJu0YxbVGYa42Xiw9HZTUCxhW37Pnw+rzSh8m1JZNAFyZjIiI/2FLbY
 +JDUCuAX7BsLhvYtADEjeVzyP03icjeLfEd6MsjNitXyKrGsXf4FCJAaQr7n9FXtQa6VCwuYKzR
 XUrCOMR4uNor29aHiAputzF6Y4BWw9Wb2F69u+A==
X-Google-Smtp-Source: AGHT+IHY/9CO7PjDgfwQ6TtMIsEPEXipbOmya0TejVg8ZHn/oyvoIpHsIVI1u7B4Ha4bchYB9l4MD0rbCApGmdOSg4M=
X-Received: by 2002:a05:6a20:1810:b0:1c9:1604:cf2 with SMTP id
 adf61e73a8af0-1c916040f79mr2955859637.0.1723834162795; Fri, 16 Aug 2024
 11:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240814134518.82692-1-ilias.apalodimas@linaro.org>
 <CAFLszTjrBL-GonZKqp3Ab5vQPMZ+BZu8V21y4z0qBCGuH64uJw@mail.gmail.com>
 <CAC_iWjKF0DMfJza-ojYXPg_tHL14DTdK+GzhxhEX3etpaNiK8Q@mail.gmail.com>
 <CAFLszTjfhtRqRTdQOi-Dhzpa_aVSVSU8FjWmXEKz5vi=_0i=BA@mail.gmail.com>
In-Reply-To: <CAFLszTjfhtRqRTdQOi-Dhzpa_aVSVSU8FjWmXEKz5vi=_0i=BA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Aug 2024 21:49:11 +0300
Message-ID: <CAC_iWj+gi30VzTFcJiHY9YzUt13Jne9oBVRsESYTknmJZaSXtg@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: clean up the efi configuration status
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Shengyu Qu <wiagn233@outlook.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Greg Malysa <greg.malysa@timesys.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Sean Anderson <sean.anderson@seco.com>, Anand Moon <linux.amoon@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon

On mobile apologies for any weird formatting in advance.

On Fri, Aug 16, 2024, 04:34 Simon Glass <sjg@chromium.org> wrote:

> Hi Ilias,
>
> On Thu, 15 Aug 2024 at 15:11, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> >
> >
> > On Thu, Aug 15, 2024, 23:33 Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Ilias,
> >>
> >> On Wed, 14 Aug 2024 at 07:45, Ilias Apalodimas
> >> <ilias.apalodimas@linaro.org> wrote:
> >> >
> >> > The EFI_LOADER and EFI config options are randomly scattered under
> lib/
> >> > making it cumbersome to navigate and enable options, unless you really
> >> > know what you are doing. On top of that the existing options are in
> >> > random order instead of a logical one.
> >> >
> >> > So let's move things around a bit and present two enties for the
> >>
> >> entries
> >>
> >> > EFI_LOADER and EFI options in the main config screen.
> >> > While at it add menus for Capsules, Protocols, and Services in the
> >> > EFI_LOADER so people can find their way around easier
> >> >
> >> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> > ---
> >> >  Kconfig                |   4 +
> >> >  lib/Kconfig            |   2 -
> >> >  lib/efi/Kconfig        |   5 +
> >> >  lib/efi_loader/Kconfig | 202
> +++++++++++++++++++++++------------------
> >> >  4 files changed, 123 insertions(+), 90 deletions(-)
> >> >
> >> > diff --git a/Kconfig b/Kconfig
> >> > index 82df59f176ec..62c5441e3576 100644
> >> > --- a/Kconfig
> >> > +++ b/Kconfig
> >> > @@ -756,3 +756,7 @@ source "lib/Kconfig"
> >> >  source "test/Kconfig"
> >> >
> >> >  source "tools/Kconfig"
> >> > +
> >> > +source "lib/efi_loader/Kconfig"
> >> > +
> >>
> >> This should be included from boot/Kconfig as it relates to booting.
> >
> >
> > Hmm why? Booting is one of the things efi does. I prefer having it on
> the main menu since it's a pointer to the entire spec, protocols, services
> etc
>
> True. From a functionality point of view, there is booting and
> firmware update. Is there anything else? I have thought for a while
> that we should perhaps have an 'update' menu. Where, for example,
> would VBE fit in the menus?
>

Why don't we do something similar for VBE? I agree that those are the 2
main categories, but I think it's far more intuitive to have all in one
place depending on what to choose to boot and upgrade your device.

Otherwise you have to enable the 'boot method' and start navigation around
for updates etc.


> >
> >
> >>
> >> The EFI app thing should perhaps be under there too...I'm not sure.
> >
> >
> > I was toying around with the idea as well. But eventually I decided this
> needs it's own entry since it's about building U-Boot as a pe/coff. I don't
> mind changing this though.
>
> Yes, building as an app isn't really about booting. It looks very
> lonely at the end of the menu, though.
>

I'll fold this in to UEFI

Cheers
Ilias

>
> Regards,
> Simon
>
> >
> > Thanks
> > Ilias
> >>
> >>
> >> Regards,
> >> Simon
>

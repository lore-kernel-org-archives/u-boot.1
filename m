Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9BAC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7442E80A0A;
	Sun,  9 Feb 2025 21:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dVZt6vYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCA1809A5; Sun,  9 Feb 2025 21:14:49 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4051A80821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso708493666b.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 12:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739132087; x=1739736887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qq/Jsia1e8lOs5bHGIThIPe6MfHFCZCcGJPPSacNA6c=;
 b=dVZt6vYxq3hmbJVLnCqsCa8PSvQ7gTTjOzPZgaMGS4KyUkcH9/BNdsBDg4ywJl/B4U
 EtZzOvUEZmeAKx86g9Xc2wm0M7+QnpodJR/5mAgETVvskto5rVZkD5McXAhAlMEnjkEC
 D4bZSllkF4VyWLSR9ATrHv5pUpH92xtPxBQQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739132087; x=1739736887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qq/Jsia1e8lOs5bHGIThIPe6MfHFCZCcGJPPSacNA6c=;
 b=wVQiBbkEdDG/p//OZpbDDtIWAKUFviN9YTb6OIO60Xh4S9JWVC8c9tZDrDN5Of4OC4
 Jolesccj38X29/CZCxA3hs/0A8cFOEmF24uF4fY4wybgG2whlO6abM35n0mQil/peZPu
 HkJYfDcmm0QN2JYDbgt81y/bhJgBToHLQW7r8DtEsgz2m+Nq4UEGnZAeF1Pq/wUSsDxc
 kUHImTe1kEQ+Tp2qTzXMSVoJWsEvLWJ2HXs14lTEfAOBOXEnIDE49pRLXOK1YI3yACw4
 R/albCKP9zzZnDJ5eTbsxeip6ZLQW8HnIYknKT0mkcWfe38oJ3X9t96JkkMBdbegatK/
 wbWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRDnoi7TrOQp8I4KjOBdL4uNRiELCFFTr996BkVSELWNlStpGR6aZCH0gh1D61HRoVb8wWttk=@lists.denx.de
X-Gm-Message-State: AOJu0YxtjbjgUMXqm1U2NimSVyR3xHGWTazinxb9JidFH+rrGxxoK5S4
 K9d1tQ7Ukm6r2AtFf27lknXU8RAdyV+vNuOZspiluzOWsuqQQ/IJTn4xKAS3M62bXL9Fx4Z0Xi/
 NvBzFfENBT6QjnHCEXwUsWoKzkTXpwhC/zLeP
X-Gm-Gg: ASbGncs0TaFKZzeZb8KdGDrQeKHaim7eFhWp9RJDO+XM/ruiJj1EAjy6kd5A8wq4h+t
 J4XRSdHnaHNgfHqHXL4BydlLNZfKX3t0gAqv5/KshNopNmWjs+op5xrf52Plo2KkDiq5EjdanxQ
 ==
X-Google-Smtp-Source: AGHT+IFTPqK1nczR7r0NND3BGo3ZQWyT4QG+OAS4qp87XH8YqYDVi3ImZyu4SzRZbdNVtkespSid2Vhoe09cXM7rSio=
X-Received: by 2002:a17:907:9719:b0:a9e:b2da:b4a3 with SMTP id
 a640c23a62f3a-ab789c627ecmr1296304466b.42.1739132086666; Sun, 09 Feb 2025
 12:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
 <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
 <CAFLszTirNaX-6KfMPJ1LNHe3iU_QzATy0s1dHnfKbUw22NCP-A@mail.gmail.com>
 <83c2dc33-83a3-45eb-96e7-8c3b7ae38b88@canonical.com>
 <CAFLszThBmOvnkGLZEv+rQkS1F+4gB=yJMQ-+UShDrUbGyGP36w@mail.gmail.com>
 <55245b3e-22b0-464e-8ec5-4e3a95b88de1@canonical.com>
 <CAFLszTiwMeT6RS1iOF=mHbWz2brY7NKoB2AJEULcr1EqGCq+MA@mail.gmail.com>
 <d4b90028-a68d-4606-98d3-7f6a34272c8b@canonical.com>
In-Reply-To: <d4b90028-a68d-4606-98d3-7f6a34272c8b@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 13:14:34 -0700
X-Gm-Features: AWEUYZkqoLkFH50VrNAtEI_movRUqoaWteH-gbTLG_hcQzNUDjupECtGwsSla_s
Message-ID: <CAFLszThRf=pY+YFQfhk20zXgAgcJX7ys2-iVdt0L-v9vj=QRDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: continue in fit_find_config_node()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sun, 9 Feb 2025 at 10:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 09.02.25 17:24, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 9 Feb 2025 at 09:10, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 09.02.25 17:02, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Sun, 9 Feb 2025 at 08:53, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 09.02.25 15:29, Simon Glass wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On Sun, 9 Feb 2025 at 04:52, Heinrich Schuchardt
> >>>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>>
> >>>>>> If a single configuration node lacks a description, this does not rule out
> >>>>>> that another node with a description matches. Anyway we have the default
> >>>>>> configuration as a fallback.
> >>>>>>
> >>>>>> So continue if a description is missing.
> >>>>>>
> >>>>>
> >>>>> That field is mandatory, so we should really fail if it is missing.
> >>>>>
> >>>>> What problem are you trying to solve here?
> >>>>
> >>>> Sure the field is needed to make a configuration selectable.
> >>>
> >>> It's actually normally informational. Have you looked a
> >>
> >> If the field is informational, we should not worry if it is missing.
> >>
> >>> CONFIG_FIT_BEST_MATCH? That is how this is supposed to be done. But
> >>> with starfive_visionfive2 I see:
> >>>
> >>> # CONFIG_FIT_BEST_MATCH is not set
> >>
> >> How would CONFIG_FIT_BEST_MATCH match strings in the EEPROM to a FIT
> >> configuration?
> >
> > It uses the compatible strings from the running devicetree. If you
> > know that it is wrong, or too generic, you could enhance
> > fit_conf_find_compat() to take a compatible string-list instead of an
> > FDT blob, then add a SYSID for reading that from your board's sysinfo
> > driver.
> >
> > How does it work at present?
>
> board_fit_config_name_match() in board/starfive/visionfive2/spl.c checks
> the configuration name against the EEPROM strings. This is invoked via
> fit_conf_get_node(). Several other boards override the same weak function.

So we have fit_find_config_node() and fit_conf_get_node() which calls
it. There is similar logic in fit_image_load() and the 'best match'
logic is not present in SPL.

It looks like we should try to unify things a bit more.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> >
> >>
> >>>
> >>>>
> >>>> But as long as we can find a good configuration we should boot instead
> >>>> of leaving the user with a bricked device.
> >>>
> >>> The more likely impact is that people won't bother adding the field on RISC-V.
> >>
> >> The current runtime check is inconsistent: You will get an error if the
> >> first config lacks a description but may not get an error if the last
> >> one lacks it. And you are potentially bricking bootable devices.
> >>
> >> The right place to check is mkimage. Here you can bail out if a string
> >> is missing without bricking devices.
> >
> > OK, I can see that the current thing is inconsistent, so I don't mind.
> >
> > Regards,
> > Simon
>

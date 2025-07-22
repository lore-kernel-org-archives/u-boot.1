Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D092C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 04:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B067830EA;
	Tue, 22 Jul 2025 06:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qy1cyjly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B08E831E0; Tue, 22 Jul 2025 06:30:55 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D8C82D32
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 06:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e302191a3so46733537b3.2
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 21:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753158651; x=1753763451; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRq2RgQ1LqDX55niBU1zdmC3/ZESTZW09ZuJrjIttRs=;
 b=Qy1cyjlyTNkBrXI82rmG5LxXn/k+3SVLVx4joGRJG9Muh1hfXrbRMZW4WfSjLO/F9K
 nIYHtxGugVg7dDSOfPSkExGnBr6LUmCI0vyEepeiGiS9LsUZEeylVexlIn58RJS+bhYl
 oBjQ/5UviAVDQNQ1M/M9NMVUCMqPQBH3RVuxdYnIKYwsVXsjyzDeEcg0tUZlBExF6WXA
 Y8UUnBHYRpXw23Y7lIcuTSoX5nxgAIUeD5zdC8hhRxG6DqaKXjip4PLaeG12lo+ZxSSe
 /grogdldxVhq3G8tL1SgRudnC+/ueqdnIu/G2a2WsdSjjlsLH70JeMyp7NICMnjA757B
 XJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753158651; x=1753763451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRq2RgQ1LqDX55niBU1zdmC3/ZESTZW09ZuJrjIttRs=;
 b=xVE9qsPC+ib8deyXV4K3DZ5NPkXovhujsosGmqboxkTxdK+n0fauvyYvnzPAmvXOaC
 PyjN93y/L71o/th0aBCfJHZUmgAFnwzrYfvFzg4tNBC5C3vbBZsAz+N2DD4kooxsoWWm
 ILDlLDF4/zVA67mXWhNXrJswjgb4nq6XnsHAcUsm9dpwyfoC405tqhabKXdIoStr9Ze4
 s6mopisWz21TUwSIVn5duk0eGhzHco5GZvu1QqwUtvw/ICEUCPKoTLwwhpGWAfcEG10F
 N8y8bRyb3NHfUIBnOx9uEE46mwWjQ5lldCQPKJDPhcyhYpk9HGZsDFEg3xdzGP1JOWkV
 3yXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYYj6pS/qPioBjhupQE9NsVB6vnVL2V+exZfPk4Tv7magDsOQwwzUgqUnevWe8xSNUrAvwXyk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxku88HOcZH70bfrx609M7kKOiT+xfP58AEnYzJJWxMLo6puLud
 kbUTUYK+wvQbZQVOQloHlMySM62k6ajrksD3bpu/xvYZNvem/QiaJqMSZ8nVEml7LoDom8gCH1p
 bUbbolISqw/hnlAFmyP3Ow4Wh6OWSawKBllef5QB+uw==
X-Gm-Gg: ASbGncsei563T+sdXDMA2+x97aUuEOuESBLeFl7728/3zXEamlHDryNsLTtkyD3qUIg
 +JU7gRlgJykMU0bvkE8FZIK90VAKTkX59BT/FFxKCGQAER7ni/SS/1QheGswpyDUJ6O2jsqACPW
 zulM0OU85SoVOl618OV7wGLabhUhGd0R3IdWIeOedm1L6T+8zPF7yPdwebcKfVW8Js5xmsJzheO
 sn9zzu6bYkZJTSOzA==
X-Google-Smtp-Source: AGHT+IGftOja5SNR78hXv5vDE5P2KMsPNr+JiBUHW/MOKQ1QureC7OVDuMFtzELSxSc8A4goE4s47HLpIy9q7nyWe7E=
X-Received: by 2002:a05:690c:9b0b:b0:719:4cde:84f with SMTP id
 00721157ae682-7194cde0b72mr207405047b3.10.1753158650875; Mon, 21 Jul 2025
 21:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
 <87ikjllws2.fsf@kernel.org>
In-Reply-To: <87ikjllws2.fsf@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 21 Jul 2025 23:30:40 -0500
X-Gm-Features: Ac12FXzm5dI9cOXXKsMhlWaCdxpj2poLHcA85K3Ig5SzYo0Qf_58bmv-2apENkg
Message-ID: <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
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

On Mon, Jul 21, 2025 at 4:26=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> On Sun, Jul 20, 2025 at 14:57, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
>
> > On Thu, Jul 17, 2025 at 1:58=E2=80=AFAM Mattijs Korpershoek
> > <mkorpershoek@kernel.org> wrote:
> >>
> >> Hi Sam,
> >>
> >> Thank you for the patch.
> >>
> >
> > [snip]
> >
> >> > +
> >> > +#define EXYNOS850_DRD_UTMI                   0x50
> >> > +#define UTMI_FORCE_SLEEP                     BIT(0)
> >> > +#define UTMI_FORCE_SUSPEND                   BIT(1)
> >> > +#define UTMI_DM_PULLDOWN                     BIT(2)
> >> > +#define UTMI_DP_PULLDOWN                     BIT(3)
> >> > +#define UTMI_FORCE_BVALID                    BIT(4)
> >> > +#define UTMI_FORCE_VBUSVALID                 BIT(5)
> >>
> >> Comparing with the linux driver using
> >> commit cc52a697f87e ("phy: exynos5-usbdrd: support Exynos USBDRD 3.2 4=
nm controller")
> >>
> >> I notice that the defines are in reverse order (from 0 to 5 and linux
> >> has from 5 to 0).
> >>
> >> Is there any particular reason for this?
> >> I don't mind it too much but it makes diffing between linux and U-Boot=
 a
> >> bit harder.
> >>
> >> Anyway, I've compared this with the linux driver and it looks good to
> >> me!
> >>
> >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> >>
> >
> > Thank for reviewing this, Mattijs! Yeah, I kinda flipped the register
> > bits w.r.t. kernel's version, just because it looks better to me this
> > way (easier to read when it's sorted properly). Due to the driver
> > model API differences between kernel and U-Boot I had to rework the
> > whole structure of the driver, and I only added Exynos850 support for
> > now, so the difference between U-Boot and kernel versions is quite big
> > as it is anyway, so I figured it's not a big deal to reorder things
> > even more. Hope it's ok with you?
>
> It's ok with me. I was just curious if there was any special reason for
> re-ordering. I agree that it's easier to read with the sorting you have
> applied.
> I've noticed that only Exynos850 is supported for now. That's fine as
> well in my opinion!
>
> Feel free to pick this up through your tree.

I don't have a maintainer tree unfortunately. The easiest way for this
series would be probably to go through Samsung tree (Minkyu)?

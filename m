Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2FAC3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7878144A;
	Mon, 31 Mar 2025 12:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dbKWs3XU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C6081703; Mon, 31 Mar 2025 12:33:56 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8848006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so3567736f8f.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743417233; x=1744022033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnxWSkbNBlj9spqzFb/dhqZ0j9h+j9/bXNk1CyNPV4E=;
 b=dbKWs3XU9+cfO4ziWkFGa+4ZyBdvCf5XgoMCwcoa47rCAH1JuZWrKNQM1HRgE0Yhjn
 YtZ/WHDEI01KbXtHJGZOil51TI7ycDUGlfZwhQGtwVpMFcbx/twpVcGP6+lL5qH0mFgr
 g2aiDKJ+aT5Q9Jo/Lz5nV4jPInmkPMzVn5fI+lk8fFkgGiLsjVSsPr5CcjEK5UluSHu/
 RqmgX5Udl4xLZWw2jYwCzZZU7cdUDDBD+w+2GNhO/g9ZRi7sUeePC5SN504wi4w0Y9z7
 oGDoMO5pbfwll/OzeEN/iuP1XjfE6KfXQhK4J01OtvwbfKjmTEMcVu1BvpGV3QsZjhiU
 t5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743417233; x=1744022033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnxWSkbNBlj9spqzFb/dhqZ0j9h+j9/bXNk1CyNPV4E=;
 b=ATdlT+syNVffDuivu4elvmnUg+R0V7aG/9Q4T7JyjmPHb92MYV0fnT6meEacbHpojg
 i8VE7o7pDXMLwtpMtc1IGA8B36m4JLTQiQ5DVZn06WVhGEp9hkzKO1e2u2wtEMtdrhGv
 KbSqfhcnFwiz1X5wu+gjFZBE7iipivyVYQkhNhyPJB9YwrG4ounD6TgiGA/5OIfQXiud
 wnXg8emGTtdazyrcGSD4fF480Hfd719ofwCQ8GOjhCMntqf76G+97a2HaRU1JepQh2oS
 qWpURYotySHzoJegZa4V7WFU6gg9oDYbbPXWXwdKp7vXfIYDG2YYCyLP7NtrOGRSh5A4
 1t+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdBx1YdByM/NzFREUog9Fka9BbTr6TqHw/fvXPlECgTUfyI1KiaZ7r8deH2p0Gb74qjxWw4kk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3snioDztJOC0zqp/nhzkzX01FJItuHrqTnV/85zIebq3oR9xa
 TkzPzg/il0HkY6Ki/kwKUMy90kZ+H3go6AWO/gpXGJVqDlopEE7djOtcLM3jEp3Lxzlq0M7VGpZ
 ooF1HauG6vPO4N+5VMaYBYDB7UGk=
X-Gm-Gg: ASbGncsx7G6ug4quys2pLHqoZfH3Of5TWjVoa+tT1AwlkSP4LNzSA7NbokEdfgyfMHQ
 lpRxPoxx7IVntWwfvtdBpPC0+5IYGtoVZZaIXPXhQrSpwYvHudR6R40M0l21SIeHaBIpT+C1vwY
 mFFymmeHv+BCnPZt3S8GEIhNFcKln0yhU26jjxEg==
X-Google-Smtp-Source: AGHT+IHKE4z4sE2YY+6Ch1j6rP42kwrKJ74v6iQWbbkfwFGQVaUpeATbBHIU35AA0twsxH7R2bdiRvuOtE8BpMwmhLM=
X-Received: by 2002:a5d:5c84:0:b0:39c:1efd:ed8f with SMTP id
 ffacd0b85a97d-39c1efdedbemr769227f8f.50.1743417233225; Mon, 31 Mar 2025
 03:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250330092815.10350-1-clamor95@gmail.com>
 <20250330092815.10350-2-clamor95@gmail.com>
 <aac2609c-c079-44a9-92ba-8517af78350e@cherry.de>
 <CAPVz0n0jo6MjYi7Bvj2RFxCJHdemrbUUbjzJfPXcKqfD6nCQgA@mail.gmail.com>
 <ea8870ec-69de-43d7-a1cc-e8a437b90a98@cherry.de>
In-Reply-To: <ea8870ec-69de-43d7-a1cc-e8a437b90a98@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 13:33:42 +0300
X-Gm-Features: AQ5f1JprD89ADw48no235fY4ha3WFVCB4H6wZPpWcGSVcxU89ChnqtqgcWStOVc
Message-ID: <CAPVz0n3xeiXcXBdrsmBktRdjGD1D7-XDM4J6DOOqL5yaYD6x8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sysreset: add PHASE_ to GPIO reset and poweroff
 configs
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
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

=D0=BF=D0=BD, 31 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:31 Quen=
tin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 3/31/25 12:27 PM, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 31 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:16 =
Quentin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hi Svyatoslav,
> >>
> >> On 3/30/25 11:28 AM, Svyatoslav Ryhel wrote:
> >>> GPIO reset and power-off functionality depends on device tree data, w=
hich
> >>> is often absent in SPL or TPL. To address this, incorporate PHASE_ in=
to the
> >>> config option.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>    drivers/sysreset/Makefile | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> >>> index 796fc9effa5..ded91a4d325 100644
> >>> --- a/drivers/sysreset/Makefile
> >>> +++ b/drivers/sysreset/Makefile
> >>> @@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) +=3D sysreset_rockchip.o
> >>>    obj-$(CONFIG_ARCH_STI) +=3D sysreset_sti.o
> >>>    obj-$(CONFIG_SANDBOX) +=3D sysreset_sandbox.o
> >>>    obj-$(CONFIG_SYSRESET_CV1800B) +=3D sysreset_cv1800b.o
> >>> -obj-$(CONFIG_POWEROFF_GPIO) +=3D poweroff_gpio.o
> >>> -obj-$(CONFIG_SYSRESET_GPIO) +=3D sysreset_gpio.o
> >>> +obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) +=3D poweroff_gpio.o
> >>> +obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) +=3D sysreset_gpio.o
> >>
> >> Are you sure this is safe for all boards?
> >>
> >> Essentially, right now POWEROFF_GPIO/SYSRESET_GPIO would be built for
> >> devices with TPL/SPL_SYSRESET symbol enabled, but with this change it
> >> would be disabled, possibly breaking their setup.
> >>
> >> I'm not against this change, it's just that there may be additional
> >> changes made to defconfigs to transition to this new symbol...
> >>
> >> ... which you haven't added here. I don't know what's the policy, but =
I
> >> think it makes sense to add the VPL/TPL/SPL symbols here so that peopl=
e
> >
> > You mean config SPL_POWEROFF_GPIO and SPL_SYSRESET_GPIO? It seems a
> > good idea, I wonder if there is a simpler way to add this without
> > adding Kconfig entry for every boot stage. Maybe you know such
> > example?
> >
>
> We don't have such a mechanism, each symbol needs to be "duplicated"
> right now.
>
> The thing is, we cannot really automate it (globally at the very least)
> as some symbols have different dependencies (and possibly different
> default values, etc...) depending on which PHASE they apply.
> Additionally, some symbols are for all PHASEs, not only proper. Maybe
> there's some magic we can have in Kconfig for that, but we would need to
> create a plugin for it.
>
> I think this may have been raised in the "xPL proposal" thread on the ML.
>

Thank you. So duplication it is.

> Cheers,
> Quentin

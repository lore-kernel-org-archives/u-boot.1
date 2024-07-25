Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EC6C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 315F58789F;
	Thu, 25 Jul 2024 20:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Pv84lFoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD1388286; Thu, 25 Jul 2024 20:25:44 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF0686D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 20:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7ad02501c3so96415266b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721931942; x=1722536742;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tIULu+Jfe/+845i/oYBFmIGHNfVnD9Q8yEG5COz9H/k=;
 b=Pv84lFoy9a616VufvjzGlnLV1RG6ftrB9b2x9naf5Z3DuTBCePbJltXQ/kJjz0kmi8
 mBLD6J4ue6YWSYSnOKbcSUWbKrXnarqtxZqQt+IEmIfMtGDSH6eGyB5+Su8u0y2vt8ms
 sN2CnNM8NJPOIkT3rpPvbkV6R6Y8dc1a3z8aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721931942; x=1722536742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tIULu+Jfe/+845i/oYBFmIGHNfVnD9Q8yEG5COz9H/k=;
 b=HA8KbyAVq7LplXX+7MNoEmVI31H3kQ6OKxPh5nZ0bi0hq79nPJZKYXXF8bHaDPi0Wb
 83cd9eflDTS7D9eoMmKDXpqGQ6ksFr1u+722ZF350mg0/4qXOPYKGFDZpMEFt6k+EWyR
 9y59CUbb4Tp5fYx7N+oD8+GwXphnW2BuSlceRU5StQ2Fj8pRAyXLw1/vEIbpF+YQ45K4
 Eh/f/+jEwletOoeG67ympxOhzAA7fXStt+o6+Qlw6/QzmnQpzR2e4OxrmZMArzEMBWuJ
 6KpaRkKlKYpVOuwVIkB6QQbjvZS0mJ1fKHIoOOoJY3ORtoLH1ur10L3VdDhDcWsGVMbi
 9N9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaiyRIQhwsNdF4HsEBbt5dzYBpAasmrQHosCjsdXo/a7VP3LQATfo4OUPLzneElerB9gqqSL9RHehpUQrXntfM0zJpRQ==
X-Gm-Message-State: AOJu0Yz/hrxURyHO8+b9FyJa+p7EI3v1IFmNyBPMFnLnRza0akQ6gYsX
 UnUA+cfk+4wMKcahfyNcPyY2n3xFo6Sy/L+OJ7lDlUV5uTvdLnfOtIA1WtXaAghgMJPXb6au6hE
 SM9hkS9ihL5aUJRY8B1IhufZ4XS1D+B+Uzv9RLA==
X-Google-Smtp-Source: AGHT+IFsBz0SxcAJoJUl/qxvvHC2rWHRac2+aPH6c3+TiEtVrklDgp72Nr/DbopNZAdUZ8XRF655QdHkrgoOeQletss=
X-Received: by 2002:a17:906:6a19:b0:a7a:c256:3cf with SMTP id
 a640c23a62f3a-a7acb3ef696mr229405466b.24.1721931942053; Thu, 25 Jul 2024
 11:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <CAPLW+4=xXM8m7y030kcxTBwgLfm_cud8HYrwF0k75=GOg==zAg@mail.gmail.com>
 <CANAwSgSw3ZkZBaVeAUoj6hCtGoydEmMEoLBaEkU4JW586M5TEA@mail.gmail.com>
 <20240627144205.GB38804@bill-the-cat>
 <CAPLW+4m6SjAmDxQFBJhQwmGP-DOOPXipEY8n6CuWk81ZFZRbeg@mail.gmail.com>
In-Reply-To: <CAPLW+4m6SjAmDxQFBJhQwmGP-DOOPXipEY8n6CuWk81ZFZRbeg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 25 Jul 2024 20:25:28 +0200
Message-ID: <CAOf5uwmy0DkjmPW_Nb3iP-3jLfgmtV0toPhFPM7=Zsi9h6RMBw@mail.gmail.com>
Subject: Re: [PATCH v2 00/40] mmc: dw_mmc: Enable eMMC on E850-96 board
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, uboot-snps-arc@synopsys.com, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all

Il mar 9 lug 2024, 02:48 Sam Protsenko <semen.protsenko@linaro.org> ha
scritto:

> On Thu, Jun 27, 2024 at 9:42=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Jun 26, 2024 at 10:12:12PM +0530, Anand Moon wrote:
> > > Hi Sam,
> > >
> > > On Wed, 19 Jun 2024 at 02:26, Sam Protsenko <
> semen.protsenko@linaro.org> wrote:
> > > >
> > > > If there are no new comments on this series, can you please apply i=
t?
> > > >
> > > > Thanks!
> > >
> > > Tested on Odroid XU4 and Odrroid U3 boards
> > >
> > > Please add my
> > >
> > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> > > Tested-by: Anand Moon <linux.amoon@gmail.com>
> >
> > Thanks, Minkyu will you be able to pick these up (and other outstanding
> > patches) for a pull request to -next soon?
> >
>
> Hi Minkyu,
>
> Gentle nudge :) Could you please apply this series? I'm working on
> some other features requiring eMMC enabled, so it would be great to
> have it merged soon.
>

I think that we should merge your clock patch. I will rethink my series and
make a differente design but agree that 5 months are too much

Michael

>
> Thanks!
>
> > --
> > Tom
>

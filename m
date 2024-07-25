Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DACC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F3486E85;
	Thu, 25 Jul 2024 11:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MlIh5J92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8FEA87876; Thu, 25 Jul 2024 11:26:13 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F7486464
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5a156556fb4so925969a12.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721899571; x=1722504371;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VcW4S5l5fS7wTFmBpAZ+ZDHWcPQAmJYlYqVjqQyu8p0=;
 b=MlIh5J92X81t9WsghP5U6B0j/Jq76A0cthxgnJz1lCdeI3aEv9BpUc9ZJy5eh0IFH4
 TmXrPPx6WKpabfyv5iPxHVWGu4ue/DvXIo8r1dM7n18MoNPfA+hAmMsj2Whai5/6sK+q
 GDsujnEEdwe5J8LCe8g5JvQwN2QEFowxW7IBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721899571; x=1722504371;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcW4S5l5fS7wTFmBpAZ+ZDHWcPQAmJYlYqVjqQyu8p0=;
 b=IikapaZozOx4O3kuH8yHDYWBBZLKXgHHPoQmBoUbGyVpq13N16rYffdV0ul+UUvdB0
 WNCt6WX141qSz3QtLXfj48oleUpa8GnFYQatcm+i07Do18eqbFfuZvers9OuZ5OLa4YN
 MWH+mNk+8mIYRkP2/iU74+BFN0Cu/YxSqXWjW6tnROucLCatZh1E86xUa34uBmKuI/CZ
 C00dc4f1quvx/S8h7LGNrFhwiAM0RuB8/doEe0t68VrIT+D61Mo98tZcYpgLQt16Ak0m
 g76pzv9pyhHd8Mbf6iT7cWAY+xWE2U4aImrn9hQ0d9eeP7fDpOQRJ89e1HQRH1q1W6gY
 y20g==
X-Gm-Message-State: AOJu0YwX5dzdhCgcBLwAKokM5MwTM5uD6B0dRhZNNPVSMilSyjauB+0r
 PYZxe//MFUoi+rXY4cFpeBmZmhl6+vCX2TmH4J1M+6w55L74wYbJNhrsHFBpCty9TjXsFhMLwjk
 LjVu9sfKWpLuWUB40M53B+XpH3h+cNgB+45Wd5A==
X-Google-Smtp-Source: AGHT+IFZIr0tWvGZs7nUEBQuI7lhRm0ZOhesaaNf8/stXY8I2RkHMICOX6vVOsImeq1H4wb0LFiT6xpi8P7WFQXM6M8=
X-Received: by 2002:a17:907:841:b0:a7a:a3db:c7b3 with SMTP id
 a640c23a62f3a-a7acb47a107mr103760266b.19.1721899571097; Thu, 25 Jul 2024
 02:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
 <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
 <DB9PR04MB9236ACC9C613982795A9E5AC84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9236ACC9C613982795A9E5AC84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 25 Jul 2024 11:25:59 +0200
Message-ID: <CAOf5uw=nNter1RSuxvaXZ0NFkoOkqAKyQs2_97Ap4W5KhXSQmA@mail.gmail.com>
Subject: Re: [PATCH] clk: fix ccf_clk_get_rate
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>
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

Hi

On Thu, Jul 25, 2024 at 10:53=E2=80=AFAM Z.Q. Hou <zhiqiang.hou@nxp.com> wr=
ote:
>
> Hi Michael,
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: Thursday, July 25, 2024 3:32 PM
> > To: Z.Q. Hou <zhiqiang.hou@nxp.com>
> > Cc: u-boot@lists.denx.de; trini@konsulko.com; lukma@denx.de;
> > seanga2@gmail.com
> > Subject: Re: [PATCH] clk: fix ccf_clk_get_rate
> >
> > Hi
> >
> > On Thu, Jul 25, 2024 at 9:16=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@nxp.=
com>
> > wrote:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > As the type of return value is 'ulong', when clk_get_by_id() failed,
> > > it should return 0 to indicate the get_rate operation doesn't succeed=
.
> > >
> >
> > I understand your point here but the clk_get_rate that can call the ccf
> > clk_get_rate can already return -ENOSYS.
>
> will also fix it.
>

Is there any usage of the error set on the latest bit of the clock? We
need to be sure that this
is correct use accross the uboot. The clk-uclass define the error that
can return

Michael

> Thanks,
> Zhiqiang




--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

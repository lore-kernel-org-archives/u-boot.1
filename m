Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0BAC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 10:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E4F8789F;
	Thu, 25 Jul 2024 12:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kJ3yuVfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4DB18789F; Thu, 25 Jul 2024 12:21:21 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71E1287876
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 12:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7aabb71bb2so53565966b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 03:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721902879; x=1722507679;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcY+4ClMWxwyv3ckJ3IB+pSuwqm7XmDh6q1odwUsSFc=;
 b=kJ3yuVfdF/td1FNod/YKGS2oigKCkwwEs2wAJg5YjAs0Z5xVwjz707iFpKWMxG0ap2
 XvcQVr5Fffkmoi5c2jAbTB41cmx6xXZBsseOK7a8c36Zme/YcSyH/QR7ZB1bmbKVpu3H
 1MsS7uKUOkfZ5O7hOEVSdyj/bqyzT2lSm4/+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902879; x=1722507679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcY+4ClMWxwyv3ckJ3IB+pSuwqm7XmDh6q1odwUsSFc=;
 b=Qg+9wXSkyQUARhrKmwVgBfTrMiuOJQ8IRPM3UBS0J/oDzNXs4ZzHzQ+l1dPZuFDRyV
 x9CYmMNpydPm789/2G/F7W90dx41XtTvIRHW8GHvf6vYKlgjiIvx/769MJ7AK0veZacj
 OvnCyC2IIevGA5M0XvkcmXEwbbUsmbJWmdlAI7ljBG2fp4H5HpglNUh9Mb0+aXCqJXvf
 LSONvsI+wOI8b+XUj+iVmuCHqUWFDGoAaDOGN0kp9sRA9VhRpgAOPYJ5nI/Gaf2rzdxz
 Rw4Zj5pUqsdiBXxPQLx1rZTAUOvq4U9FXyb+umIoE/Abt/17T4rJSNDM9CyJUyW2R49W
 MrLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ztZ5VxBqso7dgQJvgnLg+Ae9rvREOUt4/9iE54BcjM5T829zFmgbnj035eV47wAZos8wASahadfFiwljDDRE8ym0OQ==
X-Gm-Message-State: AOJu0YySM6GwyFhdRQp4pTk1HMMiIy1NTUBAh5bZbmVjSXdV24wEd3AA
 6gxcUpKfDnE+cguxl2RZuKVdBbthxaV3s+mAyY6bOX4aT4qtbS7/Kwd3xmxverl1/MIiFe3wGMz
 3gB4VRUq4cu4JV6V16aZbyQ1PLMBFGQdm2fzQZA==
X-Google-Smtp-Source: AGHT+IFEt97ycjCV8oLJlG6Mx79RtY270J88uQoLAjSzp9KkosnvbDTy6QrFe3YHv3zSTQv1peKW9KW4U2Ch5YGOZ2E=
X-Received: by 2002:a17:906:7950:b0:a7a:8e98:890d with SMTP id
 a640c23a62f3a-a7acb3eedd3mr119159666b.16.1721902878677; Thu, 25 Jul 2024
 03:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240725073707.26040-1-Zhiqiang.Hou@nxp.com>
 <CAOf5uwm-kedmeH7at0F5+zfuJ9218NwRSJjA4_vjTGvpsJ7msA@mail.gmail.com>
 <DB9PR04MB9236ACC9C613982795A9E5AC84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <CAOf5uw=nNter1RSuxvaXZ0NFkoOkqAKyQs2_97Ap4W5KhXSQmA@mail.gmail.com>
 <DB9PR04MB9236322AD261E061C1DB573484AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9236322AD261E061C1DB573484AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 25 Jul 2024 12:21:07 +0200
Message-ID: <CAOf5uwkQF5P1EknEauK6j=jB39LNeMEzvZ7secN6tb4K1pmt2Q@mail.gmail.com>
Subject: Re: [PATCH] clk: fix ccf_clk_get_rate
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>, 
 "seanga2@gmail.com" <seanga2@gmail.com>
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

On Thu, Jul 25, 2024 at 11:58=E2=80=AFAM Z.Q. Hou <zhiqiang.hou@nxp.com> wr=
ote:
>
> Hi Michael,
>
> > -----Original Message-----
> > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > Sent: Thursday, July 25, 2024 5:26 PM
> > To: Z.Q. Hou <zhiqiang.hou@nxp.com>; Simon Glass <sjg@chromium.org>
> > Cc: u-boot@lists.denx.de; trini@konsulko.com; lukma@denx.de;
> > seanga2@gmail.com
> > Subject: Re: [PATCH] clk: fix ccf_clk_get_rate
> >
> > Hi
> >
> > On Thu, Jul 25, 2024 at 10:53=E2=80=AFAM Z.Q. Hou <zhiqiang.hou@nxp.com=
> wrote:
> > >
> > > Hi Michael,
> > >
> > > > -----Original Message-----
> > > > From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> > > > Sent: Thursday, July 25, 2024 3:32 PM
> > > > To: Z.Q. Hou <zhiqiang.hou@nxp.com>
> > > > Cc: u-boot@lists.denx.de; trini@konsulko.com; lukma@denx.de;
> > > > seanga2@gmail.com
> > > > Subject: Re: [PATCH] clk: fix ccf_clk_get_rate
> > > >
> > > > Hi
> > > >
> > > > On Thu, Jul 25, 2024 at 9:16=E2=80=AFAM Zhiqiang Hou <Zhiqiang.Hou@=
nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > >
> > > > > As the type of return value is 'ulong', when clk_get_by_id()
> > > > > failed, it should return 0 to indicate the get_rate operation doe=
sn't
> > succeed.
> > > > >
> > > >
> > > > I understand your point here but the clk_get_rate that can call the
> > > > ccf clk_get_rate can already return -ENOSYS.
> > >
> > > will also fix it.
> > >
> >
> > Is there any usage of the error set on the latest bit of the clock? We =
need to
> > be sure that this is correct use accross the uboot. The clk-uclass defi=
ne the
> > error that can return
>
> The problem is this function's return value is 'ulong', if use the error =
set, the caller will treat it as a good value instead of a error number. Th=
ere are several APIs have the same problem.
>
> 2 methods to fix it:
> 1. keep the API's prototype, and use '0' to indicate error condition, but=
 a real '0' return value is also considered as error.
> 2. Change the return type to like 'long long int', and use a negative err=
or number to indicate error condition. Need to update the check of return v=
alue for all the callers.
>
> Any suggestion?
>

unit test suggest that error condition are evaluated so we have 32 bit
on arm of unsigned long so we can not
map all the positive clock

rate =3D clk_set_rate(clk, 80000000);
ut_asserteq(rate, -ENOSYS);

Now, can we have a clock greater then 2Ghz if yes this not work always
on 32 bit, then the macro
IS_ERR_VALUE should help on clk return

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

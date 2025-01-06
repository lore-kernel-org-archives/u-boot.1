Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0D2E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 23:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B6E8056D;
	Tue,  7 Jan 2025 00:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKjJ7wRj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA768058A; Tue,  7 Jan 2025 00:45:15 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44ECD8036D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 00:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so26103834a12.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 15:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736207113; x=1736811913; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKPnW6tJrzR1/dvhONlDw0BG/h5A1uSS3YXv8F9IW8g=;
 b=fKjJ7wRjPC7ZoipRbALf+sjRGEifdRYxkWZHDHK+eScQT7PQFt5EEktzLLKXaId9wO
 UY6ElgB52j7O5TXAEbQ6oWAVQ8cSP+SJqKn2r0YRaEEOpBmK2DGIGhkJU+uxS9UraDua
 ARJoRm6GIFE0YL4MRhsOmUR+EZWY1TiyoHiHV6QaUzUXe3T3+d4milH114ARzjkWEmTH
 U7S+/gW7oNxRuy0pRmI9SDqStDGZIxQm4B4/3U7fSz3JBzEKaw7bnVi+6hdGd7K3XVCU
 n/UmEKUCRH2jFy1f2Dc42BmWRCoEtaRUOiQ/8xN7WCD/UiwvXPBfs24RFwcwDK7DygNB
 4L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736207113; x=1736811913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKPnW6tJrzR1/dvhONlDw0BG/h5A1uSS3YXv8F9IW8g=;
 b=dFE++xa80xSFsKtxhWhldVnrz48cMKrmTtAr+FUF1lKpsEhgY80Kvu99eZqCNFi20+
 ksX84B6fAuvmeIW/M6rNKujVoFjPgbMJtLMAHZTuqgKFHGawpvBpE8OkBfKKEeJwzT4Y
 ZVK4UK7LUFI0f6ifzlUgvYX32CItC3G2XVl3xz1+cUjyatF5xurcz3kZOHNz6YU2z5fo
 5HiKtrlH6EBhwZz8mwsg4ZUorWXX+i2Q9Js8CIDXe1CqQfv4O2bNUTNhUbuWDiS/ODzp
 Uqt93XkZK80r9Ss8x177a2cT2fkHw1o0CqCx+An5LymXpS71byRC4GO4s4YzhyYTA9uR
 aYGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmXNFfJklpVfv7jGV5hydI6Ggs0zM/k+2AumqDARdFJw8aWsk2ix8r3Jfuxg+NCuX5Abi9oB4=@lists.denx.de
X-Gm-Message-State: AOJu0YwwcABcGATymMtUlg4Vl/LvwMRwlud8udPQ9tACLMXS44ryOJ69
 xqxwbLtKv+hjrJXFmDUKd0E7BbgIekUOniuINwfcjgehybF0h6WQ5r8CQHvILfZcbYYflz2aGvL
 vV8ZSsdWK3Btt4NptvVJucsTfNHc=
X-Gm-Gg: ASbGncvGlMbgJnyp00ZVnf3ylxoLnUwQ+ob/dpCKPMZYywsZK4t9qg1chXQxHzN3VX+
 KE/5dIPzoq73xvjtP4Tt4XeLvi5XUD608LOUHxf4=
X-Google-Smtp-Source: AGHT+IEnwPjd2nEclYMhKHnkPrwciqbC8qPvobDoVAOmGymCrr7u6qAf1eq7hsd996BdJ8xeIkGgWFuJXddJIaIkGkU=
X-Received: by 2002:a05:6402:4402:b0:5d6:501c:daef with SMTP id
 4fb4d7f45d1cf-5d81de2e06amr54260238a12.34.1736207112338; Mon, 06 Jan 2025
 15:45:12 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
 <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
In-Reply-To: <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 6 Jan 2025 15:45:00 -0800
X-Gm-Features: AbW1kvbTOxazFyl-jmetH84YAbbKqfLBCEdfp7af8Y248wVc-ptlaRrGHiHqvWs
Message-ID: <CAJaLiFy2FTtxgsb4N8GB8wxTsgyi=oPzSnjznsa_DRAbTSTixw@mail.gmail.com>
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
To: Simon Glass <sjg@chromium.org>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Peng & Simon,

On Mon, Jan 6, 2025 at 4:15=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Peng,
>
> On Sun, 5 Jan 2025 at 18:14, Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1
> > > EVK/QSB and i.MX8M EVK
> > >
> > > Hi Peng,
> > >
> > > On Sun, 5 Jan 2025 at 17:27, Peng Fan <peng.fan@oss.nxp.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
> > > > >Hi Peng,
> > > > >
> > > > >On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS)
> > > <peng.fan@oss.nxp.com> wrote:
> > > > >>
> > > > >> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd
> > > as fallback.
> > > > >>
> > > > [...]
> > > > >>
> > > > >
> > > > >This also switches to a text environment, great!
> > > > >
> > > > >For bsp_bootcmd is it possible to create a bootmeth for your use
> > > case?
> > > > >If you would like to take a look (separate from this series), I co=
uld
> > > > >help with any issues that come up.
> > > >
> > > > I just give a quick look of bootmeth, seems needs extlinux or
> > > > bootscript (boot.scr). But both are used on NXP i.MX release as of
> > > > now. In NXP releases, we put all script in the U-Boot ENV.
> > > >
> > > > Do you have suggestions how to move to support bootmeth.
> > >
> > > I'm not entirely sure what you are trying to do with the bootcmd,
> >
> > With a single u-boot, we want to support Fedora/SUSE/etc and NXP
> > Yocto releases.
> >
> > So add a bsp_bootcmd as fallback to run NXP Yocto releases.
> > NXP Yocto releases not have extlinux.cfg, nor boot.scr, we just
> > have simple uboot hush command in bootcmd, simplied saying:
> > run loadimage; run loadfdt; run mmcargs; booti ${loadaddr} - ${fdtaddr}
> >
> > > you could write your own bootmeth, e.g. using common code from the
> > > others. For example, bootmeth_script.c shows how to run a script and
> > > bootmeth_extlinux.c shows how to run an extlinux file. You could then
> > > create C code to perform your 'bsp' function, e.g. a new
> > > bootmeth_bsp.c.
> >
> > I will give a look, but this seems we need put the "run loadimage and e=
tc"
> > in dtb and needs bootmeth_imx.c to support it.
>
> Note that my suggestion here is as a follow-on to you current series,
> which I believe can be applied as is.
>
> Anyway, as a starting point, yes you can use run_command() lots of
> times in the bootmeth to run the things you need. From there you can
> potentially change some commands to direct calls into the U-Boot
> functionality. The idea is to be able to locate the bootflow as a
> separate thing from booting it. I am quite happy to help as well.
>

Can we call this bootmeth_internal, and have it read the internal
board/xxx/yyy/bootflow? And then this "default' bootflow can contain
the envs scripting to boot the board when all other boot methods have
failed. Of course, it can also be executed manually at command prompt
like other bootflows.

I think if we go this far to add another bootmeth, it would be nice to
make it generic so it can be used in other boards.

All the best,
Tony

> Regards,
> SImon

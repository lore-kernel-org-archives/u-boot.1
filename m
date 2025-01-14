Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA777E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 520ED805CD;
	Tue, 14 Jan 2025 14:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WTI00VJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E775580657; Tue, 14 Jan 2025 14:14:04 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C057E8022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso9735947a12.0
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736860442; x=1737465242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFCHQLCgM5n+QGIXP4vu7iZM3gIVui19wQIurFtrILM=;
 b=WTI00VJrp5jO+OwvKjhz7GteNVAwN3iGIGA+ZfeTxCw6ETwmDD/kxDUQrV/GaumlKh
 843tUI2EXkqIDhsTJ81Jpw0jbnOVwSlOQfI0Kxy5okHAXxhJ9/NOgGsm+cVUSre2Hl3H
 uaCytuHG6KinxOp2yCiGhLyAhoAI+co5VHtPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860442; x=1737465242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFCHQLCgM5n+QGIXP4vu7iZM3gIVui19wQIurFtrILM=;
 b=YwEIRKB84rxshafS3xLkYJVab7E23x1LlbNbpdNe3gv9Yb+tvjMa4+169OhSft0uwR
 US/f83aiezgqtbveREKUvdkHWEl6DlRUq0yCFvtVo7KkrdCmRmuTP78aoV5NWD35z9xN
 /WXkDvj3m/2L5avURz82c3sL+7UX2uAbtSz29igd7L9Un+yb+WdSrG61uxidMo8ROzXG
 XCj6EAfs6DGrCBfBzZUci40c2Tlu1FlkOtBPmgSRkxDGte2+ll5RgmGX1WbPxenLHwbY
 9HVdRsYCI3g2wTyEu/0OABsHzqkSIflgfA8RWHYMUjMbwbi1JfppWqCqWzwqBWfYuc61
 xmuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFczUAXUtVSGAS5SgFs/LfJxqRIjCj01+8Xw8IIfQJ9ChvLv0PkDSKJ+3RzzFJePMYV2d3lL8=@lists.denx.de
X-Gm-Message-State: AOJu0YxwRS5Q7fIdlnTW/kq/KF9t0BCA9JFAa/qE40ws99uAwn1zvh5s
 +40bOE/I//zvHhXSRaFml3UHDIfef6wjxzgceJPkxbBi2gNNLLeI7BAALlUC4ArrCIr1iJh/o2t
 HYiuRsK7lMx7IrzO4L+wh3Bt8oJU8UiFK0B4H
X-Gm-Gg: ASbGncthrxGiYvO6n5b/+Swu51BbWjeeB+NSnVz2yF92HMwDkgTofoiMQ85DZBk4LUm
 WNfH3w4SDqsSKqbnvNDXT/iMdka1O7TZduBO2V6U=
X-Google-Smtp-Source: AGHT+IEON0ODEG9jH66ObIN6wk/CZr/YjTZDhnAyoYXcbwrmJJLY9CLBx1CZQ8zOtpZ35XgLW6F5bCnPMGY/Q/3owgE=
X-Received: by 2002:a17:907:3e9e:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab2abdc0262mr2613467066b.54.1736860442125; Tue, 14 Jan 2025
 05:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
 <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
 <CAJaLiFy2FTtxgsb4N8GB8wxTsgyi=oPzSnjznsa_DRAbTSTixw@mail.gmail.com>
 <1ad10326-67e3-42f9-b8e8-b8a19781f1c9@kontron.de>
In-Reply-To: <1ad10326-67e3-42f9-b8e8-b8a19781f1c9@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jan 2025 06:13:50 -0700
X-Gm-Features: AbW1kvZBSdd_7HKqd1Bl18xP1c96DPWlq7sIcHCHwNtdBLzJPP6kFuuFkf1YyNg
Message-ID: <CAFLszThFRPexfpRf64XoPzPr+vSQN3-wA6w1hyhgudrDCyxMQw@mail.gmail.com>
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Tony Dinh <mibodhi@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, 
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

Hi Frieder,

On Mon, 13 Jan 2025 at 02:48, Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 07.01.25 12:45 AM, Tony Dinh wrote:
> > Hi Peng & Simon,
> >
> > On Mon, Jan 6, 2025 at 4:15=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >>
> >> Hi Peng,
> >>
> >> On Sun, 5 Jan 2025 at 18:14, Peng Fan <peng.fan@nxp.com> wrote:
> >>>
> >>>> Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1
> >>>> EVK/QSB and i.MX8M EVK
> >>>>
> >>>> Hi Peng,
> >>>>
> >>>> On Sun, 5 Jan 2025 at 17:27, Peng Fan <peng.fan@oss.nxp.com> wrote:
> >>>>>
> >>>>> Hi Simon,
> >>>>>
> >>>>> On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
> >>>>>> Hi Peng,
> >>>>>>
> >>>>>> On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS)
> >>>> <peng.fan@oss.nxp.com> wrote:
> >>>>>>>
> >>>>>>> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd
> >>>> as fallback.
> >>>>>>>
> >>>>> [...]
> >>>>>>>
> >>>>>>
> >>>>>> This also switches to a text environment, great!
> >>>>>>
> >>>>>> For bsp_bootcmd is it possible to create a bootmeth for your use
> >>>> case?
> >>>>>> If you would like to take a look (separate from this series), I co=
uld
> >>>>>> help with any issues that come up.
> >>>>>
> >>>>> I just give a quick look of bootmeth, seems needs extlinux or
> >>>>> bootscript (boot.scr). But both are used on NXP i.MX release as of
> >>>>> now. In NXP releases, we put all script in the U-Boot ENV.
> >>>>>
> >>>>> Do you have suggestions how to move to support bootmeth.
> >>>>
> >>>> I'm not entirely sure what you are trying to do with the bootcmd,
> >>>
> >>> With a single u-boot, we want to support Fedora/SUSE/etc and NXP
> >>> Yocto releases.
> >>>
> >>> So add a bsp_bootcmd as fallback to run NXP Yocto releases.
> >>> NXP Yocto releases not have extlinux.cfg, nor boot.scr, we just
> >>> have simple uboot hush command in bootcmd, simplied saying:
> >>> run loadimage; run loadfdt; run mmcargs; booti ${loadaddr} - ${fdtadd=
r}
> >>>
> >>>> you could write your own bootmeth, e.g. using common code from the
> >>>> others. For example, bootmeth_script.c shows how to run a script and
> >>>> bootmeth_extlinux.c shows how to run an extlinux file. You could the=
n
> >>>> create C code to perform your 'bsp' function, e.g. a new
> >>>> bootmeth_bsp.c.
> >>>
> >>> I will give a look, but this seems we need put the "run loadimage and=
 etc"
> >>> in dtb and needs bootmeth_imx.c to support it.
> >>
> >> Note that my suggestion here is as a follow-on to you current series,
> >> which I believe can be applied as is.
> >>
> >> Anyway, as a starting point, yes you can use run_command() lots of
> >> times in the bootmeth to run the things you need. From there you can
> >> potentially change some commands to direct calls into the U-Boot
> >> functionality. The idea is to be able to locate the bootflow as a
> >> separate thing from booting it. I am quite happy to help as well.
> >>
> >
> > Can we call this bootmeth_internal, and have it read the internal
> > board/xxx/yyy/bootflow? And then this "default' bootflow can contain
> > the envs scripting to boot the board when all other boot methods have
> > failed. Of course, it can also be executed manually at command prompt
> > like other bootflows.
> >
> > I think if we go this far to add another bootmeth, it would be nice to
> > make it generic so it can be used in other boards.
>
> I agree that a generic bootmeth would be really helpful. We would like
> to have some simple A/B boot mechanism (using RAUC) and I think
> implementing it as bootmeth and sharing it across different platforms
> and boards is better than implementing it in the env for each board/vendo=
r.

I am hoping that VBE's abrec will land before too long. That is
programmatic. Fwupd only supports VBE-simple at present but I plan to
add support for that in the middle of the year.

Regards,
Simon

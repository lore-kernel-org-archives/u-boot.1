Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13314E77197
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 01:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37902803DC;
	Mon,  6 Jan 2025 02:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gJn5L/17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55CC8056D; Mon,  6 Jan 2025 02:02:33 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F41C801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 02:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so2252799966b.3
 for <u-boot@lists.denx.de>; Sun, 05 Jan 2025 17:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736125351; x=1736730151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d/z9BDYv20nXAeLfVtF339e7zAlWeX4rKtqs8Xyld5w=;
 b=gJn5L/17u6uWPVxYz+mPH7HVhxhBzlIAt6xDWPktbPmz4aBQOFOKIzKHJkOEQ/zdOX
 ZX5hU8E1+UajQtlhgaMrMxgIBbwOhYObD1yjMR/mUm8FKSwTF3MieNf2YkhM5dflPQwF
 PwQ34peIQfMfbOuVN8artum3M4M9FNEDMItiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736125351; x=1736730151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/z9BDYv20nXAeLfVtF339e7zAlWeX4rKtqs8Xyld5w=;
 b=nBfoDpxG3fUkZl2Xef/4AmHfGBsQOl48nYtumDsy1rjoLXyzc49Y2HpalNrGTmwE1q
 nv9QYpO9VbMYFOp2VN6ziCVddGesH5RSKxpBFu4OWZhK1T7jEHFP468AOBCFifz0jlEW
 wZQaQlTE4d2ivmeb0SSJW15NL3Pl7v+HxNSXcr8BnX399gv7niWcCM/Mk52WJFRF14TO
 4gncUcMZsBouknDprrkqpi4hppsGhNKWnbFzzEbgpv0assaXBnPFe/3r0Xuj2yBktFkD
 jlU2oioUsLHrGARhVZ77Z8Sol3RhbNXE4cV1wj/t3lO9QMbzbeAjsm+7YMBaVrwnr/ni
 qU7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfF5AttL9v+inmY9GIebDQPhGB/pcfDcnFcthgAhrnFJeLrk8HtEzvzoteXXJPfCnGXc8RQRM=@lists.denx.de
X-Gm-Message-State: AOJu0YwgSenNAeS8vWZ4pZgSItwO6ZkAXylA1UVkdoUsUfaBbNRWeMqu
 uycMQXsUWnSI2G+9ueGL6p3Dw8YA6vKlXOLjbEJvLvNOSlHaX096YM6G81nHTsb3Nc4dqJL5yzw
 ZwzIEGYK8Zr+lcWpNTgP+oRlAYiymgjc+3cA5
X-Gm-Gg: ASbGncvmKeX34DcPID1t2C/CnvmxX6a/2AonDSBGZ/JuKp0lPavv/7pttP3UkOEqEH9
 zvWpcB2H5SFpThdz7oL35KcYTyVmpQ2JTcD5TecY=
X-Google-Smtp-Source: AGHT+IGoKlFXImKpDrDn4niGOPOJdz9W6dAxnwUvvz7imrGZYUXS0cgfJTG5twuVbv3Jr9Zx/nNlggGuf8AbtUEVCfk=
X-Received: by 2002:a17:907:9621:b0:aa6:6f92:74b1 with SMTP id
 a640c23a62f3a-aac2ad7fa01mr5325961166b.13.1736125351031; Sun, 05 Jan 2025
 17:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
In-Reply-To: <20250106013311.GA8414@localhost.localdomain>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 18:02:19 -0700
Message-ID: <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Sun, 5 Jan 2025 at 17:27, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Simon,
>
> On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
> >Hi Peng,
> >
> >On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> >>
> >> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.
> >>
> [...]
> >>
> >
> >This also switches to a text environment, great!
> >
> >For bsp_bootcmd is it possible to create a bootmeth for your use case?
> >If you would like to take a look (separate from this series), I could
> >help with any issues that come up.
>
> I just give a quick look of bootmeth, seems needs extlinux or bootscript
> (boot.scr). But both are used on NXP i.MX release as of now. In NXP
> releases, we put all script in the U-Boot ENV.
>
> Do you have suggestions how to move to support bootmeth.

I'm not entirely sure what you are trying to do with the bootcmd, but
you could write your own bootmeth, e.g. using common code from the
others. For example, bootmeth_script.c shows how to run a script and
bootmeth_extlinux.c shows how to run an extlinux file. You could then
create C code to perform your 'bsp' function, e.g. a new
bootmeth_bsp.c.

Regards,
Simonn

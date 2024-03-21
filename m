Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43ABC54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 05:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36D087D5E;
	Thu, 21 Mar 2024 06:46:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jGo9BC8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCC28657F; Thu, 21 Mar 2024 06:46:32 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1A188077
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 06:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47679ac2798so169334137.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 22:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710999988; x=1711604788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=00gKYusdCxJi28BvEZSBit8lunjQgLfVI6SbDReccos=;
 b=jGo9BC8gxRgb/0eD93wZzY6nner0OfFr+KuJcSC09a3rUG0+jY0S0gHz3GsAacaA/b
 8azqSnu9qOVXIyM6yRDUw7mU5xT2hLrh3VQB2/qO139twbgZKz7pcbsqzMLnuVZfRpqJ
 0eJ64Ypr/XrjSlT2p0vWr4Y8R0ziJ8NpPFfl63FPc2uYDKXKAtyiAEvBoGoulUjhzxGL
 02DPV0oVuUVADAJskIi+lCr3pyFxkXltyIECFiuFl/2SWXsWLlPZvrvxOehSwvRxoya6
 1NT7Qow97SgaiyYcThriAB/yJmouh0nVYASXsg1RgbXt93gqitqcauFEfr/mbbsHpSnK
 DhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710999988; x=1711604788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=00gKYusdCxJi28BvEZSBit8lunjQgLfVI6SbDReccos=;
 b=SEfs4tcLvZQ8zggfqS1BOihfUZh1lyx7cJJuWFqE8Qfpi7ukKgfGwSfkfx8zgIAs7O
 5A0RZEmFAtD6lPSU4lOtQ3Y10uNRvMo+f1FWCiVJ2E9u0A1nh183jRFcqJSosa4CzlhG
 plXeT+Jp6Ua9KKkAgkT0z5tbomozJPT6DMQC9Qo0gbpse23At51gbG4zVIqwtzxJ0sxk
 h9oCzHjE8ZU2OXedmiMDKQdcJUlkqsOSVl0Qnq1Rxnk1zVvBZZ9V8MRoSSsGhZYTzvh0
 aglPRjabazHSouWhh9CBD/ldb8hXVxoM1roUUiUOI1oKNrFJzvzRdl3ITAtBP+qpgQa5
 LPiQ==
X-Gm-Message-State: AOJu0Yz+BmjpFTwh0RY2yvd69Mr3TJP0mxA9b20Q/JUonsRScbb/XDO6
 3b3PgUrp22dWnOmNSe8G0LSXkn3CDZeEhphJlyLUYU6G1FOZcjtveX9rhtEzyf3VMXarfyXtDLb
 FWak/FzwPW0SrQiyFpFhBU1FAoTia5rG9z2bnWQ==
X-Google-Smtp-Source: AGHT+IFh0eWjp5Axj6Zn1TSJtIbIlMaZvrLsR6/8ypwteQjMHXdQz3rOKBAzfiCSrpqeyffvW/bGKWLHiIRK/8OLJB0=
X-Received: by 2002:a05:6102:21bb:b0:476:aecb:e09c with SMTP id
 i27-20020a05610221bb00b00476aecbe09cmr3084111vsb.9.1710999988347; Wed, 20 Mar
 2024 22:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
 <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
 <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
 <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
 <1d7ad0f4-2463-4b1c-9020-5444366438fb@denx.de>
In-Reply-To: <1d7ad0f4-2463-4b1c-9020-5444366438fb@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Mar 2024 11:16:17 +0530
Message-ID: <CAFA6WYOygxNUGWu3jDF7=4px5gBSoCOjzU=s+eTcH0rRFSGJUQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] imx8mp: power-domain: Don't power off pd_bus
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, fathi.boudra@linaro.org, 
 remi.duraffort@linaro.org, daniel.thompson@linaro.org
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

On Thu, 21 Mar 2024 at 11:06, Marek Vasut <marex@denx.de> wrote:
>
> On 3/15/24 11:41 AM, Sumit Garg wrote:
> > On Fri, 15 Mar 2024 at 14:53, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 3/15/24 6:31 AM, Sumit Garg wrote:
> >>> On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 3/12/24 8:03 AM, Sumit Garg wrote:
> >>>>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
> >>>>> turned off for a single peripheral domain as it would negatively affect
> >>>>> other peripheral domains. So lets just skip turning off bus power
> >>>>> domain.
> >>>>
> >>>> What exactly is the issue and how did you trigger it ?
> >>>>
> >>>> Details please.
> >>>
> >>> I suppose the issue can be triggered via the "=> usb start => usb
> >>> stop" sequence where one of the USB controllers is configured in
> >>> peripheral mode.
> >>
> >> 'usb start ; usb stop' causes no problems on MX8MP , maybe the test case
> >> is more extensive ?
> >>
> >> Please, write down the necessary steps to reproduce this problem, and
> >> what happens when that problem occurs.
> >
> > After digging in more, it looks like dev_power_domain_off() is never
> > (U-Boot life-cycle) invoked for USB controller devices derived from
> > DT. So this USB power domain sequence is never reachable.
>
> The imx8mp_hsiomix_off() is never called on 'usb stop' command ?
>

Yeah, that's the case.

> But then why would the 'usb start ; usb stop' test break power domain
> state here ?

It won't break with current implementation, earlier I made this
assumption that 'usb stop' turns down the power domain.

>
> > BTW, dev_power_domain_on() is invoked when USB controller devices are
> > added based on DT.
>
> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
> just before Linux boots .
>
> [...]
>
> >>>> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
> >>>
> >>> Sure I can do that but do you think the current approach can have any
> >>> side effects?
> >>
> >> Bus domain not getting cycled (which can leave it in some odd state),
> >> and increased power consumption if the next stage doesn't turn the
> >> domain off.
> >
> > Given above, would you like me to drop power domain off path entirely
> > here?
>
> Can the series go in without this patch ?

Okay let me drop this patch.

>
> > I think if people are concerned about power consumption then it
> > should be implemented properly in U-Boot to remove all the DT based
> > devices before passing on control to the next stage.
>
> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
> just before Linux boots (esp. at that point), so if you do not power off
> the bus domain before booting Linux, you may hand over a device which
> was not fully power cycled.

Unfortunately that's the current situation I see. IMO, the better
solution would be to just remove all the DT devices before passing on
control to Linux. That should automatically power off devices.

>
> And sorry for the delay, I was a bit busy.

No worries.

-Sumit

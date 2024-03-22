Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C0C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 04:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B88888154;
	Fri, 22 Mar 2024 05:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nIjNSxZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8B587EF7; Fri, 22 Mar 2024 05:56:09 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F192188013
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 05:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-476588b3c3eso570277137.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711083364; x=1711688164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GLslr8SASci3q82v8QtO2X4vxz0L7OvW4VnQjjLWomw=;
 b=nIjNSxZL/EkJm1l1hHNn/CwRSrMcqtrJHmRF1Fa8NvUVtfWmpgNJk6+IGcd76ICM51
 nUnQ4lDESJLAJilgcGxeUS5DgIWc83ElA8H+QuDzLKwD4qNvPgBDtLSfEizzlZ2uvui3
 Z1iicQGoKk8UQ7UD4wHkd4flVwZfyVKtJcUA7XfzQ2oe/yLhpLnCaBJOf2el+4AkhIBC
 mA9hzWuBqLNSPIp9lJ3w/ooFWL92YWHsHe7anNoEcMJOszYmx71CBLy51A6LOWrvlx3o
 1qwDaEiayGJjGD6iM/JwyvI+SAKj4wuTXrftaLRWEBlasd9wJ/PDWiJlwpZcFI2nGw9k
 BAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711083364; x=1711688164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLslr8SASci3q82v8QtO2X4vxz0L7OvW4VnQjjLWomw=;
 b=djuNhNtBm5oSt7ZtDpZ/P2Mct1ivnIXHMONNdQ1ShdqCSxYYT7bWC8NRLdcq855r9T
 xE/9PhtoNzx8XeKybyFhzjfHMNvfX6EIofpIc52cevED4Bhg4jVoSAZFmrExkzO1STxN
 SjvOhhTk+3/tRdXqhAKUuS57imNKLSHJKb7RfBqRhle9LzvOIGCkUgqpzKnJMLIuWCV5
 rpNqp8Q3iryq65xIht9SPpOwuzd4EXCGoJMxg0M+CgegljlxoxmlDxFcPDF2O/JZU9ky
 drWesbVdVPiIWK5WBQhWyAx0gmiYjJI48tnUCEp9XMK3BxKjMQhNYXStqtw7BbMPUTiE
 Y+1A==
X-Gm-Message-State: AOJu0YyOhoEDQJDQDziyLhAo9MT3WIcK98dgk5ceq+6Rw1iaU83AFyID
 BSutK4Ul8Ijk7HbpJFODTCfin3wROBgyqhoDvVsIRkWEFRpithR89BgTWsmvU5JdNPJPsG52ZS0
 s7GpH98SLMMxXX9r5QiPZDjkfIlrYLdWINuHJdg==
X-Google-Smtp-Source: AGHT+IESEzRVKY0DhTOfDKVrjnxYAyMta2+y5zWm+sqKfzIrzLxkWnOvSsluV2tJytf3yn5K/kvViXgeDwNavReF8M0=
X-Received: by 2002:a05:6102:3979:b0:472:990d:84a with SMTP id
 ho25-20020a056102397900b00472990d084amr1669145vsb.20.1711083364516; Thu, 21
 Mar 2024 21:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-5-sumit.garg@linaro.org>
 <dbd4f385-d93f-48db-a7e9-88b86f3d7445@denx.de>
 <CAFA6WYO8k=qyexUSRs_X-YMtKZTAzM5ZeSCNEO+sJ7z91z7ohg@mail.gmail.com>
 <f789292a-7c46-4b98-935f-86bfea39ab05@denx.de>
 <CAFA6WYPHqdWiL=8foFDD9Rs+_L+E-=D+VMC=FZrnKeQdcooNMQ@mail.gmail.com>
 <1d7ad0f4-2463-4b1c-9020-5444366438fb@denx.de>
 <CAFA6WYOygxNUGWu3jDF7=4px5gBSoCOjzU=s+eTcH0rRFSGJUQ@mail.gmail.com>
 <09b0dbae-208b-439a-bb75-a79902522eed@denx.de>
In-Reply-To: <09b0dbae-208b-439a-bb75-a79902522eed@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Mar 2024 10:25:53 +0530
Message-ID: <CAFA6WYNcfQ6Szb81thXJDYUd1GEF7zcdnAAuZCiSagYBzbAqvQ@mail.gmail.com>
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

On Fri, 22 Mar 2024 at 00:47, Marek Vasut <marex@denx.de> wrote:
>
> On 3/21/24 6:46 AM, Sumit Garg wrote:
> > On Thu, 21 Mar 2024 at 11:06, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 3/15/24 11:41 AM, Sumit Garg wrote:
> >>> On Fri, 15 Mar 2024 at 14:53, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> On 3/15/24 6:31 AM, Sumit Garg wrote:
> >>>>> On Thu, 14 Mar 2024 at 09:45, Marek Vasut <marex@denx.de> wrote:
> >>>>>>
> >>>>>> On 3/12/24 8:03 AM, Sumit Garg wrote:
> >>>>>>> power_domain_on/off() isn't refcounted and power domain bus shouldn't be
> >>>>>>> turned off for a single peripheral domain as it would negatively affect
> >>>>>>> other peripheral domains. So lets just skip turning off bus power
> >>>>>>> domain.
> >>>>>>
> >>>>>> What exactly is the issue and how did you trigger it ?
> >>>>>>
> >>>>>> Details please.
> >>>>>
> >>>>> I suppose the issue can be triggered via the "=> usb start => usb
> >>>>> stop" sequence where one of the USB controllers is configured in
> >>>>> peripheral mode.
> >>>>
> >>>> 'usb start ; usb stop' causes no problems on MX8MP , maybe the test case
> >>>> is more extensive ?
> >>>>
> >>>> Please, write down the necessary steps to reproduce this problem, and
> >>>> what happens when that problem occurs.
> >>>
> >>> After digging in more, it looks like dev_power_domain_off() is never
> >>> (U-Boot life-cycle) invoked for USB controller devices derived from
> >>> DT. So this USB power domain sequence is never reachable.
> >>
> >> The imx8mp_hsiomix_off() is never called on 'usb stop' command ?
> >>
> >
> > Yeah, that's the case.
> >
> >> But then why would the 'usb start ; usb stop' test break power domain
> >> state here ?
> >
> > It won't break with current implementation, earlier I made this
> > assumption that 'usb stop' turns down the power domain.
>
> So, maybe I am a little confused, what is this patch solving then ?
>

It isn't actually solving anything since there isn't a need for
refcount for PD bus since power domain off isn't exercised during the
lifecycle of U-Boot. Hence, I dropped it.

> >>> BTW, dev_power_domain_on() is invoked when USB controller devices are
> >>> added based on DT.
> >>
> >> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
> >> just before Linux boots .
> >>
> >> [...]
> >>
> >>>>>> Why not add counter into imx8mp_hsiomix_priv structure in this driver ?
> >>>>>
> >>>>> Sure I can do that but do you think the current approach can have any
> >>>>> side effects?
> >>>>
> >>>> Bus domain not getting cycled (which can leave it in some odd state),
> >>>> and increased power consumption if the next stage doesn't turn the
> >>>> domain off.
> >>>
> >>> Given above, would you like me to drop power domain off path entirely
> >>> here?
> >>
> >> Can the series go in without this patch ?
> >
> > Okay let me drop this patch.
>
> We can fix whatever it is that needs to be fixed in a smaller follow up
> series.

Sure, see below.

>
> >>> I think if people are concerned about power consumption then it
> >>> should be implemented properly in U-Boot to remove all the DT based
> >>> devices before passing on control to the next stage.
> >>
> >> I would expect imx8mp_hsiomix_off() to be called either on 'usb stop' or
> >> just before Linux boots (esp. at that point), so if you do not power off
> >> the bus domain before booting Linux, you may hand over a device which
> >> was not fully power cycled.
> >
> > Unfortunately that's the current situation I see. IMO, the better
> > solution would be to just remove all the DT devices before passing on
> > control to Linux. That should automatically power off devices.
>
> Doesn't CONFIG_DM_DEVICE_REMOVE=y do something like that already ?

I just did simple experiment via following diff:

diff --git a/drivers/power/domain/imx8mp-hsiomix.c
b/drivers/power/domain/imx8mp-hsiomix.c
index 6188a04c45e..0ddcd39923a 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -101,6 +101,7 @@ static int imx8mp_hsiomix_set(struct power_domain
*power_domain, bool power_on)
                if (gpr_reg0_bits)
                        setbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);
        } else {
+               while(1);
                if (gpr_reg0_bits)
                        clrbits_le32(priv->base + GPR_REG0, gpr_reg0_bits);

The boot doesn't hang suggesting that CONFIG_DM_DEVICE_REMOVE=y isn't
effective to remove any DT devices. It can for sure be another
followup series to make it effective.

-Sumit

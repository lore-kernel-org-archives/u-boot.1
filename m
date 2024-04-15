Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5012CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2DC87D40;
	Mon, 15 Apr 2024 13:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="SfuP8oFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EE687CB7; Mon, 15 Apr 2024 13:14:11 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7877687D40
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713179648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sndTHYFDt1sF7J7q5us8X2o2B6LhLlopImXQ1fmeFEU=;
 b=SfuP8oFUO9IoME/iesVQWos5Yj8eQmM6p/td8NM3EOc4yOAHwCdIvG1Yc8LysRn0XKTvQI
 Y2Dydy+RnXfH4XaWomjgnsw/3mhW3mrnLss13WReO/JdsNgoGEuRnpzEc/HxrAMzm04iAG
 S0h6gTQK37m9sjGGkdXS6BaOyIohBNp3A6nXUEHnPRPoTxT9UnXTilHU4rpu6iu+r5b8pX
 X4qpNPy9AO5rivmzLONulKMJlPlKm/xW0W6TH8VBGQeN5+mrdPkjbFYiI8P+Zvu5H7A8C3
 KGVpzh+nzumw+AGflNBbosVkixm/D6bSwXFXOkxCG3dqUpLZ4OONTJeJDDeQOQ==
Date: Mon, 15 Apr 2024 13:14:07 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, marex@denx.de,
 trini@konsulko.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com, mkorpershoek@baylibre.com, peter@korsgaard.com,
 sjg@chromium.org, neil.armstrong@linaro.org, u-boot@lists.denx.de,
 j.beck@linefinity.com
Subject: Re: [PATCH] usb: dwc3-generic: fix support without DM_REGULATOR
In-Reply-To: <CA+HBbNH=UGLY63-bSoNmmV7ZBkt2zkbS0sdqbTLTmqikzhrb_g@mail.gmail.com>
References: <20240415105405.432679-1-robert.marko@sartura.hr>
 <a2ea41b8-8656-4734-8594-c1d38a30e25e@linaro.org>
 <CA+HBbNH=UGLY63-bSoNmmV7ZBkt2zkbS0sdqbTLTmqikzhrb_g@mail.gmail.com>
Message-ID: <85a712c7afa962b227d16a2fced6f57c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello all,

On 2024-04-15 13:11, Robert Marko wrote:
> On Mon, Apr 15, 2024 at 12:57 PM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>> 
>> On 15/04/2024 11:53, Robert Marko wrote:
>> > Recent addition of vbus-supply support has broke platform which dont use
>> > controllable regulators for USB.
>> >
>> > Issue is that even withou DM_REGULATOR being enabled regulator related
>> > functions will still build as there is a stub in regulator.h but they will
>> > simply return -ENOSYS which will then make dwc3_generic_host_probe()
>> > return the same error thus breaking probe.
>> 
>> Rather than stubbing out the code, could you check for -ENOSYS and
>> ignore the error in that case? I believe there's only one place where
>> this matters (marked below).
> 
> Sure, that was my first approach but it did not seem right to me.
> But if its OK with you, I can do that.

FWIW, ifdef'ing the code out seems like a cleaner approach to me.

>> > Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus regulator")
>> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>> > ---
>> >  drivers/usb/dwc3/dwc3-generic.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>> > index 7a00529a2a..784d3ec2ed 100644
>> > --- a/drivers/usb/dwc3/dwc3-generic.c
>> > +++ b/drivers/usb/dwc3/dwc3-generic.c
>> > @@ -242,6 +242,7 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>> >       if (rc)
>> >               return rc;
>> >
>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> >       rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_supply);
>> >       if (rc)
>> >               debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>> > @@ -250,14 +251,17 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>> >       rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>> >       if (rc)
>> >               return rc;
>> 
>> Here, if (rc && rc != -ENOSYS)
>> or even if (CONFIG_IS_ENABLED(DM_REGULATOR) && rc) to be verbose 
>> (maybe
>> not the preferred style though).
>> 
>> All the other regulator_* calls either ignore the result or only print 
>> a
>> debug message.
>> > +#endif
>> >
>> >       hccr = (struct xhci_hccr *)priv->gen_priv.base;
>> >       hcor = (struct xhci_hcor *)(priv->gen_priv.base +
>> >                       HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
>> >
>> >       rc = xhci_register(dev, hccr, hcor);
>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> >       if (rc)
>> >               regulator_set_enable_if_allowed(priv->vbus_supply, false);
>> > +#endif
>> >
>> >       return rc;
>> >  }
>> > @@ -265,14 +269,18 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>> >  static int dwc3_generic_host_remove(struct udevice *dev)
>> >  {
>> >       struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> >       int rc;
>> > +#endif
>> >
>> >       /* This function always returns 0 */
>> >       xhci_deregister(dev);
>> >
>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>> >       rc = regulator_set_enable_if_allowed(priv->vbus_supply, false);
>> >       if (rc)
>> >               debug("%s: Failed to disable vbus regulator: %d\n", dev->name, rc);
>> > +#endif
>> >
>> >       return dwc3_generic_remove(dev, &priv->gen_priv);
>> >  }
>> 
>> --
>> // Caleb (they/them)

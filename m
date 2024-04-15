Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81173C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025F487F1F;
	Mon, 15 Apr 2024 13:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="LheVx1Fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C20E87E83; Mon, 15 Apr 2024 13:36:46 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C34A88132
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713181003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RntUY9i7cXRP48x3je+pyCJ/ZbGFqRbqfPuWmDldDcU=;
 b=LheVx1FvEf7v57hrW56+Vs4krxGYEJcoF7Ny/U+t4cTL1gnGoNAKSBDBbLWPvJk3Hkwyaw
 hAdqin12M6232nPblZ2PYC37jkaWhpX0CXUA/gZ/gthaEI1G7RjFR97R+9qK8oVWvBmxZJ
 KzX/vWarA7aifGDolDcJ5TelZlP2MdaqB/TpEkhhkfukBLXUtO79j/VQyT8QY50/hHERwu
 l5Y4pUvtAx4dQ81NuY0tsGFFJp7ZnXQJuZ8bg6rRaXNt/NUbi4lro2dFFwjHB85RhyoOBT
 aDAB8dH6Kc+Ha4vpV6UdlrSMUD86reQA8Ry4vc3h2iVKJHi9meWYhN2fKNY1zA==
Date: Mon, 15 Apr 2024 13:36:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Robert Marko <robert.marko@sartura.hr>, marex@denx.de,
 trini@konsulko.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 jagan@amarulasolutions.com, mkorpershoek@baylibre.com, peter@korsgaard.com,
 sjg@chromium.org, neil.armstrong@linaro.org, u-boot@lists.denx.de,
 j.beck@linefinity.com
Subject: Re: [PATCH] usb: dwc3-generic: fix support without DM_REGULATOR
In-Reply-To: <ed463461-2e96-462f-8b43-1e6ca4aad7a3@linaro.org>
References: <20240415105405.432679-1-robert.marko@sartura.hr>
 <a2ea41b8-8656-4734-8594-c1d38a30e25e@linaro.org>
 <CA+HBbNH=UGLY63-bSoNmmV7ZBkt2zkbS0sdqbTLTmqikzhrb_g@mail.gmail.com>
 <85a712c7afa962b227d16a2fced6f57c@manjaro.org>
 <ed463461-2e96-462f-8b43-1e6ca4aad7a3@linaro.org>
Message-ID: <9af69d78a50999d05ed5838414d70944@manjaro.org>
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

Hello Caleb,

On 2024-04-15 13:18, Caleb Connolly wrote:
> On 15/04/2024 12:14, Dragan Simic wrote:
>> Hello all,
>> 
>> On 2024-04-15 13:11, Robert Marko wrote:
>>> On Mon, Apr 15, 2024 at 12:57 PM Caleb Connolly
>>> <caleb.connolly@linaro.org> wrote:
>>>> 
>>>> On 15/04/2024 11:53, Robert Marko wrote:
>>>> > Recent addition of vbus-supply support has broke platform which
>>>> dont use
>>>> > controllable regulators for USB.
>>>> >
>>>> > Issue is that even withou DM_REGULATOR being enabled regulator related
>>>> > functions will still build as there is a stub in regulator.h but
>>>> they will
>>>> > simply return -ENOSYS which will then make dwc3_generic_host_probe()
>>>> > return the same error thus breaking probe.
>>>> 
>>>> Rather than stubbing out the code, could you check for -ENOSYS and
>>>> ignore the error in that case? I believe there's only one place 
>>>> where
>>>> this matters (marked below).
>>> 
>>> Sure, that was my first approach but it did not seem right to me.
>>> But if its OK with you, I can do that.
>> 
>> FWIW, ifdef'ing the code out seems like a cleaner approach to me.
> 
> Given that the stub functions exist, imho it makes sense to use them.
> It's also easy to forget to add those #ifdefs if there are other
> regulator changes in future patches.
> 
> But overall I don't feel too strongly about this, for what it does this
> code is fine, I'll defer to Marek.

Oh, sorry, I totally failed to notice that the stubs already exist
for the regulator_set_enable_if_allowed() function and its friends,
which are actually ifdef'ed code.  Having that in mind, I agree that
introducing more ifdef's isn't the preferred way to go.

Maybe there's something awkward about the stubs and the way they
need to be used, but that should be resolved by improving the whole
stubs thing, instead of introducing more ifdef's in the code that
ends up using the stubs.

>>>> > Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>>>> regulator")
>>>> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> > ---
>>>> >  drivers/usb/dwc3/dwc3-generic.c | 8 ++++++++
>>>> >  1 file changed, 8 insertions(+)
>>>> >
>>>> > diff --git a/drivers/usb/dwc3/dwc3-generic.c
>>>> b/drivers/usb/dwc3/dwc3-generic.c
>>>> > index 7a00529a2a..784d3ec2ed 100644
>>>> > --- a/drivers/usb/dwc3/dwc3-generic.c
>>>> > +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>> > @@ -242,6 +242,7 @@ static int dwc3_generic_host_probe(struct
>>>> udevice *dev)
>>>> >       if (rc)
>>>> >               return rc;
>>>> >
>>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>>> >       rc = device_get_supply_regulator(dev, "vbus-supply",
>>>> &priv->vbus_supply);
>>>> >       if (rc)
>>>> >               debug("%s: No vbus regulator found: %d\n", dev->name,
>>>> rc);
>>>> > @@ -250,14 +251,17 @@ static int dwc3_generic_host_probe(struct
>>>> udevice *dev)
>>>> >       rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>>>> >       if (rc)
>>>> >               return rc;
>>>> 
>>>> Here, if (rc && rc != -ENOSYS)
>>>> or even if (CONFIG_IS_ENABLED(DM_REGULATOR) && rc) to be verbose 
>>>> (maybe
>>>> not the preferred style though).
>>>> 
>>>> All the other regulator_* calls either ignore the result or only 
>>>> print a
>>>> debug message.
>>>> > +#endif
>>>> >
>>>> >       hccr = (struct xhci_hccr *)priv->gen_priv.base;
>>>> >       hcor = (struct xhci_hcor *)(priv->gen_priv.base +
>>>> >                       HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
>>>> >
>>>> >       rc = xhci_register(dev, hccr, hcor);
>>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>>> >       if (rc)
>>>> >               regulator_set_enable_if_allowed(priv->vbus_supply,
>>>> false);
>>>> > +#endif
>>>> >
>>>> >       return rc;
>>>> >  }
>>>> > @@ -265,14 +269,18 @@ static int dwc3_generic_host_probe(struct
>>>> udevice *dev)
>>>> >  static int dwc3_generic_host_remove(struct udevice *dev)
>>>> >  {
>>>> >       struct dwc3_generic_host_priv *priv = dev_get_priv(dev);
>>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>>> >       int rc;
>>>> > +#endif
>>>> >
>>>> >       /* This function always returns 0 */
>>>> >       xhci_deregister(dev);
>>>> >
>>>> > +#if CONFIG_IS_ENABLED(DM_REGULATOR)
>>>> >       rc = regulator_set_enable_if_allowed(priv->vbus_supply, false);
>>>> >       if (rc)
>>>> >               debug("%s: Failed to disable vbus regulator: %d\n",
>>>> dev->name, rc);
>>>> > +#endif
>>>> >
>>>> >       return dwc3_generic_remove(dev, &priv->gen_priv);
>>>> >  }
>>>> 
>>>> --
>>>> // Caleb (they/them)

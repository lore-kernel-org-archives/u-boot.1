Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE9DD4899E
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 13:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C7982BF2;
	Fri, 16 Jan 2026 14:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="QKZbh5bJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB1468309A; Fri, 16 Jan 2026 14:42:20 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752D580077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 2E87126277;
 Fri, 16 Jan 2026 14:42:18 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GWh3MzTTxvpc; Fri, 16 Jan 2026 14:42:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1768570937; bh=f0fCdEPDH3GmWZUSRJDDUfPI3IT/FVbONz+UaueXGx4=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=QKZbh5bJwMeeQ5mwEn4vJWpQsRsaiXOPQpWb58BGQw0WWQzJNPJUSglaAMBRXt5YV
 Yy4xPIXgmMrnrk1gkOR1E+/ut412qJqRs+Mvdg4QTFq6XhKOxwNWBpuG53vFDKnQbd
 SqU4xN8DB3QU0pyMpl1izV/tLrGEwvxTYSBaZXQkXiT1FU5OsiQ1mwJWDroM0EtSNg
 UK5lkKwW6Qy/mUkAhXFg6ncWCCZoTXdEenH7LavSpXXQsX1c9f3IuYzsfu93RVnL/i
 MboaVsx7q+AqMeNcsbsNVWWA8SjG1E0/kspuvodl+/ItvLHXRJ2NL5XbfHIQdIMNq2
 B3c/pnSBE8Z/w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 19:12:07 +0530
Message-Id: <DFQ22JXT2KP3.2U4ZGBQM3RYRV@disroot.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3-generic: allow fallback of dr_mode
 property to "otg"
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, <u-boot@lists.denx.de>
Cc: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Marek Vasut"
 <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Kever Yang"
 <kever.yang@rock-chips.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Marek Vasut" <marek.vasut@mailbox.org>,
 "Casey Connolly" <casey.connolly@linaro.org>
References: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
 <20260108-usb-dwc3-exynos7870-v3-1-343fa1e81e48@disroot.org>
 <874iolenzq.fsf@kernel.org>
In-Reply-To: <874iolenzq.fsf@kernel.org>
X-Mailman-Approved-At: Fri, 16 Jan 2026 14:48:43 +0100
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

On 2026-01-16 13:33 +01:00, Mattijs Korpershoek wrote:
> Hi Kaustabh,
>
> Thank you for the patch.
>
> On Thu, Jan 08, 2026 at 18:03, Kaustabh Chakraborty <kauschluss@disroot.o=
rg> wrote:
>
>> Documentation [1] states that the default value of the dr_mode property
>> is "otg". It also isn't marked a mandatory node, so it may or may not be
>> set. So, accordingly if dr_mode is not mentioned in the devicetree node,
>> OTG mode must be assumed.
>>
>> In this driver however, this case is not handled. If dr_mode is not
>> mentioned, USB_DR_MODE_UNKNOWN is set. The logic implemented raises an
>> error, instead of falling back to USB_DR_MODE_OTG. Correct this to
>> conform to the specification.
>>
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git/tree/Bindings/usb/usb-drd.yaml?h=3Dv6.18-dts [1]
>> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Thanks for your insight, but isn't this patch applied? This has been
merged into u-boot/master already. But I don't see it in next.
Confusing.

>
> Note: there is a similar patch submitted by Casey here:
> https://lore.kernel.org/all/20260114-casey-usb-role-switch-v1-1-fb7a62646=
6b9@linaro.org/
>
> Can you have a look at that one please? You could review it or test it
> to see if it works for you?

This patch addresses a single point of failure, unlike mine.

>
> Thanks!
> Mattijs
>
>> ---
>>  drivers/usb/dwc3/dwc3-generic.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-gen=
eric.c
>> index c09014aec60..c15eda19e8f 100644
>> --- a/drivers/usb/dwc3/dwc3-generic.c
>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>> @@ -10,6 +10,7 @@
>>  #include <dm.h>
>>  #include <reset.h>
>>  #include <asm/gpio.h>
>> +#include <dm/device_compat.h>
>>  #include <dm/lists.h>
>>  #include <linux/delay.h>
>>  #include <linux/usb/gadget.h>
>> @@ -173,8 +174,8 @@ static int dwc3_generic_of_to_plat(struct udevice *d=
ev)
>>  		node =3D dev_ofnode(dev->parent);
>>  		plat->dr_mode =3D usb_get_dr_mode(node);
>>  		if (plat->dr_mode =3D=3D USB_DR_MODE_UNKNOWN) {
>> -			pr_err("Invalid usb mode setup\n");
>> -			return -ENODEV;
>> +			dev_info(dev, "No USB mode specified. Using 'otg'\n");
>> +			plat->dr_mode =3D USB_DR_MODE_OTG;
>>  		}
>>  	}
>> =20
>> @@ -516,6 +517,10 @@ static int dwc3_glue_bind_common(struct udevice *pa=
rent, ofnode node)
>>  	if (!dr_mode)
>>  		dr_mode =3D usb_get_dr_mode(node);
>> =20
>> +	/* usb mode must fallback to peripheral if not known */
>> +	if (dr_mode =3D=3D USB_DR_MODE_UNKNOWN)
>> +		dr_mode =3D USB_DR_MODE_OTG;
>> +
>>  	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>>  	    (dr_mode =3D=3D USB_DR_MODE_PERIPHERAL || dr_mode =3D=3D USB_DR_MO=
DE_OTG)) {
>>  		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
>>
>> --=20
>> 2.52.0


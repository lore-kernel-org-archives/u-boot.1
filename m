Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A18C982C7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 15:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D12FD82BF2;
	Fri, 16 Jan 2026 16:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="adFSvk+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AAC58003E; Fri, 16 Jan 2026 16:16:36 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94541838A5
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 16:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 66A7560160;
 Fri, 16 Jan 2026 15:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF0CC116C6;
 Fri, 16 Jan 2026 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768576592;
 bh=1qMtIDd3lxYbXNFy4keH2SWnZqaJd6wGvEbSV00O1mk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=adFSvk+dfGimyYsE6ls9BNQtXT4WUPfvTOcFeITQSAjeGPmew3TGqanbYrozDG4x7
 euTkXR3mw+AOrgjq1agloFZkrilaAGPuoeA5HPwa2a77srH8UJxS4IN+E2I9hEPOpb
 /3Ow4rHDSWCQlPQwhVt6eyL+RULCnC7qUKOYb7QWGBzFS9Nbew6rWwbFVv2c3c5RrF
 rO/NIqVTrTWjIcPzuykmf5+Dk66aiGtYlS6IrW7RLHpAUQ2y9eo5KMmScdvGxflDhG
 uhBEY51h9E5kD3C5YHcLg3seAQQHxsCY2yiMXjLcqAIsLA0sgAWD3ElL1D8YbDRM8L
 Ibk2cOei3X5FQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Kaustabh Chakraborty <kauschluss@disroot.org>,
 u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marex@denx.de>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Marek Vasut <marek.vasut@mailbox.org>, Casey
 Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v3 1/2] usb: dwc3-generic: allow fallback of dr_mode
 property to "otg"
In-Reply-To: <DFQ22JXT2KP3.2U4ZGBQM3RYRV@disroot.org>
References: <20260108-usb-dwc3-exynos7870-v3-0-343fa1e81e48@disroot.org>
 <20260108-usb-dwc3-exynos7870-v3-1-343fa1e81e48@disroot.org>
 <874iolenzq.fsf@kernel.org> <DFQ22JXT2KP3.2U4ZGBQM3RYRV@disroot.org>
Date: Fri, 16 Jan 2026 16:16:29 +0100
Message-ID: <87pl79d1v6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jan 16, 2026 at 19:12, "Kaustabh Chakraborty" <kauschluss@disroot.org> wrote:

> On 2026-01-16 13:33 +01:00, Mattijs Korpershoek wrote:
>> Hi Kaustabh,
>>
>> Thank you for the patch.
>>
>> On Thu, Jan 08, 2026 at 18:03, Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
>>
>>> Documentation [1] states that the default value of the dr_mode property
>>> is "otg". It also isn't marked a mandatory node, so it may or may not be
>>> set. So, accordingly if dr_mode is not mentioned in the devicetree node,
>>> OTG mode must be assumed.
>>>
>>> In this driver however, this case is not handled. If dr_mode is not
>>> mentioned, USB_DR_MODE_UNKNOWN is set. The logic implemented raises an
>>> error, instead of falling back to USB_DR_MODE_OTG. Correct this to
>>> conform to the specification.
>>>
>>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/tree/Bindings/usb/usb-drd.yaml?h=v6.18-dts [1]
>>> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
>>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> Thanks for your insight, but isn't this patch applied? This has been
> merged into u-boot/master already. But I don't see it in next.
> Confusing.

You are right. This patch was already applied. I usually check for an
email that states that the patch was applied but I forgot Marek usually
does not send those.
Sorry about that, I generated un-necessary noise.

It's normal that your patch has only be applied into u-boot/master.

Right now, we are in the U-Boot merge window. During this time, the next
branch is closed. All development and fixes go into master directly.

See:
https://docs.u-boot.org/en/latest/develop/release_cycle.html#current-status
https://docs.u-boot.org/en/latest/develop/process.html#management-summary

Hope that clears out the confusion.

>
>>
>> Note: there is a similar patch submitted by Casey here:
>> https://lore.kernel.org/all/20260114-casey-usb-role-switch-v1-1-fb7a626466b9@linaro.org/
>>
>> Can you have a look at that one please? You could review it or test it
>> to see if it works for you?
>
> This patch addresses a single point of failure, unlike mine.
>
>>
>> Thanks!
>> Mattijs
>>
>>> ---
>>>  drivers/usb/dwc3/dwc3-generic.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
>>> index c09014aec60..c15eda19e8f 100644
>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>> @@ -10,6 +10,7 @@
>>>  #include <dm.h>
>>>  #include <reset.h>
>>>  #include <asm/gpio.h>
>>> +#include <dm/device_compat.h>
>>>  #include <dm/lists.h>
>>>  #include <linux/delay.h>
>>>  #include <linux/usb/gadget.h>
>>> @@ -173,8 +174,8 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>>>  		node = dev_ofnode(dev->parent);
>>>  		plat->dr_mode = usb_get_dr_mode(node);
>>>  		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
>>> -			pr_err("Invalid usb mode setup\n");
>>> -			return -ENODEV;
>>> +			dev_info(dev, "No USB mode specified. Using 'otg'\n");
>>> +			plat->dr_mode = USB_DR_MODE_OTG;
>>>  		}
>>>  	}
>>>  
>>> @@ -516,6 +517,10 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>>>  	if (!dr_mode)
>>>  		dr_mode = usb_get_dr_mode(node);
>>>  
>>> +	/* usb mode must fallback to peripheral if not known */
>>> +	if (dr_mode == USB_DR_MODE_UNKNOWN)
>>> +		dr_mode = USB_DR_MODE_OTG;
>>> +
>>>  	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>>>  	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
>>>  		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
>>>
>>> -- 
>>> 2.52.0

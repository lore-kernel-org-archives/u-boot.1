Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22844C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 09:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F492829E2;
	Sun, 13 Apr 2025 11:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744535744;
	bh=ElJURiHkIM8M9BrxMv3lMdb54FOBQMtPfKp5+V/mq5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cnNwxAXRVrJCaBzVrfIW6hvpCCOsBqm3ucArb5JZsq2Hrxd2NGQfUk1R+g6ZmtqXe
	 riiQs+aG/SubwCIDmiUjU2siP8uhofyvTr/kGv8gfKaXE5W9FO4GtYyIdvbiLsBM7w
	 eFvtYbYzmOyjFirvL38AyQPobkSw4RY/+uHD1we7QBOp59mtZj6V96qXvfrlPD3pp3
	 JpkLxG2ObH5MWloWCxUhBHKvYpqlGSI5mAP/1u9BKOTDDhHaHU9YsSBbowsBWdPiT2
	 2ETfufaC4AF7lZXxsSejQGtCtHszSF2Vq5uebpRV16ftHCXMtLs+NXTBlgk1a8UySv
	 fJCkpvp4+ULmQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B758C82A27; Sun, 13 Apr 2025 11:15:42 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A393829D4
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 11:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Nvp7weeP"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6759910271405; 
 Sun, 13 Apr 2025 11:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744535739; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ElJURiHkIM8M9BrxMv3lMdb54FOBQMtPfKp5+V/mq5g=;
 b=Nvp7weeP68wiHmvZlYUjj1jIRwdSG0NtyX0sC1RlfRwY+XYjycWuPDkV4kiyMVCYQYdmDJ
 xZK34SFgLLdm3mlw2AKHrOAraDl6+LcpmS//VU9EaCm9zYRJ/XdvQGu94pI6SeUL/NnXtx
 Y8dVhH9mu5+4xZcp6I0X2BI0dv+Mn/j1qRzHr3J24xGx2Ped/wOAzI4K1s9cfOBEYCtHOw
 GgB6bQbMaiz+8y1/iOyg0ibKVOVmn3DY+rnXczEa/I5Lpq0pjWvNq0F/iB/wk4Ni9p3tQr
 z6s225z59Pl1uiMnze5+36M93YVcMZlC651pdl+04nE/rtS8tFDRW87Mw3MITg==
Message-ID: <7ad7bf3f-dd0b-4cd6-8a8a-5f35922da114@denx.de>
Date: Sun, 13 Apr 2025 11:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
References: <20250319220805.219001-1-marex@denx.de>
 <87a59gdofd.fsf@baylibre.com> <20250324080315.GA6932@francesco-nb>
 <87pli6esx0.fsf@baylibre.com> <Z-FQeVtIImeHsfXs@gaggiata.pivistrello.it>
 <42f53c19-de12-45c3-9091-2e6c23d1fcd4@denx.de>
 <Z-FpUV-fwGvch4-W@gaggiata.pivistrello.it>
 <48e57653-d86a-4650-859e-1e77a6c29f4a@denx.de>
 <Z_TnLsKHod_fvDsK@gaggiata.pivistrello.it>
 <bf955296-b4fe-443a-8bf9-ead7afe57661@denx.de>
 <20250411142123.GC12707@francesco-nb>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250411142123.GC12707@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/11/25 4:21 PM, Francesco Dolcini wrote:
> On Tue, Apr 08, 2025 at 04:51:22PM +0200, Marek Vasut wrote:
>> On 4/8/25 11:06 AM, Francesco Dolcini wrote:
>>> On Mon, Mar 24, 2025 at 03:36:52PM +0100, Marek Vasut wrote:
>>>> On 3/24/25 3:16 PM, Francesco Dolcini wrote:
>>>>> On Mon, Mar 24, 2025 at 02:53:23PM +0100, Marek Vasut wrote:
>>>>>> On 3/24/25 1:30 PM, Francesco Dolcini wrote:
>>>>>>> On Mon, Mar 24, 2025 at 09:26:03AM +0100, Mattijs Korpershoek wrote:
>>>>>>>> Hi Francesco,
>>>>>>>>
>>>>>>>> On lun., mars 24, 2025 at 09:03, Francesco Dolcini <francesco@dolcini.it> wrote:
>>>>>>>>
>>>>>>>>> Hello Mattijs, Marek
>>>>>>>>>
>>>>>>>>> On Thu, Mar 20, 2025 at 10:47:02AM +0100, Mattijs Korpershoek wrote:
>>>>>>>>>> On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:
>>>>>>>>>>
>>>>>>>>>>> The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
>>>>>>>>>>> it crashes. This is a result of the previous hard-coded EP setup in
>>>>>>>>>>> drivers/usb/gadget/epautoconf.c which did special-case EP allocation
>>>>>>>>>>> for SPL builds, and which was since converted to this callback, but
>>>>>>>>>>> without the special-case EP allocation in SPL part.
>>>>>>>>>>>
>>>>>>>>>>> This reinstates the SPL part in an isolated manner, only for NXP iMX
>>>>>>>>>>> SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
>>>>>>>>>
>>>>>>>>> UUU can (and in our case is) used also on non-NXP i.MX platforms.
>>>>>>>>> What should we do?
>>>>>>>>
>>>>>>>> Do reproduce the problem (UUU tool crashes) on those platforms with
>>>>>>>> recent U-Boot versions (v2024.10+) ?
>>>>>>>
>>>>>>> Not tested, my comment is purely based on the code and the commit message.
>>>>>>> Older U-Boot versions (up to v2024.04, included) are working fine, with UUU used
>>>>>>> with TI K3 SoCs (AM69, AM62, AM62P).
>>>>>> Are you talking about the NXP UUU ?
>>>>>
>>>>> yes, it works just fine on not-NXP SoC.
>>>> Then please test if it still works, and if not, this patch needs to be
>>>> expanded to cover TI ... or apply unconditionally in SPL (sigh).
>>>
>>> I just found the time to check some logs from our CI in which we execute such a
>>> workflow.  We do use UUU only from U-Boot proper, so we are not going to be
>>> affected by this SPL specific change.
>>>
>>> However I found this error in the logs, on both a TI AM62 and an i.MX8MP
>>>
>>> ```
>>> Starting download of 40524455 bytes
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> ..........................................................................
>>> ..........................................................................
>>> ..........................................................................
>>> ..........................................................................
>>> .............
>>> downloading of 40524455 bytes finished
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> Starting download of 1675 bytes
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> downloading of 1675 bytes finished
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> Starting download of 82 bytes
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> downloading of 82 bytes finished
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
>>> ```
>>>
>>> the download is successful however, despite those error messages. Any idea? Is
>>> this related to this topic?
>> I have a feeling it is the UUU which should be fixed to not depend on the
>> ep1-in , really.
>>
>> You could however quickly try and apply the change in this patch not only to
>> SPL, but to U-Boot on your board as well, and see if those warnings
>> disappear.
> 
> So, I did a quick test and the issue is still there.
> 
> And looking better at the error now, this is about ep1in-bulk, that is
> not affected by this change at all.
> 
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 477ecd020985..55b248505de5 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1632,23 +1632,7 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
>          if (usb_endpoint_is_bulk_out(desc))
>                  return dwc3_find_ep(gadget, "ep2out");
>          if (usb_endpoint_is_int_in(desc)) {
> -               /*
> -                * Special workaround for NXP UUU tool in SPL.
> -                *
> -                * The tool excepts the interrupt-in endpoint to be ep1in,
> -                * otherwise it crashes. This is a result of the previous
> -                * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
> -                * which did special-case EP allocation for SPL builds,
> -                * and which was since converted to this callback, but
> -                * without the special-case EP allocation in SPL part.
> -                *
> -                * This reinstates the SPL part in an isolated manner,
> -                * only for NXP iMX SoCs, only for SPL builds, and only
> -                * for the ep1in interrupt-in endpoint.
> -                */
> -               if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
> -                       return dwc3_find_ep(gadget, "ep1in");
> -               return dwc3_find_ep(gadget, "ep3in");
> +               return dwc3_find_ep(gadget, "ep1in");
>          }
This should really be fixed in the UUU tool, not worked around in 
U-Boot. Can you try and see if the UUU tool can be fixed and not 
hard-code ep1 ?

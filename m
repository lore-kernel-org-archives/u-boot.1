Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD80D24468
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 03:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E45892A2;
	Fri, 11 Oct 2024 05:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728616406;
	bh=iAKrNAx/Ivh4wmGhZqO/Y88aM2omgozqeCsJeLMqXyA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N/OXoK8J2+fgPMBF/kM2cW9Oip692XNnsxO0NsHgKS3U5ZzTdyr8/DH8nDq3hhGvy
	 Ptouql7BUTLmMtKD2pK1++bk6rOTBGQtOAO1ThLCa76gJtPbx7VLO6ZUo7Ji7i5aG0
	 xnDZBeVCjs+J3y7q+tnzZ1OgmmcIWzgQ6S92t85MrZV/I5kKUHmjP5nWMaukmoVcN+
	 7oh5dEY9cbYSm18dXDDutznFidFoXsGCyDDxqT+ljpE94eULeGVy0H9sVDQX30dgID
	 /80htcnX9e46O8axJmT4ru4rUke+MFVKYt3yNy81DZXonU6E4ww1Vb9umpYZBATnBX
	 EsK37c6ABU6gw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4DC9289278;
 Fri, 11 Oct 2024 05:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728616405;
 bh=iAKrNAx/Ivh4wmGhZqO/Y88aM2omgozqeCsJeLMqXyA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=saKKdqb96LaR5ZHeayUHZlGtw9ILrc1FsODOrgCKj+qJMKlpY43KWQLTJbRDYWN6x
 cUiaXCCl9ioq1UxX5/G6ensIAV79E0GpMYj+3N/bfP9aKn+4zS6gUblTAcy8SPl2le
 dWgm4NmTpkl245rJpKb8lvURLekakigJ+oaXtn7tBh0gCliJnaK5I3JitH7OgGraNK
 bJpSl5AW+zfa/dill00TwpB1JJv7/vK0nf2V3eIasLhOGpnfrUidVer9NtX/hmpgZX
 AmTUF/eMvb20ETmL+KwPz8vV3b5O7PKYCyX3g0rNjjww+JbXxcR/89h5t7kyTdxv8v
 BH8f2Wn8iw3gg==
Message-ID: <0a2e3963-1019-41ce-9bb7-671cb74661ef@denx.de>
Date: Fri, 11 Oct 2024 05:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: fix CONFIG_DM_REGULATOR-off case
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
References: <6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com>
 <f7ba8d78-e6d9-4f44-8d49-c7f805d60c5b@linaro.org>
 <55c65001-bc56-4b48-9645-1e5f735fe06b@siemens.com>
 <c9d41382-0590-41d5-9bcf-9729bd5bf03d@linaro.org>
 <8d9f785c-2640-47d4-9639-dd0384daf1be@siemens.com>
 <8f61a744-63c1-4cf9-ab96-4aa867f10973@siemens.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8f61a744-63c1-4cf9-ab96-4aa867f10973@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/10/24 7:36 AM, Jan Kiszka wrote:
> On 30.09.24 06:54, Jan Kiszka wrote:
>> On 09.08.24 17:19, Caleb Connolly wrote:
>>>
>>>
>>> On 09/08/2024 07:19, Jan Kiszka wrote:
>>>> On 08.08.24 16:27, Caleb Connolly wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 08/08/2024 10:51, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> When DM_REGULATOR is disabled, all calls will return -ENOSYS. Account
>>>>>> for that so that targets like the IOT2050 will work again.
>>>>>>
>>>>>> Fixes: de451d5d5b6f ("usb: dwc3-generic: support external vbus
>>>>>> regulator")
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>     drivers/usb/dwc3/dwc3-generic.c | 6 +++---
>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/dwc3-generic.c
>>>>>> b/drivers/usb/dwc3/dwc3-generic.c
>>>>>> index a9ba315463c..2ab41cbae45 100644
>>>>>> --- a/drivers/usb/dwc3/dwc3-generic.c
>>>>>> +++ b/drivers/usb/dwc3/dwc3-generic.c
>>>>>> @@ -246,12 +246,12 @@ static int dwc3_generic_host_probe(struct
>>>>>> udevice *dev)
>>>>>>             return rc;
>>>>>>           rc = device_get_supply_regulator(dev, "vbus-supply",
>>>>>> &priv->vbus_supply);
>>>>>> -    if (rc)
>>>>>> +    if (rc && rc != -ENOSYS)
>>>>>>             debug("%s: No vbus regulator found: %d\n", dev->name, rc);
>>>>>>     -    /* Only returns an error if regulator is valid and failed to
>>>>>> enable due to a driver issue */
>>>>>> +    /* Does not return an error if regulator is invalid - but does so
>>>>>> when DM_REGULATOR is disabled */
>>>>>>         rc = regulator_set_enable_if_allowed(priv->vbus_supply, true);
>>>>>> -    if (rc)
>>>>>> +    if (rc && rc != -ENOSYS)
>>>>>
>>>>> regulator_set_enable_if_allowed() will return 0 if the call to
>>>>> regulator_set_enable() returns -ENOSYS
>>>>>
>>>>> Maybe it would make sense to have the stub implementation of
>>>>> regulator_set_enable_if_allowed() return 0?
>>>>>
>>>>
>>>> Possible. Would that be the only case where a stub should not return
>>>> ENOSYS? All do so far.
>>>>
>>>>> Somewhat confusing to check for -ENOSYS here imo, since it isn't really
>>>>> obvious when that would be the case.
>>>>
>>>> But that would still leave is a with a misleading message, even if it is
>>>> just a debug output. The absence of a regulator is not per se a bug to
>>>> my understanding.
>>>
>>> Ah good point.
>>>
>>> Alternatively, maybe it would be easier to gate this code block with if
>>> (CONFIG_IS_ENABLED(DM_REGULATOR)?
>>>
>>> But yeah maybe fine as is.
>>>
>>> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>>
>> Can this regression fix be merged now, or should I add that gating?
>>
> 
> This now also missed the v2024.10 release - can we please merge it now?
Sorry. Applied to usb/master .

If there is a critical patch before release, please, ping me directly if 
there is a chance it will be missed.

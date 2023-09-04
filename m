Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5595FC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EE88675B;
	Mon,  4 Sep 2023 18:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="VmyOHyH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 200A686380; Mon,  4 Sep 2023 18:21:54 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F28A86925
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=761156b540=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 384E3k4b004303; Mon, 4 Sep 2023 18:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=UWCg6vn68bRz/Tf7ThyNmhsWd7N4odO4piJvPu0eQEU=; b=Vm
 yOHyH4zQrFFBxgovtqAWQct4N9+/FlooBTXrUaUjDaakV8fMx7e7su7boAySk9kC
 xNPmn1mUfvDKV6km39cY7CSy71aae/TL7+RaVhHQwSjp24PkjyJ2rgMR8FZp2s15
 AGuah5BuDbvPDVSRAo/LOQhmdtbTfwGnrgaZ7KfO2srxeyvMxdnc2Q9/dmmzI22D
 6pkYiaZMqWh3BQyjwhT1rSTL7f9YepP8NFnR3MCrhzlYWVCSLwbmeDhw/Eb7gTPL
 FJhkeeAaA13bN6jF8NmgRZX2ebTAlnOiOuPviCK3GW+pYRBvBVnCqnc+9XZmm8mf
 GYpBE8H3D8QSIabqj9Pw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3suvd0fv8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 18:21:49 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 074C3100058;
 Mon,  4 Sep 2023 18:21:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F119E23695B;
 Mon,  4 Sep 2023 18:21:48 +0200 (CEST)
Received: from [10.201.22.39] (10.201.22.39) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 4 Sep
 2023 18:21:47 +0200
Message-ID: <0ad3304f-c0cf-3c8b-890d-8824b9987afe@foss.st.com>
Date: Mon, 4 Sep 2023 18:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] usb: check for companion controller in uclass
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>
References: <20230901095201.3874129-1-fabrice.gasnier@foss.st.com>
 <29d44f7f-ffca-d8cd-ce88-5e2fb6103ff4@denx.de>
 <9c06f5ec-c278-e00d-873f-99ef54098816@foss.st.com>
 <fef0778b-4850-fb73-9d8f-da48a6138e13@denx.de>
 <7b2d0448-d7f0-e5f8-a6eb-beb1746921f1@foss.st.com>
 <cb4278ea-1cf9-a2c5-1310-7e6419315d38@denx.de>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <cb4278ea-1cf9-a2c5-1310-7e6419315d38@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_10,2023-08-31_01,2023-05-22_02
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

On 9/4/23 15:54, Marek Vasut wrote:
> On 9/4/23 14:34, Fabrice Gasnier wrote:
>> On 9/1/23 18:00, Marek Vasut wrote:
>>> On 9/1/23 14:12, Fabrice Gasnier wrote:
>>>> On 9/1/23 12:48, Marek Vasut wrote:
>>>>> On 9/1/23 11:52, Fabrice Gasnier wrote:
>>>>>> EHCI is usually used with companion controller (like OHCI) as
>>>>>> companion
>>>>>> controller. This information on the companion is missing currently in
>>>>>> companion drivers.
>>>>>> So, if the usb-uclass isn't aware, it may scan busses in any order:
>>>>>> OHCI
>>>>>> first, then EHCI.
>>>>>> This is seen on STM32MP1 where DT probing makes the probe order to
>>>>>> occur
>>>>>> by increasing address (OHCI address < EHCI address).
>>>>>>
>>>>>> When a low speed or full-speed device is plugged in, it's not
>>>>>> detected as
>>>>>> EHCI should first detect it, and give ownership (handover) to OHCI.
>>>>>>
>>>>>> Current situation on STM32MP1 (with a low speed device plugged-in)
>>>>>> STM32MP> usb start
>>>>>> starting USB...
>>>>>> Bus usb@5800c000: USB OHCI 1.0
>>>>>> Bus usb@5800d000: USB EHCI 1.00
>>>>>> scanning bus usb@5800c000 for devices... 1 USB Device(s) found
>>>>>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>>>>>       scanning usb for storage devices... 0 Storage Device(s) found
>>>>>>
>>>>>> The "companion" property in the device tree allow to retrieve
>>>>>> companion
>>>>>> controller information, from the EHCI node. This allow marking the
>>>>>> companion driver as such.
>>>>>>
>>>>>> With this patch (same low speed device plugged in):
>>>>>> STM32MP> usb start
>>>>>> starting USB...
>>>>>> Bus usb@5800c000: USB OHCI 1.0
>>>>>> Bus usb@5800d000: USB EHCI 1.00
>>>>>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>>>>> scanning bus usb@5800c000 for devices... 2 USB Device(s) found
>>>>>>       scanning usb for storage devices... 0 Storage Device(s) found
>>>>>> STM32MP> usb tree
>>>>>> USB device tree:
>>>>>> 1  Hub (12 Mb/s, 0mA)
>>>>>> |   U-Boot Root Hub
>>>>>> |
>>>>>> +-2  Human Interface (1.5 Mb/s, 100mA)
>>>>>>       HP HP USB 1000dpi Laser Mouse
>>>>>>
>>>>>> 1  Hub (480 Mb/s, 0mA)
>>>>>>     u-boot EHCI Host Controller
>>>>>>
>>>>>> This also optimize bus scan when a High speed device is plugged
>>>>>> in, as
>>>>>> the usb-uclass skips OHCI in this case:
>>>>>>
>>>>>> STM32MP> usb reset
>>>>>> resetting USB...
>>>>>> Bus usb@5800c000: USB OHCI 1.0
>>>>>> Bus usb@5800d000: USB EHCI 1.00
>>>>>> scanning bus usb@5800d000 for devices... 2 USB Device(s) found
>>>>>>       scanning usb for storage devices... 1 Storage Device(s) found
>>>>>> STM32MP> usb tree
>>>>>> USB device tree:
>>>>>> 1  Hub (480 Mb/s, 0mA)
>>>>>> |  u-boot EHCI Host Controller
>>>>>> |
>>>>>> +-2  Mass Storage (480 Mb/s, 200mA)
>>>>>>       SanDisk Cruzer Blade 03003432021922011407
>>>>>>
>>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - move companion probing from generic ehci driver to usb-uclass,
>>>>>> after
>>>>>>      Marek's questions on design choice.
>>>>>> - rename commit title to follow this change
>>>>>>
>>>>>> ---
>>>>>>     drivers/usb/host/usb-uclass.c | 36
>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 36 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/usb/host/usb-uclass.c
>>>>>> b/drivers/usb/host/usb-uclass.c
>>>>>> index 02c0138a2065..e238eee8c84d 100644
>>>>>> --- a/drivers/usb/host/usb-uclass.c
>>>>>> +++ b/drivers/usb/host/usb-uclass.c
>>>>>> @@ -249,6 +249,37 @@ static void remove_inactive_children(struct
>>>>>> uclass *uc, struct udevice *bus)
>>>>>>         }
>>>>>>     }
>>>>>>     +static int usb_probe_companion(struct udevice *bus)
>>>>>> +{
>>>>>> +    struct udevice *companion_dev;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Enforce optional companion controller is marked as such in
>>>>>> order to
>>>>>> +     * 1st scan the primary controller, before the companion
>>>>>> controller
>>>>>> +     * (ownership is given to companion when low or full speed
>>>>>> devices
>>>>>> +     * have been detected).
>>>>>> +     */
>>>>>> +    ret = uclass_get_device_by_phandle(UCLASS_USB, bus, "companion",
>>>>>> &companion_dev);
>>>>>> +    if (!ret) {
>>>>>> +        struct usb_bus_priv *companion_bus_priv;
>>>>>> +
>>>>>> +        debug("%s is the companion of %s\n", companion_dev->name,
>>>>>> bus->name);
>>>>>> +        companion_bus_priv = dev_get_uclass_priv(companion_dev);
>>>>>> +        companion_bus_priv->companion = true;
>>>>>> +    } else if (ret && ret != -ENOENT && ret != -ENODEV) {
>>>>>> +        /*
>>>>>> +         * Treat everything else than no companion or disabled
>>>>>> +         * companion as an error. (It may not be enabled on boards
>>>>>> +         * that have a High-Speed HUB to handle FS and LS traffic).
>>>>>> +         */
>>>>>> +        printf("Failed to get companion (ret=%d)\n", ret);
>>>>>> +        return ret;
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>>     int usb_init(void)
>>>>>>     {
>>>>>>         int controllers_initialized = 0;
>>>>>> @@ -299,6 +330,11 @@ int usb_init(void)
>>>>>>                 printf("probe failed, error %d\n", ret);
>>>>>>                 continue;
>>>>>>             }
>>>>>> +
>>>>>> +        ret = usb_probe_companion(bus);
> 
> One more thing, shouldn't this do
> 
> if (ret)
>   continue;
> 
> for maximum compatibility ?

I think it does :-) Or I miss your question here, could you clarify ?

In the original PATCH there is:
+
+		ret = usb_probe_companion(bus);
+		if (ret)
+			continue;
+

> 
>> I'd be glad to have it in this release.
> 
> OK

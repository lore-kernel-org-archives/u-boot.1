Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C33CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 12:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B896C86907;
	Fri,  1 Sep 2023 14:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bHEYIT5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AA11868B1; Fri,  1 Sep 2023 14:12:16 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD3086908
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 14:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76082d487b=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 381BtNu3024007; Fri, 1 Sep 2023 14:12:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=tAZBWXDF8HEN8aMU3dDhnVtHqVYnFSyMyZHqP0S1TnM=; b=bH
 EYIT5aLXuy1UT4IYAuBgVT7eO8KqzTQ2EiB1QtJU1ik3XrjfcUrq4WDGqGxYrcjV
 UNOP1IqDCwtJgOSTlBHnDp+jw2peENLTzzFT57aEiX0LzmQ+NsH7Hn/FufOeew7t
 ArdFD1RTOcN/a6SsdNjyQpZSbh6IXV0KO55uIv2jS3c/A9RtM1Y9y16niFJBvLSX
 5FXoYJo6WnCQhOmRXgmpWC9a6cmTLcw6IkYGFv8/lgqEZV3zlk7dkEoTM+Ztps8N
 9+RGbsj3xqirRgRQEYN4spWa6UUGhbzzdmNNXPdjQipkvDLB+0x1HcaOVwNz7uSx
 7fUzfjkFe6vapcCc5AIw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sq6h4jx0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 14:12:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 59271100058;
 Fri,  1 Sep 2023 14:12:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51B472291DC;
 Fri,  1 Sep 2023 14:12:12 +0200 (CEST)
Received: from [10.201.22.39] (10.201.22.39) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 1 Sep
 2023 14:12:11 +0200
Message-ID: <9c06f5ec-c278-e00d-873f-99ef54098816@foss.st.com>
Date: Fri, 1 Sep 2023 14:12:10 +0200
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
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <29d44f7f-ffca-d8cd-ce88-5e2fb6103ff4@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_10,2023-08-31_01,2023-05-22_02
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

On 9/1/23 12:48, Marek Vasut wrote:
> On 9/1/23 11:52, Fabrice Gasnier wrote:
>> EHCI is usually used with companion controller (like OHCI) as companion
>> controller. This information on the companion is missing currently in
>> companion drivers.
>> So, if the usb-uclass isn't aware, it may scan busses in any order: OHCI
>> first, then EHCI.
>> This is seen on STM32MP1 where DT probing makes the probe order to occur
>> by increasing address (OHCI address < EHCI address).
>>
>> When a low speed or full-speed device is plugged in, it's not detected as
>> EHCI should first detect it, and give ownership (handover) to OHCI.
>>
>> Current situation on STM32MP1 (with a low speed device plugged-in)
>> STM32MP> usb start
>> starting USB...
>> Bus usb@5800c000: USB OHCI 1.0
>> Bus usb@5800d000: USB EHCI 1.00
>> scanning bus usb@5800c000 for devices... 1 USB Device(s) found
>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>>     scanning usb for storage devices... 0 Storage Device(s) found
>>
>> The "companion" property in the device tree allow to retrieve companion
>> controller information, from the EHCI node. This allow marking the
>> companion driver as such.
>>
>> With this patch (same low speed device plugged in):
>> STM32MP> usb start
>> starting USB...
>> Bus usb@5800c000: USB OHCI 1.0
>> Bus usb@5800d000: USB EHCI 1.00
>> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>> scanning bus usb@5800c000 for devices... 2 USB Device(s) found
>>     scanning usb for storage devices... 0 Storage Device(s) found
>> STM32MP> usb tree
>> USB device tree:
>> 1  Hub (12 Mb/s, 0mA)
>> |   U-Boot Root Hub
>> |
>> +-2  Human Interface (1.5 Mb/s, 100mA)
>>     HP HP USB 1000dpi Laser Mouse
>>
>> 1  Hub (480 Mb/s, 0mA)
>>   u-boot EHCI Host Controller
>>
>> This also optimize bus scan when a High speed device is plugged in, as
>> the usb-uclass skips OHCI in this case:
>>
>> STM32MP> usb reset
>> resetting USB...
>> Bus usb@5800c000: USB OHCI 1.0
>> Bus usb@5800d000: USB EHCI 1.00
>> scanning bus usb@5800d000 for devices... 2 USB Device(s) found
>>     scanning usb for storage devices... 1 Storage Device(s) found
>> STM32MP> usb tree
>> USB device tree:
>> 1  Hub (480 Mb/s, 0mA)
>> |  u-boot EHCI Host Controller
>> |
>> +-2  Mass Storage (480 Mb/s, 200mA)
>>     SanDisk Cruzer Blade 03003432021922011407
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>
>> Changes in v2:
>> - move companion probing from generic ehci driver to usb-uclass, after
>>    Marek's questions on design choice.
>> - rename commit title to follow this change
>>
>> ---
>>   drivers/usb/host/usb-uclass.c | 36 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/usb/host/usb-uclass.c
>> b/drivers/usb/host/usb-uclass.c
>> index 02c0138a2065..e238eee8c84d 100644
>> --- a/drivers/usb/host/usb-uclass.c
>> +++ b/drivers/usb/host/usb-uclass.c
>> @@ -249,6 +249,37 @@ static void remove_inactive_children(struct
>> uclass *uc, struct udevice *bus)
>>       }
>>   }
>>   +static int usb_probe_companion(struct udevice *bus)
>> +{
>> +    struct udevice *companion_dev;
>> +    int ret;
>> +
>> +    /*
>> +     * Enforce optional companion controller is marked as such in
>> order to
>> +     * 1st scan the primary controller, before the companion controller
>> +     * (ownership is given to companion when low or full speed devices
>> +     * have been detected).
>> +     */
>> +    ret = uclass_get_device_by_phandle(UCLASS_USB, bus, "companion",
>> &companion_dev);
>> +    if (!ret) {
>> +        struct usb_bus_priv *companion_bus_priv;
>> +
>> +        debug("%s is the companion of %s\n", companion_dev->name,
>> bus->name);
>> +        companion_bus_priv = dev_get_uclass_priv(companion_dev);
>> +        companion_bus_priv->companion = true;
>> +    } else if (ret && ret != -ENOENT && ret != -ENODEV) {
>> +        /*
>> +         * Treat everything else than no companion or disabled
>> +         * companion as an error. (It may not be enabled on boards
>> +         * that have a High-Speed HUB to handle FS and LS traffic).
>> +         */
>> +        printf("Failed to get companion (ret=%d)\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   int usb_init(void)
>>   {
>>       int controllers_initialized = 0;
>> @@ -299,6 +330,11 @@ int usb_init(void)
>>               printf("probe failed, error %d\n", ret);
>>               continue;
>>           }
>> +
>> +        ret = usb_probe_companion(bus);
> 
> Shouldn't this ^ be in separate uclass_foreach_dev(bus, uc) {} loop
> before this device_probe() loop , so that when the probe of the
> controller is called, its ->companion is already set ?

The point is to have the companion flag set before scanning the bus.
Generic OHCI or EHCI drivers don't care about this flag.

Scanning is performed right after this first loop (low-level), in two
subsequent steps: primary controllers (2nd step), then companions if
necessary (3rd step).


> 
>> +        if (ret)
>> +            continue;
>> +
>>           controllers_initialized++;
>>           usb_started = true;
>>       }
> 
> [...]

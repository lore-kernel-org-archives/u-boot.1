Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2BECA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F557863DD;
	Fri,  1 Sep 2023 11:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="5kjBjaQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5607080422; Fri,  1 Sep 2023 11:49:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD15186453
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 11:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76082d487b=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3814bXKW027990; Fri, 1 Sep 2023 11:49:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=pPARXyNUEmVd8ypw5jf3ifL9Pg6FlwooBwpASuQsFI8=; b=5k
 jBjaQNOHFvHnbN4EmhDfkEO5QXYK4fW6nyrXnHAIUTIRmdpm3PD9lRLksQeQzctC
 pq3QMsG6DhSIxtc2yle7ChxcvPEwLSkUHGOYgS5iGMu4aHlCoH7FFbF5GRm9HMNz
 VPnoLXOUtMGVZLjjGXtxCxnHhw5GgGAtB3BVUGUE0Htm6jIOfigvP3D0m2N37XW4
 zkMARsicIwajYRycr41yYWCDORpTvjnylHtuOkmhOu6k1SITi2B4lilly8zniyme
 IGS/h/9Ks6CBCnApMjTOwd1N/mJeDR46hb2Jz0L16/vEG8Hnj2cjmrHR4D4hi5T7
 YQDdh7Dv7XAyUJvqQ9wQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqty06tar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Sep 2023 11:49:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 458D8100056;
 Fri,  1 Sep 2023 11:49:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2556821A90A;
 Fri,  1 Sep 2023 11:49:41 +0200 (CEST)
Received: from [10.201.22.39] (10.201.22.39) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 1 Sep
 2023 11:49:40 +0200
Message-ID: <8f54491e-47f8-5e58-5a44-f991dcf66616@foss.st.com>
Date: Fri, 1 Sep 2023 11:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: host: ehci-generic: check for companion controller
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20230830080008.455157-1-fabrice.gasnier@foss.st.com>
 <4e4f480f-8f97-cf8a-fb55-8d1ebaffb993@denx.de>
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <4e4f480f-8f97-cf8a-fb55-8d1ebaffb993@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_07,2023-08-31_01,2023-05-22_02
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



On 8/30/23 17:12, Marek Vasut wrote:
> On 8/30/23 10:00, Fabrice Gasnier wrote:
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
>>         scanning usb for storage devices... 0 Storage Device(s) found
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
>>         scanning usb for storage devices... 0 Storage Device(s) found
>> STM32MP> usb tree
>> USB device tree:
>>    1  Hub (12 Mb/s, 0mA)
>>    |   U-Boot Root Hub
>>    |
>>    +-2  Human Interface (1.5 Mb/s, 100mA)
>>         HP HP USB 1000dpi Laser Mouse
>>
>>    1  Hub (480 Mb/s, 0mA)
>>       u-boot EHCI Host Controller
>>
>> This also optimize bus scan when a High speed device is plugged in, as
>> the usb-uclass skips OHCI in this case:
>>
>> STM32MP> usb reset
>> resetting USB...
>> Bus usb@5800c000: USB OHCI 1.0
>> Bus usb@5800d000: USB EHCI 1.00
>> scanning bus usb@5800d000 for devices... 2 USB Device(s) found
>>         scanning usb for storage devices... 1 Storage Device(s) found
>> STM32MP> usb tree
>> USB device tree:
>>    1  Hub (480 Mb/s, 0mA)
>>    |  u-boot EHCI Host Controller
>>    |
>>    +-2  Mass Storage (480 Mb/s, 200mA)
>>         SanDisk Cruzer Blade 03003432021922011407
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>>
>>   drivers/usb/host/ehci-generic.c | 24 ++++++++++++++++++++++++
> 
> More of a design question -- shouldn't the usb-uclass handle this
> property ad manipulate with private data of "remote" devices instead ?

Hi Marek,

That's an option I haven't really explored earlier. I was a bit confused
when I figured out the usb-uclass was able to manage the companion
controller, by using the "companion" flag. But I couldn't find any
driver that was actually using this flag :-O.

So I had a look at the git log, and I found out:
- Companion has been introduced in:
b6de4d1093d3 dm: usb: Add support for companion controllers

- First user for this flag was introduced in same series:
6a72e804a2b2 sunxi: ohci: Add ohci usb host controller support
e.g. drivers/usb/host/ohci-sunxi.c

So, in the original design, the flag was set in OHCI controller driver
side. This is why I implemented this in controller driver, but in EHCI
generic driver, because it has the companion property (not in OHCI node).

- Later this driver has been dropped in, to use the generic OHCI driver
instead: 543049ab5906 usb: host: Drop [e-o]hci-sunxi drivers

It looks like that setting the companion flag has been missed when
moving to OHCI generic driver. I admit the strange thing with current
approach is: implementation is done in EHCI driver, to impact OHCI
private struct.

I'll send a v2, to handle this in usb-uclass as you suggest. This makes
sense.

Thanks for reviewing,
Best Regards,
Fabrice


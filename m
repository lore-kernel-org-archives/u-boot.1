Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CD5C3ABBE
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 18:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6C2820EB;
	Tue,  6 May 2025 20:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g8VpyIIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB8E82163; Tue,  6 May 2025 20:12:42 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F16680BAE
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 20:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546ICX2S1151347
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 13:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746555153;
 bh=juqhe9wHctR2cQ+Zt748h6JjLa9a0wCzQDFwaKG+ZrI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=g8VpyIIMl7UAiHBfMLpEbcKOUvEhFDmDEYWZm7uZ8Mzqtav5rvwGlOEqJemaYOgG3
 T6cZy7EmMaoaqZLxVSVqvgdXBQyOfVmaKG6UgO6RuplkSk0CV1lzlX+m0W1rwhvRtH
 ajwjujJeCgULlyodzkIWqgt/rJNODpJbiKYLG9L0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546ICWe6012504
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 13:12:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 13:12:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 13:12:32 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546ICVKD050979;
 Tue, 6 May 2025 13:12:31 -0500
Message-ID: <7a57f01b-03c4-4840-8b86-d00756b4f4fa@ti.com>
Date: Tue, 6 May 2025 13:12:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add support to boot TI K3 HSM M4 core
To: Tom Rini <trini@konsulko.com>, "Kumar, Udit" <u-kumar1@ti.com>
CC: Beleswar Prasad Padhi <b-padhi@ti.com>, <sjg@chromium.org>,
 <xypron.glpk@gmx.de>, <cfsworks@gmail.com>, <nm@ti.com>,
 <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
References: <20250506104202.16741-1-b-padhi@ti.com>
 <41a042ec-d2ec-48ee-be15-a6f88895e977@ti.com>
 <b643bfa3-5607-4d9e-95bd-cfab9d7a6ca5@ti.com>
 <3ffaf965-503f-4c08-b914-3d4014cdf72a@ti.com>
 <40b2ddc2-fe5b-4515-8772-2a2f9f35b5d7@ti.com>
 <20250506171947.GD5430@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250506171947.GD5430@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 5/6/25 12:19 PM, Tom Rini wrote:
> On Tue, May 06, 2025 at 10:47:57PM +0530, Kumar, Udit wrote:
>>
>> On 5/6/2025 8:38 PM, Andrew Davis wrote:
>>> On 5/6/25 9:51 AM, Beleswar Prasad Padhi wrote:
>>>> Hi Andrew,
>>>>
>>>> On 5/6/2025 4:38 PM, Andrew Davis wrote:
>>>>> On 5/6/25 5:41 AM, Beleswar Padhi wrote:
>>>>>> Some TI K3 SoCs like J721S2, and J784S4 have a HSM (High Security
>>>>>> Module) M4F core in the Wakeup Voltage Domain which could be used to
>>>>>> run secure services like Authentication. Boot flow for HSM M4 core is
>>>>>> different than the general purpose M4F cores, and is as below:
>>>>>>
>>>>>
>>>>> The below flow looks exactly like the general purpose M4F cores..
>>>>> Why is the HSM core treated differently and this loader not made into
>>>>> a normal remote proc driver?
>>>>
>>>>
>>>> Not exactly, HSM core is treated differently because of following
>>>> exceptions:
>>>> 1. Device operations for HSM core (like reset/reset release) are not
>>>> handled by DM. TIFS handles that with proc_boot_ctrl TI-SCI calls.
>>>
>>> This could be added to the commit message then.
>>>
>>>> 2. The HSM firmware is not an ELF image. So we can't use rproc elf
>>>> loader with it. Manual memcpy has to be done.
>>>>
>>>
>>> Why is the HSM firmware not an ELF image?
>>
>>
>> HSM firmwares are loaded by TIFS (in non-GP) flow, and TIFS does not have
>> elf parser.
> 
> And to be clear, why is that? Since it's preventing the use other
> existing workflows...
> 

Even if the firmware is only delivered as a raw blob we should still
be able to use existing workflows and make a proper rproc driver for
this HSM core here.

TF-A, TIFS, and PMMC firmware are all raw bins and we have
ti_k3_arm64_rproc.c / k3_system_controller.c / ti_power_proc.c
rproc drivers.

Andrew

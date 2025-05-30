Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79977C5B552
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2FC831F5;
	Fri, 30 May 2025 11:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NMYSHqQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DDA283208; Fri, 30 May 2025 11:17:50 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A5E830AB
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54U9Hjrt2604629;
 Fri, 30 May 2025 04:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748596665;
 bh=Q4zhDM8DrgTehEz1p5ro7hoRowbM0FZg1rP5sSrxfnY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=NMYSHqQjHy9QxbHuDZjD9YtzRM2+n0aj1hoxdutTPP7/H+mxPhbqbV+Y7oquUtneW
 Wb7sajDRIeTZyCTA6g+KaNpwgjr8QjNwBxhdh6sbf4XThY6IQxFr9/SPujt/8tkTOP
 nhVbR073qJTM2PT/6fKz7PT9aVALEc3ryXPjTTLs=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54U9Hj822777727
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 30 May 2025 04:17:45 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 May 2025 04:17:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 May 2025 04:17:45 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54U9Hi3A2910849;
 Fri, 30 May 2025 04:17:44 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 May 2025 14:47:12 +0530
Message-ID: <DA9DRVD9402Z.3USEIDF3PCOY0@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Davis <afd@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <b-liu@ti.com>
Subject: Re: [PATCH v6 1/9] spl: Kconfig: allow K3 devices to use falcon mode
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250428141235.1734014-1-anshuld@ti.com>
 <20250428141235.1734014-2-anshuld@ti.com>
 <b3cc74a0-3903-4970-89b3-eceb973a791c@ti.com>
 <D9PM26J8COAY.1ACTT0I6VHQJH@ti.com>
 <3741d859-2048-4b32-9c1e-f551ec62d377@ti.com>
 <D9QG8DY630MX.1OV8MBZIM4R8S@ti.com>
 <d42967c8-925d-4731-85e1-5962c9befbfa@ti.com>
 <D9QQZM1V6ZV1.2Q7C9F387H6P7@ti.com>
 <9183b5da-e8fb-4697-b0ba-da49e185c378@ti.com>
 <DA88RDZOP0U4.1YQBRI22YTHDP@ti.com>
 <5a92b8f0-c320-4f76-95be-f3f96e558237@ti.com>
In-Reply-To: <5a92b8f0-c320-4f76-95be-f3f96e558237@ti.com>
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

On Thu May 29, 2025 at 7:06 AM IST, Andrew Davis wrote:
> On 5/28/25 8:08 PM, Anshul Dalal wrote:
>> On Wed May 28, 2025 at 9:09 PM IST, Andrew Davis wrote:
>>> On 5/8/25 6:37 AM, Anshul Dalal wrote:
>>>> On Thu May 8, 2025 at 9:32 AM IST, Vignesh Raghavendra wrote:
>>>>>
>>>>>
>>>>> On 5/8/2025 8:42 AM, Anshul Dalal wrote:
>>>>>> On Wed May 7, 2025 at 11:36 PM IST, Andrew Davis wrote:
>>>>>>> On 5/6/25 10:33 PM, Anshul Dalal wrote:
>>>>>>>> On Tue May 6, 2025 at 8:03 PM IST, Andrew Davis wrote:
>>>>>>>>> On 4/28/25 9:12 AM, Anshul Dalal wrote:
>>>>>>>>>> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b44=
37bc
>>>>>>>>>> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older=
 32-bit
>>>>>>>>>> HS devices and can be enabled on K3 devices.
>>>>>>>>>>
>>>>>>>>>> For secure boot, the kernel with x509 headers can be packaged in=
 a fit
>>>>>>>>> "can be", this is the issue. Security is not just allowing method=
s that
>>>>>>>>> are security checked, but forcing the use of such methods. Settin=
g
>>>>>>>>> OS_BOOT opens up several paths that look for non-FIT images. Thes=
e
>>>>>>>>> images do not enforce authentication like FIT does. This means on=
e can
>>>>>>>>> bypass secure boot when OS_BOOT is enabled by simply placing a no=
n-FIT
>>>>>>>>> boot image on the boot media.
>>>>>>>>>
>>>>>>>> As per spl_load_image_ext_os, the SPL first tries to load the file=
 set
>>>>>>>> in falcon_args_file env variable but since it's not set in our cas=
e. And
>>>>>>>> the only way to set them is by rebuilding u-boot as uEnv.txt is no=
t
>>>>>>>> supported at SPL stage.
>>>>>>>>
>>>>>>>> This means the SPL only loads CONFIG_SPL_FS_LOAD_ARGS_NAME and
>>>>>>>> CONFIG_SPL_FS_LOAD_KERNEL_NAME which are set as the DTB and fitIma=
ge
>>>>>>> What is stopping me from replacing the content of the file "fitImag=
e"
>>>>>>> with a normal kernel image? When loading that image the file type
>>>>>>> will be detected as a normal kernel image and all FIT logic bypasse=
d,
>>>>>>> including authentication, breaking our secure chain of trust.
>>>>>>>
>>>>>>> Andrew
>>>>>> That would require booti_setup to be executed in spl_parse_image_hea=
der,
>>>>>> which is not possible on the R5 SPL since the required config symbol
>>>>>> CMD_BOOTI is only available for ARM64 platforms.
>>>>>>
>>>>>> In the worst case we end up loading a 32-bit zImage which wouldn't
>>>>>> boot on the Cortex-A cores anyway and would additionally require
>>>>>> enabling CMD_BOOTZ (currently disabled) at build time.
>>>>>
>>>>> Is there any path where R5 SPL can be tricked to load and jump to
>>>>> arbitrary binary? zImage, Image, elf, bin whatever?
>>>>>
>>>>> IOW, does SPL_OS_BOOT always check for some sort of header for the im=
age
>>>>> that it loads and the only type of header we have enabled here is fit=
Image?
>>>>
>>>> It does check for the header and proceeds only with the desired securi=
ty
>>>> enforced execution flow if the loaded image is FIT. For all other imag=
e
>>>> types, they are guarded by config symbols that are set unset in our ca=
se
>>>
>>> Are you sure?
>>>
>>> The only thing preventing this from continuing in spl_parse_image_heade=
r()
>>> is a check for CONFIG_SPL_PANIC_ON_RAW_IMAGE. Which is not set for us.
>>>
>>> After that we check if OS_BOOT is enabled and if so allow for kernel
>>> images to also pass[0]. What stops this from functioning?
>>>
>>> Andrew
>>>
>>> [0] https://github.com/u-boot/u-boot/blob/master/common/spl/spl.c#L338
>>>
>>=20
>> It would not function because of the unset CONFIG_CMD_BOOTI which can
>> only be set on 64 bit platforms anyway[1]. Hence the following check
>> would fail in spl_parse_image_header:
>>=20
>> if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
>>=20
>
> I linked the wrong line, the line a couple below for CONFIG_CMD_BOOTZ
> is the one that concerns me.
>
>> And as I said previously in the thread[2]; worst case is we load a
>> 32-bit zImage, support for which would have to be explicitly enabled at
>> build time as the respective config CMD_BOOTZ is kept unset currently.
>>=20
>
> What forces CMD_BOOTZ to not be set? Can it be enabled in SPL at all?
> If it can you should make it "depends on !TI_SECURE_DEVICE" like other
> dangerous to the secure chain of trust configs.
>

Sure, I'll update Kconfig to make CMD_BOOTZ and TI_SECURE_DEVICE
mutually exclusive in the next revision just like SPL_RAW_IMAGE_SUPPORT.

Thanks for the review!

~ Anshul

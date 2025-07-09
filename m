Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162DEC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 13:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649B683496;
	Wed,  9 Jul 2025 15:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z8q2rLL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591D783443; Wed,  9 Jul 2025 13:14:33 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1586C8341A
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 13:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569BENmC1194693;
 Wed, 9 Jul 2025 06:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752059663;
 bh=2lcxBFRoYDTT++AoICvuJznfWhxyNSo0D+i3c3CjKts=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Z8q2rLL80E/1Q9nDBsDm+30uy062SzPct0k3zVwar7kyHAhG0KSU8pSRWebz1PTRt
 Khvp/A2W+WLIhQKw1VhF/r/wQjN7UKdSeFGTPwUVxFyPCpttGTpYEcogzPDDG74ezB
 nODgEIU+qPbt/ca1CygfzW2NmOEJAwO0T+xQwk8U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569BENje2402219
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 9 Jul 2025 06:14:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 06:14:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 06:14:23 -0500
Received: from [10.24.72.138]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.72.138])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569BEJ013543066;
 Wed, 9 Jul 2025 06:14:20 -0500
Message-ID: <f4f0f9d8-4323-4ee8-9ff1-e63fe2dad428@ti.com>
Date: Wed, 9 Jul 2025 16:44:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] configs: KASLR OPTEE RNG support for
 K3 devices
To: Tom Rini <trini@konsulko.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>, <casey.connolly@linaro.org>,
 <tien.fong.chee@altera.com>, <sjg@chromium.org>,
 <patrick.rudolph@9elements.com>, <1425075683@qq.com>,
 <Oliver.Gaskell@analog.com>, <u-boot@lists.denx.de>, Gokul Praveen
 <g-praveen@ti.com>
References: <20250627092224.36325-1-g-praveen@ti.com>
 <20250627092224.36325-2-g-praveen@ti.com>
 <20250627102218.xtjlreu5qmpmfszr@uda0497581-HP>
 <a6e024ba-8642-4c58-a7b7-284c8cf448e5@ti.com>
 <20250708233104.GA1456905@bill-the-cat>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20250708233104.GA1456905@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 09 Jul 2025 15:15:19 +0200
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

On 09/07/25 05:01, Tom Rini wrote:
> On Mon, Jun 30, 2025 at 10:50:09AM +0530, Gokul Praveen wrote:
>> Hi Manorit,
>>
>> On 27/06/25 15:52, Manorit Chawdhry wrote:
>>> Hi Gokul,
>>>
>>> On 14:52-20250627, Gokul wrote:
>>>> From: Gokul Praveen <g-praveen@ti.com>
>>>>
>>>> Add KASLR OPTEE RNG support across K3 devices by enabling the required
>>>> configs.
>>>>
>>>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>>>> ---
>>>>    arch/arm/Kconfig | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index 7282c4123b0..cd27e5a5422 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -805,6 +805,9 @@ config ARCH_K3
>>>>    	select REGEX
>>>>    	select FIT_SIGNATURE if ARM64
>>>>    	imply TI_SECURE_DEVICE
>>>> +	imply DM_RNG
>>>> +	imply TEE
>>>> +	imply OPTEE
>>>
>>> Does it get enabled for R5 based defconfigs too in .config? ARCH_K3 is
>>> enabled for both R5 and ARM64 cores so wondering if we are ending up
>>> enabling it for R5 too which might not be required ( or is it? )
>>>
>>> Regards,
>>> Manorit
>>>
>> No,it does not get enabled for R5 actually.
> 
> That's not what the size growth on R5 platforms I see reflects:
>                 u-boot: add: 11/-2, grow: 8/-2 bytes: 1584/-692 (892)
>                   function                                   old     new   delta
>                   try_load_entry                               -     596    +596
>                   static.fdt_kaslrseed                         -     200    +200
>                   handle_random_req                            -     180    +180
>                   getrng                                       -     120    +120
>                   rng_getinfo                                  -      80     +80
>                   _u_boot_list_2_uclass_driver_2_rng           -      72     +72
>                   efi_init_obj_list                         2304    2368     +64
>                   static.uclass_get_device                     -      56     +56
>                   label_boot                                1316    1372     +56
>                   _rproc_name_is_unique                        -      52     +52
>                   gen_rand_uuid_str                          108     144     +36
>                   efi_guid_rng_protocol                        -      16     +16
>                   dm_rng_read                                  -      16     +16
>                   static.env_do_env_set                      272     280      +8
>                   fdt_chosen                                 172     180      +8
>                   efi_rng_protocol                             -       8      +8
>                   cli_readline_into_buffer                  1716    1724      +8
>                   parse_pxefile_top                          928     932      +4
>                   bootflow_scan_next                         272     276      +4
>                   vbe_req_aslr_rand                            8       4      -4
>                   serial_init                                316     276     -40
>                   static._rproc_name_is_unique                52       -     -52
>                   static.try_load_entry                      596       -    -596
> 
Hi Tom,

Actually, the CONFIG_DM_RNG gets enabled in R5. Sorry about that.

I will send a v2 patch which fixes that.

Regards

Gokul

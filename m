Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4877EC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 21:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7657B8786C;
	Tue,  9 Apr 2024 23:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Kw6pzfek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F44879A0; Tue,  9 Apr 2024 23:05:59 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B57187519
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 23:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439L5iQh037520;
 Tue, 9 Apr 2024 16:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712696744;
 bh=Ae9msIIv3LFnogB1TSidSd1LeROrECMTuvce5wUVNv0=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=Kw6pzfekXsvZRiZf93CeUXJYqjgLzDQ1drxx2ebf/nXQgUPWCJ+xvV4pnSZlgnVDZ
 emxncOC5Vbtz3ZgTd3x+uuqcgMrU03DdPI1pztBV5wsr7tPEyspst+Km0+8BtGeYg9
 d860nf2kmze90taF15NIhLxk2p94VuyscZHFBpwo=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439L5iNn071456
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Apr 2024 16:05:44 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 16:05:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 16:05:43 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439L5hF7003145;
 Tue, 9 Apr 2024 16:05:43 -0500
From: Jon Humphreys <j-humphreys@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 "Neha Malcom Francis" <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, "Roger Quadros" <rogerq@kernel.org>, Bryan Brattlof
 <bb@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 01/16] board: Define GUIDs for firmware images
In-Reply-To: <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
References: <20240408223134.165877-1-j-humphreys@ti.com>
 <20240408223134.165877-2-j-humphreys@ti.com>
 <cac63a03-b019-4aed-83de-db2effa1a2f1@gmx.de>
Date: Tue, 9 Apr 2024 16:05:43 -0500
Message-ID: <86zfu2z1p4.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 23:13:13 +0200
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

Heinrich Schuchardt <xypron.glpk@gmx.de> writes:

> On 4/9/24 00:31, Jonathan Humphreys wrote:
>> Define GUIDs for the different firmware images (tiboot3.bin, tispl.bin,
>> u-boot.img, sysfw). >
>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> ---
>>   include/configs/ti_armv7_common.h | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
>> index 3def7b1027e..4ce14a9b84c 100644
>> --- a/include/configs/ti_armv7_common.h
>> +++ b/include/configs/ti_armv7_common.h
>> @@ -16,6 +16,23 @@
>>   #ifndef __CONFIG_TI_ARMV7_COMMON_H__
>>   #define __CONFIG_TI_ARMV7_COMMON_H__
>>
>> +/* GUIDs for capsule updatable firmware images */
>
> Please, provide code comments for the GUIDs, e.g.
>
> /**
>   * define K3_TIBOOT3_IMAGE_GUID - firmware GUID for K3 tiboot3.bin
>   *
>   * This GUID is used in capsules updates to identify the tiboot3.bin
>   * binary.
>   */
>
> Cf.
> https://docs.kernel.org/doc-guide/kernel-doc.html#object-like-macro-documentation
>
> Best regards
>
> Heinrich
>

Heinrich, thanks for reviewing!

I modelled the GUID macros after how other boards and even core code
defined there's.  (eg, include/configs/kontron-sl-mx8mm.h or
include/efi_api.h).

However, if this is the new direction, I will format as you suggest.
Please confirm.

thanks
Jon

>> +#define K3_TIBOOT3_IMAGE_GUID \
>> +	EFI_GUID(0xe672b518, 0x7cd7, 0x4014, 0xbd, 0x8d, \
>> +		 0x40, 0x72, 0x4d, 0x0a, 0xd4, 0xdc)
>> +
>> +#define K3_SPL_IMAGE_GUID \
>> +	EFI_GUID(0x86f710ad, 0x10cf, 0x46ea, 0xac, 0x67, \
>> +		 0x85, 0x6a, 0xe0, 0x6e, 0xfa, 0xd2)
>> +
>> +#define K3_UBOOT_IMAGE_GUID \
>> +	EFI_GUID(0x81b58fb0, 0x3b00, 0x4add, 0xa2, 0x0a, \
>> +		 0xc1, 0x85, 0xbb, 0xac, 0xa1, 0xed)
>> +
>> +#define K3_SYSFW_IMAGE_GUID \
>> +	EFI_GUID(0x6fd10680, 0x361b, 0x431f, 0x80, 0xaa, \
>> +		 0x89, 0x94, 0x55, 0x81, 0x9e, 0x11)
>> +
>>   /*
>>    * We setup defaults based on constraints from the Linux kernel, which should
>>    * also be safe elsewhere.  We have the default load at 32MB into DDR (for

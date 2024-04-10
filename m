Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35441CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 18:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6B387EEB;
	Wed, 10 Apr 2024 20:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SY565KDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767AF87F6E; Wed, 10 Apr 2024 20:38:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AE186E40
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AIcQQc129003;
 Wed, 10 Apr 2024 13:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712774306;
 bh=jF50aWf2fgk5OEdHUPdO1HMQ4Te22ZSUXwWHwdKkzlA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SY565KDx9CFngvdMbhKkmK5TfPzzvUgfKROIVb75mPafk5SnDs2Pci3KzgKaC8kZm
 QxXP+hDKKcQpnTG4XooWlFbV7q6T9cuRy/FxgxxlY9g7LfdXwqasVC+Ii+c7hIIJbh
 ZqZLC7Zg0b2IKNke6UrQMzE387Wu/ZU06z9DjREk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AIcQNu009031
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Apr 2024 13:38:26 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 13:38:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 13:38:25 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AIcPB9091147;
 Wed, 10 Apr 2024 13:38:25 -0500
Message-ID: <b2dc3d0f-799c-4e4b-bd7d-e2464cefcf01@ti.com>
Date: Wed, 10 Apr 2024 13:38:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] dts: j721e: binman: Include firmware capsules binman
 nodes
To: Jon Humphreys <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Simon
 Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>, Bryan
 Brattlof <bb@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240408221735.164871-1-j-humphreys@ti.com>
 <20240408221735.164871-4-j-humphreys@ti.com>
 <3b054817-8b1b-459f-b38e-70620bfd9b28@ti.com>
 <86ttk9yt2h.fsf@udb0321960.dhcp.ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <86ttk9yt2h.fsf@udb0321960.dhcp.ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 4/10/24 1:24 PM, Jon Humphreys wrote:
> Andrew Davis <afd@ti.com> writes:
> 
>> On 4/8/24 5:17 PM, Jonathan Humphreys wrote:
>>> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>>> ---
>>>    arch/arm/dts/k3-j721e-binman.dtsi | 32 +++++++++++++++++++++++++++++++
>>>    1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-j721e-binman.dtsi b/arch/arm/dts/k3-j721e-binman.dtsi
>>> index 75a6e9599b9..9169551c422 100644
>>> --- a/arch/arm/dts/k3-j721e-binman.dtsi
>>> +++ b/arch/arm/dts/k3-j721e-binman.dtsi
>>> @@ -207,6 +207,29 @@
>>>    		};
>>>    	};
>>>    };
>>> +
>>> +#include "k3-binman-capsule-r5.dtsi"
>>> +
>>> +// Capsue update GUIDs.  See ti_armv7_common.h.
>>> +#define K3_SYSFW_IMAGE_UUID_STR "6fd10680-361b-431f-80aa-899455819e11"
>>> +
>>> +&binman {
>>> +	capsule-sysfw {
>>> +		filename = "sysfw-capsule.bin";
>>> +		efi-capsule {
>>> +			image-index = <0x4>;
>>> +			image-guid = K3_SYSFW_IMAGE_UUID_STR;
>>> +			private-key = "arch/arm/mach-k3/keys/custMpk.pem";
>>> +			public-key-cert = "arch/arm/mach-k3/keys/custMpk.crt";
>>> +			monotonic-count = <0x1>;
>>> +
>>> +			blob {
>>> +				filename = "sysfw.itb";
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>>    #endif
>>>    
>>>    #ifdef CONFIG_TARGET_J721E_A72_EVM
>>> @@ -585,4 +608,13 @@
>>>    		};
>>>    	};
>>>    };
>>> +
>>> +#include "k3-binman-capsule.dtsi"
>>> +&tispl_name {
>>> +	filename = "tispl.bin_unsigned";
>>
>> Why use the _unsigned images here? HS devices cannot boot unsigned GP images,
>> but both GP and HS devices *can* boot the normal signed images (GP just strips
>> the signatures off). So no need to use the _unsigned images anymore (I'm
>> planning to just remove them at some point to prevent this confusion).
>>
> I can do that.
> 
> Note that you will then see warnings on GP devices during boot:
> 
>    Warning: Detected image signing certificate on GP device. Skipping certificate to prevent boot failure. This will fail if the image was also encrypted
> 

True, I'll send a fix for that.

Andrew

> Jon
> 
>> Andrew
>>
>>> +};
>>> +&uboot_name {
>>> +	filename = "u-boot.img_unsigned";
>>> +};
>>> +
>>>    #endif

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93251C25B74
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 05:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC08F88422;
	Tue,  4 Jun 2024 07:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bDtRlq7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C88688428; Tue,  4 Jun 2024 07:25:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218868841E
 for <U-Boot@lists.denx.de>; Tue,  4 Jun 2024 07:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717478702; x=1718083502; i=xypron.glpk@gmx.de;
 bh=plWPmh5dmz3u2CH66RcsKKwWUNQW8etJaH+/v6VKwIQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bDtRlq7rEld5IzYkSpRRT4J3r0s20YIsF5vBE9mRMw/Vvs02Iu1i1LEjY1xDjqRA
 wCPeR1LIYjxMX/lQ0YHv7J0qObwMZallpW8/S+HCt1goC/h6HThc9Qyppte/5QJ+a
 WyssvzNxsxbNBASNt/1ieQtCaOetjk0VYT8xS2vS3Q/pQoXYXYMZz+YMjQbSEX2CF
 umMck9WZvsKB4FH+iSK9aYCgLX/SidqXIHd8fObAY2OLhpQbDtw+rHbO3A7Zkc3iZ
 HMIdTaHaXoIvG3E6/eKRxT5IIeOZZVC+xSx9FJaRt4ghDh+HCIPJkMbRbFsxTN/3a
 78M1mu+Dk5SaeD0Vlw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.43.115.118]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQMyf-1rsj5I3vtp-00PPFj; Tue, 04
 Jun 2024 07:25:02 +0200
Message-ID: <9a97efe7-069b-4c88-9a64-0e23d6fd390f@gmx.de>
Date: Tue, 4 Jun 2024 07:24:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
To: "Brunham, Kalen" <kalen.brunham@intel.com>, Tom Rini <trini@konsulko.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
References: <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
 <20240527160708.GJ2568172@bill-the-cat>
 <DM4PR11MB52966C57EFE2BE722B9E8DC1E3F32@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240531160258.GN3714513@bill-the-cat>
 <DM4PR11MB5296624D138053E9457054B8E3FE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240603172322.GA68077@bill-the-cat>
 <DM4PR11MB5296E1D83E3AC318389107E3E3F82@DM4PR11MB5296.namprd11.prod.outlook.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <DM4PR11MB5296E1D83E3AC318389107E3E3F82@DM4PR11MB5296.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Eb93y4glzBfi64Q09thVj5JxnjSKEriW9FODjsFxCwNbMu2r6tN
 qW93LE08YySAjKaWGl3ncN98DGBKkfZ8f1UxWVSMB11Tvr5y8lbi07DgX8F9nOkccGi1eag
 JYR2SSNB1elszTEEpIj2uwO7wuXn8zBnKqFKdb9QfY1LBY6Mx98T5mCMEzCNZ2zBDJyFQpU
 RYwfhSgkCmQQ+bAfQJ0Pw==
UI-OutboundReport: notjunk:1;M01:P0:pXg2r239TJQ=;dp2KdjVALjhuIR5k+4HXad8MDfK
 NJ/Xgo87dO7ALPV6oAnypiS5Zfw6OtvYU7pIFi5Xaa0uQtmQM3ZDCGSXaJpnovK9tgs+ZVsdb
 vOVldBcRZ+Dnm1c69zisgW5ZYNyqNJMihEMcdA74CuQVTRqILk998FxSDyM10KVlEyN/5B5Sq
 3NOJhsaYXZVMexJv8nAwTvd9/DzsS+WsJgVLx8NXFuZOnmuLej4fkyVjKCjp91ByD1rh+2/Z5
 xRN3FaykFaOoqzFyy+eib9UDGiRFHZtThfM6BW2/f40M2+hgEbPX0F6HOgihIOE+a0HlmqJiE
 Chs548mkTrM2xoRzpaSUcBINxuM5xWXpkWYByywJ/g/Y3z0mYeHgBic0KIboe6t9HHOH4aos9
 3ldWOiUK2miC4UD/zrmrukIMjdTAhYXZvrueiMFicuBmmSPRjq4L3ikkMVh2tFXW31y+0HCq1
 GVQPp6tJ0Vg8k75aOaEuFA/FXUNyOX/LZMblQsKVAOovVzTx9t4Cai//8W9espYi1Jv91gO4F
 CeYUfDYz0Jcty3zqbK/3viWuHq7Vg4Dkzy31xHCp/zLDVF/G7H5JfgUmsPJqyzrmkyiM+f+Su
 UTyH1A+EfPR6qsdHc26CwBc3DkbSaA53sIzCmdTpj9gtRdRXWVG96l2PiflrR3xjfURWCDM9g
 e1AhbPmgbZwEKysPSOqvZSFWFNxUM4yC9PHSX8Vv0r0VMjN/owsLdSAtNbfiJnkqBA9IhG+SN
 PAT6ZS9mAiFuYdXbfx6B8JOdu6Fad+f+rOCwNKaWIEc9WB5qm1fTffAkH25VPLe0rLwdrLsDF
 8GHM8y9BAFU8Go1uU1JUdW2nKl3j45l5zS0M063iWo1sU=
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

On 6/4/24 05:34, Brunham, Kalen wrote:
> Hi Tom/Heinrich,
>
> I have https://github.com/u-boot/u-boot/pull/574 that has a proposed cha=
nge. It is currently failing clang sandbox, which looks a little strange a=
nd I'm looking into it. Please let me know if you have any feedback on the=
 general strategy.
>
> Thanks,
> -Kalen
>
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, June 3, 2024 1:23 PM
> To: Brunham, Kalen <kalen.brunham@intel.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.g=
lpk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists.=
denx.de
> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>
> On Sun, Jun 02, 2024 at 12:16:38AM +0000, Brunham, Kalen wrote:
>> Thanks Tom.
>>
>> Can you suggest who is the existing owner of this code I could work wit=
h?
>
> You should CC Heinrich for sure once you have things working.
>
>>
>> -----Original Message-----
>> From: Tom Rini <trini@konsulko.com>
>> Sent: Friday, May 31, 2024 12:03 PM
>> To: Brunham, Kalen <kalen.brunham@intel.com>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>; Heinrich Schuchardt <xypron.=
glpk@gmx.de>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; U-Boot@lists=
.denx.de
>> Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
>>
>> On Thu, May 30, 2024 at 02:53:17PM +0000, Brunham, Kalen wrote:
>>
>>> Hi Tom,
>>>
>>> What are next steps on this change?
>>>
>>> I'm committed to the idea of EFI apps opposed to examples/standalone.
>>> EFI currently requires block devices which is not enabled when only us=
ing flash.
>>>
>>> Should config BLK be updated to include DM_SPI_FLASH?
>>> Should we explore how to remove BLK as a dependency for EFI_LOADER?
>>
>> Yes, someone needs to explore how to cleanly make BLK optional for EFI_=
LOADER.

EFI applications like iPXE provide block devices. CONFIG_BLK does not
depend on anything but CONFIG_DM.

Why would you prefer to make BLK optional for EFI_LOADER?

Best regards

Heinrich

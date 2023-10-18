Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6332C41513
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D78B86F61;
	Wed, 18 Oct 2023 14:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WcTiqpJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E72186F90; Wed, 18 Oct 2023 14:55:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23BF86F61
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697633715; x=1698238515; i=xypron.glpk@gmx.de;
 bh=cLB7GjQt/u7BIRPAJeTdd2RthjF5N3HIdpIkMLUSSgU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WcTiqpJ9vV8ZJ4COZbcwdXhahGsUtkxylUZhiT94Mrp0AcvF84I8jPxFzN/WBDdlDnyDqgAnAXd
 H5Ku7mGutFdkIMVS/fy1MFlbqmX390c1NGkeZtzBqFgo+watpv6HsPZOvsrotRUOb6Ok12snXkarN
 x2sagCHhKgVG+QtXBISKXQKZdPP390f6eg2SytpcTpEDsvD7xuVJVZ+W1cyYWNtyaFsnzgUBA2+Xd
 VWzB7cZa2R3+wd/J58L+xeV6PZZAwUeRGuu8JU4w8AV6zvPwGhLxnYAG5ZnCZBE57uKxPseTwBpW0
 h+cQiyKmLBBo0JXeaRztBZss61s6jZ3gadhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1qujyC3IrK-007AUZ; Wed, 18
 Oct 2023 14:55:14 +0200
Message-ID: <cac1ad58-5a7a-41fd-84db-f972609f95c6@gmx.de>
Date: Wed, 18 Oct 2023 14:55:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231017140925.GB3119521@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231017140925.GB3119521@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4FqyvDrjhGMM/sc/RzoXm8tbwnA9B5sSY7W+2GfJyz8LXF3kQbB
 HCF8eHulc4/pfX+ONKp6uw7EGg67b3PTbu8ckDb0/I5Yil1v+K6KzEp3LDS5BrRkiE4/Eb4
 HeQlUOvMv/YMqTW3UtNq92JI+Dq476dpJNG6z0VE3B2svDX+8EQOOuOos0eRrF0/yo0w3IP
 0UneM4VC/EXfe3Gp3IDCg==
UI-OutboundReport: notjunk:1;M01:P0:mw+XuAr6k6U=;wJwHtYzUbfnKJhDjTL/wBp77NEt
 FB0CvfUqbP0Eh6+Ercwirmn84IyhmviI6G3nql/EYb4cCkAMIZtT2r+CXhmrYaWXeNKGO8A8O
 mGLVsrAkQOekWuZcecFlkBDtAchWb3EiGiUsjvjYxTrx/X4r9DiWZfyGw7CAiJOsOIU2jzm/k
 hLrxmovStp869h40t1Y86KvYx1ily7csPJXW2NuRksuiwcqupvhgGuW9Rb3mrTKVktv/R2OUr
 Wscr5tGGY5Y/DkO4TgD8+JqD/zYWGKuKVr6zQl007EK3qzDJgKTjh1tLEPk1Oyu6NhJmvssWr
 cpq6eVNDCy7wWfrqmtNqkJpkWFZ7YoPzHpmYMKUicu+A3EdcVzOZ1OBnod32hCl7RWsBNJ1tL
 QomOt1fvR0zKbkZBWKTXcYdKi0yX0UmqXr6f2hhymFMEYhKRkBJfuC46ISdqQnwTokx/IaPBT
 iD2VstndefBDP78NrGb5Z7y/o2PxZWbfQHwaJUQy8kGN/MzdeieFjNQErWeklKp4v4PX+qr4U
 daF6V6RR+8ujbFOPHiMhiqCF2ccyfoaZR2//p6Yk9Au5+NSh2jSJoWvCdXfhfCwlmUobchGvF
 yyNh+fzKChMay8hap1WzKUyPmq38+hro+W7Y1ZI1HMDFiPYKsYT1YaZpNW9LMpSeCPZHJEbgQ
 s5YdweM1448BFtbXDNmNmhanaVqk7t7V2Z8rLVVL5FyiXojyt2MfYqtX0CNeIovncc3lTPRfs
 sTt5HOYXvL33R+td+t96aKNCQXr3qAtIhG4kt+bJ/Gx5aeIEm/r69UiqyZFbXl/uVzQdWipS5
 QEHL3Gi75LG8s8T4DVPxDsjEg5SYc4Fog8UkDlRMTozWqbc3bN8S2BjHMcx1zJQT+g4M9ynpX
 TklfpBNAwZKr/8cBEXBs5yR5K5W9b2wO4e1tqL47B4Ove7Oc7nMgWlIrOKJRSZg4RvT2Le7XC
 sDu7kLL8yxWN/b7kKzrP2y7hsxU=
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

On 10/17/23 16:09, Tom Rini wrote:
> On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
>
>> Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet i=
s
>> available, add it as an explicit dependency.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> (no changes since v2)
>>
>> Changes in v2:
>> - Add new patch to update EFI_LOADER to depend on DM_ETH
>>
>>   lib/efi_loader/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>> index 13cad6342c36..fca4b3eef270 100644
>> --- a/lib/efi_loader/Kconfig
>> +++ b/lib/efi_loader/Kconfig
>> @@ -11,6 +11,7 @@ config EFI_LOADER
>>   	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
>>   	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>>   	depends on BLK
>> +	depends on DM_ETH
>>   	depends on !EFI_APP
>>   	default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
>>   	select CHARSET
>
> Does this work for you Heinrich, or do you want to clarify the
> dependencies (and re-organize the code as needed) around networking?
>

We should be able to boot via EFI on devices without U-Boot network suppor=
t.

We already use IS_ENABLED(CONFIG_NETDEVICES) to avoid invoking
eth_get_dev() if there is no network. CONFIG_NETDEVICES=3Dy selects
CONFIG_DM_ETH.

Why is this not sufficient?
Is there a configuration that does not build?

Best regards

Heinrich

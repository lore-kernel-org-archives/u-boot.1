Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2559CC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 05:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427D48861A;
	Sun, 30 Jun 2024 07:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719725044;
	bh=VcKRTxnr7meWoqtbYCvCabPYgyk9NU5n1YJihdtPZ7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wGGD/hGfu6x8LpqoDnLFRV/R4JsvdmRMgV+Q7jueAnGSEitSWI9wPWqdm79ZCKgMi
	 isRqUaxijOmlFhIdixoMmGto7Fjx4R4uALGeetaINBrh2HHhfb3Qjo7AVNIzoy5MPF
	 m7xtipwY0MexQEoqaM9vpNELNpQD/WyjlNgE5uKamtmjrYImkqIFCVA3xC7SsK/m6O
	 omZ9u5RveYTfiJFHkvRyE9fTefbCepZ8cbb8P8OUPKItJMYXynqZ88mK0UKEjvb6tK
	 Mdx9C9Go6neKPJOssLtGKP/SZiQmQLjv4mqVoifNSOzJqswlhkj5WOU/mLCWpV9awj
	 Wf/hHaVlqWtmw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B1CCF88614;
 Sun, 30 Jun 2024 07:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719725043;
 bh=VcKRTxnr7meWoqtbYCvCabPYgyk9NU5n1YJihdtPZ7A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qOlDKP1kqS2+IC8w5MDTKYuB7GqB1ZH7jx0mOoORdY8PH+QldwHDFL/HesMrJDPwU
 Z5x1Q0v/rxzY2e2HevO9AmLtr4jmGtEOUK/DX51kY36GMY8i89rO51OV5eJKlFevmm
 eSgHDnM29tStssezar5s9L4lV2tEMq/AT7thsgIHtps0Da4UzF1zJT6Zw5/BieE3fW
 XuzNCbym+JFT7GhIjynPOFwJuvJEOYOXyr8BbWSJVN1qzzwwh+S4Tc9cfbJDec00lt
 FuCQs7gEb5rQQWnujx0x5g8aY8H/5LF5qo+m+zWN6LodhXwSqhqKjwE3ZYMs9DueF7
 GbeQLX2GQVGdQ==
Message-ID: <4a6085d9-9c52-49a1-8c36-c3d1094b8a28@denx.de>
Date: Sun, 30 Jun 2024 04:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>, Suniel Mahesh
 <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240628024804.149871-1-marex@denx.de>
 <CAFLszTh_u8ipmSqyi73TVZ=kCGnk8mnb7Ww3HeHwUXSEdGqVEg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFLszTh_u8ipmSqyi73TVZ=kCGnk8mnb7Ww3HeHwUXSEdGqVEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/28/24 9:32 AM, Simon Glass wrote:
> Hi Marek,

Hi,

>> ---
>>   common/spl/spl_fit.c                | 29 +++++++++++++++++++++++++++--
>>   doc/device-tree-bindings/config.txt | 11 +++++++++++
>>   2 files changed, 38 insertions(+), 2 deletions(-)
> 
> Once this is figured out, can you extend test/image/spl_load_os.c to
> test this code?

It seems there is nothing which would do even basic tests for SPL 
fitImage DT handling in that test? Or am I reading the current test wrong ?

>> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
>> index 988125be008..0a6b5ea8212 100644
>> --- a/common/spl/spl_fit.c
>> +++ b/common/spl/spl_fit.c
>> @@ -363,6 +363,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>>   {
>>          struct spl_image_info image_info;
>>          int node, ret = 0, index = 0;
>> +       char dtoname[256];
>>
>>          /*
>>           * Use the address following the image as target address for the
>> @@ -448,9 +449,13 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>>                          if (ret < 0)
>>                                  break;
>>
>> -                       /* Make room in FDT for changes from the overlay */
>> +                       /*
>> +                        * Make room in FDT for changes from the overlay,
>> +                        * the overlay name and the trailing NUL byte in
>> +                        * that name.
>> +                        */
>>                          ret = fdt_increase_size(spl_image->fdt_addr,
>> -                                               image_info.size);
>> +                                               image_info.size + strlen(str) + 1);
> 
> Oh and I missed the room for the property, sorry. It needs something like this:
> 
> ALIGN(strlen(str) + 1, 4) + 12 + 4
> 
> the first bit is the string-table size increase
> 
> 12 is sizeof(struct fdt_property)
> 4 is the u32 size
> 
> Alos, is there any way to check that there is actually enough space to
> increase the size?

fdt_increase_size() would fail if there isn't enough space, so that 
should cover the check.

>> diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
>> index f50c68bbdc3..7aa6d9a72c6 100644
>> --- a/doc/device-tree-bindings/config.txt
>> +++ b/doc/device-tree-bindings/config.txt
>> @@ -95,6 +95,17 @@ rootdisk-offset (int)
>>   silent-console (int)
>>          If present and non-zero, the console is silenced by default on boot.
>>
>> +u-boot,spl-applied-dto-* (int)
>> +       Emitted by SPL into U-Boot control DT root node in case a DTO from
>> +       fitImage was applied on top of U-Boot control DT by the SPL fitImage
>> +       loader. The single integer cell indicates in which order was the DTO
>> +       applied by the SPL and matches the index of the DTO in the fitImage.
>> +       DTOs in fitImage may be skipped using board_spl_fit_append_fdt_skip(),
>> +       therefore the integers might not be monotonically incrementing, there
>> +       may be gaps. This property can be used to determine which DTOs were
>> +       applied by the SPL from running U-Boot by inspecting the U-Boot
>> +       control DT.
> 
> Should we send a binding with this? I wonder if it would be better to
> make the filename a property value rather than including it in the
> property name/string table? That way you would not need the
> integers...the ordering would be enough.
> 
> E.g.
> 
> u-boot,spl-applied-dtos = "fdt-dto-imx8mp-dhcom-som-overlay-eth2xfast",
>        "fdt-dto-imx8mp-dhcom-pdk-overlay-eth2xfast";
> 
> But that might be more annoying to construct as you would probably
> need fdt_setprop_placeholder()

It is easier to test for a presence of property from U-Boot shell, also 
the property is integer where the integer indicates the index of the DTO 
when it was applied.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8FEC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 16:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6F948879C;
	Mon,  8 Jul 2024 18:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lnD7Pu6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B60887CA; Mon,  8 Jul 2024 18:08:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D0E28872D
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 18:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1720454886; x=1721059686; i=xypron.glpk@gmx.de;
 bh=mS5Hos+kYQoXW29Q6GRYXaNYpnZwJ5sQO3BZaZaolbc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lnD7Pu6kwN73Df57PbgxZuXHl1y7tunOejdKNyLDmIUCMceMSFCrmZTb6Ez7kU7I
 MivqaACkFf8Gu0BFQWX53fthCNoDfpXPQ+JmfJ5chv89NZQiW3nCBNQ1UZqEim9Z3
 lg8m0IW2SbMR+6AfZVF22jih7g3jZiyVwyIC77Nr2ji0TDIOr4fB1xf9GS13juTfB
 HX/3ZdgHjMs6WTBuy5a5o43NvS86T8wuYCoenjwoK8xZUydmGNDBd/kud/vabesse
 pxU3LEEuuWhXsR7FqqjmlcviBw32EhsQOLfX9rA5XLHYEvglIfoRiYyb3BKPcv8Ds
 hV3tSP4WYWIZlU865g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1sLKDF2rwh-00rIiv; Mon, 08
 Jul 2024 18:08:06 +0200
Message-ID: <ead7a72e-73d6-476e-a0be-5ffe393c8b02@gmx.de>
Date: Mon, 8 Jul 2024 18:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/2] doc: add missing table of content links
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sam Povilus <sam.povilus@amd.com>, trini@konsulko.com, sjg@chromium.org,
 u-boot@lists.denx.de
References: <20240708153941.1045588-1-sam.povilus@amd.com>
 <20240708153941.1045588-3-sam.povilus@amd.com>
 <99203b22-a57e-4f78-b4ad-221726fbf56b@gmx.de>
Content-Language: en-US
In-Reply-To: <99203b22-a57e-4f78-b4ad-221726fbf56b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wRFo7REX1IuCEQV+3YaOjmCPR40VAXvxatsWY074lqQsfHDEGf5
 T4Ool0mF6Q1j+jE8U5yHDcuzLHqJXrCzOdg3PSRGwNWk1OZLeULTJrOsMeYHop1ekGkVlJc
 vIKpqPd7fnIdYZR/C6WPAho5/DJtWudQgPmuPhBwLHSuKPOGSZKvrNQAMBUDw6u7UyXxAbk
 nNTLcjQ6AtGDdZLdgHuqQ==
UI-OutboundReport: notjunk:1;M01:P0:FrDEWsq5ZYQ=;zH1AEtC15pX9ztM20vfohuMCYfk
 Hr04CilRiOxQnRhmzkFEVFW2inC78CeBF4O4rKxOEROyHB4k0H9nggcYTVRr54ko3Fy6PQerq
 6M4omiOYsB+++9u+HA/gRAhzBR/i7ljIdg7ThhQ5VRVaeFzzowQjRMgoTjq9+dJhCP0ytFBOF
 RKDLaTfqK++26WXVwVBb44UVz6flaTP/Jqk4aRQDb7Vsq94/DYEfzizCcBYUKJvqdFlLC9yqj
 tBHydzP4fxB8XRXFR3CTUeZvy2btdSrQkC/eNuQfLj2NAx7EMdhGU+paO0LBos4dJ2X81ux5H
 3z6dnID0Wkd3xP0300MujTbl32tMpjUDGnWnyQWHCH3mXpXOya3/9yMEYuR0w8ER6YL4fQ9Or
 7ZzhwxN2hnO4Q58soPuHafy1D/D8qpNoNBK/pYOV1FN1x00ZxvWiskWQBHHNUkDWXS9YVXVXP
 qVKgILfxih2sR+iu6qwFciUSn8JFz+haTQ9lFfjJfHn1pYQJOtJEkq2l4rXsWwM3jhrcCSx8J
 +fjQCnYRLC8ydBh+LtCZjF4EqOzYx1bSDlyaL/jX8dJdQLbqr3nbSuRbP5eTCFAnVv2E/zFCe
 g8toWIhQiCIhXn5mfFOf4hpI5QZ4mn+WIqs354zaxOmI1FaqLL+8mPdOp7AygX1Pl1glsAdbM
 JzEJxM3WegXW5ijEzE5rFcaNIjlEwQb5nk3ApTY5qwyzFjUFLZ5EOr2ysvyF6+MEQQhSWWBI3
 JDcS0BHxfuo+qGNSKvwzXO+/5/oBHDA2/owuGWOyJ9U+RR/85ryHFtVwjfur7sDuIE2WjgKSq
 EWdIyeiLajbkMMrvmLBWa2LGNIcCC3tc/0RJ5FxEoY9l8=
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

On 08.07.24 18:04, Heinrich Schuchardt wrote:
> On 08.07.24 17:39, Sam Povilus wrote:
>> add missing table of content links, make alphabetical
>>
>> Signed-off-by: Sam Povilus <sam.povilus@amd.com>
>> ---
>> =C2=A0 doc/usage/fit/index.rst | 21 ++++++++++++++++++---
>> =C2=A0 1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
>> index af2e481212..ed28dc89ae 100644
>> --- a/doc/usage/fit/index.rst
>> +++ b/doc/usage/fit/index.rst
>> @@ -10,9 +10,24 @@ images that it it reads and boots. Documentation
>> about FIT is available in
>> =C2=A0 .. toctree::
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :maxdepth: 1
>>
>> +=C2=A0=C2=A0=C2=A0 beaglebone_vboot
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 howto
>> -=C2=A0=C2=A0=C2=A0 x86-fit-boot
>> +=C2=A0=C2=A0=C2=A0 kernel_fdt
>> +=C2=A0=C2=A0=C2=A0 kernel_fdts_compressed
>> +=C2=A0=C2=A0=C2=A0 kernel
>> +=C2=A0=C2=A0=C2=A0 multi
>> +=C2=A0=C2=A0=C2=A0 multi_spl
>> +=C2=A0=C2=A0=C2=A0 multi-with-fpga
>> +=C2=A0=C2=A0=C2=A0 multi-with-loadables
>> +=C2=A0=C2=A0=C2=A0 overlay-fdt-boot
>> +=C2=A0=C2=A0=C2=A0 sec_firmware_ppa
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signature
>> +=C2=A0=C2=A0=C2=A0 sign-configs
>> +=C2=A0=C2=A0=C2=A0 sign-images
>> +=C2=A0=C2=A0=C2=A0 source_file_format
>
> In patch 1 you delete this page.
>
> Run 'make html' fails on this.
>
> When changing documentation, please, build it.

Got that wrong.

The trailing blank line can be removed when merging.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>
>> +=C2=A0=C2=A0=C2=A0 uefi
>> +=C2=A0=C2=A0=C2=A0 update3
>> +=C2=A0=C2=A0=C2=A0 update_uboot
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verified-boot
>> -=C2=A0=C2=A0=C2=A0 beaglebone_vboot
>> -=C2=A0=C2=A0=C2=A0 overlay-fdt-boot
>> +=C2=A0=C2=A0=C2=A0 x86-fit-boot
>> +
>
> We should avoid trailing blank lines at the end of files.
>
> Otherwise looks good to me.
>
> Best regards
>
> Heinrich
>


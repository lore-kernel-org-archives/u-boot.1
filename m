Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44381C7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 19:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D9682977;
	Thu, 26 Jun 2025 21:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZthTwR8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5670E82B34; Thu, 26 Jun 2025 21:54:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A99E80C83
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1750967665; x=1751572465; i=xypron.glpk@gmx.de;
 bh=aZ1Dgm/PJvSdURV1bEv3YlQjd0y6m/eijAx/e8qm88E=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZthTwR8wYUdVM3wJKH/ZIT2WNcULVYe+7MqizPEG0qqdXKyTXvKCbBauhnY5Pv3g
 +ppQBB3oTrQd8ivgNF4+6vHH1Xhw2pilklgvw9FGoO4rBsD2mhjqX/vE+sW57qA41
 ksRsAW25SSgsStvCauzLtdC1erkG12DKGUxmldZRxtA18kTeC4fRmJ8rLHPl7aY8O
 XdtOvSShJ6LN9c8frfQXB/i28+TkK8N4r1Vx3K6Fvo5rAr6blG3kOSh1y7mXwHtcH
 TRZU4jNV+8Uy9AyF94ZbRUGKouBgIYpeDiaPjLz3emGT/st/b8pTNndXICPkLRx5G
 SQjrsEeYiyiHwjRDpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhUE-1v7Dgj0yiS-00qSfy; Thu, 26
 Jun 2025 21:54:25 +0200
Message-ID: <ef1f4333-e600-4238-a0ca-24fe973558ff@gmx.de>
Date: Thu, 26 Jun 2025 21:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: initialize 'total' variable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
References: <20250625171528.1062540-1-ilias.apalodimas@linaro.org>
 <688f0e0c-7acd-452a-b941-188b76aa9c2f@gmx.de>
 <CAC_iWjJd8RXKG_oUBt-pE7seLOe3h9wS2NZkJDJAHrfarHy2Gw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjJd8RXKG_oUBt-pE7seLOe3h9wS2NZkJDJAHrfarHy2Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pj2iO9z9n2q6KKbyXQydk8cV5hdy+Y8pXE4GwDcMWOP7GeEl0Tv
 L07gQD10GmYWB1PFIIddu56ZlN+JSOt6/9Aps4N0pPuShLee6tCsoDbDiUnEMFXgvu3XXHO
 raBN+gerNjAsn9fqPw14Z8uhIwDayGqo832zzFcy1ri5vnSarL5eII10y4KfUcQpqjBnfI2
 TY8DL9gCXXiDjuXfiPxYw==
UI-OutboundReport: notjunk:1;M01:P0:EX1UofUhrRs=;zngNvo2Mdmwn/taGl1rwHSn5OLE
 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
 i7JZldBjFbgwbajpehSHljeQNq/9qQxQ=
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

On 26.06.25 13:07, Ilias Apalodimas wrote:
> On Thu, 26 Jun 2025 at 11:05, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 25.06.25 19:15, Ilias Apalodimas wrote:
>>> This variable might end up being uninitialized if we exit early.
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> ---
>>>    lib/efi_loader/efi_bootmgr.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr=
.c
>>> index b9437a81c642..662993fb8095 100644
>>> --- a/lib/efi_loader/efi_bootmgr.c
>>> +++ b/lib/efi_loader/efi_bootmgr.c
>>> @@ -1134,7 +1134,7 @@ efi_status_t efi_bootmgr_update_media_device_boo=
t_option(void)
>>>    {
>>>        u32 i;
>>>        efi_status_t ret;
>>> -     efi_uintn_t count, num, total;
>>> +     efi_uintn_t count, num, total =3D 0;
>>
>> 'total' is a non-static local variable.
>> The first line using it in origin/next initializes the variable:
>>
>>       total =3D num;
>>
>> If we exit early, local variables are discarded.
>> Could you, please, explain your concern.
>>
>> Best regards
>>
>=20
> The out: tag uses it on a for loop to free allocated opts[] boot options
>=20
> Cheers
> /Ilias

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>=20
>> Heinrich
>>
>>>        efi_handle_t *handles =3D NULL;
>>>        struct eficonfig_media_boot_option *opt =3D NULL;
>>>
>>> --
>>> 2.49.0
>>>
>>


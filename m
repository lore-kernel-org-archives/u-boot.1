Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C040BC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 12:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB56B8861D;
	Sun, 30 Jun 2024 14:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JQCP8/P2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE9088624; Sun, 30 Jun 2024 14:23:12 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A65E885E1
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 14:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719750188; x=1720354988; i=xypron.glpk@gmx.de;
 bh=OyJu3d2iKcnU3P2OwL1mf0MFaBsUTQoFA7AvCcRsqqo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JQCP8/P2+uFzwWguZY/mEEZJmPgUNK0NqTaiRW/WqnkqAauKrnj38bVPW7PLdImR
 yUbSqmEXUWozTWI/hwhlppKRuWZPPciVduVVvq2xUUq0hdIZLbi3aDKVsPV755Gc9
 Io8zHZ1BrziBcRS+NYEYPZrrSKfPXYksLTv0FMDSze0guk7KlOyHQmpv2JASMe9OV
 CHChAPuZJkK3o/zdasYgY+FWx6WGoGIMQvsNGaK0bOKUUAgZEwqeDjvL3FDcW80NF
 fNY4Kr/oRRqtM9KQUmmEOWvYstDO0sOmm7OPAk4vA3xl3HuNfX6USlLQMwC8vEEPt
 g8WJRrcjdtJQCkRQ1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWzfl-1suasn1gFt-00Jm8D; Sun, 30
 Jun 2024 14:23:08 +0200
Message-ID: <6783af44-4d10-48ff-817d-d0434900319e@gmx.de>
Date: Sun, 30 Jun 2024 14:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: adjust config options for capsule updates
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, jhumphreysti@gmail.com
References: <20240620201531.321110-1-ilias.apalodimas@linaro.org>
 <2a1d9bf4-1790-4186-b8e0-3a5001af9f72@gmx.de>
 <CAC_iWjKLdkbaxFXbogprgcaBMXtVGnp+j0_ED-izZaydQcAxEQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKLdkbaxFXbogprgcaBMXtVGnp+j0_ED-izZaydQcAxEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wd9sQ85MOI9et1Lk3uYFpr/x2MBun0WLQJqCX9ZK2FAOt81no30
 20Hp4r6IDkEjczsjWKFkXynTC3nCrjmEQ09kFVQjwhh19I5ZE7QemtuGkV1ZATWS6C6BOPc
 MaBDo+ka0D+vJrJYaIBcmOmDbNTzttBO565xn/dV3VHCYtS5jy8k7D8bdzFGD4dQ64CHBOR
 RWJ+FrDv4ScrBEVKL77rg==
UI-OutboundReport: notjunk:1;M01:P0:QimtoazP40k=;/9Iu6++Msk1Fqwv2UomBekxZLvo
 2ZGyvEEagQY/hyE8tb3EUG+JeNQPccmLT24JEQj5QFtdHkZ2+6m8zw1kmx7R238EfzjPdxzBm
 AQS5H96GI5kXqYGGwbch4fPk9bCI6AZx87b6M9fzwS6iwiGo83RNtD1e6y/0fRVxDJre9OfMa
 uBGRcJDOvGSckETMPMKra0fpLCti1yczj1oBQdz44Z4KGnAro88YT/NkJTDnZbDwQINerglY6
 BKeuqiI1fd7+OMXsAi7RQwFfkCPHTry1/WuGNc5f4cT6/MwiStJVBFod/TE8EPX33nmRfDVdl
 NHMkpE+CDKR5UiImOrghn/Jrod2qmqxRrYonG+Vo3em68KJ5Mnk7wkgLac8KnjOdLkA+sj8jL
 2BKHaI+rivRiq9uKT+052fEE3fDAAqmE4lathL+kf2ecsag8vsP2yF44yUC+6NwLrqs+QPMIr
 9q+mdL2yJ7z/xmYMu8zdDKOEtUC9GNs++oysVbSNgsDngSbezmrIcmbO3gf05j/jn0Pe6Opyf
 DDV7CbKyRk3CG0xB35Z3r+kxz2sJ1ECHCArNq/y8lMRHycZzI5bXShIAo3JxpP5IPypMDJu6E
 ZBXdYi+X/FaMq4WBJbZrcB5vuBfJr8S2ONjJLkvPlt8jp2k1MpMce6pDIycgDFAN6ct92vWnu
 +BkwNXitHjPXspVa+VTSLzVzD9tmY6O4JdxxM7u37/7ICXrF6rUeZx1yAMfzB+p4almoG3T2S
 +DPPJMunf1vVkBEZN2oAYxEtvRx/4U+T4/Gx6kN0F+QRzHCcDf6wwZW8k3tGcCtYiwGZrMfFu
 GFo2vD3Xqf6hrmlIkRe1hjsD1IHkpegZvyOE8LCkiFjU4=
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

On 6/22/24 18:38, Ilias Apalodimas wrote:
> On Sat, 22 Jun 2024 at 19:36, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 20.06.24 22:15, Ilias Apalodimas wrote:
>>> EFI_IGNORE_OSINDICATIONS is used to ignore OsIndications if setvariabl=
e
>>> at runtime is not supported and allow the platform to perform capsule
>>> updates on disk. With the recent changes boards can conditionally enab=
le
>>> setvariable at runtime using EFI_RT_VOLATILE_STORE.
>>>
>>> Let's make that visible in our Kconfigs and enable EFI_IGNORE_OSINDICA=
TIONS
>>> when set variable at runtime is disabled.
>>>
>>> Since EFI_RT_VOLATILE_STORE needs help from the OS to persist the
>>> variables, allow users to ignore OsIndications even if setvariable at
>>> runtime is enabled.
>>>
>>> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>
>> So this v2:
>
> Yes sorry, forgot to add the tile and log...

With this patch I get a failure on the sandbox in the CI:

https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21382

Without the patch the sandbox runs fine:

https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21383

Best regards

Heinrich

>
>>
>> v2:
>>          allow EFI_IGNORE_OSINDICATIONS if EFI_RT_VOLATILE_STORE=3Dy
>>
>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Thanks Heinrich
>
>>
>>> ---
>>>    lib/efi_loader/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>>> index ee71f417147a..6006e845cb1f 100644
>>> --- a/lib/efi_loader/Kconfig
>>> +++ b/lib/efi_loader/Kconfig
>>> @@ -220,6 +220,7 @@ config EFI_CAPSULE_ON_DISK
>>>    config EFI_IGNORE_OSINDICATIONS
>>>        bool "Ignore OsIndications for CapsuleUpdate on-disk"
>>>        depends on EFI_CAPSULE_ON_DISK
>>> +     default y if !EFI_RT_VOLATILE_STORE
>>>        help
>>>          There are boards where U-Boot does not support SetVariable at=
 runtime.
>>>          Select this option if you want to use the capsule-on-disk fea=
ture
>>> --
>>> 2.43.0
>>>
>>


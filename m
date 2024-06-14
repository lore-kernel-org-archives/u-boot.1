Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646DAC27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 09:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA47888997;
	Fri, 14 Jun 2024 11:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="NNuW5PzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E4088998; Fri, 14 Jun 2024 11:05:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D302587E3F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 11:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718355881; x=1718960681; i=xypron.glpk@gmx.de;
 bh=xdjCHpOrfn2BzbUC0OjxnURLWjJyEgrTpwL4G41PKRk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NNuW5PzIaTdwITMSmv5dJVkCsML/7r3CqwEEFqI5lyljzJWO2uYQxo7LRk9uo69T
 jKSFmrliSgmJLJI1H56mCm1+ODj0o/UTnj52WuUAksoh6O2rFJcgCAAmrcuCGd8zV
 zqDLZTNxvIwoZtG0SsVB4R9WkLDx+/3FPvYYR2uFSHx8BwsaQFW+a4uQYKYlfoRaB
 lz3BbnH3aCA6cBYuL3T+NQN5vd0kSxUCY6ZcVeLVfwfTk5Q1u1Jk4QZlQd4T65/Et
 kFVC5gaFPGTZmro7qGq7pq2OU+rsnu+X46rE/tp3wtRaYbvsniE9JJHJCb3hB0znH
 XXJODJiifJwuQ3rljg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MjS9I-1sgyH502m2-00dkRY; Fri, 14
 Jun 2024 11:04:41 +0200
Message-ID: <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
Date: Fri, 14 Jun 2024 11:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>, Simon Glass <sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VsB2TF9YXxHJ8VkjdzpaJydczVjCoMR9MbAjkQ7FV/bNaGENfpz
 OXZOaDy7eHVwKXPbVip918ltwB7BZhRRL1PbOsWkutqXHd/qpmakHwESTxph+qFaBsCVdNA
 MMKo1dXqGScTU0GeAL+kpn/EQRZ5l8b8niy9grB92q99TZYkegjA81lWipQwatQlY1j4tNT
 wDbfC/1VhMb15/eVLomvg==
UI-OutboundReport: notjunk:1;M01:P0:EgkEwSQC6KM=;hezyGKOgC1deatHOtKDz/n9AJhQ
 vZXaUeZd/svG5T95lW79lR/K6moMIMSPotAlluvUmRRnZqpA4jP3yS69jf84oYDM7LmiZoTTb
 UfGcM8ws4Q6K4uYpvVkj7I2v1Ows6kacanrRxFWC1RWUxzdPJPklyjFItnreTKmR71FVZwdwK
 h5hLe4RIe6JyKIF8lWSlj4w+PwdRr0T0RulBEftNeFqCscfxmuGZeyIF5Khu0S6Yq8gFPOGsF
 tMDsRDxRwQM8Px7np0d9i757yk+cOaXYF5kO9RB+1Xy+YfpgUVj4e653ottLpKFKduleoJEgz
 pavQmBH3LxREnUNh0lQlCgcim336C6pttKuUEL3OdRggjM8cDb7UQ6/Cdf0Wi4HHqYYXVNDYV
 I8Xj8KMb0KSfLm6/pOlTakfyQCfZYBBhPMx0exIyy/FgljsMCHjIvFs77amME3E/EGDD52CgW
 H+tJlDDHFO3bvSc/Ixv5Xrgf7Cp/eo/3O0FMxAAery5ZIhbC+zMFWLcaUEgx9PHGm4+f9JD6m
 WM0H6k5t98/jEFH3gNEld/KxURBJYntXbuwknI+o3QqChxuPQt0IpvqhVkJ4xDV9JDc1PxZRt
 bD1Ertv4Sn7KAShYfmvDBkwNgVfw7q6pw9nTVR5sx8R3r4rXqf/UKdG4ZpIaqcbLrByHmz3p8
 V4tX+vZCZgWCuKloq2+77b/iSeH2/UxaQy3eruYMxnyqrmwuHbKm30YN27eGXF4my7F5K/EvL
 seR0Tyxto+b1J8TFrl0B61IJ/WZiNMatTWStKcx0M4NaJt1vJS6SBCX4b0pwKZsd828fgzldy
 uaV9aGnAfeuwp6cHDkv0WK3ochZFf0J6AGD9JlOikZYKs=
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

On 14.06.24 09:01, Ilias Apalodimas wrote:
> On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 6/14/24 08:03, Ilias Apalodimas wrote:
>>> Hi Simon,
>>>
>>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
>>>>
>>>> It does not make sense to enable all SHA algorithms unless they are
>>>> needed. It bloats the code and in this case, causes chromebook_link t=
o
>>>> fail to build. That board does use the TPM, but not with measured boo=
t,
>>>> nor EFI.
>>>>
>>>> Since EFI_TCG2_PROTOCOL already selects these options, we just need t=
o
>>>> add them to MEASURED_BOOT as well.
>>>>
>>>> Note that the original commit combines refactoring and new features,
>>>> which makes it hard to see what is going on.
>>>>
>>>> Fixes: 97707f12fda tpm: Support boot measurements
>>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Put the conditions under EFI_TCG2_PROTOCOL
>>>> - Consider MEASURED_BOOT too
>>>>
>>>>    boot/Kconfig | 4 ++++
>>>>    lib/Kconfig  | 4 ----
>>>>    2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>>> index 6f3096c15a6..b061891e109 100644
>>>> --- a/boot/Kconfig
>>>> +++ b/boot/Kconfig
>>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
>>>>    config MEASURED_BOOT
>>>>           bool "Measure boot images and configuration when booting wi=
thout EFI"
>>>>           depends on HASH && TPM_V2
>>>> +       select SHA1
>>>> +       select SHA256
>>>> +       select SHA384
>>>> +       select SHA512
>>>>           help
>>>>             This option enables measurement of the boot process when =
booting
>>>>             without UEFI . Measurement involves creating cryptographi=
c hashes
>>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>>> index 189e6eb31aa..568892fce44 100644
>>>> --- a/lib/Kconfig
>>>> +++ b/lib/Kconfig
>>>> @@ -438,10 +438,6 @@ config TPM
>>>>           bool "Trusted Platform Module (TPM) Support"
>>>>           depends on DM
>>>>           imply DM_RNG
>>>> -       select SHA1
>>>> -       select SHA256
>>>> -       select SHA384
>>>> -       select SHA512
>>>
>>> I am not sure this is the right way to deal with your problem.
>>> The TPM main functionality is to measure and extend PCRs, so shaXXXX
>>> is really required. To make things even worse, you don't know the PCR
>>> banks that are enabled beforehand. This is a runtime config of the
>>> TPM.
>>
>> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
>> cannot extend PCRs. So it seems fine to let these two select the
>> complete set of hashing algorithms. As Simon pointed out for
>> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.
>
> It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_extend 8
> 0xb0000000

So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.

TPM v1 only needs SHA-1.

In cmd/tpm-v2.c do_tpm2_pcr_extend() and do_tpm_pcr_read() assume
SHA256. Function tpm_pcr_extend() shows the same limitation. This bug
should be fixed. But as is CMD_TPM_V2 seems only to require CONFIG_SHA256.

Best regards

Heinrich

>
> Regards
> /Ilias
>>
>> Even if U-Boot does not support measured boot (EFI or non-EFI) we might
>> still be using the TPMs RNG.
>>
>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>>>
>>>    So this would make the TPM pretty useless. Can't you remove somethi=
ng
>>> that doesn't break functionality?
>>>
>>> Thanks
>>> /Ilias
>>>>           help
>>>>             This enables support for TPMs which can be used to provid=
e security
>>>>             features for your board. The TPM can be connected via LPC=
 or I2C
>>>> --
>>>> 2.34.1
>>>>
>>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8B0C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFFCA87D4F;
	Fri, 14 Jun 2024 14:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gdiVW/DN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7044287D6B; Fri, 14 Jun 2024 14:18:37 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6612686784
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718367510; x=1718972310; i=xypron.glpk@gmx.de;
 bh=vLHopmAh2dQW/EVksFa0F3oj13SSTpZn+jedBQPeTdE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gdiVW/DN+ti4ghRX7bebVzC70ZvI2P/XYyVoEmkJAhuZQDKmcJFol0uEgUTyligy
 mm6Pmt9e9Bd9S8V9h8rcq/X3okBrLA46yvy88lxDAcboqAoC+I6KCywLicT/w562s
 zm1UP6ffjKPJi6dIjWDBiJ676pMzS8N8bh8LHxSEtup7QuZJbgdT3qyNVykTlKs+/
 zwXfWt6wDR3wDktyapmbtuhOA0RD4pSG7tt59eXxN6Ku8XgI+VSX5Pw0qiEjAaDKq
 48lWaQB6xe78KPInQkritqCx8+tBVX8iPoWvNwWHGvBLH9R4Sb6vw7cFjO4ea1Dhq
 MPeqF08sB7YpLB0sOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1sw5Op05Mf-00fdy4; Fri, 14
 Jun 2024 14:18:30 +0200
Message-ID: <b9d80a2f-0fb9-4219-9c86-aa818d7707e2@gmx.de>
Date: Fri, 14 Jun 2024 14:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: describe UEFI measured boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
References: <20240614094031.6013-1-ilias.apalodimas@linaro.org>
 <ab7c6516-8d03-4561-b4e7-f619799416ba@gmx.de>
 <CAC_iWj+GiFYktbALOd+mZGqPLwe+-+tD_e3MC4E1W=3=mXqz9Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWj+GiFYktbALOd+mZGqPLwe+-+tD_e3MC4E1W=3=mXqz9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0GcIGARIoVAAW+FP+kWrBHsyqQgQkyfLg6opCTyqUJ4833TIfe
 ft6gYrgCgFdfr21P1gnuhFGGZD/xu6bi1HmSIyJI2KxLlDgxwc6cPYG6y5sKDV427WaZtl9
 OMLUWFifMj21eHnvg7PJb4fBpZnD7dC9tTQhjXtqfPUPziLo+zl8D/70WEfs9RiEZBfPH20
 suFaBcAzIayJX26ag/THw==
UI-OutboundReport: notjunk:1;M01:P0:nMgw9YRXiPU=;l09H0vggnpJ4hKMrvCezwZcQve9
 KBw9NvijitdVxJKwMQuNO5pCtIWGxIo+5b6MaEWA07SMhoeINs75gf4CXWKelH5u0mbp24t9N
 9yp0/V0rBYPsC1rUI5Gzk6Hf74RajnbgzB6Ek10pZ8tGsvVPYAybnFPJ2ByLbssE+08Jl3AEX
 xo9HKob8BKEPHmpx1bDtevn0D12JBygM9H3RoUo5YaXPLlP3YTW4cXdQhK13zabTGXoEXuOVe
 H+HOUxOAFKvL14SlbMWCH3YHiKC+lezKuf+zzFNsxN83b4GWSFdA+nmjDEsIKFvAG5sDPWQqE
 kdXZoOBS//GC8BSR/Nbr4P2I3ibtpxJqLUsnpOqDY5WBQ9cCgKCnqsTfKy9RH3Kugn/m3+LN0
 EiT7b+/if8rBoivSWAOkhu/++uK6/rLM1Utm5NfacWw3ORe3N1bimdxUtx/00/JgP1Ggay/zn
 sn+FJ+lsSl2CUkYatKX8+9mFqbm5RoDaslXcC5Y4sOgOVoRg/tmhmYrpAp/3lDThBqDoiQUCt
 qohpEq85RqTtIrtqgd3VgJh+pkLRtidZW8VrKQV4s0//64Cy80FRVuH6cIuYZLvpaoM2IaUb1
 3jUkqJ1ThymCATiQ8aOZxi2ni/LtD2m97OIz9A/t6aQqajovY+vFIZ2xCxQP+pPUX5o0Q9dDj
 UH1/c1WApEQscu/FczHaiHhKNriI0ntI2MZzWLNAdvREmhf1ihZQgAYg4ENDIVrP8lNhq1rIA
 sSSXS8nlDfEI8R8Cnyg/IyDfEymSBblJpZofBu2PLo8KJgs5cd0/fDvt26Hc1E7OL3cDRQXJN
 0DSdhujgLpuDnd4xWSlFUwMUBBKE5okW2LVKk4CNrGVYI=
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

On 14.06.24 12:47, Ilias Apalodimas wrote:
> [...]
>
>>
>>> +
>>> +UEFI requirements
>>> +~~~~~~~~~~~~~~~~~
>>> +* A hardware TPM 2.0 supported by the U-Boot drivers
>>
>> by an enabled U-Boot driver.
>>
>>> +* CONFIG_EFI_TCG2_PROTOCOL=3Dy
>>> +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=3Dy
>>> +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=3Dy will measure the =
loaded DTB in PCR 0
>>
>> Why does this setting not default to yes?
>>
>> Should EFI_TCG2_PROTOCOL_MEASURE_DTB depend on !GENERATE_ACPI_TABLE as
>> we won't load the device-tree in this case?
>>
>> I can't find any reference to device-trees in `TCG PC Client Platform
>> Firmware Profile Specification`.
>
> It's not and I've already pointed this out to Arm. We followed what
> ACPI does there and used "DTB DATA" instead of "ACPI DATA" as the
> event string.
>
>>   Where is PCR 0 for the device-tree specified?
>
> As I said DT is missing from the spec but look below
>
>> I read:
>>
>> "In general, the platform firmware measures into PCR[1] the
>> configuration data that is associated with the code that measured into
>> PCR[0]".
>>
>> This looks like PCR 1 should be the target for the device-tree.
>
> There is a description for ACPI in 3.3.4.1 PCR[0] =E2=80=93 SRTM, POST B=
IOS,
> and Embedded Drivers and they explicitly mention ACPI in there.
> There's no mention of ACPI in 3.3.4.2 PCR[1] =E2=80=93 Host Platform
> Configuration.

3.3.4.1 "PCR[0] =E2=80=93 SRTM, POST BIOS, and Embedded Driver" covers usa=
ge of
EV_POST_CODEs for different PCRs.

EV_POST_CODE is deprecated. That one could be used for ACPI_DATA.

EDK II:

SecurityPkg/Tcg/Tcg2Acpi/Tcg2Acpi.c:660,
SecurityPkg/Tcg/TcgSmm/TcgSmm.c:379,
UefiCpuPkg/Library/SmmCpuFeaturesLib/SmmStm.c:1226 measure with
deprecated EV_POST_CODE, EV_POSTCODE_INFO_ACPI_DATA to PCR[0]. This
seems to include a measurement of the ACPI TPM2 table.

OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c:426 measures with
EV_PLATFORM_CONFIG_FLAGS, EV_POSTCODE_INFO_ACPI_DATA to PCR[1].

MdeModulePkg/Universal/SmbiosMeasurementDxe/SmbiosMeasurementDxe.c:630
measures SMBIOS with EV_EFI_HANDOFF_TABLES to PCR[1].

>
> However ..... In Figure 6 PCR Mapping of UEFI Components ACPI is shown
> in PCR1 .....
> I am not sure if we should use PCR0 or 1, if anyone has a strong
> opinion we can easily change the measured PCR.

According to the cited sentence PCR 1 would make most sense.

>
>>
>> Do we already measure ACPI and SMBIOS tables into PCR1 as required by
>> the specification.
>
> We do measure SMBIOS in PCR1. I don't think we do anything for ACPI.

I guess the ACPI TPM2 table would be needed to access the TCG2 device
(see TCG ACPI Specification).

>
>>
>>> +
>>> +bootm
>>
>> Measured legacy boot with bootm command
>>
>> Please, consider in your description that the bootm command may be used
>> to load a FIT image with an EFI binary.
>
> I am not entirely sure how this works, someone who has used that needs
> to update it. What happens in that case? Does bootm end up calling
> bootefi ? That means we are measuring things twice?

We measure only once:

boot/bootm.c:925:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Skip measurement if EF=
I is going to do it */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (images->os.os =3D=3D =
IH_OS_EFI &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0    IS_ENABLED(CONFIG_EFI=
_TCG2_PROTOCOL) &&
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0    IS_ENABLED(CONFIG_BOO=
TM_EFI))
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;


do_bootm_efi() calls efi_binary_run().

Best regards

Heinrich

>
>>
>>> +-----
>>>    By default, U-Boot will measure the operating system (linux) image,=
 the
>>>    initrd image, and the "bootargs" environment variable. By enabling
>>>    CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree =
image.
>>> @@ -15,8 +35,8 @@ The operating system typically would verify that the=
 hashes found in the
>>>    TPM PCRs match the contents of the event log. This can further be c=
hecked
>>>    against the hash results of previous boots.
>>>
>>> -Requirements
>>> -------------
>>> +bootm requirements
>>
>> This is already a sub-section of bootm. No need to repeat it.
>>
>>> +~~~~~~~~~~~~~~~~~~
>>>
>>>    * A hardware TPM 2.0 supported by the U-Boot drivers
>>
>> by an enabled U-Boot driver.
>>
>>>    * CONFIG_TPM=3Dy
>>
>> CONFIG_TPM_V2=3Dy is required?
>>
>> Best regards
>>
>> Heinrich
>>
>>
>
> Thanks
> /Ilias
>>


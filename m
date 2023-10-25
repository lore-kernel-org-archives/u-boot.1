Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06DAC25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7889871CE;
	Wed, 25 Oct 2023 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qwnmX/lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E4787166; Wed, 25 Oct 2023 15:58:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4294287AD4
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698242320; x=1698847120; i=xypron.glpk@gmx.de;
 bh=piPAMeQtNv7GDxZbnipoly9Zo4XZkJmHox2iTJViD1g=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=qwnmX/lQc8E00sDpw4rfUQz9Bn2Mtb0EVWIadTDa86Hc6G918UjinWFnq/JGbhN2
 OZEjIYLLN4z8PplCq0wZsB9ZqPAvn3HColZhRQMfMWj6X6RvG0ePkjfXjQbUsXWjT
 xvNEdR6U8T40GxSXxRDn2nvguRi6emVmEJ4kwM7RX2rSMC/oVL8rkmpIdnlK0viV3
 7NDTlc7jWmqx6UW9zRb1rmXknBGVy9oyloJ5JwSMTJ+iPcZTl8NvrB9tm9JPGOJDH
 XXzQsPyJ5HwS2aqtefgvfeHYOe0awDsA1gM72h9ZUkmS01cL8Px2nSwhkDgAFBQly
 41nKmm36Jx6+oobwpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1rROBu46ZZ-00fA3Z; Wed, 25
 Oct 2023 15:58:40 +0200
Message-ID: <efeab54a-7a97-4e90-9b2b-8865a3b11e7f@gmx.de>
Date: Wed, 25 Oct 2023 15:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/8] bootm: Support boot measurement
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Eddie James <eajames@linux.ibm.com>, sjg@chromium.org, u-boot@lists.denx.de
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-5-eajames@linux.ibm.com>
 <0459b591-1f22-427d-9b7f-5422dbe789b8@gmx.de>
 <CAC_iWjKMB4rO7tVh9sy7bd=gFEHeZKcwbM7cGkjSb+JkkLi_8Q@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAC_iWjKMB4rO7tVh9sy7bd=gFEHeZKcwbM7cGkjSb+JkkLi_8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LfTsIX+mXM9OstbtH4HsczAB/oei2Lexydds4Dk8NIN2ddyrCZP
 PqnPI4yZj0v65Zkq7M2ZvFp4TfgGwIUR74iZUgpN6IFVbgmGjtbgFqKMQYWDowl3JSCfiF8
 FfIYTg7XOD4gFPCQvPaHCt+m/0xsjgFdmD011cNzrpRv5yIJAi7t2rc6YMJgutwwpo6J8ZB
 711Xj88QB6laskhkOTt2A==
UI-OutboundReport: notjunk:1;M01:P0:EvE5JScvEuA=;Il6+3p0eVxTdA6XHyH996Sg+tBk
 8GRnOFEBZf+eyNtQeW4Mnha8gRnZOVDc3Um5bW35ow0jYP0YsQi+PG7DdBV2d44DEfmyr11ep
 4sNgXEzn6baIkb9FP5oOZubceCH7EHMT7REtqCaeZCKat2S1JgzEODyZTgSJUOOL1IbGkVmEg
 y42C0AgrRcJJluzxCyviZuYVKV2//rIoxXs6cb5z76aZEQj+JS9EY/kBGQUcHpZWyt5ekkXIa
 tne65I63eLsiVQ1JvNCGkmk8IsGFziPSSjN3V0naQmagcqrl0+HQMTP5jvfmj21+PKSFKlL+P
 w/seKVSLiRsPvPbTpPAimTK6/fqfIE9/lDYWXRp5mb8hc9WEBOXaMXWA7mRuQIkZGVCige92j
 kM8PYIsvS6YMqOGTo26/2a02LgVzeIihlhTqy2iYW0l9/UVXYCXSHslIH66sPuLRfNYwxV1kw
 ya3zQIeBKsoJK3pGY/rmM7/gdvRnlVIGcW6zqW+KwqT/a/lWdLvW5EOpjGyIk4o7REePYxNTd
 GIwLFSx6+2zqOHN9VmYOR46OanUXUM5C0EYUc1wHXr8eH3RyZNTP0RfU8FSA7ij/G0/OQd/K/
 gmTLBJzib1YaEPf844A+DXUQDLJqXAewKI2VyOsralYNrP2AQXuyTfHTrDanDCSVTRmGJ+mky
 AsEqMLqblfSVViTr0ipTuEhLDbaopwujFNhvNM1x+BY3gShDboHvd5ARDqXAxIObPxMZsl73t
 1dlDH/hXTGV6zTu/ByoC1W3JIOGcge4KyZCAW7uE8pl5/mlbluIl1o4GZHwMhhvGGTbxLMNs1
 /u1wwVLIj0WXe/Uf7VDONCsz+l8pla1xHBt1/CJqPC+F9uBsiUQyx4wulnB5sEtZ21Xn6iVs9
 5nT5k2FMCyITw6ICzt0fQpsT0NpqAUWaF2eUDFjZDJiga0mz3k8zpT9JMb00/sIzGJl9VwOPM
 zIl4RgVVJS0Wn5EnVIY6coYM4Zg=
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

On 25.10.23 15:21, Ilias Apalodimas wrote:
> On Wed, 25 Oct 2023 at 16:08, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 24.10.23 17:43, Eddie James wrote:
>>> Add a configuration option to measure the boot through the bootm
>>> function. Add the measurement state to the booti and bootz paths
>>> as well.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> ---
>>> Changes since v8:
>>>    - Added a configuration option to select to ignore any existing
>>>      event log. This would only be selected for systems that know
>>>      that U-Boot is the first stage bootloader. This is necessary
>>>      because the reserved memory region may persist through resets
>>>      and so U-Boot attempts to append to the previous boot's log.
>>>
>>> Changes since v6:
>>>    - Added comment for bootm_measure
>>>    - Fixed line length in bootm_measure
>>>
>>>    boot/Kconfig    | 32 +++++++++++++++++++++
>>>    boot/bootm.c    | 74 ++++++++++++++++++++++++++++++++++++++++++++++=
+++
>>>    cmd/booti.c     |  1 +
>>>    cmd/bootm.c     |  2 ++
>>>    cmd/bootz.c     |  1 +
>>>    include/bootm.h | 11 ++++++++
>>>    include/image.h |  1 +
>>>    7 files changed, 122 insertions(+)
>>>
>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>> index a01e6cb8aa..abbc72f4cf 100644
>>> --- a/boot/Kconfig
>>> +++ b/boot/Kconfig
>>> @@ -685,6 +685,38 @@ config LEGACY_IMAGE_FORMAT
>>>          loaded. If a board needs the legacy image format support in t=
his
>>>          case, enable it here.
>>>
>>> +config MEASURED_BOOT
>>> +     bool "Measure boot images and configuration to TPM and event log=
"
>>> +     depends on HASH && TPM_V2
>>> +     help
>>> +       This option enables measurement of the boot process. Measureme=
nt
>>> +       involves creating cryptographic hashes of the binary images th=
at
>>> +       are booting and storing them in the TPM. In addition, a log of
>>> +       these hashes is stored in memory for the OS to verify the boot=
ed
>>> +       images and configuration. Enable this if the OS has configured
>>> +       some memory area for the event log and you intend to use some
>>> +       attestation tools on your system.
>>> +
>>> +if MEASURED_BOOT
>>> +     config MEASURE_DEVICETREE
>>> +     bool "Measure the devicetree image"
>>> +     default y if MEASURED_BOOT
>>> +     help
>>> +       On some platforms, the devicetree is not static as it may cont=
ain
>>> +       random MAC addresses or other such data that changes each boot=
.
>>> +       Therefore, it should not be measured into the TPM. In that cas=
e,
>>> +       disable the measurement here.
>>
>> I guess the device-tree should be measured before fix-ups.
>>
>> A main source of randomness is the KASLR seed.
>>
>> @Ilias: How are we handling this in the EFI case?
>
> We unconditionally strip the KASLR node if EFI_RNG is installed.
> efi_try_purge_kaslr_seed() has a useful comment on how the kernel's
> EFI-stub behaves.
> In any case, we measure selected parts of the DTB, not all of it,
> efi_tcg2_measure_dtb() has the details and we keep the DTB measurement
> under a Kconfig node.

efi_tcg2_measure_dtb() measures all nodes but not the blank areas of the
device-tree.

That seems not to be enough to remove randomness:

* On RISC-V the boot hartid is random (needed in DT for kernel < 5.18).
* MAC addresses are random on many boards.

For the boot hartid maybe we should simply not provide it in the
device-tree if measured boot is enabled. We have an EFI protocol that is
used in newer kernels for this purpose.

Do we really need distinct Kconfig settings
CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB and MEASURE_DEVICETREE? Isn't one
enough to rule both cases?

Best regards

Heinrich

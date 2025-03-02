Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A592C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 15:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A692381197;
	Sun,  2 Mar 2025 16:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="X/uIvSJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88DC806FC; Sun,  2 Mar 2025 16:04:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA4F810ED
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 16:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740927863; x=1741532663; i=xypron.glpk@gmx.de;
 bh=PhPqKmpVPyXZH6rrjd+QX/qi/YAHhNON8NzhBGuioeA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=X/uIvSJu24CaakMOmXuzzMG4BxTeanSQLDWJNihXGHn9FLVTYw948pDmnmXeLrfl
 mzR9E6O+UFpybwgKTOR4Ea6/ukmE2ReSeNqJIE4QCi5IJu1BwtE61bEoZsRWUsQVI
 zG+R8CUWljb6UJv9vbaDQj82LkAMuURXDZ3/ydA+j2Gxoiimq/OS3qISkU814BPjm
 9HkX2m3zxKlFEZ8JN90W6bf//W5LpZyss81Ttk04uOweyLJriIvqte/tKpe4W16R6
 4wMpQus7bEeGA/O15oIPFhk41mZf1CDg+Eub5lm6Vev/JmJ387rvzHtxPF99AmGfs
 PJuzQ0rYurk4/RXldg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1tgxsQ3crM-00WZx3; Sun, 02
 Mar 2025 16:04:22 +0100
Message-ID: <dedab3c6-3d8b-4ec7-9196-5a6ab9c3e752@gmx.de>
Date: Sun, 2 Mar 2025 16:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: =?UTF-8?Q?Pawe=C5=82_Kochanowski?= <pkochanowski@sii.pl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Gabriel Nesteruk <gnesteruk@sii.pl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
 <AM8P191MB1394241D3F057BDCB1F232CFA2CE2@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <AM8P191MB1394241D3F057BDCB1F232CFA2CE2@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:glzUQFneA2vuwXUk1FacoIOoKNNjCaUOFfnwIv4WlzRc2hCMZ3U
 jIuboZ3IHNgZqtbcjOxhIR0Kc+bSIq+ntE+kv1L0WtVcDBXCSSuzTiXfa8yRteWK/T9eJA+
 POfPAObVdv0mV6LEtxgak97KtrU8btnWegeI7ldxA1MZsGUuwy6SaUNlH/vfBmgDJCaUL3F
 wrbwhepOkFrUUkz4RLPbA==
UI-OutboundReport: notjunk:1;M01:P0:4H0Kuc6svu4=;xAz+ofLUm9en+hkcoHPC/Yy2wd8
 +/fxuZtPAVYdmHn6HKAGqe5PoLhJxL2jYo438TXIL0Ar+pDRfL39T9b0ypEaxj7pAHBbJpv+F
 Hs+mYj0km2RXVUUhBBECFwLGIZsAMACucz0Zh6ypw65WcwchUHMAie5LQfJfJooKFSgL2yI8R
 mWES7sr8jvitB938NZrsLEKGu7ikjk2TssxmfKtpTJrbFmu03ZBf3h/6JuA8KbgImsOC2jgzY
 4+R1XC+BJVJNpZLeD5yaKgmPjlRdmf1poXRIfmngR2mQ7jDDoF7PnR3H0vtqdY0nwFB6FEEH9
 SGMUmQ1Ch/73DJcSubXnBGWyemSvbd3+IV2z8XU70lbQuSWcLCyrFIYXPWONzUHxFwfzScuuT
 bmviJRdmJXQG1mV19Mkh2bICkeOhb8xabu2JLRC47TLG7Q1D6mgt6EroEx9JnCVGLYYo0pIJj
 y4fxyBuWsQMnGElKEJagfhAFsXTqvhda2HC2zqL5Gd3wZgoizgynwKET+Xdv2r/dGfNTEmyXv
 hXcFFPWnfWn7lEpOJj+Atm2gpPcCa2jel5nnm21TUzeIMGAWeNcmujEUltjAS9EvizEQ8mR/7
 AWv30JqYfhJZCta6T+I4k5NjTQ04KwHD4zH2ZHXre3qHocrMJbe4SeYNnqYiGIufhDQ7dytlG
 7olFxUQQMO0FZVCiaiqWS/aQvagrauWrex01IU7GJpubtMF/9md4zsTxifcszS3w5zHQ3wWQw
 dNMtb8XXN8a5s2VLucMz+sLb/Hrm7GMUgtGYFC6wIU+3AZIN3zKMrvBN29DKiBeMvnY1ID+mp
 uiX4rSlDueuv08mcq7HVwBQSAtlI1IB3iXCEXYrSfEWY/S5AWTqd7kx1ECkHphaqYClOTs2T6
 yKTMU3LFtBLI/9wmYSPz+UVdkWsnnCyo8ouU7RAd9Qv+nQvwA+wWjHCBU0oFuxujJfvPPMg6c
 gwq5b4yZ4b3QRW4TdTGoRrWb6FgfvUOJz8kAsVmCSoWNUyIGbxM5Dipvo+hjR/j4WZUwaL8xu
 e4Eqd+ZP/y9pdTTm3pVeMw1oZldB8wVbv5M9DG8c5LetQS/1RcUTGTk5aJ0jLjEIsCHGuSymP
 rggGoq1MYHIDHb2Sr/p4bHu0MGDAlCz0nZ2ulO3OQ8KFEhE8tR99X814ALk1zZTEMCIVGy8EG
 HoTdwQwf6PlDkVaYvSi3nKQmiDmC5SFDpsaf1Uwb4IkjBOQRmOee3QKASHUtQ/nbLPd7+ltKU
 woV5aK1cDLV6CAYrualXQ3fMzo5X0nKS2fKg8IAyPoCGLTei0WYQpJgGO4igvBKT9cSRGcQ03
 YvS1jTjCaDS+QCQ/fASiCI2xVoWFaur8t3dRql8kZgYied6yKTOiwU/fOZETuOV+nIymAzJNa
 lBN+HdGHVJw7jQ6u57+KEPb72+bmY6vud1002oj9Ym/+PdIUbVvpSsb0Z9
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

On 3/2/25 13:42, Pawe=C5=82 Kochanowski wrote:
> Hi,
>
>> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Sent: Thursday, February 20, 2025 9:22 AM
>>
>> On 2/20/25 07:58, Ilias Apalodimas wrote:
>>> On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl>
>> wrote:
>>>>
>>>> From: Gabriel Nesteruk <gnesteruk@sii.pl>
>>>>
>>>> U-Boot currently reserves only 0x3000 bytes when copying the FDT in
>>>> `copy_fdt()`, which may not be sufficient if additional nodes (such
>>>> as FMAN firmware) are added later.
>>>>
>>>> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
>>>> to allow users to define the amount of extra space reserved for FDT
>>>> expansion. The default remains 0x3000.
>>>>
>>>> This change prevents potential corruption when resizing FDT after EFI
>>>> boot, especially when firmware like FMAN requires additional space.
>>>>
>>>> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
>>>> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
>>>> ---
>>>>    lib/efi_loader/Kconfig      | 9 +++++++++
>>>>    lib/efi_loader/efi_helper.c | 2 +-
>>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig index
>>>> d4f6b56afaa..bd2cbe995c9 100644
>>>> --- a/lib/efi_loader/Kconfig
>>>> +++ b/lib/efi_loader/Kconfig
>>>> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
>>>>             No additional space will be required in the resulting U-B=
oot binary
>>>>             when this option is enabled.
>>>>
>>>> +config EFI_FDT_EXTRA_SPACE
>>>> +    hex "Extra space to allocate for FDT expansion"
>>
>> Hello Pawel,
>>
>> Is this problem really EFI specific? Wouldn't you have a similar proble=
m when
>> booting via booti?
>>
> Yes it seems that this problem occurs only in EFI as this FDT relocation=
 is done with
> hardcoded size. In other cases the boot_relocate_fdt() is used and
> CONFIG_SYS_FDT_PAD bytes are added instead.
>
> Would it make sense to simply use the config SYS_FDT_PAD also here?
> It already has increased padding size in case FMAN_ENET option is used.
>
>>>> +    default 0x3000
>>>> +    help
>>>> +      Defines additional space (in bytes) reserved for expanding the
>>>> +      Flattened Device Tree (FDT) when passed to the EFI system.
>>>> +      Increase this value if your firmware (e.g., FMAN) needs to add
>>>> +      more data to the device tree after U-Boot relocation.
>>>> +
>>>>    endif
>>>>
>>>>    source "lib/efi/Kconfig"
>>>> diff --git a/lib/efi_loader/efi_helper.c
>>>> b/lib/efi_loader/efi_helper.c index 04b2efc4a3b..91b2a5b8653 100644
>>>> --- a/lib/efi_loader/efi_helper.c
>>>> +++ b/lib/efi_loader/efi_helper.c
>>>> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
>>>>            * needs to be expanded later.
>>>>            */
>>>>           fdt =3D *fdtp;
>>>> -       fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
>>>> +       fdt_pages =3D efi_size_in_pages(fdt_totalsize(fdt) +
>>>> + CONFIG_EFI_FDT_EXTRA_SPACE);
>>
>> This is not the only place where the configuration value needs to be
>> considered:
>>
>> lib/efi_loader/efi_dt_fixup.c:171:
>>                                 0x3000;
>>
>> Could you, please, send a new revision of your patch.
>>
>> Best regards
>>
>> Heinrich
>
> Please let me know if the initially proposed EFI_FDT_EXTRA_SPACE or the
> global SYS_FDT_PAD should be used and I will prepare and test new patch.

Yes, we should use the same Kconfig variable.

The description in

lib/Kconfig:1010:config SYS_FDT_PAD

seems not to match the usage. I have sent
https://lore.kernel.org/u-boot/20250302150231.152179-1-heinrich.schuchardt=
@canonical.com/T/#u

Best regards

Heinrich

>
> BR,
> Pawel
>>
>>>>           fdt_size =3D fdt_pages << EFI_PAGE_SHIFT;
>>>>
>>>>           ret =3D efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
>>>> --
>>>> 2.43.0
>>>>
>>>
>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>


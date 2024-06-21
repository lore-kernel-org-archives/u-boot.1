Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AC2C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9D9D880F1;
	Fri, 21 Jun 2024 17:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oDZQurKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F12D880F1; Fri, 21 Jun 2024 17:25:51 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE2C88027
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 17:25:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718983539; x=1719588339; i=xypron.glpk@gmx.de;
 bh=8BRHKK0rrsINp00zeCMJLLmkxk4wF7shpStdqbGSAxE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oDZQurKb2WqQQNoGmKjxqL2cAaKkIa1f2sx8qJWw58lKNXP6EKujHAVGT0+pMDdK
 lX0AD/7ZJDc6Kep1vxZPdDgSeJ68bMrcw3jWZBny3SNxtztxC9QEz609fvohIkb/U
 hRJq/QN+PBJzZ4ZGL0HIl7bqVZuqe/00FY1x8ZYLTJM5KuqxkXPDFmSzUQV2lAxc6
 ZJ5itLD37iZz1roVNm5XiznHTl6B00cfU/q2NIEwKhTlOqg+dg6Kpli4BvRW3HA+h
 Lr+LJhvgaaKcfYgVARdd+pf+7ca2ZyToZfnxge+aINNhEH/Xu4q0C4q8Vut8PW0oq
 6+4M/kfuqVCwcMPC4Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1sBuhX1SNc-0079oc; Fri, 21
 Jun 2024 17:25:39 +0200
Message-ID: <b2b00963-1ef5-4059-a39b-71f2709426ec@gmx.de>
Date: Fri, 21 Jun 2024 17:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cmd: bootm: add ELF file support
To: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgdC60LDQu9C10YY=?= <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 quentin.schulz@theobroma-systems.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
 <f516756f-93f7-4064-9dbe-abbced5fbd93@gmx.de>
 <CALUeBeD7y=2DJWms46FmRq-T8hZGLAwxbO-GQOGpbVj8DJ0BpQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CALUeBeD7y=2DJWms46FmRq-T8hZGLAwxbO-GQOGpbVj8DJ0BpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NYArQyDLVYW2LzuaT1cKBsgESTKXMxVXADYMLOU2QPGGuWYBY7W
 FB9SRF1dgoC09DqPr982qeMcZvttmXdKMV92OWXXwyH3kNUxBgHO62aeTnguJHw5io4f7yT
 y42tz01JZnohHJHFALd+dLN+6FfsUdA/Q4gOAvgifdJUxehecHVrynhHpa/TC47bwZbeoet
 XcIhmbr11qMLWhLJl8q0w==
UI-OutboundReport: notjunk:1;M01:P0:AIYsFFpwEeY=;EFlo0jUgE4cSRNNvNs1+iOa8inQ
 mdIqwHffqzvO4xpmprERRLb2cxhtmsuiwQhFdY3bvH3ajCboYiJJZEG8SsKeh+JOt9WyZ4M6L
 e/GwbcFY7S0lmo2K79N38bYfm//l723bjGO572VJUuSgDhTCK3mTyt2Au79q//GDEMR5p3g0z
 flCZxfFzbLRJnqPmP3nXE3aB1Ut8qm2imqc59vj5Udg7a4jQ+g1GZxP+F4zWRAPKZim+Y8ULh
 X0rxDiot/PwHhrYqBK0D8dqvHVO8fUOXMo7aMtEX4opFmDKoTophdQw8Tv1oWsyamE5EeWc8Z
 4FMHEEfygBtQvZBSsgJvX2IBL15f6b6nlXXgidrgO71RspigxXepYQgInugeWjN8qfA48AqKe
 DmGI3jrGCD7ogAUJ/azmEzxj/IE7Y3ZUDqkO60o04XooYiejPag4ZAI69gDmWte4AVc+Dpi6R
 Q0D0cbEnNdkNBx25kHaW4CyTFCwCIThtW0igYu3aWLmNP93nt5uStyehCp5lXBJqZ3pPH64VC
 1e7CqDC7sWm7I6/7/JQeAwArppaeLfGfgPXQ/R1WzLbw4P2QYqdB3kytbDGOhO2AGPcVqdP9Q
 RfUZ6B6n8rc5JRJwH4kSNywLpP5fA76k/XHBMlIAXFTFfjUtXteypC0+3DvI6tWJN7/7LRgZv
 MQ9lldXfC27Trwx5McX1QbeUMMs30bxObpYldpVql9ObSAdpIDDJvez8eSXtnJUgW8y8tuxPr
 hKxUbb0a1tDkvrUAOGsb/OFuCm21uz+zGEt+9lAcZH5yZ6vMj0dX2mrmaZZrQxI8ZLEyINri8
 4ocv5tynyPDryMJOdTS/g/oVD80SGbPMONpA3+Fre3+r0=
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

On 6/21/24 16:16, =D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC =D0=9C=D0=BE=D1=81=
=D0=BA=D0=B0=D0=BB=D0=B5=D1=86 wrote:
> =D0=BF=D1=82, 21 =D0=B8=D1=8E=D0=BD. 2024=E2=80=AF=D0=B3. =D0=B2 15:51, =
Heinrich Schuchardt <xypron.glpk@gmx.de>:
>
>> On 21.06.24 13:42, Maxim Moskalets wrote:
>>> Some operating systems (e.g. seL4) and embedded applications are ELF
>>> images. It is convenient to use FIT-images to implement trusted boot.
>>> Added "elf" image type for booting using bootm command.
>>>
>>> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
>>
>> I guess a test could be added to test/py/tests/test_zynqmp_rpu.py which
>> already uses the bootelf command?
>>
>> Is it necessary to use specific hardware to run this test?
>

In Gitlab CI xilinx_zynq_virt_defconfig is used with QEMU parameters
from
https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travis-c=
i/conf.xilinx_zynq_virt_qemu:

qemu-system-arm \
-machine xilinx-zynq-a9 \
-display none \
-m 1G \
-nographic \
-serial /dev/null \
-serial mon:stdio \
-monitor null \
-device loader,file=3Du-boot-dtb.bin,addr=3D0x4000000,cpu-num=3D0

See for instance this build:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/852062

Best regards

Heinrich

>> Heinrich
>>
>>> ---
>>> v5:
>>>        used func from lib/elf.c to avoid dependency form CLI
>>> ---
>>>    boot/bootm_os.c  | 18 ++++++++++++++++++
>>>    boot/image-fit.c |  3 ++-
>>>    boot/image.c     |  5 ++++-
>>>    cmd/Kconfig      |  7 +++++++
>>>    include/image.h  |  1 +
>>>    5 files changed, 32 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
>>> index 15297ddb53..6a6621706f 100644
>>> --- a/boot/bootm_os.c
>>> +++ b/boot/bootm_os.c
>>> @@ -8,6 +8,7 @@
>>>    #include <bootstage.h>
>>>    #include <cpu_func.h>
>>>    #include <efi_loader.h>
>>> +#include <elf.h>
>>>    #include <env.h>
>>>    #include <fdt_support.h>
>>>    #include <image.h>
>>> @@ -394,6 +395,20 @@ static int do_bootm_qnxelf(int flag, struct
>> bootm_info *bmi)
>>>    }
>>>    #endif
>>>
>>> +#if defined(CONFIG_BOOTM_ELF)
>>> +static int do_bootm_elf(int flag, struct bootm_info *bmi)
>>> +{
>>> +     Bootelf_flags flags =3D { .autostart =3D 1 };
>>> +
>>> +     if (flag !=3D BOOTM_STATE_OS_GO)
>>> +             return 0;
>>> +
>>> +     bootelf(bmi->images->ep, flags, 0, NULL);
>>> +
>>> +     return 1;
>>> +}
>>> +#endif
>>> +
>>>    #ifdef CONFIG_INTEGRITY
>>>    static int do_bootm_integrity(int flag, struct bootm_info *bmi)
>>>    {
>>> @@ -535,6 +550,9 @@ static boot_os_fn *boot_os[] =3D {
>>>    #ifdef CONFIG_BOOTM_EFI
>>>        [IH_OS_EFI] =3D do_bootm_efi,
>>>    #endif
>>> +#if defined(CONFIG_BOOTM_ELF)
>>> +     [IH_OS_ELF] =3D do_bootm_elf,
>>> +#endif
>>>    };
>>>
>>>    /* Allow for arch specific config before we boot */
>>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>>> index f6464bcf62..9253f81fff 100644
>>> --- a/boot/image-fit.c
>>> +++ b/boot/image-fit.c
>>> @@ -2175,7 +2175,8 @@ int fit_image_load(struct bootm_headers *images,
>> ulong addr,
>>>                fit_image_check_os(fit, noffset, IH_OS_TEE) ||
>>>                fit_image_check_os(fit, noffset, IH_OS_OPENRTOS) ||
>>>                fit_image_check_os(fit, noffset, IH_OS_EFI) ||
>>> -             fit_image_check_os(fit, noffset, IH_OS_VXWORKS);
>>> +             fit_image_check_os(fit, noffset, IH_OS_VXWORKS) ||
>>> +             fit_image_check_os(fit, noffset, IH_OS_ELF);
>>>
>>>        /*
>>>         * If either of the checks fail, we should report an error, but
>>> diff --git a/boot/image.c b/boot/image.c
>>> index fc774d605d..abac254e02 100644
>>> --- a/boot/image.c
>>> +++ b/boot/image.c
>>> @@ -130,7 +130,10 @@ static const table_entry_t uimage_os[] =3D {
>>>        {       IH_OS_OPENRTOS, "openrtos",     "OpenRTOS",            =
 },
>>>    #endif
>>>        {       IH_OS_OPENSBI,  "opensbi",      "RISC-V OpenSBI",      =
 },
>>> -     {       IH_OS_EFI,      "efi",          "EFI Firmware" },
>>> +     {       IH_OS_EFI,      "efi",          "EFI Firmware"          =
},
>>> +#ifdef CONFIG_BOOTM_ELF
>>> +     {       IH_OS_ELF,      "elf",          "ELF Image"             =
},
>>> +#endif
>>>
>>>        {       -1,             "",             "",                    =
 },
>>>    };
>>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>>> index a2dee34689..613baa106e 100644
>>> --- a/cmd/Kconfig
>>> +++ b/cmd/Kconfig
>>> @@ -321,6 +321,13 @@ config BOOTM_EFI
>>>        help
>>>          Support booting UEFI FIT images via the bootm command.
>>>
>>> +config BOOTM_ELF
>>> +     bool "Support booting ELF images"
>>> +     depends on CMD_BOOTM && LIB_ELF
>>> +     default n
>>> +     help
>>> +       Support booting ELF images via the bootm command.
>>> +
>>>    config CMD_BOOTZ
>>>        bool "bootz"
>>>        help
>>> diff --git a/include/image.h b/include/image.h
>>> index c5b288f62b..9daaee15cd 100644
>>> --- a/include/image.h
>>> +++ b/include/image.h
>>> @@ -100,6 +100,7 @@ enum {
>>>        IH_OS_TEE,                      /* Trusted Execution Environmen=
t */
>>>        IH_OS_OPENSBI,                  /* RISC-V OpenSBI */
>>>        IH_OS_EFI,                      /* EFI Firmware (e.g. GRUB2) */
>>> +     IH_OS_ELF,                      /* ELF Image (e.g. seL4) */
>>>
>>>        IH_OS_COUNT,
>>>    };
>>
>>


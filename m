Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DAEE64A88
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 12:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB86893A9;
	Tue,  3 Dec 2024 13:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AI3ywctx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE5A8921A; Tue,  3 Dec 2024 13:41:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9DB893D9
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 13:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733229666; x=1733834466; i=xypron.glpk@gmx.de;
 bh=vB8q+NzRU6SRTkFe5TNfBNOEVfl1GGDjB1h7MSHZ/zk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AI3ywctxscqgDNuvbzBLUAvYFYEY0AJjNni5FOqJEUvxIctKBKr88dWWrmEdY/tG
 l2JQuushK9lRpDNPTFSg+0ZZ1CW+q843KawaKHducCwJ4l7m/VJDmE05g2jgP5ttC
 TGPi+cK+QbH31OXUeIc2rXetvfL2HjvteZjpIkbyem9roozBPddtRzih6uw2F5z/L
 OPp4890GTCFwOmhDpwztAJnImUlMJrxoLro0L14sh3OtrWnRzMKFytA2nDCASipCf
 qs+4193rVWBlJyAVz6XT7nin1wJhBlT0yw5yxqTzTkRpwNAMmWeOpSiQBMXDY3z5U
 KP6d272bhA+lP7n1Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1trF8D2uyh-00lQ9g; Tue, 03
 Dec 2024 13:41:06 +0100
Message-ID: <b5a14d41-587d-45fd-a1d7-a02ed09eab5b@gmx.de>
Date: Tue, 3 Dec 2024 13:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] efi: Show the location of the bounce buffer when
 debugging
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Moritz Fischer
 <moritzf@google.com>, Simon Glass <sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
 <20241201152815.1668093-7-sjg@chromium.org>
 <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CADg8p946omqMf9QAzwU_Aa6wbPFkfO3sUpAWebn1DraUoN7rUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P2Lu/UP6PCJgRWwYlzyZL3ShB/f3VSowlxqB3nrGtE8TNmLgSu3
 3yonXS0wPCLISGek/niQgRJs1EM2o+zL5yk0nXCZTb1EtnrfE3YMugPSP2F2m83XiC61MH3
 9D9fyayrkOh5DXqcp/ONVykqpDXJSzo8+tyAHEIIyc+NxLeLv5B0TFEgMTVYx6h1SIQ28bg
 n11mE8RITjtS6EZ+cFaYw==
UI-OutboundReport: notjunk:1;M01:P0:tOSfkbKkIsA=;s+VfzvzfLov9H5+tXG+SHyviTP+
 X4cSIcj9UZCHWilCL8wZzyrgOidxihu2Joxbp+lTf0VhPwZP8lf/rYzy9O/+HCMc6MaqggQsJ
 LjuYwevi3zHc/k/zDy9anZbYPvxHs1/pWM3thcdQaWMyHtPD0IiXEsffVML0+Lw5XU7DKaarn
 6k2rJgh2hswrlVwKG+b2+36AsTY4h5KKvmY+IaxNHoXlFaJBria4kxUVxp9Uf99B6h0UQ+vU6
 FWoZYWeZQ5P6yQKEELi8GhWWeHR6mfRhOS33Eb04KVthYVVyWQh1RmY4KZEDiiwS6ESpgciUM
 fYLi918F2so3+xY9phfrkWwt/oTYJcK4GcAIKjFUpPKgvjh5SkjKT4fHZzuOkeSCXaIgvSN8j
 0FD3bR2VVl8Ow5qr2j2TUdvSDfdW1yKwUYQFBPwh523NDRu4Uw0mbDqjqTcNVmZVso922AKmG
 yzgpWHgEjHuLY+ADEEgww35pwTcbtu74tiIprCusMs+q6AomIqLsIMSJYW4ViMHxcpi9cDH+6
 jLEgMEZR0ZcBl/4+Cjxtj9fr2Xf/417aNkPg6rC5FPCCy8plO99y7oYO2LfExyYy8Xs2YMoXB
 vOqlVFiveE42DCL+wljA2w5sCxSln15VSuHDmIwTTC7UNnvj4k00luNSAf7mml9XwmX/1+UTw
 XNBc6XT8v6Fu3/BACptGB+kEG71SDEqtBhw+RKPYy1Tm3acrL/IcmqfovryaNWRJYVq13Nkl2
 NkwhcO2CTwzLe+rRy0whDkNYBwZQSclru9OT7x+dCP4ufs5thII1t7yEqRmgaKlDg4SJZPdsl
 cxoPuaUkjpYjb+XL5AuxQA+UXbsA8LyKklQ8moYc3I1qMT/4l4gf5DL96FI8AT1OT3L0iTE5q
 ryx1570Qnnjuhtsr43tVCR392ffLDHs+229kTH4eQKoZ6zGwvLV6RE+D/LeDSr7UHwaxRhdgB
 pBNbjwfjK5MDaCIfbeq1cLA5erZMghSjo4jkN5PRyyFXfnH6lr3FwRIpzMVnjvmYOsVxlllLr
 xliq1v7uVxt/THsPBthYyT4tYsjzX3h3jhdcXkzxFy6wiC6KDhyzhxauEJG9oAPqvnb5z0Mdc
 xu7UiN6KGJ2GyCOyI/0od81sMzOU8v
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

On 03.12.24 13:06, Sughosh Ganu wrote:
> On Sun, 1 Dec 2024 at 20:58, Simon Glass <sjg@chromium.org> wrote:
>>
>> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is
>> still needed and 24 boards (lx2160ardb_tfa_stmm,
>> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
>>
>> This feature uses EFI page allocation to create a 64MB buffer 'in space=
'
>> without any knowledge of where boards intend to load their images. This
>> may result in image corruption or other problems.
>>
>> For example, if the feature is enabled on qemu_arm64 it puts the EFI
>> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
>> 1088MB. The kernel is probably smaller than 27MB but the buffer does
>> overlap the ramdisk.
>>
>> The solution is probably to use BOUNCE_BUFFER instead, with the EFI
>> version being dropped. For now, show the address of the EFI bounce
>> buffer so people have a better chance to debug any problem.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>> In response to questions on how to show this problem:
>>
>> First, add CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dy to
>> configs/qemu_arm64_defconfig and build
>>
>> Then, to run:
>> qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 \
>>     -bios u-boot.bin
>>
>> U-Boot 2024.10-00809-gae29e5f76e4a-dirty (Oct 11 2024 - 11:48:46 -0600)
>>
>> DRAM:  128 MiB
>> Core:  51 devices, 14 uclasses, devicetree: board
>> Flash: 64 MiB
>> Loading Environment from Flash... *** Warning - bad CRC, using default =
environment
>>
>> In:    serial,usbkbd
>> Out:   serial,vidconsole
>> Err:   serial,vidconsole
>> No USB controllers found
>> Net:   eth0: virtio-net#32
>>
>> starting USB...
>> No USB controllers found
>> Hit any key to stop autoboot:  0
>> =3D> bootefi hello
>> Enabling coop memory
>> No EFI system partition
>> No EFI system partition
>> Failed to persist EFI variables
>> Missing TPMv2 device for EFI_TCG_PROTOCOL
>> Missing RNG device for EFI_RNG_PROTOCOL
>> Warning: EFI bounce buffer 000000004157f000-000000004557f000
>> Not loaded from disk
>> Booting /MemoryMapped(0x0,0x47763730,0x31b0)
>> EFI: Call: efi_load_image(false, efi_root, file_path, source_buffer, so=
urce_size, &handle)
>> EFI: 0 returned by efi_load_image(false, efi_root, file_path, source_bu=
ffer, source_size, &handle)
>> Hello, world!
>> Running on UEFI 2.10
>> Firmware vendor: Das U-Boot
>> Firmware revision: 20241000
>> Have device tree
>> Load options: <none>
>> File path: <none>
>> Boot device: /MemoryMapped(0x0,0x47763730,0x31b0)
>> =3D> print kernel_addr_r
>> kernel_addr_r=3D0x40400000
>> =3D> print ramdisk_addr_r
>> ramdisk_addr_r=3D0x44000000
>> =3D>
>>
>> The EFI bounce buffer overlaps with the ramdisk.
>
> Why can't we "allocate" sane values for the env variables in question,
> similar to what is being done for the apple and qcom boards -- you can
> refer to arch/arm/mach-apple/board.c:board_late_init(). We won't be
> facing these issues then. Eventually, there can be a common, platform
> agnostic function to initialise these values. So, just as a PoC, I
> added this code to the qemu-arm.c, and no longer observe any overlaps.
>
> diff --git a/board/emulation/qemu-arm/qemu-arm.c
> b/board/emulation/qemu-arm/qemu-arm.c
> index 6095cb02b23..bad787f7a65 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -109,6 +109,9 @@ int board_init(void)
>
>   int board_late_init(void)
>   {
> +
> +       u32 status =3D 0;
> +
>          /*
>           * Make sure virtio bus is enumerated so that peripherals
>           * on the virtio bus can be discovered by their drivers
> @@ -119,6 +122,14 @@ int board_late_init(void)
>          if (CONFIG_IS_ENABLED(USB_KEYBOARD))
>                  usb_init();
>
> +       status |=3D env_set_hex("loadaddr", lmb_alloc(SZ_2M, SZ_2M));
> +       status |=3D env_set_hex("fdt_addr_r", lmb_alloc(SZ_2M, SZ_2M));
> +       status |=3D env_set_hex("kernel_addr_r", lmb_alloc(SZ_2M, SZ_2M)=
);
> +       status |=3D env_set_hex("ramdisk_addr_r", lmb_alloc(SZ_8M, SZ_2M=
));

Hello Sughosh,

avoiding fixed addresses would make sense for most boards.

Your suggested memory reservations for the kernel and initrd are way too
small. On my system I find

decompressed kernel - 67 MiB
initrd - 77 MiB

scriptaddr is missing.

ARM have address restrictions (see function efi_get_max_initrd_addr()):

armv7:
max_init_rd_addr =3D
round_down(image_addr, SZ_4M) + SZ_512M

armv8:
#define VA_BITS_MIN          (48)
max_init_rd_addr =3D
round_down(image_addr, SZ_1G) + (1UL << (VA_BITS_MIN - 1))

These are not modeled in your suggestion.

I would suggest to make a single <=3D 512 MiB allocation for both initrd
and kernel to keep both together and then assign the addresses in the
allocated area, e.g.

kerneladdr =3D lmb_alloc(SZ_512M, SZ_4M);
if (!kerneladdr)
	goto err;
if (env_set_hex("kernel_addr_r", kerneladdr))
	goto err;
if (env_set_hex("initrd_addr_r", kerneladdr + SZ_256M))
	goto err;

Best regards

Heinrich

> +
> +       if (status)
> +               log_warning("late_init: Failed to set run time variables=
\n");
> +
>          return 0;
>   }
>
>
> U-Boot 2025.01-rc3-00042-gacab6e78aca7-dirty (Dec 03 2024 - 17:17:42 +05=
30)
>
> DRAM:  512 MiB
> EFI bounce buffer 000000005957f000-000000005d57f000
> Core:  51 devices, 14 uclasses, devicetree: board
> Flash: 64 MiB
> Loading Environment from Flash... *** Warning - bad CRC, using default
> environment
>
> In:    serial,usbkbd
> Out:   serial,vidconsole
> Err:   serial,vidconsole
> No USB controllers found
> Net:   eth0: virtio-net#31
>
> starting USB...
> No USB controllers found
> Hit any key to stop autoboot:  0
>
> =3D> bdinfo
>
> ...
>
> lmb_dump_all:
>   memory.count =3D 0x1
>   memory[0]    [0x40000000-0x5fffffff], 0x20000000 bytes, flags: none
>   reserved.count =3D 0x3
>   reserved[0]    [0x58600000-0x593fffff], 0xe00000 bytes, flags: none
>   reserved[1]    [0x5957c000-0x5d57efff], 0x4003000 bytes, flags:
> no-notify, no-overwrite
>   reserved[2]    [0x5d57fde0-0x5fffffff], 0x2a80220 bytes, flags: no-ove=
rwrite
>
> ...
>
> =3D> printenv kernel_addr_r
> kernel_addr_r=3D58e00000
> =3D> printenv ramdisk_addr_r
> ramdisk_addr_r=3D58600000
> =3D> printenv fdt_addr_r
> fdt_addr_r=3D59000000
> =3D> printenv loadaddr
> loadaddr=3D59200000
>
> -sughosh
>
>>
>> Changes in v5:
>> - Drop the word 'warning'
>>
>> Changes in v4:
>> - Reword the commit message since this feature is needed
>>
>>   lib/efi_loader/efi_bootbin.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.=
c
>> index 7e7a6bf31aa..9a880251b47 100644
>> --- a/lib/efi_loader/efi_bootbin.c
>> +++ b/lib/efi_loader/efi_bootbin.c
>> @@ -208,6 +208,15 @@ efi_status_t efi_binary_run(void *image, size_t si=
ze, void *fdt)
>>                  return -1;
>>          }
>>
>> +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
>> +       /*
>> +        * Add a warning about this buffer, since it may conflict with =
other
>> +        * things
>> +        */
>> +       log_debug("EFI bounce buffer %p-%p\n", efi_bounce_buffer,
>> +                 efi_bounce_buffer + EFI_LOADER_BOUNCE_BUFFER_SIZE);
>> +#endif
>> +
>>          ret =3D efi_install_fdt(fdt);
>>          if (ret !=3D EFI_SUCCESS)
>>                  return ret;
>> --
>> 2.43.0
>>


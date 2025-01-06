Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B273E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 12:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA32A801E8;
	Mon,  6 Jan 2025 13:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GtJpSr3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0CC801DE; Mon,  6 Jan 2025 13:40:27 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A4C801E8
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 13:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so1740589866b.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 04:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736167224; x=1736772024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zVTpcESkqHQEegCxBUh64McRPrXPE1Kd+qs8G/nrWo0=;
 b=GtJpSr3qucjfmM3Kjj/wXZV/cNatMjmZ2RWlbYmglB6Uevfj0QGhlO0UVbqF3w2qcA
 +SJ5sLhvPdOXt1vFBgMTY5/rnq+7el/WpeHk/YAEE1mO9BVoiyn/jYJvaIGQTbPOHt0j
 jGqcC/7FrvoontU1ccqYMXepM56tryoJDJS/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736167224; x=1736772024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVTpcESkqHQEegCxBUh64McRPrXPE1Kd+qs8G/nrWo0=;
 b=LTQJ2FEFuCqeTDq0KRE3Wz53Fi2AjnOGgoA/1VdjXYVIXBX5UEKAzHZH7uN6t4hTNG
 3qyS4l29k29t38qNu2O/Xv7n7gNDFuJjYzcnGNZOtOsILTa9QPFHcJY52YKD+Yl11qFF
 d1qkG73/NUrKm/fWLjr03fC3W0AyxBdSCATGdVRTAkNUqU2VQKfcFsI5nIP+hzp8JPL2
 yQq3ws6//I/62RfKGf5vZgg4wlP+ZQcVF9X1lVB7ADCXzDRn0826F5svJCp0elgYKnxP
 oK7bkpXYhXWoItclpdFw11r/UjpHnOvaUnjxRsY6SURRhcFnkZ7yuksNKmCjnh8p8tvb
 xPRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsSl0TeK1zeBlOw2gBArwaiFO1NDIbNwmX2pcYJk6uUPenGViOOawuReDNb/3n2Q8Fd/xwUiw=@lists.denx.de
X-Gm-Message-State: AOJu0YzpLHVAPeMOs6l9Q/x3UyArhILO4kfFWPtoRhp+2mfUrmtMRIpB
 1AVJSvI79kVMs4YzewH3W/AOOP8Mh+CedqK+4MDhfUJkc/Y4BywSMDOpWNeyQ7FpirO3tdRJ2Cg
 Kz/BM0K0QHw3lH4LXS8iXNVATFsN1YFdDtwoZ
X-Gm-Gg: ASbGncuR7cHpJ12vIK4GFMtrbvzMx7py0OT4zGi1B1eAUFsKDYHtlAkJPv9IQ+6wE72
 bf3qt85ZSiwL777GzjVfkh4UNeKSNaB+0gDfqYp4=
X-Google-Smtp-Source: AGHT+IH6wAlzjHXToogdl4NrOxoi4odTfHj+ygDM/S03Js1UUVRWbbZNd1jSJzGwb7aZsUFGSrQnuha/9yRnQ90tyGQ=
X-Received: by 2002:a17:907:60cf:b0:aa6:7df0:b17a with SMTP id
 a640c23a62f3a-aac334c8b40mr4334201166b.34.1736167223781; Mon, 06 Jan 2025
 04:40:23 -0800 (PST)
MIME-Version: 1.0
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
 <20241128114737.2.I03b59e1d26d2a79a666adc8ef313077da8dce145@changeid>
 <c31b3d7a-c840-4b3d-a6fe-90f9a576ffb4@gmx.de>
 <CAFLszTikmQfBsQTJ5FLfvOv2GgPWPj0GyDCoCxYnXVtbruvf-A@mail.gmail.com>
 <3EE77A40-CD92-4330-B66D-7F00CCEA7BE4@gmx.de>
 <3a7f8b43-288c-4951-a781-c9d7139bab2a@rock-chips.com>
In-Reply-To: <3a7f8b43-288c-4951-a781-c9d7139bab2a@rock-chips.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 05:40:11 -0700
Message-ID: <CAFLszThJusDaM+LxVk3o+Ooiu02Bzt7uJvj7wDX-qcU_eXO7vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] config: efi-x86_payload: Enable DEBUG_UART
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Kever,

On Sun, 5 Jan 2025 at 23:47, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Heinrich and Simon,
>
>      I send these two change because I want to fix the build error
> below(from[1]) which is for disable the DEBUG_UART[2].
> Do you have clear suggestion on how to do this in efi_stub, since I have
> no idea about this module, so I just follow how
> it works in other serial driver.
> +/binman/rom/intel-mrc (mrc.bin):
> +Image 'rom' has faked external blobs and is non-functional:
> descriptor.bin me.bin refcode.bin vga.bin mrc.bin
> +In file included from lib/efi/efi_stub.c:12:
> +include/debug_uart.h:205:9: error: stray '#' in program
> +  205 |         #warning "DEBUG_UART not defined!"
> +      |         ^
> +lib/efi/efi_stub.c:91:1: note: in expansion of macro 'DEBUG_UART_FUNCS'
> +   91 | DEBUG_UART_FUNCS
> +      | ^~~~~~~~~~~~~~~~
> +include/debug_uart.h:205:18: error: expected '=', ',', ';', 'asm' or
> '__attribute__' before string constant
> +      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> +lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not
> used [-Werror=unused-function]
> +   86 | static void _debug_uart_putc(int ch)
> +      |             ^~~~~~~~~~~~~~~~
> +make[3]: *** [scripts/Makefile.build:257: lib/efi/efi_stub.o] Error 1
> +make[2]: *** [scripts/Makefile.build:398: lib/efi] Error 2

Yes, I see what you are doing.

The real fix is probably to not use the debug UART in the stub. There
is a large comment:

 * EFI uses Unicode and we don't. The easiest way to get a sensible output
 * function is to use the U-Boot debug UART. We use EFI's console output
 * function where available, and assume the built-in UART after that. We rely
 * on EFI to set up the UART for us and just bring in the functions here.
 * This last bit is a bit icky, but it's only for debugging anyway. We could
 * build in ns16550.c with some effort, but this is a payload loader after
 * all.
 *
 * Note: We avoid using printf() so we don't need to bring in lib/vsprintf.c.
 * That would require some refactoring since we already build this for U-Boot.
 * Building an EFI shared library version would have to be a separate stem.
 * That might push us to using the SPL framework to build this stub. However
 * that would involve a round of EFI-specific changes in SPL. Worth
 * considering if we start needing more U-Boot functionality. Note that we
 * could then move get_codeseg32() to arch/x86/cpu/cpu.c.

We don't have a way of building the same file twice (once for the stub
and once for U-Boot). That would require my split-config series - Tom
rejected the last 10 patches (which actually did the work) a few years
ago[1]. But I do plan to get back to it.

For now, I suggest adding a new Kconfig, .e.g DEBUG_UART_DUMMY
(dependent on DEBUG_UART) which defines the dummy functions. Set it to
y by default, but n for the EFI-stub builds. Then you don't need to
enable the debug UART here.

Regards,
Simoon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=341504&state=*


>
> Thanks,
> - Kever
> [1] https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/jobs/987462
> [2]
> https://patchwork.ozlabs.org/project/uboot/patch/20240918130155.299353-2-lukasz.czechowski@thaumatec.com/
>
> On 2025/1/5 07:02, Heinrich Schuchardt wrote:
> > Am 4. Januar 2025 20:29:43 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >> Hi Heinrich,
> >>
> >> On Sat, 4 Jan 2025 at 05:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>> On 28.11.24 04:47, Kever Yang wrote:
> >>>> The efi_stub is useing DEBUG_UART interface by default, Enable it.
> >>> As Simon already wrote in a code comment the implementation of the EFI
> >>> stub is broken as it is not hardware agnostic.
> >> If I said that I was wrong, sorry. Actually that is the stub's intent,
> >> to take over the machine, exit boot-services and carry on. It is the
> >> EFI app which is designed to use boot services.
> >>
> >> So the stub cannot be hardware-agnostic, unfortunately. It only runs
> >> on x86 hardware, unless, for example, EFI has something like
> >> serial_getinfo() or we disable the UART / keyboard input.
> > I would assume that there is no serial console that the user has access to on many x86 systems (like on my laptop).
> >
> > In the stub itself we can use the Simple Text Output Protocol and the Simple Text Input Protocol offered by the UEFI implementation that started the stub.
> >
> > The UEFI specification defines a Serial Io Protocol which may be implemented but I would not know why we should restrict the usability in this way.
> >
> > Once we start U-Boot of course we will use hardware specific IO, e.g. on a RISC-V system use the debug console offered by the SBI
> >
> > Best regards
> >
> > Heinrich
> >
> >>> In the EFI stub we should never directly access hardware. Please, use
> >>> SimpleTextOutputProtocol.OutputString() for printing.
> >> Once the stub starts, boot services are gone. See efi_main() for how
> >> this works. There is a definite point at which we stop using that and
> >> start using U-Boot's own thing.
> >>
> >> At this point I think I may be misunderstanding what you said...
> >>
> >>>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> >>>> ---
> >>>>
> >>>>    configs/efi-x86_payload32_defconfig | 1 +
> >>>>    configs/efi-x86_payload64_defconfig | 1 +
> >>>>    2 files changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/configs/efi-x86_payload32_defconfig b/configs/efi-x86_payload32_defconfig
> >>>> index 071ddb8e36d..f0b9acc358d 100644
> >>>> --- a/configs/efi-x86_payload32_defconfig
> >>>> +++ b/configs/efi-x86_payload32_defconfig
> >>>> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
> >>>>    CONFIG_PRE_CON_BUF_ADDR=0x100000
> >>>>    CONFIG_VENDOR_EFI=y
> >>>>    CONFIG_TARGET_EFI_PAYLOAD=y
> >>>> +CONFIG_DEBUG_UART=y
> >>> On x86 this uses the NS16550 UART driver. This is fine as long as we
> >>> don't use the debug UART in the EFI stub. But correcting this is for a
> >>> separate patch.
> >>>
> >>> Having a debug UART available after the EFI stub makes sense.
> >>>
> >>> I will update the commit message when merging.
> >>>
> >>> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>
> >>>>    CONFIG_EFI=y
> >>>>    CONFIG_EFI_STUB=y
> >>>>    CONFIG_FIT=y
> >>>> diff --git a/configs/efi-x86_payload64_defconfig b/configs/efi-x86_payload64_defconfig
> >>>> index 71612d7fb19..b02a861e59c 100644
> >>>> --- a/configs/efi-x86_payload64_defconfig
> >>>> +++ b/configs/efi-x86_payload64_defconfig
> >>>> @@ -5,6 +5,7 @@ CONFIG_DEFAULT_DEVICE_TREE="efi-x86_payload"
> >>>>    CONFIG_PRE_CON_BUF_ADDR=0x100000
> >>>>    CONFIG_VENDOR_EFI=y
> >>>>    CONFIG_TARGET_EFI_PAYLOAD=y
> >>>> +CONFIG_DEBUG_UART=y
> >>>>    CONFIG_EFI=y
> >>>>    CONFIG_EFI_STUB=y
> >>>>    CONFIG_EFI_STUB_64BIT=y
> >> Regards,
> >> Simon
> >

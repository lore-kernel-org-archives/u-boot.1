Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64242C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 04:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5551386F85;
	Sun,  5 Nov 2023 05:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DsztrHrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E019586F91; Sun,  5 Nov 2023 05:12:39 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3140986F84
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 05:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5C05940628
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 04:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699157550;
 bh=9Ct6HzK/Aj1IPwpCb2j53QT2rdSv4VIQzqgEQg89xnE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=DsztrHrVb9IzEmPDizD5yW5zfuzDmK0xqF56CkC79XkxBnZepsaflS/QkwCJn0XGO
 N3pdXUC7pUuBcmQuAUajNzsTNj4wipSbEsG8w2y54qlTvF0/3YzkjBKkNF6qQzQB75
 RcOXFOHpRVZWqnrt+jd+e+a4I9LvTLKEDRPqLXzz1uvfK2HUuHl58AlqF135uj68HC
 /+5IoDsh7RaNjJZg60U4/yhXvqPjlZ6+iKqT0DUTewMy1s+DEfsrYMfrZk+tSOtBbd
 Jxa9UZWUut9tknuRI+PhaetCHeK9tovKYgfsqkxIB6Nx8rdRcDDq/lVMnimiMVF1Ps
 uEAUl9xrwpIHA==
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507b0270b7fso3266335e87.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 21:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699157549; x=1699762349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ct6HzK/Aj1IPwpCb2j53QT2rdSv4VIQzqgEQg89xnE=;
 b=N48nv6uMT7YT2jkEAcsneldAiWjG+QRmnPUcsQq/F21HeUNFp9RxjvuIO2tioVBevm
 /LAMo52wBpoF5+7uZYITERfRfZvQ1D1ecf/gYuGsIcGuJTK3K5WHY0lkrZUGtAKXGtgx
 s3HqdfPxnJ9PFAgO1VsVsGN+H4C9OMI0yPlCRo494hsEIWlZoIOADbxm/LQmr1Wn40NQ
 Q25fdLCcPUYJGd+MvvV9w0I7B3B/wK8qQAMRFzGCRHKNZ8p0T056M7cy/uY66m54uk6P
 qY/mLwhxlE8UH9Lq8e5rc+UQMRurf58AFBn1F+oJqIr1ECvVue39ADXdFLFVQUsCeE0L
 IgfQ==
X-Gm-Message-State: AOJu0YxYj58u66en3iRy26tewE2jvXia46tVYv0rxB9tWfpI9CPqGUe4
 QilZybM0UUp6/EUQTIXKY4RcldWdd01w4fdk+u/0pSp98lRbS0mlFJJV4Lhq0HDjqM8s0hXjnN6
 sE6ZoyBGKQvMZ24FHjljCNcxmykDi7TA=
X-Received: by 2002:a19:8c19:0:b0:507:b9e9:3e8d with SMTP id
 o25-20020a198c19000000b00507b9e93e8dmr19417382lfd.28.1699157549506; 
 Sat, 04 Nov 2023 21:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQfJoSQnH5+hJeqmfr0NeF2nvaUlRmaspGLaWgHFQXOzq2ZY+v/JneD4KEziZVzw9Bmd+ZRQ==
X-Received: by 2002:a19:8c19:0:b0:507:b9e9:3e8d with SMTP id
 o25-20020a198c19000000b00507b9e93e8dmr19417374lfd.28.1699157549053; 
 Sat, 04 Nov 2023 21:12:29 -0700 (PDT)
Received: from [192.168.200.42]
 (dynamic-046-114-039-028.46.114.pool.telefonica.de. [46.114.39.28])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa7cfcf000000b0053e469f6505sm2761579edy.26.2023.11.04.21.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 21:12:28 -0700 (PDT)
Message-ID: <6220fdb1-8352-4159-896b-edb7565e5774@canonical.com>
Date: Sun, 5 Nov 2023 06:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] doc: falcon: riscv: Falcon Mode boot on RISC-V
Content-Language: en-US, de-DE
To: Randolph <randolph@andestech.com>
Cc: randolph.sklin@gmail.com, dylan@andestech.com, tim609@andestech.com,
 peterlin@andestech.com, u-boot@lists.denx.de
References: <20231102111028.1723775-1-randolph@andestech.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231102111028.1723775-1-randolph@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/2/23 13:10, Randolph wrote:
> Add documentation to introduce the Falcon Mode on RISC-V.
> In this mode, the boot sequence is SPL -> OpenSBI -> Linux kernel.
> 
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>   doc/develop/falcon.rst | 159 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 159 insertions(+)
> 
> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> index 2f25fc8532..b553f0d0ea 100644
> --- a/doc/develop/falcon.rst
> +++ b/doc/develop/falcon.rst
> @@ -256,3 +256,162 @@ the following command:
>   Falcon Mode was presented at the RMLL 2012. Slides are available at:
>   
>   http://schedule2012.rmll.info/IMG/pdf/LSM2012_UbootFalconMode_Babic.pdf
> +
> +Falcon Mode Boot on RISC-V
> +--------------------------
> +
> +Introduction
> +------------

Thank you for documenting this.

In HTML we want this to be a <h3></h3> title.

The underscore type controls the title level. Please, use
    ~~~~~~~~~~~~
for the underline. Same below.

> +
> +In the RISC-V environment, OpenSBI is required to enable a supervisor mode

%s/mode/mode binary/

> +to execute certain privileged operations. The typical boot sequence on
> +RISC-V is SPL -> OpenSBI -> U-Boot -> Linux kernel. SPL will load and start
> +the OpenSBI initializations, then OpenSBI will bring up the next image, U-Boot.

%s/U-Boot/U-Boot proper/

> +The OpenSBI binary must be prepared in advance of the U-Boot build process
> +and it will be packed together with U-Boot into a file called u-boot.itb.
> +
> +The Falcon Mode on RISC-V platforms is a distinct boot process. Borrowing

%s/processs/sequence/

> +ideas from the U-Boot Falcon Mode on ARM, it skips the U-Boot proper phase
> +in the normal boot process and allows OpenSBI to load and start the Linux
> +kernel. Its boot sequence is SPL -> OpenSBI -> Linux kernel. The OpenSBI
> +binary and Linux kernel binary must be prepared prior to the U-Boot build
> +process and they will be packed together as linux.itb in this process.

%s/linux.itb/a FIT image named linux.itb/

> +
> +CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT enables the Falcon Mode boot on RISC-V.
> +This configuration tells OpenSBI that Linux kernel is its next OS image and

%s/configuration/configuration setting/

> +makes it load and start the kernel afterwards.
> +
> +Note that the Falcon Mode boot bypasses a lot of initializations by U-Boot.
> +If the Linux kernel expects hardware initializations by U-Boot, make sure to
> +port the relevant code to the SPL build process.
> +
> +Configurations

%s/Configurations/Configuration/

> +--------------
> +
> +CONFIG_SPL_LOAD_FIT_ADDRESS
> +    Specifies the address to load u-boot.itb in a normal boot. When the Falcon
> +    Mode boot is enabled, it specifies the load address of linux.itb.
> +
> +CONFIG_SYS_TEXT_BASE
> +    Specifies the address of the text section for a u-boot proper in a normal
> +    boot. When the Falcon Mode boot is enabled, it specifies the text section
> +    address for the Linux kernel image.
> +
> +CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT
> +    Activates the Falcon Mode boot on RISC-V.
> +
> +Function that a board must implement
> +------------------------------------
> +
> +Initially, SPL places the FDT blob right after the kernel. As the kernel does
> +not include the BSS section in its size calculation, SPL ends up placing the
> +FDT blob within the BSS section of the kernel. This may cause the FDT blob to
> +be cleared during kernel BSS initialization. To avoid the issue, be sure to
> +move the FDT blob out of the kernel first.
> +
> +void spl_perform_fixups(struct spl_image_info *spl_image)
> +    required, necessary action to move the FDT blob out of the Linux kernel BSS
> +    section

Shouldn't we have a generic function for this? Why should we want 
duplicate code?

> +
> +Example for Andes AE350 Board
> +-----------------------------
> +
> +A FDT blob is required to boot the Linux kernel from the SPL. Andes AE350
> +platforms generally come with a builtin dtb. If you want to load a custom DTB,
> +follow the steps below:
> +
> +1. Load the custom DTB to SDRAM::
> +
> +        => fatload mmc 0:1 0x20000000 user_custom.dtb
> +
> +2. Set the SPI speed::
> +
> +        => sf probe 0:0 50000000 0
> +
> +3. Erase sectors from the SPI Flash::
> +
> +        => sf erase 0xf0000 0x10000
> +
> +4. Write the FDT blob to the erased sectors of the Flash::
> +
> +        => sf write 0x20000000 0xf0000 0x10000
> +
> +Console Log of AE350 Falcon Mode Boot
> +-------------------------------------
> +

Please, indent following log and precede it by '::'

Best regards

Heinrich

> +U-Boot SPL 2023.01-00031-g777ecdea66 (Oct 31 2023 - 18:41:36 +0800)
> +Trying to boot from RAM
> +
> +OpenSBI v1.2-51-g7304e42
> +   ____                    _____ ____ _____
> +  / __ \                  / ____|  _ \_   _|
> + | |  | |_ __   ___ _ __ | (___ | |_) || |
> + | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
> + | |__| | |_) |  __/ | | |____) | |_) || |_
> +  \____/| .__/ \___|_| |_|_____/|____/_____|
> +        | |
> +        |_|
> +
> +Platform Name             : andestech,ax25
> +Platform Features         : medeleg
> +Platform HART Count       : 1
> +Platform IPI Device       : andes_plicsw
> +Platform Timer Device     : andes_plmt @ 60000000Hz
> +Platform Console Device   : uart8250
> +Platform HSM Device       : andes_smu
> +Platform PMU Device       : andes_pmu
> +Platform Reboot Device    : atcwdt200
> +Platform Shutdown Device  : ---
> +Firmware Base             : 0x0
> +Firmware Size             : 196 KB
> +Runtime SBI Version       : 1.0
> +
> +Domain0 Name              : root
> +Domain0 Boot HART         : 0
> +Domain0 HARTs             : 0*
> +Domain0 Region00          : 0x0000000000000000-0x000000000003ffff ()
> +Domain0 Region01          : 0x00000000e6000000-0x00000000e60fffff (I,R)
> +Domain0 Region02          : 0x00000000e6400000-0x00000000e67fffff (I)
> +Domain0 Region03          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
> +Domain0 Next Address      : 0x0000000001800000
> +Domain0 Next Arg1         : 0x0000000001700000
> +Domain0 Next Mode         : S-mode
> +Domain0 SysReset          : yes
> +
> +Boot HART ID              : 0
> +Boot HART Domain          : root
> +Boot HART Priv Version    : v1.11
> +Boot HART Base ISA        : rv64imafdcx
> +Boot HART ISA Extensions  : none
> +Boot HART PMP Count       : 8
> +Boot HART PMP Granularity : 4
> +Boot HART PMP Address Bits: 31
> +Boot HART MHPM Count      : 4
> +Boot HART MHPM Bits       : 64
> +Boot HART MIDELEG         : 0x0000000000000222
> +Boot HART MEDELEG         : 0x000000000000b109
> +[    0.000000] Linux version 6.1.47-09019-g0584b09ad862-dirty
> +[    0.000000] OF: fdt: Ignoring memory range 0x0 - 0x1800000
> +[    0.000000] Machine model: andestech,ax25
> +[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> +[    0.000000] printk: bootconsole [sbi0] enabled
> +[    0.000000] Disabled 4-level and 5-level paging
> +[    0.000000] efi: UEFI not found.
> +[    0.000000] Zone ranges:
> +[    0.000000]   DMA32    [mem 0x0000000001800000-0x000000003fffffff]
> +[    0.000000]   Normal   empty
> +[    0.000000] Movable zone start for each node
> +[    0.000000] Early memory node ranges
> +[    0.000000]   node   0: [mem 0x0000000001800000-0x000000003fffffff]
> +[    0.000000] Initmem setup node 0 [mem 0x0000000001800000-0x000000003fffffff]
> +[    0.000000] SBI specification v1.0 detected
> +[    0.000000] SBI implementation ID=0x1 Version=0x10002
> +[    0.000000] SBI TIME extension detected
> +[    0.000000] SBI IPI extension detected
> +[    0.000000] SBI RFENCE extension detected
> +[    0.000000] SBI SRST extension detected
> +[    0.000000] SBI HSM extension detected
> +[    0.000000] riscv: base ISA extensions acim
> +[    0.000000] riscv: ELF capabilities acim
> +[    0.000000] percpu: Embedded 18 pages/cpu s35000 r8192 d30536 u73728
> +[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 252500


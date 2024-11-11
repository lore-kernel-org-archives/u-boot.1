Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4522FD2E9E3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042488938E;
	Mon, 11 Nov 2024 13:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Ob0Y4eJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CEFE88F8E; Mon, 11 Nov 2024 12:06:32 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61E3D89371
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 12:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso35386555e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731323188; x=1731927988; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Hbr4Yo1YiYF2czCSP3VcaxZd4w8wdZAusyqBBQNYlw8=;
 b=Ob0Y4eJIRn5jeqR7SKtj7MXN9fxgLMmviuLeD+20a36pn2/KSO2YOVLn2+oXaF4pBb
 m7tM4zb05DwTk5AhMyJXFDFmrq6DpRKFe+imEoBkhEgPPrGlgBi1xpOBrwQt6+RnqarP
 T8jsr5X1bEX3D+RCtOGrOm8iRJuDKFel/geQmnjiJ3Sl+7p6lR7rFTqej1aZIqmguf9o
 yDhMSuu8mbGhg7DmQftet56NR2nnemUdO0gS3crdLbG8Qcfc1cNn3ZN9BtrM/lJBXwcS
 Fh62NA43qUMENl0zptdrUEtj1ECaub6GudX6ASJ13A/NtNFS2M2jaM9M3JvO/A7JyzS9
 f+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731323188; x=1731927988;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hbr4Yo1YiYF2czCSP3VcaxZd4w8wdZAusyqBBQNYlw8=;
 b=H6SM0UyuaEevksuBoCOL7wOB/ck2P96nPqX3e7tBClnR+UFnacTkoHzn4NXzHwepcP
 g/mZY4oi/ACQ9U8N4QOop4ON/lRXCpl53bX5qXhvxVdu6wVMHTAK4jsoRr8tbLdbGe63
 B2knRwtpFy+4mAOqu6/OURDFhUwD+IeLhD7WnPyMQ2QV2sBMBpCztlk5UxUHaWf2lto5
 FEwD7OBQGW/MmKNN36U7Osk9MrLlUCcSmn96BXo3Denqa6NWcOfoAEqzCaOPZooQRo1F
 roxxcWsCpqa6VH/DvCeWSdHgmHXKklwaUsuA3M+uqdJQEMe+nazflCyfq3Z4dqLH8T5L
 rA7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQC8qHr6TkNn8apXvzlDxJo7TPCxK8/EpIChvLVe5Rp/V7KE0gxhvUW9juEaM+v5maDUD07wE=@lists.denx.de
X-Gm-Message-State: AOJu0YygJBlQyOVpsrbF8+7mbI9galwbR95aeogQwDzyHcdZ9FAqEe78
 e6D9bppKWSMd4vdz86fQLLJqs3LuJHgYDvm5IUgDnlTqJQKoJCU6JmPJonCCb8c=
X-Google-Smtp-Source: AGHT+IED99HJPoLQe1TktM1d022Qlq4Xp7+t7O1ob5453M2rW3kSyNpC+SCbkDw8ZRztaXK657TB7w==
X-Received: by 2002:a05:600c:4ec7:b0:431:5f9e:3f76 with SMTP id
 5b1f17b1804b1-432b750967dmr98746005e9.16.1731323187671; 
 Mon, 11 Nov 2024 03:06:27 -0800 (PST)
Received: from [192.168.2.177] ([207.188.162.240])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97ce1bsm12554436f8f.36.2024.11.11.03.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 03:06:27 -0800 (PST)
Message-ID: <b3f491c7-2d95-4f61-af12-88645ed86d59@suse.com>
Date: Mon, 11 Nov 2024 12:06:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fdt: Swap the signature for board_fdt_blob_setup()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>, Alexander Graf <agraf@csgraf.de>,
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Andre Przywara <andre.przywara@arm.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 David Feng <fenghua@phytium.com.cn>, E Shattow <lucent@gmail.com>,
 Eric Curtin <ecurtin@redhat.com>, Francois Berder <fberder@outlook.fr>,
 Green Wan <green.wan@sifive.com>, H Bell <dmoo_dv@protonmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, "Ivan T. Ivanov"
 <iivanov@suse.de>, James Hilliard <james.hilliard1@gmail.com>,
 Janne Grunau <j@jannau.net>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <kettenis@openbsd.org>, Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Sam Day <me@samcday.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot-qcom@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
References: <20241102174944.412088-1-sjg@chromium.org>
 <20241102174944.412088-2-sjg@chromium.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20241102174944.412088-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 Nov 2024 13:26:21 +0100
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



On 02/11/2024 18:49, Simon Glass wrote:
> This returns a devicetree and updates a parameter with an error code.
> Swap it, since this fits better with the way U-Boot normally works. It
> also (more easily) allows leaving the existing pointer unchanged.
> 
> No yaks were harmed in this change, but there is a very small code-size
> reduction.
> 
> For sifive, the OF_BOARD option must be set for the function to be
> called, so there is no point in checking it again. Also OF_SEPARATE is
> defined always.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Set up the existing FDT in case the board wants to check it
> - Update snapdragon to return -EEXIST
> - Set the existing FDT before calling board_fd_blob_setup()
> - Update sandbox to return -EEXIST if an fdt comes from a bloblist
> - Update do_go_uboot() to set the existing FDT
> - Drop unnecessary setting of FDT in vexpress64
> - Tidy up redundant RISC-V code
> 
>   arch/arm/mach-apple/board.c                   |  7 ++--
>   arch/arm/mach-snapdragon/board.c              |  9 ++---
>   arch/arm/mach-stm32mp/boot_params.c           | 19 ++++++-----
>   arch/sandbox/cpu/cpu.c                        | 34 +++++++++----------
>   board/Marvell/octeontx/board-fdt.c            | 12 +++----
>   board/Marvell/octeontx2/board-fdt.c           | 12 +++----
>   board/Marvell/octeontx2/board.c               |  3 +-
>   board/andestech/ae350/ae350.c                 | 23 +++++++------
>   board/armltd/vexpress64/vexpress64.c          | 33 ++++++++----------
>   board/broadcom/bcmstb/bcmstb.c                |  7 ++--
>   board/emulation/qemu-arm/qemu-arm.c           |  7 ++--
>   board/emulation/qemu-ppce500/qemu-ppce500.c   | 12 +++----
>   board/emulation/qemu-riscv/qemu-riscv.c       |  7 ++--
>   board/highbank/highbank.c                     |  7 ++--
>   board/raspberrypi/rpi/rpi.c                   | 13 ++++---
>   board/sifive/unleashed/unleashed.c            | 12 +++----
>   board/sifive/unmatched/unmatched.c            | 11 +++---
>   .../visionfive2/starfive_visionfive2.c        | 11 +++---
>   board/xen/xenguest_arm64/xenguest_arm64.c     | 14 ++++----
>   board/xilinx/common/board.c                   | 26 ++++++++------
>   include/fdtdec.h                              |  9 ++---
>   lib/fdtdec.c                                  | 14 +++++---
>   22 files changed, 152 insertions(+), 150 deletions(-)
> 
[...]
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 9122f33d88d..c46fe4b2350 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -508,15 +508,14 @@ int board_init(void)
>   /*
>    * If the firmware passed a device tree use it for U-Boot.
>    */
> -void *board_fdt_blob_setup(int *err)
> +int board_fdt_blob_setup(void **fdtp)
>   {
> -	*err = 0;
> -	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC) {
> -		*err = -ENXIO;
> -		return NULL;
> -	}
> +	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC)
> +		return -ENXIO;
>   
> -	return (void *)fw_dtb_pointer;
> +	*fdtp = (void *)fw_dtb_pointer;
> +
> +	return 0;
>   }
>   
>   int copy_property(void *dst, void *src, char *path, char *property)

For Raspberry Pi:

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

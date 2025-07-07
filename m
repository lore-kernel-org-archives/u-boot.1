Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC17FC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D0F831B5;
	Mon,  7 Jul 2025 22:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nbaVVRD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2B3831C3; Mon,  7 Jul 2025 22:16:05 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9676E831A4
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60c79bedc19so5683867a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 13:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919362; x=1752524162; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tyMwEhq2WnV7cguLwLZ0F48Z6BvxAJeIQoEvVo9r/0=;
 b=nbaVVRD1MTu65WDEX534f/H+ULAbn2w2x0wuXxXCDcA7XZpUCuOJ6bvY96GGy7bal1
 i1zt1dnZmWCqf9p/KQJcWiZtBtpmDy28Vh5vmM3KROuQflpNvxH6xa7TI4f1EzCI6yG/
 Ibkm4hAn/7+qr8i0D+WtHrwcXGNpbrFLVSR4JUG6D6gdW0TPn0317LAjytsw4JuP28Wm
 AirUqOWow8YmuxKHpXI5+mSoShdDBSwlgFybXFFtMF8b5dDRW0V2JTOC7ReJIiMzQ/sA
 PcKnCJzV0Ln0IOauZnULcdTUzr/8IExqYALHClf7czHLqAWbaDnA5dhN82CIFHs+Zk1g
 KzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919362; x=1752524162;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8tyMwEhq2WnV7cguLwLZ0F48Z6BvxAJeIQoEvVo9r/0=;
 b=NC1osdHnTuXAFaeleC/5d7NhuIoOyW6aC27EVzN4eSOpiUz+tsaUJaz2dAXJLZDiCs
 FBSPUTAmMSmqSd5RHFOZxnQEZcANJmYHkOFjL/szd2VkzEKtE4Y1qN1jkwhryp2bgOUZ
 ZdLM7q3FOJQtR0YsD3CGJamFIe0Y5rxKxglpFFBBR3zA++On5Cj3ANbiX4S6zW1xMEJQ
 Y8cLL82ccGxpD+gT4dW16L81Mv+jREBjUdRnKHoH77cWer+aqH4w9++2g4LlB18tm5+D
 GvLyCFsZjZ9KTKpFFvF5/8+sgytlZ4fDGl05nFG+UyyTY7sqEEXVg9NRyG7sYTUOTi8O
 NfrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhciB1FoMBv1RrRn6Gqpc8pUkHVh1xPiyqsEYmIkVbBEG2vrJu2QwPtWl86skHaXk4eOsp9P8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1nROsTBFI+y04ppEua+uuwtTEiTeayuOvmdBwDbD0W21os7/5
 gC0MXQuyzj7Mxj0QdtfEywtFFROEX4qYULImd9kqHxKczp2SmCdmGPmofo1RBBRdlpI=
X-Gm-Gg: ASbGncskCs4VKO3LuQw8GeKW3gEKgKZpTiFXqIK//Vkm5aV9ckeajFZQN5NMU4r3LS0
 ouzJKnxJVhI4rvP1d/oGMIIs8cFE0snYxAoy2R20ClSFGTS9pLCU7X8uBMM4dEOOb1dGMsfGipW
 K73V9/AHTMIaFTpAU/PVV4WJf1zIi6EXODgOZ74dWAmazVbbhNr943YwnLoaQ92Ed77YB5KgrDI
 Q6AcoRgdVnuIpI9LWIRA/ovW3VtwSs/hDjO0BVVrHee9XKySKNvbfCfjQ0ByqAijyRVA+LumEWI
 /5AEPQNxnRPuQYW3bqAIhu/4sn/LIqf5HxOtg10d8k8Cw+Qe/5YZZPYLAJ8/UG4yMP5K8bVvVVk
 GoWeS5Lm/Nd78uf7scZVAnzjdZxxgoj8RayA=
X-Google-Smtp-Source: AGHT+IH8Mp1VilUvg01WcO/q1HEnQNJm74bqx3BRTjp2+f3Zq3IoLxSWsHMhJYS0C/MDjkk2Xh3Izg==
X-Received: by 2002:a17:907:86ab:b0:adb:2a66:85bc with SMTP id
 a640c23a62f3a-ae3fbd1397bmr1153590866b.34.1751919361957; 
 Mon, 07 Jul 2025 13:16:01 -0700 (PDT)
Received: from localhost (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b0336asm765625266b.115.2025.07.07.13.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 13:16:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 23:15:59 +0300
Message-Id: <DB63KZ89ZWMY.3KGIHVA42RGM4@linaro.org>
Cc: <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: Re: [PATCH v5 2/4] mach-k3: add runtime configuration of MMU table
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Anshul Dalal" <anshuld@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.0
References: <20250703133533.104758-1-anshuld@ti.com>
 <20250703133533.104758-3-anshuld@ti.com>
In-Reply-To: <20250703133533.104758-3-anshuld@ti.com>
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

Hi Anshul,

On Thu Jul 3, 2025 at 4:35 PM EEST, Anshul Dalal wrote:
> k3_mem_map is used by u-boot to configure the MMU on k3 devices but
> currently it's a static array which does not scale for platforms with
> non-standard load addresses for ATF and OP-TEE. Additionally on systems
> with limited DRAM, more space is mapped than is available on the device.
>
> Therefore this patch adds a new k3_mem_map_init function which can
> be called from dram_init to configure the table at runtime where we
> can query the required DDR information and reserved regions from the
> device-tree.

Is this a problem for k3 only? This kind of code should be aimed at the mmu
support and improving armv8 overall, not specific platforms

>
> A dummy implementation is also added in r5/common.c to allow the build
> to pass without masking each call to k3_mem_map_init behind an ifdef
> CONFIG_ARM64.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

[...]

> +
> +static void k3_mmu_add_cachable_entry(u64 start, u64 end, unsigned int *=
map_idx)
> +{
> +	if (start >=3D end)
> +		return;
> +
> +	k3_mem_map[*map_idx].virt =3D start,
> +	k3_mem_map[*map_idx].phys =3D start,
> +	k3_mem_map[*map_idx].size =3D end - start,
> +	k3_mem_map[*map_idx].attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +				     PTE_BLOCK_INNER_SHARE;
> +	(*map_idx)++;
> +}

Doesn't this need a break-before-make?
Also why does it have to be a board specific function? Is there something m=
mu_change_region_attr()
doesn't do ?

> +
> +/* It is assumed that if ATF and OPTEE are loaded in DDR, they are loade=
d to
> + * first bank only
> +
> +static int k3_setup_extra_mem_banks(unsigned int *map_idx)
> +{
> +	unsigned int bank;
> +	int ret;
> +
> +	ret =3D fdtdec_setup_memory_banksize();
> +	if (ret)
> +		return ret;
> +
> +	for (bank =3D 1; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		k3_mmu_add_cachable_entry(gd->bd->bi_dram[bank].start,
> +					  gd->bd->bi_dram[bank].start +
> +						  gd->bd->bi_dram[bank].size,
> +					  map_idx);
> +	}
> +

ditto

> +static int k3_uboot_mem_map_init(unsigned int *map_idx)
> +{
> +	int ret;
> +
> +	/* Overwrite the 128MiB SPL entry */
> +	(*map_idx)--;
> +
> +	ret =3D k3_setup_first_mem_bank(map_idx);
> +	if (ret)
> +		return ret;
> +
> +	if (CONFIG_NR_DRAM_BANKS > 1)
> +		ret =3D k3_setup_extra_mem_banks(map_idx);
> +
> +	return ret;
> +}
> +
> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/in=
clude/mach/k3-ddr.h

[..]

Thanks
/Ilias

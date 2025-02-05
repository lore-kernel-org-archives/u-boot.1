Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81527C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D20980762;
	Wed,  5 Feb 2025 17:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dDMiVgqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03570807C0; Wed,  5 Feb 2025 17:48:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1393D807E4
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738774065; x=1739378865; i=xypron.glpk@gmx.de;
 bh=crUvrHMYFydiT5xLiWAAsrCf4H6+vHC4fR1UT1/c82M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dDMiVgqACGNbGP774OgUEkc2NCzpeplHOmTQltbjcHs2LIcKRZlMDzCAjXc4DzyY
 YOP5EDRSaYviCg8Od50yiorN8M0n7dwIzzLcfDUznT/eyhaoDST+q15YYPoFvgNew
 lEZbVOe0eRFVF+kKiWnh7LYmFM7/HIq/H9aG9mjEUo5lQ4gQ3TCC57nLPKW7l2s+o
 bPqN5jMfjhBXBC012djznWpyy3Zub9Xh6X7kaNKCKiI5qK5CjOYTeIbHr+Ap60ACf
 WhaeMLwP4YJ/p5nTsLHRvToxZNOTfNuG1GvvKyV9tGnijQKYtqNtkKQiXd0Oojscq
 O+JVOkAZE2KeAGu3kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1tC9Eo2PLn-00qTH8; Wed, 05
 Feb 2025 17:47:45 +0100
Message-ID: <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
Date: Wed, 5 Feb 2025 17:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 trini@konsulko.com
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250205071714.635518-6-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TAopI2qqFaE7z/cXm4VT77whdpfzoGFI6jQEA3NVfICaOwieP8/
 tWwvFFg1YCzKGS2k+jOcVdocr6urqdMtQqpZX63SILI8T5vinvmzUZeFBuBa67Xc+9ZALW8
 PndILtFfnmD2dVw/z7h0uEfqJfKLcvKqikDEsykg4Lz8czfgHgX1EAHjQT/WLdxibyMINor
 k1KYXtFT2a8rWwovnTPyA==
UI-OutboundReport: notjunk:1;M01:P0:4OD75V7Tuj8=;75Y6T/flFgCjF2yJNl9tS9QF//7
 BQrWfcBykSv6yZDSY+KsNWNl0aS4W3Aeuyb4zNxA9yq9Wd7qwmUEUhByhcEWipo+21GqR/Beu
 AcdlEfX7iesLOFX1Se8D9xP+D6j89oJIpAsRtIx3nxj0NOYaSp7Dl2UAuTqvvRgk7Ga00OKR7
 sgfuQ0N2KMQ47z0EUvXbFEu2IEqKneN4qTj11VKO0Vd2V7H47N2QR1fLSFZ0b1wcbrgYUCTVJ
 l1u4lZxc0FEiDzuqT0txv8eu0KJjMV4lldFsBfJcEHfjjbebtQgjSvTkLFeTnB9KVIhT5nHVQ
 HIhaA+iBu9fB6YIOZHC6YSr9ObamksUpRRvRoUx2op++VR8RiVv94QhNYK4zHBvlEv+ooKZ7q
 chYDinXEv8X69hJGqp5Bn1wlwC6/0u8sq7uInAoYd56GYXy7rBff991m6MH0tIgM+Y9XEObb9
 RYYYCigD4nOrIfgPiMog2WiM5gJW8WUyL7AIF/PTYCHh65EqEnnscrZieezm+CcT/sreentWW
 ZjaQ6REIX9dA1puCQdBRfyD+ytcPaRqZSnW/hgL2l32qkfcDUzbMYOVK6T0a/EUbWBl4OGvDW
 GaP+BCfkdzHGFgwI423qt7RT1hqTDyM+LLlvmsvtLqjlov5BrOaJvB1IUUCzIr8Uj1EFPzP/5
 IX1TZ74E/tqIFwLsH12GVirpu/wO5V7994jLDWQ9Vp8NxDGnJG08+u60ARcTtjkYoTgSB3QzO
 XdSYF1PxNOob1pjyEdyUQIW2m8felLG1BOkbW9UdoVmCp4VrhCEmJSfyHk/b6YgqDsS8lVsFS
 bX90h60g41CYgs8mrYhJes36xRdoOfgUPXwD1RlrCq6jvAco7V7losLNNcw756RHQofVdLVXe
 ykwWG5YYSdduToQF5Mv6c2FNF2mPV+CUWNj9NHz331GsCXmMIhsl15DRwfjBeKx+xV+CX+EdQ
 TmIB5fGoMVnPRyctqyiU8DWIEzp+WwNRJMibL0DFwYjvs0z5dhkSazitw40SBiAFbUJmgZb3l
 l7XGyR/kgfGdj5su4UnRWWw4D0cg7ax8t3qGvl7OrdvIsORJkwXQJ67+bPCXAr2BlRmkp5yd+
 6/R5GCSGaBSp0HomNq9HBj4X7fDluhVcNWBWHbvr2eo+umv6eoTCVjiPurH/Ej8NK4u7r25YV
 YAzugKbVqdjqTRG4e+D16ZUPF5K0btj/bdSM6NRUjrIIRfWUFbf0b+ZMRrI5MvoMCKrsUMIsN
 BixgEIQzQt2c5rVGf4SLIYWx5r57pScSjlm43qHRNxxKXg5sRMt+hDNP+j18XppbhB8ivcPP5
 O4BhmatRo3aNLfDDCcc6YPBq7EoI1avclSXulKfsLsvLx8Zx0uy5fQqMDff4oqsZs/3D0vgbT
 lQnTjCC5UFudAerO5xUIN3NsyiLzGeCMnf/ZcElXcuomP5PMNNFF3ZOztW
X-Mailman-Approved-At: Wed, 05 Feb 2025 17:53:55 +0100
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

On 2/5/25 08:16, Ilias Apalodimas wrote:
> For armv8 we are adding proper page permissions for the relocated U-Boot
> binary. Add a weak function that can be used across architectures to cha=
nge
> the page permissions
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   arch/arc/lib/cache.c           |  2 ++
>   arch/arm/cpu/arm926ejs/cache.c |  2 ++
>   arch/arm/cpu/armv7/cache_v7.c  |  1 +
>   arch/arm/cpu/armv7m/cache.c    |  2 ++
>   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
>   arch/arm/lib/cache.c           |  2 ++
>   arch/m68k/lib/cache.c          |  2 ++
>   arch/nios2/lib/cache.c         |  2 ++
>   arch/powerpc/lib/cache.c       |  2 ++
>   arch/riscv/lib/cache.c         |  2 ++
>   arch/sh/cpu/sh4/cache.c        |  2 ++
>   arch/xtensa/lib/cache.c        |  2 ++
>   include/cpu_func.h             | 16 ++++++++++++++++
>   13 files changed, 59 insertions(+)
>
> diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> index 5169fc627fa5..5c79243d7223 100644
> --- a/arch/arc/lib/cache.c
> +++ b/arch/arc/lib/cache.c
> @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
>
>   	__ic_entire_invalidate();
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cac=
he.c
> index 5b87a3af91b2..857311b3dfad 100644
> --- a/arch/arm/cpu/arm926ejs/cache.c
> +++ b/arch/arm/cpu/arm926ejs/cache.c
> @@ -88,3 +88,5 @@ void enable_caches(void)
>   	dcache_enable();
>   #endif
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7=
.c
> index d11420d2fdd0..14c9be77db8d 100644
> --- a/arch/arm/cpu/armv7/cache_v7.c
> +++ b/arch/arm/cpu/armv7/cache_v7.c
> @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
>   __weak void v7_outer_cache_inval_all(void) {}
>   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
>   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> index b6d08b7aad73..458a214e9577 100644
> --- a/arch/arm/cpu/armv7m/cache.c
> +++ b/arch/arm/cpu/armv7m/cache.c
> @@ -370,3 +370,5 @@ void enable_caches(void)
>   	dcache_enable();
>   #endif
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
> index 670379e17b7a..1cf3870177ee 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1028,6 +1028,28 @@ skip_break:
>   	__asm_invalidate_tlb_all();
>   }
>
> +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> +{
> +	u64 attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | P=
TE_TYPE_VALID;
> +
> +	switch (perm) {
> +	case MMU_ATTR_RO:
> +		attrs |=3D PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> +		break;
> +	case MMU_ATTR_RX:
> +		attrs |=3D PTE_BLOCK_RO;
> +		break;
> +	case MMU_ATTR_RW:
> +		attrs |=3D PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> +		break;
> +	default:
> +		log_err("Unknown attribute %llx\n", perm);
> +		return;
> +	}
> +
> +	mmu_change_region_attr(addr, size, attrs, false);
> +}
> +
>   #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
>
>   /*
> diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> index 516754caeaf9..c7704d8ee354 100644
> --- a/arch/arm/lib/cache.c
> +++ b/arch/arm/lib/cache.c
> @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
>
>   	return 0;
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}

I would prefer if the weak function would return -ENOSYS indicating the
missing implementation and the real function would return 0 in case of
success or an error code on failure. This way the EFI protocol could set
the return code if the architecture does not provide support for setting
the attributes the passed addresses are invalid.

Best regards

Heinrich

> diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
> index 370ad40f1423..b275646384a5 100644
> --- a/arch/m68k/lib/cache.c
> +++ b/arch/m68k/lib/cache.c
> @@ -151,3 +151,5 @@ __weak void flush_dcache_range(unsigned long start, =
unsigned long stop)
>   {
>   	/* An empty stub, real implementation should be in platform code */
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
> index 8f543f2a2f26..7a93a8fcc6a7 100644
> --- a/arch/nios2/lib/cache.c
> +++ b/arch/nios2/lib/cache.c
> @@ -127,3 +127,5 @@ void dcache_disable(void)
>   {
>   	flush_dcache_all();
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
> index a9cd7b8d30ac..3d0536caccde 100644
> --- a/arch/powerpc/lib/cache.c
> +++ b/arch/powerpc/lib/cache.c
> @@ -58,3 +58,5 @@ void invalidate_icache_all(void)
>   {
>   	puts("No arch specific invalidate_icache_all available!\n");
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
> index 71e4937ab542..1c751e562157 100644
> --- a/arch/riscv/lib/cache.c
> +++ b/arch/riscv/lib/cache.c
> @@ -151,3 +151,5 @@ __weak void enable_caches(void)
>   	if (!zicbom_block_size)
>   		log_debug("Zicbom not initialized.\n");
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> index 99acc5999652..22e0f1484a33 100644
> --- a/arch/sh/cpu/sh4/cache.c
> +++ b/arch/sh/cpu/sh4/cache.c
> @@ -126,3 +126,5 @@ int dcache_status(void)
>   {
>   	return 0;
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
> index e6a7f6827fc2..aacc2d2627d6 100644
> --- a/arch/xtensa/lib/cache.c
> +++ b/arch/xtensa/lib/cache.c
> @@ -57,3 +57,5 @@ void invalidate_icache_all(void)
>   {
>   	__invalidate_icache_all();
>   }
> +
> +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {=
}
> diff --git a/include/cpu_func.h b/include/cpu_func.h
> index 7e81c4364a73..17b6d199302a 100644
> --- a/include/cpu_func.h
> +++ b/include/cpu_func.h
> @@ -69,6 +69,22 @@ void flush_dcache_range(unsigned long start, unsigned=
 long stop);
>   void invalidate_dcache_range(unsigned long start, unsigned long stop);
>   void invalidate_dcache_all(void);
>   void invalidate_icache_all(void);
> +
> +enum pgprot_attrs {
> +	MMU_ATTR_RO,
> +	MMU_ATTR_RX,
> +	MMU_ATTR_RW,
> +};
> +
> +/** pgprot_set_attrs() - Set page table permissions
> + *
> + * @addr: Physical address start
> + * @size: size of memory to change
> + * @perm: New permissions
> + *
> + **/
> +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
> +
>   /**
>    * noncached_init() - Initialize non-cached memory region
>    *


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D38C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E8282012;
	Thu, 30 Jan 2025 11:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MJLPM/FM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0963F8206E; Thu, 30 Jan 2025 11:08:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098F080C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738231677; x=1738836477; i=xypron.glpk@gmx.de;
 bh=YEMM83SCvp1H1MLmq99Cmt6wrx7txh71VvC6qHi6JvU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MJLPM/FMg3dA0D2b5L/bxKw1sOowTxAN9f+vwAYJ9PakqcVtWSU91Ek1qA6ng19V
 idbtUx81GtopQJun+pvZ7RWFUZ4dZ8It9jmvE19s+WC1ta1j0iUWWFCQIcQ69yKhu
 9kO4P3/pyoQqFwFY8vPta0EdAPQVG3ehA2c1MnJU0wbhDcWxyX0IFotWbXwNtLX8V
 8fCuOJ+7kyhZImiUIgGG9nJ4HUkrccYtPulDRMCmkVdR5lOfVWgNZ8jy45qpaDaf6
 1WDH3fXEo9STzDV34wB6rkUV3Wo7TrSXRPdPLwnBxRGW4DlErBrLrJfuluTpgC4rC
 iNrubJgbZaYgTEyl2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2Dx8-1tT54U3dxW-00z3EE; Thu, 30
 Jan 2025 11:07:57 +0100
Message-ID: <1c795dd4-9074-434a-afb5-4bf4b35a04b3@gmx.de>
Date: Thu, 30 Jan 2025 11:07:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] arm: Prepare linker scripts for memory permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250130072100.27297-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LLoCOS82JBrUMBfMp/R8c6RHmfmjZy0eAuxjiVCWp+8WcjeO7oZ
 oeAv/9PHp6WOU2679mP0DATRNRTTlUop/bT9pwzDecsNdW8llSiLNEDuwbdkFOzZJyydVId
 Ksxtz8O92c4GM/gBXJQZ1UMybeULSRSi73/OlZBzxSbae0vkJh1e/XowXqCIbT1khQ9N59J
 F0C8hmrKLU0Vvnj+IBrzQ==
UI-OutboundReport: notjunk:1;M01:P0:EqtFiTPNtes=;AuiOoWJcTJX7qeLl2Czfijq06aO
 8N8uBtBGpQ80VoF+bzBofSDVlo/Hc5UOGXFM+1gl4+tzbqsOP3+rI/7pfy6VrXeizmi3mIgAV
 dKwsE8Q1vTnWuPQOC3ZUmm3pXE0ZOouZLcAEaXl8oOAhzc+vV9fs3DNdUHJMfypZ15uohSHzz
 jf02LR852MDJKh1+wxkoO+mSXxvfPcBmh/y9S0GPNX4QpUilggN148R3HUSknI1TYVUjKGf4Z
 jE+NOUHoQOfjyAQWAkaJpm5jPXXx/MNCl3/bxSSHI+gWToRfjBEF2BoQISX4m5ffVSuNKXxCN
 lFrkHL/snG4zls06iI3a6ENgRsznjC1LdWd0mJaFj1R6FJAH40k/ib6WAbUypLgFdK2mj5boO
 TD8gM2OovQz501ssXP5sBcd0cQHh5JZNL5ZoT64yAr+GFig23GTEqMexPgLpBuUt5D/geU2N+
 t9WJ96WP+rSYxoyvwYqCHLAJI18btadRQimIgxSGVhTxAnSa2omPX3H3jWpNVoJEaxVuuBLY5
 zVsNXxTH7dnQCD4hYKWWsmAozeQOLnQinzYNQzdolQDhMILPdbblevQ1VjppAq9+8CtlhW5Bw
 QiAOe7zOd8WQlnFnVhqUGgdnHK7iWASjYL5gGWcvopXHEO6JzlJFLA73VLE6s6EbvUcdGJhXR
 xn9hScLZ3/NaH2rnyCmKVgX3DXn/YWGdKlh/3LbXXq5xDrluzKWysqT3J6IdeRYGk5ZPyjcfT
 6MZnT0R4dqnntIogwVfEw9U/SOHDinI0vxGXnNYoqTZGQ0LbDYSuLjP4iuoo0p76fJUcSn8Tg
 sO63SlH8GE2i/0cO768tBmihC1hJfhkxBefJIPAppCVuWPSRlHAYTZyGJJqVCC6knsCov9MH3
 K7esQ6XZmWCT0FTwKeMdXvZYE5STeg41iz4tCBOC1RnWrs54TKh/LrG19UzByB1jg5W1NgDce
 ftr+uUziRyXAsoa3F3n5U5dy4d2V+vgrZpkE93rZTmXmVSXOYwfKsrLtQ9BHCOi8u66UKwY8R
 Ivq0yuAJH8z2T9arysLSUdxnAz+5chl7qjvlDJ/DTcng6bcpgKflTFEhmNPK8GSk8JnAiFQXX
 vm2B8EMM9h8Kb4mG/POLMyUu5XXotHQLId45tYJID6r7F6IfwMEFjR2No1IfG7ln33YAOv/Ns
 2Uw9tiEK/bEVJ72IeijKXRL35CRV+/xL0jnlaYn0cmGiNBwdGFJarnrsIcYkm7kmjBK+Uw2mn
 /R+PODXDnjNWLl638PC6Loi4kaPebH691XFxrZ1WK8HIwXXHfNnmsHWwKWMESSij0uvMKl3lr
 OTELxvzVI3n+im3N/lMOPYY6cpbska/4hgUmfjGkDGoiwU=
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

On 1/30/25 07:20, Ilias Apalodimas wrote:
> Upcoming patches are switching the memory mappings to RW, RO, RW^X page

RWX, RO, RW?

> permissions after the U-Boot binary and its data are relocated. Add
> annotations in the linker scripts to and mark text, data, rodata etc
> sections and align them to a page boundary
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   Makefile                       | 15 +++++++++------
>   arch/arm/cpu/armv8/u-boot.lds  | 32 +++++++++++++++++++-------------
>   include/asm-generic/sections.h |  2 ++
>   lib/efi_loader/efi_runtime.c   |  2 ++
>   4 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 33bb86343c5b..8d7c062ec830 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2176,13 +2176,16 @@ System.map:	u-boot
>   # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
>   # R_AARCH64_RELATIVE (64-bit).
>   checkarmreloc: u-boot
> -	@RELOC=3D"`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
> +	@RELOCS=3D"`$(CROSS_COMPILE)readelf -r -W $< | cut -d ' ' -f 4 | \
>   		grep R_A | sort -u`"; \
> -	if test "$$RELOC" !=3D "R_ARM_RELATIVE" -a \
> -		 "$$RELOC" !=3D "R_AARCH64_RELATIVE"; then \
> -		echo "$< contains unexpected relocations: $$RELOC"; \
> -		false; \
> -	fi
> +	for reloc in $$RELOCS; do \
> +		if [ "$$reloc" !=3D "R_ARM_RELATIVE" -a \
> +		     "$$reloc" !=3D "R_AARCH64_RELATIVE" -a \
> +		"$$reloc" !=3D "R_AARCH64_NONE" ]; then \
> +			echo "$< contains unexpected relocations: $$reloc"; \
> +			false; \
> +		fi; \
> +	done

This seems to be an unrelated change that should go into a separate patch.

>
>   tools/version.h: include/version.h
>   	$(Q)mkdir -p $(dir $@)
> diff --git a/arch/arm/cpu/armv8/u-boot.lds b/arch/arm/cpu/armv8/u-boot.l=
ds
> index 857f44412e07..18e168e27135 100644
> --- a/arch/arm/cpu/armv8/u-boot.lds
> +++ b/arch/arm/cpu/armv8/u-boot.lds
> @@ -22,7 +22,7 @@ SECTIONS
>
>   	. =3D ALIGN(8);
>   	__image_copy_start =3D ADDR(.text);
> -	.text :
> +	.text ALIGN(4096):
>   	{
>   		CPUDIR/start.o (.text*)
>   	}
> @@ -36,9 +36,12 @@ SECTIONS
>                   __efi_runtime_stop =3D .;
>   	}
>
> -	.text_rest :
> +	.text_rest ALIGN(4096) :
>   	{
> +		__text_start =3D .;
>   		*(.text*)
> +		. =3D ALIGN(4096);
> +		__text_end =3D .;
>   	}
>
>   #ifdef CONFIG_ARMV8_PSCI
> @@ -98,27 +101,30 @@ SECTIONS
>   	}
>   #endif
>
> -	. =3D ALIGN(8);
> -	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
> +	.rodata ALIGN(4096): {
> +	    __start_rodata =3D .;
> +	    *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
> +	    . =3D ALIGN(4096);
> +	    __end_rodata =3D .;
> +	}
>
> -	. =3D ALIGN(8);
> -	.data : {
> +	.data ALIGN(4096) : {
> +	    __start_data =3D .;
>   		*(.data*)
> +	    . =3D ALIGN(4096);
> +	    __end_data =3D .;
>   	}
>
> -	. =3D ALIGN(8);
> -
> -	. =3D .;
> -
>   	. =3D ALIGN(8);
>   	__u_boot_list : {
>   		KEEP(*(SORT(__u_boot_list*)));
>   	}
>
> -	.efi_runtime_rel : {
> +	.efi_runtime_rel ALIGN(4096) : {
>                   __efi_runtime_rel_start =3D .;
>   		*(.rel*.efi_runtime)
>   		*(.rel*.efi_runtime.*)
> +		. =3D ALIGN(4096);
>                   __efi_runtime_rel_stop =3D .;
>   	}
>
> @@ -136,10 +142,10 @@ SECTIONS
>   	/*
>   	 * arch/arm/lib/crt0_64.S assumes __bss_start - __bss_end % 8 =3D=3D =
0
>   	 */
> -	.bss ALIGN(8) : {
> +	.bss ALIGN(4096) : {
>   		__bss_start =3D .;
>   		*(.bss*)
> -		. =3D ALIGN(8);
> +		. =3D ALIGN(4096);
>   		__bss_end =3D .;
>   	}
>
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sectio=
ns.h
> index b6bca53db10d..5626df796f33 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -23,6 +23,7 @@ extern char __kprobes_text_start[], __kprobes_text_end=
[];
>   extern char __entry_text_start[], __entry_text_end[];
>   extern char __initdata_begin[], __initdata_end[];
>   extern char __start_rodata[], __end_rodata[];
> +extern char __start_data[], __end_data[];
>   extern char __efi_helloworld_begin[];
>   extern char __efi_helloworld_end[];
>   extern char __efi_var_file_begin[];
> @@ -63,6 +64,7 @@ static inline int arch_is_kernel_data(unsigned long ad=
dr)
>
>   /* Start of U-Boot text region */
>   extern char __text_start[];
> +extern char __text_end[];
>
>   /* This marks the text region which must be relocated */
>   extern char __image_copy_start[], __image_copy_end[];
> diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
> index 35eb6a777665..c10a79301a92 100644
> --- a/lib/efi_loader/efi_runtime.c
> +++ b/lib/efi_loader/efi_runtime.c
> @@ -742,6 +742,8 @@ void efi_runtime_relocate(ulong offset, struct efi_m=
em_desc *map)
>   		      rel->info, *p, rel->offset);
>
>   		switch (rel->info & R_MASK) {
> +		case 0:
> +			break;

This seems to be an unrelated patch that should be in a separate patch.

Best regards

Heinrich

>   		case R_RELATIVE:
>   #ifdef IS_RELA
>   		newaddr =3D rel->addend + offset - CONFIG_TEXT_BASE;


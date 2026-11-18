Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273F606A334
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cWgn5tzk;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=FVB0+Z8K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65D94606F6;
	Wed, 18 Nov 2026 21:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OtnGBr8kwILS; Wed, 18 Nov 2026 21:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA2396064A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795035955;
	b=K8F1Bg18WAzCBUY7mskYlWULUMr65tPTNkrVe8CS1hhHZAqzcO4N/VOvYTsIdESddoTE
	 8Pm8/DpKt3VF+ZzUeEN/EK9m0Qs9OJNrNJF9kxMKb6ciVyvPqdjd/pRiMU515zmjyTqb0
	 lfE5zzUZc3ZExssFP0T3yX5zdHdD2KE1lp3JgJXzmC4F9zA3JRNJWoEN0PiAsnvckiYgt
	 HNDX3n4NnWJvaA0fV/pT1/1wUpHaATfd/5tZYm6rQRysTNN1jqrYLa4LhOT8SPeqeqfCE
	 cSVaq7UYvjC2NLBSKjwRscqgiUWEPp9BzY7KNwlSH0JOfdVVyZtYJ3TZUBUGlns2aig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795035955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nBBo08A4eMxc0YBJB4Vu8B16SppFfCAytf7Ks/AexzQ=;
	b=NIsEEdlrkeIHqoLWKbLzNPACkRPek9jhJD1Bn+u2rrR7KGCErenuxEh8ulqmWhtLdD8t
	 RtEuxVj9x63wHcT2qoTnJPAhTPtqloXTs+NzmUsz7SZwGl9YI/7dESXg+Ddcg9KMZ2QMf
	 RwZb/4GWyjDfZ1iMA27B2ZDUmSe1IQCsdxhu8nPCnO2v6SGvEv5I9pZ+H4fjaOHooZmT6
	 zRRTimu1m9CQ1IGSK9Fpf9csNHwKIPA/TdLYhH/LvDaqdasJHnB84BVW7+5TJN7SBKUYz
	 zAKhDWpIbGLqyEI2HUais4wKQH6ZpNvRTTLNk6TGmWSfi81KqKJFbKHm2lKxZS0N4ig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795035954;
	bh=nBBo08A4eMxc0YBJB4Vu8B16SppFfCAytf7Ks/AexzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWgn5tzk4vPocmuQJPOz+P5ZebQ8eCPNMUNYz+X4KJrS3WR7wxvz6alDFVMWh/DUn
	 xoa7/u7iqkowN4pu6IQST4CoBD7VWmSUgjwv/WhT0kgvGY4V/ACT4++Y0zZqUPpj4w
	 B5yt3cUVDCGFQ60rgOSoewJYlQRf/r2gOHpumSYzrmTG76kXPOM/QTQh6xm7FAsvt2
	 sDID62b0uk+PpUDtXt8vLfIWooLHKezqFczUMJqLLm+w2Xl0RxyVaz5azrfXP75gBz
	 eXFTHzGLzMQPAC3O+UXF00BTWNStxguD3u5CsifiMekTynHjYTUO+m5BP9lZh2+aYi
	 4ErOqSbIjBQFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA2396064A;
	Wed, 18 Nov 2026 21:05:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FAA42F1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3231F80E2E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uP_yLpj0ycdv for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBEC780E13
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FVB0+Z8K
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBEC780E13
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795035921;
 bh=nBBo08A4eMxc0YBJB4Vu8B16SppFfCAytf7Ks/AexzQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FVB0+Z8KIQIaC9F8J26fP7hxM4uOIzTpfNVVwWE5L0qT3fK8+tAoXdANtDgmOcSMB
 r3zGnq1uaQvo3IT6ocSfyqUWOYgpAlDIAMLtUsvsFwFgYKYeQFNbfS4ai0V3fbmwbw
 MDpsXOZhcl/mnjJajRG2E89fa14gLufD0NuAZkI3armupwdcTMVMx8z9hOpDcxi6C7
 EWllK1kcM7GOA1e9eSUQkpE/9fmIlSXlRipldrgoRxIDxgrV6Cqxe1s2nFNf918nbp
 swqLsJAhM5CUvvdM+G17YZG4VT8S7UM1yR/2MpyN9rGzeioMO4AeamPnYF4Dhbethw
 hCAR6IivSd68A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 413F9B22146A;
 Wed, 18 Nov 2026 22:05:20 +0100 (CET)
Message-ID: <f5e87e76-ea5e-4dc2-9b28-4f9eadcfbf5d@freeshell.de>
Date: Wed, 18 Nov 2026 13:05:13 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Disable M-mode IMSIC and APLIC nodes in DT passed
 to next stage in S mode
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, Yao Zi
 <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anirudh,

On 11/18/26 10:00, Anirudh Srinivasan wrote:
> When U-Boot is running in S mode and is used to boot linux, the DT passed
> to linux can either be the bundled in DT U-Boot and OpenSBI use, or be
> loaded by U-Boot from some boot media. In the former case, OpenSBI fixes
> up the DT to disable the M-mode IMSIC and APLIC nodes on an AIA system.
> These controllers are to be managed by M-mode software, so this is done
> to prevent linux from trying to probe them.
> 
> This fixup doesn't happen in the latter case because U-Boot loads a
> fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
> This gets rid of prints like this during linux boots.
> 

I think it is not necessary to mention specific software (U-Boot or
OpenSBI) in the lede paragraph of the commit message. That description
of Linux is a testing scenario (which is fine to also mention, in
secondary paragraph(s), or just omit from the commit mesage and leave it
to mailing list replies for cover letter and T-by tags). It would apply
equally to any S-mode kernel including U-Boot main app itself being
S-mode, GRUB EFI, *BSD, etc.

Essentially we accept that for RISC-V there is other third-party
software which may integrate with U-Boot and we cannot know the
consistency of device tree state in this context, even when we have
provided some of these modifications in the form of device tree
overrides to that software. It makes good sense to do some fixup in
these likely situations. The important thing I'm reading for in this
description is, "what is it about the RISC-V platform M-mode / S-mode in
U-Boot that requires consistency checks of device tree properties at
runtime?"

Are these the only consistency checks that we foresee?

> [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
> [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
> [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)
> 
> [   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready
> 
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>  arch/riscv/lib/fdt_fixup.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
> index 6dfd1a2d5b8..ce8c18a7b92 100644
> --- a/arch/riscv/lib/fdt_fixup.c
> +++ b/arch/riscv/lib/fdt_fixup.c
> @@ -117,6 +117,80 @@ int riscv_board_reserved_mem_fixup(void *fdt)
>  	return 0;
>  }
>  

> +/**
> + * riscv_node_handles_mmode_external_interrupts() - Check if interrupt controller handles M-mode
> + * external interrupts
> + * @fdt: Pointer to the device tree
> + * @offset: Offset of node in DT to check
> + *
> + * Return: true if controller handles M-mode external interrupts IRQ_M_EXT (11), else false
> + */
> +static bool riscv_node_handles_mmode_external_interrupts(void *fdt, int offset)
> +{
> +	int i, len;
> +	const fdt32_t *interrupts_extended =
> +		fdt_getprop(fdt, offset, "interrupts-extended", &len);
> +	if (!interrupts_extended || !len || len % (2 * sizeof(u32)))
> +		return false;
> +	for (i = 1; i < len / sizeof(u32); i += 2) {

Read the size-cells property, or comment why this is assumed to be
size-cells=<2> (and what happens on non-64-bit platform if this is
applicable or not).

> +		if (fdt32_to_cpu(interrupts_extended[i]) == IRQ_M_EXT)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * riscv_aia_mmode_imsic_aplic_fixup() - Disable M-mode APLIC and IMSIC nodes in DT
> + * @fdt: Pointer to the device tree in which nodes are to be disabled
> + *
> + * On RISC-V AIA systems, M-mode software manages the M-mode APLIC and IMSIC.
> + * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
> + * could still be enabled, so fixup the DT to disable these nodes before passing
> + * it to the next S-mode stage.
> + *
> + * Return: 0 on success or error otherwise.
> + */
> +static int riscv_aia_mmode_imsic_aplic_fixup(void *fdt)
> +{

Critically this fixup routine does not *enable* the nodes *for* M-mode.
I cannot think of a better name for it than you have here, however.

Is this not an S-mode fixup routine?

Maybe... "riscv_aia_exit_mmode_imsic_aplic_fixup"

> +	int offset, err;
> +
> +	/* Disable M-IMSIC in APLIC-IMSIC configuration */
> +	fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,imsics") {
> +		if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
> +			err = fdt_status_disabled(fdt, offset);
> +			if (err < 0)
> +				return err;
> +		}
> +	}
> +
> +	/* Disable M-APLIC in APLIC only configuration */
> +	fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
> +		if (riscv_node_handles_mmode_external_interrupts(fdt, offset)) {
> +			err = fdt_status_disabled(fdt, offset);
> +			if (err < 0)
> +				return err;
> +		}
> +	}
> +
> +	/* Disable M-APLIC in APLIC-IMSIC configuration */
> +	fdt_for_each_node_by_compatible(offset, fdt, -1, "riscv,aplic") {
> +		int len, imsic_offset;
> +		const fdt32_t *msi_parent = fdt_getprop(fdt, offset, "msi-parent", &len);
> +
> +		if (msi_parent && len >= sizeof(fdt32_t)) {
> +			imsic_offset = fdt_node_offset_by_phandle(fdt, fdt32_to_cpu(*msi_parent));
> +			if (imsic_offset >= 0 &&
> +			    riscv_node_handles_mmode_external_interrupts(fdt, imsic_offset)) {
> +				err = fdt_status_disabled(fdt, offset);
> +				if (err < 0)
> +					return err;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_OF_BOARD_FIXUP
>  int board_fix_fdt(void *fdt)
>  {
> @@ -165,5 +239,15 @@ int arch_fixup_fdt(void *blob)
>  	if (err < 0)
>  		return err;
>  

> +	/*
> +	 * Disable M-mode APLIC and IMSIC nodes in DT passed
> +	 * to next stage if we're in S mode
> +	 */
> +	if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
> +		err = riscv_aia_mmode_imsic_aplic_fixup(blob);

This could be clearer to say "When not in M-mode then disable M-mode
APLIC and IMSIC nodes"

The subroutine name is already very descriptive but this comment would
be fully redundant if the function name is clearer about its
functionality, and would not need a comment. (See previous suggestion
about function name).

> +		if (err < 0)
> +			return err;
> +	}
> +
>  	return 0;
>  }
> 
> ---
> base-commit: 83b1ec64ede9998566e6a82b22848c20a33f4aff
> change-id: 20261118-mimsic_maplic_fixup-051bd38d0985
> 
> Best regards,
> --  
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> 

Overall looks good to me, I want to know why we're not reading the
size-cells, and then refine the descriptions to be clearer about what I
am looking at in front of me so that a function name does not need a
comment to explain what it is doing.

It is a level of technical detail I am not familiar with, so if you can
make it make sense to me then it will be clear for everyone.

Thanks,

-E

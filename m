Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C37606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cwB43baf;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=NHfjVClx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89E0B8149A;
	Thu, 19 Nov 2026 21:32:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qrt1n52cfyGo; Thu, 19 Nov 2026 21:32:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 406A081565
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795123941;
	b=UdGhqaZzfxTKmMgYmFAQkfBhUkqv2H+28e0Mt3Q0Tk2KT1taNpo7ZvYXsiK5I+Z8Cjqn
	 NtAJGMsyXWG1pHZ1vcHxNCKtZQ8tPJPIcgJ9snXBgjneNQUDJPQWzQQm6bRW8dud5dPcF
	 uVcSlFFB8Z0z/ek/xNDQFeO+ouRmDa0iipJqGUI9bAz+GpVsdlwPk/IyoGEeTlVKDw03S
	 OrygdUHtnBPyfkvdvtf63s3rGJditrojcRo4S5tYPurKR3pL74MiWD27CXO5NFFKZ8or2
	 F4OjPGNNp4rTVG9yprK1o4pjvy3YeB+vDq7PSx6RG4JqPLUVp07cC5/v2yCFO1n7EQQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795123941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sHuBhBXcYBpO8NR7PdZuPRh7Ss1ifQHKxkdwLoZPBZA=;
	b=ZR38VEW7KzZu1GEg9Eo323mDDPxPMfzwx2Os7QHMdyWyyfdHQRjCX8lQyXnF+9en9D4c
	 DcJF3ArFGJveKvfsJJUIME8pA55LNqirmtMEGwxi6rSGfZZHAkP9HfODZv8xr7LIWfo8u
	 q1f0cw7pT2+wAa41XRJ/6d4ktDs4TaMD/E5XdOcJzzHtxX5C1eQU54U203LOM+yXpGtSI
	 NbDXmdWI3X0K68nnBWmKrSY6uidwZjRriMQIq6zsNiicVq+fO1PYJEhlKkHOrhiQlh9yO
	 jitXsyUghAmLi1J5Qlt3oHNXUP/yXImiPh7Jxu8ESOxi7pQ+NtpGm4YlsS1Gmh9WyxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=NHfjVClx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795123941;
	bh=sHuBhBXcYBpO8NR7PdZuPRh7Ss1ifQHKxkdwLoZPBZA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cwB43bafKK31f/vI23Suy9NhOLtcu82lQvZaxhCA3MjXmtO61AOeOXUAyuX3r0tO5
	 Onj9+Y3GwrIdnY8nkwtErS5RcTJkTp2Pr4yxYUo0PpyH6jdafn31ruSuOAn/BxWxNv
	 E2FCI8ufIIMq+sO8I4uQllxBVkr9NmhoMm4Blxs8Y/r44u8Wuvt2VNBwl1gUfOBS4j
	 2OU16bPLSq7ge5V7iYYJo3LIyx5yzmmq0Xf8aEbcPxcAYtfJP7qkx23ShKfFfvzJcv
	 4NsZ6GdjOHIXgEMTBY+G8E3A1y0ncbkUyWGS6lBGZHHVCPVuXF5DyncgkbSMJ3ZB+v
	 PoItacdqEpEpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 406A081565;
	Thu, 19 Nov 2026 21:32:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4295C1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 287FB81553
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:32:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BEju2A9e9SMZ for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 21:32:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 836F08149A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=NHfjVClx
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 836F08149A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795123903;
 bh=sHuBhBXcYBpO8NR7PdZuPRh7Ss1ifQHKxkdwLoZPBZA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NHfjVClxTdjBfh/JZJmxxi4STIvB+Q8k2PerkTGLEf8kpKmIDrzicZrti1yuq7z81
 1yc/sfuIAdK/G9lKTPKdDv5tyNlAVY5TW7MI0Zo7oydM6E4bEIOfNwMgGe86DJ0fqe
 p7Q5CamDXwAvffCfI5UAB3rSlkQc7rcOBhWxlXTwtFWSc/sgxhQ7avWGfffdXSO1U0
 +ZrarZ/q77t2lZo7/PDv8fOvpB07a0z4tqdXg7BE+buFRmQqIXuJcf6+TdmyZNIafO
 Aztq98HkAtAI0zFyCZhyVI6tFuKwEILgWQoH5g2cRCH0nrj8c3nuUaOxwuO/LEYpLi
 62AQ2rj8w8n8A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 5CADAB221D16;
 Thu, 19 Nov 2026 22:31:42 +0100 (CET)
Message-ID: <ae7bc060-5d53-4d55-b006-89ac5fcbada5@freeshell.de>
Date: Thu, 19 Nov 2026 13:31:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, Yao Zi
 <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
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

On 11/19/26 07:47, Anirudh Srinivasan wrote:
> When U-Boot is running in S mode, the DT passed to the next S mode stage
> can either be the bundled in DT U-Boot and the previous M mode stage
> use, or be loaded by U-Boot from some boot media. In the former case,
> the M mode stage can fix up the DT to disable the M-IMSIC and M-APLIC
> nodes on an AIA system (for example, OpenSBI does this fixup). These
> controllers are to be managed by M-mode software, so this is done to
> prevent S mode software from trying to probe them.
> 
> This fixup doesn't happen in the latter case because U-Boot loads a
> fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
> This gets rid of prints like this during linux boots.
> 
> [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs available
> [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setup state (error -22)
> [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@a0000000 ((____ptrval____)), parent (____ptrval____)
> 
> [   10.727605] platform cc000000.interrupt-controller: deferred probe pending: platform: supplier a0000000.interrupt-controller not ready
> 
> Reviewed-by: E Shattow <e@freeshell.de>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Changes in v3:
> - Reword commit title to say M-APLIC/M-IMSIC and drop references to M Mode to avoid any confusion
> - Link to v2: https://patch.msgid.link/20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com
> 
> Changes in v2:
> - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_maplic_fixup
> - Drop most references to OpenSBI/Linux in commit message and just use M-mode/s-mode software
> - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup-v1-1-52dea8f39779@oss.tenstorrent.com
> ---
>  arch/riscv/lib/fdt_fixup.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
> index 6dfd1a2d5b8..49f5b3b5bb6 100644
> --- a/arch/riscv/lib/fdt_fixup.c
> +++ b/arch/riscv/lib/fdt_fixup.c
> @@ -117,6 +117,85 @@ int riscv_board_reserved_mem_fixup(void *fdt)
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
> +	const fdt32_t *interrupts_extended = fdt_getprop(fdt, offset, "interrupts-extended", &len);
> +
> +	/*
> +	 * Each entry is <phandle irq>. The phandle points to a riscv,cpu-intc
> +	 * node, whose DT binding sets #interrupt-cells = <1>, so each entry is
> +	 * 2 cells.
> +	 */
> +	if (!interrupts_extended || !len || len % (2 * sizeof(u32)))
> +		return false;
> +	for (i = 1; i < len / sizeof(u32); i += 2) {
> +		if (fdt32_to_cpu(interrupts_extended[i]) == IRQ_M_EXT)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * riscv_aia_mimsic_maplic_fixup() - Disable M-APLIC and M-IMSIC nodes in DT
> + * @fdt: Pointer to the device tree in which nodes are to be disabled
> + *
> + * On RISC-V AIA systems, M-mode software manages the M-APLIC and M-IMSIC.
> + * If S-mode U-Boot loads a device tree from boot media, the DT nodes for these
> + * could still be enabled, so fixup the DT to disable these nodes before passing
> + * it to the next S-mode stage.
> + *
> + * Return: 0 on success or error otherwise.
> + */
> +static int riscv_aia_mimsic_maplic_fixup(void *fdt)
> +{
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
> @@ -165,5 +244,12 @@ int arch_fixup_fdt(void *blob)
>  	if (err < 0)
>  		return err;
>  
> +	/* Disable M-IMSIC and M-APLIC nodes when we're not in M-mode */
> +	if (!CONFIG_IS_ENABLED(RISCV_MMODE)) {
> +		err = riscv_aia_mimsic_maplic_fixup(blob);
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

The code and function call-out comments LGTM, thanks for updating those.

nit: If I am understanding this correctly, then I suggest to drop
references to "boot media" in the commit description of where DT
originates from; we simply have the U-Boot control Fdt (in-memory dtb
with whatever modifications happened before it gets to our present
state) as it was passed from M-mode or SBI S-mode handoff regardless of
where it originates from. It exists, and we need to validate in U-Boot
runtime for uniformity with the current operating mode since U-Boot
source tree is a likely source of overrides [1] and non-uniformity in
handoff to S-mode kernels.

From what I understand of reading the code then that commit message
could be clearer as e.g.:

"Introduce fixup of initial control Fdt in S-mode for the current
operating mode to disable non-applicable M-mode specific M-IMSIC and
M-APLIC nodes.

This fixup is evaluated once for the control Fdt passed from the
previous stage and does not affect any replacement Fdt loaded from boot
media."

...unless this does filter again on subsequent actions loading DT from
boot media, as that's what the present commit message has me confused
about now. I don't think that it does, from what I understand reading
the code.

Keep my R-by tag, and up to you to refine the commit message or not as
you like. I appreciate your help with this as a follow-up to [1]. Thanks!

-E

1: https://lore.kernel.org/lkml/20261029162343.1896134-1-e@freeshell.de/

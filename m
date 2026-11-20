Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318F606A326
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g1xbCmcP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=hQb4gjxA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1629C40E1E;
	Fri, 20 Nov 2026 10:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZkuYv8JVENXD; Fri, 20 Nov 2026 10:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1F0F40E10
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795171699;
	b=SJagcZvdAFcWD52dxrYLsKmZmd8J3ZN0I2RAk6aoqkc2SpSrp5mkcTHBZZ+4a/oNkICQ
	 U0qkvOUKHtLFYlWyDXmgG5XK3SAJXL7+wVNflo5GwqcTW0GTJqPU+m+gd/f5elI6eNAzM
	 0JkVyARy8kJo4EXFiNA7Yo+hsUZLf0FrJtJ7AeBJhlGmDbcn7TJHbRPiw/4xbqgrXkv1H
	 jaPvi6riXseax6UaU9UgfOOwpAfdTSpMWSMMDuXp2OIqhAGML3PTFv2c12LAwtV7QAykT
	 oNEqbANpoWD3CZt4CbKwvRLwcRe9erpDCoku25rCKntYvLuQuKMpv0OW7SReOsiQTlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795171699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ZohoMailClient:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wlP6WwAtJCWNt0tlfROt39hjL8HmCmcyOFNg3wZvw9w=;
	b=Jrgxo3EWtvWjvMOtVcy1qzzyFSmqZ5/UrksQcWrIxuIwaYRFLBPwBrwEvjv8Zltid3KN
	 HjlX4N8JuEBdZXD1tU0JmQl+N5//PMdwlnleIQuGw/6DFmYRVGaqWkK1tPW0uaYKAOWmA
	 JznXDxSkoLR5gJGNOPNLAc44NFbu6QiEkesXe6VeKP/w1LSPQuKCNNOkB55z9owHuNWOR
	 KJNE/PEFEZ3zfCkn9IlzNRwELh2Cm4SQfbyclIHsWbsl/ezWEi75vvC+zYwdGoRfUNHUs
	 LEoqxyQxO25ZNs7J4nJtl4Tv9KbmgmxVs5Y1cfsuxCfI+Vw5ZmLOQIrI2nVNBEsDxqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=hQb4gjxA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795171699;
	bh=wlP6WwAtJCWNt0tlfROt39hjL8HmCmcyOFNg3wZvw9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g1xbCmcPNjLlp+E6/K7zeuHSFjeKQvkEK3vogdfKcnr0T3NwIQtjIXzzLPK56vFyI
	 qsQLtg4u2XCb4yFdVgxlxN2aCHMPfMqR32xW9GTmU/safwiQHzFhYFUXOtCr/WK8nJ
	 rkSUjCFaUPUaqIpZF//2tfjFnckHDIIFmFVJ7tE0PyEvbjrwvIndj9NExWTr+8QFK7
	 gk5dmlWLpMAu+S2h23PZk0tBVI6WmA2d04TJaIm2wxHZZtdS3girQ1GDLQaN7a8ZO4
	 /E0akpdHEoUzKftD52pb8+tcTYc14AGA/OglsC8iy5Hbq9XEL3w3008We2PLBw9T4t
	 pc35JL0CykZEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1F0F40E10;
	Fri, 20 Nov 2026 10:48:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4272770B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33FEA40E10
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHNE054Mobul for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 10:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D26D240D62
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hQb4gjxA
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D26D240D62
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:48:16 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=hQb4gjxA8sARrHz67l/vUW/Nb60o+yJqTEnDFSUY8uaDqv9yYK5is34CYA5WQjvJayn0BP616M64BPIs/3QVA+DAg+JRL6mCx91nYsSilH14JhcEs7vC9fmLW3thXz0cVBfYFfnh6EPTlGGZkAQ+RZ/gX8lkaWccdlMEP3+sxbI=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=wlP6WwAtJCWNt0tlfROt39hjL8HmCmcyOFNg3wZvw9w=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795171661907836.7516580520182;
 Fri, 20 Nov 2026 02:47:41 -0800 (PST)
Date: Fri, 20 Nov 2026 10:46:48 +0000
From: Yao Zi <me@ziyao.cc>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3] riscv: Disable M-IMSIC and M-APLIC nodes in DT passed
 to next stage in S mode
Message-ID: <awAlGMMg-6tcb1N7@pie>
References: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-mimsic_maplic_fixup-v3-1-e028e28fb958@oss.tenstorrent.com>
X-ZohoMailClient: External
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.158.14
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 09:47:07AM -0600, Anirudh Srinivasan wrote:
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

Please add a blank line after this if for readability.

Isn't the !len check here redundant? With len = 0, the loop would never
execute. I'm not sure whether it's better to remove it or not since it
might make the purpose more clear. It depends on you.

> +	for (i = 1; i < len / sizeof(u32); i += 2) {
> +		if (fdt32_to_cpu(interrupts_extended[i]) == IRQ_M_EXT)
> +			return true;
> +	}

Please and another blank line after this loop.

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

Should we use "reserved" instead of "disabled"? Quoting the devicetree
specification,

> "disabled"
>	Indicates that the device is not presently operational, but it
>	might become operational in the future (for example, something
>	is not plugged in, or switched off).
>
> "reserved"
>	Indicates that the device is operational, but should not be
>	used. Typically this is used for devices that are controlled by
>	another software component, such as platform firmware.

Another possible problem is that these loops overrides the status
unconditionally, turning already "reserved" devices into "disabled".

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

It should be possible for an APLIC to deliver interrupts to both the HART
and the IMSIC, and this branch seems to disable such an IMSIC, too.
Please update the comment.

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

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

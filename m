Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25378CCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 10:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B50D844E4;
	Thu,  9 Oct 2025 12:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="YYN1LB30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F50844F0; Thu,  9 Oct 2025 12:53:31 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A645C844DE
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 78B622618D;
 Thu,  9 Oct 2025 12:53:29 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Otwnlf1YF2g9; Thu,  9 Oct 2025 12:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760007208; bh=nzEcRckrXko2OiWI+Tk+SnRXYRB3NyjGx1lJ6a2GOPI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YYN1LB308xXNukAMvMwuTnBfREQ7dAwA3py9Ntw+mNvgQBdEYv7N4JuqODGp93v2E
 2oQlbAMd280Y0WhGtWfXNZPfUsEhmw0pJ396JyAta/Q7PoqsppaELTdyvDU0Pg/5XN
 gPISuPdVt0YPDEYJd6AGpJUybbKiUqsJKSgHgBUxzLvkw7FxLVGzxEBm4ZqS5I/pCF
 U2mCKoAp6fH/nppXm3QH85gmYIgB1keu5gwp6iagLocJcmxQXasAx0OaZxcoO3/z1M
 OcHoLF3OhOitWjv56SOUOYIKCq+XbySTxY4KblLlMvrtUAsmwc/UXB/tOh9nK0gy1S
 4sahoDgYTNBQQ==
Date: Thu, 9 Oct 2025 10:53:20 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v4 05/10] riscv: Add support for MIPS GIC syscon on
 RISC-V SoCs
Message-ID: <aOeUIPh_0N3Brj1Q@pie>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-6-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103021.1518687-6-uros.stajic@htecgroup.com>
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

On Tue, Aug 19, 2025 at 10:32:53AM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add basic support for the MIPS GIC syscon used on the P8700 SoC.
> Enables access to interrupt control via device tree matching.

The commit message is wrong. You cannot enable access to interrupt
controller with stub functions.

The IPI stuff, on RISC-V, is mostly used to boot HARTs into the
next-level firmware on SMP systems. As the platform does seem to contain
multiple HARTs (as indicated by the "startharts" command), they should
be implemented correctly.

...

> diff --git a/arch/riscv/lib/mips_gic.c b/arch/riscv/lib/mips_gic.c
> new file mode 100644
> index 00000000000..7d761c58e74
> --- /dev/null
> +++ b/arch/riscv/lib/mips_gic.c

...

> +int riscv_init_ipi(void)
> +{
> +	return 0;
> +}
> +
> +int riscv_send_ipi(int hart)
> +{
> +	return 0;
> +}
> +
> +int riscv_clear_ipi(int hart)
> +{
> +	return 0;
> +}
> +
> +int riscv_get_ipi(int hart, int *pending)
> +{
> +	return 0;
> +}
> +
> +static const struct udevice_id mips_gic_ids[] = {
> +	{ .compatible = "mips,gic0", .data = RISCV_SYSCON_PLICSW },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(mips_gic) = {
> +	.name		= "mips_gic",
> +	.id		= UCLASS_SYSCON,
> +	.of_match	= mips_gic_ids,
> +	.flags		= DM_FLAG_PRE_RELOC,
> +};

Regards,
Yao Zi

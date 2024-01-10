Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BC7C4725D
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D7C87A7B;
	Wed, 10 Jan 2024 15:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704895698;
	bh=bmYr3e1Fx8vcfqlanCjANQnvdy5AfYyw2eCFbb5/nWs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQXASoovHj97AGb726KVo3atDXZZ1fuF1cs2L8Q71o5ReNVj73dBzpiw5Gf9KotYz
	 TtDpWK+AfG0N1M89Gyw7gk9fOqDBDKX8m4Wvob1x/Y0NPbgHDtKukHmTIXnbExhyNF
	 4O9unVUjm4YpweveoJWseTreEX+jzQOhxjakgxH3rYd8JOZIDvm8d9n/psIaqxfQMV
	 OZRNSWwtnV3kVc15AeY1H3FW7CLIHZfYbwfdnNV9uhLZ01S7h679pBp4+K7b+TmymT
	 a9CHaXZ6iHgvV9E850iuPgJf/PlpTkf9MsXiwBCr3SklASUE+wRGSiky/1mEedKwx+
	 FyJzP51/ZSpjQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7842787A99; Wed, 10 Jan 2024 15:08:16 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FBFB87A79
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4T98lc4D73z9scd;
 Wed, 10 Jan 2024 15:08:12 +0100 (CET)
Message-ID: <698b72c1-5353-4608-bab0-ce3185498c0d@denx.de>
Date: Wed, 10 Jan 2024 15:08:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: AC5: Use finer grained memory map
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20231027004430.442136-1-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231027004430.442136-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T98lc4D73z9scd
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

On 10/27/23 02:44, Chris Packham wrote:
> The ATF implementation for AC5/AC5X ends up with bl31 living in some
> internal SRAM. This is in the middle of the large MMIO region that we
> were using. Adjust this to be finer grained blocks based on the address
> map from the AC5X Family Control and Management Subsystem Functional
> Datasheet.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-mvebu/alleycat5/cpu.c | 66 ++++++++++++++++++++++-------
>   1 file changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/alleycat5/cpu.c b/arch/arm/mach-mvebu/alleycat5/cpu.c
> index 8204d9627515..0f72ae1709be 100644
> --- a/arch/arm/mach-mvebu/alleycat5/cpu.c
> +++ b/arch/arm/mach-mvebu/alleycat5/cpu.c
> @@ -16,7 +16,10 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -#define RAM_SIZE	SZ_1G
> +#define AC5_PTE_BLOCK_DEVICE \
> +	(PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) | \
> +			 PTE_BLOCK_NON_SHARE | \
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN)
>   
>   static struct mm_region ac5_mem_map[] = {
>   	{
> @@ -31,30 +34,63 @@ static struct mm_region ac5_mem_map[] = {
>   		.phys = 0x00000000,
>   		.virt = 0xa0000000,
>   		.size = 0x100000,
> -
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -			 PTE_BLOCK_NON_SHARE |
> -			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
>   	},
>   	{
>   		/* MMIO regions */
>   		.phys = 0x100000,
>   		.virt = 0x100000,
>   		.size = 0x3ff00000,
> -
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -			 PTE_BLOCK_NON_SHARE |
> -			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
>   	},
>   	{
> -		/* MMIO regions */
>   		.phys = 0x7F000000,
>   		.virt = 0x7F000000,
> -		.size = 0x21000000,
> -
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -			 PTE_BLOCK_NON_SHARE |
> -			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +		.size = SZ_8M,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	{
> +		.phys = 0x7F800000,
> +		.virt = 0x7F800000,
> +		.size = SZ_4M,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	{
> +		.phys = 0x7FC00000,
> +		.virt = 0x7FC00000,
> +		.size = SZ_512K,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	{
> +		.phys = 0x7FC80000,
> +		.virt = 0x7FC80000,
> +		.size = SZ_512K,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	{
> +		.phys = 0x7FD00000,
> +		.virt = 0x7FD00000,
> +		.size = SZ_512K,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	/* ATF region 0x7FE00000-0x7FE20000 not mapped */
> +	{
> +		.phys = 0x7FE80000,
> +		.virt = 0x7FE80000,
> +		.size = SZ_512K,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	{
> +		.phys = 0x7FFF0000,
> +		.virt = 0x7FFF0000,
> +		.size = SZ_1M,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
> +	},
> +	{
> +		.phys = 0x80000000,
> +		.virt = 0x80000000,
> +		.size = SZ_2G,
> +		.attrs = AC5_PTE_BLOCK_DEVICE,
>   	},
>   	{
>   		0,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

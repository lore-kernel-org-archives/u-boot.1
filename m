Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01754C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 07:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96DB86429;
	Mon, 28 Aug 2023 09:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="ezRp2i1D";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="KZfO814G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC0B86412; Mon, 28 Aug 2023 09:17:19 +0200 (CEST)
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018F486412
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from ziongate (localhost [127.0.0.1])
 by ziongate (OpenSMTPD) with ESMTP id 6e204e06;
 Mon, 28 Aug 2023 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=mAXgpO+IoaMPoBcKKaYW4+jv6I0=; b=ezRp2i1D/V+vzhtyU52rjv63OHPR
 mYqT3cypH7fY6dHTQ8IjKYYDiNqSq3cA/UAwTGZVWxjGhE8QpiukXcyefAjW3F9h
 TBQh9GXRIIbXyXDjSGu7+rhXzZumFCa6+bk+YjoMbaTaAgOVQipZ3wB/M84BUIVB
 CEa0JmmHdmBw1KM=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
 default; b=IxG3Rt3BjH8fOQJcB8tlO22BgPLWrl/SxBB2WxLq2FohsyHGiY2k6
 l4rq/Hyso1NV9XBfBR5CkeQFFzxZhIJnVloJCjgTZtmDmXdq+0eJ0pTFtzIXwcYe
 7MVbAkjHZgsY4pbcRRXLj977oYwV4xJkb5pU2E/ynm6h/Hz+h0QOZ4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=20190913; t=1693207035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mgPrwTNbDx5V56oUeYt7PlJRvBBJbhzH734jB0cpss=;
 b=KZfO814Gnqbp/LCRemYbJqRRSE2kSP894PmChJT4exLUZxB+xz6tEZCmTT3jcdBkZldBNc
 9wVN/py+TLas3viKVFaS11+oBRycuoaip8LHopJubfCyuY8WkNGZjOcs8wtPixhM7+0jJ/
 /IskzaWnow/nFlvA0f8gDMLWXlAjq8U=
Received: from [192.168.0.2] (host-82-50-168-26.retail.telecomitalia.it
 [82.50.168.26]) by ziongate (OpenSMTPD) with ESMTPSA id e63a256c
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 28 Aug 2023 07:17:15 +0000 (UTC)
Message-ID: <8e555bfb-dd81-9781-3a8f-20d251ef69dc@kernel-space.org>
Date: Mon, 28 Aug 2023 09:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH] tools: relocate-rela: Fix BE symtab handling
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Angelo Durgehello <angelo.dureghello@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Ovidiu Panait <ovpanait@gmail.com>, Simon Glass <sjg@chromium.org>,
 Zong Li <zong.li@sifive.com>
References: <20230730221652.223841-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20230730221652.223841-1-marek.vasut+renesas@mailbox.org>
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

applied to u-boot-coldfire

Thanks,
angelo

On 31/07/23 12:16 AM, Marek Vasut wrote:
> The symtab contains data in target endianness, convert the data to
> native endianness before doing any operations and on them, and back
> to target endianness before updating the bin file.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Angelo Durgehello <angelo.dureghello@timesys.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Ovidiu Panait <ovpanait@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Zong Li <zong.li@sifive.com>
> ---
>   tools/relocate-rela.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
> index f230ec5676c..e28e7fcc6f5 100644
> --- a/tools/relocate-rela.c
> +++ b/tools/relocate-rela.c
> @@ -78,6 +78,14 @@ static uint32_t elf32_to_cpu(uint32_t data)
>   	return be32_to_cpu(data);
>   }
>   
> +static uint32_t cpu_to_elf32(uint32_t data)
> +{
> +	if (ei_data == ELFDATA2LSB)
> +		return cpu_to_le32(data);
> +
> +	return cpu_to_be32(data);
> +}
> +
>   static bool supported_rela(Elf64_Rela *rela)
>   {
>   	uint64_t mask = 0xffffffffULL; /* would be different on 32-bit */
> @@ -602,14 +610,16 @@ static int rela_elf32(char **argv, FILE *f)
>   			}
>   
>   			debug("Symbol description:\n");
> -			debug(" st_name:\t0x%x\n", symbols.st_name);
> -			debug(" st_value:\t0x%x\n", symbols.st_value);
> -			debug(" st_size:\t0x%x\n", symbols.st_size);
> +			debug(" st_name:\t0x%x\n", elf32_to_cpu(symbols.st_name));
> +			debug(" st_value:\t0x%x\n", elf32_to_cpu(symbols.st_value));
> +			debug(" st_size:\t0x%x\n", elf32_to_cpu(symbols.st_size));
>   
> -			value = swrela.r_addend + symbols.st_value;
> +			value = swrela.r_addend + elf32_to_cpu(symbols.st_value);
>   
>   			debug("Value:\t0x%x\n", value);
>   
> +			value = cpu_to_elf32(value);
> +
>   			if (fseek(f, addr, SEEK_SET) < 0) {
>   				fprintf(stderr, "%s: %s: seek to %"
>   					PRIx32 " failed: %s\n",

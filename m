Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D91C61D97
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A2486BAC;
	Thu, 23 Nov 2023 18:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18B8875AA; Thu, 23 Nov 2023 18:20:18 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 016FB8622B
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 18:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E82C11042;
 Thu, 23 Nov 2023 09:21:02 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 053953F7A6;
 Thu, 23 Nov 2023 09:20:15 -0800 (PST)
Date: Thu, 23 Nov 2023 17:20:13 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Robert Catherall <robert.catherall@arm.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: afs: Set the filesize env. var. on load
Message-ID: <20231123172013.6558fbd3@donnerap.manchester.arm.com>
In-Reply-To: <20231123141601.28056-1-robert.catherall@arm.com>
References: <20231123141601.28056-1-robert.catherall@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 23 Nov 2023 14:16:01 +0000
Robert Catherall <robert.catherall@arm.com> wrote:

Hi Robert,

> The `afs load` command copies data to RAM. Set the filesize
> environment variable to record how much data was 'loaded'

Thanks for sending this, I realised this was indeed missing just recently!

> Signed-off-by: Robert Catherall <robert.catherall@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  cmd/armflash.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/armflash.c b/cmd/armflash.c
> index d1466f73aa..fdaea5ad81 100644
> --- a/cmd/armflash.c
> +++ b/cmd/armflash.c
> @@ -180,6 +180,7 @@ static int load_image(const char * const name, const ulong address)
>  {
>  	struct afs_image *afi = NULL;
>  	int i;
> +	loff_t len_read = 0;
>  
>  	parse_flash();
>  	for (i = 0; i < num_afs_images; i++) {
> @@ -197,6 +198,7 @@ static int load_image(const char * const name, const ulong address)
>  
>  	for (i = 0; i < afi->region_count; i++) {
>  		ulong from, to;
> +		u32 size;
>  
>  		from = afi->flash_mem_start + afi->regions[i].offset;
>  		if (address) {
> @@ -208,14 +210,20 @@ static int load_image(const char * const name, const ulong address)
>  			return CMD_RET_FAILURE;
>  		}
>  
> -		memcpy((void *)to, (void *)from, afi->regions[i].size);
> +		size = afi->regions[i].size;
> +		memcpy((void *)to, (void *)from, size);
>  
>  		printf("loaded region %d from %08lX to %08lX, %08X bytes\n",
>  		       i,
>  		       from,
>  		       to,
> -		       afi->regions[i].size);
> +		       size);
> +
> +		len_read += size;
>  	}
> +
> +	env_set_hex("filesize", len_read);
> +
>  	return CMD_RET_SUCCESS;
>  }
>  


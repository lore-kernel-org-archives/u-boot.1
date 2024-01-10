Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1053C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19AC987ABE;
	Wed, 10 Jan 2024 15:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704895817;
	bh=SRwKr6t7fVHcKJlOZ2V1IrfUrne5w8zOo3fr+u2wcdQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ho7uVCmgBbf86g8Z+V5fXXEMl2DwatdabOk7TqSDn9GoRI0MM07p16TvbGjoVUwoi
	 8qT3MUMGjH/r3lHCownS1J/Ds71NzqQ93fs9LORhEQBW5wJa4C12fnG8O5AKt+D9yj
	 MZZ7l3wqHtUz+3G0mbe5BPqI1E1bTGPa82b9IRXtwzhy0fwOwnHXZajmCzzIihvnzw
	 w5fDsBTLP3Y7gxYVoParrIIEnZVydDicjm+saOJ+mdSogqDKwwyto2GfcKh1+Yz/Yj
	 jxs5E5fsFK7GKbAO+N+MgIbK0IygNLB+HmoGTWu1xNs2RaOOZU/OdvLR4n0efZ4xJq
	 oWfxfMA17KSsQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E92F87A88; Wed, 10 Jan 2024 15:10:15 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F4487A7B
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4T98nv1hKHz9sZN;
 Wed, 10 Jan 2024 15:10:11 +0100 (CET)
Message-ID: <4dbc517f-8610-4380-bafb-5b54d969cbc1@denx.de>
Date: Wed, 10 Jan 2024 15:10:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
References: <20231129101117.60177-1-robert.marko@sartura.hr>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231129101117.60177-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T98nv1hKHz9sZN
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

On 11/29/23 11:11, Robert Marko wrote:
> Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
> which makes it hard to add support for any other board to be fixed up.
> 
> So, lets just move the FDT fixup code to a separate function and call it
> if compatible matches, there should be no functional change.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Stefan Roese <sr@denx.de>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
> index 04124d8014..1471caa9a6 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
>   #endif
>   
>   #ifdef CONFIG_OF_BOARD_SETUP
> -int ft_board_setup(void *blob, struct bd_info *bd)
> +static int espressobin_fdt_setup(void *blob)
>   {
> -#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>   	int ret;
>   	int spi_off;
>   	int parts_off;
>   	int part_off;
>   
>   	/* Fill SPI MTD partitions for Linux kernel on Espressobin */
> -	if (!of_machine_is_compatible("globalscale,espressobin"))
> -		return 0;
> -
>   	spi_off = fdt_node_offset_by_compatible(blob, -1, "jedec,spi-nor");
>   	if (spi_off < 0)
>   		return 0;
> @@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   		return 0;
>   	}
>   
> +	return 0;
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +	if (of_machine_is_compatible("globalscale,espressobin"))
> +		return espressobin_fdt_setup(blob);
>   #endif
>   	return 0;
>   }

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

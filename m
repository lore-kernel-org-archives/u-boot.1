Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5451C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 06:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC9386823;
	Mon, 18 Sep 2023 08:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695019647;
	bh=EQIp8PxLRvxPXOpjTZS194BDsLjuPrVoeEpgpoWeHhg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KAfIL3Xvvcu41hT0TASCf8c1wixvliQ6rPotUTTX2fNLGvTzM8HZCUtqTGPYeUJhr
	 c/GD+dlZ7ip0ExvAevHWYHny8Pf+9bJ9wKrjIag0itjmYo2ICItJIr0I+XXriPhsCU
	 ELGEuEiqEvd4rxvbRnp57ikgb60m1jwgJmTqkBU32YQcnmQ4XBpTH0VVe/v+e3KuSy
	 gWhXIyag6eNgljwxR55W5jf93Sbvh4m92ZuMhfJrJQKO1Y/1RO9GEhP+x4iECTTybH
	 MyDnqzLCFUcd9gL8cejUbCa/G0cre6Ztx6UEK/bVTNZbLpE9UPi+rhCXn9nq77/RGO
	 17SJDpPG/CYnQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF0486898; Mon, 18 Sep 2023 08:47:26 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8371A8658D
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 08:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4RpwMZ3SwGz9sRj;
 Mon, 18 Sep 2023 08:47:22 +0200 (CEST)
Message-ID: <510d5c68-ea28-e3be-5fa0-2d8dfba2572b@denx.de>
Date: Mon, 18 Sep 2023 08:47:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>, u-boot@lists.denx.de
Cc: luka.perkov@sartura.hr
References: <20230914101642.1603383-1-robert.marko@sartura.hr>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230914101642.1603383-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/14/23 12:16, Robert Marko wrote:
> Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
> which makes it hard to add support for any other board to be fixed up.
> 
> So, lets just move the FDT fixup code to a separate function and call it
> if compatible matches, there should be no functional change.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
> index 3ab6e8873d..da325e8c75 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -359,18 +359,14 @@ int last_stage_init(void)
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
> @@ -455,6 +451,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
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

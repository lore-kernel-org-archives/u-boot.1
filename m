Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14902C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AFF8812C;
	Thu, 28 Mar 2024 10:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711619809;
	bh=lVipQZ1I8jf/nYAOVsbrpkMw6Wkyto3AbniMbdNprbs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3+2X2X9lxEDb8Zuh9MIHMcya3x+zEqIl50mTkb41JIZVDaG0Ah2XWYlpIFNV/6rC
	 fE+zl4Sm8bC3SjARCvvPDSh1NboZp0xFFlufJI8YTlYoNA+Ybmap5kCYAnbArSz1LQ
	 7NL+gHsHadazHRo55bPcqjXupGB+hfFYJbHynRGUBcyVfy5Mnx9ycYWf2vIuXXJ4DO
	 3QaTef+bOQM3YInp3ZzRaN3Yg3qiRy2SwPjFNcJ08gTE1WhqEBdTzoTckZJxOps7SE
	 dhZdSmXQvGfgqE/bgl96oRzhTaj+Fc5aFtcSM0ZFXmM04uPX2Z4YNhuMJt1ngrKcZE
	 ZDrs0Z7W2zTFw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5738B8812C; Thu, 28 Mar 2024 10:56:48 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926EA87E75
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4zTS4yQ7z9sZN;
 Thu, 28 Mar 2024 10:56:44 +0100 (CET)
Message-ID: <cd6fd531-e855-4230-853c-4ac90de605bc@denx.de>
Date: Thu, 28 Mar 2024 10:56:44 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 07/18] arm: mvebu: turris_omnia: Disable
 Atmel SHA node if not present
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-8-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-8-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zTS4yQ7z9sZN
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

On 3/27/24 17:23, Marek Behún wrote:
> If the FEAT_CRYPTO feature bit is present in MCU features, the board
> crypto is implemented by MCU and the Atmel SHA chip is not present.
> Disable Atmel SHA device-tree node in that case.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index b2f0088e5e..3b7a71bdad 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -1007,6 +1007,25 @@ static int fixup_mcu_gpio_in_eth_wan_node(void *blob)
>   	return 0;
>   }
>   
> +static void fixup_atsha_node(void *blob)
> +{
> +	int node;
> +
> +	if (!omnia_mcu_has_feature(FEAT_CRYPTO))
> +		return;
> +
> +	node = fdt_node_offset_by_compatible(blob, -1, "atmel,atsha204a");
> +	if (node < 0) {
> +		printf("Cannot find ATSHA204A node!\n");
> +		return;
> +	}
> +
> +	if (fdt_status_disabled(blob, node) < 0)
> +		printf("Cannot disable ATSHA204A node!\n");
> +	else
> +		debug("Disabled ATSHA204A node\n");
> +}
> +
>   #endif
>   
>   #if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
> @@ -1020,6 +1039,8 @@ int board_fix_fdt(void *blob)
>   	fixup_msata_port_nodes(blob);
>   	fixup_wwan_port_nodes(blob);
>   
> +	fixup_atsha_node(blob);
> +
>   	return 0;
>   }
>   #endif
> @@ -1211,6 +1232,8 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	fixup_msata_port_nodes(blob);
>   	fixup_wwan_port_nodes(blob);
>   
> +	fixup_atsha_node(blob);
> +
>   	return 0;
>   }
>   #endif

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

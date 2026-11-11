Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F78E606A332
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qu/Ya+tN;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=bUDHcub2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 359BA811DB;
	Wed, 11 Nov 2026 15:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YWL0lAacA9SC; Wed, 11 Nov 2026 15:41:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 604768121D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794411679;
	b=qfSC1++kyYoHqEdksBWBjK4G7bHrBLoX4JSbQLSQm4hqvrdvXkB9pi+bBEQbj5L62dnq
	 gIeiTkM0JBXyUTEwgcUm4/5g3hbltiQ81DHAmvtue090FimlFPYmqVcvcWs9UAP5Ef4+U
	 RnGE6f4jPkX62Hw1vVIPilEjp41Cm7RXm0yQbXKF/hWTaCHVMTN44Y2W5RUfvX2UjNjmX
	 eOuBkaKqDDHusdw9MXvMRgwI4zuP0f6Exs1NMVFJ4lAOhH4ErkHzvencYGphHs9zK/5ak
	 Zl8ZO8cMpYJR2sAJ0EzTppkE1gXWwX6bIbIw9Z5f6uI3onUN5iEaMM0aEyCVeW4z18A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794411679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LhcAZ2H9PwViMghNGRniU5Cp9sTtEaF9rB7R2H1syVU=;
	b=SWAIbOrCGj6DejB0BNKOXR1xMe82FedvYe5czoWOGOAUVMSD6F14PH0bjz8n5htL9Ddi
	 3I2YGcNau0YmPQtOGcdLUBhLo6b6xXuqNwjhDBO28E3klWQBQ/vsFrzEGldS+FM/UQPQW
	 F5OmhFbaoQg7n3aYbRtzpNyXAaBbdj1WMPpns9HcYS26Yj86PQ0WlTqQkuBNv1jYQcnpp
	 CU5GaFnMQ5fUlQUpoXLOpVlVhwr6PKJfEzfugzLSh9+b1EETJFJwQkLHpwB5WjJq6pZft
	 oifmATYD/M26S8EmQvGQ0C8nJqGUjKfEodvP/AoF0opvwa9IAy99IYr4Pn8LkPbIvpQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=bUDHcub2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794411679;
	bh=LhcAZ2H9PwViMghNGRniU5Cp9sTtEaF9rB7R2H1syVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qu/Ya+tNcVVN9uaW4qA9eL2v0UJFGEI8GaMV6sZh+HW/jdSnVbuRHYxnkDXXY6/SC
	 5DgJ85z0MQzxP+NmXAlkOifTXwFy0V6pZ7aRrL9+gV7TJ+szqcsLOruW3IPrGvS9cq
	 +UiDCSBaI/aGm+SliP+93tWfghSD1SpGBhUir1JJQoWLVnQBFL9SYpPt3caR01Tklc
	 4esOnsyIRmM4e3KuPp/KuwVp/kbKHJqEqxWqbEi6VBWZwX8ZkxCS1ao458/ZUe53sM
	 EovDP57HYFmo8vd8NQN+hhCcPwOjheZkXK5T4axQJXj7lAvqnLfNnzBuxDWjyb00OK
	 7LQT/LxIVrORg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 604768121D;
	Wed, 11 Nov 2026 15:41:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5765BE09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40736811DB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i46sDZ-YNOaE for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0EF068121D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=45.157.188.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.10;
 helo=smtp-bc0a.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=bUDHcub2
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [45.157.188.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EF068121D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:41:14 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPnmm1K1KzGRg;
 Wed, 11 Nov 2026 16:41:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794411671;
 bh=LhcAZ2H9PwViMghNGRniU5Cp9sTtEaF9rB7R2H1syVU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bUDHcub2f10Ln40UpuB04A5LsFeHWFm8Ju85u+3Gi4gA8pMgJHK59jReXh+2cPIp3
 q0MYqsf51iuHHxeGq09aI+nxD+waKHJFoeplcbdav3qpkNOdSEyCHURlErsMQYERjY
 VLuuZjwUxk+0tCq3MxYZdDPMALvPKALWLXwKCKdkCl7vzsnb77O/ZxHXDIrYRuzv1G
 6pg0bTrik/ZH+NvYw3I0NRczSuDvvz+YvzfF4wGld+6sbQsoRM2T1Ov2GMqQsBdJ8w
 B0QkvFWyfGTsH0Cy3nPEoCz7eOoBiPqnYqye78JPYO9N7RCwMICa2TrxRlAj+oclrI
 YL2FGzn5yQCbQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPnml0bntznBD; Wed, 11 Nov 2026 16:41:11 +0100 (CET)
Message-ID: <a10d5dd9-ecdd-44e2-acce-8cb33501adec@0leil.net>
Date: Wed, 11 Nov 2026 16:41:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] ram: rockchip: px30: allow multiple SDRAM types
 selection
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org, Joseph Chen <chenjh@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261025-ddr-multi-v2-2-b82ff9c860ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Massimo, Joseph,

On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> Allow the inclusion of more than one SDRAM parameters set in the PX30
> sdram driver. The driver applies included sets in alphabetical order
> (DDR3, DDR4, LPDDR2, LPDDR3), stopping at the first one that makes
> SDRAM initialization function to complete with success. This order is
> debatable and not based on any specific reason.
> 
> Due to limited PX30 TPL maximum size, including support for more than
> one SDRAM type can require disabling some configuration options such
> as CONFIG_RAM_ROCKCHIP_DEBUG.
> 

@Joseph, can you help us out here?

We are trying to do the same thing that px30_ddr_333MHz_v*.bin from 
Rockchip's rkbin is doing: do DDR initialization without knowing which 
kind of DDR is soldered on the PX30-based device. Is there something 
special we need to do or know? For now, we are trying to initialize with 
DDR3 first, then DDR4 if it fails, then LPDDR2 if that fails too, then 
LPDDR3 if all fails. The first DDR init that doesn't fail is deemed 
successful. I do not know if this is correct, can you please provide 
some guidance?

> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/sdram_px30.c | 40 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> index c7ff924b2c5..7f51b9c4f8f 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -123,27 +123,24 @@ u32 addrmap[][8] = {
>   
>   struct dram_info dram_info;
>   
> -#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3) + \
> -	IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4) + \
> -	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2) + \
> -	IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3) > 1
> -#error "This driver only supports one DRAM configuration at a time"
> -#endif
> -
>   struct px30_sdram_params sdram_configs[] = {
>   #if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR3)
>   #include	"sdram-px30-ddr3-detect-333.inc"
> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
> +#endif
> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_DDR4)
>   #include	"sdram-px30-ddr4-detect-333.inc"
> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
> +#endif
> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR2)
>   #include	"sdram-px30-lpddr2-detect-333.inc"
> -#elif IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
> +#endif
> +#if IS_ENABLED(CONFIG_RAM_ROCKCHIP_LPDDR3)
>   #include	"sdram-px30-lpddr3-detect-333.inc"
> -#else
> -#error "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP option"
>   #endif
>   };
>   
> +static_assert(ARRAY_SIZE(sdram_configs) > 0,
> +	      "Please select suitable DRAM type CONFIG_RAM_ROCKCHIP options");
> +
>   struct ddr_phy_skew skew = {
>   #include	"sdram-px30-ddr_skew.inc"
>   };
> @@ -691,19 +688,11 @@ out:
>   	return ret;
>   }
>   
> -struct px30_sdram_params
> -		*get_default_sdram_config(void)
> -{
> -	sdram_configs[0].skew = &skew;
> -
> -	return &sdram_configs[0];
> -}
> -
>   /* return: 0 = success, other = fail */
>   int sdram_init(void)
>   {
>   	struct px30_sdram_params *sdram_params;
> -	int ret = 0;
> +	int ret = 1;

@Massimo: question: why the need to change ret to 1?

Because the driver enforces sdram_configs array to be non-empty, we're 
guaranteed to do at least one loop and thus ret is guaranteed to be set 
properly.

Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56CDC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276DE8875B;
	Mon,  8 Jul 2024 16:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720448085;
	bh=MRUdc3iSC6uFiv29fO1SIIAOdLHVi+VN5Iu9gN7xBq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BhTn8GykTBJe9mtK2l3m76OipxGXdS+9hJbidHGwbJlTQ8aisxF5jBUP5SEABpZNW
	 1CqrCi1eh3Et1PkFTae0t00SI2IpAv8VD2pkFPTymwVG00s+njw30kE9jE1EssB/5U
	 i9kycV4OUYu3yDubTuTC3ny4i8HEdtT5AwBM5QeZ7RWNgMLg1AGfJK8kqY1N2Ki1uG
	 HXUqIOkzqxdmlXJMrTLYpvIwl8Ax9Vj0EJkP9acc4D6PQzTwmnzc0xFeupksxmQhG9
	 ggQXER1DGKBQuoJMZA/r+/f5wBwLzFcNBVmxvSgQq2Az/n8XmjhJ8C6xGa+7SylhNV
	 XYXx/FY3i2e8A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FD18877E; Mon,  8 Jul 2024 16:14:43 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D488088756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4WHmMz68ydz9tQm;
 Mon,  8 Jul 2024 16:14:39 +0200 (CEST)
Message-ID: <87e745c4-cdca-4cf3-a336-ad6889f977b4@denx.de>
Date: Mon, 8 Jul 2024 16:14:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: env_sf_get_env_addr() missing check for
 CONFIG_ENV_IS_IN_SPI_FLASH
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, =?UTF-8?B?TWFyZWsgQmVow4PCum4=?=
 <kabel@kernel.org>
References: <20240606001202.11799-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240606001202.11799-1-mibodhi@gmail.com>
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

On 6/6/24 02:12, Tony Dinh wrote:
> The CONFIG_ENV_OFFSET is undefined if boot device is UART
> (CONFIG_MVEBU_SPL_BOOT_DEVICE_UART), or envs are not stored on flash
> (CONFIG_ENV_IS_NOWHERE). Check for CONFIG_ENV_IS_IN_SPI_FLASH as the first
> condition to determine whether env_sf_get_env_addr() should be provided.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-mvebu/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
> index 7c62a5dbb6..6dd729ae6e 100644
> --- a/arch/arm/mach-mvebu/cpu.c
> +++ b/arch/arm/mach-mvebu/cpu.c
> @@ -36,7 +36,7 @@ static const struct mbus_win windows[] = {
>   };
>   
>   /* SPI0 CS0 Flash of size MBUS_SPI_SIZE is mapped to address MBUS_SPI_BASE */
> -#if CONFIG_ENV_SPI_BUS == 0 && CONFIG_ENV_SPI_CS == 0 && \
> +#if defined(CONFIG_ENV_IS_IN_SPI_FLASH) && CONFIG_ENV_SPI_BUS == 0 && CONFIG_ENV_SPI_CS == 0 && \
>       CONFIG_ENV_OFFSET + CONFIG_ENV_SIZE <= MBUS_SPI_SIZE
>   void *env_sf_get_env_addr(void)
>   {

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

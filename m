Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2BCC2D0D0
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 05:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF8D088307;
	Mon, 24 Jun 2024 07:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="sZJGB6xf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2C7882E6; Mon, 24 Jun 2024 07:16:10 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D0E58819D
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 07:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8671B120004;
 Mon, 24 Jun 2024 08:16:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8671B120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1719206167;
 bh=KjXpYlpPJr8MNBmI2qMXSmKf5qb/3SPMKGiESQc6UQc=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=sZJGB6xfo+tYms2qylDwYTF1sNukYrmskN950I1NFqlifx22vl1E8zLtM6B+R0Y0R
 uGjsk0yIxTvRa2HZXglHZpWPRWaoNl3mGtfOWD05HPb+8Bf9xbV4+CORrY6HlDqEJ1
 HWevKXCflCcbWZ3Th9IugZUMN4y9JsolTk77sun+3sVyGPUCHJlrAhXLhw8rejKxk9
 ulIdBBrBS+GhGQcJ5+guWq3O6OCnVkXktfVNPDUwTZ4ZRaLx4FMnSSubJPkfnYcDL3
 5A6Q9gI3rk5jxNuMMrjiiyQTFABv2z2eqzB7C0IUC+rg4UZ+gaGA55hJrTDB8o5aQp
 zPSFp/BpCvnmg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 24 Jun 2024 08:16:07 +0300 (MSK)
Received: from [172.28.128.6] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 24 Jun 2024 08:16:06 +0300
Message-ID: <bc2584a6-38ac-c396-a70f-7904dfcbae39@salutedevices.com>
Date: Mon, 24 Jun 2024 08:04:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com>
Content-Language: en-US
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240602200836.3949773-2-avkrasnov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186074 [Jun 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2; salutedevices.com:7.1.1; 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/24 02:22:00 #25682877
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi, sorry, pls ping :)

Thanks

On 02.06.2024 23:08, Arseniy Krasnov wrote:
> Based on Linux kernel:
> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as a boot device")
> 
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  include/linux/mtd/rawnand.h      | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index c40a0f23d7..ed605b4af5 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
>  	if (ret == 16)
>  		chip->options |= NAND_BUSWIDTH_16;
>  
> +	if (ofnode_read_bool(node, "nand-is-boot-medium"))
> +		chip->options |= NAND_IS_BOOT_MEDIUM;
> +
>  	if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>  		chip->bbt_options |= NAND_BBT_USE_FLASH;
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fb002ae641..4eb880d8fb 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -218,6 +218,12 @@ enum nand_ecc_algo {
>  /* Device needs 3rd row address cycle */
>  #define NAND_ROW_ADDR_3		0x00004000
>  
> +/*
> + * Whether the NAND chip is a boot medium. Drivers might use this information
> + * to select ECC algorithms supported by the boot ROM or similar restrictions.
> + */
> +#define NAND_IS_BOOT_MEDIUM	0x00400000
> +
>  /* Options valid for Samsung large page devices */
>  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
>  

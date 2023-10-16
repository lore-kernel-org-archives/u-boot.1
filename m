Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96DACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B80B86823;
	Mon, 16 Oct 2023 11:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697446885;
	bh=bN603Eor2IrXTKHVa5PwGRsgByC5UssJQhxHYyq49ao=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SUqx3M4sEeruGfGMBLanQo5UBZOSl0a8B2EisXINeK20dx5v45UwqcK76loY7ggjD
	 nFmRWBr8SrLkGegJ9sKTPX4FqH6/Vl+F0gdAWzR5+RK6byz5xLXR5/zJJYfSpIHptb
	 RBEObJWsfwNNcGqV9xZh42kuPN0XT73+XW5SZ0bymHUeuIMs1qCUsYUCeybAbFhcUE
	 SH84WMKZEHU6M+8mJ52nAFoKEvRL9YbErYb7PfFDqTfPypjLAmYd2ysJWTAugdgQsf
	 GUvGjmYJmhEH2REp3CQMhMeWu8zAbR5uIj5AYtpAMAICPOC12AgQniVYLFd7jgBaHt
	 GEF7/Sz+lQ6Dg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F6986AE9; Mon, 16 Oct 2023 11:01:16 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8974E865A2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S8B0t2D9zz9smS;
 Mon, 16 Oct 2023 11:01:02 +0200 (CEST)
Message-ID: <24e09940-1cad-44c3-aaa1-89b9a4286357@denx.de>
Date: Mon, 16 Oct 2023 11:01:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] arm: mvebu: clearfog: support 512MB memory size from
 tlv eeprom
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
References: <20231008145804.25567-1-josua@solid-run.com>
 <20231008145804.25567-3-josua@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231008145804.25567-3-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S8B0t2D9zz9smS
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

On 10/8/23 16:58, Josua Mayer wrote:
> Handle 2GBit memory size value "2" from tlv eeprom on ddr
> initialisation, to support SoMs with 512MB ddr memory.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/solidrun/clearfog/clearfog.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
> index 4f4532b537e..6fa2fe5fe3e 100644
> --- a/board/solidrun/clearfog/clearfog.c
> +++ b/board/solidrun/clearfog/clearfog.c
> @@ -159,6 +159,9 @@ struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
>   	cf_read_tlv_data();
>   
>   	switch (cf_tlv_data.ram_size) {
> +	case 2:
> +		ifp->memory_size = MV_DDR_DIE_CAP_2GBIT;
> +		break;
>   	case 4:
>   	default:
>   		ifp->memory_size = MV_DDR_DIE_CAP_4GBIT;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

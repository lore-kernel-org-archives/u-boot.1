Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEBCDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D36786B71;
	Mon, 16 Oct 2023 11:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697446844;
	bh=4F/v7mCwZQ0kttPT7TaUV8yR0w2pJNMvq7Sm7YW3dKk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EvHs+4R6Rk9maJ2JILXLKwuLFLYkenPaGIBWcZuCWYA50Zd4uC96wsKsLDQEOkT1u
	 l2620mPS/YEZ0hnmjum0+wZ9Dw7xW9aefGzvUzO9tT5EMjPsYar+dL/jACPIziZGwX
	 he0NGDjEGl/mitiaOB7Xl+vo4LhQx9RGYxdoord+3OJYIP1GOYwUvtv+ATPMlXU6Bv
	 kAwrbXX2qoSgfqyVsMJIa42vDxiX1QoBPSpMBOzf/ZH6Thn23jebviNzeKLtwsTKom
	 ZJGSqDXVUbp9Y70wIXMRyUJjQGQe3sEZqAUpJ08qu4nWjntpi/VnuRCIJf1hirLppb
	 TpzYPc/jezegw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC5E86548; Mon, 16 Oct 2023 11:00:42 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B23868AE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S8B0L1GQSz9sTS;
 Mon, 16 Oct 2023 11:00:34 +0200 (CEST)
Message-ID: <da63f8b4-b57a-41ce-b581-10f377c3020f@denx.de>
Date: Mon, 16 Oct 2023 11:00:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm: mvebu: clearfog: read number of ddr channels
 from tlv data
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
References: <20231008145804.25567-1-josua@solid-run.com>
 <20231008145804.25567-2-josua@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231008145804.25567-2-josua@solid-run.com>
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

On 10/8/23 16:58, Josua Mayer wrote:
> Extend the existing tlv vendor extension used for ram size by one byte to
> also store the number of ddr channels.
> The length of the tlv entry can indicate whether the new information is
> present. If not default to single channel.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   board/solidrun/clearfog/clearfog.c | 14 +++++++++++++-
>   board/solidrun/common/tlv_data.c   |  7 ++++++-
>   board/solidrun/common/tlv_data.h   |  1 +
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
> index 6edb4221551..4f4532b537e 100644
> --- a/board/solidrun/clearfog/clearfog.c
> +++ b/board/solidrun/clearfog/clearfog.c
> @@ -36,7 +36,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define BOARD_GPP_POL_LOW	0x0
>   #define BOARD_GPP_POL_MID	0x0
>   
> -static struct tlv_data cf_tlv_data;
> +static struct tlv_data cf_tlv_data = { 0 };
>   
>   static void cf_read_tlv_data(void)
>   {
> @@ -168,6 +168,18 @@ struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
>   		break;
>   	}
>   
> +	switch (cf_tlv_data.ram_channels) {
> +	default:
> +	case 1:
> +		for (uint8_t i = 0; i < 5; i++)
> +			ifp->as_bus_params[i].cs_bitmask = 0x1;
> +		break;
> +	case 2:
> +		for (uint8_t i = 0; i < 5; i++)
> +			ifp->as_bus_params[i].cs_bitmask = 0x3;
> +		break;
> +	}
> +
>   	/* Return the board topology as defined in the board code */
>   	return &board_topology_map;
>   }
> diff --git a/board/solidrun/common/tlv_data.c b/board/solidrun/common/tlv_data.c
> index 11d6e4a1380..cf5824886c3 100644
> --- a/board/solidrun/common/tlv_data.c
> +++ b/board/solidrun/common/tlv_data.c
> @@ -45,9 +45,14 @@ static void parse_tlv_vendor_ext(struct tlvinfo_tlv *tlv_entry,
>   
>   	if (val[4] != SR_TLV_CODE_RAM_SIZE)
>   		return;
> -	if (tlv_entry->length != 6)
> +	if (tlv_entry->length < 6)
>   		return;
>   	td->ram_size = val[5];
> +
> +	/* extension with additional data field for number of ddr channels */
> +	if (tlv_entry->length >= 7) {
> +		td->ram_channels = val[6];
> +	}
>   }
>   
>   static void parse_tlv_data(u8 *eeprom, struct tlvinfo_header *hdr,
> diff --git a/board/solidrun/common/tlv_data.h b/board/solidrun/common/tlv_data.h
> index a1432e4b8e1..be3f782ac4a 100644
> --- a/board/solidrun/common/tlv_data.h
> +++ b/board/solidrun/common/tlv_data.h
> @@ -10,6 +10,7 @@ struct tlv_data {
>   	/* Store product name of both SOM and carrier */
>   	char tlv_product_name[2][32];
>   	unsigned int ram_size;
> +	uint8_t ram_channels;
>   };
>   
>   void read_tlv_data(struct tlv_data *td);

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

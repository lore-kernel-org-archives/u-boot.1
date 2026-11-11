Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C37606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TWPGulEA;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=SbetESqu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA5788122F;
	Wed, 11 Nov 2026 15:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-I_lq_C62Lt; Wed, 11 Nov 2026 15:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C1C9881279
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794412477;
	b=hrux5KWNQ8OFaHyGGZOtOp98AgXPIhefyNHqepDcwfWwVLDL9+YqiFCNeH+bC6YjMies
	 jfKsScArn27mOWBwHYYw015GMBNNv0xRZ9uf694uHPTiAKTJ/hRXhbIdNcmxY3ED2mwb3
	 aiYpfXKl/5xSBXTPoVkisCFuRxO8UzWaLSyFachT1MCkv1cfSE7qzZTNGZgHldFJU5hn6
	 AQGN9YUdceG5J0dRL6rUPJLULhRwgXSQw1NRkPJg/0Iyui5Q2y7xxlXx4ndRxVw/PORpf
	 hgpktYvZbSZFcIa+lOey/KFDDEWVF01r/8PXpha4GVgipgYQm8LtWKAYU2opI2lTIxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794412477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+q0llDe/nYdlW6R5yeuV+iNvkCyh1AyGJAljGx+HGSg=;
	b=rczozdGMKT1p+C5Uyh9XLsSODP+LwxJb8m2KKB6j6Rj1GXabFWWKfl2F5B0pl4lgDKDG
	 dl+xUjGddv4oF9QGJ1loU7oIGLoBIE207i7V33RdNBpd2TTZa/ZXi6h9HQht9S0JG694g
	 86M1IX5NnabsHCnf1hTZaJJhM2SzAdjjvmfWOsbwT6snVGrpooc9IHvOt6G7zG/zO7iQp
	 uTdeEBNKRPLdKg1XwOxRtZLHgIAmwkV8jao21fVBaaDnbFql/gjtsfR0kwMtmLmTIA//K
	 P1TBM0x8RgKLv2Jkd1CrAEc9XBzYfLnIBuncxBe8pJT5JMieJrFWlWio+AvXRkPjs+A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794412476;
	bh=+q0llDe/nYdlW6R5yeuV+iNvkCyh1AyGJAljGx+HGSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TWPGulEAZTzgyfWLiuH7ElrlROLpCRBdcdg+1Yy1p9zlgcF5wLp5N6b9SieTthwCx
	 EwS8CQwF/uSfVwXfijjjsMFFDLU//DehKXnZiOp8oT6TtKZOfibfuSQAfYwK1Mha2Y
	 IYCEulcj9elTc2D6jwUw5NESKOH04JudQQUrWzSH+Cc1cU/iMocC02V/3pGPnuRMv3
	 QZeBdi54F/w0CEK/daMhy/bh+zSA8hkPk4C2HshUDGedxdqy+PfHrk/BJqwIJ4Pt++
	 5eIaBW4M7F5f/aLwKblYcA0q2SVplRTLK3c1EpvJ5MjCStOgD1N4rmBqEOoZCiRB6K
	 K1WMwR3eZSsTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1C9881279;
	Wed, 11 Nov 2026 15:54:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57EC817CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D3034016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3evW2bIzfpuP for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0055D4006F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=45.157.188.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.12;
 helo=smtp-bc0c.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=SbetESqu
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0055D4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:54:33 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPp472HWQzThC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794412471;
 bh=+q0llDe/nYdlW6R5yeuV+iNvkCyh1AyGJAljGx+HGSg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SbetESquxj3q8r2hDGk57tsu5Z0SDqvgMv1BXRlPbS/UZ2e3GqJnkjUM56O418yTx
 homoWQF+2EvfMrBRPyw58A3KMuf8HT7wRBb/o/HjhKDLW6i5TI4eVjhQ6FCYFGbg7M
 p8sd8/ZM+8h9l/x78yep0xGWoco2hurm1IukbvSc59nqLTE0hzsVo0WlM0V/CNNHoP
 SXlx/MuLbaKmbGT05RgRX4yZP5oOKE/K6qC288rMLYMoS8cUmZ19MI1dN32DDnN8Ln
 Ph3s2a21KVp1mR+KulQF7WQu6aGSs41epT1u6TAic9JID8bt196+r0m27V/rXJmWpp
 JOPc5o+7q1Z+A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jPp4635l4zwcl; Wed, 11 Nov 2026 16:54:30 +0100 (CET)
Message-ID: <3e4b8eeb-ac8a-447d-98ea-74ec0e2ad14e@0leil.net>
Date: Wed, 11 Nov 2026 16:54:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ram: rockchip: reduce debugging code size
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20261025-ddr-multi-v2-0-b82ff9c860ba@gmail.com>
 <20261025-ddr-multi-v2-3-b82ff9c860ba@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261025-ddr-multi-v2-3-b82ff9c860ba@gmail.com>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/25/26 8:30 PM, Massimo Pegorer wrote:
> Slightly optimize SDRAM driver debugging code to reduce required space
> in the case of PX30 SoC TPL, allowing further code to be included such
> as multiple SDRAM types support.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   drivers/ram/rockchip/sdram_common.c | 49 ++++++++++++++-----------------------
>   1 file changed, 19 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/sdram_common.c
> index b7a8fce607c..b46de5d9044 100644
> --- a/drivers/ram/rockchip/sdram_common.c
> +++ b/drivers/ram/rockchip/sdram_common.c
> @@ -11,39 +11,34 @@
>   #include <asm/arch-rockchip/sdram_common.h>
>   
>   #ifdef CONFIG_RAM_ROCKCHIP_DEBUG
> -void sdram_print_dram_type(unsigned char dramtype)
> +static const char *sdram_get_dram_type_string(unsigned char dramtype)
>   {
>   	switch (dramtype) {
> -	case DDR3:
> -		printascii("DDR3");
> -		break;
> -	case DDR4:
> -		printascii("DDR4");
> -		break;
> -	case LPDDR2:
> -		printascii("LPDDR2");
> -		break;
> -	case LPDDR3:
> -		printascii("LPDDR3");
> -		break;
> -	case LPDDR4:
> -		printascii("LPDDR4");
> -		break;
> -	default:
> -		printascii("Unknown Device");
> -		break;
> +	case DDR3:	return "DDR3";
> +	case DDR4:	return "DDR4";
> +	case LPDDR2:	return "LPDDR2";
> +	case LPDDR3:	return "LPDDR3";
> +	case LPDDR4:	return "LPDDR4";
> +	default:	return "Unknown Device";
>   	}
>   }
>   
> +void sdram_print_dram_type(unsigned char dramtype)
> +{
> +	printascii(sdram_get_dram_type_string(dramtype));
> +}
> +

issue: make the above a separate patch

It makes it easier to see individual changes and the impact each change 
has on the final size.

>   void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
>   			  struct sdram_base_params *base, u32 split)
>   {
> -	u64 cap;
> -	u32 bg;
> +	u64 cap = sdram_get_cs_cap(cap_info, 3, base->dramtype);
>   
> -	bg = (cap_info->dbw == 0) ? 2 : 1;

issue: make the removal of the bg variable its own patch

Same reasons as above.

> +	if (cap_info->row_3_4)
> +		cap = cap * 3 / 4;
> +	else if (split)
> +		cap = cap / 2 + (split << 24) / 2;
>   
> -	sdram_print_dram_type(base->dramtype);
> +	printascii(sdram_get_dram_type_string(base->dramtype));

question: why this oneline change here?

Isn't that exactly what sdram_print_dram_type() is doing? You can always 
forcefully inline it, even though I'm not sure it's necessary

>   
>   	printascii(", ");
>   	printdec(base->ddr_freq);
> @@ -57,7 +52,7 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
>   	printdec(0x1 << cap_info->bk);
>   	if (base->dramtype == DDR4) {
>   		printascii(" BG=");
> -		printdec(1 << bg);
> +		printdec(1 << ((cap_info->dbw == 0) ? 2 : 1));
>   	}
>   	printascii(" CS0 Row=");
>   	printdec(cap_info->cs0_row);
> @@ -80,12 +75,6 @@ void sdram_print_ddr_info(struct sdram_cap_info *cap_info,
>   	printascii(" Die BW=");
>   	printdec(8 << cap_info->dbw);
>   
> -	cap = sdram_get_cs_cap(cap_info, 3, base->dramtype);
> -	if (cap_info->row_3_4)
> -		cap = cap * 3 / 4;
> -	else if (split)
> -		cap = cap / 2 + (split << 24) / 2;
> -

question: does the move of those 5 lines at the beginning of the 
function actually help with anything?

thought: I'm thinking there are additional ways to make functions in 
this file smaller

There's a bunch of checks scattered all over the file on dram_type. 
Considering we know what we want to support via the 
CONFIG_RAM_ROCKCHIP_* symbols, I'm thinking we could have a bunch of 
#ifdef/IS_ENABLED in there and make the functions smaller. It needs to 
be done carefully though. Maybe in a future commit, not necessarily for 
you to do.

todo: split this into its own series, we don't need to have it depend on 
the PX30 DDR auto-detect thing. We can merge improvements and bug fixes 
separately from new features. The next patch could be part of that 
series, but I'll only start reviewing it now :)

Cheers,
Quentin

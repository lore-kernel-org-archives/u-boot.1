Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A15C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 12:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99E28860A;
	Tue, 11 Jun 2024 14:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U9FFB5KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3A888665; Tue, 11 Jun 2024 14:26:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15E7882EF
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 14:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718108763; x=1718713563; i=xypron.glpk@gmx.de;
 bh=yd2BSGoCIKELsGDyrk0weDPOBMY8Ihb+CqtUdUjsL+Y=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=U9FFB5KUZa8gEsQwKy4Y/ZN1XSnZpDtPXqWbGR8s4LKt+f4u4+LvJfCIRzRmhgRV
 AZhBPM9ZuJQtHtFON55EXZc5W/ns5/HGPwEkmA4TNrn1NYeyHQCF8D3JSby3piD4m
 nv0+9D8nzkgxK/kDrF5shn0q72lKKZo2N5p0nzrZZrAArIAZuAsoLiqoFx3FGgpJV
 ACNME7gsgH/PPd+3kxJsbuu1kPQdOknsU5BSeHDG4EY4UY9rJQgGh0G0nKUSa/xXI
 fDBCceTY4pBBq+b8lEpQkuSH7Svpk8glg5MLNLQlHX/XEXe8V8Ek7P4fEK/4nGv7C
 7ZLXi6TI6fgF+miltg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1sJVfm0JWD-009fuS; Tue, 11
 Jun 2024 14:26:03 +0200
Message-ID: <b723aa8e-1d29-4904-953d-160caf097136@gmx.de>
Date: Tue, 11 Jun 2024 14:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] lib: fdtdec: Handle multiple memory nodes
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-1-1407e0b69678@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240522-loongarch-v1-1-1407e0b69678@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LA4wYkWYp3m+5PbeqGEjP4AeO4XWtyytU6Ab2e4AaylqyTeNby4
 jy7KhGwFPPs2t7lrlocpcbhVML2ZWMSP7kmUNd+pzwwaKPpUDPKzEzqAdqNC0k7X6MaIa94
 Zm9Y+ejo1kYjfW1mV6NArmjFXXn6r7MdX9E0g+xQSn/ts//WEDiguZqXYcGXBHzkQluepb/
 5nwcV8FKQ5elBmW5RL10Q==
UI-OutboundReport: notjunk:1;M01:P0:AEqpE80EItM=;zrYUo0GafEceqLjLTWa4/CgXH4R
 sXFOehvrluDTRQlFn+EjlDyfBJdCd/SmTvvQuexdT9C4zrEh+kKzXrAnR0l9KLLoF3JBpV6cs
 DVideUehduVQP7C9W3hnxrvVAsQcKbwKRaXBTHDcpwQYflxtekKiXTEInPhmtPl1XxcOVoXLK
 zeNNXxoky9rdWS7surndUVpzRAbX0XEg3gTgBt/al9AQMsL2cBOf03ul3s6HWb/3TPGqMaPWE
 VUUiK1u6FQhjZt/nLWb7ubYK0YJYc2Rom8CPY9IpV8N6IQPXlVE68ID0HoHQp2YhrKRLxdE+E
 h2ApfcZ2HcKvzaTZoYqDhrvheOnZ3k++AyaBTJcDG6jIbvOMQBb/9owpv3FJij1n0tmsCWP1B
 GxX35TNzJE0fz687ULKydVTOTkulZauGKx/ZHYOTj9oMlofcDQvtfLzaHcRvrqnrI/lZPcC3V
 dmowHb7yyHfGpsFRWEFIJbnQH0ZHIpcipENsTMbniIwN5y+tQsV9s+SxlWk3HTABT1R1mssJq
 hAU1C8Fk315bEuU1kMbAscx/SPb//zAQizFGG9U5mA2utwuq3FgdArHGsHHY+FD+dPM1zbfEX
 g41kiNbHU7n2Wh3PgGd4y2LNYXmOTyls980jrF/JyztiM193hKCFogYJ1/2PV+apCZg5eN+TF
 6uvqwO/NZiGopbCaoe3Byq9/tkwYNHDVHk/dqUyW1ekX2w1271U2WAvvPLm0JjtqF3EbmIDLL
 r/7fDzjiFfajQ9NhvUjPDuzz4c+3PtiyUAAXDHSW3EtgUtO/acdELU4hlW6JCqenC3RnC//OV
 ivR2pBgVgwbxhtJu53UzQmXktyo3rzYn8nrWLnsb8vt3A=
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

On 22.05.24 17:34, Jiaxun Yang wrote:
> Current code only tries to fetch the first memory node found in
> fdt tree and determine memory banks from multiple reg properties.
>
> Linux do allow multiple memory nodes in devicetree, rework

%/do allow/allows/

It is not Linux that allows it but

Devicetree Specification, Release v0.4
https://github.com/devicetree-org/devicetree-specification/releases/downlo=
ad/v0.4/devicetree-specification-v0.4.pdf

> fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
> to iterate over all memory nodes.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   lib/fdtdec.c | 137 ++++++++++++++++++++++++++++++++++++---------------=
--------
>   1 file changed, 83 insertions(+), 54 deletions(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b2c59ab3818b..403b363043d6 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1075,90 +1075,119 @@ ofnode get_next_memory_node(ofnode mem)
>   	return mem;
>   }
>
> +static void sort_memory_banks(int num)
> +{
> +	int i, j;
> +	phys_addr_t tmp_start;
> +	phys_size_t tmp_size;
> +	struct bd_info *bd =3D gd->bd;
> +
> +	for (i =3D 0; i < num - 1; i++) {
> +		for (j =3D i + 1; j < num; j++) {
> +			if (bd->bi_dram[i].start > bd->bi_dram[j].start) {
> +				tmp_start =3D bd->bi_dram[i].start;
> +				tmp_size =3D bd->bi_dram[i].size;
> +				bd->bi_dram[i].start =3D bd->bi_dram[j].start;
> +				bd->bi_dram[i].size =3D bd->bi_dram[j].size;
> +				bd->bi_dram[j].start =3D tmp_start;
> +				bd->bi_dram[j].size =3D tmp_size;
> +			}
> +		}
> +	}

Please, use qsort() instead.

> +}
> +
>   int fdtdec_setup_memory_banksize(void)
>   {
> -	int bank, ret, reg =3D 0;
> -	struct resource res;
> +	int bank =3D 0;
>   	ofnode mem =3D ofnode_null();
>
> -	mem =3D get_next_memory_node(mem);
> -	if (!ofnode_valid(mem)) {
> -		debug("%s: Missing /memory node\n", __func__);
> -		return -EINVAL;
> -	}
> +	while (true) {
> +		struct resource res;
> +		int reg =3D 0;
>
> -	for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		ret =3D ofnode_read_resource(mem, reg++, &res);
> -		if (ret < 0) {
> -			reg =3D 0;
> -			mem =3D get_next_memory_node(mem);
> -			if (!ofnode_valid(mem))
> -				break;
> +		mem =3D get_next_memory_node(mem);
> +		if (!ofnode_valid(mem))
> +			break;
>
> -			ret =3D ofnode_read_resource(mem, reg++, &res);
> +		while (true) {
> +			int ret =3D ofnode_read_resource(mem, reg, &res);

Please, leave a blank line after declarations.

>   			if (ret < 0)
>   				break;
> -		}
>
> -		if (ret !=3D 0)
> -			return -EINVAL;
> +			if (bank >=3D CONFIG_VAL(NR_DRAM_BANKS))
> +				goto too_may_memory_banks;
>
> -		gd->bd->bi_dram[bank].start =3D (phys_addr_t)res.start;

The conversion is superfluous.

> -		gd->bd->bi_dram[bank].size =3D
> -			(phys_size_t)(res.end - res.start + 1);
> +			gd->bd->bi_dram[bank].start =3D (phys_addr_t)res.start;
> +			gd->bd->bi_dram[bank].size =3D
> +				(phys_size_t)(res.end - res.start + 1);
>
> -		debug("%s: DRAM Bank #%d: start =3D 0x%llx, size =3D 0x%llx\n",
> -		      __func__, bank,
> -		      (unsigned long long)gd->bd->bi_dram[bank].start,
> -		      (unsigned long long)gd->bd->bi_dram[bank].size);
> +			log_debug("%s: DRAM Bank #%d %s.%d: start =3D 0x%llx, size =3D 0x%ll=
x\n",
> +				  __func__, bank, ofnode_get_name(mem), reg,
> +				 (unsigned long long)gd->bd->bi_dram[bank].start,
> +				 (unsigned long long)gd->bd->bi_dram[bank].size);
> +			reg++;
> +			bank++;
> +		}
>   	}
>
> +	if (!bank) {
> +		log_warning("%s: Missing /memory node\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	sort_memory_banks(bank);
> +
>   	return 0;
> +
> +too_may_memory_banks:
> +	log_warning("%s: Too many memory banks\n", __func__);
> +	return -EINVAL;
>   }
>
>   int fdtdec_setup_mem_size_base_lowest(void)
>   {
> -	int bank, ret, reg =3D 0;
> -	struct resource res;
> -	unsigned long base;
> -	phys_size_t size;
> +	int bank =3D 0;
>   	ofnode mem =3D ofnode_null();
> +	__maybe_unused const char *final_name;
> +	__maybe_unused int final_reg;

'__maybe_unused' is superfluous.

>
>   	gd->ram_base =3D (unsigned long)~0;

gd->ram_base =3D ULONG_MAX;

>
> -	mem =3D get_next_memory_node(mem);
> -	if (!ofnode_valid(mem)) {
> -		debug("%s: Missing /memory node\n", __func__);
> -		return -EINVAL;
> -	}
> +	while (true) {
> +		struct resource res;
> +		phys_size_t base, size;
> +		int reg =3D 0;
>
> -	for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		ret =3D ofnode_read_resource(mem, reg++, &res);
> -		if (ret < 0) {
> -			reg =3D 0;
> -			mem =3D get_next_memory_node(mem);
> -			if (!ofnode_valid(mem))
> -				break;
> +		mem =3D get_next_memory_node(mem);
> +		if (!ofnode_valid(mem))
> +			break;
>
> -			ret =3D ofnode_read_resource(mem, reg++, &res);
> +		while (true) {
> +			int ret =3D ofnode_read_resource(mem, reg, &res);
>   			if (ret < 0)
>   				break;
> +			base =3D res.start;
> +			size =3D res.end - res.start + 1;
> +			if (gd->ram_base > base && size) {
> +				gd->ram_base =3D base;
> +				gd->ram_size =3D size;
> +				final_name =3D ofnode_get_name(mem);
> +				final_reg =3D reg;
> +			}
> +			reg++;
> +			bank++;
>   		}
> +	}
>
> -		if (ret !=3D 0)
> -			return -EINVAL;
> -
> -		base =3D (unsigned long)res.start;
> -		size =3D (phys_size_t)(res.end - res.start + 1);
> -
> -		if (gd->ram_base > base && size) {
> -			gd->ram_base =3D base;
> -			gd->ram_size =3D size;
> -			debug("%s: Initial DRAM base %lx size %lx\n",
> -			      __func__, base, (unsigned long)size);
> -		}
> +	if (!bank) {
> +		log_warning("%s: Missing /memory node\n", __func__);
> +		return -EINVAL;
>   	}
>
> +	log_debug("%s: Initial DRAM %s.%d: base %lx size %lx\n",
> +		  __func__, final_name, final_reg,
> +		  (ulong)gd->ram_base, (ulong)gd->ram_size);

ram_base is already defined as unsigned long.

include/asm-generic/global_data.h:154:
   unsigned long ram_base;

Best regards

Heinrich

> +
>   	return 0;
>   }
>
>


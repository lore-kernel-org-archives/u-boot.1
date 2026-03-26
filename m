Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EAB10A3D96
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 15:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BC2681E18;
	Thu, 26 Mar 2026 16:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mOe6oVsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C6683CD3; Thu, 26 Mar 2026 16:09:06 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9813580517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso13504465e9.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774537738; x=1775142538; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9p9rJDpDSYtxi+4RtJYQwc0QbRwtDKj+gYeaGbYPetU=;
 b=mOe6oVslXsSPQzPbl+Phc2J7xlW3sL1l5gBUf5YaCJkVu6v/fm57NRfUBu5hoShGSJ
 7XkIGuSiFpj9lTeOqJgUxjoQ8cVDD4eGYcRl9Oatj+6KSR/vSYcCMq6ennq7XfNGGmdM
 vXPJvjeBoCxQdMsVI35aPU4SxZvGuMTlQSnDjbRwrX7yRbzXjm5pB70a2aC+Kd9vOpJe
 54cyoZsm3sNJoPDfrvGNcwFhNUUfqtt+8Y2IGPiynGZKbAISb8+uq/YFELEgrSPDoqdN
 08amyjjaGPHvsHnkG6u74V7eE26OxjWZrRpzoxJ34DlSL2+owa9J8D6r7Ynmrc2QmGMx
 GiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774537738; x=1775142538;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9p9rJDpDSYtxi+4RtJYQwc0QbRwtDKj+gYeaGbYPetU=;
 b=Kn4MsIurnT48yvmccZvlDJ5iBxOe2CuvttuJtm8V2qikV0tdbswqHydbWxNWGvyoik
 MT7q7pdW705JUjkydKflfEjlYDgnWfQj3YSs41+j0WEpa/NGbEPfo1LxXLAsPbwGJUgh
 gIXltVNwyOomzhOqfKN72kVYaP0oYb4nQ4LDx43ydu81HORvoA3GOEyh7JVdbreikJkB
 EsqEOzKUJe1TxjVHigsauwik8bhf3jTFiu2vyzNL+h0MDpJbcKnx4C6hAQqvwGqK+KIN
 kxZC6hTbD4vvksxp1TmEXkxkqejD6yR5PxjOe6KNRbomrz9lfZHlgknDvFebVLW25tLq
 nSgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAY1XIhGz/b1mvpc5wQ7/7Jdd670lR1jRh7R8qWIHjGYlbK69lJpOPmeJBj2egpvzByc6YZPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxcmeYa5AZjdps+UAKtc3iGeakW5mwYq7mSMkvsNUVXYcyksx8Y
 JYBkc5erp+sliia/Uj7NAnuU2ljdJUwnXPG3ujhixTe34YcZyEtc6CbQEfFIvdGAtf4=
X-Gm-Gg: ATEYQzz2CyNmzUZeZQc5OV0xux+T7rkhRj/P2J82bwiC0Pl7G6AG0UDT9L5DYwOXRW0
 E6x3v+KM9l6hf6kBvcsWMXfNxtjMi0Abp6qBAZedjXNESKl+w4Gcvw5jFeKBUZp1AB6HkhX127L
 NdVMuk9UyPFvmH42L5sk/ijt3jUYeRtOrXRD7lXo0RnGiI8nyi22zxfHA3xTqzwLu5zRfybcUn7
 fluxxpyYeSztcfpd3SbdgmXWZVJNVuoGndb1uOUpu1cK8wykeXSj66WQyH61ml7ZZNb3ei0PTza
 z4CVSNW9Ame1WgyFy5QZBoBTGJzLCUET9kBxkNkQJgRtduHGyMR8hbrZrmUn289vzhKVYZo5zcb
 r65DCvdvO1fYi/AebrVgey2DSZ76pEDt3stiapXD6ZRBjXRiUhCL+UAsgGkgoxOZsK3I51UrXoU
 4aSR0NUzP49wDbFsY0F1tnzooIMGPCxJsP8Nw6KCCptIyW2+0GqwTY5kVRSqz/nKaG3NVFlpGd+
 g==
X-Received: by 2002:a05:600c:4685:b0:486:5f71:5829 with SMTP id
 5b1f17b1804b1-48715fc3870mr125719795e9.5.1774537737747; 
 Thu, 26 Mar 2026 08:08:57 -0700 (PDT)
Received: from [192.168.1.36] (p5b29eb0d.dip0.t-ipconnect.de. [91.41.235.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722fa8dc6sm64775835e9.1.2026.03.26.08.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 08:08:57 -0700 (PDT)
Message-ID: <61e458bd-3b1a-4b7b-bb03-797c7ac8dc27@linaro.org>
Date: Thu, 26 Mar 2026 16:08:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 1/3] fdtdec: Deduplicate iterator function
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260325031743.371728-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 25/03/2026 04:17, Marek Vasut wrote:
> Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
> implement the exact same iterator over all memory banks, the only difference
> is the body that is executed for each bank. Deduplicate the functionality
> into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
> function pointer to a function which implements the body as a parameter.
> No functional change.

This is a nice optimisation! It will be good to de-dup some thing in
mach-snapdragon too with this.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Kind regards,>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  lib/fdtdec.c | 77 ++++++++++++++++++++--------------------------------
>  1 file changed, 30 insertions(+), 47 deletions(-)
> 
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c38738b48c7..d820f75b031 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1092,7 +1092,7 @@ ofnode get_next_memory_node(ofnode mem)
>  	return mem;
>  }
>  
> -int fdtdec_setup_memory_banksize(void)
> +static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, int bank))
>  {
>  	int bank, ret, reg = 0;
>  	struct resource res;
> @@ -1120,63 +1120,46 @@ int fdtdec_setup_memory_banksize(void)
>  		if (ret != 0)
>  			return -EINVAL;
>  
> -		gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
> -		gd->bd->bi_dram[bank].size =
> -			(phys_size_t)(res.end - res.start + 1);
> -
> -		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
> -		      __func__, bank,
> -		      (unsigned long long)gd->bd->bi_dram[bank].start,
> -		      (unsigned long long)gd->bd->bi_dram[bank].size);
> +		bankfn(&res, bank);
>  	}
>  
>  	return 0;
>  }
>  
> -int fdtdec_setup_mem_size_base_lowest(void)
> +static void fdtdec_setup_memory_banksize_bankfn(struct resource *res, int bank)
>  {
> -	int bank, ret, reg = 0;
> -	struct resource res;
> -	unsigned long base;
> -	phys_size_t size;
> -	ofnode mem = ofnode_null();
> +	gd->bd->bi_dram[bank].start = (phys_addr_t)res->start;
> +	gd->bd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
>  
> -	gd->ram_base = (unsigned long)~0;
> -
> -	mem = get_next_memory_node(mem);
> -	if (!ofnode_valid(mem)) {
> -		debug("%s: Missing /memory node\n", __func__);
> -		return -EINVAL;
> -	}
> -
> -	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		ret = ofnode_read_resource(mem, reg++, &res);
> -		if (ret < 0) {
> -			reg = 0;
> -			mem = get_next_memory_node(mem);
> -			if (!ofnode_valid(mem))
> -				break;
> -
> -			ret = ofnode_read_resource(mem, reg++, &res);
> -			if (ret < 0)
> -				break;
> -		}
> -
> -		if (ret != 0)
> -			return -EINVAL;
> +	debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
> +	      __func__, bank,
> +	      (unsigned long long)gd->bd->bi_dram[bank].start,
> +	      (unsigned long long)gd->bd->bi_dram[bank].size);
> +}
>  
> -		base = (unsigned long)res.start;
> -		size = (phys_size_t)(res.end - res.start + 1);
> +int fdtdec_setup_memory_banksize(void)
> +{
> +	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_memory_banksize_bankfn);
> +}
>  
> -		if (gd->ram_base > base && size) {
> -			gd->ram_base = base;
> -			gd->ram_size = size;
> -			debug("%s: Initial DRAM base %lx size %lx\n",
> -			      __func__, base, (unsigned long)size);
> -		}
> +static void fdtdec_setup_mem_size_base_lowest_bankfn(struct resource *res, int bank)
> +{
> +	unsigned long base = (unsigned long)res->start;
> +	phys_size_t size = (phys_size_t)(res->end - res->start + 1);
> +
> +	if (gd->ram_base > base && size) {
> +		gd->ram_base = base;
> +		gd->ram_size = size;
> +		debug("%s: Initial DRAM base %lx size %lx\n",
> +		      __func__, base, (unsigned long)size);
>  	}
> +}
>  
> -	return 0;
> +int fdtdec_setup_mem_size_base_lowest(void)
> +{
> +	gd->ram_base = (unsigned long)~0;
> +
> +	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
>  }
>  
>  static int uncompress_blob(const void *src, ulong sz_src, void **dstp)

-- 
// Casey (she/her)


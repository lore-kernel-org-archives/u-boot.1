Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF3CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 16:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8235683542;
	Tue, 12 Aug 2025 18:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObLN4XNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08058835A2; Tue, 12 Aug 2025 18:41:33 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0161E83321
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-459ebb6bbdfso35691525e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755016890; x=1755621690; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Du3RwyKgM4fkl7JSL3E/ET21BvRzHFgG4BLRzB/qPbU=;
 b=ObLN4XNyuRZoVuJDlwfRWac77iJjcpUG7K4RHCROLfJuQ+KTs20FQO1FMpeIHSzD11
 WL44i9GS8+aCqWgaQU31km6DCiAQUNY/n2Hr8pSCZc2NH7PuPk+IBlBA9sQZ+NEDdFYC
 qvW8BbXfDbljBRPlJN/3ScsM5L+8Nrk8bGmlfqDYGoYv94vCHGftOO19E2gc9uXOwzkr
 N7Sz66d2A0PJLgX+v0jTqNYzLq1I3udwe5wt1WTlZS+WgYHVmZ+FHz9OF+jjoMXAAtWz
 DwU8TRmzSIMQJBoL7QOz91xGqZe5GLUYkWYnT7lht5cTA83O6aQ+Y0y+64MkNlvkV9m6
 /x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755016890; x=1755621690;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Du3RwyKgM4fkl7JSL3E/ET21BvRzHFgG4BLRzB/qPbU=;
 b=H6XS1kUsjFhl/Epb/6X36vkbACXE6x9g401ISBy+qgowgb9QIHZZ/YVdZDItM/5VkQ
 A5Zwef9a9k2y12oUBljAYn7xNupr1JvP1+/WXiTT7jaOTiEpUzpy99ch4oWt3rClN3Xt
 BnaQKwc7wIY4PHqzBgs3Dkg/uhlfArVv8VcOKZLZ1sKxnrfKO/n2G2r8tp1kOFafJUk5
 6zgTYAuXlscaG7TB1fueDjvZMo/qh7IDVomnrNU6gTI9fqDa2c5rHBsjqT13nGP183Of
 gGFKr5Xg3CXWXAe0byGb+3WX9Wrlg5/N9IZW/9ZQZPKSVHTHXpaXAtKTYUeydUQq5Aid
 +fSw==
X-Gm-Message-State: AOJu0Yz+3KQNQDWHlxJzdu+xEuIahkp9wXI4CUePCBwABX/OXjttDLq4
 6fvoL5Ci/wUGJ5y3SrMIfCYmWLdihwhz6S1Ssn6Vo3vREuxIvwpLSOr5
X-Gm-Gg: ASbGncsSaI4YXjnsb96Hd8ii6KAe4phgyAD6qAWr1dZQlh1I3PB2lGtkfl7YcWNgotc
 ZWswR5immX1F5qKrICGTg4kQO96x22a4f7SRAvcZBOXp7krmPE9UVvZiaZN4TN/f9UjxWAk/weg
 CqxbZf2c2oe4Ujp0BV2oqNtjz1JybraSEBY7umQPRWjaGCv1e9RFc2wMHQfVf3lhc0jkuBN5ICH
 eK7SVmFvxYvB+icV/nZViSd7RJ8RRSI2WG7WlwVLmJ5JQXVb4rB16+7CC+TwU0nZduLKscJ+gSn
 3YaxrwzBDTBLSwAkw5nXBjQ/r1TOq5OJ8b1ZhU1fMfsTyrNQjrWHD6bElgPcmmefel1s1ZbhpD6
 vgtLPkdJ0Vi48b3KN4+lflL7ZvdSp4qSFZnI0pKbDRX77rWunYeUNAOe+NkQygzy/bo7xDtMC
X-Google-Smtp-Source: AGHT+IHzFq/tGOoTJEQD4wgm1YOVnRpf3/7Jscb+hB4ptBKGutqLZicvO4Qhb+0aW6ZoeE96O8d9sA==
X-Received: by 2002:a05:600c:3542:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45a15b5c8d3mr5347335e9.30.1755016890187; 
 Tue, 12 Aug 2025 09:41:30 -0700 (PDT)
Received: from Ansuel-XPS. (host-80-181-255-224.retail.telecomitalia.it.
 [80.181.255.224]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e583f9fcsm297358845e9.4.2025.08.12.09.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 09:41:29 -0700 (PDT)
Message-ID: <689b6eb9.050a0220.d7261.4aab@mx.google.com>
X-Google-Original-Message-ID: <aJtutzot-CxTJRgS@Ansuel-XPS.>
Date: Tue, 12 Aug 2025 18:41:27 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: u-boot@lists.denx.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 marex@denx.de, semen.protsenko@linaro.org,
 miquel.raynal@bootlin.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, sjg@chromium.org, trini@konsulko.com,
 seanga2@gmail.com, lukma@denx.de
Subject: Re: [PATCH 1/1] clk: introduce of_clk_detect_critical helper
References: <20250812162946.892728-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812162946.892728-1-fido_max@inbox.ru>
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

On Tue, Aug 12, 2025 at 07:29:46PM +0300, Maxim Kochetkov wrote:
> This helper find clock-critiacl property in dts and assign

clock-critiacl -> typo

> CLK_IS_CRITICAL flag to the clock.
> 
> Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
> ---
>  drivers/clk/clk-uclass.c | 17 +++++++++++++++++
>  drivers/core/of_access.c | 22 ++++++++++++++++++++++
>  include/clk.h            | 28 ++++++++++++++++++++++++++++
>  include/dm/of_access.h   | 17 +++++++++++++++++
>  4 files changed, 84 insertions(+)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 7262e89b512..4f35b90382f 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -835,6 +835,23 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id)
>  	return clk;
>  }
>  
> +int of_clk_detect_critical(struct device_node *np, int index,
> +			   unsigned long *flags)
> +{
> +	struct property *prop;
> +	const __be32 *cur;
> +	uint32_t idx;
> +
> +	if (!np || !flags)
> +		return -EINVAL;
> +
> +	of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
> +		if (index == idx)
> +			*flags |= CLK_IS_CRITICAL;
> +
> +	return 0;
> +}
> +
>  int clk_uclass_post_probe(struct udevice *dev)
>  {
>  	/*
> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
> index b11e36202c1..59dda3ae152 100644
> --- a/drivers/core/of_access.c
> +++ b/drivers/core/of_access.c
> @@ -666,6 +666,28 @@ int of_property_read_string_helper(const struct device_node *np,
>  	return i <= 0 ? -ENODATA : i;
>  }
>  
> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
> +			       u32 *pu)
> +{
> +	const void *curv = cur;
> +
> +	if (!prop)
> +		return NULL;
> +
> +	if (!cur) {
> +		curv = prop->value;
> +		goto out_val;
> +	}
> +
> +	curv += sizeof(*cur);
> +	if (curv >= prop->value + prop->length)
> +		return NULL;
> +
> +out_val:
> +	*pu = be32_to_cpup(curv);
> +	return curv;
> +}
> +
>  static int __of_root_parse_phandle_with_args(struct device_node *root,
>  					     const struct device_node *np,
>  					     const char *list_name,
> diff --git a/include/clk.h b/include/clk.h
> index f94135ff778..ea708f54fd5 100644
> --- a/include/clk.h
> +++ b/include/clk.h
> @@ -589,6 +589,27 @@ bool clk_dev_binded(struct clk *clk);
>   */
>  ulong clk_get_id(const struct clk *clk);
>  
> +/**
> + * of_clk_detect_critical() - set CLK_IS_CRITICAL flag from Device Tree
> + * @np: Device node pointer associated with clock provider
> + * @index: clock index
> + * @flags: pointer to top-level framework flags
> + *
> + * Detects if the clock-critical property exists and, if so, sets the
> + * corresponding CLK_IS_CRITICAL flag.
> + *
> + * Do not use this function. It exists only for legacy Device Tree
> + * bindings, such as the one-clock-per-node style that are outdated.
> + * Those bindings typically put all clock data into .dts and the Linux
> + * driver has no clock data, thus making it impossible to set this flag
> + * correctly from the driver. Only those drivers may call
> + * of_clk_detect_critical from their setup functions.
> + *
> + * Return: error code or zero on success
> + */
> +int of_clk_detect_critical(struct device_node *np, int index,
> +			   unsigned long *flags);
> +
>  #else /* CONFIG_IS_ENABLED(CLK) */
>  
>  static inline int clk_request(struct udevice *dev, struct clk *clk)
> @@ -665,6 +686,13 @@ static inline ulong clk_get_id(const struct clk *clk)
>  {
>  	return 0;
>  }
> +
> +int of_clk_detect_critical(struct device_node *np, int index,
> +			   unsigned long *flags)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_IS_ENABLED(CLK) */
>  
>  /**
> diff --git a/include/dm/of_access.h b/include/dm/of_access.h
> index 44143a5a391..dba725498f5 100644
> --- a/include/dm/of_access.h
> +++ b/include/dm/of_access.h
> @@ -405,6 +405,17 @@ int of_property_read_string_helper(const struct device_node *np,
>  				   const char *propname, const char **out_strs,
>  				   size_t sz, int index);
>  
> +/*
> + * struct property *prop;
> + * const __be32 *p;
> + * u32 u;
> + *
> + * of_property_for_each_u32(np, "propname", prop, p, u)
> + *         printk("U32 value: %x\n", u);
> + */
> +const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
> +			       u32 *pu);
> +
>  /**
>   * of_property_read_string_index() - Find and read a string from a multiple
>   * strings property.
> @@ -701,4 +712,10 @@ int of_remove_property(struct device_node *np, struct property *prop);
>   */
>  int of_remove_node(struct device_node *to_remove);
>  
> +#define of_property_for_each_u32(np, propname, prop, p, u)	\
> +	for (prop = of_find_property(np, propname, NULL),	\
> +		p = of_prop_next_u32(prop, NULL, &u);		\
> +		p;						\
> +		p = of_prop_next_u32(prop, p, &u))
> +
>  #endif
> -- 

I would split these of additional function to a separate commit also
where they come from? They are ported from Linux Kernel?

Also would be ideal to have some scenario where it's needed to declare a
clock in DT that is critical. Isn't that handled directly by the clock
driver internally?

-- 
	Ansuel

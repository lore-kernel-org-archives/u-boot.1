Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD3ED374A4
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 14:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 568AA88FF6;
	Thu, 17 Oct 2024 16:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="jHl6IoOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115368901D; Thu, 17 Oct 2024 16:56:16 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85B288B0C
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6565C14863DD; Thu, 17 Oct 2024 16:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1729176970; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=fKBFpe646Jzr3Lf11cxy/lBqCCbf9eZH+ihP4ljaK4c=;
 b=jHl6IoOpLjWP0AXF3+s4NhNoDe9bpK67BGs3khfnzxrjaK0akkNmm+bkFEpeKbX4fhWa1E
 wusODuVi9KstOKhGcvt9k+27UtKCq6ztZADvfZlgi8RESRloWk7D5fWBg9e9gGz0OT2nu2
 JqTzLa+LQAuIDf2v9SkJkY0GyJDR5me1D1ETSmkFpIvRaCiiRCqzQXyLtQFec4jRsnKjMa
 vinFLqfv3tpLEZeTUHYPdZkDO3+hDYge46skBTxa074VWTtSnwAkYRvh25KefOoGbwnqdh
 IlUbfuaBwGP/7msYCzjFuevMSAIkHUreUanSWPdtI4ewOCUBtqhSyeP6+OK4Ig==
Date: Thu, 17 Oct 2024 16:56:08 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH] dm: core: downgrade some dm_warn messages to log_debug()
Message-ID: <20241017-clambake-trekker-048460185316@thorsis.com>
Mail-Followup-To: Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Quentin,

Am Tue, Oct 15, 2024 at 04:32:14PM +0200 schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> People complained that enabling (SPL_)DM_WARN was now totally unusable
> due to the amount of messages printed on the console.
> 
> Let's downgrade the log level of some messages that are clearly not on
> the error path.
> 
> Note that there's one pr_debug in there, because it is followed by
> pr_cont so it made sense to reuse the same family of functions.
> 
> Reported-by: Alexander Dahl <ada@thorsis.com>
> Fixes: 6afdb1585112 ("dm: core: migrate debug() messages to use dm_warn")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Note that I am not entirely sure about the "not found" and "not large
> enough" changes there.
> 
> Another note, %#x isn't handled by tinyprintf so it just prints "x"
> instead of the value.
> 
> Finally, I don't know how one can enable LOG_DEBUG level without
> enabling DEBUG which enables assert() so I just tested that by removing
> the #define DEBUG in include/log.h :)
> ---
>  drivers/core/of_access.c | 36 ++++++++++++-------------
>  drivers/core/of_addr.c   | 26 +++++++++---------
>  drivers/core/of_extra.c  |  6 ++---
>  drivers/core/ofnode.c    | 68 ++++++++++++++++++++++++------------------------
>  4 files changed, 68 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
> index d05be273e7bbb68c3ad82ef4c1c036ae7f68ae61..77acd76626257b6da95a27d107052ff8800c2b67 100644
> --- a/drivers/core/of_access.c
> +++ b/drivers/core/of_access.c
> @@ -490,17 +490,17 @@ int of_read_u8(const struct device_node *np, const char *propname, u8 *outp)
>  {
>  	const u8 *val;
>  
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);

Printing __func__ when using log_* functions, is redundant, isn't it?
You can enabling printing the function name through the logging
framework, right?

>  	if (!np)
>  		return -EINVAL;
>  	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
>  	if (IS_ERR(val)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return PTR_ERR(val);

What about using log_msg_ret() instead in these cases?

Greets
Alex

>  	}
>  
>  	*outp = *val;
> -	dm_warn("%#x (%d)\n", *outp, *outp);
> +	log_debug("%#x (%d)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -509,17 +509,17 @@ int of_read_u16(const struct device_node *np, const char *propname, u16 *outp)
>  {
>  	const __be16 *val;
>  
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  	if (!np)
>  		return -EINVAL;
>  	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
>  	if (IS_ERR(val)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = be16_to_cpup(val);
> -	dm_warn("%#x (%d)\n", *outp, *outp);
> +	log_debug("%#x (%d)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -534,14 +534,14 @@ int of_read_u32_array(const struct device_node *np, const char *propname,
>  {
>  	const __be32 *val;
>  
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  	val = of_find_property_value_of_size(np, propname,
>  					     sz * sizeof(*out_values));
>  
>  	if (IS_ERR(val))
>  		return PTR_ERR(val);
>  
> -	dm_warn("size %zd\n", sz);
> +	log_debug("size %zd\n", sz);
>  	while (sz--)
>  		*out_values++ = be32_to_cpup(val++);
>  
> @@ -553,19 +553,19 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
>  {
>  	const __be32 *val;
>  
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  	if (!np)
>  		return -EINVAL;
>  
>  	val = of_find_property_value_of_size(np, propname,
>  					     sizeof(*outp) * (index + 1));
>  	if (IS_ERR(val)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = be32_to_cpup(val + index);
> -	dm_warn("%#x (%d)\n", *outp, *outp);
> +	log_debug("%#x (%d)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -575,20 +575,20 @@ int of_read_u64_index(const struct device_node *np, const char *propname,
>  {
>  	const __be64 *val;
>  
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  	if (!np)
>  		return -EINVAL;
>  
>  	val = of_find_property_value_of_size(np, propname,
>  					     sizeof(*outp) * (index + 1));
>  	if (IS_ERR(val)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = be64_to_cpup(val + index);
> -	dm_warn("%#llx (%lld)\n", (unsigned long long)*outp,
> -		(unsigned long long)*outp);
> +	log_debug("%#llx (%lld)\n", (unsigned long long)*outp,
> +		  (unsigned long long)*outp);
>  
>  	return 0;
>  }
> @@ -621,7 +621,7 @@ int of_property_match_string(const struct device_node *np, const char *propname,
>  		l = strnlen(p, end - p) + 1;
>  		if (p + l > end)
>  			return -EILSEQ;
> -		dm_warn("comparing %s with %s\n", string, p);
> +		log_debug("comparing %s with %s\n", string, p);
>  		if (strcmp(string, p) == 0)
>  			return i; /* Found it; return index */
>  	}
> @@ -826,8 +826,8 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
>  	strncpy(ap->stem, stem, stem_len);
>  	ap->stem[stem_len] = 0;
>  	list_add_tail(&ap->link, &aliases_lookup);
> -	dm_warn("adding DT alias:%s: stem=%s id=%i node=%s\n",
> -		ap->alias, ap->stem, ap->id, of_node_full_name(np));
> +	log_debug("adding DT alias:%s: stem=%s id=%i node=%s\n",
> +		  ap->alias, ap->stem, ap->id, of_node_full_name(np));
>  }
>  
>  int of_alias_scan(void)
> diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
> index 6c7b4c97d6778e632e6c318ca094bd94cc6248d4..250dd175b55c053fb80c7fa34ccaa66f3a4a8a1f 100644
> --- a/drivers/core/of_addr.c
> +++ b/drivers/core/of_addr.c
> @@ -27,7 +27,7 @@ static struct of_bus *of_match_bus(struct device_node *np);
>  #ifdef DEBUG
>  static void of_dump_addr(const char *s, const __be32 *addr, int na)
>  {
> -	dm_warn("%s", s);
> +	pr_debug("%s", s);
>  	while (na--)
>  		pr_cont(" %08x", be32_to_cpu(*(addr++)));
>  	pr_cont("\n");
> @@ -66,9 +66,9 @@ static u64 of_bus_default_map(__be32 *addr, const __be32 *range,
>  	s  = of_read_number(range + na + pna, ns);
>  	da = of_read_number(addr, na);
>  
> -	dm_warn("default map, cp=%llx, s=%llx, da=%llx\n",
> -		(unsigned long long)cp, (unsigned long long)s,
> -		(unsigned long long)da);
> +	log_debug("default map, cp=%llx, s=%llx, da=%llx\n",
> +		  (unsigned long long)cp, (unsigned long long)s,
> +		  (unsigned long long)da);
>  
>  	if (da < cp || da >= (cp + s))
>  		return OF_BAD_ADDR;
> @@ -200,11 +200,11 @@ static int of_translate_one(const struct device_node *parent,
>  	if (ranges == NULL || rlen == 0) {
>  		offset = of_read_number(addr, na);
>  		memset(addr, 0, pna * 4);
> -		dm_warn("empty ranges; 1:1 translation\n");
> +		log_debug("empty ranges; 1:1 translation\n");
>  		goto finish;
>  	}
>  
> -	dm_warn("walking ranges...\n");
> +	log_debug("walking ranges...\n");
>  
>  	/* Now walk through the ranges */
>  	rlen /= 4;
> @@ -222,7 +222,7 @@ static int of_translate_one(const struct device_node *parent,
>  
>   finish:
>  	of_dump_addr("parent translation for:", addr, pna);
> -	dm_warn("with offset: %llx\n", (unsigned long long)offset);
> +	log_debug("with offset: %llx\n", (unsigned long long)offset);
>  
>  	/* Translate it into parent bus space */
>  	return pbus->translate(addr, offset, pna);
> @@ -247,7 +247,7 @@ static u64 __of_translate_address(const struct device_node *dev,
>  	int na, ns, pna, pns;
>  	u64 result = OF_BAD_ADDR;
>  
> -	dm_warn("** translation for device %s **\n", of_node_full_name(dev));
> +	log_debug("** translation for device %s **\n", of_node_full_name(dev));
>  
>  	/* Increase refcount at current level */
>  	(void)of_node_get(dev);
> @@ -266,8 +266,8 @@ static u64 __of_translate_address(const struct device_node *dev,
>  	}
>  	memcpy(addr, in_addr, na * 4);
>  
> -	dm_warn("bus is %s (na=%d, ns=%d) on %s\n", bus->name, na, ns,
> -		of_node_full_name(parent));
> +	log_debug("bus is %s (na=%d, ns=%d) on %s\n", bus->name, na, ns,
> +		  of_node_full_name(parent));
>  	of_dump_addr("translating address:", addr, na);
>  
>  	/* Translate */
> @@ -279,7 +279,7 @@ static u64 __of_translate_address(const struct device_node *dev,
>  
>  		/* If root, we have finished */
>  		if (parent == NULL) {
> -			dm_warn("reached root node\n");
> +			log_debug("reached root node\n");
>  			result = of_read_number(addr, na);
>  			break;
>  		}
> @@ -293,8 +293,8 @@ static u64 __of_translate_address(const struct device_node *dev,
>  			break;
>  		}
>  
> -		dm_warn("parent bus is %s (na=%d, ns=%d) on %s\n", pbus->name,
> -			pna, pns, of_node_full_name(parent));
> +		log_debug("parent bus is %s (na=%d, ns=%d) on %s\n", pbus->name,
> +			  pna, pns, of_node_full_name(parent));
>  
>  		/* Apply bus translation */
>  		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
> diff --git a/drivers/core/of_extra.c b/drivers/core/of_extra.c
> index bfc1e3441b1d63e3ef72352863842c9e49647db5..f49187dfc1ec2491b525be35d8deac0bd70a6c4e 100644
> --- a/drivers/core/of_extra.c
> +++ b/drivers/core/of_extra.c
> @@ -58,7 +58,7 @@ int ofnode_decode_region(ofnode node, const char *prop_name, fdt_addr_t *basep,
>  	const fdt_addr_t *cell;
>  	int len;
>  
> -	dm_warn("%s: %s: %s\n", __func__, ofnode_get_name(node), prop_name);
> +	log_debug("%s: %s: %s\n", __func__, ofnode_get_name(node), prop_name);
>  	cell = ofnode_get_property(node, prop_name, &len);
>  	if (!cell || (len < sizeof(fdt_addr_t) * 2)) {
>  		dm_warn("cell=%p, len=%d\n", cell, len);
> @@ -67,8 +67,8 @@ int ofnode_decode_region(ofnode node, const char *prop_name, fdt_addr_t *basep,
>  
>  	*basep = fdt_addr_to_cpu(*cell);
>  	*sizep = fdt_size_to_cpu(cell[1]);
> -	dm_warn("%s: base=%08lx, size=%lx\n", __func__, (ulong)*basep,
> -		(ulong)*sizep);
> +	log_debug("%s: base=%08lx, size=%lx\n", __func__, (ulong)*basep,
> +		  (ulong)*sizep);
>  
>  	return 0;
>  }
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 48ae8ce830ec5a37675900e4f537e087fcac37b7..950895e72a9949fff44222fd039a82a9351de714 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -315,7 +315,7 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u8(ofnode_to_np(node), propname, outp);
> @@ -323,11 +323,11 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>  	cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
>  			   &len);
>  	if (!cell || len < sizeof(*cell)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return -EINVAL;
>  	}
>  	*outp = *cell;
> -	dm_warn("%#x (%u)\n", *outp, *outp);
> +	log_debug("%#x (%u)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -346,7 +346,7 @@ int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u16(ofnode_to_np(node), propname, outp);
> @@ -354,11 +354,11 @@ int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
>  	cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
>  			   &len);
>  	if (!cell || len < sizeof(*cell)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return -EINVAL;
>  	}
>  	*outp = be16_to_cpup(cell);
> -	dm_warn("%#x (%u)\n", *outp, *outp);
> +	log_debug("%#x (%u)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -391,7 +391,7 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u32_index(ofnode_to_np(node), propname, index,
> @@ -400,17 +400,17 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
>  	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
>  			   propname, &len);
>  	if (!cell) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return -EINVAL;
>  	}
>  
>  	if (len < (sizeof(int) * (index + 1))) {
> -		dm_warn("(not large enough)\n");
> +		log_debug("(not large enough)\n");
>  		return -EOVERFLOW;
>  	}
>  
>  	*outp = fdt32_to_cpu(cell[index]);
> -	dm_warn("%#x (%u)\n", *outp, *outp);
> +	log_debug("%#x (%u)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -430,17 +430,17 @@ int ofnode_read_u64_index(ofnode node, const char *propname, int index,
>  	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
>  			   propname, &len);
>  	if (!cell) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return -EINVAL;
>  	}
>  
>  	if (len < (sizeof(u64) * (index + 1))) {
> -		dm_warn("(not large enough)\n");
> +		log_debug("(not large enough)\n");
>  		return -EOVERFLOW;
>  	}
>  
>  	*outp = fdt64_to_cpu(cell[index]);
> -	dm_warn("%#llx (%llu)\n", *outp, *outp);
> +	log_debug("%#llx (%llu)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -468,7 +468,7 @@ int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u64(ofnode_to_np(node), propname, outp);
> @@ -476,12 +476,12 @@ int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
>  	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
>  			   propname, &len);
>  	if (!cell || len < sizeof(*cell)) {
> -		dm_warn("(not found)\n");
> +		log_debug("(not found)\n");
>  		return -EINVAL;
>  	}
>  	*outp = fdt64_to_cpu(cell[0]);
> -	dm_warn("%#llx (%llu)\n", (unsigned long long)*outp,
> -		(unsigned long long)*outp);
> +	log_debug("%#llx (%llu)\n", (unsigned long long)*outp,
> +		  (unsigned long long)*outp);
>  
>  	return 0;
>  }
> @@ -499,11 +499,11 @@ bool ofnode_read_bool(ofnode node, const char *propname)
>  	bool prop;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	prop = ofnode_has_property(node, propname);
>  
> -	dm_warn("%s\n", prop ? "true" : "false");
> +	log_debug("%s\n", prop ? "true" : "false");
>  
>  	return prop ? true : false;
>  }
> @@ -514,7 +514,7 @@ const void *ofnode_read_prop(ofnode node, const char *propname, int *sizep)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node)) {
>  		struct property *prop = of_find_property(
> @@ -529,7 +529,7 @@ const void *ofnode_read_prop(ofnode node, const char *propname, int *sizep)
>  				  propname, &len);
>  	}
>  	if (!val) {
> -		dm_warn("<not found>\n");
> +		log_debug("<not found>\n");
>  		if (sizep)
>  			*sizep = -FDT_ERR_NOTFOUND;
>  		return NULL;
> @@ -553,7 +553,7 @@ const char *ofnode_read_string(ofnode node, const char *propname)
>  		dm_warn("<invalid>\n");
>  		return NULL;
>  	}
> -	dm_warn("%s\n", str);
> +	log_debug("%s\n", str);
>  
>  	return str;
>  }
> @@ -573,7 +573,7 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
>  	ofnode subnode;
>  
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, subnode_name);
> +	log_debug("%s: %s: ", __func__, subnode_name);
>  
>  	if (ofnode_is_np(node)) {
>  		struct device_node *np = ofnode_to_np(node);
> @@ -588,8 +588,8 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
>  				ofnode_to_offset(node), subnode_name);
>  		subnode = noffset_to_ofnode(node, ooffset);
>  	}
> -	dm_warn("%s\n", ofnode_valid(subnode) ?
> -		ofnode_get_name(subnode) : "<none>");
> +	log_debug("%s\n", ofnode_valid(subnode) ?
> +		  ofnode_get_name(subnode) : "<none>");
>  
>  	return subnode;
>  }
> @@ -598,7 +598,7 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
>  			  u32 *out_values, size_t sz)
>  {
>  	assert(ofnode_valid(node));
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node)) {
>  		return of_read_u32_array(ofnode_to_np(node), propname,
> @@ -1032,7 +1032,7 @@ ofnode ofnode_get_aliases_node(const char *name)
>  	if (!prop)
>  		return ofnode_null();
>  
> -	dm_warn("%s: node_path: %s\n", __func__, prop);
> +	log_debug("%s: node_path: %s\n", __func__, prop);
>  
>  	return ofnode_path(prop);
>  }
> @@ -1301,7 +1301,7 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
>  	int len;
>  	int ret = -ENOENT;
>  
> -	dm_warn("%s: %s: ", __func__, propname);
> +	log_debug("%s: %s: ", __func__, propname);
>  
>  	/*
>  	 * If we follow the pci bus bindings strictly, we should check
> @@ -1318,10 +1318,10 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
>  		int i;
>  
>  		for (i = 0; i < num; i++) {
> -			dm_warn("pci address #%d: %08lx %08lx %08lx\n", i,
> -				(ulong)fdt32_to_cpu(cell[0]),
> -			      (ulong)fdt32_to_cpu(cell[1]),
> -			      (ulong)fdt32_to_cpu(cell[2]));
> +			log_debug("pci address #%d: %08lx %08lx %08lx\n", i,
> +				  (ulong)fdt32_to_cpu(cell[0]),
> +				  (ulong)fdt32_to_cpu(cell[1]),
> +				  (ulong)fdt32_to_cpu(cell[2]));
>  			if ((fdt32_to_cpu(*cell) & type) == type) {
>  				const unaligned_fdt64_t *ptr;
>  
> @@ -1348,7 +1348,7 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
>  	ret = -EINVAL;
>  
>  fail:
> -	dm_warn("(not found)\n");
> +	log_debug("(not found)\n");
>  	return ret;
>  }
>  
> @@ -1632,7 +1632,7 @@ int ofnode_write_string(ofnode node, const char *propname, const char *value)
>  {
>  	assert(ofnode_valid(node));
>  
> -	dm_warn("%s: %s = %s", __func__, propname, value);
> +	log_debug("%s: %s = %s", __func__, propname, value);
>  
>  	return ofnode_write_prop(node, propname, value, strlen(value) + 1,
>  				 false);
> 
> ---
> base-commit: d2061828a4c1b60b44cd2307b6a782ac2efbffbe
> change-id: 20241015-dm-debug-less-verbose-29d4aba76f5b
> 
> Best regards,
> -- 
> Quentin Schulz <quentin.schulz@cherry.de>
> 

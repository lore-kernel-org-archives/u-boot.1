Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB925CF319C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 08:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1724A88F01;
	Wed,  2 Oct 2024 10:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="dct6Yig4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC90188F35; Wed,  2 Oct 2024 10:37:40 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4E988DFB
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 10:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD1C11487ECC; Wed,  2 Oct 2024 10:37:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1727858256; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4aXezBpgcQk/R5MFM9dctih7PRajKWEDQwcImKumaiU=;
 b=dct6Yig4N4bZht/YrxL2lNiys77kUPao1D7AGY2Hu7vEGeI7ligvcGf3QmRUfyo10dk1ur
 AHCk8962IJtZUsdsaf6rU43ENLRgjxh0sGu4sBLZr6ohY6lbXgwpLIKXAfI6Mxq9THzwDF
 eHjqByTvW/h80IqScBd1QUlroMpabI+HsmX3YU2x6VlceBcuBTG9JcB0F+N11G4kbsyyZU
 HqjqPzImbKdSClHMaeQ1W4YGE8JesGDLDwaI0nzcwyqoSOKjgGw8fIsBurK4Rs/JT60W+L
 +WFmWFKR3N5Hdy6hIQc3ajPi1LSfFZGoQQYQ0NhTkYP0+w5l8q267M93r3Lumw==
Date: Wed, 2 Oct 2024 10:37:28 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
Message-ID: <20241002-caption-saline-d00d342af087@thorsis.com>
Mail-Followup-To: Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
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

sorry for being late to the party, but I just tested v2024.10-rc6 and
my console output looks like this now:

    ofnode_read_bool: bootph-all: true
    ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: false
    ofnode_read_bool: bootph-some-ram: false
    ofnode_read_bool: bootph-pre-ram: false
    ofnode_read_bool: bootph-pre-sram: false
    ofnode_read_bool: u-boot,dm-pre-reloc: false
    ofnode_read_bool: u-boot,dm-pre-proper: false
    ofnode_read_bool: u-boot,dm-spl: false
    ofnode_read_bool: u-boot,dm-tpl: false
    ofnode_read_bool: u-boot,dm-vpl: false
    ofnode_read_bool: bootph-all: false
    ofnode_read_bool: bootph-some-ram: false
    ofnode_read_bool: bootph-pre-ram: false
    ofnode_read_bool: bootph-pre-sram: false
    ofnode_read_bool: u-boot,dm-pre-reloc: false
    ofnode_read_bool: u-boot,dm-pre-proper: false
    ofnode_read_bool: u-boot,dm-spl: false
    ofnode_read_bool: u-boot,dm-tpl: false
    ofnode_read_bool: u-boot,dm-vpl: false
    ofnode_read_bool: bootph-all: true
    ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
    ofnode_read_u32_array: ranges: ofnode_read_bool: bootph-all: true
    ofnode_read_bool: bootph-all: true
    ofnode_read_bool: bootph-all: false
    …

This goes on for several screen pages, and clutters the usual output.
I first thought I messed up CONFIG_LOGLEVEL or CONFIG_LOG, but no.
All I had done was setting CONFIG_DM_WARN …

Am Tue, Jun 11, 2024 at 03:04:26PM +0200 schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Prior to that, seeing the debug() messages required to enable DM_DEBUG
> which defines DEBUG (and then _DEBUG) which in turn makes failing
> assert() calls reset U-Boot which isn't necessarily what is desired.
> 
> Instead, let's migrate to dm_warn which is using log_debug when unset or
> log_warn when set.
> 
> While at it, reword the DM_DEBUG symbol in Kconfig to explain what it
> now actually does.

CONFIG_DM_WARN currently reads like this:

    Enable this to see warnings related to driver model.

    Warnings may help with debugging, such as when expected devices do
    not bind correctly. If the option is disabled, dm_warn() is compiled
    out - it will do nothing when called.

Instead of just useful warnings, users get debug messages all over the
place now.  Is this actually intended behaviour?  Can this be fixed
before v2024.10 release please?

> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/device.c    |  2 +-
>  drivers/core/fdtaddr.c   |  7 +++--
>  drivers/core/lists.c     |  2 +-
>  drivers/core/of_access.c | 51 +++++++++++++++---------------
>  drivers/core/of_addr.c   | 41 ++++++++++++------------
>  drivers/core/of_extra.c  | 33 ++++++++++----------
>  drivers/core/ofnode.c    | 81 ++++++++++++++++++++++++------------------------
>  drivers/core/regmap.c    | 57 +++++++++++++++++-----------------
>  drivers/core/root.c      | 14 ++++-----
>  drivers/core/uclass.c    |  4 +--
>  10 files changed, 149 insertions(+), 143 deletions(-)
> 
> diff --git a/drivers/core/device.c b/drivers/core/device.c
> index 18e2bd02dd5..779f371b9d5 100644
> --- a/drivers/core/device.c
> +++ b/drivers/core/device.c
> @@ -58,7 +58,7 @@ static int device_bind_common(struct udevice *parent, const struct driver *drv,
>  
>  	ret = uclass_get(drv->id, &uc);
>  	if (ret) {
> -		debug("Missing uclass for driver %s\n", drv->name);
> +		dm_warn("Missing uclass for driver %s\n", drv->name);
>  		return ret;
>  	}
>  
> diff --git a/drivers/core/fdtaddr.c b/drivers/core/fdtaddr.c
> index 6be8ea0c0a9..9e59968df01 100644
> --- a/drivers/core/fdtaddr.c
> +++ b/drivers/core/fdtaddr.c
> @@ -15,6 +15,7 @@
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <dm/device-internal.h>
> +#include <dm/util.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -32,19 +33,19 @@ fdt_addr_t devfdt_get_addr_index(const struct udevice *dev, int index)
>  
>  		na = fdt_address_cells(gd->fdt_blob, parent);
>  		if (na < 1) {
> -			debug("bad #address-cells\n");
> +			dm_warn("bad #address-cells\n");

Okay, this is a warning.  A lot of the converted messages are.

>  			return FDT_ADDR_T_NONE;
>  		}
>  
>  		ns = fdt_size_cells(gd->fdt_blob, parent);
>  		if (ns < 0) {
> -			debug("bad #size-cells\n");
> +			dm_warn("bad #size-cells\n");
>  			return FDT_ADDR_T_NONE;
>  		}
>  
>  		reg = fdt_getprop(gd->fdt_blob, offset, "reg", &len);
>  		if (!reg || (len <= (index * sizeof(fdt32_t) * (na + ns)))) {
> -			debug("Req index out of range\n");
> +			dm_warn("Req index out of range\n");
>  			return FDT_ADDR_T_NONE;
>  		}
>  
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index 942fe4a4e67..bd0ab4f16c9 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -144,7 +144,7 @@ int device_bind_driver_to_node(struct udevice *parent, const char *drv_name,
>  
>  	drv = lists_driver_lookup_name(drv_name);
>  	if (!drv) {
> -		debug("Cannot find driver '%s'\n", drv_name);
> +		dm_warn("Cannot find driver '%s'\n", drv_name);
>  		return -ENOENT;
>  	}
>  	ret = device_bind_with_driver_data(parent, drv, dev_name, 0 /* data */,
> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
> index 41f2e09b9c2..d05be273e7b 100644
> --- a/drivers/core/of_access.c
> +++ b/drivers/core/of_access.c
> @@ -25,6 +25,7 @@
>  #include <linux/bug.h>
>  #include <linux/libfdt.h>
>  #include <dm/of_access.h>
> +#include <dm/util.h>
>  #include <linux/ctype.h>
>  #include <linux/err.h>
>  #include <linux/ioport.h>
> @@ -489,17 +490,17 @@ int of_read_u8(const struct device_node *np, const char *propname, u8 *outp)
>  {
>  	const u8 *val;
>  
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  	if (!np)
>  		return -EINVAL;
>  	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
>  	if (IS_ERR(val)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = *val;
> -	debug("%#x (%d)\n", *outp, *outp);
> +	dm_warn("%#x (%d)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -508,17 +509,17 @@ int of_read_u16(const struct device_node *np, const char *propname, u16 *outp)
>  {
>  	const __be16 *val;
>  
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);

This is no warning at all.  And there are tons of those changed by
this patch.  It ended up in master as 6afdb1585112 ("dm: core: migrate
debug() messages to use dm_warn") by the way.  Please review again and
assign reasonable log levels for all converted messages, otherwise
the destinction between DM_WARN and DM_DEBUG is useless?

Greets
Alex

>  	if (!np)
>  		return -EINVAL;
>  	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
>  	if (IS_ERR(val)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = be16_to_cpup(val);
> -	debug("%#x (%d)\n", *outp, *outp);
> +	dm_warn("%#x (%d)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -533,14 +534,14 @@ int of_read_u32_array(const struct device_node *np, const char *propname,
>  {
>  	const __be32 *val;
>  
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  	val = of_find_property_value_of_size(np, propname,
>  					     sz * sizeof(*out_values));
>  
>  	if (IS_ERR(val))
>  		return PTR_ERR(val);
>  
> -	debug("size %zd\n", sz);
> +	dm_warn("size %zd\n", sz);
>  	while (sz--)
>  		*out_values++ = be32_to_cpup(val++);
>  
> @@ -552,19 +553,19 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
>  {
>  	const __be32 *val;
>  
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  	if (!np)
>  		return -EINVAL;
>  
>  	val = of_find_property_value_of_size(np, propname,
>  					     sizeof(*outp) * (index + 1));
>  	if (IS_ERR(val)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = be32_to_cpup(val + index);
> -	debug("%#x (%d)\n", *outp, *outp);
> +	dm_warn("%#x (%d)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -574,20 +575,20 @@ int of_read_u64_index(const struct device_node *np, const char *propname,
>  {
>  	const __be64 *val;
>  
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  	if (!np)
>  		return -EINVAL;
>  
>  	val = of_find_property_value_of_size(np, propname,
>  					     sizeof(*outp) * (index + 1));
>  	if (IS_ERR(val)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return PTR_ERR(val);
>  	}
>  
>  	*outp = be64_to_cpup(val + index);
> -	debug("%#llx (%lld)\n", (unsigned long long)*outp,
> -	      (unsigned long long)*outp);
> +	dm_warn("%#llx (%lld)\n", (unsigned long long)*outp,
> +		(unsigned long long)*outp);
>  
>  	return 0;
>  }
> @@ -620,7 +621,7 @@ int of_property_match_string(const struct device_node *np, const char *propname,
>  		l = strnlen(p, end - p) + 1;
>  		if (p + l > end)
>  			return -EILSEQ;
> -		debug("comparing %s with %s\n", string, p);
> +		dm_warn("comparing %s with %s\n", string, p);
>  		if (strcmp(string, p) == 0)
>  			return i; /* Found it; return index */
>  	}
> @@ -707,17 +708,17 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
>  			if (cells_name || cur_index == index) {
>  				node = of_find_node_by_phandle(NULL, phandle);
>  				if (!node) {
> -					debug("%s: could not find phandle\n",
> -					      np->full_name);
> +					dm_warn("%s: could not find phandle\n",
> +						np->full_name);
>  					goto err;
>  				}
>  			}
>  
>  			if (cells_name) {
>  				if (of_read_u32(node, cells_name, &count)) {
> -					debug("%s: could not get %s for %s\n",
> -					      np->full_name, cells_name,
> -					      node->full_name);
> +					dm_warn("%s: could not get %s for %s\n",
> +						np->full_name, cells_name,
> +						node->full_name);
>  					goto err;
>  				}
>  			} else {
> @@ -729,8 +730,8 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
>  			 * remaining property data length
>  			 */
>  			if (list + count > list_end) {
> -				debug("%s: arguments longer than property\n",
> -				      np->full_name);
> +				dm_warn("%s: arguments longer than property\n",
> +					np->full_name);
>  				goto err;
>  			}
>  		}
> @@ -825,8 +826,8 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
>  	strncpy(ap->stem, stem, stem_len);
>  	ap->stem[stem_len] = 0;
>  	list_add_tail(&ap->link, &aliases_lookup);
> -	debug("adding DT alias:%s: stem=%s id=%i node=%s\n",
> -	      ap->alias, ap->stem, ap->id, of_node_full_name(np));
> +	dm_warn("adding DT alias:%s: stem=%s id=%i node=%s\n",
> +		ap->alias, ap->stem, ap->id, of_node_full_name(np));
>  }
>  
>  int of_alias_scan(void)
> diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
> index d7913ab3d2f..c893447a1b1 100644
> --- a/drivers/core/of_addr.c
> +++ b/drivers/core/of_addr.c
> @@ -11,6 +11,7 @@
>  #include <linux/libfdt.h>
>  #include <dm/of_access.h>
>  #include <dm/of_addr.h>
> +#include <dm/util.h>
>  #include <linux/err.h>
>  #include <linux/ioport.h>
>  #include <linux/printk.h>
> @@ -26,7 +27,7 @@ static struct of_bus *of_match_bus(struct device_node *np);
>  #ifdef DEBUG
>  static void of_dump_addr(const char *s, const __be32 *addr, int na)
>  {
> -	debug("%s", s);
> +	dm_warn("%s", s);
>  	while (na--)
>  		pr_cont(" %08x", be32_to_cpu(*(addr++)));
>  	pr_cont("\n");
> @@ -65,9 +66,9 @@ static u64 of_bus_default_map(__be32 *addr, const __be32 *range,
>  	s  = of_read_number(range + na + pna, ns);
>  	da = of_read_number(addr, na);
>  
> -	debug("default map, cp=%llx, s=%llx, da=%llx\n",
> -	      (unsigned long long)cp, (unsigned long long)s,
> -	      (unsigned long long)da);
> +	dm_warn("default map, cp=%llx, s=%llx, da=%llx\n",
> +		(unsigned long long)cp, (unsigned long long)s,
> +		(unsigned long long)da);
>  
>  	if (da < cp || da >= (cp + s))
>  		return OF_BAD_ADDR;
> @@ -193,17 +194,17 @@ static int of_translate_one(const struct device_node *parent,
>  	ranges = of_get_property(parent, rprop, &rlen);
>  	if (ranges == NULL && !of_empty_ranges_quirk(parent) &&
>  	    strcmp(rprop, "dma-ranges")) {
> -		debug("no ranges; cannot translate\n");
> +		dm_warn("no ranges; cannot translate\n");
>  		return 1;
>  	}
>  	if (ranges == NULL || rlen == 0) {
>  		offset = of_read_number(addr, na);
>  		memset(addr, 0, pna * 4);
> -		debug("empty ranges; 1:1 translation\n");
> +		dm_warn("empty ranges; 1:1 translation\n");
>  		goto finish;
>  	}
>  
> -	debug("walking ranges...\n");
> +	dm_warn("walking ranges...\n");
>  
>  	/* Now walk through the ranges */
>  	rlen /= 4;
> @@ -214,14 +215,14 @@ static int of_translate_one(const struct device_node *parent,
>  			break;
>  	}
>  	if (offset == OF_BAD_ADDR) {
> -		debug("not found !\n");
> +		dm_warn("not found !\n");
>  		return 1;
>  	}
>  	memcpy(addr, ranges + na, 4 * pna);
>  
>   finish:
>  	of_dump_addr("parent translation for:", addr, pna);
> -	debug("with offset: %llx\n", (unsigned long long)offset);
> +	dm_warn("with offset: %llx\n", (unsigned long long)offset);
>  
>  	/* Translate it into parent bus space */
>  	return pbus->translate(addr, offset, pna);
> @@ -246,7 +247,7 @@ static u64 __of_translate_address(const struct device_node *dev,
>  	int na, ns, pna, pns;
>  	u64 result = OF_BAD_ADDR;
>  
> -	debug("** translation for device %s **\n", of_node_full_name(dev));
> +	dm_warn("** translation for device %s **\n", of_node_full_name(dev));
>  
>  	/* Increase refcount at current level */
>  	(void)of_node_get(dev);
> @@ -260,13 +261,13 @@ static u64 __of_translate_address(const struct device_node *dev,
>  	/* Count address cells & copy address locally */
>  	bus->count_cells(dev, &na, &ns);
>  	if (!OF_CHECK_COUNTS(na, ns)) {
> -		debug("Bad cell count for %s\n", of_node_full_name(dev));
> +		dm_warn("Bad cell count for %s\n", of_node_full_name(dev));
>  		goto bail;
>  	}
>  	memcpy(addr, in_addr, na * 4);
>  
> -	debug("bus is %s (na=%d, ns=%d) on %s\n", bus->name, na, ns,
> -	      of_node_full_name(parent));
> +	dm_warn("bus is %s (na=%d, ns=%d) on %s\n", bus->name, na, ns,
> +		of_node_full_name(parent));
>  	of_dump_addr("translating address:", addr, na);
>  
>  	/* Translate */
> @@ -278,7 +279,7 @@ static u64 __of_translate_address(const struct device_node *dev,
>  
>  		/* If root, we have finished */
>  		if (parent == NULL) {
> -			debug("reached root node\n");
> +			dm_warn("reached root node\n");
>  			result = of_read_number(addr, na);
>  			break;
>  		}
> @@ -287,13 +288,13 @@ static u64 __of_translate_address(const struct device_node *dev,
>  		pbus = of_match_bus(parent);
>  		pbus->count_cells(dev, &pna, &pns);
>  		if (!OF_CHECK_COUNTS(pna, pns)) {
> -			debug("Bad cell count for %s\n",
> -			      of_node_full_name(dev));
> +			dm_warn("Bad cell count for %s\n",
> +				of_node_full_name(dev));
>  			break;
>  		}
>  
> -		debug("parent bus is %s (na=%d, ns=%d) on %s\n", pbus->name,
> -		      pna, pns, of_node_full_name(parent));
> +		dm_warn("parent bus is %s (na=%d, ns=%d) on %s\n", pbus->name,
> +			pna, pns, of_node_full_name(parent));
>  
>  		/* Apply bus translation */
>  		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
> @@ -358,8 +359,8 @@ int of_get_dma_range(const struct device_node *dev, phys_addr_t *cpu,
>  	}
>  
>  	if (!dev || !ranges) {
> -		debug("no dma-ranges found for node %s\n",
> -		      of_node_full_name(dev));
> +		dm_warn("no dma-ranges found for node %s\n",
> +			of_node_full_name(dev));
>  		ret = -ENOENT;
>  		goto out;
>  	}
> diff --git a/drivers/core/of_extra.c b/drivers/core/of_extra.c
> index a3ebe9e9c24..bfc1e3441b1 100644
> --- a/drivers/core/of_extra.c
> +++ b/drivers/core/of_extra.c
> @@ -9,6 +9,7 @@
>  #include <dm/of_access.h>
>  #include <dm/of_extra.h>
>  #include <dm/ofnode.h>
> +#include <dm/util.h>
>  
>  int ofnode_read_fmap_entry(ofnode node, struct fmap_entry *entry)
>  {
> @@ -16,13 +17,13 @@ int ofnode_read_fmap_entry(ofnode node, struct fmap_entry *entry)
>  	ofnode subnode;
>  
>  	if (ofnode_read_u32(node, "image-pos", &entry->offset)) {
> -		debug("Node '%s' has bad/missing 'image-pos' property\n",
> -		      ofnode_get_name(node));
> +		dm_warn("Node '%s' has bad/missing 'image-pos' property\n",
> +			ofnode_get_name(node));
>  		return log_msg_ret("image-pos", -ENOENT);
>  	}
>  	if (ofnode_read_u32(node, "size", &entry->length)) {
> -		debug("Node '%s' has bad/missing 'size' property\n",
> -		      ofnode_get_name(node));
> +		dm_warn("Node '%s' has bad/missing 'size' property\n",
> +			ofnode_get_name(node));
>  		return log_msg_ret("size", -ENOENT);
>  	}
>  	entry->used = ofnode_read_s32_default(node, "used", entry->length);
> @@ -57,17 +58,17 @@ int ofnode_decode_region(ofnode node, const char *prop_name, fdt_addr_t *basep,
>  	const fdt_addr_t *cell;
>  	int len;
>  
> -	debug("%s: %s: %s\n", __func__, ofnode_get_name(node), prop_name);
> +	dm_warn("%s: %s: %s\n", __func__, ofnode_get_name(node), prop_name);
>  	cell = ofnode_get_property(node, prop_name, &len);
>  	if (!cell || (len < sizeof(fdt_addr_t) * 2)) {
> -		debug("cell=%p, len=%d\n", cell, len);
> +		dm_warn("cell=%p, len=%d\n", cell, len);
>  		return -1;
>  	}
>  
>  	*basep = fdt_addr_to_cpu(*cell);
>  	*sizep = fdt_size_to_cpu(cell[1]);
> -	debug("%s: base=%08lx, size=%lx\n", __func__, (ulong)*basep,
> -	      (ulong)*sizep);
> +	dm_warn("%s: base=%08lx, size=%lx\n", __func__, (ulong)*basep,
> +		(ulong)*sizep);
>  
>  	return 0;
>  }
> @@ -85,7 +86,7 @@ int ofnode_decode_memory_region(ofnode config_node, const char *mem_type,
>  	if (!ofnode_valid(config_node)) {
>  		config_node = ofnode_path("/config");
>  		if (!ofnode_valid(config_node)) {
> -			debug("%s: Cannot find /config node\n", __func__);
> +			dm_warn("%s: Cannot find /config node\n", __func__);
>  			return -ENOENT;
>  		}
>  	}
> @@ -96,14 +97,14 @@ int ofnode_decode_memory_region(ofnode config_node, const char *mem_type,
>  		 suffix);
>  	mem = ofnode_read_string(config_node, prop_name);
>  	if (!mem) {
> -		debug("%s: No memory type for '%s', using /memory\n", __func__,
> -		      prop_name);
> +		dm_warn("%s: No memory type for '%s', using /memory\n", __func__,
> +			prop_name);
>  		mem = "/memory";
>  	}
>  
>  	node = ofnode_path(mem);
>  	if (!ofnode_valid(node)) {
> -		debug("%s: Failed to find node '%s'\n", __func__, mem);
> +		dm_warn("%s: Failed to find node '%s'\n", __func__, mem);
>  		return -ENOENT;
>  	}
>  
> @@ -112,8 +113,8 @@ int ofnode_decode_memory_region(ofnode config_node, const char *mem_type,
>  	 * use the first
>  	 */
>  	if (ofnode_decode_region(node, "reg", &base, &size)) {
> -		debug("%s: Failed to decode memory region %s\n", __func__,
> -		      mem);
> +		dm_warn("%s: Failed to decode memory region %s\n", __func__,
> +			mem);
>  		return -EINVAL;
>  	}
>  
> @@ -121,8 +122,8 @@ int ofnode_decode_memory_region(ofnode config_node, const char *mem_type,
>  		 suffix);
>  	if (ofnode_decode_region(config_node, prop_name, &offset,
>  				 &offset_size)) {
> -		debug("%s: Failed to decode memory region '%s'\n", __func__,
> -		      prop_name);
> +		dm_warn("%s: Failed to decode memory region '%s'\n", __func__,
> +			prop_name);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 9ff46460e7d..4d563b47a5a 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -16,6 +16,7 @@
>  #include <dm/of_access.h>
>  #include <dm/of_addr.h>
>  #include <dm/ofnode.h>
> +#include <dm/util.h>
>  #include <linux/err.h>
>  #include <linux/ioport.h>
>  #include <asm/global_data.h>
> @@ -314,7 +315,7 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u8(ofnode_to_np(node), propname, outp);
> @@ -322,11 +323,11 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
>  	cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
>  			   &len);
>  	if (!cell || len < sizeof(*cell)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return -EINVAL;
>  	}
>  	*outp = *cell;
> -	debug("%#x (%u)\n", *outp, *outp);
> +	dm_warn("%#x (%u)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -345,7 +346,7 @@ int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u16(ofnode_to_np(node), propname, outp);
> @@ -353,11 +354,11 @@ int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
>  	cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
>  			   &len);
>  	if (!cell || len < sizeof(*cell)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return -EINVAL;
>  	}
>  	*outp = be16_to_cpup(cell);
> -	debug("%#x (%u)\n", *outp, *outp);
> +	dm_warn("%#x (%u)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -390,7 +391,7 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u32_index(ofnode_to_np(node), propname, index,
> @@ -399,17 +400,17 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
>  	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
>  			   propname, &len);
>  	if (!cell) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return -EINVAL;
>  	}
>  
>  	if (len < (sizeof(int) * (index + 1))) {
> -		debug("(not large enough)\n");
> +		dm_warn("(not large enough)\n");
>  		return -EOVERFLOW;
>  	}
>  
>  	*outp = fdt32_to_cpu(cell[index]);
> -	debug("%#x (%u)\n", *outp, *outp);
> +	dm_warn("%#x (%u)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -429,17 +430,17 @@ int ofnode_read_u64_index(ofnode node, const char *propname, int index,
>  	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
>  			   propname, &len);
>  	if (!cell) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return -EINVAL;
>  	}
>  
>  	if (len < (sizeof(u64) * (index + 1))) {
> -		debug("(not large enough)\n");
> +		dm_warn("(not large enough)\n");
>  		return -EOVERFLOW;
>  	}
>  
>  	*outp = fdt64_to_cpu(cell[index]);
> -	debug("%#llx (%llu)\n", *outp, *outp);
> +	dm_warn("%#llx (%llu)\n", *outp, *outp);
>  
>  	return 0;
>  }
> @@ -467,7 +468,7 @@ int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node))
>  		return of_read_u64(ofnode_to_np(node), propname, outp);
> @@ -475,12 +476,12 @@ int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
>  	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
>  			   propname, &len);
>  	if (!cell || len < sizeof(*cell)) {
> -		debug("(not found)\n");
> +		dm_warn("(not found)\n");
>  		return -EINVAL;
>  	}
>  	*outp = fdt64_to_cpu(cell[0]);
> -	debug("%#llx (%llu)\n", (unsigned long long)*outp,
> -	      (unsigned long long)*outp);
> +	dm_warn("%#llx (%llu)\n", (unsigned long long)*outp,
> +		(unsigned long long)*outp);
>  
>  	return 0;
>  }
> @@ -498,11 +499,11 @@ bool ofnode_read_bool(ofnode node, const char *propname)
>  	bool prop;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	prop = ofnode_has_property(node, propname);
>  
> -	debug("%s\n", prop ? "true" : "false");
> +	dm_warn("%s\n", prop ? "true" : "false");
>  
>  	return prop ? true : false;
>  }
> @@ -513,7 +514,7 @@ const void *ofnode_read_prop(ofnode node, const char *propname, int *sizep)
>  	int len;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node)) {
>  		struct property *prop = of_find_property(
> @@ -528,7 +529,7 @@ const void *ofnode_read_prop(ofnode node, const char *propname, int *sizep)
>  				  propname, &len);
>  	}
>  	if (!val) {
> -		debug("<not found>\n");
> +		dm_warn("<not found>\n");
>  		if (sizep)
>  			*sizep = -FDT_ERR_NOTFOUND;
>  		return NULL;
> @@ -549,10 +550,10 @@ const char *ofnode_read_string(ofnode node, const char *propname)
>  		return NULL;
>  
>  	if (strnlen(str, len) >= len) {
> -		debug("<invalid>\n");
> +		dm_warn("<invalid>\n");
>  		return NULL;
>  	}
> -	debug("%s\n", str);
> +	dm_warn("%s\n", str);
>  
>  	return str;
>  }
> @@ -572,7 +573,7 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
>  	ofnode subnode;
>  
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, subnode_name);
> +	dm_warn("%s: %s: ", __func__, subnode_name);
>  
>  	if (ofnode_is_np(node)) {
>  		struct device_node *np = ofnode_to_np(node);
> @@ -587,8 +588,8 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
>  				ofnode_to_offset(node), subnode_name);
>  		subnode = noffset_to_ofnode(node, ooffset);
>  	}
> -	debug("%s\n", ofnode_valid(subnode) ?
> -	      ofnode_get_name(subnode) : "<none>");
> +	dm_warn("%s\n", ofnode_valid(subnode) ?
> +		ofnode_get_name(subnode) : "<none>");
>  
>  	return subnode;
>  }
> @@ -597,7 +598,7 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
>  			  u32 *out_values, size_t sz)
>  {
>  	assert(ofnode_valid(node));
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	if (ofnode_is_np(node)) {
>  		return of_read_u32_array(ofnode_to_np(node), propname,
> @@ -669,7 +670,7 @@ ofnode ofnode_get_parent(ofnode node)
>  const char *ofnode_get_name(ofnode node)
>  {
>  	if (!ofnode_valid(node)) {
> -		debug("%s node not valid\n", __func__);
> +		dm_warn("%s node not valid\n", __func__);
>  		return NULL;
>  	}
>  
> @@ -1030,7 +1031,7 @@ ofnode ofnode_get_aliases_node(const char *name)
>  	if (!prop)
>  		return ofnode_null();
>  
> -	debug("%s: node_path: %s\n", __func__, prop);
> +	dm_warn("%s: node_path: %s\n", __func__, prop);
>  
>  	return ofnode_path(prop);
>  }
> @@ -1053,8 +1054,8 @@ static int decode_timing_property(ofnode node, const char *name,
>  
>  	length = ofnode_read_size(node, name);
>  	if (length < 0) {
> -		debug("%s: could not find property %s\n",
> -		      ofnode_get_name(node), name);
> +		dm_warn("%s: could not find property %s\n",
> +			ofnode_get_name(node), name);
>  		return length;
>  	}
>  
> @@ -1299,7 +1300,7 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
>  	int len;
>  	int ret = -ENOENT;
>  
> -	debug("%s: %s: ", __func__, propname);
> +	dm_warn("%s: %s: ", __func__, propname);
>  
>  	/*
>  	 * If we follow the pci bus bindings strictly, we should check
> @@ -1316,8 +1317,8 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
>  		int i;
>  
>  		for (i = 0; i < num; i++) {
> -			debug("pci address #%d: %08lx %08lx %08lx\n", i,
> -			      (ulong)fdt32_to_cpu(cell[0]),
> +			dm_warn("pci address #%d: %08lx %08lx %08lx\n", i,
> +				(ulong)fdt32_to_cpu(cell[0]),
>  			      (ulong)fdt32_to_cpu(cell[1]),
>  			      (ulong)fdt32_to_cpu(cell[2]));
>  			if ((fdt32_to_cpu(*cell) & type) == type) {
> @@ -1346,7 +1347,7 @@ int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
>  	ret = -EINVAL;
>  
>  fail:
> -	debug("(not found)\n");
> +	dm_warn("(not found)\n");
>  	return ret;
>  }
>  
> @@ -1630,7 +1631,7 @@ int ofnode_write_string(ofnode node, const char *propname, const char *value)
>  {
>  	assert(ofnode_valid(node));
>  
> -	debug("%s: %s = %s", __func__, propname, value);
> +	dm_warn("%s: %s = %s", __func__, propname, value);
>  
>  	return ofnode_write_prop(node, propname, value, strlen(value) + 1,
>  				 false);
> @@ -1743,7 +1744,7 @@ int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
>  
>  	uboot = ofnode_path("/options/u-boot");
>  	if (!ofnode_valid(uboot)) {
> -		debug("%s: Missing /u-boot node\n", __func__);
> +		dm_warn("%s: Missing /u-boot node\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1769,7 +1770,7 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
>  
>  	uboot = ofnode_path("/options/u-boot");
>  	if (!ofnode_valid(uboot)) {
> -		debug("%s: Missing /u-boot node\n", __func__);
> +		dm_warn("%s: Missing /u-boot node\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1784,7 +1785,7 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
>  		return -EINVAL;
>  
>  	if (!bootscr_flash_size) {
> -		debug("bootscr-flash-size is zero. Ignoring properties!\n");
> +		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
>  		*bootscr_flash_offset = 0;
>  		return -EINVAL;
>  	}
> @@ -1831,7 +1832,7 @@ phy_interface_t ofnode_read_phy_mode(ofnode node)
>  		if (!strcmp(mode, phy_interface_strings[i]))
>  			return i;
>  
> -	debug("%s: Invalid PHY interface '%s'\n", __func__, mode);
> +	dm_warn("%s: Invalid PHY interface '%s'\n", __func__, mode);
>  
>  	return PHY_INTERFACE_MODE_NA;
>  }
> diff --git a/drivers/core/regmap.c b/drivers/core/regmap.c
> index 7ff7834bdf0..304d5b02bcd 100644
> --- a/drivers/core/regmap.c
> +++ b/drivers/core/regmap.c
> @@ -17,6 +17,7 @@
>  #include <asm/io.h>
>  #include <dm/of_addr.h>
>  #include <dm/devres.h>
> +#include <dm/util.h>
>  #include <linux/ioport.h>
>  #include <linux/compat.h>
>  #include <linux/err.h>
> @@ -139,8 +140,8 @@ static int init_range(ofnode node, struct regmap_range *range, int addr_len,
>  		ret = of_address_to_resource(ofnode_to_np(node),
>  					     index, &r);
>  		if (ret) {
> -			debug("%s: Could not read resource of range %d (ret = %d)\n",
> -			      ofnode_get_name(node), index, ret);
> +			dm_warn("%s: Could not read resource of range %d (ret = %d)\n",
> +				ofnode_get_name(node), index, ret);
>  			return ret;
>  		}
>  
> @@ -154,8 +155,8 @@ static int init_range(ofnode node, struct regmap_range *range, int addr_len,
>  							  addr_len, size_len,
>  							  &sz, true);
>  		if (range->start == FDT_ADDR_T_NONE) {
> -			debug("%s: Could not read start of range %d\n",
> -			      ofnode_get_name(node), index);
> +			dm_warn("%s: Could not read start of range %d\n",
> +				ofnode_get_name(node), index);
>  			return -EINVAL;
>  		}
>  
> @@ -173,15 +174,15 @@ int regmap_init_mem_index(ofnode node, struct regmap **mapp, int index)
>  
>  	addr_len = ofnode_read_simple_addr_cells(ofnode_get_parent(node));
>  	if (addr_len < 0) {
> -		debug("%s: Error while reading the addr length (ret = %d)\n",
> -		      ofnode_get_name(node), addr_len);
> +		dm_warn("%s: Error while reading the addr length (ret = %d)\n",
> +			ofnode_get_name(node), addr_len);
>  		return addr_len;
>  	}
>  
>  	size_len = ofnode_read_simple_size_cells(ofnode_get_parent(node));
>  	if (size_len < 0) {
> -		debug("%s: Error while reading the size length: (ret = %d)\n",
> -		      ofnode_get_name(node), size_len);
> +		dm_warn("%s: Error while reading the size length: (ret = %d)\n",
> +			ofnode_get_name(node), size_len);
>  		return size_len;
>  	}
>  
> @@ -250,36 +251,36 @@ int regmap_init_mem(ofnode node, struct regmap **mapp)
>  
>  	addr_len = ofnode_read_simple_addr_cells(ofnode_get_parent(node));
>  	if (addr_len < 0) {
> -		debug("%s: Error while reading the addr length (ret = %d)\n",
> -		      ofnode_get_name(node), addr_len);
> +		dm_warn("%s: Error while reading the addr length (ret = %d)\n",
> +			ofnode_get_name(node), addr_len);
>  		return addr_len;
>  	}
>  
>  	size_len = ofnode_read_simple_size_cells(ofnode_get_parent(node));
>  	if (size_len < 0) {
> -		debug("%s: Error while reading the size length: (ret = %d)\n",
> -		      ofnode_get_name(node), size_len);
> +		dm_warn("%s: Error while reading the size length: (ret = %d)\n",
> +			ofnode_get_name(node), size_len);
>  		return size_len;
>  	}
>  
>  	both_len = addr_len + size_len;
>  	if (!both_len) {
> -		debug("%s: Both addr and size length are zero\n",
> -		      ofnode_get_name(node));
> +		dm_warn("%s: Both addr and size length are zero\n",
> +			ofnode_get_name(node));
>  		return -EINVAL;
>  	}
>  
>  	len = ofnode_read_size(node, "reg");
>  	if (len < 0) {
> -		debug("%s: Error while reading reg size (ret = %d)\n",
> -		      ofnode_get_name(node), len);
> +		dm_warn("%s: Error while reading reg size (ret = %d)\n",
> +			ofnode_get_name(node), len);
>  		return len;
>  	}
>  	len /= sizeof(fdt32_t);
>  	count = len / both_len;
>  	if (!count) {
> -		debug("%s: Not enough data in reg property\n",
> -		      ofnode_get_name(node));
> +		dm_warn("%s: Not enough data in reg property\n",
> +			ofnode_get_name(node));
>  		return -EINVAL;
>  	}
>  
> @@ -424,8 +425,8 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
>  	void *ptr;
>  
>  	if (do_range_check() && range_num >= map->range_count) {
> -		debug("%s: range index %d larger than range count\n",
> -		      __func__, range_num);
> +		dm_warn("%s: range index %d larger than range count\n",
> +			__func__, range_num);
>  		return -ERANGE;
>  	}
>  	range = &map->ranges[range_num];
> @@ -433,7 +434,7 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
>  	offset <<= map->reg_offset_shift;
>  	if (do_range_check() &&
>  	    (offset + val_len > range->size || offset + val_len < offset)) {
> -		debug("%s: offset/size combination invalid\n", __func__);
> +		dm_warn("%s: offset/size combination invalid\n", __func__);
>  		return -ERANGE;
>  	}
>  
> @@ -455,7 +456,7 @@ int regmap_raw_read_range(struct regmap *map, uint range_num, uint offset,
>  		break;
>  #endif
>  	default:
> -		debug("%s: regmap size %zu unknown\n", __func__, val_len);
> +		dm_warn("%s: regmap size %zu unknown\n", __func__, val_len);
>  		return -EINVAL;
>  	}
>  
> @@ -564,15 +565,15 @@ int regmap_raw_write_range(struct regmap *map, uint range_num, uint offset,
>  	void *ptr;
>  
>  	if (range_num >= map->range_count) {
> -		debug("%s: range index %d larger than range count\n",
> -		      __func__, range_num);
> +		dm_warn("%s: range index %d larger than range count\n",
> +			__func__, range_num);
>  		return -ERANGE;
>  	}
>  	range = &map->ranges[range_num];
>  
>  	offset <<= map->reg_offset_shift;
>  	if (offset + val_len > range->size || offset + val_len < offset) {
> -		debug("%s: offset/size combination invalid\n", __func__);
> +		dm_warn("%s: offset/size combination invalid\n", __func__);
>  		return -ERANGE;
>  	}
>  
> @@ -594,7 +595,7 @@ int regmap_raw_write_range(struct regmap *map, uint range_num, uint offset,
>  		break;
>  #endif
>  	default:
> -		debug("%s: regmap size %zu unknown\n", __func__, val_len);
> +		dm_warn("%s: regmap size %zu unknown\n", __func__, val_len);
>  		return -EINVAL;
>  	}
>  
> @@ -630,8 +631,8 @@ int regmap_write(struct regmap *map, uint offset, uint val)
>  		u.v64 = val;
>  		break;
>  	default:
> -		debug("%s: regmap size %zu unknown\n", __func__,
> -		      (size_t)map->width);
> +		dm_warn("%s: regmap size %zu unknown\n", __func__,
> +			(size_t)map->width);
>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index 4bfd08f4813..7cf6607a9b7 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -207,7 +207,7 @@ static int dm_scan_fdt_node(struct udevice *parent, ofnode parent_node,
>  		err = lists_bind_fdt(parent, node, NULL, NULL, pre_reloc_only);
>  		if (err && !ret) {
>  			ret = err;
> -			debug("%s: ret=%d\n", node_name, ret);
> +			dm_warn("%s: ret=%d\n", node_name, ret);
>  		}
>  	}
>  
> @@ -248,7 +248,7 @@ int dm_extended_scan(bool pre_reloc_only)
>  
>  	ret = dm_scan_fdt(pre_reloc_only);
>  	if (ret) {
> -		debug("dm_scan_fdt() failed: %d\n", ret);
> +		dm_warn("dm_scan_fdt() failed: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -256,8 +256,8 @@ int dm_extended_scan(bool pre_reloc_only)
>  	for (i = 0; i < ARRAY_SIZE(nodes); i++) {
>  		ret = dm_scan_fdt_ofnode_path(nodes[i], pre_reloc_only);
>  		if (ret) {
> -			debug("dm_scan_fdt() scan for %s failed: %d\n",
> -			      nodes[i], ret);
> +			dm_warn("dm_scan_fdt() scan for %s failed: %d\n",
> +				nodes[i], ret);
>  			return ret;
>  		}
>  	}
> @@ -320,14 +320,14 @@ static int dm_scan(bool pre_reloc_only)
>  
>  	ret = dm_scan_plat(pre_reloc_only);
>  	if (ret) {
> -		debug("dm_scan_plat() failed: %d\n", ret);
> +		dm_warn("dm_scan_plat() failed: %d\n", ret);
>  		return ret;
>  	}
>  
>  	if (CONFIG_IS_ENABLED(OF_REAL)) {
>  		ret = dm_extended_scan(pre_reloc_only);
>  		if (ret) {
> -			debug("dm_extended_scan() failed: %d\n", ret);
> +			dm_warn("dm_extended_scan() failed: %d\n", ret);
>  			return ret;
>  		}
>  	}
> @@ -345,7 +345,7 @@ int dm_init_and_scan(bool pre_reloc_only)
>  
>  	ret = dm_init(CONFIG_IS_ENABLED(OF_LIVE));
>  	if (ret) {
> -		debug("dm_init() failed: %d\n", ret);
> +		dm_warn("dm_init() failed: %d\n", ret);
>  		return ret;
>  	}
>  	if (!CONFIG_IS_ENABLED(OF_PLATDATA_INST)) {
> diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> index 762536eebc6..7ae0884a75e 100644
> --- a/drivers/core/uclass.c
> +++ b/drivers/core/uclass.c
> @@ -59,8 +59,8 @@ static int uclass_add(enum uclass_id id, struct uclass **ucp)
>  	*ucp = NULL;
>  	uc_drv = lists_uclass_lookup(id);
>  	if (!uc_drv) {
> -		debug("Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> -		      id);
> +		dm_warn("Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> +			id);
>  		/*
>  		 * Use a strange error to make this case easier to find. When
>  		 * a uclass is not available it can prevent driver model from
> 
> -- 
> 2.45.2
> 

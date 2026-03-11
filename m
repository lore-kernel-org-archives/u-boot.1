Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93AA1125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B728984013;
	Wed, 11 Mar 2026 15:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB5184035; Wed, 11 Mar 2026 15:17:29 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8EA84010
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=pengutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=a.fatoum@pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <a.fatoum@pengutronix.de>)
 id 1w0KNK-00039w-49; Wed, 11 Mar 2026 15:17:26 +0100
Message-ID: <f1cf64a7-04b4-409f-ab54-044b010f32cd@pengutronix.de>
Date: Wed, 11 Mar 2026 15:17:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ludwig <ludwig.nussel@siemens.com>,
 Simon Glass <simon.glass@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>
References: <20260306012019.800588-1-sjg@chromium.org>
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20260306012019.800588-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: u-boot@lists.denx.de
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

Hello Simon,

On 3/6/26 2:20 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>

> +	/* Process each image referenced by the config */
> +	image_count = 0;
> +	fdt_for_each_property_offset(prop_offset, fit, conf_noffset) {
> +		const char *prop_name;
> +		int img_count, i;
> +
> +		fdt_getprop_by_offset(fit, prop_offset, &prop_name, NULL);
> +		if (!prop_name)
> +			continue;
> +
> +		/* Skip properties that are not image references */
> +		if (!strcmp(prop_name, FIT_DESC_PROP) ||
> +		    !strcmp(prop_name, FIT_COMPAT_PROP) ||

I know you need to mimic what mkimage does on the other side, but I
found this surprising:

The configuration node name is probably hashed along with the FDT node,
but compatible isn't, so relying on compatible means an attacker can
trivially control which configuration is booted.

> +		    !strcmp(prop_name, FIT_DEFAULT_PROP))

I am aware of /configurations/default, but what does a default property
within a configuration signify?

Thanks,
Ahmad

> +			continue;
> +
> +		img_count = fdt_stringlist_count(fit, conf_noffset, prop_name);
> +		for (i = 0; i < img_count; i++) {
> +			int noffset;
> +
> +			noffset = fit_conf_get_prop_node_index(fit,
> +							       conf_noffset,
> +							       prop_name, i);
> +			if (noffset < 0)
> +				continue;
> +
> +			ret = fit_config_add_hash(fit, noffset, node_inc,
> +						  &count, max_nodes, buf, &used,
> +						  buf_len);
> +			if (ret < 0)
> +				return ret;
> +
> +			image_count++;
> +		}
> +	}
> +
> +	if (!image_count) {
> +		printf("No images in config '%s'\n", conf_name);
> +		return -ENOMSG;
> +	}
> +
> +	return count;
> +}
> +
>  /**
>   * fit_config_check_sig() - Check the signature of a config
>   *
> @@ -269,20 +443,16 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
>  		FIT_DATA_POSITION_PROP,
>  		FIT_DATA_OFFSET_PROP,
>  	};
> -
> -	const char *prop, *end, *name;
> +	char *node_inc[IMAGE_MAX_HASHED_NODES];
> +	char hash_buf[FIT_MAX_HASH_PATH_BUF];
>  	struct image_sign_info info;
>  	const uint32_t *strings;
> -	const char *config_name;
>  	uint8_t *fit_value;
>  	int fit_value_len;
> -	bool found_config;
>  	int max_regions;
> -	int i, prop_len;
>  	char path[200];
>  	int count;
>  
> -	config_name = fit_get_name(fit, conf_noffset, NULL);
>  	debug("%s: fdt=%p, conf='%s', sig='%s'\n", __func__, key_blob,
>  	      fit_get_name(fit, noffset, NULL),
>  	      fit_get_name(key_blob, required_keynode, NULL));
> @@ -297,45 +467,12 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
>  		return -1;
>  	}
>  
> -	/* Count the number of strings in the property */
> -	prop = fdt_getprop(fit, noffset, "hashed-nodes", &prop_len);
> -	end = prop ? prop + prop_len : prop;
> -	for (name = prop, count = 0; name < end; name++)
> -		if (!*name)
> -			count++;
> -	if (!count) {
> -		*err_msgp = "Can't get hashed-nodes property";
> -		return -1;
> -	}
> -
> -	if (prop && prop_len > 0 && prop[prop_len - 1] != '\0') {
> -		*err_msgp = "hashed-nodes property must be null-terminated";
> -		return -1;
> -	}
> -
> -	/* Add a sanity check here since we are using the stack */
> -	if (count > IMAGE_MAX_HASHED_NODES) {
> -		*err_msgp = "Number of hashed nodes exceeds maximum";
> -		return -1;
> -	}
> -
> -	/* Create a list of node names from those strings */
> -	char *node_inc[count];
> -
> -	debug("Hash nodes (%d):\n", count);
> -	found_config = false;
> -	for (name = prop, i = 0; name < end; name += strlen(name) + 1, i++) {
> -		debug("   '%s'\n", name);
> -		node_inc[i] = (char *)name;
> -		if (!strncmp(FIT_CONFS_PATH, name, strlen(FIT_CONFS_PATH)) &&
> -		    name[sizeof(FIT_CONFS_PATH) - 1] == '/' &&
> -		    !strcmp(name + sizeof(FIT_CONFS_PATH), config_name)) {
> -			debug("      (found config node %s)", config_name);
> -			found_config = true;
> -		}
> -	}
> -	if (!found_config) {
> -		*err_msgp = "Selected config not in hashed nodes";
> +	/* Build the node list from the config, ignoring hashed-nodes */
> +	count = fit_config_get_hash_list(fit, conf_noffset,
> +					 node_inc, IMAGE_MAX_HASHED_NODES,
> +					 hash_buf, sizeof(hash_buf));
> +	if (count < 0) {
> +		*err_msgp = "Failed to build hash node list";
>  		return -1;
>  	}
>  
> diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
> index e5b5a8432e9..da08cc75c3a 100644
> --- a/doc/usage/fit/signature.rst
> +++ b/doc/usage/fit/signature.rst
> @@ -353,20 +353,27 @@ meantime.
>  Details
>  -------
>  The signature node contains a property ('hashed-nodes') which lists all the
> -nodes that the signature was made over.  The image is walked in order and each
> -tag processed as follows:
> +nodes that the signature was made over.  The signer (mkimage) writes this
> +property as a record of what was included in the hash.  During verification,
> +however, U-Boot does not read 'hashed-nodes'. Instead it rebuilds the node
> +list from the configuration's own image references (kernel, fdt, ramdisk,
> +etc.), since 'hashed-nodes' is not itself covered by the signature. The
> +rebuilt list always includes the root node, the configuration node, each
> +referenced image node and its hash/cipher subnodes.
> +
> +The image is walked in order and each tag processed as follows:
>  
>  DTB_BEGIN_NODE
>      The tag and the following name are included in the signature
> -    if the node or its parent are present in 'hashed-nodes'
> +    if the node or its parent are present in the node list
>  
>  DTB_END_NODE
>      The tag is included in the signature if the node or its parent
> -    are present in 'hashed-nodes'
> +    are present in the node list
>  
>  DTB_PROPERTY
>      The tag, the length word, the offset in the string table, and
> -    the data are all included if the current node is present in 'hashed-nodes'
> +    the data are all included if the current node is present in the node list
>      and the property name is not 'data'.
>  
>  DTB_END
> @@ -374,7 +381,7 @@ DTB_END
>  
>  DTB_NOP
>      The tag is included in the signature if the current node is present
> -    in 'hashed-nodes'
> +    in the node list
>  
>  In addition, the signature contains a property 'hashed-strings' which contains
>  the offset and length in the string table of the strings that are to be
> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> index 7a7f9c379de..19f3f981379 100644
> --- a/test/py/tests/test_vboot.py
> +++ b/test/py/tests/test_vboot.py
> @@ -362,10 +362,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
>              shutil.copyfile(fit, efit)
>              vboot_evil.add_evil_node(fit, efit, evil_kernel, 'kernel@')
>  
> -            msg = 'Signature checking prevents use of unit addresses (@) in nodes'
> +            # fit_check_sign catches this via signature mismatch (the @
> +            # node is hashed instead of the real one)
>              utils.run_and_log_expect_exception(
>                  ubman, [fit_check_sign, '-f', efit, '-k', dtb],
> -                1, msg)
> +                1, 'Failed to verify required signature')
> +
> +            # bootm catches it earlier, at fit_check_format() time
> +            msg = 'Signature checking prevents use of unit addresses (@) in nodes'
>              run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
>  
>          # Create a new properly signed fit and replace header bytes

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |


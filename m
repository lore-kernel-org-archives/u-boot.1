Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96B5C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D43F879E5;
	Thu, 18 Jan 2024 13:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qzTRdw/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DBFC87AB9; Thu, 18 Jan 2024 13:39:15 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732448798D
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3373bc6d625so10310982f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 04:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705581553; x=1706186353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MjOmI2CSqFLpoVpJUVEo6+Mial8QGqoczruGVyRp04s=;
 b=qzTRdw/5VFrASYx1Td9WKbdiScpKW/SSU3gQkb+SssbKGybdWTCIz/ULP5W9Im256b
 XLq0Wj1eT0YGsfqvImuEH8qSkTXkvB5m7lvy76q385oiH5mpkk07auvdRt3n6U+Ao+tq
 6Z4hO3Bfpa9Vu/8tgZNnNrXPE9qx5SIDNsUmiEJciUXwNh7AKTN0N46Z85P5A39yzxxt
 GCD9Rt5Yn13tJUgEwtp6ydBgYPGPzKRlj0V+Np3/lC88bIgrYfVgO8OwtF7AXOkZiKFc
 wXkJSzxoC4bYAg7OIQzF8FFBnSpK05CkGBl4L4GrLZaOdROiR+SNysNwTH+l/MRBLmNn
 lpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705581553; x=1706186353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjOmI2CSqFLpoVpJUVEo6+Mial8QGqoczruGVyRp04s=;
 b=SFFzjfw07hHTy4dlaf1xC2IvCjz/hCl74aamK9sYvIqx3wuXcguCIck+Uh0cU05I2Y
 h97nMmBJ82RgQ36PECxXA2boph3aYJ1N3W6b67nWebbE9D0AaVBS6n/roVpr4OSBJ7ej
 AmcWIrQ2QExBaOXxPX/HegGT47W0Lk5FFJnzZAQieTc/SndEjV8XyDTVHiYPZwNEzCXS
 cpoW1Q1EpD2FxaJMVbdGQj0OJsa0KSBJrIX1/1IxBs/4Qj4g57/8xsfe0axy2/N2KdG2
 u4lYrEWDpJeME8iBV15OoDo9U3nh9gx0GTvbc2pMDCB6TkhFp8VXsWZKKP6Z8hXoys7k
 bUEQ==
X-Gm-Message-State: AOJu0YwHxt65W4SlzebmUhgxUFsqvf8JNc4pS2KVBpaHJILLx6DnenEl
 YBzNupa/WQyYZ8tErcGa4lAGdZkZGYb2+VyLKJ0yIWTvfQzlx65W+uKy9f3W+gU=
X-Google-Smtp-Source: AGHT+IGAaazP3A01xptFJ+fzWhdwrQgHfi6ndxLSm8PgjjXiMjhKZScb9cqYKj6cUr4VprZnA1g33w==
X-Received: by 2002:a5d:6106:0:b0:337:c732:4074 with SMTP id
 v6-20020a5d6106000000b00337c7324074mr446988wrt.75.1705581552879; 
 Thu, 18 Jan 2024 04:39:12 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d54c8000000b00337d3465997sm1167166wrv.38.2024.01.18.04.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:39:12 -0800 (PST)
Date: Thu, 18 Jan 2024 14:39:10 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] cmd: provide command to display SMBIOS information
Message-ID: <Zakb7ozkAU994FBj@hera>
References: <20240117153347.85074-1-heinrich.schuchardt@canonical.com>
 <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117153347.85074-2-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

A few nits below

On Wed, Jan 17, 2024 at 04:33:45PM +0100, Heinrich Schuchardt wrote:
> U-Boot can either generated an SMBIOS table or copy it from a prior boot
> stage, e.g. QEMU.
>
> Provide a command to display the SMBIOS information.
>
> Currently only type 1 and 2 are translated to human readable text.
> Other types may be added later. Currently only a hexdump and the list of
> strings is provided for these.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v2:

[...]

> 	email address updated
> +static struct smbios_header *next_table(struct smbios_header *table)
> +{
> +	const char *str;
> +
> +	if (table->type == SMBIOS_END_OF_TABLE)
> +		return NULL;
> +
> +	str = smbios_get_string(table, 0);
> +	return (struct smbios_header *)(++str);

That can lead to unaligned access when we dereference that pointer, do we
care?

> +}
> +
> +static void smbios_print_generic(struct smbios_header *table)
> +{
> +	char *str = (char *)table + table->length;
> +

Do we want the header below printed if there are no strings?
IOW can we exit early if (!*str) ?

> +	if (CONFIG_IS_ENABLED(HEXDUMP)) {
> +		printf("Header and Data:\n");
> +		print_hex_dump("\t", DUMP_PREFIX_OFFSET, 16, 1,
> +			       table, table->length, false);
> +	}
> +	if (*str) {
> +		printf("Strings:\n");
> +		for (int index = 1; *str; ++index) {
> +			printf("\tString %u: %s\n", index, str);
> +			str += strlen(str) + 1;
> +		}
> +	}
> +}
> +
> +void smbios_print_str(const char *label, void *table, u8 index)
> +{
> +	printf("\t%s: %s\n", label, smbios_get_string(table, index));
> +}
> +


Other than that, LGTM

Thanks
/Ilias

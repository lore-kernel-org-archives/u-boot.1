Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F169606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lN3jjN91;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gQWRVpPI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC5780E23;
	Mon, 23 Nov 2026 13:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DpvaUFRLAwPJ; Mon, 23 Nov 2026 13:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0DF5080E29
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795439560;
	b=XNQm2L0d/YqbQVi1b8+qEgIriEeC1E03zbh0y0wA6hS8ob1vbfjwzP7UYvxJOtDz4QtV
	 jn6Hi5eMa3PWiP1bne+We7g8wBCEhFFBkey5ko3L3N4huqLuhV8qW35e+vhA+S/Y+z12f
	 cN0RTIE02CGfZFumM/rE9wtLsK9uCH2C7zrj3Llt372vXivULGt20Eb2np4c4FHVWI5v3
	 p4a7Y9PmhM6fq3y/5szgQrFAY2RwNOD20CpXuuyXU9BHyCk41i2Yqvrv7dHBdT08ZcZLp
	 cFfmUfRtxVvd7LyVQSa/9Y/PeZjU6KmDM8cTXD5Fl36eWy98ib9shPPM2y3xRJGdMfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795439560;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2C/Crp4OyW++hlIIpvuX803b3D7iV8K4CsaQdQk1cXc=;
	b=RVewb6axhcaB1Qo4lzIspztSDQ2Dtb3jg9Cfc7R99cIoVoG+vJHeAbu9VIPfByaaoC/k
	 cM74M6PjoVnIPsj4sMPn4DxTcix2hwgZHkU84QVZjKJu7e7wlWgXXbXlvKXrE1NgLHC45
	 1O1fwX6jgGAlPw9BnPUXY8cO7zIBuaoBRBNbsSLetue1fBQpDaZ5449U6SXYq9CHY/fbe
	 gjhYxeJ/GXft7x4Gvx1qgGNqzqrlri8ZQEOHYIjO7sQfGYcnk7GMaiK2XYpEMJ3wvcl4g
	 mMZLKJl6IXrdDNCtivkaAL+8MLavVYn1UgGz+NpJ0JWKZh3U74CJMzQYzWGzwmhNxYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gQWRVpPI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795439560;
	bh=2C/Crp4OyW++hlIIpvuX803b3D7iV8K4CsaQdQk1cXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lN3jjN91gMWGO29G+LU8+GcWz6rvT0K27ivPzumx9pL5PvBz1GwyRYw/4yg5TfQcX
	 /fQcHRTIEZzvYXhiW549mFhxFQ+Er2C1oR0FClJ4RhMtfnYfOBhOcmCORJJnHw/xcK
	 pwDl83CLw/N4oGFgcV6pLQ0IHhaip9GeSoNpqttVYnsb2eBsxlpQpW0HFAiKgzwOnK
	 ctgoGvY669Ji9IpcjgoY65PEq8IHKDC4HvRbKEkdVDi2qkuybOanrU+zFL3CPCcnsP
	 t3SEijlgqxJatJ/MIOddhgklL7wci8Gpq2brsMObFH0a2DXcqynLey6fBeAjn6dTFH
	 gfzjgTw7AONfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DF5080E29;
	Mon, 23 Nov 2026 13:12:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B5F841AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B38F980E29
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LpSf8ggLQIBZ for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 13:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68BC380E23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gQWRVpPI
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68BC380E23
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 13:12:36 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so28602925e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 05:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795439555; x=1796044355;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2C/Crp4OyW++hlIIpvuX803b3D7iV8K4CsaQdQk1cXc=;
 b=gQWRVpPIkSpwVzQS2bSZ0oTHK2l4eITRnG9RRioo/cTBJqoQRJTHNbkLCv/52hjZ4S
 E1sM+Pk+nnAmxzxdMq2LPoWt2HeQritww3LmbBXFGQGkVghhp5vUsf1K77968U2oV5y/
 DUcxc6fzHrMGn2Yc9DcfpB7ZlxyFe/UfN6nqfr0QyVq5T25D3bZO76ZI1qeT5dYabehN
 A/e6SGyAn3qUYRNvDjxda92F10fwgw2ugoNRyckeZMtIoTQwTEuvLnlB1lqIMRZ0ZS6f
 0XLE+VI8eXT3VyxsSawEkKoAD8A/CQv4aP4DbMD1HL7AYxOy9GiPSaQXmuqFh7VkVh+O
 mkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795439555; x=1796044355;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2C/Crp4OyW++hlIIpvuX803b3D7iV8K4CsaQdQk1cXc=;
 b=lk/rOONUqPmpWZCaSnx+NnAqe4nGgwc5PGv54Aaz9QdG8hcjok0SMtkgU57eg4tvVf
 1OPOlIiqNOBm9NO71uQfoWCRznNkKUj+zj92CAyLlR1xyQ0MebMrNutyU1DmuolXWWe3
 kiXy/Sx6G05+6rSu/i21KElULawaFwkyr4yF9trMdDm+NeFN74jmJYYyarVBsPJzZRNX
 am09syLumPJJJLfoYZ0Mk9lwlR+S97kTzhk4BbmmXajnWOqD2vv9xDU0HQrUkav7z33/
 ogxwJYUTZLRvSLu5QH6NduYl0LBePFwPPwo6hADmUksWqsQl0AqOnXIwmdKPfcZFj2b1
 vvtg==
X-Gm-Message-State: APuU4Z+pdTNG2XrMl+pausJd3NlNiPdOND9iD8A1+qFZF1wiR40OSUro
 kNRjI5T3+ZysOA9tmXpkSxhMtPy0YckqqduQQ54qqnAlUNpYKpsh6T8EIfvuvTmb/SM=
X-Gm-Gg: AZFdTZdiJUWiMaEvT44bTdrG6mlBhJpD3BHN88uA2HSrVa/5LGVCSj2RCbSjIUsGtaJ
 jXpJJNXgb93jCp19P0usgfMvI1/NjK/0tfY97NBVJDlOk9XH2OGlm6jRUwSpr0smEbCxL6uTYzu
 Wx9VhUUHWYbqcR3Pgp9NoIWJu7J+Vemd01j12ApIV8HmmTyPMOv9uqTWXyqWdK/8bGT4ZX/vpWC
 l+Q58BRQYSeqiQ8irwNh/DNiSDR3T2lzHGfLj96kikfm0cs/FS92vrqf9+czTdBoTaKP5hv0rHk
 QihssebWkoQHJJVuAgvbaD1a+/QRF/3AYttn/F2AoH9y6ryY0Bpa5kXztGZuJRIxoS3ZD8xpRgD
 bzhD3rwWEUo6D2bmiI273WUZ3H6ADiycI26ukw++pJp4In42antNGqtqoBxKqc2Zrxg7jJ3DvaL
 TXyod37DVk/EyRAjFtJgIruDZ6EHmOt+isqGUk4FWLkFY0zpucV8F4SUqYj2+a3ExJWigH1C48u
 Mum/MzwJmrXsB0YmMP4e3f1xu8EjmzyBIJgDjIi6JjJAp4tij8OKagIiIZiM1q6Y9hvnZ9cUeF7
 fIn4cKh89tnC4l03ogz9nPnolm3Y4NWKIoTUecrm
X-Received: by 2002:a05:600c:3e1a:b0:4bb:6814:7391 with SMTP id
 5b1f17b1804b1-4bb8881921cmr226864125e9.25.1795439554832; 
 Mon, 23 Nov 2026 05:12:34 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff25:4f10:c1b0:1199:e313:6fb5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm393538315e9.12.2026.11.23.05.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:12:34 -0800 (PST)
Date: Mon, 23 Nov 2026 14:12:30 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH] board: stemmy: Read persistent radio addresses
Message-ID: <awM3X9Ku4Q4_-jkX@linaro.org>
References: <20261120-ux500-efs-v1-1-58147e2eae41@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-ux500-efs-v1-1-58147e2eae41@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 10:24:45PM +0100, Linus Walleij wrote:
> The device tree should contain the hardware addresses for Wifi
> and Bluetooth.
> 
> Samsung stores Wi-Fi and Bluetooth addresses in several
> locations depending on the device and firmware. The eMMC partition
> numbers also differ between devices.
> 
> Locate the EFS and DATAFS partitions by name, with a filesystem-content
> fallback for unlabeled partition tables. Search the Samsung Wi-Fi
> address files in priority order and support both Bluetooth EFS layouts.
> 
> Accept colon-separated and compact addresses, including Codina's
> bt_macaddr: record, reject known firmware placeholders.
> 
> Pass valid addresses to the operating system through the device
> tree nodes from ft_board_setup().
> 
> Tested on some different phones such as Janice, Codina, Skomer,
> Golden...
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  MAINTAINERS                     |   1 +
>  board/ste/stemmy/Makefile       |   2 +-
>  board/ste/stemmy/stemmy-radio.c | 325 ++++++++++++++++++++++++++++++++++++++++
>  board/ste/stemmy/stemmy-radio.h |   8 +
>  board/ste/stemmy/stemmy.c       |   4 +
>  5 files changed, 339 insertions(+), 1 deletion(-)
> 
> [...]
> diff --git a/board/ste/stemmy/stemmy-radio.c b/board/ste/stemmy/stemmy-radio.c
> new file mode 100644
> index 000000000000..3394fb8ca75a
> --- /dev/null
> +++ b/board/ste/stemmy/stemmy-radio.c
> @@ -0,0 +1,325 @@
> [...]
> +static int stemmy_find_partition(struct blk_desc *desc, const char *name)
> +{
> +	struct disk_partition info;
> +	int part;
> +
> +	if (!desc)
> +		return -ENODEV;
> +
> +	part = part_get_info_by_name(desc, name, &info);
> +	if (part >= 0)
> +		return part;
> +
> +	for (part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
> +		if (part_get_info(desc, part, &info))
> +			continue;
> +		if (!strcasecmp(name, (const char *)info.name))
> +			return part;
> +	}

I guess this is basically part_get_info_by_name_case_insensitive() as
fallback to the real part_get_info_by_name() above? Do we actually have
partitions with differing case on some of the phones?

> +
> +	return -ENOENT;
> +}
> +
> [...]
> +static int stemmy_read_radio_addr(struct blk_desc *desc, int part,
> +				  const char *path, u8 *addr)
> +{
> +	char buf[RADIO_ADDR_BUF_SIZE + 1];
> +	loff_t len;
> +	int ret;
> +
> +	ret = fs_set_blk_dev_with_part(desc, part);
> +	if (ret)
> +		return ret;
> +
> +	if (fs_get_type() != FS_TYPE_EXT) {
> +		fs_close();

Do we need the same fs_close() call in any of the other error paths (or
maybe even the success path)?

> +		return -EINVAL;
> +	}
> +
> +	ret = fs_read(path, (ulong)buf, 0, RADIO_ADDR_BUF_SIZE, &len);
> +	if (ret)
> +		return ret;
> +	if (!len || len > RADIO_ADDR_BUF_SIZE)
> +		return -EINVAL;
> +
> +	buf[len] = '\0';
> +
> +	return stemmy_parse_radio_addr(buf, len, addr);
> +}
> +
> +static int stemmy_try_radio_source(struct stemmy_radio_storage *storage,
> +				   const struct stemmy_radio_source *source,
> +				   u8 *addr)
> +{
> +	struct disk_partition info;
> +	int part, ret;
> +
> +	if (!storage->desc)
> +		return -ENODEV;
> +
> +	part = storage->part[source->partition];
> +	if (part >= 0)
> +		return stemmy_read_radio_addr(storage->desc, part, source->path,
> +					      addr);
> +
> +	/* Fall back to locating an unlabeled partition by its contents. */
> +	for (part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
> +		if (part_get_info(storage->desc, part, &info))
> +			continue;

Oh wow, do we have unlabeled partitions on one of the phones even? :o

> +
> +		ret = stemmy_read_radio_addr(storage->desc, part, source->path,
> +					     addr);
> +		if (!ret) {
> +			storage->part[source->partition] = part;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> [...]
> +static void stemmy_fixup_radio_addr(void *fdt,
> +				    struct stemmy_radio_storage *storage,
> +				    const struct stemmy_radio_source *sources,
> +				    size_t count, const char *compatible,
> +				    bool bluetooth)
> +{
> +	const char *property = bluetooth ? "local-bd-address" : "local-mac-address";
> +	const char *name = bluetooth ? "Bluetooth BD" : "WiFi MAC";
> +	u8 addr[ETH_ALEN];
> +	int node, ret, i;
> +
> +	ret = stemmy_find_radio_addr(storage, sources, count, bluetooth, addr);
> +	if (ret) {
> +		printf("Persistent %s missing\n", name);

log_warning()?

> +		return;
> +	}
> +
> +	printf("Persistent %s: %pM\n", name, addr);

log_info()?

> +
> +	node = fdt_node_offset_by_compatible(fdt, -1, compatible);
> +	if (node < 0)
> +		return;
> +
> +	/* local-bd-address uses Bluetooth (least significant byte first) order. */
> +	if (bluetooth) {
> +		for (i = 0; i < ETH_ALEN / 2; i++)
> +			swap(addr[i], addr[ETH_ALEN - i - 1]);
> +	}
> +
> +	ret = fdt_setprop(fdt, node, property, addr, sizeof(addr));
> +	if (!ret)
> +		return;
> +
> +	log_warning("Cannot set %s: %s\n", property, fdt_strerror(ret));
> +}
> +

Thanks,
Stephan

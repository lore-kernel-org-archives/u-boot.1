Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755C0C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 07:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A844987BDB;
	Tue, 30 Jan 2024 08:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gXejulAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381E387C39; Tue, 30 Jan 2024 08:39:16 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DB60875B9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 08:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so13314635e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 23:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706600353; x=1707205153; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+E7CMtUJ8GxQP6QPzm+BVgA/i/C/pDwVetyq4YN7Cto=;
 b=gXejulAKAuPhnNefDKowj9jfg9IxQ+MnXEIQh2y/Y2WQPOM7srIhjvJJ7L3OzeO489
 lZaerqyMQDgL+FOXxY3BmaeZtJLoAaUxrN7xedholvu2jhlq7omXBKhVDOtLUGpJNatD
 7iK1Y8EfQwvhgjLc24AOEGlRKy3WziGcmz3YmcdacnamFq1CoAjW+4DOI8/65bYUTmHk
 eFxMc/mqcx9B9TsGsD5BGx9ALZ4v5dEvgPQwDPS3geYBF9ZIMQvguI3eTccm+az5FXTA
 erJz1GyeicdAWK0M6xo7Hwxiz3W/ZN9wnDVgq0U3PCIELTq1owRFBywMq3w5WrVsbtMI
 6Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706600353; x=1707205153;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+E7CMtUJ8GxQP6QPzm+BVgA/i/C/pDwVetyq4YN7Cto=;
 b=bq4AdGs8H57b+sX/IBd1Wr0HSQ77JlGSiCOWNea/lsJiV8RKGnDoR2WOpz8Npi5sUb
 BTCoGQ9b0skwgrt0kc8WC4aTnalYNqpR+j947AWEW6tlVUrLNqN29W/6+m99jKab0ReL
 FfaxKMo+sfnO/RD1QARlBeLxFpKiurp09d9d2ukWVu02aekU+HP9a2INrKvZymR4NWC4
 UqoAEWzqXUu6sWS99D58JvASKtTlkJyw+Y7IqKVlvtbjRn+VpljzAV7TbWZ1zWyaoMQ0
 yR5bB0+Jdr7byV7GHdpC2fCntByfBMfcEY2tfwuouJaAHhsMq0fly2hkkaaCVcHsPyBs
 j4yA==
X-Gm-Message-State: AOJu0Yz8ptJ5I75lCxxAgtk2acVBu1z5+jSuwWVW0MrN+hapyQsaHYUL
 uzZuSDreEzTkf5qQOc9teJoe81YxJbBKIyDf1xKFUzgiSTLnZsVjW3UHquP/38Y=
X-Google-Smtp-Source: AGHT+IHfeQOCk/T6pX7M2ch3Dlp/XCM9HHhY2gOwZTljV61FTxkyZfj1EhY+kjxnH48EU5AeUV+xzw==
X-Received: by 2002:a05:600c:3b83:b0:40e:ef9f:de89 with SMTP id
 n3-20020a05600c3b8300b0040eef9fde89mr5388744wms.6.1706600353590; 
 Mon, 29 Jan 2024 23:39:13 -0800 (PST)
Received: from localhost ([102.140.209.237]) by smtp.gmail.com with ESMTPSA id
 fj12-20020a05600c0c8c00b0040f02b92e95sm939662wmb.22.2024.01.29.23.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 23:39:13 -0800 (PST)
Date: Tue, 30 Jan 2024 10:39:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 git@xilinx.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: Re: [PATCH v10 1/8] mtd: spi-nor: Add parallel and stacked memories
 support
Message-ID: <2cbba0e2-c048-4adf-a2a4-77d3dd2802b0@moroto.mountain>
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
 <20240130044423.1391251-2-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130044423.1391251-2-venkatesh.abbarapu@amd.com>
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

On Tue, Jan 30, 2024 at 10:14:16AM +0530, Venkatesh Yadav Abbarapu wrote:
> @@ -1444,28 +1465,66 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  {
>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>  	int ret;
> +	u32 offset = from;

Declare offset as loff_t otherwise it's limited to 4GB.  I don't know if
we support more than 4GB here but it's just weird and forces us to add
casts later...

> +	u32 stack_shift = 0;

This variable is never used.

> +	u32 read_len = 0;
> +	u32 rem_bank_len = 0;
> +	u8 bank;
> +	u8 is_ofst_odd = 0;

If you wanted, you could make this bool true/false.

>  
>  	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
>  
> +	if ((nor->flags & SNOR_F_HAS_PARALLEL) && (offset & 1)) {
> +	    /* We can hit this case when we use file system like ubifs */
> +		from = (loff_t)(from - 1);
> +		len = (size_t)(len + 1);

These casts are unnecessary.  Just write:

		from--;
		len++;

> +		is_ofst_odd = 1;
> +	}
> +
>  	while (len) {
> -		loff_t addr = from;
> -		size_t read_len = len;
> +		if (nor->addr_width == 3) {
> +			if (nor->flags & SNOR_F_HAS_PARALLEL) {
> +				bank = (u32)from / (SZ_16M << 0x01);
> +				rem_bank_len = ((SZ_16M << 0x01) *
> +					(bank + 1)) - from;
> +			} else {
> +				bank = (u32)from / SZ_16M;
> +				rem_bank_len = (SZ_16M * (bank + 1)) - from;
> +			}
> +		}

If nor->addr_width != 3 then rem_bank_len is zero and I think we're
going to have a problem...

> +		offset = from;
> +
> +		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			stack_shift = 1;
> +			if (offset >= (mtd->size / 2)) {
> +				offset = offset - (mtd->size / 2);
> +				nor->spi->flags |= SPI_XFER_U_PAGE;
> +			} else {
> +				nor->spi->flags &= ~SPI_XFER_U_PAGE;
> +			}
> +		}
>  
> -#ifdef CONFIG_SPI_FLASH_BAR
> -		u32 remain_len;
> +		if (nor->flags & SNOR_F_HAS_PARALLEL)
> +			offset /= 2;
>  
> -		ret = write_bar(nor, addr);
> -		if (ret < 0)
> -			return log_ret(ret);
> -		remain_len = (SZ_16M * (nor->bank_curr + 1)) - addr;
> +		if (nor->addr_width == 3) {
> +#ifdef CONFIG_SPI_FLASH_BAR
> +			ret = write_bar(nor, offset);
> +			if (ret < 0)
> +				return log_ret(ret);
> +#endif
> +		}
>  
> -		if (len < remain_len)
> +		if (len < rem_bank_len)
>  			read_len = len;
>  		else
> -			read_len = remain_len;
> -#endif
> +			read_len = rem_bank_len;

If rem_bank_len is zero then read_len is zero.

> +
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			goto read_err;
>  
> -		ret = nor->read(nor, addr, read_len, buf);
> +		ret = nor->read(nor, offset, read_len, buf);
>  		if (ret == 0) {
>  			/* We shouldn't see 0-length reads */
>  			ret = -EIO;

When read_len is zero we return -EIO.

> @@ -1474,8 +1533,15 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>  		if (ret < 0)
>  			goto read_err;
>  
> -		*retlen += ret;
> -		buf += ret;
> +		if (is_ofst_odd == 1) {
> +			memcpy(buf, (buf + 1), (len - 1));

This needs to be memmove().  memcpy() is undefined for overlapped
buffers.

> +			*retlen += (ret - 1);
> +			buf += ret - 1;
> +			is_ofst_odd = 0;
> +		} else {
> +			*retlen += ret;
> +			buf += ret;
> +		}
>  		from += ret;
>  		len -= ret;
>  	}

regards,
dan carpenter


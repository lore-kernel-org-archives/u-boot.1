Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3ADE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 16:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CEF280711;
	Mon, 23 Dec 2024 17:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734972734;
	bh=kOD3aOMMebpv9hCRT734uYfWoa1pExVy9fbtjDWvGis=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jJcY+I6JMf+qI3MidEBFUBzocRuoWSWAlUT+iCvZ42ZX02zpyH9bo1XcfqfEQKxiI
	 QL6igxK6vhYu9YnEWGczdCnQjX02WPkSI6lkU3tU1U9C9oV8RqmZAY1Gweuolu9RHe
	 4ondKEU9JRgZmhN9Hl4p01Q3rk3QyKaPxh7kO0k0Weo01Lab25WlB6PqSOE4AZHL3d
	 ni+Ars78wn8lzmj6hwdwRZmOgQ7T+yf7BjlmxJc9leK/CXZXGOCFDsDhWZqJWN9/Az
	 vKuA9t+vcBhmKbgRXK4Pcm3lB4+U07ejxLc/C8egliFyt0iiwY/ba3F3HrXNMcbF6H
	 T5aKZEPqrZBUg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 699D080714; Mon, 23 Dec 2024 17:52:13 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D31806FC
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 17:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="PrsVIzMV"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AE5E1040DBC5; Mon, 23 Dec 2024 17:52:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734972729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOD3aOMMebpv9hCRT734uYfWoa1pExVy9fbtjDWvGis=;
 b=PrsVIzMVMk6jJ26C1xci1Vmxg9LlYydaQqYEep0IMW1NWK7Ry4vY5XfD/qWpvW1Nsk6/lN
 7FwlDrllXooEkE4kWvUtAIsUqW1hVeL8RaWh2uDqeoOqw2dVhP+8Hwt1D2cY0o+wC/htDz
 VC3y/7mJUg30sH4sjxAmAJExoVcdjCmluc+tajUTJn8MwmFFiGcG5d0aCdihdQdEJWD/R1
 fm1UyR75irtzNEHR4R7BYErhjq39ZsS3WKngTwNvsJ2LkEZZU2hHjpnU4ANochQvwIgNFI
 LSVZngsO74VnMKVnwhWWcdu22fg4iYMuSfw0kfsJYoUmsC+nW4Tvs9VPRJForw==
Message-ID: <63291d8d-ca66-4e8a-a9aa-efba47a1f505@denx.de>
Date: Mon, 23 Dec 2024 17:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
References: <20241220143006.1921705-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241220143006.1921705-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/20/24 3:30 PM, Venkatesh Yadav Abbarapu wrote:

[...]

> @@ -1578,8 +1580,8 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>   	int ret;
>   	loff_t offset = from;
> -	u32 read_len = 0;
>   	u32 rem_bank_len = 0;
> +	u32 stack_shift = 0;
>   	u8 bank;
>   	bool is_ofst_odd = false;
>   
> @@ -1593,18 +1595,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	}
>   
>   	while (len) {
> -		bank = (u32)from / SZ_16M;
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			bank /= 2;
> -
> -		rem_bank_len = SZ_16M * (bank + 1);
> -		if (nor->flags & SNOR_F_HAS_PARALLEL)
> -			rem_bank_len *= 2;
> -		rem_bank_len -= from;
> -
> +		size_t read_len = len;

size_t read_len should be declared at the beginning of this function.

>   		offset = from;
>   
> +	if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {

The indent here needs to be pushed on tab RIGHT -> .

Do you need this functionality in SPL ? If so, you might need a matching 
Kconfig SPL_SPI_STACKED_PARALLEL symbol .

> +		if (nor->addr_width == 3) {
> +			bank = (u32)from / SZ_16M;
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				bank /= 2;
> +
> +			rem_bank_len = SZ_16M * (bank + 1);
> +			if (nor->flags & SNOR_F_HAS_PARALLEL)
> +				rem_bank_len *= 2;
> +			rem_bank_len -= from;
> +		}
> +
>   		if (nor->flags & SNOR_F_HAS_STACKED) {
> +			stack_shift = 1;
>   			if (offset >= (mtd->size / 2)) {
>   				offset = offset - (mtd->size / 2);
>   				nor->spi->flags |= SPI_XFER_U_PAGE;
> @@ -1613,20 +1620,31 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>   			}
>   		}
>   
> +		if (nor->addr_width == 4)
> +			rem_bank_len = (mtd->size >> stack_shift) - offset;
> +
>   		if (nor->flags & SNOR_F_HAS_PARALLEL)
>   			offset /= 2;
> +	}
>   
>   #ifdef CONFIG_SPI_FLASH_BAR
> +		u32 remain_len;
> +
>   		ret = write_bar(nor, offset);
>   		if (ret < 0)
>   			return log_ret(ret);
> -#endif
> -
> -		if (len < rem_bank_len)
> +		remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;

Is this calculation correct?

It used to be calculated as:

bank = (u32)from / SZ_16M;
rem_bank_len = SZ_16M * (bank + 1);
rem_bank_len -= from;

Now the bank is calculated as:

bank = nor->bank_curr + 1;

?

Why not keep calculating bank from offset ?

Maybe this will work ?

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 691962ef271..bdfbd44f30c 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1578,10 +1578,11 @@ static int spi_nor_read(struct mtd_info *mtd, 
loff_t from, size_t len,
  			size_t *retlen, u_char *buf)
  {
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
-	int ret;
  	loff_t offset = from;
  	u32 rem_bank_len = 0;
  	u32 stack_shift = 0;
+	size_t read_len;
+	int ret;
  	u8 bank;
  	bool is_ofst_odd = false;

@@ -1595,7 +1596,7 @@ static int spi_nor_read(struct mtd_info *mtd, 
loff_t from, size_t len,
  	}

  	while (len) {
-		size_t read_len = len;
+		read_len = len;
  		offset = from;

  		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
@@ -1627,24 +1628,24 @@ static int spi_nor_read(struct mtd_info *mtd, 
loff_t from, size_t len,
  				offset /= 2;
  		}

-#ifdef CONFIG_SPI_FLASH_BAR
-		u32 remain_len;
+		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR)) {
+			bank = (u32)from / SZ_16M;
+			rem_bank_len = SZ_16M * (bank + 1);
+			rem_bank_len -= from;

  			ret = write_bar(nor, offset);
  			if (ret < 0)
  				return log_ret(ret);
-		remain_len = (SZ_16M * (nor->bank_curr + 1)) - offset;
-		if (len < remain_len)
-			read_len = len;
-		else
-			read_len = remain_len;
-#endif
-		if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
+		}
+
+		if (CONFIG_IS_ENABLED(SPI_FLASH_BAR) ||
+		    CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
  			if (len < rem_bank_len)
  				read_len = len;
  			else
  				read_len = rem_bank_len;
  		}
+
  		if (read_len == 0)
  			return -EIO;

I am still worried about using stacked parallel and BAR together, is 
that even possible or are they mutually exclusive ?

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D1C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 15:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2E087102;
	Sun, 29 Oct 2023 16:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698592190;
	bh=aMjAojErgLTqZ1v7dOg1JMNGlKE7uuYEe5lg2s8CQGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v6hAD66sfLcRMEHw77AYiDE4kZXEUpVEYjsUwbr+v4A3iLq0ZuYoFnNFQTRz3rJRe
	 yfv30d4OFq/v25kQ61/hE9AWmax0d7iWThdPnf0fwDj1E1kK22QiUTLKoAGD+gSPln
	 3lkb5CSu5oMkCKWyRi6RL9xMoo4Y7j67udy/shsqFm+6ibmaZ1bqRqCq7tpvSO5jvb
	 18rTJFFa8NMfZKcmC8wW//oUsWTiKSPS/rllzveMG8DAK5gpRO1AW2TLfVoIJjStwI
	 1kZMtJ2s9YlzYQeJvuFxa5v/ax55deJtnXsASt86C/C4UMbN0XAvSTft+03kQqYGiP
	 6ZABam5YK/M/g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 35A5C878E9;
 Sun, 29 Oct 2023 16:09:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698592183;
 bh=aMjAojErgLTqZ1v7dOg1JMNGlKE7uuYEe5lg2s8CQGM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=yxYn2ZCb60Ie6K/WRus2X7njqFiel10cTntNwjMgBcIaEaDcYGdQQSvzkTGJjF0Cm
 OKbIbMCwlWMw8jbNSfmKW6J2J+4hz3Y9lTb82HHFzZxN3VDELX4F6XxIoHkpAKSn3L
 zCokrnq8qwxz2YEXcf/ZI3nx9stJFotjwhWWhR7w34p66Fa6p9AJXR7SnUaUtt7dYo
 SebiFME1BZWrvIf0X2ZXjZ64nBUrTVBsGd4RMK0QHlznt6OtcpwAV9AQsx5iPPi6z8
 lImMgG5vTEGanP9MM2HwyKGWweHdIAVWmyEuruaqV3NvodZQtxlLIYhTyLiLT2Ckp6
 uyjKTsp8m4oYQ==
Message-ID: <c3cfba5e-46cb-4fec-8e0d-b8aa1b9c0098@denx.de>
Date: Sun, 29 Oct 2023 13:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] usb: storage: Implement 64-bit LBA support
Content-Language: en-US
To: Hector Martin <marcan@marcan.st>, Bin Meng <bmeng.cn@gmail.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 u-boot@lists.denx.de, asahi@lists.linux.dev
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
 <20231029-usb-fixes-3-v1-4-0153210a7f55@marcan.st>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231029-usb-fixes-3-v1-4-0153210a7f55@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/29/23 08:23, Hector Martin wrote:
> This makes things work properly on devices with >= 2 TiB
> capacity. If u-boot is built without CONFIG_SYS_64BIT_LBA,
> the capacity will be clamped at 2^32 - 1 sectors.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>   common/usb_storage.c | 132 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 114 insertions(+), 18 deletions(-)
> 
> diff --git a/common/usb_storage.c b/common/usb_storage.c
> index 95507ffbce48..3035f2ee9868 100644
> --- a/common/usb_storage.c
> +++ b/common/usb_storage.c
> @@ -66,7 +66,7 @@
>   static const unsigned char us_direction[256/8] = {
>   	0x28, 0x81, 0x14, 0x14, 0x20, 0x01, 0x90, 0x77,
>   	0x0C, 0x20, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01,
> +	0x00, 0x01, 0x00, 0x40, 0x00, 0x01, 0x00, 0x01,

What changed here ?

>   	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>   };
>   #define US_DIRECTION(x) ((us_direction[x>>3] >> (x & 7)) & 1)
> @@ -1073,6 +1073,27 @@ static int usb_read_capacity(struct scsi_cmd *srb, struct us_data *ss)
>   	return -1;
>   }

[...]

> +#ifdef CONFIG_SYS_64BIT_LBA

Could you try and use CONFIG_IS_ENABLED() ?

> +	if (capacity == 0x100000000) {
> +		if (usb_read_capacity64(pccb, ss) != 0) {
> +			puts("READ_CAP64 ERROR\n");
> +		} else {
> +			debug("Read Capacity 64 returns: 0x%08x, 0x%08x, 0x%08x\n",
> +			      cap[0], cap[1], cap[2]);
> +			capacity = be64_to_cpu(*(uint64_t *)cap) + 1;
> +			blksz = be32_to_cpu(cap[2]);
> +		}
> +	}
> +#else
> +	/*
> +	 * READ CAPACITY will return 0xffffffff when limited,
> +	 * which wraps to 0 with the +1 above
> +	 */
> +	if (!capacity) {
> +		puts("LBA exceeds 32 bits but 64-bit LBA is disabled.\n");
> +		capacity = ~0;
> +	}
>   #endif


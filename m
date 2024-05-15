Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA6C04FFE
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 00:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D9388168;
	Wed, 15 May 2024 02:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715734208;
	bh=043oQKfy0iVb1/FoBgKL65PCAo9lGcvj/sKNvHWkTac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rAwLbGTkCpghx50mbf74ClRBz1V2Vn3KuaaA3/PBI19Ykybp7O2Cs+GEIICUFcCky
	 ltk5vJo45fgnFITHKWot5IaeeZtmvuIQh0sxXViXGnjh+LlTVxItWbyg/0G84qPFIV
	 toOBxsw0eYCXsep1pWVc7CebqT3dnqdKg5KXmRECip4lDwTqRUP0heDOcHKwDlO5Ks
	 Q4izglg5t6ZM31LWeumeTwH1F6ZMU/CU8FC5G8e5WmfVa8xclMjkFZxjDfK1w7ymXP
	 +mFqc5EI/lYbNIiJwVgeOJT0DplyTXM68RnNtBFR2A5+CRGK6tIntaxtF9C0GnFHva
	 huVQRwd8Voz6w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 015D487666;
 Wed, 15 May 2024 02:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715734206;
 bh=043oQKfy0iVb1/FoBgKL65PCAo9lGcvj/sKNvHWkTac=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BBs3Gj4YZZkVuNUic8n7keb1FwO89OA918h9Gk2Ahyzj0aPvTUKFG2qpQRrxQJZ2/
 wof+uTsZcuUR364WtKOcoDAOuf5G/wRvCBDb2bgyAjoFuKeYCkGAL/7DJnm66PSGrw
 F2IH6phw3I5ycavwhiOoGFtybOltQ3hk9q64NJFYqkW+RhsTnyhT32BcsyEQUAz1Vt
 0ffURpAJVEyaSRVqegNO+7UaEHXVsduLJtW4FpG7Dhz5At33n8Z0+ybg0HfIrFP056
 M1zFKNaBOqdoCR1+Tnidi7NcUk60/0CiNij3hbNSPYuCsj2+7zd170DztaGiFKwwA9
 xnHNfp+13ZNrQ==
Message-ID: <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
Date: Wed, 15 May 2024 02:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20240515002248.2920155-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240515002248.2920155-1-tharvey@gateworks.com>
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

On 5/15/24 2:22 AM, Tim Harvey wrote:
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.

Thanks for working on this one, this is really nice.

> If we have DM_RNG enabled poulate this value automatically when
> fdt_chosen is called.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   boot/fdt_support.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 874ca4d6f5af..cd3069baf450 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -7,10 +7,12 @@
>    */
>   
>   #include <abuf.h>
> +#include <dm.h>
>   #include <env.h>
>   #include <log.h>
>   #include <mapmem.h>
>   #include <net.h>
> +#include <rng.h>
>   #include <stdio_dev.h>
>   #include <dm/ofnode.h>
>   #include <linux/ctype.h>
> @@ -300,6 +302,27 @@ int fdt_chosen(void *fdt)
>   	if (nodeoffset < 0)
>   		return nodeoffset;
>   
> +	if (IS_ENABLED(CONFIG_DM_RNG)) {
> +		struct udevice *dev;
> +		size_t len = 0x8;
> +		u64 *data;
> +
> +		data = malloc(len);

Can you allocate this 8 byte array on stack , i.e. u64 data[2]; ?

cmd/kaslrseed.c could use similar clean up (and 
lib/efi_loader/efi_dt_fixup.c and boot/pxe_utils.c ... uhhh). Maybe you 
can deduplicate this functionality into common code shared by all those 
duplicates before the duplication gets out of control ?

lib/kaslrseed.c looks like a good place to put the common stuff.

> +		if (!data)
> +			return -ENOMEM;
> +
> +		err = uclass_get_device(UCLASS_RNG, 0, &dev);
> +		if (!err)
> +			err = dm_rng_read(dev, data, len);
> +		if (!err)
> +			err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", data, len);
> +		if (err < 0) {
> +			printf("WARNING: could not set kaslr-seed %s.\n",
> +			       fdt_strerror(err));
> +			return err;
> +		}

You're missing free() here, but it shouldn't be needed if you allocate 
the array on stack, which is better/simpler.

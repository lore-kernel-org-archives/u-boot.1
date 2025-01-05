Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B39CE77198
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C7880642;
	Sun,  5 Jan 2025 23:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115155;
	bh=yT3vLQw7wHSRZOx1mMjr8cAfJwaMLuPhX6PkqkqKoxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YHptbdyfa1+xI4qfWU+ngQu+uLD06A/UslBtA2jw6FVF2UGn32M3JDKqwffzTiW9i
	 MCv4l+GPR3CHtn8QIhZeVoV7a9R2B9e5sWox4lmJgJYYgfsMwWkAH0HgLYeV+2zpx1
	 IaOBysY4tebCFIEhAui4u5C/gB2oGRt/vhZ3LRo+ohwB27CA5CLWIlMgmDEci6Ye+Z
	 tEzcTpv3XilGxuU9danpep2/jVW8iTJwpW3y4hd104A8tfx1HhtroyGfOTvLoPqakW
	 P1gzikpE1PIOOyi8iZRJup35DYDSYB4dC5OH44QjjEDtm+kua0k9AgVH8KeLMmKgmB
	 PGFjfGazSKvww==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BCC4801CE; Sun,  5 Jan 2025 23:12:33 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8AC80602
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iGSLqieI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6B30E101ECBB3; Sun,  5 Jan 2025 23:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yT3vLQw7wHSRZOx1mMjr8cAfJwaMLuPhX6PkqkqKoxQ=;
 b=iGSLqieILj+O0lAaMPLFHJCIbRZbXMDlkm3WyIYw5sOdU9kfKXp7PZOTG+thAXxfOXjL/I
 lZwjrgVHF53nRtTMfQ8bqgIuOPU9MFi7tSFLQE/T3Rk+M+FrA6xQ46qvhBq+NiKctBGqyy
 hCvNvOvXhBee2XAr1BXZqNJPRj8dnAlCDhQLEgk8aBirbfbPWEEMkz4vNoNTHTdQCS/zCL
 mNZVjksQHtovEh0cwLK2gQlTpoc232sqCtfCncQDPcO686WlKHKRMdbZfTSXl/WMYWOOOA
 cGnoEZGrH8NGnPmjHUncoPn+WpaVOxV0srF8mSgPwr6kRhU/D2xARVxesvPajg==
Message-ID: <65087384-d517-4671-b808-912aa0368804@denx.de>
Date: Sun, 5 Jan 2025 22:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] tools: imx8image: add i.MX95 support
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-15-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-15-6744df5dc020@oss.nxp.com>
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> i.MX95 uses binman to invoke mkimage to create image container. 2 image
> containers are needed currently. The first one is composed of
> ahab-container.img, LPDDR firmware images, OEI images, System Manager
> image and u-boot-spl.bin. The second one is comsisted of ARM Trusted
> firmware and u-boot.bin.
> 
> Because DDR OEI image and LPDDR firmware images have to be packaged
> together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
> not check if m33-oei-ddrfw.bin exists.
> 
> When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
> delete the line for u-boot.bin in container.cfg. In fact, binman is
> always called after the u-boot.bin is built, so imx9_image.sh does not
> check if u-boot.bin exists.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

[...]

> @@ -227,12 +234,16 @@ typedef struct {
>   #define CORE_CA35       4
>   #define CORE_CA72       5
>   #define CORE_SECO       6
> +#define CORE_M33        7
>   
>   #define CORE_ULP_CM33		0x1
>   #define CORE_ULP_CA35		0x2
>   #define CORE_ULP_UPOWER 	0x4
>   #define CORE_ULP_SENTINEL 	0x6
>   
> +#define CORE_IMX95_M33P        0U
> +#define CORE_IMX95_A55C0       2U

Drop the trailing U from the constant.

>   #define SC_R_OTP	357U
>   #define SC_R_DEBUG	354U
>   #define SC_R_ROM_0	236U

[...]

> @@ -586,8 +639,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
>   			meta = IMAGE_A53_DEFAULT_META(custom_partition);
>   		} else if (soc == QM && core == CORE_CA72) {
>   			meta = IMAGE_A72_DEFAULT_META(custom_partition);
> -		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
> +		} else if ((soc == ULP) && core == CORE_CA35) {
>   			meta = 0;
> +		} else if ((soc == IMX9) && core == CORE_CA35) {

Should this be CORE_CA55 ?

> +			meta = CORE_IMX95_A55C0;
>   		} else {
>   			fprintf(stderr,
>   				"Error: invalid AP core id: %" PRIu64 "\n",

[...]

> -static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
> +static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
>   {
>   	image_t *img_sp = image_stack;
>   	/*8K total container header*/
>   	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
>   	FILE *fd = NULL;
> -	flash_header_v3_t header;
> +	flash_header_v3_t *header;
> +	flash_header_v3_t *header2;
> +	void *p;
>   	int ret;
>   
> +	p = calloc(1, SZ_4K);

Can this be simply reserved on stack ?

[...]

> diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
> index ca78a57a19a06ade4792da6d2435cbc4fa07de62..6523d1a0ad109db2da29bae122a20b084c2522ed 100755
> --- a/tools/imx9_image.sh
> +++ b/tools/imx9_image.sh
> @@ -18,6 +18,14 @@ for f in $blobs; do
>   		continue
>   	fi
>   
> +	if [ $f = "m33-oei-ddrfw.bin" ]; then
> +		continue
> +	fi
Can this be wired into binman somehow instead ?

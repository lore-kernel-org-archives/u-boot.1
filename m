Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38442C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 18:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4CE86429;
	Wed, 23 Aug 2023 20:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692814017;
	bh=LSJiSGP/bulY0gyAutr2OZ4P8F8pPlT+coyglAe5VZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lmMJUy3cm/zmt2/GwB5prigurFL/KcDJEObCqXIJmGP7FEt8wUczGw4GK5zla2VLv
	 1WMckkh39BVd059rCmDTlt4oCQR8NRDEw4QjVSl0LiJf0nl4bPyHqLtBieY3JyODhy
	 oBDnAQcrO4H6xHUkKrPSAJxROvvXCwJGz+xugAEuakpwMK6GXqPFqDzhX2rhtOeLOC
	 HId/Bx5KOq0i6Gf+aqvDiWtJI7KjOOQRM4HT6KVvf7ralLz8qND2HHOHI6G/NA/xUy
	 s7KN0kUcC60AUAGj4W61o+uAHaMAtBM7FLUbts8so9SQ1QBEV7KIsZBeiyyD8yIDjz
	 I0I0flg2L+hPg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 29C0385DD2;
 Wed, 23 Aug 2023 20:06:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692814016;
 bh=LSJiSGP/bulY0gyAutr2OZ4P8F8pPlT+coyglAe5VZM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k2EV6LcQNy84s5iTpw+PpxAuec3dNk72doBdKyR1HSIEaJjjheUeLPuOtUXR1jtqT
 gaR8XqrZhEnvY0HZRRvm/PxYq5Dd/SlDJcxPy6Xruh27rYASPp8/tizIaPCE4YOp8x
 efX017l0yzbYpUReRY7XAab+1QhH8TWw7INJOg+KlQsAajKjZu57YvKDpqlQ/Y7L/R
 /jP/RE7u6o87ZSv/gs51eFCo7ooKRRfDkog+ppGt98k45896ahVkGSNIompuKbXf7E
 rfU2OEQbc+rrIqSEW6b2exJfqCf+ea2OBPC7bHdJJZjYKoZQoTqXtBYv19nxIue5ck
 HydxGruTIlFIQ==
Message-ID: <40263db2-e42a-4997-ddcc-7a1ea7d44d31@denx.de>
Date: Wed, 23 Aug 2023 20:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tools: ensure zeroed padding in external FIT images
Content-Language: en-US
To: Roman Azarenko <roman.azarenko@iopsys.eu>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Massimo Pegorer <massimo.pegorer@vimar.com>, Tom Rini <trini@konsulko.com>
References: <20230823121417.270511-1-roman.azarenko@iopsys.eu>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823121417.270511-1-roman.azarenko@iopsys.eu>
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

On 8/23/23 14:14, Roman Azarenko wrote:
> Padding the header of an external FIT image is achieved by growing the
> existing temporary FIT file to match the given alignment requirement
> before appending image data. Reusing an existing file this way means
> that the padding will likely contain a portion of the original data not
> overwritten by the new header.
> 
> Truncate the temporary FIT file to unpadded header length first, so
> that the subsequent truncate operation extends the file with null
> bytes, making padding predictably zeroed.
> 
> Fixes: 7946a814a319 ("Revert "mkimage: fit: Do not tail-pad fitImage with external data"")
> Signed-off-by: Roman Azarenko <roman.azarenko@iopsys.eu>
> ---
> This fix was prompted by an observation that there is unexpected data
> in the padding between the FIT header and the first image in a
> generated external FIT file.
> 
> Having non-zero data in padding doesn't have any negative practical
> consequences, these FIT files work fine just like any other. However
> I'm not aware of any reason of making the padding depend on the
> contents of an internal/intermediate FIT file. In my opinion, padding
> should be predictably zeroed.
> 
> Steps to reproduce:
> 
> 1. Generate a random binary blob representing a fake rootfs image:
> 
> 	$ dd if=/dev/urandom of=rootfs bs=1M count=1
> 
> 2. Define a minimalistic FIT source file:
> 
> 	/dts-v1/;
> 	/ {
> 		description = "Padding demo";
> 		#address-cells = <0x01>;
> 		images {
> 			rootfs {
> 				data = /incbin/("rootfs");
> 				type = "filesystem";
> 				compression = "none";
> 				hash-1 {
> 					algo = "sha256";
> 				};
> 			};
> 		};
> 
> 		configurations {
> 			default = "config";
> 
> 			config {
> 				rootfs = "rootfs";
> 			};
> 		};
> 	};
> 
> 3. Build an external FIT image with 4096 bytes of padding:
> 
> 	$ mkimage -f source.dts -E -B 1000 output.dtb
> 
> Observe how the header is padded to 4096 bytes (0x1000) with a part of
> an existing dummy rootfs image, which happened to be in that place in
> the internal/intermediate FIT file.
> ---
>   tools/fit_image.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 9fe69ea0d9f8..7a7b68f96ed8 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -497,7 +497,7 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>   {
>   	void *buf = NULL;
>   	int buf_ptr;
> -	int fit_size, new_size;
> +	int fit_size, unpadded_size, new_size;
>   	int fd;
>   	struct stat sbuf;
>   	void *fdt;
> @@ -564,14 +564,15 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>   	/* Pack the FDT and place the data after it */
>   	fdt_pack(fdt);
>   
> -	new_size = fdt_totalsize(fdt);
> -	new_size = ALIGN(new_size, align_size);
> +	unpadded_size = fdt_totalsize(fdt);
> +	new_size = ALIGN(unpadded_size, align_size);
>   	fdt_set_totalsize(fdt, new_size);
>   	debug("Size reduced from %x to %x\n", fit_size, fdt_totalsize(fdt));
>   	debug("External data size %x\n", buf_ptr);
>   	munmap(fdt, sbuf.st_size);
>   
> -	if (ftruncate(fd, new_size)) {
> +	/* Truncate to unpadded size first to ensure zero-filled padding */
> +	if (ftruncate(fd, unpadded_size) || ftruncate(fd, new_size)) {
>   		debug("%s: Failed to truncate file: %s\n", __func__,
>   		      strerror(errno));
>   		ret = -EIO;

Can we use memset and zero out the trailing part of the buffer instead ?

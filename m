Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D59C35FF0
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6428188D52;
	Tue, 17 Sep 2024 10:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G02xymGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366B888D52; Tue, 17 Sep 2024 10:08:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C332588D54
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48H88Zg5087070;
 Tue, 17 Sep 2024 03:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726560515;
 bh=kcbCAP3bp1Ra5lrUSsEwVRSxBXhuaMR+1Nt/Ggrbqgo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=G02xymGhe+XkdjHYd1devXxoHfaYQ9CwmMd44SMO/Sia6gMxwZT5qavVE3/j3CGwI
 SzIbAivr5Ny42WBFpEb5wmTeAx8QDvviHzHT0gyjVqJqu2OQJjAVi6GoP0L42wZ8hj
 iWmtT+yW1m5pfftwIMVQThX21cE7bsOvrBj6GAkc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48H88ZIP022274
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Sep 2024 03:08:35 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Sep 2024 03:08:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Sep 2024 03:08:35 -0500
Received: from [10.24.69.142] ([10.24.69.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48H88XwQ075537;
 Tue, 17 Sep 2024 03:08:33 -0500
Message-ID: <9b62de2e-2a30-4ff3-889a-23b64a9ed866@ti.com>
Date: Tue, 17 Sep 2024 13:38:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tftp: rework the logic to validate the load address
To: Sughosh Ganu <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
 <20240916152025.75789-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240916152025.75789-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 16/09/24 20:50, Sughosh Ganu wrote:
> Use the lmb_read_check() function to verify if it is safe to use a
> region of memory to load data from a tftp command. The current logic
> checks the amount of free memory available, starting from the 'load
> address'. This call fails if the same region of memory has been used
> earlier. This used to work earlier as the LMB memory map had a local
> scope and was not persistent. Fix this issue by using the
> lmb_read_check() call instead which only returns an error in case the
> memory region has been marked for not allowing re-use.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> 
> Note: To be applied on next, on top of
> https://patchwork.ozlabs.org/project/uboot/patch/20240913073251.2286529-2-prasad.kummari@amd.com/
> 

Tested-by: Vaishnav Achath <vaishnav.a@ti.com>

>   net/tftp.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/net/tftp.c b/net/tftp.c
> index b5d227d8bc..d6744bc24e 100644
> --- a/net/tftp.c
> +++ b/net/tftp.c
> @@ -82,7 +82,6 @@ static ulong	tftp_block_wrap;
>   static ulong	tftp_block_wrap_offset;
>   static int	tftp_state;
>   static ulong	tftp_load_addr;
> -static ulong	tftp_load_size;
>   #ifdef CONFIG_TFTP_TSIZE
>   /* The file size reported by the server */
>   static int	tftp_tsize;
> @@ -159,13 +158,8 @@ static inline int store_block(int block, uchar *src, unsigned int len)
>   	void *ptr;
>   
>   	if (CONFIG_IS_ENABLED(LMB)) {
> -		ulong end_addr = tftp_load_addr + tftp_load_size;
> -
> -		if (!end_addr)
> -			end_addr = ULONG_MAX;
> -
>   		if (store_addr < tftp_load_addr ||
> -		    store_addr + len > end_addr) {
> +		    lmb_read_check(store_addr, len)) {
>   			puts("\nTFTP error: ");
>   			puts("trying to overwrite reserved memory...\n");
>   			return -1;
> @@ -712,19 +706,8 @@ static void tftp_timeout_handler(void)
>   	}
>   }
>   
> -/* Initialize tftp_load_addr and tftp_load_size from image_load_addr and lmb */
>   static int tftp_init_load_addr(void)
>   {
> -	if (CONFIG_IS_ENABLED(LMB)) {
> -		phys_size_t max_size;
> -
> -		max_size = lmb_get_free_size(image_load_addr);
> -		if (!max_size)
> -			return -1;
> -
> -		tftp_load_size = max_size;
> -	}
> -
>   	tftp_load_addr = image_load_addr;
>   	return 0;
>   }

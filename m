Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E090EC35FF1
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 08:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0462E88CDC;
	Tue, 17 Sep 2024 10:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r+x5rPuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE2E88D0F; Tue, 17 Sep 2024 10:08:21 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BBB881E7
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48H88E98073648;
 Tue, 17 Sep 2024 03:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726560494;
 bh=H9KI+XbIOVQ5EW16uCZkiKT6aZle1yJEeUCPDToumqg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=r+x5rPuorcsxg1CWk0dpes1Ca54B63MbU8mPDzFQ77OmFUftr7P/jSu5biVHdS24F
 grW2Lj/DQr2rwCprucyGMcnLmKKU9vC0Ao/JM27uR0cA5sXcHTtL/UZLfgnf+NqVIS
 odkjbHcKDY6uyRX2qqLc2bDO4ceMKcZKKOw4nfQI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48H88EZK105239;
 Tue, 17 Sep 2024 03:08:14 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Sep 2024 03:08:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Sep 2024 03:08:14 -0500
Received: from [10.24.69.142] ([10.24.69.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48H88BfP087258;
 Tue, 17 Sep 2024 03:08:12 -0500
Message-ID: <a5e8da60-7980-4a99-b0eb-b67fe45edc20@ti.com>
Date: Tue, 17 Sep 2024 13:38:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wget: rework the logic to validate the load address
To: Sughosh Ganu <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, Joe
 Hershberger <joe.hershberger@ni.com>
References: <20240916152025.75789-1-sughosh.ganu@linaro.org>
 <20240916152025.75789-3-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240916152025.75789-3-sughosh.ganu@linaro.org>
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
> region of memory to load data from the wget command. The current logic
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

>   net/wget.c | 36 +-----------------------------------
>   1 file changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/net/wget.c b/net/wget.c
> index 4a168641c6..a88c31f236 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -64,26 +64,6 @@ static unsigned int retry_tcp_ack_num;	/* TCP retry acknowledge number*/
>   static unsigned int retry_tcp_seq_num;	/* TCP retry sequence number */
>   static int retry_len;			/* TCP retry length */
>   
> -static ulong wget_load_size;
> -
> -/**
> - * wget_init_max_size() - initialize maximum load size
> - *
> - * Return:	0 if success, -1 if fails
> - */
> -static int wget_init_load_size(void)
> -{
> -	phys_size_t max_size;
> -
> -	max_size = lmb_get_free_size(image_load_addr);
> -	if (!max_size)
> -		return -1;
> -
> -	wget_load_size = max_size;
> -
> -	return 0;
> -}
> -
>   /**
>    * store_block() - store block in memory
>    * @src: source of data
> @@ -97,13 +77,8 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>   	uchar *ptr;
>   
>   	if (CONFIG_IS_ENABLED(LMB)) {
> -		ulong end_addr = image_load_addr + wget_load_size;
> -
> -		if (!end_addr)
> -			end_addr = ULONG_MAX;
> -
>   		if (store_addr < image_load_addr ||
> -		    store_addr + len > end_addr) {
> +		    lmb_read_check(store_addr, len)) {
>   			printf("\nwget error: ");
>   			printf("trying to overwrite reserved memory...\n");
>   			return -1;
> @@ -493,15 +468,6 @@ void wget_start(void)
>   	debug_cond(DEBUG_WGET,
>   		   "\nwget:Load address: 0x%lx\nLoading: *\b", image_load_addr);
>   
> -	if (CONFIG_IS_ENABLED(LMB)) {
> -		if (wget_init_load_size()) {
> -			printf("\nwget error: ");
> -			printf("trying to overwrite reserved memory...\n");
> -			net_set_state(NETLOOP_FAIL);
> -			return;
> -		}
> -	}
> -
>   	net_set_timeout_handler(wget_timeout, wget_timeout_handler);
>   	tcp_set_tcp_handler(wget_handler);
>   

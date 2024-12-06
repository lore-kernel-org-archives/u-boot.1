Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633BCE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 07:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E25888913F;
	Fri,  6 Dec 2024 08:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dULDOys1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E9D8917E; Fri,  6 Dec 2024 08:55:54 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4110E89078
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 08:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B67tlrv012314;
 Fri, 6 Dec 2024 01:55:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733471747;
 bh=Q3jop9uk0xi5npa3oYkCc3X6ERtd7X8ShSIB6e8RXHY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dULDOys1EXLfm+Mm6UUsR4Oiijab6Lhkt7X73YiTqJRG3cmqg7FVSyTWz9t8A4ymW
 5+jhqdOdAoh5UiF43ZliqdIfO3zBJ/RQZF45V6YtUkrqjfkc+r793hW3G12J3quAvH
 YgQZUZnmq4PCDVEIExlMsIhx5CCK4FR4ddQuiNJE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B67tl01018815
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 6 Dec 2024 01:55:47 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 01:55:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 01:55:47 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B67tiFZ082885;
 Fri, 6 Dec 2024 01:55:45 -0600
Message-ID: <5461b278-59ed-4ee5-a100-5cdf08f3df19@ti.com>
Date: Fri, 6 Dec 2024 13:25:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ufs: core: mark unexported functions as static
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>, <u-boot@lists.denx.de>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-2-a5cef54b1cdc@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-2-a5cef54b1cdc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 20/11/24 14:52, Neil Armstrong wrote:
> Mark the remaining local functions as static to avoid build
> warnings.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 31c2959aeb12931b2bbdf26b3c676ae1a7b0fd1a..8a6c9f1e40b058dfd29bc07d011d576cdfc504cb 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -1035,8 +1035,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
>   /**
>    * ufshcd_query_flag() - API function for sending flag query requests
>    */
> -int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> -		      enum flag_idn idn, bool *flag_res)
> +static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
> +			     enum flag_idn idn, bool *flag_res)
>   {
>   	struct ufs_query_req *request = NULL;
>   	struct ufs_query_res *response = NULL;
> @@ -1171,9 +1171,9 @@ out:
>   /**
>    * ufshcd_query_descriptor_retry - API function for sending descriptor requests
>    */
> -int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
> -				  enum desc_idn idn, u8 index, u8 selector,
> -				  u8 *desc_buf, int *buf_len)
> +static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
> +					 enum desc_idn idn, u8 index, u8 selector,
> +					 u8 *desc_buf, int *buf_len)
>   {
>   	int err;
>   	int retries;
> @@ -1265,8 +1265,8 @@ static void ufshcd_init_desc_sizes(struct ufs_hba *hba)
>    * ufshcd_map_desc_id_to_length - map descriptor IDN to its length
>    *
>    */
> -int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
> -				 int *desc_len)
> +static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
> +					int *desc_len)

Isn't ufshcd_map_desc_id_to_length exported?

>   {
>   	switch (desc_id) {
>   	case QUERY_DESC_IDN_DEVICE:
> @@ -1309,9 +1309,9 @@ EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
>    * ufshcd_read_desc_param - read the specified descriptor parameter
>    *
>    */
> -int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> -			   int desc_index, u8 param_offset, u8 *param_read_buf,
> -			   u8 param_size)
> +static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
> +				  int desc_index, u8 param_offset,
> +				  u8 *param_read_buf, u8 param_size)
>   {
>   	int ret;
>   	u8 *desc_buf;
> @@ -1570,8 +1570,8 @@ static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
>    * ufshcd_read_string_desc - read string descriptor
>    *
>    */
> -int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
> -			    u8 *buf, u32 size, bool ascii)
> +static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
> +				   u8 *buf, u32 size, bool ascii)
>   {
>   	int err = 0;
>   
> @@ -1882,7 +1882,7 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
>   	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
>   }
>   
> -int ufs_start(struct ufs_hba *hba)
> +static int ufs_start(struct ufs_hba *hba)
>   {
>   	struct ufs_dev_desc card = {0};
>   	int ret;
> 

-- 
Thanking You
Neha Malcom Francis

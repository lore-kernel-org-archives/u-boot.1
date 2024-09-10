Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E08ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D05588F41;
	Tue, 10 Sep 2024 12:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v0y/Ursk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA7A88F41; Tue, 10 Sep 2024 12:43:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401BD88E34
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48AAgq0Z114386;
 Tue, 10 Sep 2024 05:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1725964972;
 bh=WEgWhxv6SO7x8PzuRbl/blkbkHsy/i8VFSNS4+mVBFU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=v0y/Ursk4axBd06dtBFrdzWqG36pJw66+xe2IzEmLovoabtkPcXH9p/9Vi7x2mdTW
 5JQxnsYTGW2kzgCLe9klgvM/59qoVu6+mSjo6iTIXWl/jOEREls8gPzL3hPhc9BB5l
 blLe5r8cbyJfbQSl11eGjFODYpYVvaGU30u/AkP8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48AAgqOI077237
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 10 Sep 2024 05:42:52 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 05:42:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 05:42:52 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AAgoRR055431;
 Tue, 10 Sep 2024 05:42:50 -0500
Message-ID: <463056d8-b506-468f-8b4f-6b6c77eb271c@ti.com>
Date: Tue, 10 Sep 2024 16:12:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ufs: allocate descriptors with size aligned with
 DMA_MINALIGN
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
CC: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-1-3ee0bffacc64@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-1-3ee0bffacc64@linaro.org>
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

Hi Neil,

On 10/09/24 14:50, Neil Armstrong wrote:
> Align the allocation size with DMA_MINALIGN to make sure we do not
> flush/invalidate data from following allocations.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index be64bf971f1..e005cc90608 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -633,7 +633,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>   	/* Allocate one Transfer Request Descriptor
>   	 * Should be aligned to 1k boundary.
>   	 */
> -	hba->utrdl = memalign(1024, sizeof(struct utp_transfer_req_desc));
> +	hba->utrdl = memalign(1024,
> +			      ALIGN(sizeof(struct utp_transfer_req_desc),
> +				    ARCH_DMA_MINALIGN));
>   	if (!hba->utrdl) {
>   		dev_err(hba->dev, "Transfer Descriptor memory allocation failed\n");
>   		return -ENOMEM;
> @@ -642,7 +644,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
>   	/* Allocate one Command Descriptor
>   	 * Should be aligned to 1k boundary.
>   	 */
> -	hba->ucdl = memalign(1024, sizeof(struct utp_transfer_cmd_desc));
> +	hba->ucdl = memalign(1024,
> +			     ALIGN(sizeof(struct utp_transfer_cmd_desc),
> +				   ARCH_DMA_MINALIGN));
>   	if (!hba->ucdl) {
>   		dev_err(hba->dev, "Command descriptor memory allocation failed\n");
>   		return -ENOMEM;
> 

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Sorry for the delay in sending out this review, I had reviewed the first few 
patches that you had send in an earlier version and looks like this cleanup/fix 
was needed. Thanks!

-- 
Thanking You
Neha Malcom Francis

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3104E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 09:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699C88963A;
	Fri,  6 Dec 2024 10:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w+iFEXum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EF0089639; Fri,  6 Dec 2024 10:40:44 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF598963A
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 10:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B69ecGc037918;
 Fri, 6 Dec 2024 03:40:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733478038;
 bh=Fv6SB4PvIOnMI/O2MLp2hONpuKdfYUtJWsJ3GvAdDVA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=w+iFEXumym+ZSOcWPpD6ovLyi3nl5rL3fFqdm6kEANnSwo7UIHndtdMEq1Einf07i
 SiJqpTdcqS6299v9AkEn1tlAcH/J72hg6QX6W3yu1rj8BMD5vOk5uhumJ73gfWnn46
 zaNBLGD+JyuwAwladIXWlFjPsKLZYW9MfBdXJFFg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69ecpF094064;
 Fri, 6 Dec 2024 03:40:38 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 03:40:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 03:40:38 -0600
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B69eZEf121033;
 Fri, 6 Dec 2024 03:40:35 -0600
Message-ID: <1070c694-0fba-458b-84da-8f617ab7201a@ti.com>
Date: Fri, 6 Dec 2024 15:10:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ufs: core: move ufshci defines in a separate header
To: Neil Armstrong <neil.armstrong@linaro.org>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <bmeng.cn@gmail.com>, <venkatesh.abbarapu@amd.com>, <u-boot@lists.denx.de>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
 <20241120-topic-ufs-cleanup-v1-4-a5cef54b1cdc@linaro.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-4-a5cef54b1cdc@linaro.org>
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
> Splitting the header will help synchronizing the defines
> again with Linux.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/ufs/ufs.h    | 329 +-------------------------------------------------
>   drivers/ufs/ufshci.h | 334 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 335 insertions(+), 328 deletions(-)
> 

[...]

> +	__be32			input_param1;
> +	__be32			input_param2;
> +	__be32			input_param3;
> +	__be32			__reserved1[2];
> +
> +	/* DW 12-19 - Task Management Response UPIU structure */
> +	struct utp_upiu_header	rsp_header;
> +	__be32			output_param1;
> +	__be32			output_param2;
> +	__be32			__reserved2[3];
> +};
> +
> +#endif
> 

Acked-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FACAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 04:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3740E8331F;
	Wed, 17 Sep 2025 06:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oEInZK7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D0F83327; Wed, 17 Sep 2025 06:19:44 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBCA83314
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H4Jee3166293;
 Tue, 16 Sep 2025 23:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758082780;
 bh=aisyaXv7suSlU26Wpry6+46L0SUXlW+ujvL9UXhg/bk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oEInZK7/Sgq9HajoobH5aHLqT7VDhZJO9aDSE0zxNOGVvMRn40Y5QYrdwrkBw357o
 au/ZiSLE/SLTG1kWi/4jEeogFlue4Ym8LhLi5WheoJ98mFHpGC77yClFi1OzCQf3fF
 IcoJzXK05dxAgKdkEJ6BGvsqb0dGdfuAwirD1HYA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H4Jeon2055485
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 23:19:40 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 23:19:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 23:19:39 -0500
Received: from [172.24.19.53] (ltpw0bk3wf.dhcp.ti.com [172.24.19.53])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H4JbZJ2690194;
 Tue, 16 Sep 2025 23:19:38 -0500
Message-ID: <59097c32-9efc-4ec2-87ea-14594b8e6fde@ti.com>
Date: Wed, 17 Sep 2025 09:49:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: ti: am57xx: Remove "ti/omap/" from
 name_fit_config
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250917041729.3460570-1-a-dutta@ti.com>
Content-Language: en-US
From: "Dutta, Anurag" <a-dutta@ti.com>
In-Reply-To: <20250917041729.3460570-1-a-dutta@ti.com>
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

Hi Tom
Please pick this up for v2025.10.

On 17-09-2025 09:47, Anurag Dutta wrote:
> Commit 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code
> instead of findfdt script") prepends "ti/omap/" to the actual name
> of the fdtfile whereas fit image boot needs exact dtb name. So, remove
> "ti/omap" from name_fit_config by substituting it with an empty string.
>
> Fixes: 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code instead of findfdt script")
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
>
> logs : https://gist.github.com/anuragdutta731/d7ba9314fa6d7a71bc348911b515615e
>
> Changelog: v2:
> 1. Removed semicolon from the end of cmd.
>
> Link to v1:
> https://lore.kernel.org/all/20250916080800.3357438-1-a-dutta@ti.com/
>
>   board/ti/am57xx/am57xx.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
> index 7d029a3e859..a7cbbced099 100644
> --- a/board/ti/am57xx/am57xx.env
> +++ b/board/ti/am57xx/am57xx.env
> @@ -10,7 +10,7 @@ get_name_kern=
>   	else
>   		setenv bootfile zImage;
>   	fi
> -get_fit_config=setenv name_fit_config ${fdtfile}
> +get_fit_config=setexpr name_fit_config gsub "ti/omap/" "" ${fdtfile}
>   console=ttyS2,115200n8
>   fdtfile=undefined
>   finduuid=part uuid mmc 0:2 uuid

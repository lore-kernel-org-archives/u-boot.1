Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F03CA0EE8
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 04:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 386EC803CC;
	Wed, 17 Sep 2025 06:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tGfI0p5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF45B832F9; Wed, 17 Sep 2025 06:42:17 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D20800C1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 06:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H4gDSe1524970;
 Tue, 16 Sep 2025 23:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758084133;
 bh=HO8pX3Z7NBTIqtIUgTRg/ZxzkKAmd8uC89JAAsxzppA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tGfI0p5moOfDYFTrk1N6fpF5mcm7MDYmZnfGz/H8LM25nMjKj5EyKuYEvgyutnnMN
 L+DKAjpKrtyUeGZamsOoLBtlQ8N/G3Rr4AmzL5ApYGAox5z9y+cQDYtu4SPM+owaUf
 SAXjixDeGF9SteoMLb6tiB+IK5oQ7kmSjoT19Fwk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H4gDMt492841
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 23:42:13 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 23:42:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 23:42:13 -0500
Received: from [172.24.20.139] (lt5cd2489kgj.dhcp.ti.com [172.24.20.139])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H4gBfH2715264;
 Tue, 16 Sep 2025 23:42:12 -0500
Message-ID: <835be5c3-de8b-4aa2-abc8-ca858646557a@ti.com>
Date: Wed, 17 Sep 2025 10:12:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: ti: am57xx: Remove "ti/omap/" from
 name_fit_config
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20250917041729.3460570-1-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
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


On 9/17/2025 9:47 AM, Anurag Dutta wrote:
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


Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   console=ttyS2,115200n8
>   fdtfile=undefined
>   finduuid=part uuid mmc 0:2 uuid

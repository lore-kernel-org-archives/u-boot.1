Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478D5CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 15:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A018A83071;
	Tue, 16 Sep 2025 17:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o7dUvMrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D678309A; Tue, 16 Sep 2025 17:28:27 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78B680325
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 17:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GFSLMR1303313;
 Tue, 16 Sep 2025 10:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758036501;
 bh=/C/DsBSiK6L1YwDSR1VqmctYGSvoKo5RTb4Kf1fLWcw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=o7dUvMrJwMeiVWUW0OCbZt4MAghOOZJ31djtqPdSthY8+cK2i7enwZFTZv1JRWURC
 ZYTFRovEYgD+J1IU05U7+9YX/ROljr9Xb9XK4TxEjPdf1eHBpaOoSYfCKtbeSibGbG
 9JKgIqU0b6oSVaC+Io6IXclgoEhLX1vhZpGA66zI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GFSLom822013
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 10:28:21 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 10:28:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 10:28:21 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GFSJ2Z1822929;
 Tue, 16 Sep 2025 10:28:20 -0500
Message-ID: <043f40f7-ef46-4151-9a72-46ebee9f05d1@ti.com>
Date: Tue, 16 Sep 2025 20:58:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: am57xx: Remove "ti/omap/" from name_fit_config
To: Anurag Dutta <a-dutta@ti.com>, <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20250916080800.3357438-1-a-dutta@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250916080800.3357438-1-a-dutta@ti.com>
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


On 9/16/2025 1:38 PM, Anurag Dutta wrote:
> Commit 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code
> instead of findfdt script") prepends "ti/omap/" to the actual name
> of the fdtfile whereas fit image boot needs exact dtb name. So, remove
> "ti/omap" from name_fit_config by substituting it with an empty string.
>
> Fixes: 649f4a7d3ca7 ("board: ti: am57xx: Set fdtfile from C code instead of findfdt script")
> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
> ---
> logs:
> am57_hs: https://gist.github.com/anuragdutta731/29af0f4099961be45d458425755ba1b6
> am57: https://gist.github.com/anuragdutta731/af9d326d10382d7b4d7a28382693a81a
>
>   board/ti/am57xx/am57xx.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
> index 7d029a3e859..ddf4b318bc7 100644
> --- a/board/ti/am57xx/am57xx.env
> +++ b/board/ti/am57xx/am57xx.env
> @@ -10,7 +10,7 @@ get_name_kern=
>   	else
>   		setenv bootfile zImage;
>   	fi
> -get_fit_config=setenv name_fit_config ${fdtfile}
> +get_fit_config=setexpr name_fit_config gsub "ti/omap/" "" ${fdtfile};

; at last can be avoided

rest

LGTM


>   console=ttyS2,115200n8
>   fdtfile=undefined
>   finduuid=part uuid mmc 0:2 uuid

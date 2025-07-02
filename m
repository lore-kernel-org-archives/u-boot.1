Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A8C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 14:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2405180E9A;
	Wed,  2 Jul 2025 16:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="htYJy6tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A1B800D7; Wed,  2 Jul 2025 16:15:06 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3A1881FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 16:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 562EF2rE3951467;
 Wed, 2 Jul 2025 09:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751465702;
 bh=UyQvWb/sxLuZpKxjkcY/jTl+a0vMVr1IwFqli4VIAao=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=htYJy6tzgovU0nKNE3tfmPbS4+5mhs9zWjoGpQZNRI2KW1ALFKB+rPKsYKnVArLJ2
 ZNpZX75Z5uwOF/GsNk43zAOUQbcK0v/FnONztrMXElsRe+uZKdbMD6CxQQT9LaMoH4
 PMFQLyU0ldB22pCLZLvcmAr9Enk5dlsSQ4iqMArQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 562EF25S918170
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 2 Jul 2025 09:15:02 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 2
 Jul 2025 09:15:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 2 Jul 2025 09:15:02 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 562EExq53563374;
 Wed, 2 Jul 2025 09:14:59 -0500
Message-ID: <1cf39f79-f2c2-47c5-86f5-a67dc84f8835@ti.com>
Date: Wed, 2 Jul 2025 19:44:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: Clean up formatting in rm-cfg.yaml
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <afd@ti.com>
References: <20250702105533.1533178-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250702105533.1533178-1-n-francis@ti.com>
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

Hello Neha,

Thanks for updating these yaml

On 7/2/2025 4:25 PM, Neha Malcom Francis wrote:
> Latest update to the K3 Resource Partitioning Tool updates the YAML
> configuration files to have standard formatting with respect to
> indentation. Update the files that require this cleanup.

Patch LGTM .

Please update tool version in subject, which is used to generate yaml.

With addition of tool version, Please use

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Boot logs:
> https://gist.github.com/nehamalcom/73c1c66d674c32f71a6ade8049c97d21
>
>   board/ti/am64x/rm-cfg.yaml      | 2416 +++++++-------
>   board/ti/j7200/rm-cfg.yaml      | 3554 ++++++++++----------
>   board/ti/j721e/rm-cfg.yaml      | 5498 +++++++++++++++----------------
>   board/ti/j722s/rm-cfg.yaml      |   66 +-
>   board/ti/j722s/tifs-rm-cfg.yaml | 1552 ++++-----
>   5 files changed, 6543 insertions(+), 6543 deletions(-)
>
> diff --git a/board/ti/am64x/rm-cfg.yaml b/board/ti/am64x/rm-cfg.yaml
> index 88b37b5972c..1cc4cd34430 100644
[..]

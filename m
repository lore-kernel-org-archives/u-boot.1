Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9A2C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 11:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BE488B57;
	Wed, 24 Apr 2024 13:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="h4GB2PZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA9A88BE0; Wed, 24 Apr 2024 13:01:45 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA03F887E2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 13:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713956481; x=1714561281; i=xypron.glpk@gmx.de;
 bh=kpFwqscMWWJAgQk5VM3diThAprJLFFVF+8pHIk74YvI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=h4GB2PZuWjde+xkYgO/ejOCWnC2HeSAa/MCgbN1RLggm7tPDfEDYE+FBbOrbDHVa
 xPkpSUv+Slj7TJQCPh0MPXgDwaj+ZMuMS9Yg743dgKTQlsrxmd/9tB3grIIbPPvFQ
 SD7VtcyZUr2oTOlMmLlR8FREWajHUikI+h4P0O/gqZyZdj0yhaGpros01eO7csZ7Z
 q6QN7ss1s7UPKW4c759CFej/tqTJD138FfNkLCk9ovyrFGacZNaZWN6w6Kc8fclRh
 KslE/Boh+MPwWDrd1FehPMGOAS0pd9QBPdH9w9qesHx6iq4x3AZCILEkI4pjg3SM0
 mVH9DbO+BXYVKxLoCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1s80j82EU3-00Slus; Wed, 24
 Apr 2024 13:01:21 +0200
Message-ID: <3707b3b7-8ded-4c97-93fe-491da21feb0f@gmx.de>
Date: Wed, 24 Apr 2024 13:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] board: starfive: Rename spl_soc_init() to
 spl_dram_init()
To: lukas.funke-oss@weidmueller.com
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Bo Gan <ganboing@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 u-boot@lists.denx.de
References: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
 <20240424074339.210851-3-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240424074339.210851-3-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tqoQfo0XB7OjJLR8ibHaeiu2nQ6tiYhQ8syklvOqLaVIYAUvI0n
 ii59nPqM02vKs23pNzKivzTkbCb68I/H8gxsvFE7043Zq8V5daqjf4/rt3qefcfXSiGM0sg
 YoIjPczm/IlvI7Z0AxmCcc8fU9JEECZ/uMC2mPYSIx65iIv4WuTHPQgvPfW8202kiVbu5jw
 Qy25wPtnwOyuJkemr83uQ==
UI-OutboundReport: notjunk:1;M01:P0:pgUwROT0Zis=;Ab2xyeyYs7YCsmu1BzeyFgt0UHR
 LK+yWouYYpU7pqGT/8ofqfWxTpYCoMRFG4wXC+0i1LSmbI+TtmvnElnEolVXIn9mjFnq30RUk
 r8ZhCXg81JXafymI7oBHf/Swg22oMmIHWXStc8ohovbj/ezHSkEWZKZK7DliwemaGc664AWTv
 GdoVS27t/sjnKsV/3rvzWXQsBmb0uKUYMWPDyKODROYmFLrZmxW79R7yPNoWt5t8EBuA2VK2Z
 s5ORcOODiZnQkugvcTsndQSNSU0T5ZdXNyScZygSau8Se9/kXy6zilzrM+xhMBfvgrZnLMq0O
 GR9nYpT1d0M9CiaILLaBfr/nRSX0MkpnRe9ZDR7d1UGblHUij4vSXvW7dU4wJt/heeeO6us7I
 jDDfzNgZTJDp7qZxxXT2gITE52/dZEUw3Mx1TKLq+OkvlU/tpMJmP4n2jWDSSOmoVcu4rSLeM
 gkg+9jyozYQKfCitssK1KHFXXw7Am0K1uhr+Vy9z1Doztab1l/sZT2jmIvHhMc6FV1LgnynEw
 3z3gfTo1n5fdStsm02Z2H5M5ZzqyCL3e7jNSIKr3otKS0EQqCIao2F5V7TIRlvAoS2azelkKD
 gw3CCkGmNyS65QpX7Y/vpVq3hc4+tOje+hjnNsVQXO3nKkEfgb52ux1RHGdLLQSma2cmT+j3l
 eRbWRJVT+CxhjBjzaQ1ngoRIasDlh5xuMIYoW/9W9N2DwcCRuAg5YTLZRmk0aqTEfLKAlFC6e
 Le0ARfAZK0G6/vFVyEOgVMIsYyNMQVoboi4woqcDf14gxFT/n+Hc4UbN+WXQWcqpKvCuFx/fO
 jUQOZCdY9+cL4tgUyXCd9z9sdfHAuP7l7C6Rh5rg+VbwA=
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

On 24.04.24 09:43, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Rename spl_soc_init() to spl_dram_init() because the generic function
> name does not reflect what the function actually does. Also
> spl_dram_init() is commonly used for dram initialization and should be
> called from board_init_f().
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v3:
>   - Reorganize patches such that each patch can be built individually
>
> Changes in v2:
>   - capitalized acronym DRAM
>
>   arch/riscv/cpu/jh7110/spl.c              | 2 +-
>   arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
>   board/starfive/visionfive2/spl.c         | 4 ++--
>   3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
> index 6bdf8b9c72..87aaf86524 100644
> --- a/arch/riscv/cpu/jh7110/spl.c
> +++ b/arch/riscv/cpu/jh7110/spl.c
> @@ -28,7 +28,7 @@ static bool check_ddr_size(phys_size_t size)
>   	}
>   }
>
> -int spl_soc_init(void)
> +int spl_dram_init(void)
>   {
>   	int ret;
>   	struct udevice *dev;
> diff --git a/arch/riscv/include/asm/arch-jh7110/spl.h b/arch/riscv/inclu=
de/asm/arch-jh7110/spl.h
> index 23ce8871b3..d73355bf35 100644
> --- a/arch/riscv/include/asm/arch-jh7110/spl.h
> +++ b/arch/riscv/include/asm/arch-jh7110/spl.h
> @@ -7,6 +7,6 @@
>   #ifndef _SPL_STARFIVE_H
>   #define _SPL_STARFIVE_H
>
> -int spl_soc_init(void);
> +int spl_dram_init(void);
>
>   #endif /* _SPL_STARFIVE_H */
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfiv=
e2/spl.c
> index 45848db6d8..ca61b5be22 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -285,9 +285,9 @@ int spl_board_init_f(void)
>
>   	jh7110_jtag_init();
>
> -	ret =3D spl_soc_init();
> +	ret =3D spl_dram_init();
>   	if (ret) {
> -		debug("JH7110 SPL init failed: %d\n", ret);
> +		debug("JH7110 DRAM init failed: %d\n", ret);
>   		return ret;
>   	}
>


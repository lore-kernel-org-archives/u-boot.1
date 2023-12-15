Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF17CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 06:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEAF87ABC;
	Fri, 15 Dec 2023 07:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="s9oWAp1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AED787AB4; Fri, 15 Dec 2023 07:38:49 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170B987B35
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 07:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231215063842epoutp02fd08f1c5218d4de80184f104a6ee49f0~g7fs68Hzv2168321683epoutp02a
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 06:38:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231215063842epoutp02fd08f1c5218d4de80184f104a6ee49f0~g7fs68Hzv2168321683epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702622322;
 bh=FHeegFcEzE71Ekdk2Oz1XvLcc1c6AXZJM/YMKJSoaOw=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=s9oWAp1zjS8Iy8Yz+rNnVPAKgIpvDCK92Oggetg8jbjMsPr7pRh8y6wtcArKcDVgP
 n0nrazFOckFo6fQsJKbW1qgdrQqh4RDW/Q2CYPG6Ne4DfjEsWfja7VRo6LPI3FzoKL
 RWrKgrxNmUDkCkfrgzqs/YtlVzv4ZsR2FU3CzZVQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231215063841epcas2p4b3f483271b023fed88fdf1f9718ea5e3~g7fscdss-2872928729epcas2p4J;
 Fri, 15 Dec 2023 06:38:41 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.90]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4Ss00x18DDz4x9QK; Fri, 15 Dec
 2023 06:38:41 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 79.28.18994.F64FB756; Fri, 15 Dec 2023 15:38:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231215063839epcas2p473df6c57c05447a147556a41e1fa54b1~g7fp4ILVE2872928729epcas2p4B;
 Fri, 15 Dec 2023 06:38:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231215063839epsmtrp174aa8cdb1829d28d9788d83f54cf2e62~g7fp3erYr1142511425epsmtrp1K;
 Fri, 15 Dec 2023 06:38:39 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-9a-657bf46fe804
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 EA.59.18939.F64FB756; Fri, 15 Dec 2023 15:38:39 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231215063838epsmtip248a2ff26ddcc459591e372adebdc00eb~g7fprUwzN2349923499epsmtip2j;
 Fri, 15 Dec 2023 06:38:38 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Simon Glass'" <sjg@chromium.org>, "'U-Boot Mailing List'"
 <u-boot@lists.denx.de>
Cc: "'Tom Rini'" <trini@konsulko.com>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, "'Leo'" <ycliang@andestech.com>, "'Nikita Shubin'"
 <n.shubin@yadro.com>, "'Rick Chen'" <rick@andestech.com>
In-Reply-To: <20231214094939.v2.5.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
Subject: RE: [PATCH v2 05/21] riscv: Add a reset_cpu() function
Date: Fri, 15 Dec 2023 15:38:38 +0900
Message-ID: <000701da2f21$565e5560$031b0020$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQCfyCLiJkprdh1sBNyVQgIGa1efbgEtNnaNAtgq3zCy/oV9AA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmmW7+l+pUgz8vJSx2n9nEYvH2xVlG
 i29btjFaTJ20md3i7d5OdovDUz8wWjw+9JrJgd1jz+lZzB6zGy6yeHz4GOfx6sAqdo+zd3Yw
 enTdncEYwBaVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6Dr
 lpkDdIuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C8QK84Mbe4NC9dLy+1xMrQ
 wMDIFKgwITtj0sv1zAX9whVLtnWwNDDu4+9i5OSQEDCRWLT8OhuILSSwh1FiwnOdLkYuIPsT
 o8TXLycY4Zwd13+ywHT093xkhUjsZJTYvG8uVNULRomP7+4zgVSxCehLvOzYBlTFwSEiECFx
 9oYfSA2zwBFGiQ0tvxhBajgFQiVOLupnBbGFBewlVt3eyQxiswioSlw/+gXM5hWwlDiwbBWU
 LShxcuYTsCuYBeQltr+dwwxxkYLEz6fLWCHi4hIvjx5hh4iLSDxc/RHObr13FqxeRMBJYvbs
 y0wQcSmJ2a9fsoMcJyFwg0PizKtvUA0uEiuWdkEVCUu8Or6FHabhZX8blF0s0dV2iQWiuYFR
 4nT7FaiEvcSPm1PAvmcW0JRYv0sf4jg+iY7Df9lBwhICvBIdbUITGFVmIXltFpLXZiF5ZxbC
 oAWMLKsYpVILinPTU5ONCgx181LL4TGenJ+7iRGcVrV8dzC+Xv9X7xAjEwfjIUYJDmYlEd4F
 a6tThXhTEiurUovy44tKc1KLDzGaAgN8IrOUaHI+MLHnlcQbmlgamJiZGZobmRqYK4nz3mud
 myIkkJ5YkpqdmlqQWgTTx8TBKdXAFPPb7HYqz6ogo5UxzzkFj7b/++j0nl/bOjmafXaGxWT9
 Pd/4tILmLmnPXDzd5NTSsOXXnTaE7VHq/TIxUWy1yE3uSZo5a+TTNmS5T3dZHMOVesXrGFuJ
 QezBjLw1cgcbuq1kMz0nqi9RuJZ7xH/HhUuHfdsOrQ5zObr9UhO3cZqygufhy0t2q8zUm+Jf
 z79wx2pL4WD1P+duh+nt7b+czNDwJke5Zu7NFy9sjXbNTnA9oO52f+tUqUk/Fn1m4d7/qfxr
 Ct+SgGze6fx2gjtXtT3JOP3tX+vMN1xJpxuVvl5w+iNguTndbdnspA3ChbOdhDzbNN6XWtaH
 RN37W7BZptS5MyQ06Rmf8sVSpzd2SizFGYmGWsxFxYkAhfL7JjQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvG7+l+pUg3vnWSx2n9nEYvH2xVlG
 i29btjFaTJ20md3i7d5OdovDUz8wWjw+9JrJgd1jz+lZzB6zGy6yeHz4GOfx6sAqdo+zd3Yw
 enTdncEYwBbFZZOSmpNZllqkb5fAlTHp5Xrmgn7hiiXbOlgaGPfxdzFyckgImEj093xk7WLk
 4hAS2M4ocX/tPVaIhKzEs3c72CFsYYn7LUegip4xSiybvocJJMEmoC/xsmMbWIOIQITE3F+L
 mECKmAVOMErMmnKZGSQhJHCJUaK1PQTE5hQIlTi5qB+sQVjAXmLV7Z1gNSwCqhLXj34Bs3kF
 LCUOLFsFZQtKnJz5hKWLkQNoqJ5E20ZGkDCzgLzE9rdzmCGOU5D4+XQZK0RcXOLl0SPsMA/8
 OTqXDcIWkXi4+iPcM6+Ob2GHibfeO8sMcb+TxOzZl5kg4mISM6ddhpovJTH79Uv2CYySs5Bc
 NAvhollILpqF5IoFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYLjWytoB+Oy9X/1DjEy
 cTAeYpTgYFYS4V2wtjpViDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoR
 TJaJg1OqgWlziPxuXaPozXtzpTozrjd9kF9zkuV2zLPbF0Xdj/Is7S8zvZzj8PfgmaPKFgem
 39i96Ff+5miTaKUvzm1l2tN3SPXzKpvPDTn29rKDfPinrw4Keo2LuOuiX/BvX/TpWuBnlbDH
 Ex2jtj23b7iT1ibSHnXW9GB4QH4hZ5IQ3+0PWRySKVMrlss5x2/6z58efuLqef0bV7elzct4
 NWnXSju2pheJoScqDibWLnT1OKzU+/qgZ+ws3rdxykePpbd9y2ZwmzVBaFkc30SbjSJ8k+ev
 kZq7ik36yjcbHzdxkYcXA0JXLlFre9C2W27xDu8yoa/znM5c9HxYYvZgs/K/7ogCGUbVwIb5
 h5+V//soflWJpTgj0VCLuag4EQASXVxPXgMAAA==
X-CMS-MailID: 20231215063839epcas2p473df6c57c05447a147556a41e1fa54b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231214165149epcas2p1f5b2f3aca2f12763da2a39eb00a86cf2
References: <20231214165112.2182274-1-sjg@chromium.org>
 <CGME20231214165149epcas2p1f5b2f3aca2f12763da2a39eb00a86cf2@epcas2p1.samsung.com>
 <20231214094939.v2.5.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
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

> -----Original Message-----
> From: Simon Glass <sjg@chromium.org>
> Sent: Friday, December 15, 2023 1:50 AM
> To: U-Boot Mailing List <u-boot@lists.denx.de>
> Cc: Tom Rini <trini@konsulko.com>; Simon Glass <sjg@chromium.org>; Chanho
> Park <chanho61.park@samsung.com>; Heinrich Schuchardt
<xypron.glpk@gmx.de>;
> Leo <ycliang@andestech.com>; Nikita Shubin <n.shubin@yadro.com>; Rick Chen
> <rick@andestech.com>
> Subject: [PATCH v2 05/21] riscv: Add a reset_cpu() function
> 
> The current do_reset() is called from a command context. Add a function
> which can be used from anywhere, as is done on ARM. Adjust do_reset()
> to call it.
> 
> Note that reset_cpu() is normally provided by SYSRESET so make this
> declaration conditional on that being disabled.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>


> ---
> 
> (no changes since v1)
> 
>  arch/riscv/cpu/cpu.c   | 13 +++++++++++++
>  arch/riscv/lib/reset.c |  7 ++-----
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index ebd39cb41a60..8445c5823e17 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -3,10 +3,13 @@
>   * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
>   */
> 
> +#include <command.h>
>  #include <cpu.h>
> +#include <cpu_func.h>
>  #include <dm.h>
>  #include <dm/lists.h>
>  #include <event.h>
> +#include <hang.h>
>  #include <init.h>
>  #include <log.h>
>  #include <asm/encoding.h>
> @@ -162,3 +165,13 @@ int arch_early_init_r(void)
>  __weak void harts_early_init(void)
>  {
>  }
> +
> +#if !CONFIG_IS_ENABLED(SYSRESET)
> +void reset_cpu(void)
> +{
> +	printf("resetting ...\n");
> +
> +	printf("reset not supported yet\n");
> +	hang();
> +}
> +#endif
> diff --git a/arch/riscv/lib/reset.c b/arch/riscv/lib/reset.c
> index 712e1bdb8e1d..c4153c9e6e02 100644
> --- a/arch/riscv/lib/reset.c
> +++ b/arch/riscv/lib/reset.c
> @@ -4,14 +4,11 @@
>   */
> 
>  #include <command.h>
> -#include <hang.h>
> +#include <cpu_func.h>
> 
>  int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> argv[])
>  {
> -	printf("resetting ...\n");
> -
> -	printf("reset not supported yet\n");
> -	hang();
> +	reset_cpu();
> 
>  	return 0;
>  }
> --
> 2.43.0.472.g3155946c3a-goog



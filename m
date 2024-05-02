Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BB6C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5E48874C;
	Thu,  2 May 2024 15:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="iDOfUMsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F4D88C25; Thu,  2 May 2024 10:58:02 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B786888B18
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 10:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0048205.ppops.net [127.0.0.1])
 by m0048205.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 4428BMnl008545
 for <u-boot@lists.denx.de>; Thu, 2 May 2024 04:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=AHcxZmH8OYAYr0FfePUX2XDW0y3X0vU9V3V73/LHSMI=; b=iDOfUMsBLmhd
 Y6YrcnV3dCFfzFUUE+RNww5Pzts8AZSqxdr+Vj/yZIHNVt+OLk5LmkZOet8ptrgZ
 6CP7UiS2GWX5LiZm08iOHUrH2mnHIV3jSN2Mg+SuCwxePFBaj3MlKy0EV0IouW22
 OpyoKKkYE895HZjlDvG+C68FTSKsOH5disg/ByTuP0ED2xPuC9Ay5Lx6t+HECk0G
 HpxsN7sVodce4TUlW0KIgMTfj6fgia1J2zHNJhOmapj36wo0WcFKH9Tvi5RNinOq
 Ckj/aQ6hdivA8XQ8yO1yylvwiw5nWlp/t1CuCUQcey9GsI5HFNYUTmgk8yyPlVyz
 Tmj9Ei+gaA==
Date: Thu, 2 May 2024 11:57:33 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCHv2 066/149] board: ge: Remove <common.h> and add needed
 includes
Message-ID: <ZjNVfWmpLdA94sys@de2cfed78370>
References: <20240501024316.1767971-66-trini@konsulko.com>
 <20240501235849.2224082-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501235849.2224082-1-trini@konsulko.com>
X-Proofpoint-ORIG-GUID: Pi3d7ZJbKRzdF-Rs4VONHZ_GnV7RSOIl
X-Proofpoint-GUID: Pi3d7ZJbKRzdF-Rs4VONHZ_GnV7RSOIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=766
 priorityscore=1501 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020053
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

On Wed, May 01, 2024 at 05:58:49PM -0600, Tom Rini wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
> Changes in v2:
> - Remove "common.h" include as well.
> 
> Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>
> Cc: Ian Ray <ian.ray@gehealthcare.com>
> Cc: Martyn Welch <martyn.welch@collabora.com>
> 
>  board/ge/b1x5v2/b1x5v2.c         | 1 -
>  board/ge/common/ge_rtc.c         | 1 -
>  board/ge/common/vpd_reader.h     | 2 +-
>  board/ge/mx53ppd/mx53ppd.c       | 1 -
>  board/ge/mx53ppd/mx53ppd_video.c | 1 -
>  5 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
> index a2cbd1512e92..031773bc5ef3 100644
> --- a/board/ge/b1x5v2/b1x5v2.c
> +++ b/board/ge/b1x5v2/b1x5v2.c
> @@ -17,7 +17,6 @@
>  #include <asm/io.h>
>  #include <asm/mach-imx/video.h>
>  #include <command.h>
> -#include <common.h>
>  #include <i2c.h>
>  #include <input.h>
>  #include <ipu_pixfmt.h>
> diff --git a/board/ge/common/ge_rtc.c b/board/ge/common/ge_rtc.c
> index 6437afc7bd0a..5c62ecca8c89 100644
> --- a/board/ge/common/ge_rtc.c
> +++ b/board/ge/common/ge_rtc.c
> @@ -3,7 +3,6 @@
>   * Copyright 2017 General Electric Company
>   */
> 
> -#include <common.h>
>  #include <env.h>
>  #include <dm/uclass.h>
>  #include <rtc.h>
> diff --git a/board/ge/common/vpd_reader.h b/board/ge/common/vpd_reader.h
> index 0c51dc57e902..d32c18da351c 100644
> --- a/board/ge/common/vpd_reader.h
> +++ b/board/ge/common/vpd_reader.h
> @@ -3,7 +3,7 @@
>   * Copyright 2016 General Electric Company
>   */
> 
> -#include "common.h"
> +#include <linux/types.h>
> 
>  struct vpd_cache;
> 
> diff --git a/board/ge/mx53ppd/mx53ppd.c b/board/ge/mx53ppd/mx53ppd.c
> index cc462d53da6a..9396d43f8add 100644
> --- a/board/ge/mx53ppd/mx53ppd.c
> +++ b/board/ge/mx53ppd/mx53ppd.c
> @@ -8,7 +8,6 @@
>   * Jason Liu <r64343@freescale.com>
>   */
> 
> -#include <common.h>
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> diff --git a/board/ge/mx53ppd/mx53ppd_video.c b/board/ge/mx53ppd/mx53ppd_video.c
> index 4e2c6ebde73c..eb4dd758b3b5 100644
> --- a/board/ge/mx53ppd/mx53ppd_video.c
> +++ b/board/ge/mx53ppd/mx53ppd_video.c
> @@ -8,7 +8,6 @@
>   * Fabio Estevam <fabio.estevam@freescale.com>
>   */
> 
> -#include <common.h>
>  #include <dm.h>
>  #include <linux/list.h>
>  #include <asm/arch/iomux-mx53.h>
> --
> 2.34.1
> 
> 

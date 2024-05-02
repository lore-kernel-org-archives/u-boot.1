Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B25C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1260188B72;
	Thu,  2 May 2024 15:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="CiQOTtAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31E088C26; Thu,  2 May 2024 10:58:06 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C98188C10
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 10:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ian.ray@gehealthcare.com
Received: from pps.filterd (m0048205.ppops.net [127.0.0.1])
 by m0048205.ppops.net-00176a03. (8.17.1.24/8.17.1.24) with ESMTP id
 4426jXFU019789
 for <u-boot@lists.denx.de>; Thu, 2 May 2024 04:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=outbound;
 bh=8ld7BiZmtoWldlRoBCoJVmNbWSAcaOTTHBlOg2M1Gww=; b=CiQOTtADXDrv
 P1VU5fvUWTwUuCTLbemug8iAMwr5matSD5iBuXzykY1LGdEUHJqqXARly4u08zxO
 m/O8QFUZjy/6CTgthVRDRN6dRwisDmO/T3k3DPds5oCxxB3AIsx08BexhCnxCa6Q
 q4M6/zhwNN1nhRN537/eeElfYOh261OJEeUy3Idc7zFeaOe3K2/aJZ0qfS76NX5L
 QU/jdZEz+UQCbzFbH6zWAPw9KTvdiYd4n9KGeeeiTtHNre/M3FjFakRcPJuy9ZPH
 prUWTuSYcao49QZmtWCD5sQ9bR1Yb52LWg4dcR6kH6429j1P9jkIp9BLUh5tuJYF
 90nhLM03LQ==
Date: Thu, 2 May 2024 11:57:45 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH 093/149] board: msc: Remove <common.h> and add needed
 includes
Message-ID: <ZjNVic_ueW1jCfZ2@de2cfed78370>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-93-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501024316.1767971-93-trini@konsulko.com>
X-Proofpoint-ORIG-GUID: bM3BJzf2FoIwpaQCiBPp3tTr7ItpG4r3
X-Proofpoint-GUID: bM3BJzf2FoIwpaQCiBPp3tTr7ItpG4r3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=851
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
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

On Tue, Apr 30, 2024 at 08:42:20PM -0600, Tom Rini wrote:
> 
> WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> 
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ian Ray <ian.ray@gehealthcare.com>

> ---
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Cc: Ian Ray <ian.ray@gehealthcare.com>
> ---
>  board/msc/sm2s_imx8mp/sm2s_imx8mp.c | 1 -
>  board/msc/sm2s_imx8mp/spl.c         | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
> index 6ccbf02db06e..b1ce014bd55d 100644
> --- a/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
> +++ b/board/msc/sm2s_imx8mp/sm2s_imx8mp.c
> @@ -7,7 +7,6 @@
>   * Copyright 2021 Collabora Ltd.
>   */
> 
> -#include <common.h>
>  #include <errno.h>
>  #include <miiphy.h>
>  #include <netdev.h>
> diff --git a/board/msc/sm2s_imx8mp/spl.c b/board/msc/sm2s_imx8mp/spl.c
> index ed7a1b7d3d00..b1b5561838dc 100644
> --- a/board/msc/sm2s_imx8mp/spl.c
> +++ b/board/msc/sm2s_imx8mp/spl.c
> @@ -7,7 +7,7 @@
>   * Copyright 2021 Collabora Ltd.
>   */
> 
> -#include <common.h>
> +#include <config.h>
>  #include <cpu_func.h>
>  #include <fsl_esdhc_imx.h>
>  #include <hang.h>
> --
> 2.34.1
> 
> 

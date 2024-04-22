Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E406C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A6B8837C;
	Mon, 22 Apr 2024 10:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YZ3Mv3fl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A4F8833D; Mon, 22 Apr 2024 10:25:15 +0200 (CEST)
Received: from mail-m121146.qiye.163.com (mail-m121146.qiye.163.com
 [115.236.121.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 705FD88388
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=YZ3Mv3fl06qpPfj3gB1pBwIGBs80LvZRUkccKPp5MVkgt5XwI0O8JwUbaB5pMnRxOKEp2/dt9RxTidk/zgGrmpsPvprfzYFeSwdumvfA7xEhkVFyo4YgPrdL6sLVOmusLcb4UtVUt/pS+UV04r02zCHIGn8UIPC7STO1BLmiAWA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Y+KVflpSypSl2SK1ClD4SzQ3yaPS/QHrbnltE0zisxk=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 0F3A490026E;
 Mon, 22 Apr 2024 16:24:54 +0800 (CST)
Message-ID: <99f377ea-5363-42fb-81b2-9fe1ea984a14@rock-chips.com>
Date: Mon, 22 Apr 2024 16:24:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rk3288: simplify the DT file list in MAINTAINERS
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu
References: <369151a2b8d73d733ca79eca98d4d5958f90d491.1713423687.git.dsimic@manjaro.org>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <369151a2b8d73d733ca79eca98d4d5958f90d491.1713423687.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0pLGlYeSh1MGkpPHh1CSx9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04e8753c03a9kunm0f3a490026e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6Ahw*NzNREDouTA9NLQEM
 HiwwCzBVSlVKTEpITExPSUJPTE1IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSk9PNwY+
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


On 2024/4/18 15:06, Dragan Simic wrote:
> Use a wildcard to simplify the list of board DT files in the MAINTAINERS
> file for the Radxa Rock 2 Square board.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   board/radxa/rock2/MAINTAINERS | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/board/radxa/rock2/MAINTAINERS b/board/radxa/rock2/MAINTAINERS
> index 5328fd76014a..af974c983047 100644
> --- a/board/radxa/rock2/MAINTAINERS
> +++ b/board/radxa/rock2/MAINTAINERS
> @@ -1,9 +1,7 @@
>   FIREFLY
>   M:	Simon Glass <sjg@chromium.org>
>   S:	Maintained
> -F:	arch/arm/dts/rk3288-rock2-som.dtsi
> -F:	arch/arm/dts/rk3288-rock2-square.dts
> -F:	arch/arm/dts/rk3288-rock2-square-u-boot.dtsi
> +F:	arch/arm/dts/rk3288-rock2*
>   F:	board/radxa/rock2
>   F:	include/configs/rock2.h
>   F:	configs/rock2_defconfig

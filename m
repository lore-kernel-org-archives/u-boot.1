Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74C7C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 01:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB95C8747A;
	Mon, 27 Nov 2023 02:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="EklDWABk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1DD8747A; Mon, 27 Nov 2023 02:45:30 +0100 (CET)
Received: from mail-m127229.xmail.ntesmail.com
 (mail-m127229.xmail.ntesmail.com [115.236.127.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA9987474
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 02:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=EklDWABkPvU5XrOjsgiOpy1E/oNZFiFD099aEWjwVe1XEyQ35CCuJZ+VaCV8ImWIc9SYMjZ6Y2v9Xf1CGvy+zRWSqQmcXyiCINQuZH0pUAfnIgpQTOOyrks2UWZvlrHpNysGsAd9k2yxtYwwItIWEHoNuJscsdsb1QTwLn3Zfk8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=xPf+wcgXhKU2GiAAZbZmJTMdABAb5SNXl19AQ4tlIVA=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11878.qiye.163.com (Hmail) with ESMTPA id 6D4247407AE;
 Mon, 27 Nov 2023 09:44:58 +0800 (CST)
Message-ID: <d8d6cc79-bfa1-4c1e-934f-625941160078@rock-chips.com>
Date: Mon, 27 Nov 2023 09:44:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maintainers: rk3399: remove maintainer
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20231124120431.115717-1-i@shantur.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231124120431.115717-1-i@shantur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkMdT1ZJGklPQx0dQkkZGR5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8c0e737c782eb4kusn6d4247407ae
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBg6Kyo4SDw#LCESFAgwTgkT
 DzowCRpVSlVKTEtKS09CT0JCT0hOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTktINwY+
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


On 2023/11/24 20:04, Shantur Rathore wrote:
> Remove Akash Gajjar <akash@openedev.com> from
> MAINTAINERS as email is bouncing.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
>   board/pine64/rockpro64_rk3399/MAINTAINERS | 1 -
>   board/rockchip/evb_rk3399/MAINTAINERS     | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/board/pine64/rockpro64_rk3399/MAINTAINERS b/board/pine64/rockpro64_rk3399/MAINTAINERS
> index 303db144aa..220ee21f23 100644
> --- a/board/pine64/rockpro64_rk3399/MAINTAINERS
> +++ b/board/pine64/rockpro64_rk3399/MAINTAINERS
> @@ -1,5 +1,4 @@
>   ROCKPRO64
> -M:	Akash Gajjar <akash@openedev.com>
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	board/pine64/rockpro64_rk3399
> diff --git a/board/rockchip/evb_rk3399/MAINTAINERS b/board/rockchip/evb_rk3399/MAINTAINERS
> index c7e412b54e..acdb840f20 100644
> --- a/board/rockchip/evb_rk3399/MAINTAINERS
> +++ b/board/rockchip/evb_rk3399/MAINTAINERS
> @@ -93,7 +93,6 @@ F:	configs/rock-4se-rk3399_defconfig
>   F:	arch/arm/dts/rk3399-rock-4se-u-boot.dtsi
>   
>   ROCK-PI-4
> -M:	Akash Gajjar <akash@openedev.com>
>   M:	Jagan Teki <jagan@amarulasolutions.com>
>   S:	Maintained
>   F:	configs/rock-pi-4-rk3399_defconfig

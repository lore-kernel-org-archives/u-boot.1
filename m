Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7849C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BE7087C8F;
	Thu,  1 Feb 2024 04:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="iylUHX2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605DD87C8F; Thu,  1 Feb 2024 04:19:46 +0100 (CET)
Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com
 [117.135.214.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D2A8799C
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=iylUHX2pCH2N7O1LU8VUqEVXFrpKbXqmkLYLKXwzvnW8QbDnZg/nua+US/iV1FNDjy0SIMKsYly6LEYsr7w5oViTAFstq3g7NmzJYlkhPT+QzIH89WF/SzRQFoi3J6SfopjL6ARcWJYZ+xiju92xmOgNvtirpdhclU7yNKWD3XQ=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=1aRl3AwMOyFWIrMeqN3haisgpQxwjAtkKVlnOxQ6Eeo=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 9391D9001AC;
 Thu,  1 Feb 2024 11:19:10 +0800 (CST)
Message-ID: <9df0b07c-8f83-4500-90c8-1875db20668a@rock-chips.com>
Date: Thu, 1 Feb 2024 11:19:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] rockchip: rv1126: select SPL_OPTEE_IMAGE
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@edgeble.ai>, Johan Jonker <jbx6244@gmail.com>,
 John Keeping <john@metanate.com>, Jonas Karlman <jonas@kwiboo.se>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240124032602.126059-1-tim@feathertop.org>
 <20240124032602.126059-6-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240124032602.126059-6-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGU1KVkkYTxhLQk8eTR5PTFUTARMWGhIXJBQOD1
 lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpNT0lOSFVKS0tVSkJLS1kG
X-HM-Tid: 0a8d62ad76ef03a9kunm9391d9001ac
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46AQw6GjMNKk0fPBANAxYI
 LxJPCQpVSlVKTEtNTE5MTk5JT0pLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlNTEI3Bg++
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


On 2024/1/24 11:26, Tim Lunn wrote:
> rv1126 requires OPTEE as it provides pcsi support. Mainline Linux
> kernel will fail to boot without this.
>
> Select SPL_OPTEE_IMAGE when building FIT image. TEE must be provided
> when building.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> (no changes since v1)
>
>   arch/arm/mach-rockchip/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 6ff0aa6911..cce118a004 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -359,6 +359,7 @@ config ROCKCHIP_RV1126
>   	select PMIC_RK8XX
>   	select BOARD_LATE_INIT
>   	imply ROCKCHIP_COMMON_BOARD
> +	select SPL_OPTEE_IMAGE if SPL_FIT
>   	imply OF_LIBFDT_OVERLAY
>   	imply ROCKCHIP_OTP
>   	imply MISC_INIT_R

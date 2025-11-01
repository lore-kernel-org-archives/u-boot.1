Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2017CCFA00
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 13:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FCD83A84;
	Sat,  1 Nov 2025 14:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="K1NSzsWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C7883A8A; Sat,  1 Nov 2025 14:55:56 +0100 (CET)
Received: from mail-m3294.qiye.163.com (mail-m3294.qiye.163.com
 [220.197.32.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37E183A1B
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 14:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.229])
 by smtp.qiye.163.com (Hmail) with ESMTP id 280324c9a;
 Sat, 1 Nov 2025 21:55:50 +0800 (GMT+08:00)
Message-ID: <67d2dd52-93bf-4ffd-b974-b67d9faa1702@rock-chips.com>
Date: Sat, 1 Nov 2025 21:55:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Fix RG353M model renaming
To: David Barbion <davidb@230ruedubac.fr>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
References: <20250910211855.739181-1-davidb@230ruedubac.fr>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250910211855.739181-1-davidb@230ruedubac.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9a3fb3f8eb03afkunm11801374988312
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSRhCVk4dShlOQkxOGkMaSVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUlCWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=K1NSzsWKIItVwSej4mL2oI/qU204QSuivHvcHN5/c01iZQhuHX1lQDguhlxPmloQ7J5Y5looIa+j8VqjqgCLWN7iNU9yWkDyKhK5gmWtZXw+74NTnXXDOggNPDR8SJhy/Pi43qYi1W6JTv0Y9N10EVap1VMy9ovGTOiO8TZRXrE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=tyMfXpYgxcSn1HQGG4E+HqNh2p7HnNgvHJRbds3TIQA=;
 h=date:mime-version:subject:message-id:from;
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

Hi David,


On 2025/9/11 05:18, David Barbion wrote:
> Anbernic RG353M is hardware compatible with RG353P. Only the form-factor
> differs. So only one DTS is created for both machines with
> "Anbernic RG353P" as default model. If a RG353M is detected, the model
> should be overwritten with the correct name.
> Actually, it's overwritten with "Anbernic" only making the process of
> machine detection a little harder.
> However, to determine the size of the string "Anbernic RG353M", it is
> sizeof() which is used resulting in obtaining the size of the pointer
> (which is 8 bytes on ARM64) not the size of the pointed string.
> strlen() should be used instead.

Everything is OK other than you need a signature in the commit message, 
I think I can add it for your?

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>


Thanks,
- Kever
> ---
>   board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> index c1d1826fd14..d402374e90e 100644
> --- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> +++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
> @@ -695,7 +695,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	if (gd->board_type == RG353M)
>   		fdt_setprop(blob, 0, "model",
>   			    rg3xx_model_details[RG353M].board_name,
> -			    sizeof(rg3xx_model_details[RG353M].board_name));
> +			    strlen(rg3xx_model_details[RG353M].board_name));
>   
>   	if (rg3xx_model_details[gd->board_type].detect_panel) {
>   		ret = rgxx3_panel_fixup(blob);

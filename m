Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69358C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 09:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C5FF87D06;
	Tue,  5 Mar 2024 10:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="N/2BjrhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E4F87FFB; Tue,  5 Mar 2024 10:31:38 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5B187FEE
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 10:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8d7b=KL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709631086;
 bh=x4jxFz25qLw+T7C3cL6ebaf40BxGXYfUBL3xN2Df3Mw=;
 b=N/2BjrhQD9oD7bvRUijaZAOh8iaGvkguaCrbxwxZZGjkaFgGxD9yI8lshJhXGaUTao5Q9gw+D
 igb7s/FOPx38CrBkRC1H6RlB3C0BH//RBorR/BCC+aQtE8BbKRSng5/9nJGy5RJhX8fHg91wT/z
 Rr5KyaNELjL0oYohVpBKD7ZsnwGaKfmJPHNpA6kQEqwF0cBYAJUhDN/PaQGS2ZFB4FD7ZxVcoMG
 rDtJfUAd166rDuT/rSaiXkeLBOEjvHDrfM+2cp3qMaZudZZK7Ut3ELCsN3qI8un+RqOYvSNRO5N
 N7VdnjNtJsBI8AVjamWQEC4ifUg78qHCWG3T3RrOQOeA==
Message-ID: <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
Date: Tue, 5 Mar 2024 10:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5b: enable environment
Content-Language: en-US
To: Trevor Woerner <twoerner@gmail.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>, Christopher Obbard
 <chris.obbard@collabora.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-4-twoerner@gmail.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240305021051.22405-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65e6e66c0c58f90fb4aa51a6
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

Hi Trevor,

On 2024-03-05 03:10, Trevor Woerner wrote:
> Following the pattern of other Rockchip devices, enable the U-Boot
> environment to be stored in MMC. This patch specifically assumes the
> environment will be stored on the SDcard.

This board has SPI flash, so storing env in SPI flash is probably a
better default. However, preferably the env should be stored/loaded from
the same device that TPL/SPL was loaded from.

Regards,
Jonas

> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  configs/rock5b-rk3588_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index 0595325e8107..64a242003aa1 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -60,6 +60,8 @@ CONFIG_CMD_REGULATOR=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_OF_LIVE=y
>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_MMC_ENV_DEV=1
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_SPL_REGMAP=y
>  CONFIG_SPL_SYSCON=y


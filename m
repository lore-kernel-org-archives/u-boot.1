Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20288D37482
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D7B88FB9;
	Thu, 17 Oct 2024 14:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729168275;
	bh=7mUXd2LXxox3M/q0Zq7Os4idqeZEbeZlq6jHc+n8tLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d0RwaxVAqROikUtbGxJfH0gWdpE7//VLfUGUYl0ikMn1W8ACCMBmFikdWvGHSANij
	 Zf6UxbNquaKGO9VO5T6AKBWxSH1Kx+ukHWO7erDVU9Ep7oVupv3Avu0nRTRJauYLZx
	 tcgKxcPemVrUVv4UYj2R7GhbwKFgl6IDoapEdDx7POHMforchi1SB+o+JH+kJyGzr3
	 B4uZr2VDmuzHaV4D8wngQD+UVemYn3b6hLq9owy2o+rlpVDZ64KbbbMJdzBaaJFJ2R
	 qlCXJt0luQ70LEkVCPhcHRc25dwdpP7YIEvbi/1qQKmu/gZoHmTRb9+oyJ5RaC44VV
	 b3ZCCeKygP4Zw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EA35588E5C;
 Thu, 17 Oct 2024 14:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729168272;
 bh=7mUXd2LXxox3M/q0Zq7Os4idqeZEbeZlq6jHc+n8tLQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cEpGR89lhSlOBNJuLgwE49rcN6XyoG/48xo5Q1sMHbccIuknA0jSZebxtO+31rd3G
 giv4o4vEH3HhSJ/WmldrZ5NtaDtBgpiE6vrV0ey6f5qYrvB49Kp9aWsMaiXBDX+VPI
 TSVWZqX9KT7wYwKbMYiOowBb0sEmpuxETdj2fuXzEwajxK7qhqBoz2y4CyzxAR9eU3
 VVeoWKXUwUWvzyoPJsnQduu+/E2W5P47r8Vz4MQGWg6ALx38G0bOoKIMiLwXuZzY8C
 xEfMR7wI654JHG7XPIFNUDx6FZf4xY8Cul84NBbsCbU3kEN0JG0YW6PTMMy0cwpH1n
 rSye409rvVasA==
Message-ID: <a146fbb6-1133-468d-a636-d50d72013bf0@denx.de>
Date: Thu, 17 Oct 2024 14:09:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, sbabic@denx.de,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, eduard@lionizers.com, fedor.ross@ifm.com,
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com,
 tharvey@gateworks.com, sjg@chromium.org, u-boot@lists.denx.de
Cc: martijn.de.gouw@prodrive-technologies.com
References: <20241017075049.3959440-1-paul.geurts@prodrive-technologies.com>
 <20241017075049.3959440-3-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241017075049.3959440-3-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/17/24 9:50 AM, Paul Geurts wrote:

[...]

>   bool imx_hab_is_enabled(void)
>   {
> -	struct imx_fuse_t *fuse =
> +	struct imx_fuse_t *sec_config =
>   		(struct imx_fuse_t *)&imx_sec_config_fuse;
> +	struct imx_fuse_t *field_return =
> +		(struct imx_fuse_t *)&imx_field_return_fuse;
>   	uint32_t reg;
> +	bool is_enabled;
>   	int ret;
>   
> -	ret = fuse_read(fuse->bank, fuse->word, &reg);
> +	ret = fuse_read(sec_config->bank, sec_config->word, &reg);
>   	if (ret) {
>   		puts("\nSecure boot fuse read error\n");

Drop the leading \n please.

>   		return ret;
>   	}
> +	is_enabled = (reg & IS_HAB_ENABLED_BIT) == IS_HAB_ENABLED_BIT;

is_enabled = reg & IS_HAB_ENABLED_BIT;
is enough here.

> +	if (is_enabled) {
> +		ret = fuse_read(field_return->bank, field_return->word, &reg);
> +		if (ret) {
> +			puts("\nField return fuse read error\n");

Drop the leading \n please.

> +			return ret;
> +		}
> +		is_enabled = !((reg & FIELD_RETURN_FUSE_MASK) == FIELD_RETURN_PATTERN);

is_enabled = (reg & FIELD_RETURN_FUSE_MASK) != FIELD_RETURN_PATTERN;

> +	}
>   
> -	return (reg & IS_HAB_ENABLED_BIT) == IS_HAB_ENABLED_BIT;
> +	return is_enabled;
>   }
[...]

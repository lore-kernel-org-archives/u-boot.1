Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F89C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 14:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5DFD87C45;
	Sun, 11 Feb 2024 15:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=yandex.com header.i=@yandex.com header.b="dm1IpJ2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0089B87C45; Sun, 11 Feb 2024 15:07:41 +0100 (CET)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [178.154.239.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12F11877D0
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 15:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@yandex.com
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:68c:0:640:359:0])
 by forward500b.mail.yandex.net (Yandex) with ESMTPS id F3E2F60AEB;
 Sun, 11 Feb 2024 17:07:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id Q7mSPQcOmqM0-rQsrsngN; 
 Sun, 11 Feb 2024 17:07:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
 t=1707660449; bh=j85177/WaqmDSx2iSA8h2V2lqhsXsvNSTovLvKGcTAo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dm1IpJ2icYf/jImnS2Nz8INtTQ/RxXubXDfLt1q99rrTCYhwDMyuesf6X8W4L8WPi
 SCzYQXrZsVoB/f+mHMKc3EngcVlg3eDrvKmroUwGeA2fdAPGnhnmehLNby0tTNCJIl
 jM3Lj88jqX5mIj8iGwNLO6YhTSghBmyziwyxNM1c=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.com
Message-ID: <f0fdf99e-4688-47e2-97ff-a7ba24682a29@yandex.com>
Date: Sun, 11 Feb 2024 15:07:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: rockchip: Clarify the rkspi image format further
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, massimo.pegorer+oss@gmail.com
References: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
From: Johan Jonker <jbx6244@yandex.com>
In-Reply-To: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 11 Feb 2024 15:45:52 +0100
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



On 2/10/24 19:18, Dragan Simic wrote:
> As discussed on the U-Boot mailing list, [1][2] only some Rockchip SoCs
> suffer from a bug in their BROMs that requires a specific format for their

This not a bug.

> SPI images, which was the reason for the rkspi format to be introduced.
> 
> Improve the description of the rkspi format a bit to mention this, for
> future reference and to make understanding it easier.
> 
> [1] https://lore.kernel.org/u-boot/c32129ba-db25-4b9d-9a4a-032d88dfb9cd@kwiboo.se/
> [2] https://lore.kernel.org/u-boot/CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com/
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  doc/README.rockchip | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/README.rockchip b/doc/README.rockchip
> index 84caff8a24d3..e0c5c395ec6a 100644
> --- a/doc/README.rockchip
> +++ b/doc/README.rockchip
> @@ -649,7 +649,12 @@ sector is used. The header is the same as with rksd and the maximum size is

>  also 32KB (before spreading). The image should be written to the start of
>  SPI flash.
>  

On rk3066 an image should start before page address:
NAND : 50
SPI  : 13
EMMC :  1

Not sure about start limits for other SoC's. (Kever ??)

Also rk3066 and rk3188 use RC4 crypto.

> -See above for instructions on how to write a SPI image.
> +Only the BROMs of some Rockchip SoCs, such as the RK3399, suffer from a bug
> +that mandates the above-described data spreading, thus requiring the rkspi
> +format to be used for their SPI images. Rockchip SoCs that don't suffer
> +from this bug use the rksd format for their SPI images.
> +

This not a bug. It's a design choice to reuse the reading function in the boot ROM shared by EMMC, NAND and SPI etc. due to size restrictions.

See NAND example:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/blob/master/drivers/block/rkmtd.c?ref_type=heads#L259

This NAND code also applies to SPI with minor tweaks.
Code will never read more then 2k regardless of the page size.

===
This info must be written in a more neutral wording.(no bugs involved)
Just describe the 2 formats and the SoC's that use it.

Johan

===
Extra:

Could someone cleanup README.rockchip
The file README.rockchip has most building scenarios covered by now.
Please have a look if all the boot log listing in that file are still needed or can be removed. 

===

Is there a need for SPI programmer code a la RKMTD with common base and block interface tools?

===

Is someone able to extract rk3568 boot ROM code in order to study NAND boot behavior for a future RKMTD NFC V9 upgrade?

> +See the section above for instructions on how to write an SPI image.
>  
>  rkmux.py
>  --------
> 

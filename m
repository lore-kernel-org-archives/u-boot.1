Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D0CF538B
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B188908D;
	Wed, 23 Oct 2024 15:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729691300;
	bh=zxH3pe3XdhoMQFjwy6P4IFwoAP8GnrQ6kGkW4VGy5W4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQ0uAGSyj63eDMs96cpznAJBMWF8KGbaOdAZyJREPZrwQH+psOedXbhj/Q35OVtAR
	 xoxDYtgDtmKLyrLugpGpMXfWM8YyqG7V6OYJ9x1wb41nTPUqhrHLVIkZXEA6jpxoln
	 JuMaS5fBVkY8Z/DLsQoclC+V5EJo8coXzf4kiPjB6cqX6i2Sob99dTnZS03WNnT7jE
	 Y5zOa0B9yzwjlprwqhwoBwGIeROuFeE4vgdTRgEWaaLHizujPfA0FSNx9kLuA1bpph
	 ovZgdKZ3/EL7j8aSt53EDyTRp/3lnUOPzfc0q4/NYmtSQOpqioBEtPHcQKukklEFKV
	 uPcEG/VixNCSQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D9CA8908F; Wed, 23 Oct 2024 15:48:19 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 648E588E0A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XYVk51Mtjz9t1K;
 Wed, 23 Oct 2024 15:48:13 +0200 (CEST)
Message-ID: <758e4071-2e87-4051-905c-f4654ef29b5a@denx.de>
Date: Wed, 23 Oct 2024 15:48:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mips: mt7688: gardena-smart-gateway: Increase
 CONFIG_SYS_BOOTM_LEN
To: Ezra Buehler <ezra@easyb.ch>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
References: <20241023132731.420801-1-ezra@easyb.ch>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241023132731.420801-1-ezra@easyb.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/23/24 15:27, Ezra Buehler wrote:
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> The default value of 0x800000 (8 MB) is somewhat limiting for us, as our
> compressed kernel may grow up to around 4 MB. By choosing the commonly
> used value of 0x2000000 (32 MB), we are definitely on the safe side.
> This rather large amount should be fine, as we have 128 MB of RAM.
> 
> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> ---
> 
> Are there drawbacks of choosing a hight value for CONFIG_SYS_BOOTM_LEN
> that I am missing here? If so, 0x1000000 is most likely enough too.

I don't see problems with using 32MB, so:

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> Cheers,
> Ezra.
> 
>   configs/gardena-smart-gateway-mt7688_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
> index b7f4a76ce6..2c69e91339 100644
> --- a/configs/gardena-smart-gateway-mt7688_defconfig
> +++ b/configs/gardena-smart-gateway-mt7688_defconfig
> @@ -47,6 +47,7 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_SPL_NOR_SUPPORT=y
>   CONFIG_HUSH_PARSER=y
>   CONFIG_CMD_LICENSE=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_XIMG is not set
>   CONFIG_CMD_MEMINFO=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

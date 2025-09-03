Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26241CA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 00:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B57C83390;
	Wed,  3 Sep 2025 02:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1D383A7A; Wed,  3 Sep 2025 02:21:50 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EFD7832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 02:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 12067B220382;
 Wed,  3 Sep 2025 02:21:46 +0200 (CEST)
Message-ID: <a206d10a-c0ca-4d87-8da4-ba9a3c85f167@freeshell.de>
Date: Tue, 2 Sep 2025 17:21:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 09/10] board: starfive: spl: Support VisionFive 2 Lite
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-10-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-10-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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



On 8/28/25 23:09, Hal Feng wrote:
> Choose the matching FIT config on the VisionFive 2 Lite board.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  board/starfive/visionfive2/spl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
> index 901e7b58f36..18571b482f9 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -133,6 +133,9 @@ int board_fit_config_name_match(const char *name)
>  		   (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
>  		    !strncmp(get_product_id_from_eeprom(), "VF7110b", 7))) {

Deprecation of "VF7110b" and "VF7110a" mentioned previously should be in
its own patch.

>  		return 0;
> +	} else if (!strcmp(name, "starfive/jh7110s-starfive-visionfive-2-lite") &&
> +		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
> +		return 0;
>  	}
>  
>  	return -EINVAL;

This is sorted correctly and looks good to me. With that,

Reviewed-by: E Shattow <e@freeshell.de>

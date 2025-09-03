Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4922ACA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 00:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19C283390;
	Wed,  3 Sep 2025 02:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC35833D0; Wed,  3 Sep 2025 02:26:27 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB513832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 02:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A2A51B2204BD;
 Wed,  3 Sep 2025 02:26:23 +0200 (CEST)
Message-ID: <52aad19a-0188-4bba-9f06-a0d7d6ff0c38@freeshell.de>
Date: Tue, 2 Sep 2025 17:26:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 10/10] board: starfive: visionfive2: Add VisionFive 2 Lite
 fdt selection
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-11-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250829060931.79940-11-hal.feng@starfivetech.com>
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
> Set $fdtfile to the VisionFive 2 Lite DTB if the board is matched.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index f38433e94ac..912e8cb967a 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -65,6 +65,8 @@ static void set_fdtfile(void)
>  	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
>  		   !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)) {
>  		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> +	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
> +		fdtfile = "starfive/jh7110s-starfive-visionfive-2-lite.dtb";
>  	} else {
>  		log_err("Unknown product\n");
>  		return;

I continue to think it is silly we are setting $fdtfile env variable
past the moment since adopting OF_UPSTREAM. That is a discussion for
somewhere else, however.

Anyhow the sorting is correct and new code follows the existing code
pattern.

Reviewed-by: E Shattow <e@freeshell.de>

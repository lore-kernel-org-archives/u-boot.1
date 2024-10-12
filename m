Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F89BCF2586
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 21:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B619688DA3;
	Sat, 12 Oct 2024 23:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728768365;
	bh=fI9acW3H6B+vZUH62Tpv24vKbP6ysXlFTP5WxJgobwc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XcrTh1hjymS5/l7p4iKgiWjPzqVUytaHttN6nWlaVDL94LKcjITEOV+eDygIFV2Ba
	 3nYcki2IQQ8r0UT2G1zgrCRu41/N+0Cwah9lY69ivrnCw9HJH8ZLNGW4wfhUcB7nBb
	 QeEHWD8yA1Q/VnPx2Y/VFnSIyaQUCyNnFoLod+uP0fYlcGQ/R3u/6CT3r8qhJZ1L/l
	 s5fMa42QHJmeJ6jy8ziyCHnDiWUh/dAM98VXAkp4ikf64DUIQOC82fdYCqT4cyZrNr
	 u5Xgd9E/Nw3K6fa/7b2G4twOgwuqreY6Wlixv1qzadplKNJ8epu8e2NLG4v3y9aVY/
	 a33olqyrs+1EA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5B84C88B11;
 Sat, 12 Oct 2024 23:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728768364;
 bh=fI9acW3H6B+vZUH62Tpv24vKbP6ysXlFTP5WxJgobwc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=w7Sbs4tfc88gTQDfA5vkIiIxpwLGmi0AJ7yf1WQDq/IT8f4HgYYPLzwddL+aCZB22
 6Aff8A0d5ZVWbmZAte2nEQ+DrvB9wWLRPnNWJmjUUQpWXvCVPHm4/ITAiIftSHlVuq
 kx4w4Ex+WNM0549ILqSLy+32LLNfBo6HiBMv6JEAjOGMq9dhZnQUFE64WTnMGDle6y
 TxLHeX+23RS4m+JbUWUS+MTHuZHQw/bA9Ec3H7HbJo+i1+cmObYieIbTvUUgx5aZ6C
 Gx0tmV3B1f7HHxjMQ1D0jRS6jUD6YTeWDrW2G3xp+qWLlYidonKH10t5yB5y8EomHW
 uUlQz+ioZUCKA==
Message-ID: <9b2f1914-ed29-429b-8c0a-e2a25a1172a9@denx.de>
Date: Sat, 12 Oct 2024 22:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
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

On 10/10/24 3:23 PM, Christoph Niedermaier wrote:
> The i.MX8M Plus DHCOM currently supports parsing ethernet MAC address
> from multiple sources in the following priority order:
> 
> 1) U-Boot environment 'ethaddr'/'eth1addr' environment variable
> 2) SoC OTP fuses
> 3) On-SoM EEPROM
> 
> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
> which contains additional write-lockable page, which can also be
> populated with a structure containing ethernet MAC address.
> 
> Add support for parsing the content of this new write-lockable page
> and place it between 2) and 3) on the priority list. The new entry is
> 2.5) On-SoM EEPROM write-lockable page
> 
> Because the write-lockable page is not present on rev.100 i.MX8MP DHCOM
> SoM, test whether EEPROM ID page exists in DT and whether it is enabled
> first. If so, read the entire ID page out, validate it, and determine
> whether EEPROM MAC address is populated in it in DH specific format. If
> so, use the MAC address. There may be multiple EEPROMs with an ID page
> on this platform, always use the first one.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> ---
>   board/dhelectronics/common/dh_common.c        | 113 ++++++++++++++++++
>   board/dhelectronics/common/dh_common.h        |  23 ++++
>   .../dh_imx8mp/imx8mp_dhcom_pdk2.c             |   6 +
>   3 files changed, 142 insertions(+)
> 
> diff --git a/board/dhelectronics/common/dh_common.c b/board/dhelectronics/common/dh_common.c
> index 32c50b4f0f..8ea70fc984 100644
> --- a/board/dhelectronics/common/dh_common.c
> +++ b/board/dhelectronics/common/dh_common.c
> @@ -7,9 +7,22 @@
>   #include <dm.h>
>   #include <i2c_eeprom.h>
>   #include <net.h>
> +#include <u-boot/crc.h>
>   
>   #include "dh_common.h"
>   
> +struct eeprom_id_page {
> +	u8	id[3];		/* Identifier 'D', 'H', 'E' - 'D' is at index 0 */
> +	u8	version;	/* 0x10 -- Version 1.0 */
> +	u8	data_crc16[2];	/* [1] is MSbyte */
> +	u8	header_crc8;
> +	u8	mac0[6];
> +	u8	mac1[6];
> +	u8	item_prefix;	/* H/F is coded in MSbits, Vendor coding starts at LSbits */
> +	u8	item_num[3];	/* [2] is MSbyte */
> +	u8	serial[9];	/* [8] is MSbyte */
> +} __packed;

Is __packed needed ?

[...]

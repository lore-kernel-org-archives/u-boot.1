Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFD7C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 03:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4FE083327;
	Mon, 11 Aug 2025 05:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D172583330; Mon, 11 Aug 2025 05:16:09 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97A683323
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 05:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.27.117])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0966FB4E0005;
 Mon, 11 Aug 2025 05:16:05 +0200 (CEST)
Message-ID: <e6f1cb27-371c-44ef-b7ec-3f348ca0a085@freeshell.de>
Date: Sun, 10 Aug 2025 20:16:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] starfive: fix return code of `mac write_eeprom`
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, u-boot@lists.denx.de
References: <20250809082155.6929-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250809082155.6929-1-heinrich.schuchardt@canonical.com>
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



On 8/9/25 01:21, Heinrich Schuchardt wrote:
> When writing the EEPROM fails, the command usage help text is displayed
> after the error message. We should only display the error message instead.
> 
> If writing the EEPROM fails, return CMD_RET_FAILURE (1) instead of
> CMD_RET_USAGE (-1).
> 
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> index 010e386e64d..17a44020bcf 100644
> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
> @@ -275,7 +275,7 @@ static int prog_eeprom(unsigned int size)
>  
>  	if (is_match_magic()) {
>  		printf("MAGIC ERROR, Please check the data@%p.\n", pbuf.buf);
> -		return -1;
> +		return CMD_RET_FAILURE;
>  	}
>  
>  	ret = i2c_get_chip_for_busnum(CONFIG_SYS_EEPROM_BUS_NUM,
> @@ -285,7 +285,7 @@ static int prog_eeprom(unsigned int size)
>  	if (ret) {
>  		printf("Get i2c bus:%d addr:%d fail.\n", CONFIG_SYS_EEPROM_BUS_NUM,
>  		       CONFIG_SYS_I2C_EEPROM_ADDR);
> -		return ret;
> +		return CMD_RET_FAILURE;
>  	}
>  
>  	for (i = 0, p = (u8 *)pbuf.buf; i < size; ) {
> @@ -314,11 +314,11 @@ static int prog_eeprom(unsigned int size)
>  	if (ret) {
>  		has_been_read = -1;
>  		printf("Programming failed.\n");
> -		return -1;
> +		return CMD_RET_FAILURE;
>  	}
>  
>  	printf("Programming passed.\n");
> -	return 0;
> +	return CMD_RET_SUCCESS;
>  }
>  
>  /**

This patch is a good start, but I think maybe more is needed? Quoting
the notes I wrote for myself last year:

"
mac command:

if data did not change then "Programming passed." is printed regardless
of write protect state but no action was taken and no usage help is
printed. 'mac' still outputs in-memory info.

when data was changed the command shows "Programming failed." or
"Programming passed." followed by usage help and 'mac' command shows no
output until 'mac read_eeprom'.

Suggested:

If data did not change at time of 'mac eeprom_write' then it should
still try to write so the message pass/fail will be correct.
The usage info following 'mac write_eeprom' is a bug, should not be printed.

prog_eeprom return values inconsistent with command.h

prog_eeprom returns -1 which overlaps with CMD_RET_USAGE
should be 1 for failure

show_eeprom()

Print a message "No valid data. Please do mac read_eeprom".
Maybe "Read nnn bytes from EEPROM" and "Displaying local copy of EEPROM
from memory" to be more clear.
"

Acked-by: E Shattow <e@freeshell.de>

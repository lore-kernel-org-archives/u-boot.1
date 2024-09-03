Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92641CA101E
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 06:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBEC48891B;
	Tue,  3 Sep 2024 08:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725346466;
	bh=JXgGTOnchQ18dV3AslfBeQZrppBnpycJK7UyAihcB38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dJfrmr/bvqWKkZMzF+RWmZTeU2V9yId6tN8axAE1U4gwT6MSVCR4nWqUQrpTeyz2l
	 i6RU1N5jCNBvCHT0yp9VEC4eKIPsN88noPZt4Zx5Otj/CcxSIlSVlb0sPfktlHO/uK
	 XefyWRgN+jJL1zd7wNoJAdFLsa4ch5alGN2QUUc39POilxewFhHeFhVdbFnEXQzbVd
	 NJ6TP+hARkcuULzI3TMIXDLpJUr7Os1F+LjcYfPB4n7CVqgXzB8+2dSjAKOAHZg1C3
	 ALZbdo59wNz0ICLmRBZN9QJj/1d+cBAs2ZfOuG2WwGSwDu+WCaF8sJrpceqjuwbl+t
	 2eBZ0Pop6SSnw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8EA8892C; Tue,  3 Sep 2024 08:54:26 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331A6888FB
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 08:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Wybvf0zDyz9sSc;
 Tue,  3 Sep 2024 08:54:22 +0200 (CEST)
Message-ID: <316aaada-65be-42bc-a57f-d2421b79820b@denx.de>
Date: Tue, 3 Sep 2024 08:54:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell 1/3] arm: mvebu: turris_omnia: Rename
 variable holding EEPROM udevice
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240829080849.20276-1-kabel@kernel.org>
 <20240829080849.20276-2-kabel@kernel.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240829080849.20276-2-kabel@kernel.org>
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

On 8/29/24 10:08, Marek Behún wrote:
> Rename the variable holding the EEPROM udevice from `chip` to `eeprom`.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index 2f29d26edf8..392df53a6d8 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -464,16 +464,16 @@ static bool check_eeprom_crc(const void *buf, size_t size, u32 expected,
>   
>   static bool omnia_read_eeprom(struct omnia_eeprom *oep)
>   {
> -	struct udevice *chip;
> +	struct udevice *eeprom;
>   	int ret;
>   
> -	chip = omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
> -				  OMNIA_I2C_EEPROM_CHIP_LEN);
> +	eeprom = omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
> +				    OMNIA_I2C_EEPROM_CHIP_LEN);
>   
> -	if (!chip)
> +	if (!eeprom)
>   		return false;
>   
> -	ret = dm_i2c_read(chip, 0, (void *)oep, sizeof(*oep));
> +	ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
>   	if (ret) {
>   		printf("dm_i2c_read failed: %i, cannot read EEPROM\n", ret);
>   		return false;

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

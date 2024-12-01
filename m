Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B44DD49780
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F3E892E5;
	Sun,  1 Dec 2024 19:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733078715;
	bh=ApssvLOk4VIdCM0BusrAfYeJyfYFiDFczV6sCzuEz/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RoyyMAH97WfH4jNL7OKX5a1adDiTLw/cRsyTX+byiGA0CMscuaYhC+H5YHp6ZCCxu
	 8Ddh+tg2TDNyhxXoCJTkSabIQ6cLFO2csUORT1tg8mJJunYlI3um+qKbSjzOaf4bPX
	 KGoQmy58raeIHCL5WQcTo2fP13Wd1xLniSq8b2bO8SGEu7BeYciDsE6r7h55F2mXgO
	 61LhU3plaF7TT7BunJxjkkB9UhXrQ/6fGWCio0sBAbRWVwuWk9pYTFYY2D3xnkiq6I
	 1P48TtUBOJcy4zlNV7SQDQtIt4G9pd7n68YQXCUs21+UC/z+MDXdk//IdXeiBzXM/v
	 2yoT1XqJUn2YA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 673C888B99;
 Sun,  1 Dec 2024 19:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733078713;
 bh=ApssvLOk4VIdCM0BusrAfYeJyfYFiDFczV6sCzuEz/0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JfRj1Y21/TLRcsaGAk1Lh6ElOjkFATNZYTWZoS4WNGkiAdNFV1L7U5Pl4swem8FY3
 Fp6DzVFu7nhrNtOuR87R1CqcPDVfxrNoWJBeAEY1SfsMv26j6+w8q7ZNCjUJ3nxrQn
 QWUwvqPXbQxheJIDsQ3UW6cpWeOeMvLKqvU+wIuAjpx1E7zck9rYWrVvsPAizzqa3a
 txOQl5EWjcvJUjQVk5C5CCVyn7EsaP7DLncsAiag6SAoGvRVwFtpSnyKGgXdo0/jih
 +1l0kXHbj5u6ydVsSJqqdQz9yj3g7e0noVHG6GNyN2Cf/91CZ6G5ByYMmd5+l3ulNt
 DwiiNwD6SqtZw==
Message-ID: <f3c84d83-31ff-4408-a733-a97a2219ed33@denx.de>
Date: Sun, 1 Dec 2024 19:43:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] arm64: imx8mp: Read values from M24C32-D
 write-lockable page on DHCOM i.MX8MP
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
 <20241128142020.35386-3-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241128142020.35386-3-cniedermaier@dh-electronics.com>
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

On 11/28/24 3:20 PM, Christoph Niedermaier wrote:

[...]

> +++ b/board/dhelectronics/common/dh_common.c
> @@ -7,6 +7,7 @@
>   #include <dm.h>
>   #include <i2c_eeprom.h>
>   #include <net.h>
> +#include <u-boot/crc.h>
>   
>   #include "dh_common.h"
>   
> @@ -30,6 +31,148 @@ int dh_get_mac_is_enabled(const char *alias)
>   	return 0;
>   }
>   
> +int dh_read_eeprom_id_page(u8 *eeprom_buffer, const char *alias)
> +{
> +	struct eeprom_id_page *eip = (struct eeprom_id_page *)eeprom_buffer;
> +	struct udevice *dev;
> +	size_t payload_len;
> +	int eeprom_size;
> +	u16 crc16_calc;
> +	u16 crc16_eip;
> +	u8 crc8_calc;
> +	ofnode node;
> +	int ret;
> +
> +	node = ofnode_path(alias);
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_I2C_EEPROM, node, &dev);
> +	if (ret)
> +		return ret;
> +
> +	eeprom_size = i2c_eeprom_size(dev);
> +	if (eeprom_size < 0) {
> +		printf("%s: Error getting EEPROM ID page size! ret = %d\n", __func__, ret);
> +		return eeprom_size;
> +	} else if (eeprom_size == 0 || eeprom_size > DH_EEPROM_ID_PAGE_MAX_SIZE) {

The else part is not necessary, use plain:

...
  ...
  return eeprom_size;
}

if (eeprom_size == 0 || eeprom_size > DH_EEPROM_ID_PAGE_MAX_SIZE) {
...

> +		eeprom_size = DH_EEPROM_ID_PAGE_MAX_SIZE;
> +		printf("Get invalid EEPROM ID page size %d bytes! Try to read %d bytes.\n",
> +		       eeprom_size, DH_EEPROM_ID_PAGE_MAX_SIZE);
> +	}
> +
> +	ret = i2c_eeprom_read(dev, 0x0, eeprom_buffer, eeprom_size);
> +	if (ret) {
> +		printf("%s: Error reading EEPROM ID page! ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	/* Validate header ID */
> +	if (eip->hdr.id[0] != 'D' || eip->hdr.id[1] != 'H' || eip->hdr.id[2] != 'E') {
> +		printf("%s: Error validating header ID! (got %c%c%c (0x%02x 0x%02x 0x%02x) != expected DHE)\n",
> +		       __func__, isprint(eip->hdr.id[0]) ? eip->hdr.id[0] : '.',
> +		       isprint(eip->hdr.id[1]) ? eip->hdr.id[1] : '.',
> +		       isprint(eip->hdr.id[2]) ? eip->hdr.id[2] : '.',
> +		       eip->hdr.id[0], eip->hdr.id[1], eip->hdr.id[2]);
> +		return -EINVAL;
> +	}
> +
> +	/* Validate header checksum */
> +	crc8_calc = crc8(0xff, eeprom_buffer, offsetof(struct eeprom_id_page, hdr.crc8_hdr));
> +	if (eip->hdr.crc8_hdr != crc8_calc) {
> +		printf("%s: Error validating header checksum! (got 0x%02x != calc 0x%02x)\n",
> +		       __func__, eip->hdr.crc8_hdr, crc8_calc);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Validate header version
> +	 * The payload is defined by the version specified in the header.
> +	 * Currently only version 0x10 is defined, so take the length of
> +	 * the only defined payload as the payload length.
> +	 */
> +	if (eip->hdr.version == DH_EEPROM_ID_PAGE_V1_0) {

Invert this conditional:

...
if (eip->hdr.version != DH_EEPROM_ID_PAGE_V1_0) {
  printf(...);
  return ...;
}

payload_len = sizeof(eip->pl);
...

> +		payload_len = sizeof(eip->pl);
> +	} else {
> +		printf("%s: Error validating version! (0x%02X is not supported)\n",
> +		       __func__, eip->hdr.version);
> +		return -EINVAL;
> +	}
> +
> +	/* Validate payload checksum */
> +	crc16_eip = (eip->hdr.crc16_pl[1] << 8) | eip->hdr.crc16_pl[0];
> +	crc16_calc = crc16(0xffff, eeprom_buffer + sizeof(eip->hdr), payload_len);
> +	if (crc16_eip != crc16_calc) {
> +		printf("%s: Error validating data checksum! (got 0x%02x != calc 0x%02x)\n",
> +		       __func__, crc16_eip, crc16_calc);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[...]

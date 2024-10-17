Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B84D3C536
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 21:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0C8890AD;
	Thu, 17 Oct 2024 23:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729199679;
	bh=eUYiS0EmRRo5GBfhqsi+IJTRNKfPk9Ywkzy/OepXxYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+5OJtxwEQ7SZHF0T2992pChd3dEcfJWAViyhq8on+MY5+uJePwIkRQMvCwdmQsPC
	 eLHcoR/lViL3nDQqo8/G0kGGhJ/PIDcEnO0SyL5qTooZKyEzpOEFCs2FvtVjJ3BmAD
	 wJn53chs5naKjzvSbsgMWGf8g8Tju9DG2pjuIOy3IQxSPWyH4xTRSl3s+b/cc/5tfh
	 nI6sTweJyz8u5FrbTURBkKopxJYSmrzwW1tE4jvrPHbaMTj6iLLi6ZhR3gTTcU9+dQ
	 GQ3Bznacfjc9Dn4WMX0HAS2xbWVXjS4+mldIoQXSqHfh4RLZVSc7C3QE4o3ZdsVExu
	 Cne0X8tVp4EZw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DC4268902A;
 Thu, 17 Oct 2024 23:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729199678;
 bh=eUYiS0EmRRo5GBfhqsi+IJTRNKfPk9Ywkzy/OepXxYg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=haHOKkHOesbIn17dLjSKnFACKtXCHr8JGrphvUmMBpe9yJ0EePgGx51QFVfq79lz6
 P56CQKI+YIcgg7o5tXT8T5q0EC/zCm/zGzn5oEgNeeX1+/Ft70vnVv3t84TZAjbACB
 8PVmEN/rQ6NjwDxRWM4HJcDUZhcsH2jWmjQR1ydJepfztImRd/fK2qUj7WIvcKylNe
 1nsujv9AVRxRQSbqzji4GrrJWClnunLP4KWpgLlGrweKmeO6alzVOfCZqHZsmA9frj
 6NTjolL5RQcv2t3Rc2t4WZjHzcpCdmE2G5y1vzU4H5H3ne3/VQDggnMScRMr+Odzbz
 t3d87t91lP8Vw==
Message-ID: <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
Date: Thu, 17 Oct 2024 20:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
 <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
 <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
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

On 10/17/24 1:55 PM, Christoph Niedermaier wrote:

[...]

>>>>> +                            __func__, ret);
>>>>
>>>> This will be printed on every device, even the ones without ID EEPROM,
>>>> correct ? This should not be printed on devices without ID EEPROM. Also,
>>>
>>> This is suppressed by the -ENOENT check.
>>
>> Does i2c_eeprom_read() in dh_get_value_from_eeprom_id_page() return
>> -ENOENT in case the EEPROM is described in DT, but not populated on the
>> board ? I suspect it returns some other error code, -ETIMEDOUT or
>> -EINVAL maybe ?
> 
> It could only be possible if the DTO for hardware rev. 100 (which has no
> EEPROM ID page) is not loaded. The return value then is -ENODEV.
> I will included this in v2.

OK

>>>> Also, this shouldn't be repeatedly reading the EEPROM, the EEPROM read
>>>> operation is the slow part, the EEPROM is 32 bytes, so the EEPROM should
>>>> be read once and cached, and once the cache is populated all read
>>>> accesses to the EEPROM should use the cache.
>>>
>>> This is already covered in function dh_get_value_from_eeprom_id_page().
>> It seems that function always calls
>> ret = i2c_eeprom_read(dev, 0x0, eipa, sizeof(eipa));
>> ?
> 
> The 32 bytes are read into a static variable. If the ID (DHE) already exists
> in it, the i2c_eeprom_read() function is no longer called.
Hmmm, but it seems all the functions which access this EEPROM WLP are 
called from board_init(), are they not ?

If yes, then there is no need for any static variable:

board_init() {
  u8 eeprom[32];
  dh_read_eeprom_wlp(eeprom); // read the eeprom once
  dh_setup_mac_address(eeprom); // extract MAC from EEPROM
  dh_add_item_number_and_serial_to_env(eeprom); // extract SN from EEPROM
  // once this function exits, the eeprom variable on stack is discarded
  // which is OK, since it won't be used anymore anyway
}

[...]

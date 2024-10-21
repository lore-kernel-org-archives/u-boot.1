Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE92D17159
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 02:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B88C88F6B;
	Tue, 22 Oct 2024 04:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729562849;
	bh=AyA/gvFPJvVNaL2QTtgaVfJjzqmXa8K6GvheuVVGTN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kE1mnyberw1yCtL7AYGT6iqN+VV1hbY96RmK4Vf+YWio/w0vhferX39KR6RtZZuZh
	 RHkEEjzCNlDIQ787NhsMIfEnsSaYepw6OnDVmmccoyreZNL3QuGConuvu1S+1Gjwbs
	 x2d18nEY3B9abi8BXW3XfgKvksVruIrQLWofoU1+V1lXdjapRiscXBjaAb6W1LQrED
	 D8fz6sAz0kGL+trqKdAucvpKQnr2DHA2uK8PumhTsGyOOhJ9Lh7GkrPqfwNYvFgHdF
	 ai8mC7sQ/D/M6qaXxuaR8vkLSnP72nBTCizErlBgy/DdqjVjKVAlidAYPZP9SRazq0
	 4407/kKWV/q0w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C535C88F66;
 Tue, 22 Oct 2024 04:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729562848;
 bh=AyA/gvFPJvVNaL2QTtgaVfJjzqmXa8K6GvheuVVGTN4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WMAkSjq6YcRdcGid/v5+aefcSLhgc1YErZl1+aUSIgkWBP3/3s2rQi5gFQGlEBJxH
 US31YWCeJ0S+0KDZtDbIMve3070rMs8mvr14rVuqR696MdiGw4sceh4/sFr+AoKX+2
 3F99RqOBxlmdUUfgppgBB2s60IKUfrFgVfxpil6QpCSm0tZMra5QB0kK12n9/Ey4Fp
 l1iLkI4jB6y7YPreu21ZY64l20TlL0+R2Rc4UVo/NJHrg1ZhcD/J12zXMiptddzJi4
 4p+CEYvDMzEsfwd86yZGdsJDdcJiE6kKofeeSnW9AjO8UKD4QrfHA8Z2RUP+kOCU99
 ppstZcoASIINg==
Message-ID: <a0f70ee2-6d71-4f66-b22e-994df2b28504@denx.de>
Date: Tue, 22 Oct 2024 01:00:40 +0200
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
 <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
 <7b9b543d7aad498591fa6a04a3154cf8@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <7b9b543d7aad498591fa6a04a3154cf8@dh-electronics.com>
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

On 10/21/24 5:38 PM, Christoph Niedermaier wrote:

[...]

>> If yes, then there is no need for any static variable:
>>
>> board_init() {
>>    u8 eeprom[32];
>>    dh_read_eeprom_wlp(eeprom); // read the eeprom once
>>    dh_setup_mac_address(eeprom); // extract MAC from EEPROM
>>    dh_add_item_number_and_serial_to_env(eeprom); // extract SN from EEPROM
>>    // once this function exits, the eeprom variable on stack is discarded
>>    // which is OK, since it won't be used anymore anyway
>> }
> 
> The idea is that function dh_add_item_number_and_serial_to_env() encapsulates
> the reading.

The function which interacts with the EEPROM on start up, once, can have 
this name, sure.

> I don't want to have to worry about the structure and number of
> bytes of the EEPROM ID page and want to be independent of it. It is planned to
> extend the structure and increase the number of bytes for the STM32MP2. The
> changes to the size will then depend on the version of the data in the header
> within the structure.

It is OK to allocate 32 or 64 bytes on stack, since that chunk of memory 
is free'd on return from the function. The lifespan of that allocated 
memory is exactly as long as it should be, and it does not waste U-Boot 
memory unnecessarily.

So far, all known EEPROMs have WLP size of 32 or 64 Byes.

> However, these changes should then only have to be made
> within the function dh_add_item_number_and_serial_to_env() for reading the
> EEPROM ID page. I accept the static variable in order to better isolate the
> function.

This can very well be:

dh_add_item_number_and_serial_to_env() {
    u8 eeprom[32];
    dh_read_eeprom_wlp(eeprom); // read the eeprom once
    dh_setup_mac_address(eeprom); // extract MAC from EEPROM
    dh_add_item_number_and_serial_to_env(eeprom); // extract SN from EEPROM
    // once this function exits, the eeprom variable on stack is discarded
    // which is OK, since it won't be used anymore anyway
}

board_init() {
   ..
   dh_add_item_number_and_serial_to_env();
   ...
}

> Since the memory is freed up again when the operating system boots,
> this consumption of 32 bytes in U-Boot is not a problem, because it is only
> temporary.
This is not good, please do not waste memory in U-Boot if it can be 
easily avoided by automatically allocating it on stack and freeing it 
when not needed.

[...]

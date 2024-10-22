Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B649D2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3248488F5B;
	Tue, 22 Oct 2024 14:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729601542;
	bh=BBxmV8I+VpH4FEU2fvsNegWji0IrDl9Xbb+NvstxAn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7OHexaAdO/oBbDJ1t/6YFioFZzZW/l7gobJzKaTuPu65HxK3r3id4atQ8JV2L50k
	 +CBcY2ftSzu3FQxco01DMCFzhglN2RYh88zRbsIV+X0/wPqhU9NXom62Ng6kl+4dZp
	 4GPildVr8pdM91epEO33HY3lEp15oVil1eeLOaruxc7EoAwrSsh3MVxcMTrsrYDTt3
	 vBd8fpl6qTRw5PLj64hIjrTE9rn+n/QBnN1l03j8D2dF5AuUmZR3bSHm242mCYA3cm
	 WOFPiLMHb9jIW+NWmzcDb5VHJpD6QIhDq4sGk3I8cj2zeGpiTT/QgZ78aM4SsWMVgK
	 8a9VGQUnPB2oQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ACFEC88DFD;
 Tue, 22 Oct 2024 14:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729601541;
 bh=BBxmV8I+VpH4FEU2fvsNegWji0IrDl9Xbb+NvstxAn0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C62xfNU2wbStxSmsYu4N7wF1bonsGg4lXaytdp2kLMG7FQtpt0R882dvZFkT2POrB
 He5AuY6JGTfaiNcPbKV/sfiF4L+uKelr2E3oSz8eivziDxEZt/GNZFoZCM4rXei2fa
 Rfog69lUHX0DYClCaASs4+CTTR7pLctFC8sCsMA+Oae/P79Xx89wnOFn9dxLC/zc7+
 mr+lSatugdYUxpmuTTOZIdvV2sfQc2pznS/n+xwsFwEwTO9PSn0YwJDqXL+as4MEvI
 EWr6l11Vct/oRDI3rmw6T5EIry/FdfrMJ5S2kF5iske+otT/fHzbRRXMVtE257A1NQ
 9o4rDKLgyoHvw==
Message-ID: <009179c8-5512-4ba6-beeb-2d508dd5abd8@denx.de>
Date: Tue, 22 Oct 2024 13:57:24 +0200
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
 <a0f70ee2-6d71-4f66-b22e-994df2b28504@denx.de>
 <d06620ee891f4e419bfeb8fe657ba729@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d06620ee891f4e419bfeb8fe657ba729@dh-electronics.com>
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

On 10/22/24 11:31 AM, Christoph Niedermaier wrote:
> From: Marek Vasut <marex@denx.de>
> Sent: Tuesday, October 22, 2024 1:01 AM
>> On 10/21/24 5:38 PM, Christoph Niedermaier wrote:
>>
>> [...]
>>
>>>> If yes, then there is no need for any static variable:
>>>>
>>>> board_init() {
>>>>     u8 eeprom[32];
>>>>     dh_read_eeprom_wlp(eeprom); // read the eeprom once
>>>>     dh_setup_mac_address(eeprom); // extract MAC from EEPROM
>>>>     dh_add_item_number_and_serial_to_env(eeprom); // extract SN from EEPROM
>>>>     // once this function exits, the eeprom variable on stack is discarded
>>>>     // which is OK, since it won't be used anymore anyway
>>>> }
>>>
>>> The idea is that function dh_add_item_number_and_serial_to_env() encapsulates
>>> the reading.
>>
>> The function which interacts with the EEPROM on start up, once, can have
>> this name, sure.
> 
> Sorry, I mean the function dh_get_value_from_eeprom_id_page() here.

The function name doesn't really matter, please pick a fitting one.

>>> I don't want to have to worry about the structure and number of
>>> bytes of the EEPROM ID page and want to be independent of it. It is planned to
>>> extend the structure and increase the number of bytes for the STM32MP2. The
>>> changes to the size will then depend on the version of the data in the header
>>> within the structure.
>>
>> It is OK to allocate 32 or 64 bytes on stack, since that chunk of memory
>> is free'd on return from the function. The lifespan of that allocated
>> memory is exactly as long as it should be, and it does not waste U-Boot
>> memory unnecessarily.
>>
>> So far, all known EEPROMs have WLP size of 32 or 64 Byes.
>>
>>> However, these changes should then only have to be made
>>> within the function dh_add_item_number_and_serial_to_env() for reading the
>>> EEPROM ID page. I accept the static variable in order to better isolate the
>>> function.
> 
> Sorry, here I mean also the function dh_get_value_from_eeprom_id_page().
> 
>> This can very well be:
>>
>> dh_add_item_number_and_serial_to_env() {
>>      u8 eeprom[32];
>>      dh_read_eeprom_wlp(eeprom); // read the eeprom once
>>      dh_setup_mac_address(eeprom); // extract MAC from EEPROM
>>      dh_add_item_number_and_serial_to_env(eeprom); // extract SN from EEPROM
>>      // once this function exits, the eeprom variable on stack is discarded
>>      // which is OK, since it won't be used anymore anyway
>> }
>>
>> board_init() {
>>     ..
>>     dh_add_item_number_and_serial_to_env();
>>     ...
>> }
>>
>>> Since the memory is freed up again when the operating system boots,
>>> this consumption of 32 bytes in U-Boot is not a problem, because it is only
>>> temporary.
>> This is not good, please do not waste memory in U-Boot if it can be
>> easily avoided by automatically allocating it on stack and freeing it
>> when not needed.
>>
>> [...]
> 
> I don't want to allocate the memory in the function board_init().

You do not, the following automatically reserves space on stack when 
called and frees it up upon function return:

function foo() {
   u8 array[12];
   ...
   stuff(array);
   ...
}

> I want to handle
> size and caching in the function dh_get_value_from_eeprom_id_page(). So I don't
> want to deal with size and structure in the function board_init(). For me, the use
> of a static variable is OK, but you don't like it. Do you know how I can do this
> without assigning a static variable, but not allocate the memory somewhere in a
> caller function?
Even the static variable space is allocated somewhere, either in .bss or 
.data section, except with static variable(s) the memory persists 
throughout the lifetime of U-Boot because their content has to be 
retained even when the function using their content returns.

With variable(s) allocated on stack (which is majority of variable), the 
memory allocation happens on entry to the function and the memory is 
automatically freed on exit from the function.

It is perfectly fine to call some wrapper superfunction from 
board_init() which holds the array on stack and calls all the EEPROM 
parser/handler functions:

eeprom_superwrapper() {
   u8 eeprom[64];
   ...
   eeprom_do_stuff1(eeprom);
   eeprom_do_stuff2(eeprom);
   ...
}

board_init() {
   ...
   eeprom_superwrapper();
   ...
}

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7967CCF538D
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 14:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6956891E9;
	Wed, 23 Oct 2024 16:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729692291;
	bh=sXvWU+8z7Q5X6V3cWFeNvID219qrfx7L7eJ68mVPAmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jW4j01cmjUJGZZVCJiNYon9uAJo6sLMAX0qrRRi/gJS8v+Beem29o5KHyIY96gVjf
	 5Ny10OBVX0X34yky9GV+/XJI/Adn3AkdDTz2kZRma19ngm2Iafp/C5+hNY3OcCvVP4
	 vmbBuP+cOAIgQ9k40AeSVIUYFp7/fkekIzJdwbhrke2SZg0CRkZl5JtLaYUpQBL6QW
	 n6soduETh7+U9e21sqaYMgdSqicRVayeqYj4dgR7v8MBDcaw6jFRUtHNpGN/2Pcsa9
	 aVLS0qQYTYeuKWvVa5pGQLZc5ledBfhI+ZpqQ05/+50heQhKMK+LEZozh7sfPhCIyi
	 Tok/QdwJ5jsew==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E5CAB892E0;
 Wed, 23 Oct 2024 16:04:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729692291;
 bh=sXvWU+8z7Q5X6V3cWFeNvID219qrfx7L7eJ68mVPAmw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gS1qos/xk7JhJivWeV6xOoQbCj9+KBVMFvx1xJAfIUnhsNm3VdS2PvujDToQsn0+h
 iTVqJ7t2dA4vYXmK5dBFoSMUbrfVFyb5JyqSmufmX+aSc7niLLMKhsSBO2clu954mO
 f2KHYCco8uSwkHiUzuZm8ANVLoN5JQ+O4k64tlt7kouAl3n7HVi5GCQQgxCTd/Cs9a
 tsb41VnheHhHFGCbZICZKrmVaOwX64TT9atw9Hm271qJ+xGC8j7FEgkXsPsXzoWKIO
 gwwlZ8p4x13PacG8xx9WTKDrYDmmUt6l7R2tsL3aXlWhXaK7eSa54e7pHvXrfRb+uC
 yD+ukZ6udLd4w==
Message-ID: <c9d142f6-05ca-4fab-8016-3f545e6538d0@denx.de>
Date: Wed, 23 Oct 2024 16:04:45 +0200
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
 <009179c8-5512-4ba6-beeb-2d508dd5abd8@denx.de>
 <bef41c1fefeb422e9e1b8f8f0d241a13@dh-electronics.com>
 <1fd571bc-d133-4e91-8ab6-45e6e7429027@denx.de>
 <95c20aac320049eda6a324d360743691@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <95c20aac320049eda6a324d360743691@dh-electronics.com>
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

On 10/23/24 3:20 PM, Christoph Niedermaier wrote:
> From: Marek Vasut <marex@denx.de>
> Sent: Wednesday, October 23, 2024 2:41 PM
>> On 10/23/24 2:18 PM, Christoph Niedermaier wrote:
>>
>> [...]
>>
>>>> You do not, the following automatically reserves space on stack when
>>>> called and frees it up upon function return:
>>>>
>>>> function foo() {
>>>>      u8 array[12];
>>>>      ...
>>>>      stuff(array);
>>>>      ...
>>>> }
>>>
>>> Sorry, I expressed myself incorrectly here. Of course I meant that
>>> I don't want to reserve memory on the stack for the EEPROM ID page
>>> in the board_init() function.
>>
>> Why ?
> 
> It's about structuring the software. I want to isolate the function which
> is responsible for evaluate the EEPROM from the caller function. I wanted
> to avoid entangling the two. This means that I, as the caller of the function,
> do not have to worry about the internal structure of the EEPROM ID page.

You are only passing in a block of unstructured memory allocated on 
stack, u8 block[64].

>>>>> I want to handle
>>>>> size and caching in the function dh_get_value_from_eeprom_id_page(). So I don't
>>>>> want to deal with size and structure in the function board_init(). For me, the use
>>>>> of a static variable is OK, but you don't like it. Do you know how I can do this
>>>>> without assigning a static variable, but not allocate the memory somewhere in a
>>>>> caller function?
>>>> Even the static variable space is allocated somewhere, either in .bss or
>>>> .data section, except with static variable(s) the memory persists
>>>> throughout the lifetime of U-Boot because their content has to be
>>>> retained even when the function using their content returns.
>>>>
>>>> With variable(s) allocated on stack (which is majority of variable), the
>>>> memory allocation happens on entry to the function and the memory is
>>>> automatically freed on exit from the function.
>>>>
>>>> It is perfectly fine to call some wrapper superfunction from
>>>> board_init() which holds the array on stack and calls all the EEPROM
>>>> parser/handler functions:
>>>>
>>>> eeprom_superwrapper() {
>>>>      u8 eeprom[64];
>>>>      ...
>>>>      eeprom_do_stuff1(eeprom);
>>>>      eeprom_do_stuff2(eeprom);
>>>>      ...
>>>> }
>>>>
>>>> board_init() {
>>>>      ...
>>>>      eeprom_superwrapper();
>>>>      ...
>>>> }
>>>
>>> That's not what I'm looking for. Do you have another solution?
>> No. I do not understand what is the problem with allocating 64 Bytes on
>> stack ?
> 
> There is no problem with the reservation of the EEPROM buffer on the
> stack. I wanted to isolate the evaluation function from the caller
> function, so that I have no dependencies on the caller. Since there
> seems to be no better solution, I will add the variable to the
> board_init() function in V2.
There seem to be multiple functions using the same data, so you have to 
pass pointer to those data around.

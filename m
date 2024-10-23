Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D845DCF537D
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 12:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417FF8925A;
	Wed, 23 Oct 2024 14:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729687277;
	bh=MUbGpN1Qa8oXE5inPCFcVkj/cP23liA9GjdjZZG/3B0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZAppI8WaK4/c4AxTTG41UM4Ygcd9z3Mt/l3g/xzKWnCvlmnKWoWM/QqMQFK16jG8u
	 AEE8OaQ5UNkzKt6S4O0fl5UhhF6BFNystq6rxZiWAIZyLa3MvtA0g8xi2yOOhxdjQ/
	 hsnWhBmwBKoN9VVK/K7BVFIhQkTKGL9tloOOJbPXh3efZq9nYkyRRZPG+wZDLz0eGo
	 tAXyVALH2jc9Vk6bWWXLUQNZmBp8Gi+h5auoVBbg4534Iwnsxv+oeALmf5JYXsw+Ur
	 Ae/yq8fPx7Hfc+QycZ/PsNoqVGjMrLY9Ma7F3mu9vegYXJiuAEyEUIHVlPV21cwDtA
	 GicILxGTITLng==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4359088DD9;
 Wed, 23 Oct 2024 14:41:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729687275;
 bh=MUbGpN1Qa8oXE5inPCFcVkj/cP23liA9GjdjZZG/3B0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GggNH50LrfQWUd253uBkUycOotMO0Zb1p16lHqTfV95hZXWjETxss4aaxR4jhcTD1
 ZrhvayyarttGcMu6gMuDSRwtohsxlT/UGQFaCw3J5dLR8oAu9kD/vfj8ENlDnFMkb+
 dCdjaFxATVBkKAnjDtQ7KJQRE9ze4XPa4YqNHzfutKL4o8QRJBG0E0qp3olLY5h9lM
 cILr3OrQ5vcFC+San4+4BXf9yDazYZ8s3gSeS8OD/Q6/CmOGgaJjWSRTydH2oc715Z
 FNJYK3IXO51DkFTDXLWSgxamwJp4PWLy72F2DozREMutxeTonUj+46D259xjuOTV/T
 OkV5vvCoonKdw==
Message-ID: <1fd571bc-d133-4e91-8ab6-45e6e7429027@denx.de>
Date: Wed, 23 Oct 2024 14:41:09 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <bef41c1fefeb422e9e1b8f8f0d241a13@dh-electronics.com>
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

On 10/23/24 2:18 PM, Christoph Niedermaier wrote:

[...]

>> You do not, the following automatically reserves space on stack when
>> called and frees it up upon function return:
>>
>> function foo() {
>>     u8 array[12];
>>     ...
>>     stuff(array);
>>     ...
>> }
> 
> Sorry, I expressed myself incorrectly here. Of course I meant that
> I don't want to reserve memory on the stack for the EEPROM ID page
> in the board_init() function.

Why ?

>>> I want to handle
>>> size and caching in the function dh_get_value_from_eeprom_id_page(). So I don't
>>> want to deal with size and structure in the function board_init(). For me, the use
>>> of a static variable is OK, but you don't like it. Do you know how I can do this
>>> without assigning a static variable, but not allocate the memory somewhere in a
>>> caller function?
>> Even the static variable space is allocated somewhere, either in .bss or
>> .data section, except with static variable(s) the memory persists
>> throughout the lifetime of U-Boot because their content has to be
>> retained even when the function using their content returns.
>>
>> With variable(s) allocated on stack (which is majority of variable), the
>> memory allocation happens on entry to the function and the memory is
>> automatically freed on exit from the function.
>>
>> It is perfectly fine to call some wrapper superfunction from
>> board_init() which holds the array on stack and calls all the EEPROM
>> parser/handler functions:
>>
>> eeprom_superwrapper() {
>>     u8 eeprom[64];
>>     ...
>>     eeprom_do_stuff1(eeprom);
>>     eeprom_do_stuff2(eeprom);
>>     ...
>> }
>>
>> board_init() {
>>     ...
>>     eeprom_superwrapper();
>>     ...
>> }
> 
> That's not what I'm looking for. Do you have another solution?
No. I do not understand what is the problem with allocating 64 Bytes on 
stack ?

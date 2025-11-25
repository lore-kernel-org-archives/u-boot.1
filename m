Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D24D0E6FF
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 15:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 851F8840D8;
	Tue, 25 Nov 2025 16:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kzzupLmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BA1840E0; Tue, 25 Nov 2025 16:38:54 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C583D83F75
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 16:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dG6L069ftz9vRj;
 Tue, 25 Nov 2025 16:38:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764085128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evdPJP8+m5gD5kt6QweUcdTtZYE80PzHPHGOKOG9PX0=;
 b=kzzupLmDXCMr4Rug56tW4tHR03U8JMDHfwwIyeuoRZLTQOUgc4cwfDTHAdNrRbMrmJGeCC
 brlwuneEB9lQaz9+dBEPR6y4cBtxHEaINlmWlfZ9V89ufBwEtCiidxsYZc+iUfuAeFKJed
 gBbWKKGP9xl/ZmJQ8721sDz95veA3finTeoXfI+QfJC9YemgoNqJhZkfvRetwrf/7+5K5D
 jsxzghJqkv18TY5ZKoyJnJGM72o2gq3rzRLpEnoe4QdGd2pJT99MmWZd2zKUb8n01uB7yF
 yTJ7gpWi0mDBmy3u7kmfDoYwNTJg/JZNwo7aPu7E+kBPh6959OHXeWWamUSqcw==
Message-ID: <d99ac773-1728-4a0e-8be9-507fdd6f6116@mailbox.org>
Date: Tue, 25 Nov 2025 16:38:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mkimage: Add support for bundling TEE in mkimage -f auto
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Carlos_L=C3=B3pez?= <carlos.lopezr4096@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 u-boot@dh-electronics.com
References: <20251118232045.578034-1-marek.vasut@mailbox.org>
 <9e9ec219-3ae7-4ec8-8f85-5edb4bbbe53a@cherry.de>
 <7b21c476-ed12-48da-95f7-dd354e116a70@mailbox.org>
 <9bb15fc9-7434-4ba4-814b-d99cdcd7a4f8@cherry.de>
 <889f9772-a50f-47e2-a678-1316a8be296a@mailbox.org>
 <b3d8ae61-1549-4126-807b-22f85ce4894c@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b3d8ae61-1549-4126-807b-22f85ce4894c@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 73040293da8f9cd6fee
X-MBO-RS-META: exzp8i4ex53mm6r4u6usteckr6nx3ucm
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

On 11/25/25 4:18 PM, Quentin Schulz wrote:

Hello Quentin,

>>>>>> Example invocation:
>>>>>> "
>>>>>> $ mkimage -E -A arm -C none -e 0xc0008000 -a 0xc0008000 -f auto \
>>>>>>            -d arch/arm/boot/zImage \
>>>>>>            -b arch/arm/boot/dts/st/stm32mp135f-dhcor-dhsbc.dtb \
>>>>>>            -z ../optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin \
>>>>>>       -Z 0xde000000 \
>>>>>>            /path/to/output/fitImage
>>>>>> "
>>>>
>>>> ...
>>>>
>>>>> Which formats are supported for the --tee-file parameter? OP-TEE OS 
>>>>> itself has multiple versions for the binary header (v1 and v2?) and 
>>>>> we can pass either a binary (tee.bin) or an ELF (tee.elf) in 
>>>>> binman, c.f. tools/binman/etype/tee_os.py
>>>>
>>>> The raw binary only, see the example invocation above.
>>>>
>>>
>>> Must be documented then please.
>>
>> Where would you document this ? In the manpage ? Elsewhere ?
>>
> 
> Wherever the user can see it when using the tool. The manpage for sure 
> yes. Maybe in the mkimage usage help string but I'm worried it'll make 
> it harder to read.

Done in V3

> Also, turns out that one really is supposed to use the raw binary format 
> for OP-TEE OS (since 3.8.0). I had missed that part so it kinda makes 
> sense to only support that, after all 3.8.0 is already 6 years old! 
> Blobs from Rockchip do have a .bin extension so I assume they are raw 
> binaries.

[...]

>> Neither of the binaries listed above is TEE ?
>>
> 
> Oopsies. Got distracted by reviewing both tf-a (already merged) and tee 
> support in mkimage -f auto. So this applies to TF-A part only, where we 
> (Rockchip) use the ELF file (for Rockchip blobs; maybe upstream TF-A is 
> loadable in raw binary form as well?) and that is split by binman. Since 
> one is supposed to use the raw bin for OP-TEE OS and that binman doesn't 
> actually split this into multiple entries, this doesn't apply, sorry for 
> the noise.
No worries, thank you for checking !

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA90EC83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 21:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E49882D21;
	Mon, 28 Jul 2025 23:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="R9RaUwCP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qpTIDr6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FB282F00; Mon, 28 Jul 2025 23:44:19 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60465829E7
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 23:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4brX740zFVz9tbD;
 Mon, 28 Jul 2025 23:44:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753739056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BByOQ+ZrfUxnzecuIOkMSF38nrkiVllYmrJ6wrTzslQ=;
 b=R9RaUwCPR7tucc+UrMQgwJiS6pUoaTl5k/T59qlDv2T7ysDam/+AoUh1B4bAykRYK5MbWE
 nixKCf4ub5O7kptHkLd0/UM5mhPS8vRZReIYhPFheKpGTvc8knFwYKRHlOTx1fP0Oc7xzM
 yIPnrcL+MQecNH3RqqaJt+OErtAQLbAjtgp/G0lo12YocLlJCjzJivCL7WyqOb5cs2Nuf1
 otocQCik2EIUBp/YlbqIW4gB10lu7eoEglLARaR9WIU4Tt8nprBuoX4LzGZYX4HrRVh9IL
 kOrRK3SFNsK/b8VU/c1HylgJIbIA7WOeJXz5NAGXfjSXm91fwm14+ilgCJS09w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qpTIDr6x;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <64b05f5d-b5c5-4aca-b326-0dbc720009be@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753739054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BByOQ+ZrfUxnzecuIOkMSF38nrkiVllYmrJ6wrTzslQ=;
 b=qpTIDr6xOgliFKVi9DDIVTWeV3BOswneCJBDlqqHrXugKlY3EI0m0DdlrpkgnEh+BdmL0Q
 c4/QoFMVDZvnRYXt4bRBKBn3Nwr2ZjXwFHRK3v4V5C2VOQ50Pn6hwipwMQtBfiyJdRVyju
 buF99VBPKrEnuIzmfL/sq9zK9xHFAWUMrLe/4NAupEeCAeXiuuvfBhmRKB13lf0jGAimZl
 a8vso1WBi1UPLGuPG/SZUVzPt5ifzuhBZrfMvyx6tqYgDCPH7kAkJ5napvlIbpDFCQU9eC
 d8a7/S8zbukcR+/TwITc875MbtgniORALFP84SIMSeJjHJOpMUNxAffblvFG9g==
Date: Mon, 28 Jul 2025 23:44:10 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
To: frank-w@public-files.de, "Lucien.Jheng" <lucienzx159@gmail.com>,
 u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 tien.fong.chee@altera.com, trini@konsulko.com, sjg@chromium.org,
 xypron.glpk@gmx.de, seanga2@gmail.com
Cc: lucien.jheng@airoha.com, daniel@makrotopia.org
References: <20250727141609.15425-1-lucienzx159@gmail.com>
 <2f6dcd69-1e18-4a9a-a07e-9b59f79212da@mailbox.org>
 <f4be2285-eb0a-49c1-8595-a73a231465e8@gmail.com>
 <F1C856C7-A075-4EFA-A39B-905A9C40D524@public-files.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <F1C856C7-A075-4EFA-A39B-905A9C40D524@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n8rz3kiqy45hk7uk8b6cio3geoekrwmx
X-MBO-RS-ID: d3d3f4d183526a7f4d5
X-Rspamd-Queue-Id: 4brX740zFVz9tbD
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

On 7/28/25 8:08 PM, Frank Wunderlich wrote:
> Am 28. Juli 2025 18:34:01 MESZ schrieb "Lucien.Jheng" <lucienzx159@gmail.com>:
>>
>> Marek Vasut 於 2025/7/27 下午 10:46 寫道:
>>> On 7/27/25 4:16 PM, Lucien.Jheng wrote:
>>>> This commit introduces a new API, request_firmware_into_buf_via_script(),
>>>> to the fs_loader framework.
>>>> This function allows firmware to be loaded into memory
>>>> using a user-defined U-Boot script,
>>>> providing greater flexibility for firmware loading scenarios that cannot be handled
>>>> by static file paths or device/partition selection alone.
>>>
>>> Please run some 'fmt -w 72' on the paragraph above.
>> Got it. Will modify for the next version.
>>> [...]
>>>
>>>> I've validated this API on the Banana Pi R3 Mini. Here are my test commands and logs:
>>>> 1.  `env set en8811h_load_firmware 'env set fw_addr 0x46000000 && env set fw_size 0x24000 && load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin
>>>
>>> The 'load' command sets $filesize variable AFTER the load completed. The $filesize variable contains the actual size of the loaded data. You will likely need to expand the script a bit:
>>>
>>> env set fw_addr 0x46000000 && env set fw_size 0x24000 && \
>>> mw.b ${fw_addr} 0 ${fw_size} && # Make sure the memory backing the
>>>                                  # firmware is initialized to some valid
>>>                                  # content.
>>> load mmc 0:3 0x46000000 /boot/EthMD32.dm.bin && \
>>> if test ${filesize} -lt 0x4000 ; then # Validate that the size of loaded
>>>                                        # data is correct
>>>    load mmc 0:3 0x46004000 /boot/EthMD32.DSP.bin
>>>    # Validate loaded data size here again
>>> else
>>>    env set fw_size 0                   # Indicate failure
>>>    exit 1
>>> fi
>> OK. I will expand the script you mention.
>>>
>>> [...]
>>>
>>> Looks pretty good otherwise I think , thanks !
>> Thank you for your great advice.
> 
> Hi,
> 
> Is it possible to trigger it from uboot console?
> 
> E.g. setting these vars from there and then call the firmware load function and maybe network init?
For some devices (like PCIe and USB) it might be possible, since those 
are initialized after 'pci enum' and 'usb start' . For devices which are 
started early, set the script, saveenv , and reset. For some devices it 
might be possible to experiment with this using CMD_BIND too.

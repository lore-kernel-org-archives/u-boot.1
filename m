Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DADC7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 22:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32F3882ED0;
	Mon, 30 Jun 2025 00:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ffL1gW5p";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Uhe6TExS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE2482F28; Mon, 30 Jun 2025 00:49:17 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6F382D4E
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 00:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bVkxK6Zskz9sX2;
 Mon, 30 Jun 2025 00:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751237349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnwVwiC1OTEjY3vgBW/K8HftKoubtgH3EHxoWe2mYrw=;
 b=ffL1gW5pT7QANl/AIFcwmMuuMGppYFAMl4sYqnh8ODV1bgyaVh9llV/ktlQOoTSMX+oW0X
 Z2utJgMx8t8EUCBUZTM8/KTE1IMKGo/K954jE0vbNut8Iunk5EOgygZuVmMWRbu4u8wuw4
 q05U3ZI6RFLt62J7xotvFNo3Sh0uGkKDKquylU3A9WXNEDKDKu8iAVIFo6EAtfeBAj7VLj
 AO4nJMjkqda3IXuBUaEUZF+yuavU6MXlGDBI+FpWzdpMdDlCwLDIOp3DMQKicHAgvgKAGy
 +4gM9lhGmPBAlv+LcVVI5e2EH3yZCv0Bvt8PuC6P2fvN0HezZsdfxs75txsqiQ==
Message-ID: <7e7c7608-fd84-4826-9507-1b4e2089a5f4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751237344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnwVwiC1OTEjY3vgBW/K8HftKoubtgH3EHxoWe2mYrw=;
 b=Uhe6TExS8FkfBSAkE0vtKwazdxQQy2lJMvdVtie39iCa6mf7fzk6qJzSfKJHoPv+ewpNzw
 3Tq5CA3jm7oCmtXAaFzhmP0Nb6z/8xiUeU7jUc9Lu3ZPC7f4OZqdB+8hXyoNkgcpyX21sC
 aV3pjW56DglP5ns3gZGDfpxynmoXpWmgBM0FFesScN3Pz/FLrkCn+aM9gh0EfxaCXaLoyA
 pi77IwaEJjlAQl2Gm6bwmNpPgAwuJMvOZOlGVLBB/IjeCUaovue9ThdzVMaER8rBYKaOsz
 lpbk8zbPitQcdH5XBoa5SoB86ongGPkyMs/qCpMIA3K76EGk6CVTHNFUC9rqvw==
Date: Mon, 30 Jun 2025 00:49:00 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 Vagrant Cascadian <vagrant@debian.org>
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250615131243.30770-1-lucienzx159@gmail.com>
 <995a016a-f873-440c-acb7-b18568003e41@mailbox.org>
 <24750b55-0d68-44c0-aed6-c69c7a40dafb@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <24750b55-0d68-44c0-aed6-c69c7a40dafb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: huos4iak8yb3hhk6fixz94tcenmww75q
X-MBO-RS-ID: a8ad5ea7e17cda39b7d
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

On 6/29/25 6:10 PM, Lucien.Jheng wrote:

Hi,

I'm sorry for my abysmally slow response.

>>> +config PHY_AIROHA_FW_IN_MMC
>>> +    bool "Airoha firmware in MMC partition"
>>> +    help
>>> +      Airoha PHYs use firmware which can be loaded automatically
>>> +      from storage directly attached to the PHY, and then loaded
>>> +      via MDIO commands by the boot loader. The firmware is loaded
>>> +      from a file specified by the PHY_AIROHA_FW_PART,
>>> +      PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.
>> I ran into the same firmware loading problem recently. I took a 
>> different approach, have a look at [1] and specifically function 
>> rcar_gen4_pcie_load_firmware() . This invokes U-Boot shell script , 
>> which has to be defined by the user, and which loads the firmware by 
>> whatever means necessary, from whatever storage or location . I think 
>> that might be the generic approach to U-Boot firmware loading . If the 
>> user needs to change the firmware loading location, they do not need 
>> to rebuild the U-Boot itself, they simply update their environment and 
>> the matching script. What do you think ?
>>
>> [1] https://patchwork.ozlabs.org/project/uboot/ 
>> patch/20250617081641.8385-5-marek.vasut+renesas@mailbox.org/
> 
> Hi Marek
> 
> I've looked at the `rcar_gen4_pcie_load_firmware` API. As you mentioned, 
> it allows users to set the storage and location from the U-Boot shell, 
> meaning they don't need to recompile U-Boot.

Yes, that's the goal there.

> However, I recently checked out `FS_LOADER` and realized it's 
> essentially the same approach as how I'm currently placing firmware on 
> eMMC, just with a unified API(request_firmware_into_buf).
> 
> I'm wondering if there's a future possibility to integrate U-Boot shell 
> scripts into `FS_LOADER`?

I think it would be ideal to have one unified firmware loading code, so 
the answer to the "if" part of the question is "yes".

I have yet to think about the "how" part. If you want to give it a try, 
please do.

> Also, given that the Kernel has a built-in firmware mechanism where 
> files are compiled directly into the Kernel image, I'm curious if U-Boot 
> might adopt a similar approach in the future. I'm also considering if 
> `binman_sym` could be a viable alternative.

I'm not a lawyer. My understanding of this firmware bundling is, that 
this is a legal minefield which is better avoided, and also causes 
redistribution problems with prebuilt U-boot binaries. You end up 
bundling together GPL code (U-Boot) and non-GPL code (firmware blobs), 
and the final license of the result is unclear to me.

+CC Vagrant, since they have insight into this from Debian side.

> For the short term, though, I'll go ahead and submit the EN8811H 
> firmware loading method using the `rcar_gen4_pcie_load_firmware` 
> approach. I'll then explore potential improvements later.
Please wait a bit for input from the others. Also keep in mind, that 
rcar_gen4_pcie_load_firmware() is non-generic interface specific to that 
one driver, you would have to implement something similar in this driver 
, with different variable names .

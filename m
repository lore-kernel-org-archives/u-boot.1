Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8EDCCFA00
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 00:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADE483700;
	Mon,  3 Nov 2025 01:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WU1/ug74";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K5QKPK8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08627838A5; Mon,  3 Nov 2025 01:46:09 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1398B83642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 01:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d0CZ64FYDz9smd;
 Mon,  3 Nov 2025 01:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762130766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwD0CwJ/aJF8D22QzuLB0gl1+a302jWxSh6KwlkxWb0=;
 b=WU1/ug74xaHp+8+XNwqjufu7siM5/0CdWtkzG7NOaULPv6FM2tQOCm4NSKtzDcYr65D4jV
 rV6qcG/iERH1oCCMcMQFvIaTyLGkIAqVbuSgn9uDrmzWXSe97sJhJr64Oohe1IruIQZyIT
 Gtz+SE7FjwzVNbVa+tCyIZvjSF1bX77yBBruV3BvurcLJDei9KwN5HTjz9mH4ics0qoqax
 zILOhvY0Xh9QVI+irIlWxc9mOAKhbBbTDPrH3yg04Mtd4khZw6fnbAkl+ugwyTlZG++wIK
 MV1tGl/W5SY5tyC2oZrKhEA6khVc6Kn2CMMd+N0GvARvuf72XDbLv9O1YuABEA==
Message-ID: <291d4a3b-0839-4692-9284-7a13d4d9be13@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762130764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwD0CwJ/aJF8D22QzuLB0gl1+a302jWxSh6KwlkxWb0=;
 b=K5QKPK8rHOfEu14D5es8CmjIylXZ+k+Lwf7rkxRq8VMJ5BAeCzVUxmVdalw5lHCPASmnxK
 MlwosS/LEzfT/7XMIT2dupF4lCP5qryIjLEFiRoBtUy3dGR3wJlrbOwHSN1WRKSV+pKmqh
 oY69iIvAmUHHKxTDCcOaM5oogXnzw8IBmsVwA6wr83GWZQZ/lYZIB15qYWg0GO42jElo4h
 IP+80fn0pHdenW//EyoqKxj35lA3iE3hdAuhxh4d5VJYHxsoSKhKiAjUdXYwlWnDDzjRVB
 xpsAusjOfz+RnG9vBV01pvAV/nWGpckEux6NYGGCl8Rep14JvetyTLN/C4CWQw==
Date: Mon, 3 Nov 2025 01:46:01 +0100
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
To: Lucien Jheng <lucienzx159@gmail.com>
Cc: jerome.forissier@linaro.org, skylake.huang@mediatek.com,
 s-vadapalli@ti.com, paul.barker.ct@bp.renesas.com,
 marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de,
 lucien.jheng@airoha.com, Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
References: <20251006124915.13647-1-lucienzx159@gmail.com>
 <2f894c99-3279-4d8a-8e09-b002a73d85bb@mailbox.org>
 <0c7f155a-3bdb-4d4b-8f2d-3b79eec3cbc2@gmail.com>
 <a3e748e8-8785-4f74-bed5-5fd1c517d44f@mailbox.org>
 <CAHvkZ4ZS+Nv=Nueqfve2ujJxwD0RgruQGi51TH6YNFqiEZd3Pw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAHvkZ4ZS+Nv=Nueqfve2ujJxwD0RgruQGi51TH6YNFqiEZd3Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rm8rb51xc6bwkdf11u99ns51586ma69h
X-MBO-RS-ID: 00f0076fdd55de123d7
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

On 11/3/25 1:13 AM, Lucien Jheng wrote:

Hello Lucien,

>>>> On 10/6/25 2:49 PM, Lucien.Jheng wrote:
>>>>> Synchronize paged PHY helpers with Linux v6.17.
>>>>>
>>>>> Add support for PHY devices that use paged register access by
>>>>> implementing the following functions:
>>>>> - phy_save_page(): Save current page number
>>>>> - phy_select_page(): Switch to a specific page and return previous page
>>>>> - phy_restore_page(): Restore previously saved page
>>>>>
>>>>> Also adds read_page and write_page callbacks to the phy_driver
>>>>> structure to enable driver-specific page handling.
>>>>>
>>>>> These helpers allow safe access to paged PHY registers by ensuring
>>>>> proper page selection and restoration,
>>>>> even in error conditions, which will be used by the Airoha PHY driver.
>>>> Are there any users ? If not, this is dead code.
>>>
>>> I have checked the latest Linux kernel, and these functions are
>>> currently used by several vendors, including *MediaTek, Airoha, Marvell,
>>> and Realtek PHY*.
>>>
>>> Therefore, I believe these APIs are not dead code.
>> This is U-Boot, are there any users in U-Boot ?
>>
>> If you plan to use this in a new driver, then please send this together
>> with the new driver.
>>
> Got it.
> I will send this together with new driver.
> Thank you

Likewise, thank you !

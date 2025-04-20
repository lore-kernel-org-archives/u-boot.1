Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3CEC369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 17:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0EC1819D2;
	Sun, 20 Apr 2025 19:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gSc815Ba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC8481B4B; Sun, 20 Apr 2025 19:56:28 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41917809A5
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 19:56:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Zgblq1wx6z9spR;
 Sun, 20 Apr 2025 19:56:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1745171783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bcnj5/TNVoTPepCVM7wmlE6+EOaB2pRokXcNaSgcXXk=;
 b=gSc815BaCnn34ytuucydEvLgJUsJ9ArKU1xvK30rk8V/EMKyQvGnh/qyrgP+mJ5yskYTAI
 zGl7X5MWirxUS7LreQl5O9v0W7+yZC7Rqy3TFWom0quXGTnlga8Urli6v7fOceS7IfRbta
 eoeGk4wj5KEkz/OXcYZrSXHFqfEn5jj5EIoD32j2SXOGcpn7p+Msz0Af3UeyAF9SNn+gZd
 6Xcy2QKHNwZ1AZeFbe0iA74Yh5vTHuKiQeY29gkekzqybpYvPtrFh/yCDUS8Ecm1eQsuPp
 cXCEb75PdqZp/xBvNSzphPgCxR7qSYHa0KcrzZYVmWninq0wzI+r1GFdOSzO6A==
Message-ID: <e011b2f3-afd3-425a-900a-db0ee4ace166@mailbox.org>
Date: Sun, 20 Apr 2025 19:55:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: Daniel Golle <daniel@makrotopia.org>, "Lucien.Jheng"
 <lucienzx159@gmail.com>
Cc: ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 frank-w@public-files.de, ericwouds@gmail.com
References: <20250406130244.19496-1-lucienzx159@gmail.com>
 <eacd3b66-0262-4bde-9b91-6ca7eea789fe@mailbox.org>
 <2aa57092-f844-4ef8-9b97-0998a697c0be@gmail.com>
 <aARRJ85ULmqsYgPo@makrotopia.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aARRJ85ULmqsYgPo@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xjuq773qd66qbuw1pd1ie7igku3q64s7
X-MBO-RS-ID: 76bd69bbb78c092d352
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

On 4/20/25 3:43 AM, Daniel Golle wrote:
> Hi Lucien,
> Hi Marek,

Hi,

> On Fri, Apr 18, 2025 at 11:57:19PM +0800, Lucien.Jheng wrote:
>> Hi Marek Vasut
>>
>> Thanks for the review.
>>
>> The next commit will change the loading of the PHY firmware to the
>> filesystem on a block device.
> 
> Please keep in mind that most systems using this PHY are (like the
> OpenWrt One, for example) simple embedded devices with only a small
> amount of NAND or NOR flash. Loading the firmware from a filesystem
> means overhead and complexity, while loading it from a simple
> MTD partition, raw UBI volume or one of the EMMC boot hw partitions
> is a better match to the reality of the devices it is being used on,
> making the process less complex and more deterministic, and hence
> more robust.

That works until someone else needs to load the firmware from somewhere 
else. U-Boot is not a one-board-special-hack but a generic bootloader, 
which is why special board-specific Kconfig options and other such 
ad-hoc board-specific hacks in drivers are frowned upon. Having a PHY 
driver depend on loading firmware in a non-generic manner is not helpful.

Whatever board specific firmware loading should not be in the driver, it 
should be either in board code, or in some generic firmware loader (if 
that is something someone wants to write, but that is more involved).

I am not buying the "reality of devices" argument, sorry, this is a 
generic ethernet PHY, users can use it on whatever device they populate 
it on, and they can very well chose to place the firmware into 
/lib/firmware to share it with Linux expectations or in some EEPROM .

>> [...]
>> Marek Vasut 於 2025/4/6 下午 09:30 寫道:
>>> [...]
>>>
>>> Can this do the same thing as Aquatia PHY and load the PHY firmware from
>>> filesystem on block device instead , using the blk* or fs* commands ?
>>> Then the hard-coded filesize and co. won't be necessary.
> 
> Note that the size is afaik given by the hardware in this case, it won't
> every change. Hence any handling of a more dynamic approach of loading
> the firmware will also have to come with a size-check against the (again)
> hard-coded size anyway.

If the firmware size is fixed, it shouldn't be exposed via Kconfig in 
the first place. Linux doesn't do that either, why is it done here ?

>>> If you need board specific loading override, implement __weak default
>>> loading from file on filesystem by default (see what Aquatia does) and
>>> then override the loading function on board or architecture level.
> 
> That can work, but in practice it will lead to code duplication, as all
> platforms using those PHYs are kinda similar (ie. MT7981, MT7986 and
> probably Airoha/EcoNet router SoCs as well)
Surely there is a way to factor common loader code parts into dedicated 
loader-implementation.c to avoid duplication.

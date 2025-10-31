Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA110CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5285D83A2D;
	Fri, 31 Oct 2025 17:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="v2FWQTON";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="A/b2KZ9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D1783A32; Fri, 31 Oct 2025 17:51:32 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F6083A1E
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cyn7P3rKrz9spX;
 Fri, 31 Oct 2025 17:51:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761929489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QoDTm30RnK+zAr2t2KawJPDyWHcL+F+NL+z87G/brU=;
 b=v2FWQTONHXc9Ldn0yOac9H+hhBJxbKEe3EnS0QFSMlmj30tIODJh91VIGjDP2VrnTjM3fl
 JLzU/TCbvcxuvKR+vUyPtk/QsokIQdYNQJapWE6OXypst9V5ifI2EJnHchpM3UhlB1+Bb0
 Nofc4GQsXy5Lay0A2TXbZaPjDdiLqSSqVhGcxkZL7Xaem/P0m5BCb1spbQ9SQ1gxd6XUzY
 6d4vdAfkh2ob8PMdLUphDc3JuEyagqYhHqN9uevlZUKqWJZ41jTJTfr1mWNKo3z9TGfpJx
 G9jnyPHbf/S4PGiRtHyVbAyw59t2YLsp02qx/ZmhPUUIoyry7oUReQB9fKCwgw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="A/b2KZ9x";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a8f176dc-59c3-4af4-88ed-03d064f2e7c2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761929487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QoDTm30RnK+zAr2t2KawJPDyWHcL+F+NL+z87G/brU=;
 b=A/b2KZ9xB087hHrqGzEJtI0cgRog1gBPJkvILmJVsGOwf/RE5806+IcNm1kj9wiTIcTw9x
 lXozLP1EQH2JiNrqQzJrbPggRHSsP2HP2fFJNZbfFhiXJV5qrrgNYI0FWlpFxFRHo0JZwd
 vSktfY9ozd58Nlf3IkxpMLvzE/1KuYDjhS8OjIxV3kBl2nKC6F9SIOoiYRcnIoAx1gTGzj
 pUfqtELlKBkxUviFubw6qhmRrajFfmUuypLGPMghMdJC7lVf+qf/N8zvrT/cPBbc9rzGBU
 ncV71IxmCZ+aZdADmE4erHzIknNFRXro6G3pDIhoYTgLHtbx+JSH+OJG7QeADA==
Date: Fri, 31 Oct 2025 17:51:24 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
 <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
 <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dk1xe6dnfodwkex5keogm93gzf3bo5br
X-MBO-RS-ID: ebec2cc829feeb70f87
X-Rspamd-Queue-Id: 4cyn7P3rKrz9spX
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

On 10/31/25 5:34 PM, Beiyan Yun wrote:
> 
> 
>> On 31 Oct 2025, at 11:57 PM, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>>> Aquantia PHYs are being used w/o SPI flash in some routers recently.
>>> Current firmware loader only attempts to load from FS on top of MMC,
>>> limiting the use on many devices.
>>> Removed the old firmware loader, migrate to generic firmware loader to
>>> allow a wider range and runtime override of firmware source. (e.g., USB).
>>> Tested on Buffalo WXR18000BE10P with UBIFS.
>>> Signed-off-by: Beiyan Yun <root@infi.wang>
>>> ---
>>> Changes in v4:
>>> - Split firmware upload helpers change
>>> - Reorder `aquantia_read_fw`
>>> - Make `aquantia_read_fw` weak to allow overide
>>> - Rename exit label in `aquantia_read_fw`
>>> - Kconfig polish
>>> Changes in v3:
>>> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>>> Changes in v2:
>>> - Add support for script based loader
>>>   drivers/net/phy/Kconfig    |  28 +++++----
>>>   drivers/net/phy/aquantia.c | 122 ++++++++++++++++++++++---------------
>>>   2 files changed, 91 insertions(+), 59 deletions(-)
>>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>>> index 018be98705a..4a74a0d4e8c 100644
>>> --- a/drivers/net/phy/Kconfig
>>> +++ b/drivers/net/phy/Kconfig
>>> @@ -1,4 +1,3 @@
>>> -
>>>   config BITBANGMII
>>>   	bool "Bit-banged ethernet MII management channel support"
>>>   @@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
>>>   config PHY_AQUANTIA_UPLOAD_FW
>>>   	bool "Aquantia firmware loading support"
>>>   	depends on PHY_AQUANTIA
>>> +	select FS_LOADER
>>> +	select FW_LOADER
>> Can you not use the plain FW_LOADER to load the firmware from either storage, UBI or Block ? Is FS_LOADER even needed ?
> 
> Thanks for the suggestion, and yes you can, but that API is script-only—it expects the board to stage the blob and just copies from the address exposed via *_addr/_size. The current users of this driver expect the old pattern: the bootloader mounts a filesystem (MMC before, now possibly UBI/USB/etc.), reads the firmware, and applies it. Keeping an fs-loader node in the DT is effectively the same contract as the legacy MMC setup, just generalized.

Can you maybe write a script which implements the old loader behavior in 
a compatible manner ?

> The fs_loader driver gives us several things the script path doesn’t: a standard way to describe the storage via "/chosen/firmware-loader"

Try this:

"fdt addr $fdtcontroladdr ; fdt print /chosen"

And then look at the "fdt" command and what it can do regarding reading 
content of DT properties into variables.

> , runtime overrides through "storage_interface/fw_dev_part/fw_ubi_*, and no requirement for a board-specific script. So FS_LOADER isn’t redundant—it’s the part that replaces the hard-coded MMC flow with a configurable backend, while the script helper stays available for boards that want extra logic.
Maybe a more generic script can be a replacement for the older 
hard-coded approach ?

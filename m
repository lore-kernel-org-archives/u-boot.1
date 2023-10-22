Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A6ACDB474
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 03:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D66287696;
	Sun, 22 Oct 2023 05:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="X9XMb3RD";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7f/pcy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00CC87696; Sun, 22 Oct 2023 05:34:54 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 541F687695
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 05:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.nyi.internal (Postfix) with ESMTP id 6F0C55C02C1;
 Sat, 21 Oct 2023 23:34:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Sat, 21 Oct 2023 23:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1697945691; x=1698032091; bh=Qixxhgu5Rh1pZP/AHh8sKd7yAvsv4YmF/gt
 M8SsBV7k=; b=X9XMb3RDbFNjqF/JBY0sXsn4SF+/epce7OvxdMFQ8+n+Cmnn48/
 q7uleve9SNTTCC7dp8ivyC6ZWr45KgOtiqUiBV5Vec7kf918HLqi6UuphlAoTvHG
 WBbZCM3RL8jJpiljvahevC+/rerDulNfxXyUWlIzhIy2N1WsxWY+QwTWHJnZw6sg
 9q2XyTAe9HqGGGhNu2g4FrmuURrmXIKybBZK3UT70Ux8Po6pZq5JJbZJ1e0GSeVw
 CV1gH5jxoIrbeLFFBZhrYN0VEC46NPUDIHtMN2aeT4Vl8Ul/OY/AZK6vKebR7AN3
 i8uXLGsQUnrSQDUrwpFzVTMlO+pikRyXYzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1697945691; x=1698032091; bh=Qixxhgu5Rh1pZP/AHh8sKd7yAvsv4YmF/gt
 M8SsBV7k=; b=J7f/pcy6CEV+15Fz6HRlinVdTpBpyBOZh975zCHDSDi77Onbngx
 ghaW14+93I989W4XKrjbWCJrWvDoSAHt5J+Cr+hzBbQxGe0OkwIfVGcJpociSQip
 GlkWhDe1/4+gJ7m74emzr7Li0EX2ZLlOFC3ZlGG3of393Ko7e4zwal1igB5IReCE
 9JSvTFLSIxXwDBU6R5nUxjLzklkharqAOYEEottybsbTw5di05s4DnqfcbaPZP1Y
 SgbPvYUsLPzRPN5HDJ/4fBGfZ3dCm8E7/n+y3m9qgVHAc+4KJg+PspFs/zy+sXOe
 CaN0VDGvkoLxDNtyxN2RlBizeLpW2uxSMww==
X-ME-Sender: <xms:W5g0ZUOp4dLhQ4NG_yWKY90KHhVuKqMog7-IR36fQRowrt8Sa4KStw>
 <xme:W5g0Za9f4fNPTb-o2iO3LXWB3IkFdsn1qvqyJYiNiDy64O39v8Or0iCznkFVDZUPY
 BdXS3SsMMzRYM7yqQ>
X-ME-Received: <xmr:W5g0ZbRPoUEWbuFT-rDozQrV8FFpDvmnATZyg4vocx5bh6iJ1Em7dM6eb2CCJTA0aW_U99G-cGDm3lIA3zRLXYicxJAyDZ2TMj46UgRRHc7PERsCNOgznSQ0jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugdejvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudfhffefhfffuddutedvffekteevieeugeefleelffeitddutdff
 udehgfdtfefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
 nhgurdhorhhg
X-ME-Proxy: <xmx:W5g0ZcsTHrYv9YEYOUWdOPjdHyYTzJmMOVcZxsyYEtVyQ1zzOLtZ1Q>
 <xmx:W5g0ZceT_hVGgWN00L2Y3F7uSfLrMCYX0VuoU_Ce-U8Wq5lWQWq1Ww>
 <xmx:W5g0ZQ1ShGRFQqcnlUNm77s9wAzKuGQm_zp0FIdtH5hirKwiw8YVeg>
 <xmx:W5g0ZTyN08FBoH4iXaz2vYk7CjvBrHnKhluSkpQNek7YySB5G_YH4w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 23:34:50 -0400 (EDT)
Message-ID: <299bd702-5965-ed8c-d7a5-b83ddb721ff4@sholland.org>
Date: Sat, 21 Oct 2023 22:34:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 01/22] sunxi: remove CONFIG_SATAPWR
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng
 <uwu@icenowy.me>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>, Okhunjon Sobirjonov
 <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@foss.arm.com, Jagan Teki <jagan@amarulasolutions.com>,
 u-boot@lists.denx.de
References: <20230928215455.28094-1-andre.przywara@arm.com>
 <20230928215455.28094-2-andre.przywara@arm.com>
 <9ee155e3-7bd0-ed70-b4b7-33f4760a507c@sholland.org>
 <20231022002759.1608c5c3@slackpad.lan>
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20231022002759.1608c5c3@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
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

On 10/21/23 18:27, Andre Przywara wrote:
> On Thu, 19 Oct 2023 18:51:30 -0500
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi Samuel,
> 
> thanks for having a look!
> 
>> On 9/28/23 16:54, Andre Przywara wrote:
>>> The CONFIG_SATAPWR Kconfig symbol was used to point to a GPIO that
>>> enables the power for a SATA harddisk.
>>> In the DT this is described with the target-supply property in the AHCI
>>> DT node, pointing to a (GPIO controlled) regulator. Since we need SATA
>>> only in U-Boot proper, and use a DM driver for AHCI there, we should use
>>> the DT instead of hardcoding this.
>>>
>>> Add code to the sunxi AHCI driver to check the DT for that regulator and
>>> enable it, at probe time. Then drop the current code from board.c, which
>>> was doing that job before.
>>> This allows us to remove the SATAPWR Kconfig definition and the
>>> respective values from the defconfigs.
>>> We also select the generic fixed regulator driver, which handles those
>>> GPIO controlled regulators.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> Reviewed-by: Sam Edwards <CFSworks@gmail.com>
>>> ---
>>>  arch/arm/Kconfig                             |  2 ++
>>>  arch/arm/mach-sunxi/Kconfig                  |  8 --------
>>>  board/sunxi/board.c                          | 16 +---------------
>>>  configs/A10-OLinuXino-Lime_defconfig         |  1 -
>>>  configs/A20-OLinuXino-Lime2-eMMC_defconfig   |  1 -
>>>  configs/A20-OLinuXino-Lime2_defconfig        |  1 -
>>>  configs/A20-OLinuXino-Lime_defconfig         |  1 -
>>>  configs/A20-OLinuXino_MICRO-eMMC_defconfig   |  1 -
>>>  configs/A20-OLinuXino_MICRO_defconfig        |  1 -
>>>  configs/A20-Olimex-SOM-EVB_defconfig         |  1 -
>>>  configs/A20-Olimex-SOM204-EVB-eMMC_defconfig |  1 -
>>>  configs/A20-Olimex-SOM204-EVB_defconfig      |  1 -
>>>  configs/Cubieboard2_defconfig                |  1 -
>>>  configs/Cubieboard_defconfig                 |  1 -
>>>  configs/Cubietruck_defconfig                 |  1 -
>>>  configs/Itead_Ibox_A20_defconfig             |  1 -
>>>  configs/Lamobo_R1_defconfig                  |  1 -
>>>  configs/Linksprite_pcDuino3_Nano_defconfig   |  1 -
>>>  configs/Linksprite_pcDuino3_defconfig        |  1 -
>>>  configs/Sinovoip_BPI_M3_defconfig            |  1 -
>>>  configs/orangepi_plus_defconfig              |  2 +-
>>>  drivers/ata/ahci_sunxi.c                     |  9 +++++++++
>>>  22 files changed, 13 insertions(+), 41 deletions(-)
>>>
>>> [...]
>>> diff --git a/configs/orangepi_plus_defconfig b/configs/orangepi_plus_defconfig
>>> index 76de72aa228..ed585881d49 100644
>>> --- a/configs/orangepi_plus_defconfig
>>> +++ b/configs/orangepi_plus_defconfig
>>> @@ -7,7 +7,6 @@ CONFIG_DRAM_CLK=672
>>>  CONFIG_MACPWR="PD6"
>>>  CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>>>  CONFIG_USB1_VBUS_PIN="PG13"
>>> -CONFIG_SATAPWR="PG11"
>>>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>>>  CONFIG_SPL_I2C=y
>>>  CONFIG_SPL_SYS_I2C_LEGACY=y
>>> @@ -16,3 +15,4 @@ CONFIG_SUN8I_EMAC=y
>>>  CONFIG_SY8106A_POWER=y
>>>  CONFIG_USB_EHCI_HCD=y
>>>  CONFIG_USB_OHCI_HCD=y
>>> +CONFIG_USB3_VBUS_PIN="PG11"  
>>
>> This change is unrelated to the purpose of this commit.
> 
> I added this line after your suggestion last December:
> https://lore.kernel.org/u-boot/bb2ef69f-23e1-9936-e824-6b86924b9c8a@sholland.org/
> 
> In short: this is an H3 board without native SATA, so having this
> symbol set here enables SATA operation for now, until we get full DT
> regulator support in phy-sun4i-usb.c.

Ah right, sorry for the confusion. Maybe this deserves mentioning in the
commit message. Either way:

Reviewed-by: Samuel Holland <samuel@sholland.org>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316EBCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE9B836D1;
	Sun, 26 Oct 2025 16:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eqRgJoSz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="M8Ur1zwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFB783771; Sun, 26 Oct 2025 16:56:50 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B21383623
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cvh8c105Fz9slL;
 Sun, 26 Oct 2025 16:56:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761494208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kAqIdw8OLn6d7A2w15s1FM3dcIVYJ0QMh7krtV5uKQ=;
 b=eqRgJoSzRFoEejf95/zRYNyv2S2z1ERczfG03A/K9atWfoeI/pYDeqchPrdo8sCUr/5meC
 z/A0eeqZ+lPrRCdhjZqOYCin7v3TMUBlZ6wp2butgXMStelT/II/JFLtxrLfejPBBaUu98
 trh1GZyvVFr4a0mqY/TouqYTIFSXah7kgR3DC9jeKRET1roD0ArxZ0IQKGiqXnP41IcLVD
 GtzcRN0pvMHQLHfmWNrhHlFu4GMSJ5CVi8Q0jp9YHS2wyGiBFjP42zC70ITwGzi3HTykUP
 xAqMg6v2rBsdQVpCoUlVCE68ZTmwm9LHExsgMzyaDzaqIgDgi+rlLrEY8uAacQ==
Message-ID: <e88eceb2-7292-4888-8fbc-8022cabceb41@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761494206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kAqIdw8OLn6d7A2w15s1FM3dcIVYJ0QMh7krtV5uKQ=;
 b=M8Ur1zwiNl4+PznaJ4qnAxgPc3GAyKQbiFIE0nY5Op7vsMqTpZ2MrfT0xidBS6taO2qcft
 pwatI8d3P/1UuWiuh3Wtyki68C8vvx0DKw/fvRP5y1ZHH+tlKR9xbCvv0YM9q5fXieKx59
 9eXfdQlZwVqMX5N8p5w5USgcLr4oQveMMM2DtN+q8idSuna8+JRHHr9FLprKgLfIjToeCp
 Ylnt0Kq3CaI+tL3ytnbDvzNSA363RlRp0yXlBRHRx/EAdYzI8/nlxra8g/L5pCZgpA4HaB
 86aSCLd4WISyBF3POHe0ABaT8B3xSVJIQe/R8YXpcrjN0yJa8/AbpOMYARbC0A==
Date: Sun, 26 Oct 2025 16:56:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
To: Tom Rini <trini@konsulko.com>, Paul Kocialkowski <paulk@sys-base.io>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 gss_mtk_uboot_upstream@mediatek.com
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
 <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org> <aJJGvQpoYUWWjwrB@collins>
 <20251026154314.GW6688@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251026154314.GW6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9uc3ri18iixwmmc7a4to8an9cxknpddb
X-MBO-RS-ID: fd70d4385bc97755197
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

On 10/26/25 4:43 PM, Tom Rini wrote:
> On Tue, Aug 05, 2025 at 08:00:29PM +0200, Paul Kocialkowski wrote:
>> Hi,
>>
>> Le Mon 14 Oct 24, 10:43, Marek Vasut a écrit :
>>> On 10/14/24 9:06 AM, Sky Huang wrote:
>>>> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
>>>>
>>>> Remove unnecessary CL22 phy reset before ethernet phy driver
>>>> probe. Lots of ethernet phys requires driver to load firmware.
>>>> Before that, CL22 phy reset may lead to malfunction.
>>>>
>>>> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
>>>> ---
>>>>    drivers/net/phy/phy.c | 2 --
>>>>    1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>>>> index 716a1d46111..e6fed8c41d7 100644
>>>> --- a/drivers/net/phy/phy.c
>>>> +++ b/drivers/net/phy/phy.c
>>>> @@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct mii_dev *bus, uint phy_mask)
>>>>    static void phy_connect_dev(struct phy_device *phydev, struct udevice *dev,
>>>>    			    phy_interface_t interface)
>>>>    {
>>>> -	/* Soft Reset the PHY */
>>>> -	phy_reset(phydev);
>>>>    	if (phydev->dev && phydev->dev != dev) {
>>>>    		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
>>>>    		       phydev->bus->name, phydev->addr,
>>>
>>> This needs clarification and likely has to be handled differently. Removing
>>> the reset would leave the PHY in potentially undefined state.
>>>
>>> Which PHY is affected by this ?
>>
>> Good hunch. I just bisected down to this commit as I had some issues with my
>> Allwinner V3 board using the internal CL22 PHY. The symptom is that the LEDS's
>> polarity was inverted. Network still seems to work (although not tested beyond
>> ping).
>>
>> This change can have very significant consequences in general, which were not
>> explored at all in the commit. This may break many boards that do rely on that
>> PHY reset, in various scenarios and for various reasons.
>>
>> I think it should be reverted as soon as possible to restore previous behavior.
> 
> I'm wondering if anyone has further comments here? If I do go and revert
> this what is then going to break on the MediaTek side for example?
Let's revert it, and if MTK stuff breaks, let's fix it properly then.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D1DE7AD4B
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 21:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3A2E84214;
	Thu, 25 Dec 2025 22:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gRWCrdbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031B884218; Thu, 25 Dec 2025 22:46:11 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4DBE84212
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 22:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dcj3y6T1Pz9shl;
 Thu, 25 Dec 2025 22:46:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766699166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kXpQ1WSvF5H7DhwsEd4lOIV3IA94YM+a0FbX+JUnrs=;
 b=gRWCrdbuvL6FbLKp7ztGI2yWTxyHV8ISj+LhOVBEee1HRDp9WCTsLWnWnFK4tvz5nw0Nbj
 AjtiDi/qqF2FjcTghzG3jaY2fLHHRiuPz2W1i0H91pSqLKPpcLcjCV94Kxe7l66DxSmpFY
 CndvH1Hez2i6RVcXeJCzue4Vg6h1VtiANTjLx86V85RK1M4hdOhPDXzfK0Fae8i09corRK
 Tp9NOMZAw8KgqsEMjNXFxBRD90i4VmHS3kEOnWqhkxUKW8bTpcshbu8qNbrTPLBgM02TaS
 r1XB8+vYep4K4XONE3mQ7Tkyjo1cJbGQ28ZbCty+v/iY4ib2SuHAYTXXihmYIw==
Message-ID: <2efa3ff6-646f-4d46-80f9-7cfe2b971641@mailbox.org>
Date: Thu, 25 Dec 2025 21:56:37 +0100
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYxIDIvN10gdXNiOiBlaGNpLW14Njog?=
 =?UTF-8?Q?Fix_usb=5Foc=5Fconfig=28=29_for_i=2EMX7/8M/9/7ULP/8_and_8ULP_plat?=
 =?UTF-8?Q?forms?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Peng Fan
 <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, George Chan
 <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-2-504115a53020@nxp.com>
 <e314692d-452c-452e-ba44-1469a8bcd9b5@mailbox.org>
 <PAXPR04MB9644117D0D40EE8A9FFE5CB3E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <PAXPR04MB9644117D0D40EE8A9FFE5CB3E2B3A@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: a5r4a7dxdbnpyw59g91wje9srzcdu1cz
X-MBO-RS-ID: 74a5bfecc722ab9028d
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

On 12/25/25 11:41 AM, Alice Guo (OSS) wrote:

Hello Alice,

>>> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
>>> index cfaf49d67f0..03ff4ce10d5 100644
>>> --- a/drivers/usb/host/ehci-mx6.c
>>> +++ b/drivers/usb/host/ehci-mx6.c
>>> @@ -280,7 +280,12 @@ static void ehci_mx6_powerup_fixup(struct ehci_ctrl
>> *ctrl, uint32_t *status_reg,
>>>    /* Should be done in the MXS PHY driver */
>>>    static void usb_oc_config(struct usbnc_regs *usbnc, int index)
>>>    {
>>> +#if defined(CONFIG_MX6)
>>>    	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[index]);
>>> +#elif defined(CONFIG_USB_EHCI_MX7) || defined(CONFIG_MX7ULP) ||
>> defined(CONFIG_IMX8) || \
>>> +      defined(CONFIG_IMX8ULP)
>>> +	void __iomem *ctrl = (void __iomem *)(&usbnc->ctrl[0]); #endif
>> Can we simply pass 0 to this function as index for non-MX6 instead of this
>> ifdeffery ?
> 
> Even if I move the condition from inside the usb_oc_config() to the call site, I still cannot avoid conditional compilation because the logic is platform-specific.
> Given this, is it acceptable to keep the current change as it is?
Can we please somehow weed out the ifdeffery ?

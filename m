Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77FCE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D759280619;
	Tue,  7 Jan 2025 14:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="K4NVAMTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74EC8036D; Tue,  7 Jan 2025 13:40:03 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A9AB80079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736253592; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WKVLr1nUHg/aIVioeXMF+NQgljC+Cqv2lUEzrt6L8w/UjUDvDKSuOQrCrdS8T3jrXWryKKd8kCmNLX+rlrlEMStIOy71E+DVy6w1t95SOkZxhPOGCkOf2k1TiAck8Nvr5alER8ZHMwmCwKlOf0Y+Is2oSLznIQqdtOdZSOLt3l0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736253592;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MHC2vxSzj63yaZTirsF8g4qXgTnBQznKaQ0bCGB5b24=; 
 b=d+//4fNTxetFh0xoHIgEd+OEDw6HdPD2cwOqtkZRno3YO5eg1MFxPqI4LR8YPCA57wYtplC+6QwZiZs4wr91ziFObcUq1eSvJNIaLtxe49yes0PNCIBDKYCpLjAICy0frHr163rs4+SLtU4tDzQGOwQOHMDZu8I+l9Tj/P9CHeg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736253592; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MHC2vxSzj63yaZTirsF8g4qXgTnBQznKaQ0bCGB5b24=;
 b=K4NVAMTvoXEi1CPJYvwZ+I1Ekez4Xf8yFxihEJTs+gr10V5GHG/ogKMwtVvv6gNC
 q8FMn+9k5PYA/NTvE9YJs1KWq1dXWhx4iyix9cO7X2czAVFN0scwOjRDxGBQPjsLSpR
 A8ZXbGt2mWPNmhq1VXSCW0ZPk1MdBnPRTISMC8Zg=
Received: by mx.zohomail.com with SMTPS id 1736253589684868.8851896976138;
 Tue, 7 Jan 2025 04:39:49 -0800 (PST)
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Marek Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, 
 "Lukasz Majewski" <lukma@denx.de>, 
 "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
In-Reply-To: <64b317fe-d5a2-4bc7-8c8a-fa608bccfa0b@denx.de>
Cc: <u-boot@lists.denx.de>, <seashell11234455@gmail.com>, 
 <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
Message-ID: <1818696fe57acd78.91ad175705e34eaa.3d66e6a504061c82@Mac>
Date: Tue, 7 Jan 2025 12:39:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 07 Jan 2025 14:15:02 +0100
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



On 06/01/2025 16:37, Marek Vasut wrote:
> On 1/6/25 10:14 AM, Junhui Liu wrote:
>> Hi Marek,
>>=20
>> On 05/01/2025 20:19, Marek Vasut wrote:
>>> On 1/4/25 4:37 AM, Junhui Liu wrote:
>>>> From: Kongyang Liu <seashell11234455@gmail.com>
>>>>
>>>> This patch merges flush and reset logic for both host and gadget code
>>>> into a common set of functions, reducing duplication. It also adds supp=
ort
>>>> for the updated reset logic to compatible with core version since v4.20=
a.
>>>>
>>>> This patch mainly refers to the patch in the kernel.
>>>> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>>>
>>> [...]
>>>
>>>> +++ b/drivers/usb/common/dwc2_core.c
>>>> @@ -0,0 +1,115 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
>>>
>>> 2025 now .
>>=20
>> You're right. It should be 2024-2025.
>>=20
>>>
>>> [...]
>>>
>>>> +int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	log_debug("Flush Rx FIFO\n");
>>>> +
>>>> +	/* Wait for AHB master IDLE state */
>>>> +	ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE=
, true, 1000, false);
>>>> +	if (ret) {
>>>> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
>>>> +
>>>> +	ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH=
, false, 1000, false);
>>>> +	if (ret) {
>>>> +		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* Wait for at least 3 PHY Clocks */
>>>> +	udelay(1);
>>> Shouldn't this delay be derived from the PHY clock frequency somehow ?
>>> Are we sure 1us is always sufficient ?
>>=20
>> According to the datasheet, the PHY clock can be selected to 6/30/48/60
>> MHz depending on the speed mode. And 1us is sufficient even for 6MHz
>> (twice the 3 PHY clock at 6MHz), so I think 1us is acceptable here.
>=20
> Please add a code comment like that ^ .

OK, I will add comments in the next version.

>=20
>> If we want to derive the delay dynamically from the PHY clock frequency,
>> we would need to read the PHY clock and speed mode cfg from the register
>> and calculate the appropriate delay. This would add complexity to the
>> code. In the current situation, a fixed delay of 1 us is sufficient for
>> all supported clock frequencies and keeps the implementation simpler.
> Thanks for the clarification, add a code comment and that is all fine.

--=20
Best regards,
Junhui Liu

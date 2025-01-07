Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E4DE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD478066C;
	Tue,  7 Jan 2025 14:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="VNau+wuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247EB8036D; Tue,  7 Jan 2025 13:52:55 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7107380079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736254365; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JxVvbp3jOXo8IY6aRqpvqPqzNVDfKXfFiEae9UDFfOuNGof56290EttL89ZWnmI5z+vA5f6C5RW3DlxIkCtRxBzy5M6ks42suCQSyX3+AMu5HPvJA+d3ZmcumoRuCDWdTwLZub47JRpm3bDYioNF2XeuvZQLO5oFBFdLN/E8BjY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736254365;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=M7W3eicPC34H7rYpnmS8H/vsWqOzcmkcGJMk5K4fpsU=; 
 b=FxTrEfTJJbIcbSVuqtlDXFmibB/CEK01BvqPlRAwX04yuqQ6t4awFT4bXnBq177SB8EQNeeZTxrcE9XhT11uajcmKHFNWsbz8SUw7jdkCMb2QyZ6kE8FjkgpFYE6js7liW012RAd0RUoKd/SfwYJZQ+ZkVh/r9gWWO6g7ADmi4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736254365; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=M7W3eicPC34H7rYpnmS8H/vsWqOzcmkcGJMk5K4fpsU=;
 b=VNau+wuDFQCO426YCll5HJJVGmtmjggffxoVuJLBGBSrxMmlizhlzlN97XMZjT8/
 UYSxv6dVMZlCQpQPxDFjF5eDm4PUXREeu2dekN2my76wTmXpaPazRivFxV0Mfn54h5Z
 UvTPymOcrNEJ2pU0nC8pY61M1vphcEo85UaIr4No=
Received: by mx.zohomail.com with SMTPS id 1736254363661405.7659370385952;
 Tue, 7 Jan 2025 04:52:43 -0800 (PST)
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>, 
 "Tom Rini" <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>, 
 "Lukasz Majewski" <lukma@denx.de>
In-Reply-To: <87h66bc5jb.fsf@baylibre.com>
Cc: <u-boot@lists.denx.de>, <seashell11234455@gmail.com>, 
 <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 6/8] usb: dwc2: Extract macro definitions to common
 header
Message-ID: <18186a2440c78a40.512f0975f4808276.e0f69f3b8a94181e@Mac>
Date: Tue, 7 Jan 2025 12:52:40 +0000
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

Hi Mattijs,

Thank you for your review.

On 07/01/2025 10:55, Mattijs Korpershoek wrote:
> Hi Junhui,
>=20
> Thank you for the patch.
>=20
> On sam., janv. 04, 2025 at 11:37, Junhui Liu <junhui.liu@pigmoral.tech> wr=
ote:
>=20
>> From: Kongyang Liu <seashell11234455@gmail.com>
>>
>> Some macros are shared between host and gadget code, causing duplicated
>> definitions. Move DWC2 macro definitions from host and gadget code into a
>> common header to reduce duplication.
>>
>> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>> Tested-by: Peter Robinson <pbrobinson@gmail.com>
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  drivers/usb/common/dwc2_core.h         | 430 +++++++++++++++++++++++++++=
++++++
>>  drivers/usb/gadget/dwc2_udc_otg_regs.h | 160 +-----------
>>  drivers/usb/host/dwc2.h                | 291 ----------------------
>>  3 files changed, 431 insertions(+), 450 deletions(-)
>=20
> [...]
>=20
>>
>>  #endif /* __DWC2_CORE_H_ */
>> diff --git a/drivers/usb/gadget/dwc2_udc_otg_regs.h b/drivers/usb/gadget/=
dwc2_udc_otg_regs.h
>> index 6aec55970db682ef8a21fad0b47144a4a87a47ca..d27b2f6187ff35991bbbc05d9=
7b6063117b082f0 100644
>> --- a/drivers/usb/gadget/dwc2_udc_otg_regs.h
>> +++ b/drivers/usb/gadget/dwc2_udc_otg_regs.h
>> @@ -10,65 +10,7 @@
>>  #ifndef __ASM_ARCH_REGS_USB_OTG_HS_H
>>  #define __ASM_ARCH_REGS_USB_OTG_HS_H
>> =20
>> -#include <linux/bitops.h>
>> -
>> -struct dwc2_usbotg_phy {
>> -	u32 phypwr;
>> -	u32 phyclk;
>> -	u32 rstcon;
>> -};
>=20
> This structure definition gets removed but is still used
> in drivers/usb/gadget/dwc2_udc_otg_phy.c. See otg_phy_init() for example.
>=20
> Is that intentional ?

Sorry, it should be left here. Removing it will cause compile errors
when CONFIG_USB_GADGET_DWC2_OTG_PHY=3Dy. I will fix it in the next version.

>=20
>> -
>> -/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>> -/*definitions related to CSR setting */
>> -
>=20
> [...]
>=20
>>
>>

--=20
Best regards,
Junhui Liu

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC72E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5AD80654;
	Tue,  7 Jan 2025 14:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="T7JHQpCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3348036D; Tue,  7 Jan 2025 13:44:40 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E66680079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736253870; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RfU60hikfPngotfiCH4BL7aYmKq702plbhZwxWNk3Pmxyf0Ss1ptLgBiJqFFE1XpUm21ZQdUdul7kmWwIvynjag1we/cP7D1GlAmBkvJUamTALMOzRtDWic4z1Yu0g8oXsnuTF0Hi/4/yJJRplx1WLpbpEjxd+zipX5FogMPU28=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736253870;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=DiJYN/nS0Uz2VJjT9ipYFoqbdBTs27bja4Imcg6MP/E=; 
 b=NPo0TDLDLQVMzhD4P4e95sXY1i/oRZA/gEXXVF5IdT6SkTdUxiryGS67aJ+aPwbRQoWU6txaDA8ko4gi8sokPHXdWjb5gwRcInoDtSQe9uxTHWSvEz2SUNcj4aaVG5Rl+5Nq+cVLALZNYYJK12KvHa0VMWztmpDq5u/jTFwnK4Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736253870; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=DiJYN/nS0Uz2VJjT9ipYFoqbdBTs27bja4Imcg6MP/E=;
 b=T7JHQpCyfh/BYEIPQv14hsZB7sGW1L6SuEvoSdJvLil3wh/TBgtkTlfEQykUdtIk
 7FtAa84zExBgW1E2Gc5y/IJ4E9F7mIXKpazpwNR6vqVrjMG4yA+jSgJoacNnKVQioCF
 d/sYeODXR6WaqtlRr9MXf9RdjF59ixHqDMhFP8CA=
Received: by mx.zohomail.com with SMTPS id 1736253868545941.0068966039255;
 Tue, 7 Jan 2025 04:44:28 -0800 (PST)
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Mattijs Korpershoek" <mkorpershoek@baylibre.com>, 
 "Tom Rini" <trini@konsulko.com>, "Marek Vasut" <marex@denx.de>, 
 "Lukasz Majewski" <lukma@denx.de>
In-Reply-To: <87jzb7c5vq.fsf@baylibre.com>
Cc: <u-boot@lists.denx.de>, <seashell11234455@gmail.com>, 
 <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/8] usb: dwc2: Refactor and update USB DWC2 driver
Message-ID: <181869b078bc34d8.757d2e884ba94770.31b1d6f75b7d55b0@Mac>
Date: Tue, 7 Jan 2025 12:44:23 +0000
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

On 07/01/2025 10:47, Mattijs Korpershoek wrote:
> Hi Junhui,
>=20
> On sam., janv. 04, 2025 at 11:37, Junhui Liu <junhui.liu@pigmoral.tech> wr=
ote:
>=20
>> This series improves the USB DWC2 driver by extracting register
>> definitions into a common file for better readability and updating the
>> reset method to reflect changes in version 4.20a, including the new
>> GRSTCTL_CSFTRST_DONE bit for reset completion indication.
>>
>> This series has been tested on two platforms:
>> - MK808 with RK3066 SoC and dwc2 v2.91a, tested with USB flash drive and
>>   connected the board to the PC through the rockusb command. Test log [1]=
.
>> - K230-CanMV with K230 SoC [2] and dwc2 v4.30a, tested with the onboard
>>   rtl8152 USB to net chip and an external rtl8152 adapter connected to
>>   the onboard USB-C interface via USB hub. Test log [3].
>>
>> [1] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#fil=
e-mk808-md
>> [2] https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial=
.html
>> [3] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#fil=
e-k230-canmv-md
>=20
> When applying this series on top of master (commit 6d41f0a39d64 ("Prepare =
v2025.01"))
> And building with khadas-vim3_android_ab_defconfig, I see:
>=20
> drivers/usb/gadget/dwc2_udc_otg.c:1209:33: error: invalid use of undefined=
 type 'struct dwc2_core_reg'
>  1209 |         return readl(&usbotg_reg->global_regs.gotgctl) & GOTGCTL_B=
SESVLD;
>       |                                 ^~
>=20
> Full build logs:
> https://paste.debian.net/1343304/
>=20
> It seems that at some places, we use:
>     struct dwc2_core_reg
>=20
> instead of:
>     struct dwc2_core_regs
>=20
> Could that be fixed for v4, please?
>=20
> I think this typo is in "usb: dwc2: Align macros with Linux kernel
> definitions" but missed it during review, sorry.

Thanks for pointing it out, sorry about the missing check, I'll fix it
in the next version.

>=20
>>
>> ---
>> Changes in v3:
>> - Handled warnings from checkpatch.pl (add spaces around '<<' and
>>   replace 'x' with '(x)' for macro argument).
>> - Add return ret; when timeout happens.
>> - Link to v2: https://lore.kernel.org/r/20241230-dwc2-dev-v2-3-12cd9b8a23=
58@outlook.com
>>
>> Changes in v2:
>> - Reorganized structures, renamed macros, and moved code for better
>>   clarity and maintainability.
>> - Added a fix for the incorrect ULPI_UTMI_SEL bit setting.
>> - Added a fix for incorrectly calculating HBstLen for external DMA mode.
>> - Extend the changes that replace uint32 with u32 to also include u8 and
>>   u16.
>> - Link to v1: https://lore.kernel.org/r/20240522142311.17351-1-seashell11=
234455@gmail.com
>>
>> ---
>> Junhui Liu (1):
>>       usb: dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
>>
>> Kongyang Liu (7):
>>       usb: dwc2: Extract register definitions to common header file
>>       USB: dwc2: Fix HBstLen setting for external DMA mode
>>       usb: dwc2: Clean up with bitfield macros
>>       usb: dwc2: Align macros with Linux kernel definitions
>>       usb: dwc2: Extract macro definitions to common header
>>       usb: dwc2: Unify flush and reset logic with v4.20a support
>>       usb: dwc2: Replace uint<x>_t types with u<x>
>>
>>  drivers/usb/common/Makefile                |   2 +
>>  drivers/usb/common/dwc2_core.c             | 115 +++++
>>  drivers/usb/common/dwc2_core.h             | 560 +++++++++++++++++++++
>>  drivers/usb/gadget/dwc2_udc_otg.c          | 125 ++---
>>  drivers/usb/gadget/dwc2_udc_otg_regs.h     | 293 ++---------
>>  drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c | 306 ++++++------
>>  drivers/usb/host/dwc2.c                    | 494 ++++++++-----------
>>  drivers/usb/host/dwc2.h                    | 750 +----------------------=
------
>>  8 files changed, 1137 insertions(+), 1508 deletions(-)
>> ---
>> base-commit: e7713a78829250b925d6377ee26c7b0745727feb
>> change-id: 20241218-dwc2-dev-955c21a81118
>>
>> Best regards,
>>

--=20
Best regards,
Junhui Liu

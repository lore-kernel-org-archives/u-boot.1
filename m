Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B9CE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 13:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B62A805D7;
	Mon,  6 Jan 2025 14:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="Kf5sYWcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C801801DE; Mon,  6 Jan 2025 10:14:39 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239138007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:14:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736154868; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RBkGJsGtqOV/N444LUT7AT3UiIX3wHMnk6WVZLggVMEjss+nm33m/EqsMgmw8VOn9lF+0g1ak9J+fLiJ2d2CBoBzcCycDVHHwcHqSuvLSviSzHv/pfp8oXMljZC5IAcYk/EOIgvGiLC30yE6a4oKcpERz7+29vAc+7NYmrxQmv8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736154868;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9T2S+6bqDCZazT6grNJ2XGdnVs95b0cHp2uDK/xTnrY=; 
 b=NbLr68vbvVqwKRotKFalUNqvYwHDvfgYW0jHhzcj6yxtbZkgUsy4RJCmAzuc4jvb5DC6DjICFAU5QMAjvwEh3oTuACmiM4sNkAyL8/5G6yafWb65NUemJi7A91snbhqZi/ywEFtu38AMlYJUEdjNfR4LzHLNduUHaFWW83DMdkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736154868; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=MIME-Version:From:From:To:To:In-Reply-To:Cc:Cc:Subject:Subject:Message-ID:Date:Date:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=9T2S+6bqDCZazT6grNJ2XGdnVs95b0cHp2uDK/xTnrY=;
 b=Kf5sYWcxZMotwRriZpYd+XOH4O+yhGBQCm5ZvttBUcu2kcchFSKCTkAJLRECjoh5
 d1l8bzSjjiRAcG106LhbtShUr0sT/va4SUsEhfs8K2NBHAmrQdNtcKxhxstW2FpWVA5
 xiFH4lo6QCN2FrF0n0h2zm/UBPdl42yx7+8U+NP8=
Received: by mx.zohomail.com with SMTPS id 1736154866626778.6484607644919;
 Mon, 6 Jan 2025 01:14:26 -0800 (PST)
MIME-Version: 1.0
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Marek Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, 
 "Lukasz Majewski" <lukma@denx.de>, 
 "Mattijs Korpershoek" <mkorpershoek@baylibre.com>
In-Reply-To: <88c88307-ab59-4d7a-acfd-f1a52c41a382@denx.de>
Cc: <u-boot@lists.denx.de>, <seashell11234455@gmail.com>, 
 <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
Message-ID: <18180fa5d7b286a0.3a5aa491c048ad05.6820f85a01d7931@Jude-Air.local>
Date: Mon, 6 Jan 2025 09:14:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 06 Jan 2025 14:14:51 +0100
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

Hi Marek,

On 05/01/2025 20:19, Marek Vasut wrote:
> On 1/4/25 4:37 AM, Junhui Liu wrote:
>> From: Kongyang Liu <seashell11234455@gmail.com>
>>=20
>> This patch merges flush and reset logic for both host and gadget code
>> into a common set of functions, reducing duplication. It also adds suppor=
t
>> for the updated reset logic to compatible with core version since v4.20a.
>>=20
>> This patch mainly refers to the patch in the kernel.
>> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
>=20
> [...]
>=20
>> +++ b/drivers/usb/common/dwc2_core.c
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
>=20
> 2025 now .

You're right. It should be 2024-2025.

>=20
> [...]
>=20
>> +int dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
>> +{
>> +	int ret;
>> +
>> +	log_debug("Flush Rx FIFO\n");
>> +
>> +	/* Wait for AHB master IDLE state */
>> +	ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, =
true, 1000, false);
>> +	if (ret) {
>> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
>> +
>> +	ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH, =
false, 1000, false);
>> +	if (ret) {
>> +		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
>> +		return ret;
>> +	}
>> +
>> +	/* Wait for at least 3 PHY Clocks */
>> +	udelay(1);
> Shouldn't this delay be derived from the PHY clock frequency somehow ?
> Are we sure 1us is always sufficient ?

According to the datasheet, the PHY clock can be selected to 6/30/48/60
MHz depending on the speed mode. And 1us is sufficient even for 6MHz
(twice the 3 PHY clock at 6MHz), so I think 1us is acceptable here.

If we want to derive the delay dynamically from the PHY clock frequency,
we would need to read the PHY clock and speed mode cfg from the register
and calculate the appropriate delay. This would add complexity to the
code. In the current situation, a fixed delay of 1 us is sufficient for
all supported clock frequencies and keeps the implementation simpler.

--=20
Best regards,
Junhui Liu

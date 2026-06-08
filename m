Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFCFCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7795083FEC;
	Mon,  8 Jun 2026 09:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U+xJ7gPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D387283FEC; Mon,  8 Jun 2026 09:15:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8EF807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAB43435EB;
 Mon,  8 Jun 2026 07:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB51F00893;
 Mon,  8 Jun 2026 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780902916;
 bh=f+7oPmOnOE51b37dm0jc0XpGl7JRzYtPrC7W9l0iGLU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=U+xJ7gPhNk6/xekKwXxM5SmVmyLa0nsgdA4IOdxabmSMJtQKTBfIr+8wsHkPAlJYH
 rIG9xii7LHSJ5RILVLeWc2bDGxapLsksBVz2sJNHo8T40f4yY9tNkqZeBJBUSTCkI6
 IzJRF6FyH7/Os9i2Ag44xN3zWlg4UXHbl4Ck8f7/MTDmHSwz4hTTadE/SpAD/t9K4n
 BJ0PMOGpxinv+FoFBFa4UNe09dN/rLSsIjl8QEqqatoZwPH7kHvvonSCIy82lZU8o5
 So8ldcLyOFU3ivk/+f3BDk3BKHdPG02WEq7cGqgPWWm3UTTz6vb688eUQakp5eTlRt
 XAabPPiJmsSjg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Casey Connolly
 <casey.connolly@linaro.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>, Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH] dwc3: Fix fastboot re-run failure with flat DTS
In-Reply-To: <a6c838a3-f795-4a29-bb0e-89a8b8fb098b@mailbox.org>
References: <20260529-usb-v1-1-be5bcb911f40@oss.qualcomm.com>
 <a6c838a3-f795-4a29-bb0e-89a8b8fb098b@mailbox.org>
Date: Mon, 08 Jun 2026 09:15:13 +0200
Message-ID: <87mrx5zeny.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi,

On Sat, May 30, 2026 at 12:02, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 5/29/26 2:22 PM, Balaji Selvanathan wrote:
>> Problem: The first "run fastboot" works and enumerates on the host.
>> Subsequent runs fail, with no USB enumeration observed.
>> 
>> With flat DTS configurations, the peripheral device inherits
>> power-domains from its parent (glue) node, as both reference the
>> same DT node. During teardown after "fastboot continue",
>> device_remove() of peripheral device invokes dev_power_domain_off(),
>> which powers off the shared USB GDSC.
>> 
>> As a result, the next "run fastboot" fails because the power
>> domain is left in an uninitialized state.
>> 
>> Add DM_FLAG_LEAVE_PD_ON to dwc3_generic_peripheral to prevent
>> power domain shutdown during peripheral removal.
> It seems the driver does not handle its power domains correctly, 
> inhibiting PD control is not a fix, sorry.

I agree with Marek here. Especially since this is a generic driver.

I had a somewhat similar problem on amlogic devices where I could only
run fastboot once.

I've solved this via
https://lore.kernel.org/all/20221024-meson-dm-usb-v1-1-2ab077a503b9@baylibre.com/

Maybe you can explore something similar instead?

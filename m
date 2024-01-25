Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45AEC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 18:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8CC877BC;
	Thu, 25 Jan 2024 19:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="FHp8E1n2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B5C87B58; Thu, 25 Jan 2024 17:29:22 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE0787536
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 17:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rT2bJ-0000wR-KK; Thu, 25 Jan 2024 11:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=9GOO6oAM/h0hRlrUxQvDQ/+eM6mlxoK1udFfaQwBbM0=; b=FHp8E1n2dubQKktWVsh1
 r1HiZnlIasozMWSwUsh/kAO7w3Inb8Bw5sYeI5oM38dboWDVLDKHxlDfEWyrlWbeD/TY/3vHKmWma
 fBkhQ2MlymJ5Vyhd74et6bj1sD6JKQlEmZXyIIBx89RIRQYvkmB7yAWVpbpk6dEHWotNEjHNllL3I
 hPFcurBicct2X2nC6WnyLwqJPHGUM8GPscJoNydBDhRL0qi+ohPAREcmKkFkPPr0IwnVJiPuSpjDZ
 /dPTNRW5dvb8eI/vBXT66uA3YkuBoHEJtkyLpRnA/i4FIVAktnB55b4WDkcaE4bSX05JM21V43bAb
 sJE3WawbUaE2Vg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i . MX
 U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,  Yannic Moog
 <Y.Moog@phytec.de>,  u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH v2] Add Phytec i.MX93 support
In-Reply-To: <4f0dcc58-7a9f-41d9-9604-f9fe2336eb25@norik.com> (Primoz Fiser's
 message of "Thu, 25 Jan 2024 12:47:28 +0100")
References: <20240124134237.819-1-othacehe@gnu.org>
 <4f0dcc58-7a9f-41d9-9604-f9fe2336eb25@norik.com>
Date: Thu, 25 Jan 2024 17:29:02 +0100
Message-ID: <87cytpml69.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 25 Jan 2024 19:19:55 +0100
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


Hello,

Thanks for having a look!

> Here are my findings:
>
> - FEC ethernet doesn't work
> - distroboot doesn't work
>
> Did you expirience the same?

I have not tested Ethernet ports on u-boot yet. I removed distroboot
support as you proposed later in the review.

Note that my evaluation board has a hardware issue on the eMMC module. I
am testing this patch my flashing the bootloader on the SD card using
the commands in the proposed documentation, and booting on the SD card.

> Can you rework you commit msg + title please?

Done.

> Can you rename to match other?

Sure.

> Can you add:
>
> &wdog3 {
> 	bootph-all;
> 	bootph-pre-ram;
> };
>
> here to also enable WDT in SPL, please.

OK.

> I don't think this is necessary?
>
> You are using CONFIG_DM_SERIAL.

It is not necessary indeed.

> IMHO I would disable distroboot and sync with downstream.

Done.

I synced the configuration and environment files to be closer to the
downstream versions.

I will send a v3 soon.

Thanks,

Mathieu

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71C1C36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE14380EEF;
	Tue, 25 Mar 2025 04:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mts+eH3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E84B80F70; Tue, 25 Mar 2025 04:37:50 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E952806FC
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZMFx60rPXz9smm;
 Tue, 25 Mar 2025 04:37:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742873866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYzhvzBaa7FJ6t3z2fxN8iiZC21A6YYuhh8heWMqr/E=;
 b=mts+eH3jj4MXrK+CgYJqGAPICAEj4OTNwPj7XdXQMwG/B4SEKRbmjljGXt1BeRBwiKqFZb
 SUxkJSlA5G8KcWxz9JtzRjUrXImHto4Mtyhp4MseQkgMc0fH4TL84/+JNdFeHsOMdz1Hea
 vLYUbJEL4h2bxyLEJJSgwfq2N/iRBXD5hfT+L53vrqe7V8mBa4yjdtgFOTxpZnFjg189T7
 791Ejsg7Ik+3o3d/Hpl9DfzrEs79fmqc1y19lqKzhd975CGMqoDpWVQUDOS9PTlrx2zWrh
 7/MzIIDJuMdT7nwYNKvoTPtjzBr/ncVOciHDM8My1aIElOgE1UWCxmd6fBiOeA==
Message-ID: <6f58a557-d5b4-4bc7-87b0-6ed626ec534a@mailbox.org>
Date: Tue, 25 Mar 2025 04:37:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250325025452.950303-1-aford173@gmail.com>
 <20250325025452.950303-5-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250325025452.950303-5-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e46484cf6feb8cb6c55
X-MBO-RS-META: uahgzjifehrdtwx74jdcw37mzfhdme3g
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

On 3/25/25 3:54 AM, Adam Ford wrote:
> Much of the data that is display by imx8_cpu.c is also displayed from
> arch/arm/mach-imx/cpu.c, except the temperature grade and active
> temperature are only displayed when SoC is an i.MX9. Since IMX9 now
> implies IMX_TMU, change this to check for IMX_TMU in the same way
> it's done in mach-imx/cpu.c to enable displaying this information
> for any SoC with either of this config enabled.
> Since additional text may appear due to this commit, remove
> the extra space in the message displaying the temperature
> grade.
> 
> Before:
> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> 
> After:
> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> CPU:   Industrial temperature grade (-40C to 105C) at 28C
> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
Please drop the fullstop at the end of Subject and then add

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

To the whole series.

Thanks !

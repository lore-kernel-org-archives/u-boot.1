Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32BAC35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 23:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE82781BC0;
	Sun, 23 Mar 2025 00:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Uz4F4xL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59CB98197D; Sun, 23 Mar 2025 00:31:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F9180C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 00:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZKwYZ3C91z9sd1;
 Sun, 23 Mar 2025 00:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742686274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uML5EqTWKYd9AFWByCfuikPXQOD6OqbNi+ZXsv59zOc=;
 b=Uz4F4xL1nVyd6wMCMSTsRIU2a8816Z4cpDOT0INezqMA3Zj0PDfTfXmnIW8ciMAIJlCFua
 XAalHGnorgK0G4jMuO+MDcBMuSg9YfgN0jaOBqcl5bfkg7zeppBGImowXjUIwjqs20el+j
 7Yi4BzJr1DcesZaNNG6NfMOuoNlQmHmvHSpVu4OwIMDju3IqUpjpENpHGFLurXN4WMNm/N
 fFq0vEyRkmFqNhsNIS0KYhQ2QO50VVrb8p3jQtxcmZz3XwofI7rXlqUEpPIfmgvj2ZySV0
 FAzNAWXihbHmgkL0k//tYXQ98SvLtb++zWEKI6NMLBYFyQvOU8+HwjiNkbTnRw==
Message-ID: <16100abb-70da-4b0b-a5de-3e961c0551d9@mailbox.org>
Date: Sun, 23 Mar 2025 00:30:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V3 3/6] cpu: imx8_cpu: Print Speed grade if IMX_THERMAL or
 IMX_TMU
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Enrico Leto <enrico.leto@siemens.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Sumit Garg <sumit.garg@kernel.org>,
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
 <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-4-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250322183812.784676-4-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ssbws9bi59kzfqeq37px6whkz11m7nr4
X-MBO-RS-ID: 1d0225f713fe945865f
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

On 3/22/25 7:38 PM, Adam Ford wrote:
> Much of the data that is display by imx8_cpu.c is also displayed from
> arch/arm/mach-imx/cpu.c, except the temperature grade and active
> temperature are only displayed when SoC is an i.MX9. Since IMX9 now
> implies IMX_TMU, change this to check for IMX_THERMAL or IMX_TMU
> in the same way it's done in mach-imx/cpu.c to enable displaying
> this information for any SoC with either of these configs enabled.
> 
> Before:
> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> Model: Beacon EmbeddedWorks i.MX8MPlus Development kit
> 
> After:
> CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
> CPU:   Industrial temperature grade  (-40C to 105C) at 28C
There is an extra space after 'grade' , please fix.

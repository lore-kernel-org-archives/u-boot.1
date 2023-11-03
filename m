Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889A6C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 10:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5158713C;
	Fri,  3 Nov 2023 11:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9051871C0; Fri,  3 Nov 2023 11:31:57 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6426A8711A
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 11:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
Received: from i53875bfa.versanet.de ([83.135.91.250] helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1qyrSp-0000dq-2j; Fri, 03 Nov 2023 11:31:43 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2 1/2] rockchip: ringneck-px30: always reset STM32
 companion controller on boot
Date: Fri, 03 Nov 2023 11:31:42 +0100
Message-ID: <6611078.LvFx2qVVIh@diego>
In-Reply-To: <20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com>
References: <20231103-ringneck-stm32-reset-v2-0-a0e5559f89bf@theobroma-systems.com>
 <20231103-ringneck-stm32-reset-v2-1-a0e5559f89bf@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Freitag, 3. November 2023, 10:28:12 CET schrieb Quentin Schulz:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> It's happened that glitches on the STM32_RST and STM32_BOOT lines have
> put the STM32 companion microcontroller into DFU mode making it not boot
> its FW, rendering it useless for the user.
> 
> Considering that the STM32 companion microcontroller is always reset on
> a reboot or power cycle, resetting it once again in U-Boot SPL isn't
> going to hurt it any more.
> 
> For ATtiny companion microcontroller, the situation is a bit different
> because a reboot or power cycle doesn't reset it. Additionally, since it
> can only be reset with a UPDI reset on the STM32_RST line, and that is
> virtually impossible to mistakenly trigger, the ATtiny is unlikely to be
> in unwanted reset or enter reset because U-Boot toggles STM32_RST line.
> 
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



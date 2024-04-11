Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E51CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00FE188268;
	Thu, 11 Apr 2024 14:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B19B588268; Thu, 11 Apr 2024 14:37:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A81C68827A
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9364D113E;
 Thu, 11 Apr 2024 05:38:17 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B1AC3F64C;
 Thu, 11 Apr 2024 05:37:47 -0700 (PDT)
Date: Thu, 11 Apr 2024 13:37:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: John Watts <contact@jookia.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] sunxi: Support UART1 and UART2 on the T113
Message-ID: <20240411133738.3209aa12@donnerap.manchester.arm.com>
In-Reply-To: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
References: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 11 Apr 2024 15:14:14 +1000
John Watts <contact@jookia.org> wrote:

Hi John,

> The T113 supports UART1 and UART2 on PG and PD pins respectively.
> Add support for these in U-Boot so we can use them.

So those bits are just for the *debug* UARTs. Traditionally this is UART0,
with some particular pinmux, sometimes UART2 on older SoCs.

So is there a board that uses those pins for a debug console? I want to
avoid making this code even messier than it already is, without good
reasons. Also please note that I tried to clean this up here:
https://patchwork.ozlabs.org/project/uboot/patch/20240103001239.17482-20-andre.przywara@arm.com/

> Note: I'm not entirely sure if the PD pins should be default, they
> overlap with the LCD pins. I am however using this on a real board.

Is this a custom board? Could you consider using UART0 for debug then?
This one doesn't support RTS/CTS, so you do not waste the more capable
UARTs for debug.

Cheers,
Andre

> Signed-off-by: John Watts <contact@jookia.org>
> ---
> John Watts (2):
>       sunxi: Support UART1 on the T113
>       sunxi: Support UART2 on the T113
> 
>  arch/arm/mach-sunxi/board.c | 9 +++++++--
>  include/sunxi_gpio.h        | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> ---
> base-commit: 777c28460947371ada40868dc994dfe8537d7115
> change-id: 20240411-t113serial-a6e9ca8d8848
> 
> Best regards,


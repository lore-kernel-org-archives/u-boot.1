Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2606CE7B1B
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF2F84132;
	Fri, 14 Nov 2025 16:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eTl0JJtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC2884142; Fri, 14 Nov 2025 16:13:05 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5897284105
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5517743816;
 Fri, 14 Nov 2025 15:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA33C19421;
 Fri, 14 Nov 2025 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763133181;
 bh=FhDYYy59qeIpCrcqmXbWnkTgolIt5DLr8g8XO+jMhv0=;
 h=From:To:Cc:Subject:Date:From;
 b=eTl0JJtWCWiZcbGoC5c2sthNiV+s11dLqKKmJ+oRj3od1xNyCzDFAwvWFchh6I34A
 Pjari+8EkQT3emxE+GvlBZSPkhiKom4lFzU/d9YSvohTMjZzbZnI3Wg6E5mOmB+J2L
 BqUKZNwIFiEKzu30nvG13yIZTbGYOhBUu8aBV2zzeRXCKp6YhIlkofavY+POe2uyNc
 I3/KduCGs9ZTbuv/9q/Y8nx53L6ZifqlH3eYE5ligoRvPDdDvMyHvqsybUMHA8mV6f
 TUyuovo611BL6PP4bB9OGbM/QZW8WcnxhVhCb9n/nOGN/96SXA4n/KjyHqSGG9+vqa
 jL3Z3iKtMaDSg==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 0/2] Add support for two RTCs
Date: Fri, 14 Nov 2025 16:12:46 +0100
Message-ID: <20251114151255.2008694-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I'll soon post support for the Kontron SMARC-sAM67 u-boot support.
I'm still waiting for the linux device trees to be merged (in -next
right now) and then to be synced to the u-boot tree. That board
features two different RTCs and this will already support for these.

You can find the device tree at [1]. RTC nodes are in the overlays,
though there is none for the RV3032 at the moment.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts

Michael Walle (2):
  drivers: rtc: add PCF85063 support
  drivers: rtc: add RV3032 support

 drivers/rtc/Kconfig    |  15 +++++
 drivers/rtc/Makefile   |   2 +
 drivers/rtc/pcf85063.c | 107 ++++++++++++++++++++++++++++++++++++
 drivers/rtc/rv3032.c   | 121 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/rtc/pcf85063.c
 create mode 100644 drivers/rtc/rv3032.c

-- 
2.47.3


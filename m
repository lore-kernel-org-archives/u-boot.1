Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02470D167E7
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 09:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE8383CDF;
	Fri,  9 Jan 2026 10:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tpcZDbw7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CFA184113; Fri,  9 Jan 2026 10:38:03 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF6D83CB1
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 10:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DF3C43CD0;
 Fri,  9 Jan 2026 09:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6864C4CEF1;
 Fri,  9 Jan 2026 09:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767951479;
 bh=+xSLbFsdr6rsgOgGQXhXFRLuybjRdN100pEKkSCRjfU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tpcZDbw7D1PUES9Si7jlb5fRC9BMLcTZpO4SIxwwAejbRgz3atUjfTSkJw7wOyTVO
 4kg+954wvvFkVO6swUoK0X/0VHOtY2TcRw7C1EN0p5A+GUtSPE1HasMZNqN/OuVitw
 am/RRi9aZjs4amBRkm44ePUWoUypxjfk4J2FN4kWiSxFbRRs8i/0jmrO/ATH0getwM
 JyprW2KwUP++mUoHqFBypAB9BlBilp5A1Qmi8JwNjvXroVQVRZZdvnCTavJ8B8XwLT
 1cCrd4kUejPRCz4/IKtsDMxNGQEfNokIgDBgRnOmkYt6zlKvFnAAuo6cDHvCSJDB0d
 FiGZCz8JZM3pw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek
 Vasut <marex@denx.de>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: Re: [PATCH 10/10] arch: arm: rockchip: Add initial support for RK3506
In-Reply-To: <20260109005008.101506-11-jonas@kwiboo.se>
References: <20260109005008.101506-1-jonas@kwiboo.se>
 <20260109005008.101506-11-jonas@kwiboo.se>
Date: Fri, 09 Jan 2026 10:37:56 +0100
Message-ID: <87bjj3yvm3.fsf@kernel.org>
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

Hi Jonas,

Thank you for the patch.

On Fri, Jan 09, 2026 at 00:49, Jonas Karlman <jonas@kwiboo.se> wrote:

> Rockchip RK3506 is a ARM-based SoC with tri-core Cortex-A7.
>
> Add initial arch support for the RK3506 SoC.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # drivers/usb/gadget

> ---

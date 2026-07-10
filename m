Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A271FC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F51284AD6;
	Fri, 10 Jul 2026 15:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="PHsCV1U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2AD84AC5; Fri, 10 Jul 2026 15:17:41 +0200 (CEST)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [84.16.66.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D379284A63
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSL2hRszY5M;
 Fri, 10 Jul 2026 15:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689458;
 bh=48smk1cbVi0/5yKLVllh/4QIsaNdZHGugu92EQjoFhc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=PHsCV1U1o7OlRBeTLJV4L/Z28zEWzlW4xZgowwMzbGly1V1eRIPS+bghAbWha5jNg
 0V9RoV4dlUsnVUyuTWcU9osRr36dKYhOw1cIiCJSaCco43HOSjVrZqp4V9QwcJtYZ0
 SeMPneCWa5BV5mAK2cSQ8q9jWxDJm7rc7FrrEZHIaPqPDyLv/Wv9BgsXK+I1LLMnCX
 oiCMTWRQ3M4LXH/QzV1/6wFbKqIDQMrYhPoADgPMeheZBW4xsPAmaDNbpMGUlA9Srg
 3nie1HlCiDELu7aRYr0MRXLBuncn3qibMCEoS2H2OGu2n4Kg++jk/dLRGvvMOv6Cbz
 BJ4hrOm7O7TBA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSK2mQ0zd0c; Fri, 10 Jul 2026 15:17:37 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
In-Reply-To: <20260423-rk35-cnt-freq-v1-1-8f07677be5ca@cherry.de>
References: <20260423-rk35-cnt-freq-v1-1-8f07677be5ca@cherry.de>
Subject: Re: [PATCH] rockchip: fix asm-operand-widths clang warning
Message-Id: <178368945734.879692.14782903883919331676.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
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

On Thu, 23 Apr 2026 16:05:13 +0200, Quentin Schulz wrote:
> CONFIG_COUNTER_FREQUENCY is currently 24000000 for all SoCs, meaning it
> fits in a 32b type. For 64b SoCs, it's an issue since the registers are
> 64b.
> 
> clang complains that we're trying to fit a 32b value into a 64b
> register:
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] rockchip: fix asm-operand-widths clang warning
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/07ab38e11f56b687ef40fa8c62de5556ae645a26

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>


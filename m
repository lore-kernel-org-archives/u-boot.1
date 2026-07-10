Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A2CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:18:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E978984AC9;
	Fri, 10 Jul 2026 15:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="RrKr0AO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F51E84AA1; Fri, 10 Jul 2026 15:17:40 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28E384AA4
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSJ2GyZzXNw;
 Fri, 10 Jul 2026 15:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689456;
 bh=HfOgdqUapsLJfIjhKHXjAK3mEhRO1CQ8DCAotlNCdAQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RrKr0AO677wRdWjoPSm2P6p/mJm4meA72o5uLmZOAbr4WWFIDqO7BpLojXK3G3ahe
 GrhMhCUPbZNUgemGBU6gDlchqVD3NvjaDNmsVf+0tQVxhOxyoCIQYOhbZE/QC1FBoR
 KWhO68zjGdSU1VzUa/TTKHeRpME5CUx0LfRFYbMSki6AgOCToj/vEBmOy0YK1qkjGa
 OpX8vX4eG++GaG7XvPlG8gLTM9jaunOix4o6Q/b5gRxkNn8RN886aQY1WBNn8+Cvpn
 c4lmFkuUNsyWQ7qTz+AbyyMu85UxwKEH6LxJAb5T0nStNLMAmSciEhlkNblh1ote6h
 N/H3NCElvkr/A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSH3t5WzfZT; Fri, 10 Jul 2026 15:17:35 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: kever.yang@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
References: <12b6e0d5-637e-446e-9e4b-82c82e6fad40@gmail.com>
Subject: Re: [PATCH v1] mtd: nand: raw: rockchip_nfc: fix oobfree length
 calculation
Message-Id: <178368945551.879692.18360924316982097333.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:35 +0200
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

On Tue, 30 Jun 2026 15:32:46 +0200, Johan Jonker wrote:
> The oobfree[0].length calculation depends on the
> rknand->metadata_size value, but this is calculated
> after the function rk_nfc_ecc_init is called. Move this
> calculation to a location before it's value is required.

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] mtd: nand: raw: rockchip_nfc: fix oobfree length calculation
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3f6d1416a89cc213ddf1f1f41dc0cda84b896b5c

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>


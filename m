Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D80C5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CCF540A0F;
	Thu, 13 Aug 2026 16:56:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fTwUX79N8dL; Thu, 13 Aug 2026 16:56:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A88FE40A0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640161;
	bh=gunfB68PDncsyCdNOGtakKTRIuNV6rBgtyS1jf1i//g=;
	h=To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=PQTbxsqpc7oVsOjw/wK10zY4/H3SRQG22qXVtr9mtpXLIQjpKT+n9/Ot54YmXTt/g
	 eKpntGXr6Jk0cNczvV1UZViZkf13zDrEDAl/WKkRwAzvtHkdlzj74Z5e86PUhYQDHm
	 KboeC3+acVd8K6GF3ra2HBi17PJWxSrOdno35Wu0n1N2lcrcD0hiM/DDC6jg/CuJvb
	 gURjEHkps6JjXbiBSLC52l4XepFoklFtIejobaAWedQVYVyJJJBq+uOeGFBco3ed1Y
	 mEpWIYTahUdjQD6c3PzgFSvVRRj/lmA985mcDXGplEo7fj2oUOtFhNTm+uXFXh1sHM
	 OQFiR2F/XvDsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A88FE40A0D;
	Thu, 13 Aug 2026 16:56:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8484C357
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76609810EE
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bBBwD6c44Kci for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:55:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::42ab; helo=smtp-42ab.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9D83880F46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D83880F46
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D83880F46
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:55:57 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLWhS5ZsMz4SY;
 Thu, 13 Aug 2026 18:55:52 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLWhS0WTZzfxx; Thu, 13 Aug 2026 18:55:52 +0200 (CEST)
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Martin Herren <sputnik@on-the-web.ch>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20260811-rk3576_radxa-rock-4_spi-v2-1-515b2880999e@on-the-web.ch>
References: <20260811-rk3576_radxa-rock-4_spi-v2-1-515b2880999e@on-the-web.ch>
Subject: Re: [PATCH v2] rockchip: rk3576-rock-4d: Enable XMC SPI chip
Message-Id: <178664015203.342950.2937838160016655823.b4-ty@b4>
Date: Thu, 13 Aug 2026 18:55:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786640152;
 bh=gunfB68PDncsyCdNOGtakKTRIuNV6rBgtyS1jf1i//g=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=eEhdQJ6sQZ61L5iQcqXyU2+fwHjFwMf9iW1Rg6vEc5MFH9LUu0piatzwjB+R1NCW3
 Lu7Gku6iM4Y8rs6z5Ao4SVBkJHWKXVAykxgaBePQyTPQ7+IFbHtUAyO8wLLheTzm0N
 fGo0bLkM+H0fE07LfxSZ0MUaENWzMw14qe86gqG69SaRhUMJRPC1bmZebFaWBVbnKJ
 1B1VWxBgBC3GrbeEt9h7WEwojjUphhlzBTcPSQNpaGkXukGjIcFOHGk8ZLGSmUrtxB
 98txCFpcSzR1SX/Ggj0Xb8dLRWqTQNMr0yz4rt0GOJVA3qMXRkW5FbiuNyMhDxu86e
 qNb4sZF3SaNZA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=eEhdQJ6s
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 11 Aug 2026 23:05:54 +0200, Martin Herren wrote:
> The Radxa Rock 4D exists also with a different SPI flash chip than the
> one specified in the schematic[1]: XMC XM25QU128C.
> At least board revision V1.12 can be impacted.
> 
> Enable CONFIG_SPI_FLASH_XMC Kconfig options.
> 
> Without this SPL fails to probe the SPI flash and thus fails to load
> U-Boot proper from it.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/1] rockchip: rk3576-rock-4d: Enable XMC SPI chip
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/64d6610cf42eaad2d61ece8e50ed4ab0b5bae93d

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>


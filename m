Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4056FC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4E984AA4;
	Fri, 10 Jul 2026 15:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="gN5pez1/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C2784A63; Fri, 10 Jul 2026 15:17:38 +0200 (CEST)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::8faf])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B4484A9E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSH0NRYzj1L;
 Fri, 10 Jul 2026 15:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689454;
 bh=FhanyKMqIGwsxsUEVksaWjTlIrJF1aKn6eykk8P432s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gN5pez1/4utw3J/zHZol1v8FU3tmKJsMGUIMkum8excD5lfNlSzelg7hMhyjEHu1P
 g5AdbnXLhg+Zz1wXZe4wwW4or2iHtDbvVRlJqlwr90umQ0HHDgCfuqKvovx5fVtyxf
 xYvFvEyfr5/x6/4P8NDMgeVMXQTcM190V3520i/M/rhBf2G4TU2vj8XOcDFmvFgXVV
 frsx4gQbNt2dQUsLijn8zslhkQzdPWnxSUh60dy84n7hzSbsx5ItVDc8RGtADWDWS0
 m/bC6tNhGADTlEE3TKzmgcGnykbUgkOgD6kQADc0aJsMK44K5dus4ERxILs7ymuZuR
 dOd++oJeHBYoQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSG0NFVzfKx; Fri, 10 Jul 2026 15:17:34 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
In-Reply-To: <20260707100918.3057718-1-jonas@kwiboo.se>
References: <20260707100918.3057718-1-jonas@kwiboo.se>
Subject: Re: [PATCH] arm: dts: rockchip: Align OTP nodes for RK3528/RK356x
 with Linux v7.1
Message-Id: <178368945402.879692.2435958373792787796.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:34 +0200
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

On Tue, 07 Jul 2026 10:09:17 +0000, Jonas Karlman wrote:
> The <soc>-u-boot.dtsi OTP nodes for RK3528/RK356x use different names
> compared to the OTP nodes that was merged in Linux v7.1. This causes
> build issues when dts/upstream pulls in updated DTs, i.e.:
> 
>   ERROR (duplicate_label): /soc/nvmem@ffce0000: Duplicate label 'otp'
>                            on /soc/nvmem@ffce0000 and /soc/efuse@ffce0000
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] arm: dts: rockchip: Align OTP nodes for RK3528/RK356x with Linux v7.1
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/d4140de41eba31166d43c2759fc8c444d9116084

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>


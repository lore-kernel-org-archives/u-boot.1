Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9F1C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 750CA84A92;
	Fri, 10 Jul 2026 15:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="LkC9IBCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A06E384AC5; Fri, 10 Jul 2026 15:17:39 +0200 (CEST)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 039EC84AA1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSH4RFFzjqW;
 Fri, 10 Jul 2026 15:17:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689455;
 bh=4uj21KJtYAiTHwKQp0MaC9HlznCoE9Fn9iBf3aE/kNI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=LkC9IBCSOFviGIFIytQ4KVxR6kYy9HoIvuTMjjx1HRHX7zJMINdS1AKVpCZ5pS47z
 4pZ03eaKc7hFM2+TU+qjGIpYepQJceQtEQM3ydKb8lyeKGERXivE1ZNF9bcXCUKqJt
 e8T4DiKg3Txh6eTulxXGWo1bzu7dTQE+3I/ZTzDRPsiDpcNMyfjyna4f61lxH7s0wL
 1YnYSfCAx8lyPp4/b9O6JeFSTsA8mTJyg590TcKhvMdr6PHpjFZHLGU/QUV2Xp4Kex
 jT0rcW6eeaeJJ/yIEbdli+zgYsIhcrPR2rpxDqlG9QXk/EhCSa2BdC3sQpZpvC7kC6
 AIM/JYo0OWVmQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSG6mnrzfcx; Fri, 10 Jul 2026 15:17:34 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: kever.yang@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
In-Reply-To: <d0f7ce27-ad87-4910-be25-e867b5af4956@gmail.com>
References: <d0f7ce27-ad87-4910-be25-e867b5af4956@gmail.com>
Subject: Re: [PATCH v1] rockchip: doc: fix typo evb-rk3288-rk808_defconfig
Message-Id: <178368945492.879692.973107125125223229.b4-ty@b4>
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

On Tue, 30 Jun 2026 16:01:00 +0200, Johan Jonker wrote:
> Use correct defconfig name for evb-rk3288-rk808.

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] rockchip: doc: fix typo evb-rk3288-rk808_defconfig
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/9b238123825c71cdb871b02e404f1443827fb69b

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>


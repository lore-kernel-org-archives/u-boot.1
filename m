Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4585C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 13:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C329876EF;
	Wed, 24 Jan 2024 14:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="FS/X2YZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AD387A07; Wed, 24 Jan 2024 14:30:20 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88A52876A9
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 14:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rSdKZ-00006t-SJ; Wed, 24 Jan 2024 08:30:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=TIdSG+BvmWfaLjvJQ4WHO+WqFgafiIF2IBg+hFQbGYg=; b=FS/X2YZhy50MhutyVvXQ
 Z/0MfsjMfGH2VV67ME/yXgQzYdG/y3T07Yh1271KJ/oq4r+fr5xsr2s+DPeus1fni5WRo0RuhhdPN
 6K5rJ1iSHIZGH0ZKk/0ZWnZ8a8ixyWv2MpLXIcW/R6LUKbmdShBqylW8Ho5jyuPNdNHWCWoVO9PVc
 3NClksyDhPrLMvUGmQvZ6dj1UtIzJsLI5cSfHdCtm+tcwEFDWJacuq7Z6KiZBimnD8g7cNW3AQPMA
 kd2H6XJczFhr9OKBfNWnlyd95C2adosHLMpYpopyB8j1I1gY+kwa1zYrZ9M6y8cfdleEmq4aL+lk0
 SC0gQg5vnviP5Q==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "festevam@gmail.com" <festevam@gmail.com>,  Christoph Stoidner
 <C.Stoidner@phytec.de>,  Wadim Egorov <W.Egorov@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] Add Phytec i.MX93 support
In-Reply-To: <e88317c9172455727459367953e0bb2acbd63eab.camel@phytec.de>
 (Yannic Moog's message of "Fri, 19 Jan 2024 07:21:35 +0000")
References: <20240117075254.8520-1-othacehe@gnu.org>
 <e88317c9172455727459367953e0bb2acbd63eab.camel@phytec.de>
Date: Wed, 24 Jan 2024 14:30:12 +0100
Message-ID: <87a5ou6eqj.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 24 Jan 2024 14:30:41 +0100
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


Hello Yannic,

> As a heads-up: you need to rebase as am62 (doc) got applied by Tom.

Noted.

> Is the trusted-firmware-a upstream version working? If so, please use that instead.

It is but only on the master branch, so it might be better to stick to
the nxp-imx repository until a lts release is created.

>> +#include <config_distro_bootcmd.h>
>
> I don't see a specific reason to have this include separate?! Group it with the others, please.

Many other include files place it here, right after the
BOOT_TARGET_DEVICES macro, so I guess there must be a reason, even
though I am unsure why :).

Thanks,

Mathieu

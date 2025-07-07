Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A3C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 13:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D3983156;
	Mon,  7 Jul 2025 15:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="t4mp47fP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2D583190; Mon,  7 Jul 2025 15:06:46 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6AE83156
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail2; t=1751893603; x=1752152803;
 bh=B8//H0xZdMrI41kT9p1PguAngy/SSopGH8i9yizMFKs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=t4mp47fPVss5jgO3ChY7AJnjajSI3EL96MsyUKYDA1lBtmzF8dc5eFbYbM+RkcVT+
 oxdg5OjiI4ahVCr2NKTk7fbeAOsfjyssTpx1sQ4d9/9t1xGyz6ybYWSecY1zm40FjD
 4cboO7iOQV1/1hkUBzSxULqhwIFx97pOdd372FDo8JN5quXUj0kKZuxgosAK+xEzMp
 1dtyorR10Wh+PMsGOwXp6eXq0+Pgk47Qmy5ww6LOKM0ZtWXcKHQOAzTaQsJr8BkRVO
 kSKGbf9FBdr9dftw5VXC7Igqr8iad4eE1HbIb0KTzA84I5LvQ3u9/r2g3A8vo8A8oN
 skqliFVCtwwzg==
Date: Mon, 07 Jul 2025 13:06:38 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Jim Liu <jim.t90615@gmail.com>,
 Ye Li <ye.li@nxp.com>, =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Subject: [PATCH 3/4] gpio: add SPL to Kconfig option description
Message-ID: <20250707150438.3016690-4-philip@philipmolloy.com>
In-Reply-To: <20250707150438.3016690-1-philip@philipmolloy.com>
References: <20250707150438.3016690-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 7e90b26b43e73660e93fd3a640a06f405ebea4b2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

DM_GPIO_LOOKUP_LABEL and SPL_DM_GPIO_LOOKUP_LABEL had the same
description and therefore appeared to be duplicates in Kconfig frontends

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e11109fb56d..e143efffd35 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -88,7 +88,7 @@ config DM_GPIO_LOOKUP_LABEL
 =09  for the same functionality in board code.
=20
 config SPL_DM_GPIO_LOOKUP_LABEL
-=09bool "Enable searching for gpio labelnames"
+=09bool "Enable searching for gpio labelnames in SPL"
 =09depends on SPL_DM_GPIO
 =09help
 =09  This option enables searching for gpio names in
--=20
2.50.0



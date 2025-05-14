Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7CFC3ABDD
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C328C82AC4;
	Wed, 14 May 2025 18:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8733582AA7; Wed, 14 May 2025 18:18:37 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55B680050
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZyJRt1sM9zktL;
 Wed, 14 May 2025 18:18:34 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZyJRs4YmSzXXg; Wed, 14 May 2025 18:18:33 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/4] rockchip: enable exFAT support for Theobroma products
Date: Wed, 14 May 2025 18:18:12 +0200
Message-Id: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETCJGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0MT3dSKtMQS3ZLiFN1U8xRDMwODJJNEQ3MloPqCotS0zAqwWdGxtbU
 AXbwJRlsAAAA=
X-Change-ID: 20250514-exfat-tsd-e7d1600b4a17
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

Our upcoming Mass Production Flasher solution will be storing boot
artifacts on an exFAT partition so enable its support for all our
products.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (4):
      configs: ringneck-px30: enable exFAT support
      configs: jaguar-rk3588: enable exFAT support
      configs: tiger-rk3588: enable exFAT support
      configs: puma-rk3399: enable exFAT support

 configs/jaguar-rk3588_defconfig | 1 +
 configs/puma-rk3399_defconfig   | 1 +
 configs/ringneck-px30_defconfig | 1 +
 configs/tiger-rk3588_defconfig  | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: 1b5e435102aa29a665119430196cb366ce36a01b
change-id: 20250514-exfat-tsd-e7d1600b4a17

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


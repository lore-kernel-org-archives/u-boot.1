Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EE7C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A04D86F6E;
	Wed, 12 Jun 2024 16:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69561887DD; Wed, 12 Jun 2024 16:41:10 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682B386784
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VzpBW6plMz5Gh;
 Wed, 12 Jun 2024 16:41:07 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VzpBW386Pz7sl; Wed, 12 Jun 2024 16:41:07 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] rockchip: puma-rk3399/ringneck-px30: make closer to
 Jaguar/Tiger defconfigs
Date: Wed, 12 Jun 2024 16:40:47 +0200
Message-Id: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG+zaWYC/x3MQQqAIBBA0avIrBN0CKmuEi1MJxsCDY0IpLsnL
 d/i/wqFMlOBSVTIdHPhFBt0J8DtNgaS7JsBFfbKaJSZY4jkDrmmdHlJdtRorCKtBmjRmWnj5x/
 Oy/t+T+zvIGAAAAA=
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 heiko@sntech.de
X-Mailer: b4 0.14-dev-a6ee3
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

To ease maintenance, limit test scenarios and variations, let's enable a
few things:
 - full bootstd
 - a handful of CLI commands like gpio, squashfs, erofs, pmic,
   regulator, and the likes.

This also disables support for non-Linux OSes as Linux is the primary
target, we may revisit this in the future if necessary.

Also disables support for zImage on Puma since those aren't supported on
Aarch64, one is supposed to use Image.gz (or any other supported
compression format) with booti instead.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      rockchip: ringneck-px30: get closer to other Theobroma defconfigs
      rockchip: puma-rk3399: get closer to other Theobroma defconfigs

 configs/puma-rk3399_defconfig   |  9 ++++++++-
 configs/ringneck-px30_defconfig | 16 +++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)
---
base-commit: 787eaa9c8df2660c748358eb689de916f991e22e
change-id: 20240612-ringneck-bootd-ea9126a0e108

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C117CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 10:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3349B83443;
	Tue, 23 Sep 2025 12:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D624D833ED; Tue, 23 Sep 2025 12:27:39 +0200 (CEST)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DD0A80050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 12:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cWGQ04DsYzCWp;
 Tue, 23 Sep 2025 12:27:36 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cWGPz73svzHrl; Tue, 23 Sep 2025 12:27:35 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] mkimage: fit: various fixes in fit_{import,extract}_data
Date: Tue, 23 Sep 2025 12:27:19 +0200
Message-Id: <20250923-mkimage-2-runs-data-size-v1-0-ef3fa57e9645@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAd20mgC/x2MQQqDMBAAvxL23IVkNYj9ivQQ4rZdJKlkqxQlf
 zf0OAMzJygXYYW7OaHwLiqf3MDdDMR3yC9GmRsDWfJ2pA7TIik0TVi2rDiHb0CVgzHaOPrB+p5
 chJavhZ/y+6+nR60XdxoFLGoAAAA=
X-Change-ID: 20250923-mkimage-2-runs-data-size-c0c95705421c
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lars Feyaerts <lars@bitbiz.be>
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

I had to hunt down a difference between the FIT after running mkimage
once and after running it twice. The use-case is typically U-Boot
generating an unsigned FIT and then calling mkimage manually to sign it
outside any build system.

The issue can be reproduced with the following

make CROSS_COMPILE=aarch64-linux-gnu- BUILD_TAG= SOURCE_DATE_EPOCH=0 O=build/ringneck ringneck-px30_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- BUILD_TAG= SOURCE_DATE_EPOCH=0 O=build/ringneck -j`nproc`
cd build/ringneck
cp ./simple-bin.fit.itb ./simple-bin.foo.fit
cp ./simple-bin.fit.itb ./simple-bin.foo2.fit
BUILD_TAG= SOURCE_DATE_EPOCH=0 ./tools/mkimage -E -t -B 200 -F ./simple-bin.foo.fit
BUILD_TAG= SOURCE_DATE_EPOCH=0 ./tools/mkimage -E -t -B 200 -F ./simple-bin.foo2.fit
BUILD_TAG= SOURCE_DATE_EPOCH=0 ./tools/mkimage -E -t -B 200 -F ./simple-bin.foo2.fit

then compare the output of

dtc -I dtb -O dts simple-bin.foo.fit
dtc -I dtb -O dts simple-bin.foo2.fit

data-size and data-offset properties are swapped.

While going through the code, I identified a few theoretical issues
possibly triggered by not checking the return code of fdt_setprop so
those are added. Not tested outside of building.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      mkimage: fit: do not overwrite fdt_setprop return value
      mkimage: fit: do not ignore fdt_setprop return code
      mkimage: fit: erase data-size property when importing data

 tools/fit_image.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)
---
base-commit: df4c18067fe04d42c9929d6c3565f8ec002b41f2
change-id: 20250923-mkimage-2-runs-data-size-c0c95705421c

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


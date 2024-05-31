Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EB2C27C44
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 17:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B96882F1;
	Fri, 31 May 2024 19:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401B9887EC; Fri, 31 May 2024 19:35:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BEA18882BE
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 19:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C227113E;
 Fri, 31 May 2024 10:36:06 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 312C43F792;
 Fri, 31 May 2024 10:35:41 -0700 (PDT)
Date: Fri, 31 May 2024 18:35:38 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, U-Boot
 Mailing List <u-boot@lists.denx.de>
Subject: adding file to gitlab CI build directory?
Message-ID: <20240531183538.4999839f@donnerap.manchester.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi,

some Allwinner devices use some kind of "secure boot", which requires the
SPL image to be build wrapped in a TOC0 format instead of the normal EGON
format. mkimage supports that for a while, but for that to work it
requires some private key in the current directory. This key is easily
generated with "openssl genrsa -out root_key.pem", and mkimage prints that
command when no file is found, so it's easy for users to comply.

However this understandably upsets the gitlab CI, and breaks the build:
https://source.denx.de/u-boot/custodians/u-boot-sunxi/-/jobs/835423
+mkimage (TOC0): error: Failed to read private key from 'root_key.pem'
+mkimage (TOC0): info: Try 'openssl genrsa -out root_key.pem'
+make[2]: *** [scripts/Makefile.spl:446: spl/sunxi-spl.bin] Error 1
+make[2]: *** Deleting file 'spl/sunxi-spl.bin'
+make[1]: *** [Makefile:2089: spl/u-boot-spl] Error 2
+make[1]: *** Deleting file 'spl/u-boot-spl'
+make: *** [Makefile:177: sub-make] Error 2

This prevents me from merging the defconfig for a device requiring secure
boot, so I was wondering what the solution would be?
The actual key is irrelevant for the build, so we could either insert
*some* root_key.pem into the CI build directory, or generate this key on
the fly, using openssl.

I have no clue what would be best or easiest here, or how to pull this
off, so any suggestions are welcome.

Thanks,
Andre

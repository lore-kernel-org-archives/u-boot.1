Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97D6D33981
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 16:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB8484047;
	Fri,  5 Dec 2025 17:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y5PXQ7pZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B0284047; Fri,  5 Dec 2025 17:01:48 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF3683FA7
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 17:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linusw@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B6A51600C4;
 Fri,  5 Dec 2025 16:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85A5C4CEF1;
 Fri,  5 Dec 2025 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764950504;
 bh=qx6DNwX0vD+UonK9ThSlHrMo3v0Agpmu8sdmLXdZhL0=;
 h=From:Date:Subject:To:Cc:From;
 b=Y5PXQ7pZyfkxAjRJWMb0ATqYAIoyeMFEkEiCaAFg6uGlheZRK4f+vjl4RGMAojHAm
 YrTmW8j8UG+zXB/NUAKCUKvo5dDw92f4RZmbQUrPGWmJTsLVrEQxVal2WVQmWU0TDn
 D+R4pL0cf3kEhb5jGhzg6/Th51SjKeaSeUJu/XRj27m4aG8bWTgu1S3beHjA0Ew5zM
 z0QwauVuhfSYyBcbf8PgYlMso1lZojSV59g4hffklU3Ht9bOog05Dnk3A8n/kh3VTm
 mAtkWN8tguSTyy8bU3EH6Jgm5/DknQ6RqDONWMIZAteSC7m0lhbnO0yKTWsbRQXVG2
 r+TRkPblZu2BA==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 05 Dec 2025 17:01:38 +0100
Subject: [PATCH v2] MAINTAINERS: update my email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251205-linusw-kernel-org-v2-1-40c8652749b2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2TX0B4yefA/DgZYtbCStabVqC
 O9uxbvHbybzzQKJIlOCU7VApMyJgy8gdxXYqfcjIQ+FQdayEbJucGb/SE+8UvQ0Y4gjOmmNdX0
 7KG2g7G6RHL8256UrPHG6h/jeLrL4pv9sWaDAXrWktLTaHA/nX7kvJXTrun4ALVagL7MAAAA=
X-Change-ID: 20251205-linusw-kernel-org-f2cbcfa6d34b
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, David Feng <fenghua@phytium.com.cn>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
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

I am moving over to using my email address at kernel.org.
Change this in all the affected MAINTAINERS files.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- Collect Quentin's ACK.
- Also add a small .mailmap entry to push mail to the new address.
- Link to v1: https://lore.kernel.org/r/20251205-linusw-kernel-org-v1-1-a36e342c4b97@kernel.org
---
 .mailmap                            | 1 +
 MAINTAINERS                         | 4 ++--
 board/armltd/integrator/MAINTAINERS | 2 +-
 board/armltd/vexpress64/MAINTAINERS | 6 +++---
 board/broadcom/bcmns/MAINTAINERS    | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 04daa274ef31..0e01452a70cb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -75,6 +75,7 @@ Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <j
 Kalyani Akula <kalyani.akula@amd.com> <kalyani.akula@xilinx.com>
 Klaus Goger <klaus.goger@cherry.de> <klaus.goger@theobroma-systems.com>
 Masahisa Kojima <kojima.masahisa@socionext.com> <masahisa.kojima@linaro.org>
+Linus Walleij <linusw@kernel.org> <linus.walleij@linaro.org>
 Love Kumar <love.kumar@amd.com> <love.kumar@xilinx.com>
 Lukasz Majewski <lukma@denx.de>
 Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
diff --git a/MAINTAINERS b/MAINTAINERS
index cddeca734ffb..1789f023631a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -820,7 +820,7 @@ F:	include/linux/soc/ti/
 
 ARM U8500
 M:	Stephan Gerhold <stephan@gerhold.net>
-R:	Linus Walleij <linus.walleij@linaro.org>
+R:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	arch/arm/dts/ste-*
 F:	arch/arm/mach-u8500/
@@ -1648,7 +1648,7 @@ F:	include/scmi*
 N:	scmi
 
 SEAMA
-M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	cmd/seama.c
 F:	doc/usage/cmd/seama.rst
diff --git a/board/armltd/integrator/MAINTAINERS b/board/armltd/integrator/MAINTAINERS
index 8af765eaebc8..a228fc3daec8 100644
--- a/board/armltd/integrator/MAINTAINERS
+++ b/board/armltd/integrator/MAINTAINERS
@@ -1,5 +1,5 @@
 INTEGRATOR BOARD
-M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	board/armltd/integrator/
 F:	include/configs/integratorcp.h
diff --git a/board/armltd/vexpress64/MAINTAINERS b/board/armltd/vexpress64/MAINTAINERS
index c38ab520c521..58ab5db7e4a2 100644
--- a/board/armltd/vexpress64/MAINTAINERS
+++ b/board/armltd/vexpress64/MAINTAINERS
@@ -1,18 +1,18 @@
 VEXPRESS64 PLATFORM
 M:	David Feng <fenghua@phytium.com.cn>
-M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Linus Walleij <linusw@kernel.org>
 M:	Peter Hoyes <Peter.Hoyes@arm.com>
 S:	Maintained
 F:	board/armltd/vexpress64/
 F:	include/configs/vexpress_aemv8.h
 
 VEXPRESS_AEMV8A_SEMI BOARD
-M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	configs/vexpress_aemv8a_semi_defconfig
 
 JUNO DEVELOPMENT PLATFORM BOARD
-M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	configs/vexpress_aemv8a_juno_defconfig
 
diff --git a/board/broadcom/bcmns/MAINTAINERS b/board/broadcom/bcmns/MAINTAINERS
index 63c6d8bb4aca..4972d6cc9343 100644
--- a/board/broadcom/bcmns/MAINTAINERS
+++ b/board/broadcom/bcmns/MAINTAINERS
@@ -1,5 +1,5 @@
 BCMNS BOARD
-M:	Linus Walleij <linus.walleij@linaro.org>
+M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	board/broadcom/bcmns/
 F:	configs/bcmns_defconfig

---
base-commit: c98b6a6dcd1fc7bcba081fc2353954e33de5053c
change-id: 20251205-linusw-kernel-org-f2cbcfa6d34b

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


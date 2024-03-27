Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C53C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF8A88089;
	Wed, 27 Mar 2024 11:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E538880AA; Wed, 27 Mar 2024 11:49:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A0B2D880A3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333702F4;
 Wed, 27 Mar 2024 03:49:58 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BCFB3F694;
 Wed, 27 Mar 2024 03:49:21 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/4] capsule: Makefile: add the generated files to
 CLEAN_FILES list
Date: Wed, 27 Mar 2024 16:19:02 +0530
Message-Id: <20240327104902.905144-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327104902.905144-1-sughosh.ganu@linaro.org>
References: <20240327104902.905144-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

A certain set of capsule files are now generated as part of the
sandbox build. Add these files to the CLEAN_FILES list for deletion on
invoking any of the cleanup targets.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: None

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ff003a5ad8..1df2e81654 100644
--- a/Makefile
+++ b/Makefile
@@ -2166,7 +2166,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
-	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb
+	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
+	       Test* capsule.*.efi-capsule capsule*.map
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.34.1


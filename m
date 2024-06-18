Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D92CC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 06:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B5C88403;
	Tue, 18 Jun 2024 08:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BE4G5ArV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73ECE88468; Tue, 18 Jun 2024 08:23:18 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA3B883C2
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9F0A44220B; 
 Tue, 18 Jun 2024 06:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718691795;
 bh=UC7BC5dUind/JLZ/arnX7WJRfB3DXMWd7TItcVzB+OI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=BE4G5ArVtdWAlmJdKAjar8uJ/Dzafvtz1UXkOtj/3hP3y5JFcXfZl33NCqzlwLWE7
 yezxGIjmZM6jnQzTSSx2s51zL/NNfRM7HB9d3y0CqxwaMaTpGL67GJhekD99QQ4XM8
 s7m3EraucgLeXbuCjsK4ZX2TAksy5ciunfe0k3t13CZvd6brg6zH3Tqh4k5729aRQr
 Mfx+7QAz+Rb5/p8HmUMdLuaC6oTklBrRnz+Ec2eMLaCR9tVnNvLEqSX5pQACj0z5vM
 t5RDZKqn1GmRvOozx1WVK35w5lal3qSFVw1QeyS3k79YPpu/MDLF9YtqNyVssBiwRZ
 5VCmYkd5wNz9g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sam Povilus <sam.povilus@amd.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] boot: links to FIT documentation in Kconfig
Date: Tue, 18 Jun 2024 08:23:17 +0200
Message-ID: <20240618062317.11950-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Correct the links to the FIT documentation in boot/Kconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6..36bdc83b957 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -85,7 +85,7 @@ config FIT_SIGNATURE
 	  using a hash signed and verified using RSA. If
 	  CONFIG_SHA_PROG_HW_ACCEL is defined, i.e support for progressive
 	  hashing is available using hardware, then the RSA library will use
-	  it. See doc/uImage.FIT/signature.txt for more details.
+	  it. See doc/usage/fit/signature.rst for more details.
 
 	  WARNING: When relying on signed FIT images with a required signature
 	  check the legacy image format is disabled by default, so that
@@ -223,8 +223,8 @@ config SPL_LOAD_FIT
 	  1. "loadables" images, other than FDTs, which do not have a "load"
 	     property will not be loaded. This limitation also applies to FPGA
 	     images with the correct "compatible" string.
-	  2. For FPGA images, the supported "compatible" list is in the
-	     doc/uImage.FIT/source_file_format.txt.
+	  2. For FPGA images, the supported "compatible" list may be found in
+	     https://fitspec.osfw.foundation/.
 	  3. FDTs are only loaded for images with an "os" property of "u-boot".
 	     "linux" images are also supported with Falcon boot mode.
 
-- 
2.43.0


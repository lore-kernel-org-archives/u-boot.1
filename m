Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010CCC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FE781F4E;
	Thu, 27 Mar 2025 16:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484E281E13; Thu, 27 Mar 2025 16:33:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EE72581F71
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996C41762;
 Thu, 27 Mar 2025 08:33:59 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21DB13F694;
 Thu, 27 Mar 2025 08:33:53 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 18/18] [DO NOT MERGE] Makefile: enable switch/case fallthrough
 warnings
Date: Thu, 27 Mar 2025 15:33:13 +0000
Message-Id: <20250327153313.2105227-19-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
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

=================================================================
This does not fully work yet, there is at least the libbz2 code
left to be handled. But this patch helps to let CI find more
places where we need annotations.
=================================================================

C's implicit fallthrough behaviour in switch/case statements can lead to
subtle bugs. Quite some while ago many compilers introduced warnings in
those cases, requiring intentional fallthrough's to be annotated.

So far we were not enabling that compiler option, so many ambiguities
and some bugs in the code went unnoticed.

With all places that produced warnings fixed or annotated now, we can
add this compiler option to the build flags, to find new ambiguities
early, before the code gets merged.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 7d83ce16721..46c48556788 100644
--- a/Makefile
+++ b/Makefile
@@ -808,6 +808,7 @@ endif
 # These warnings generated too much noise in a regular build.
 # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
+KBUILD_CFLAGS += -Wimplicit-fallthrough
 
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
-- 
2.25.1


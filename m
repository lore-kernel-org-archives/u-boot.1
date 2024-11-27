Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC5AD609A8
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 07:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA2D89CD6;
	Wed, 27 Nov 2024 08:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D1E89794; Wed, 27 Nov 2024 08:13:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E09B9896FF
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 08:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33F012444;
 Tue, 26 Nov 2024 23:13:35 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A1593F58B;
 Tue, 26 Nov 2024 23:13:02 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <lucent@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/2] bouncebuf: allow for allocating bounce buffer frome heap
Date: Wed, 27 Nov 2024 12:42:49 +0530
Message-Id: <20241127071250.736762-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127071250.736762-1-sughosh.ganu@linaro.org>
References: <20241127071250.736762-1-sughosh.ganu@linaro.org>
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

The current bounce buffer logic checks if the user passed buffer is
DMA aligned, and if so, the same buffer is used. This can be an issue
on platforms which have certain IP's that are unable to access memory
addresses above a certain point. Introduce a config symbol that can be
used by such platforms which forces the bounce buffer logic to
allocate the buffer from the heap which is part of the U-Boot image
area.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 common/bouncebuf.c   | 2 +-
 drivers/core/Kconfig | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/bouncebuf.c b/common/bouncebuf.c
index b2f87e4d93..f827378e5f 100644
--- a/common/bouncebuf.c
+++ b/common/bouncebuf.c
@@ -44,7 +44,7 @@ int bounce_buffer_start_extalign(struct bounce_buffer *state, void *data,
 	state->len_aligned = roundup(len, alignment);
 	state->flags = flags;
 
-	if (!addr_is_aligned(state)) {
+	if (CONFIG_IS_ENABLED(BOUNCE_BUFFER_ALLOC) || !addr_is_aligned(state)) {
 		state->bounce_buffer = memalign(alignment,
 						state->len_aligned);
 		if (!state->bounce_buffer)
diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 6b4330fe4e..94258e8761 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -476,4 +476,11 @@ config BOUNCE_BUFFER
 	  A second possible use of bounce buffers is their ability to
 	  provide aligned buffers for DMA operations.
 
+config BOUNCE_BUFFER_ALLOC
+	bool "Allocate memory for bounce buffer"
+	depends on BOUNCE_BUFFER
+	help
+	  Certain platforms have IP's which are unable to access addresses above
+	  a certain value. This symbol forces the bounce buffer to be allocated
+	  from within the U-Boot image area for such platforms.
 endmenu
-- 
2.34.1


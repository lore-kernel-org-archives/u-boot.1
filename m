Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A146FC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F6C80C99;
	Wed, 29 Jan 2025 18:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Zv8Jujr+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ra7ruvfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A2A80C5A; Wed, 29 Jan 2025 18:05:45 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D688780646
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YjpSk6ln8z9tMX;
 Wed, 29 Jan 2025 18:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrParizZO8xPECIFBXY5ro10HV/U8cdvriUwXG9iJ4w=;
 b=Zv8Jujr+qt/xmREKWh84g6m3CH6VCWwukUmJAfpjXaf89F3zWgOHM9n8M7b5XK4Td6XLGj
 W/RcvbBV56RKSRCCF337kcNjZj+X6OfWPy3YnH7uKTIxKW6YCNLfZSR0M2LXDujo9O9QRs
 EsalHtJ1GicqERTOitesLmDz2g3qaJrCt6nYYQaOJ79iOWf/GhAV4WQv0DrAvliUuoV9Cs
 MnFEHRYBKrVFikSpTq7hUwe0iobgteaopCYXFQSD6+xQGAne8KKgZ7m5JNbALpZ3KTipEG
 EtEMhZO96/4GbTMx3sXMwMR9wjIhP2isbTC5oPSO5P5ceHFR1x7yZgWHj15jrg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738170340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrParizZO8xPECIFBXY5ro10HV/U8cdvriUwXG9iJ4w=;
 b=Ra7ruvfmZjktXNX5ReIR56wCmOWecrsGE6HlVsTL/jR/6i42cNwihEwfh7ge5Y3lZrX0yL
 ix8xiObo9Ghr0rGJhLdyEKiAv5aHp1TISDTAs9Z+rAif9raj8WMx67RURoSdyghpp8Dx0u
 IQsZCGlToHbw429nbD32g/heyDe5CAuu/ypkNXxIJ9DDNMdP/Y+lzzI0efb9Oty1QtKieg
 /GxB6fTaSGukamr7/S2CP8ocETkGxENO7p3pxLuZa3gy+TAglBg+QfzgI/EhKh1gEHMu3q
 AM/2uNYCQsSBdt0sarx8bt3RhL780qcI3ZRnEES1fsD/0z7wzyGM7NXYlh6AEA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Adam Ford <aford173@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/9] ARM: renesas: Rename common/common.c to
 common/rcar64-common.c
Date: Wed, 29 Jan 2025 18:04:29 +0100
Message-ID: <20250129170514.82118-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: da9b0c40db3335c8ce3
X-MBO-RS-META: 3xpmtphpw114ebyxf153g53ohdag98o6
X-Rspamd-Queue-Id: 4YjpSk6ln8z9tMX
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

The common.c content is specific to 64-bit R-Car SoCs, rename
the file to rcar64-common.c and remove R-Car 64-bit ifdeffery
in the file. No functional change.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
V3: - Add RB from Quentin
---
 board/beacon/beacon-rzg2m/Makefile                 | 2 +-
 board/hoperun/hihope-rzg2/Makefile                 | 2 +-
 board/renesas/common/Makefile                      | 2 +-
 board/renesas/common/{common.c => rcar64-common.c} | 0
 board/silinux/ek874/Makefile                       | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename board/renesas/common/{common.c => rcar64-common.c} (100%)

diff --git a/board/beacon/beacon-rzg2m/Makefile b/board/beacon/beacon-rzg2m/Makefile
index 6a6ae94def8..10b7a7fbfa9 100644
--- a/board/beacon/beacon-rzg2m/Makefile
+++ b/board/beacon/beacon-rzg2m/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
+obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
diff --git a/board/hoperun/hihope-rzg2/Makefile b/board/hoperun/hihope-rzg2/Makefile
index a42c55b9d00..299769c9cb6 100644
--- a/board/hoperun/hihope-rzg2/Makefile
+++ b/board/hoperun/hihope-rzg2/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
+obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
index c531738b22e..8c26c0afd90 100644
--- a/board/renesas/common/Makefile
+++ b/board/renesas/common/Makefile
@@ -18,7 +18,7 @@ endif
 # 64 bit SoCs
 ifdef CONFIG_RCAR_64
 ifndef CONFIG_XPL_BUILD
-obj-y	+= common.o
+obj-y	+= rcar64-common.o
 endif
 
 ifdef CONFIG_RCAR_GEN3
diff --git a/board/renesas/common/common.c b/board/renesas/common/rcar64-common.c
similarity index 100%
rename from board/renesas/common/common.c
rename to board/renesas/common/rcar64-common.c
diff --git a/board/silinux/ek874/Makefile b/board/silinux/ek874/Makefile
index c1cab6fa788..0beda63d115 100644
--- a/board/silinux/ek874/Makefile
+++ b/board/silinux/ek874/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../../renesas/common/gen3-spl.o
 else
-obj-y	:= ek874.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
+obj-y	:= ek874.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
 endif
-- 
2.45.2


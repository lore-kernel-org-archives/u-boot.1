Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3248C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 13:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B048070C;
	Tue, 10 Jun 2025 15:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6956C82B07; Tue, 10 Jun 2025 15:18:12 +0200 (CEST)
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch
 [45.157.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B05038007D
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 15:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bGq9F1xjTzmZ7;
 Tue, 10 Jun 2025 15:18:09 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bGq9D27c6z5gP; Tue, 10 Jun 2025 15:18:08 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 10 Jun 2025 15:17:56 +0200
Subject: [PATCH] pylibfdt: correct license information (further)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-pylibfdt-license-v1-1-fcb69e3d6a96@cherry.de>
X-B4-Tracking: v=1; b=H4sIAIMwSGgC/x3MSwqAIBRG4a3IHSeo0IO2Eg2y/uqCmGhEIe09a
 fgNzsmUEBmJepEp4uLEhy/QlaB5n/wGyUsxGWVq1Wglw+PYrsspHc/wCdJAN7U1nUbbUclCxMr
 3vxzG9/0AswgR7WIAAAA=
X-Change-ID: 20250610-pylibfdt-license-2e165b281e78
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Since commit 51ec8db23280 ("pylibfdt: correct license information"), the
License classifiers are gone so I assume setuptools now extract the
license from the license argument to setuptools.setup() function.

It's always been incorrect as far as I could tell, so let's fix this
with the appropriate info from the SPDX License identifier at the top of
the file. It was missing GPL-2.0-or-later and we disambiguate by using
BSD-2-Clause instead of simply BSD.

Fixes: 6b08fb5cc44f ("fdt: Move to setuptools")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Note: not tested
---
 scripts/dtc/pylibfdt/setup.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
index 487e669f524ad1d2b5e6549a2e3ee18968757da2..0f7485de9b50ba9ab9d2756f6588377de2722467 100755
--- a/scripts/dtc/pylibfdt/setup.py
+++ b/scripts/dtc/pylibfdt/setup.py
@@ -157,7 +157,7 @@ setup(
     long_description=long_description,
     long_description_content_type="text/plain",
     url="https://git.kernel.org/pub/scm/utils/dtc/dtc.git",
-    license="BSD",
+    license="GPL-2.0-or-later OR BSD-2-Clause",
     license_files=["Licenses/gpl-2.0.txt", "Licenses/bsd-2-clause.txt"],
 
     classifiers=[

---
base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
change-id: 20250610-pylibfdt-license-2e165b281e78

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


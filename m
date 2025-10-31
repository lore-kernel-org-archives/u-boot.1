Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3662CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1704C83A56;
	Fri, 31 Oct 2025 18:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB2E83A57; Fri, 31 Oct 2025 18:08:44 +0100 (CET)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDA483A45
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cynWF5h0FzZ0T;
 Fri, 31 Oct 2025 18:08:41 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cynWD62MXzCS; Fri, 31 Oct 2025 18:08:40 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Oct 2025 18:08:20 +0100
Subject: [PATCH v2 1/5] boot: fix incorrect dependency of FIT_RSASSA_PSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rsa-pss-always-v2-1-a29184ea064d@cherry.de>
References: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
In-Reply-To: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
To: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alexander Graf <agraf@csgraf.de>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

This padding has nothing to do with FIT except that we can make use of
it when verifying the FIT signatures.

This padding can also be used to verify the signature "manually" e.g. by
calling rsa_verify_hash() directly with an embedded public key.

Additionally, this padding is only useful if RSA (and specifically
RSA_VERIFY) is enabled otherwise it's not used.
The only other place it's used is in rsa-sign.c which is only built for
the host tools and handled by TOOLS_FIT_RSASSA_PSS symbol instead, so no
need to care for that one.

Finally, the FIT_SIGNATURE dependency also wasn't enough because it only
implies RSA_VERIFY, meaning it can be disabled and still have
FIT_RSASSA_PSS enabled.

So add a dependency on RSA_VERIFY and reword the input prompt.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9adb051400f..c5159b3b73b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -117,8 +117,8 @@ config FIT_SIGNATURE_MAX_SIZE
 	  space.
 
 config FIT_RSASSA_PSS
-	bool "Support rsassa-pss signature scheme of FIT image contents"
-	depends on FIT_SIGNATURE
+	bool "Support rsassa-pss signature scheme"
+	depends on RSA_VERIFY
 	help
 	  Enable this to support the pss padding algorithm as described
 	  in the rfc8017 (https://tools.ietf.org/html/rfc8017).
@@ -225,8 +225,8 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  space.
 
 config SPL_FIT_RSASSA_PSS
-	bool "Support rsassa-pss signature scheme of FIT image contents in SPL"
-	depends on SPL_FIT_SIGNATURE
+	bool "Support rsassa-pss signature scheme in SPL"
+	depends on SPL_RSA_VERIFY
 	help
 	  Enable this to support the pss padding algorithm as described
 	  in the rfc8017 (https://tools.ietf.org/html/rfc8017) in SPL.

-- 
2.51.0


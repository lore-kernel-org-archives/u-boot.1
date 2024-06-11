Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C34DC25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B850D88671;
	Tue, 11 Jun 2024 15:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D51886AE; Tue, 11 Jun 2024 15:04:44 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDDFA88681
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vz85k3hR2zGWQ;
 Tue, 11 Jun 2024 15:04:42 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vz85j6t9FzBjL; Tue, 11 Jun 2024 15:04:41 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 11 Jun 2024 15:04:24 +0200
Subject: [PATCH v2 1/4] dm: core: fix misleading debug message when
 matching compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-misc-20240610-v2-1-028e82b0b620@cherry.de>
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
In-Reply-To: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
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

A driver can have multiple compatible. When the id->compatible matches
for that driver, the first compatible supported by the driver is
currently returned, which gives the following confusing message:

   - found match at 'rk3588_syscon': 'rockchip,rk3588-sys-grf' matches 'rockchip,rk3588-pmugrf'

Considering that the compatible passed in argument is necessarily the
one that exactly matched to enter this code path, there's no need to do
some elaborate logic, just print the driver name and the compatible
passed in argument.

Fixes: d3e773613b6d ("dm: core: Use U-Boot logging instead of pr_debug()")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/core/lists.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 2839a9b7371..942fe4a4e67 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -246,9 +246,8 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
 		}
 
 		if (entry->of_match)
-			log_debug("   - found match at '%s': '%s' matches '%s'\n",
-				  entry->name, entry->of_match->compatible,
-				  id->compatible);
+			log_debug("   - found match at driver '%s' for '%s'\n",
+				  entry->name, id->compatible);
 		ret = device_bind_with_driver_data(parent, entry, name,
 						   id ? id->data : 0, node,
 						   &dev);

-- 
2.45.2


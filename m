Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D40D15DAB
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B00BF83FB0;
	Wed,  3 Dec 2025 17:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F31084008; Wed,  3 Dec 2025 17:19:44 +0100 (CET)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42a8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF7A83FBC
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM2sT3tmZztbK;
 Wed,  3 Dec 2025 17:19:41 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dM2sS4CR8zKYv; Wed,  3 Dec 2025 17:19:40 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 03 Dec 2025 17:19:33 +0100
Subject: [PATCH next v2 2/4] lib: rsa: use FIT_ALGO_PROP constant instead
 of "algo" in FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-fit-compat-v2-2-0fea56f23809@cherry.de>
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
In-Reply-To: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
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

Some FIT image properties have their string represented in
include/image.h via constants. FIT_ALGO_PROP does exist and would fit the
bill so let's use it instead of using a hardcoded string.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 lib/rsa/rsa-verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rsa/rsa-verify.c b/lib/rsa/rsa-verify.c
index e7e612a4688..3169c3a6dd1 100644
--- a/lib/rsa/rsa-verify.c
+++ b/lib/rsa/rsa-verify.c
@@ -448,7 +448,7 @@ static int rsa_verify_with_keynode(struct image_sign_info *info,
 		return -EBADF;
 	}
 
-	algo = fdt_getprop(blob, node, "algo", NULL);
+	algo = fdt_getprop(blob, node, FIT_ALGO_PROP, NULL);
 	if (!algo) {
 		debug("%s: Missing 'algo' property\n", __func__);
 		return -EFAULT;

-- 
2.52.0


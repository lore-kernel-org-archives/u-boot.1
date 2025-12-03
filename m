Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8665D12D7A
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3387B83FFE;
	Wed,  3 Dec 2025 17:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D686A84008; Wed,  3 Dec 2025 17:19:45 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9AB483F9D
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM2sW2tyczsvp;
 Wed,  3 Dec 2025 17:19:43 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dM2sV3q6FzLP4; Wed,  3 Dec 2025 17:19:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 03 Dec 2025 17:19:35 +0100
Subject: [PATCH next v2 4/4] boot/fit: print all configuration node compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-fit-compat-v2-4-0fea56f23809@cherry.de>
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

Fit conf node may have a compatible property[1] which stores the
compatible of the first blob in the fdt property of the node. This can
be used to automatically select the proper conf node based on the
compatible from the running U-Boot (matching the former's compatible
with the latter)[2].

This brings the ability to mkimage/dumpimage to print the compatibles of
the configuration node(s). U-Boot CLI commands such as iminfo also see
this addition to their output.

[1] https://fitspec.osfw.foundation/#optional-properties compatible paragraph
[2] https://fitspec.osfw.foundation/#select-a-configuration-to-boot
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 boot/image-fit.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index c42b22ab02b..cc7a4bb44dc 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -323,6 +323,17 @@ static void fit_conf_print(const void *fit, int noffset, const char *p)
 		printf("%s\n", uname);
 	}
 
+	for (fdt_index = 0;
+	     uname = fdt_stringlist_get(fit, noffset, FIT_COMPAT_PROP,
+					fdt_index, NULL), uname;
+	     fdt_index++) {
+		if (fdt_index == 0)
+			printf("%s  Compatible:   ", p);
+		else
+			printf("%s                ", p);
+		printf("%s\n", uname);
+	}
+
 	uname = fdt_getprop(fit, noffset, FIT_FPGA_PROP, NULL);
 	if (uname)
 		printf("%s  FPGA:         %s\n", p, uname);

-- 
2.52.0


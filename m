Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4C5C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0448832E9;
	Wed,  9 Apr 2025 17:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010AB83869; Wed,  9 Apr 2025 17:10:46 +0200 (CEST)
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42a8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B27E83869
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZXmbl0Ywnz45w;
 Wed,  9 Apr 2025 17:10:43 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZXmbk4YYDz20b; Wed,  9 Apr 2025 17:10:42 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 09 Apr 2025 17:10:28 +0200
Subject: [PATCH RFC 4/4] boot/fit: print all configuration node compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-fit-compat-v1-4-56df89ef486a@cherry.de>
References: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
In-Reply-To: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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
index 52dbd7e96180da306da7f1516e8a3ab18a51ea33..4a3656c97a2c4ef8ca85177b08e3447baeed1877 100644
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
2.49.0


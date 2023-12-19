Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969FC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D77987282;
	Tue, 19 Dec 2023 15:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/x4x/9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606D9871B4; Tue, 19 Dec 2023 15:21:51 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC6486FF4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:21:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7b7f3eda169so24393539f.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702995707; x=1703600507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vEV0eu2loWcPuvG54veokVRtV7/Nn6ZbjVAmJ4cK5aU=;
 b=F/x4x/9ykyBPiP/M7on3JD+jfLGpobAO5sPTZrsq2cTxkHoPlsIS32kU80ve7zudf/
 /sqiKshZRtgULYuViIcXMjw/SQRYJG2gRLJCSpgVIzqYHYMa+s2D3opPW6aIb/smUWri
 5J1fYXK4rf8nCL3m1Zsxpjn5+Fjc/FYB4/vTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702995707; x=1703600507;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEV0eu2loWcPuvG54veokVRtV7/Nn6ZbjVAmJ4cK5aU=;
 b=WL9jiioIW7Bh39wXQmPDcUy6w6GOLFlvGD/qM4+Q1vrSeQ7IWtqWXiRYQB5ggf6aNR
 RnnrN5ATezg6hyiAoRQQWgsGpqG59O4gWKyvUIEQbu0o43KSWY7sGZLmD/UG5XhIW/MX
 hzTI5bBg9ZwOWqjZIo1pOjmo8mls5g0c8cmuD0JHhKIAc5+7XtPIX7wI2eH7NbusHNaN
 TVZ/DAU2wTlN1P3OI2/Cq7BKZzvLPHGHeqVzVfj2g54LDcmv331jWz8bRh/FRam0oqyp
 8Hv0ChjT0qsFZr/XyAHKhUrx/6B/dyzdEI7oOXWbN6AOaZPQ9YqdWND60qeJU3o4EHGv
 LcoA==
X-Gm-Message-State: AOJu0Yy1h0pBXyq1Y/+jYQQm7ZajEcjgIFWoM8ow42ihW5ZRNKjF2pYx
 1Nl5Sx7ykM92a0Srs3oKEb0Ra7peOVap8Y87oDtXgA==
X-Google-Smtp-Source: AGHT+IHZuFj30YChKAQPRey2GweYV4GPZg3tJjTxPoIyiSzFGW/bk6Eyyky77o4vxd/Ldy3K7gvgXQ==
X-Received: by 2002:a05:6602:158a:b0:7b3:ecad:32ed with SMTP id
 e10-20020a056602158a00b007b3ecad32edmr29038657iow.8.1702995707416; 
 Tue, 19 Dec 2023 06:21:47 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ck27-20020a0566383f1b00b00463fe3a0860sm1366608jab.142.2023.12.19.06.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:21:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 10/10] Makefile: Use the fdtgrep -u flag
Date: Tue, 19 Dec 2023 07:21:25 -0700
Message-ID: <20231219142128.2388562-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

Use this flag so that the bootph binding is obeyed correctly.

Add a comment about what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/12
---

Changes in v2:
- Add a comment about the fdtgrep operations

 scripts/Makefile.lib | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 16bbc277a9f1..1ca84195c997 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -635,8 +635,19 @@ else
 fdtgrep_props := -b bootph-all -b bootph-pre-ram $(migrate_spl)
 endif
 endif
+
+# This rule produces the .dtb for an SPL build.
+#
+# The first fdtgrep keeps nodes with the above properties (with -u ensuring that
+# the properties are implied in all parents of a matching node). The root node
+# is always included, along with /chosen and /config nodes. Referenced aliases
+# (i.e. properties in /aliases which point to an incldued node) are also
+# included.
+#
+# The second fdtgrep removes all bootph properties along with unused strings
+# and any properties in CONFIG_OF_SPL_REMOVE_PROPS
 quiet_cmd_fdtgrep = FDTGREP $@
-      cmd_fdtgrep = $(objtree)/tools/fdtgrep $(fdtgrep_props) -RT $< \
+      cmd_fdtgrep = $(objtree)/tools/fdtgrep $(fdtgrep_props) -u -RT $< \
 		-n /chosen -n /config -O dtb | \
 	$(objtree)/tools/fdtgrep -r -O dtb - -o $@ \
 		-P bootph-all -P bootph-pre-ram -P bootph-pre-sram \
-- 
2.43.0.472.g3155946c3a-goog


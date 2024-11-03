Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0E1CF9C6A
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 03:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A29688A4C;
	Sun,  3 Nov 2024 04:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I800lXmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F334288F24; Sun,  3 Nov 2024 04:50:23 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B1888875
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 04:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2B7ED3F22F; 
 Sun,  3 Nov 2024 03:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730605820;
 bh=A7GcNJIzfBoBNW+Q2OAfoapNLmAnfh85FyRrVFPB/Ik=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=I800lXmmLxnadtNhwgEkM2SEHH2gApzjAow4I0xi0p5ALt1DMTQYYRFhjOPCgMXoo
 23Pb6sqjXvzXfz3TopD0ZXinIn50HMRYU6QuPVgU2wWb/6z0Ssm5ylYDVgO6qj54tS
 LZo4VRcX2oWAtYjAPPyK68tuFRIrVe0rrYYoU5KSaPx53JNRBgF2XNi+QeiQjEhtg7
 OsrTQJbzRW7oBOXQ6f4wTAx58bw8H1k3PazV6pemjCiUNxgsUwgSKZC+0NXaXcg3wC
 LXPIAaynAGipcefVpaX6yMjGv3eRfwhxCeHY+U6fdp5+a1zM8yT1KMtAzdUjo47h1U
 BHD6huP5BQRTg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lib: vsprintf: fix API build
Date: Sun,  3 Nov 2024 04:50:15 +0100
Message-ID: <20241103035015.29486-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Avoid a build failure when building with CONFIG_API=y, CONFIG_EXAMPLES=y:

    lib/vsprintf.c:312:14: warning:
    ‘device_path_string’ defined but not used [-Wunused-function]
     312 | static char *device_path_string(char *buf, char *end, void *dp, int field_width,
         |              ^~~~~~~~~~~~~~~~~~

Fixes: 64b5ba4d293a ("efi_loader: make device path to text protocol customizable")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index e5802866632..c7340a047b2 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -308,7 +308,7 @@ static __maybe_unused char *string16(char *buf, char *end, u16 *s,
 	return buf;
 }
 
-#if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT)
+#if CONFIG_IS_ENABLED(EFI_DEVICE_PATH_TO_TEXT) && !defined(API_BUILD)
 static char *device_path_string(char *buf, char *end, void *dp, int field_width,
 				int precision, int flags)
 {
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD96C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 22:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F28E8295C;
	Fri,  9 May 2025 00:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AGrDV7as";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E73F6828A2; Thu,  8 May 2025 21:38:34 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B293382162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 21:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af59c920d32so890987a12.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 12:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746733111; x=1747337911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7oB7A16wj8pYohp6bJkW+6S7a8iy6dHsS4riVvlrh7c=;
 b=AGrDV7as+CHOWerI4F6qLujRB2YkOzQcHbzTGFxNI7MpCiWN3GgR1X5HuxKUlY++TU
 ABt4cuLrFCxwlgMSTHadD9Xl+G5sT919gBRJfDTUSiIDOdqSz/ikxXQIZ7xUpC2p+xiI
 bg4BaTTiZED0ozURIXRjU2uDlMA72WBVtfDjzer4xTI97aruEA7kcG9jUjiOmmYNHmhV
 ptnFnW9To9hHFQvLmjDzRb06/8E3JXu/GVPuayE69ig0EqSQf1Xh0+y3Cg8cATNFUuXS
 R9MIl5Lf8TwFmTx9G8pPKoWfhts0MTK54D6Mi/na5VDH9qTG0G/zQBklrUuEj//SOoVa
 xRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746733111; x=1747337911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7oB7A16wj8pYohp6bJkW+6S7a8iy6dHsS4riVvlrh7c=;
 b=ADXJfT2jQObd6uvvWmWrGunPIhcqHcBLLfVxpOi4UQ+WFr/narhKVR4xd+uUwjG74Q
 j86sRHnz+4Y/WU21zchNA4jrlQ9UHh8AyVk/0HV4CDW9rus6zlbZYzsJIR7NkO44ZDgQ
 oYG4vvaOwSJVSO/FBO5pEur+qnEkCUYSvgBQunv/HVO0xXpS9BWPkoFvLo23OWQ5S+k7
 cJF8lKqgRYH198sBpRiK3ME5pRtI4NJwj+3KCfWGY89LYLDsSpGSSt6g8dmq6C00u2yL
 p3Fc7K84XRsARaWczXpHVA7sYUSRzJqWKuoAEDJsG3IFBb4xi8mM/h7rz1rVGV9DWoXO
 IF3w==
X-Gm-Message-State: AOJu0Yx3IcKQuf46vjNZxKKtuh0fxo6X4T7Jya5UWJIKs99l4EZYlT+W
 wcrbX7Ir8/S2u+Ck+RbFHH9Ov8VfOhzmMxjNwTZ/3ImtTBBUDhIeFEI+NSU4yzBjZg==
X-Gm-Gg: ASbGnct8DaOXdEm5sM0NvqKbpb1Dc3A8Sn9DbgITQlCWRMKlUA8LQuoRjfAPs0/TGa2
 ej+8TSTaUY4k2NUmSj7EhLkykLsYd1xzplNgln0xbcBYrnxD92TlY2aT03nptm0xBUgMYqDw3Ff
 p2m57S5SYhG/n0htc0ODYFftpfFA1aqqhrXCJrqNy4lrDDCvlNEv/wObeCooBhdVh4AET+mx6HI
 QRWnCIBQpvWSb/x6EIr62koICOkXX8tknGMRcv/z+2rjJz5Dj0KEMVjnQNS4QnFjCwgLwmbnM7r
 7aVpNrOM32AmG4lL09bJdKeCO++DUd3GcgO37ggtULMYQ9XlPlFhPjANpGyvDVfawRc4A0Xvbxe
 hBfUbi4sbOdF6rOj4qw==
X-Google-Smtp-Source: AGHT+IFT9r6hcVas0rnlRo37yrxGXLWbOSvaHQmDfMri4yfv3RKDQ74evSS+qOOjVlI5vksuOOAvtA==
X-Received: by 2002:a17:90b:1d81:b0:2ff:6e72:b8e9 with SMTP id
 98e67ed59e1d1-30c3d6464ffmr1102296a91.25.1746733110650; 
 Thu, 08 May 2025 12:38:30 -0700 (PDT)
Received: from noble-leuven.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30c39dd4b87sm398117a91.19.2025.05.08.12.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 12:38:30 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, carlos.lopezr4096@gmail.com,
 aristo.chen@canonical.com, di.gerasimov@gmail.com,
 marek.vasut+renesas@mailbox.org
Subject: [PATCH 1/1] cmd: ximg: handle Z_BUF_ERROR explicitly in GZIP
 decompression
Date: Thu,  8 May 2025 19:37:24 +0000
Message-ID: <20250508193724.4269-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 May 2025 00:16:49 +0200
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

When decompressing GZIP-compressed image parts via the `imxtract` command,
explicitly handle the `Z_BUF_ERROR` return value from `gunzip()` to provide
a clearer diagnostic. This error typically indicates that the destination
buffer is too small to hold the uncompressed data.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 cmd/ximg.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/cmd/ximg.c b/cmd/ximg.c
index 29d7c3279b3..0afa1bc6640 100644
--- a/cmd/ximg.c
+++ b/cmd/ximg.c
@@ -27,6 +27,7 @@
 #include <asm/byteorder.h>
 #include <asm/cache.h>
 #include <asm/io.h>
+#include <u-boot/zlib.h>
 
 static int
 do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
@@ -206,9 +207,13 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			break;
 #ifdef CONFIG_GZIP
 		case IH_COMP_GZIP:
+			int ret = 0;
 			printf("   Uncompressing part %d ... ", part);
-			if (gunzip((void *) dest, unc_len,
-				   (uchar *) data, &len) != 0) {
+			ret = gunzip((void *)dest, unc_len, (uchar *)data, &len);
+			if (ret == Z_BUF_ERROR) {
+				puts("Image too large: increase CONFIG_SYS_XIMG_LEN\n");
+				return 1;
+			} else if (ret != 0) {
 				puts("GUNZIP ERROR - image not loaded\n");
 				return 1;
 			}
-- 
2.43.0


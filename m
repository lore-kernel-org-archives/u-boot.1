Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F937D6554F
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 19:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9AF89672;
	Tue, 26 Nov 2024 20:12:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="XhjH4q1H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC6A896AB; Tue, 26 Nov 2024 20:12:23 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A2789691
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 20:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 5b939f06-ac2a-11ef-8d51-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 5b939f06-ac2a-11ef-8d51-005056999439;
 Tue, 26 Nov 2024 20:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=DQ1GyoYAvZod1lvzH6dFO51LUr2odlkRNJwrYHTt7Zo=;
 b=XhjH4q1HtWviHd53dyOa3fR6+WFeuthxpJHG90ZcQHEYw0nGTNRgjSdNySJdRpDXhDldr5EL80Qkv
 /XzBjiyWjSLPuvx7cQB3L6hR6vFczqIgzmqExCqy6J5L7MVSgqSa6sox2Hi1Wg99C+4yWpjoTWKXvu
 RriE66YTbYKjTHco=
X-KPN-MID: 33|icddR7pltyZUtYhTIkc6TIMnQKlt5Tvw7nTz0DPVrn+zD3B3jti7hdVouSzvVGm
 /uPYE5ty6Ihh7vmIF+bc1zckzkGvP/+KLPs93DJoWjmI=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|G+VtmaPuqzOZhOAWrjsGEVyzwFl9q3TShjDtdfDlmj3rE64UI6yGunbPvQu3TFs
 YYbyWQeKxbShyPe0lf5HueQ==
X-Originating-IP: 80.61.163.207
Received: from copland.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 5be2a2df-ac2a-11ef-892d-00505699d6e5;
 Tue, 26 Nov 2024 20:12:20 +0100 (CET)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, marex@denx.de,
 quentin.schulz@cherry.de, Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] Makefile: avoid non-standard sed expressions
Date: Tue, 26 Nov 2024 20:12:14 +0100
Message-ID: <20241126191214.21709-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.46.1
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

The '?' that is used in the sed expression that determines MK_ARCH
is part of the extended regular expression syntax, but the default
behaviour of sed as specified by POSIX is to use only basic regular
expression syntax.  Use the equivalent '\{0,1\}' instead as
suggested by the OpenBSD re_format(7) man page.

Fixes: 04b1d84221d5 ("Makefile: fix empty MK_ARCH when using ccache")
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 22953bdabd8..7933ade6eff 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\?[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
+  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(ccache\)\{0,1\}[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))
-- 
2.47.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2FCF483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5985184088;
	Mon, 23 Mar 2026 20:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cyaVwjIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2748412F; Mon, 23 Mar 2026 20:52:49 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCDC583FEC
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-67df55bb1efso216942eaf.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295565; x=1774900365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W9PlspDYRbmyQ28uFzB8tWouo201aZcHvTKVKUMZm3o=;
 b=cyaVwjIsS25E8cVI8H2qqzzzDiKSaOwHqa3Q9IVrUDDv84hfoZgwGd5fpdBMs3pSbQ
 53F3oadGkQMGzhou2XrtLAQxLMBWCO2lPPMC9J+qmWsPmJKYTKamNx02lOmuoKd/PthC
 RtZJTBroqotk36/9WOOOINcDK5LRn17m7JcdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295565; x=1774900365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W9PlspDYRbmyQ28uFzB8tWouo201aZcHvTKVKUMZm3o=;
 b=l5TbIuPniUVmv8wSvufG6KrJmdLP/OJ8zd39J5/xAaUtVitdNRCvpJS5dio/Yq3Rcp
 vovILoy56jYkUCmqL0hQ63g5Yu9gO2brLlvCLL0sljHd2s6jOkGsggJu6Ntwe/hR7LJY
 sE//SW8QyvovyPl7iQC81jlSPxTEJyeJ+OWsy5Lw3wYhfudE5Lt81pUWoFmiq3i9TT+X
 oS2kyDZCiD5Gt4fAamm9m4aH+Ky3+p0X/V/uIufKw5627Oh3U3OBD6zzIwPy85mmFMZj
 6Jrx7I8QJhaqBV5bQVjiW0PWvNl5N59W7yLwmoRRJcC/lNdTL5xuueTdreAgiOqQvoz0
 r0xA==
X-Gm-Message-State: AOJu0YzMTnl4nFUKXxywW1O6GLdd7nHFdWCr+0WrC7e7ERJodm2p7tHk
 deXqMOA3d7MJl/LTZWe4SsmFJM/ULk4HbxdsNEhClaLnCvmfhqo8kDQWHNMYHcy0qgn+j+cS9/f
 mVSLO9/8=
X-Gm-Gg: ATEYQzznLS2UUhX2rv7TbNoT4EW34H9vA6C6kYhL9rSqPijs39iXED8Yqs4h3VFD1xF
 8k5jXRMeSuq68L+vaFoHr90fU5mm251WVWlbaqkeRzukLW7AFaXsjX9/Hia8zhBmn/3zzpF2D89
 Jm6E9t5k/6xYHsf+/ihUPAn4SYqnYT0T1YnWkuyMfdZv1ZXS+pkEOItehptZWtbinhKqv9XQuf8
 yxD+6W6JYvayh6HL0XV19HfyNlOeaKenXkjMvqd+AMubGSLV77qmPVbv0Mjjs5achPGINRV85Dl
 1feF6CaMcqH1+w4IFzDsQOWFVVb57majw4CuirUFiNMv6QlY+1vaH9Dibhi5V4W78iVExTq10hC
 qzrjClfjufr1vNnuId1kEgNB5+n1GKLo4SHdsy8E41zvjlbLwnbCUcMnXUQuSNA03PgoYjSTiLN
 bO42GE2O0bk0quLR4VT2RTwlxBjBcen8FKl6U6OJ6ckkhPIEA1ud71MHtSxVEo7yQkMvtefNhi2
 oqLaIbeIozEQJ92iQM+qGEOz2E6Feq5gFwQa9i7zCCYwICQprY=
X-Received: by 2002:a05:6820:f033:b0:67d:ea9d:c89d with SMTP id
 006d021491bc7-67dea9dcc6amr3794246eaf.44.1774295565583; 
 Mon, 23 Mar 2026 12:52:45 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c253d8984sm6770677eaf.13.2026.03.23.12.52.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] dts: Disallow OF_UPSTREAM for sandbox
Date: Mon, 23 Mar 2026 13:52:44 -0600
Message-ID: <20260323195244.2363402-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Our sandbox platform are not appropriate for OF_UPSTREAM, reflect this in
Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 dts/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index af8d30b45ab9..169abe607837 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -88,7 +88,7 @@ config OF_LIVE
 
 config OF_UPSTREAM
 	bool "Enable use of devicetree imported from Linux kernel release"
-	depends on !COMPILE_TEST
+	depends on !COMPILE_TEST && !SANDBOX
 	help
 	  Traditionally, U-Boot platforms used to have their custom devicetree
 	  files or copy devicetree files from Linux kernel which are hard to
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DB2C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB494830B4;
	Wed,  2 Jul 2025 03:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H1DT9iVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE4E82E86; Wed,  2 Jul 2025 03:05:58 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F73830B4
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4067106dd56so2337904b6e.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418355; x=1752023155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=P727RLBHQvIniEtAA6vubSBkmLnmqoqprl6rHFL9K60=;
 b=H1DT9iVmiYr9qP5rUNnuAlzNDnGbQaBSBrBzJv4aKKhLIopGOG03cftpJYDGvp23mD
 YYKrJKpQTupbU0GcA5sJ//EEWHVizBNowNS0+c0auBOmPQWWzBUPybyevPuVV/JEj1LK
 /Sm9vC8CAIIePGocaMsVj4TFU5cUaGuwqlp9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418355; x=1752023155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P727RLBHQvIniEtAA6vubSBkmLnmqoqprl6rHFL9K60=;
 b=XtXbixqokcqWy13+ANn65ByM7ZnpectpMfskdise0TLUcv/6qTjRnFA69uCb6lfcBH
 +TvIbOqCG+KiPVrak9ouObAw06zeoIOS5/3RqPLYJcs8Nbwz2SAJBJ0DoyiNK0aufE1X
 NPx9us9ovlErJXgi7eaWOktUhJEgQ9aoxopG0fRkXN5DS28qcy7WJi5dpznYSpVXWxZ2
 YzOV/DY7erMo5m2cPf3Ihz6iwok+7QFt7YmEHbo21q/afQ+dLG03XkFKVdX0kHa2tUu9
 DCu1OoSCNjZj1Plmd2p+wLPSU+7YL0UtMovm0psqGy8YRZNMxNA28BmO6SXQJVySbk7G
 hfZw==
X-Gm-Message-State: AOJu0YwJBjW0tNUpP0wmdw5mxrjo+MvWINxL2Xcj46ApMSSQprUtxUe3
 fIlLPxUFpgjJ8D8wHSfSR4uKm8xhgwghTCJkcyFcfqsoSbL/mppHlbAIpAeRvk9aIjbsDvLsNXd
 cTA73+8U=
X-Gm-Gg: ASbGncvmoxx3/UM3OcqXNNHB++Qri0Oo+0REVbJ5kaNqRqXZuHF+h7ub2rwW5nwa+M8
 pdiKJmXg0Bpj9fxVxg0NJ5/QnoY1aSIzN1QpGQi0sRATKTOcXikiQmhV0yO0NBi3d/OeWoc+0JF
 NKX8LqIbL9F8ZnmAeqvp6tAQVy5bh9UgU4Sj+3GRImzaytKpcvuzlQolDU6in61ZX2cJGwrgxHV
 qqWCdY5FpU8XEAar20pGIWbhYi3hKRcAY3u2fU4sw923bnKrZ4Cs2RO4AEjNthoS+5IAlyuKSi0
 qw6paKDZi1kJcAS7BdaPj2SN5gLuNgZvAHv7TNbMeI9EHUm++l13gPxkB1/TYyX7eCDfmjxHhYq
 eKYsVNAsfo6zbTq3dcASm1K6+zufd/z3DoA==
X-Google-Smtp-Source: AGHT+IEdDsemUvRRCDWLumpGJrBWpKzTtt15LHfYf5TD3wNQE/QedlaI8yICNXhuCfqAjvvFc2cVeQ==
X-Received: by 2002:a05:6808:1994:b0:408:fb4c:859e with SMTP id
 5614622812f47-40b887a2077mr589647b6e.6.1751418355599; 
 Tue, 01 Jul 2025 18:05:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32288d4csm2325591b6e.10.2025.07.01.18.05.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:05:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] common/log_syslog.c: Add missing include of <env.h>
Date: Tue,  1 Jul 2025 19:05:54 -0600
Message-ID: <20250702010554.19315-1-trini@konsulko.com>
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

This file was making environment calls without including <env.h> and so
relying on an indirect inclusion from elsewhere. Add the missing include
directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/log_syslog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/log_syslog.c b/common/log_syslog.c
index 0dcb5f7cdeae..73bd3aca07e0 100644
--- a/common/log_syslog.c
+++ b/common/log_syslog.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
+#include <env.h>
 #include <log.h>
 #include <net.h>
 #include <asm/global_data.h>
-- 
2.43.0


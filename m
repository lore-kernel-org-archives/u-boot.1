Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8C4CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C3583946;
	Fri,  3 Oct 2025 22:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SWD0aLmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66CE883826; Fri,  3 Oct 2025 22:39:39 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 432A083936
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-42571b8abbaso24606115ab.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523976; x=1760128776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j8Xuo8j3fnDZ1kNNRRrJGXxXGYAlQU69kmL3U7n/FrU=;
 b=SWD0aLmGEuwLj/6ilbZHsW73bazDYFZlvsC8/CXeQDVOuWbLEtFzItoO3HlYlDe5pb
 mLnM07EO5DYqQhdmZ8prSx2ZJ7EoUpUteCH0Zzev2hnVMD6m3u8x4nmMKoLLgp+OjTuS
 jyZuD7HMtFjrUfWtcuN7mLFyEFFZhRHWsFtbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523976; x=1760128776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8Xuo8j3fnDZ1kNNRRrJGXxXGYAlQU69kmL3U7n/FrU=;
 b=CRvjm9rlKfKXlqEvoB7p9TMBlc8KMTXI9n38bvEqMzTQhhlpUrGU+3J/pc0tU/GsRJ
 fouljJ7iCUIMxwsK6jpVxWFN+aBk8RppYKfpnm/l9L/ZUQCZyx49ZSFyFH2IgGCdLKOp
 b2M1qN4Yd52svVWbz1lb38VClFZWA/dy7KtsbbIEWlCEa8pssgZgps/xi1nQ1ppVxDzg
 vYTxL36H0cDh5Aax52cmLnApPvVTJsWmc3wftZLnL5hvj9hbcNrm/eHXj8Enz9ZX7EjV
 OJJWWl2nI/Q9ZNuGXCOhvq7NL+Fsh7Z+X6utPluiqVUX1kXs96YDT5BtPv3V/WxVfjpl
 UFAg==
X-Gm-Message-State: AOJu0YwEar2MOw8/J7/M7fOpshX9Sgsh+Wjv5891qB8ttPKEWnyOjGba
 LUyPFt/4uUIVW/asH3ALmN3sRJ//jfmLm2AGurVjwSSjlzn8rXaLAjTgYcPx1OCzp1tXtWLu8Ig
 Hogqq3Q0=
X-Gm-Gg: ASbGnctH/bxfcr8tl34yA9vJILBljwgjypBAPUBAFDq1oiUHlyA5eT+WNIUVJxIVYZQ
 CCYN5Z7QP1273FcewcM+BwKf+44nb5PfMcPJEQQh6KdwmuNv5tiw8zjGXIg3144F0znaQgvZQRt
 2xthHZzWNeRtlz9WjlSNocQAE3KJLSU66KYYViX9lIiMlUgdyP5tHq7QetemMc/eQW0qjxImxjE
 JjB1ot+pwh8nbPMrp941MJTGeAjEKN/TfNXesud9vc86Y+BE6kC2kNybnef/bTb3xU4jMd5eSWD
 0wq3MEsjI240EHXyhFZeeXj4UAiTfs0YbmXaBonjMV5pVTypqzPUZCGXNI9On0S8uyFZnO/PLRo
 CKG4h0ti9Udx7J0wbLJopT6pUWJxo8/VxYcaO5d69GT7e/7n201ZfTUiHulIIhMGfllu/idv1xP
 0JpoJRMClBzb00CfOG9iecebw=
X-Google-Smtp-Source: AGHT+IHwW+ngegzauK9Y+Wzm8PBGDMx8wD4bK847dlLc0D6kWGIIea3V03zQnnkHyPC7gZNd4eKR/Q==
X-Received: by 2002:a05:6e02:190e:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-42e7ad16e68mr59910355ab.12.1759523976023; 
 Fri, 03 Oct 2025 13:39:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b2a4a22sm24939405ab.40.2025.10.03.13.39.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] global: Disable xPL phases when we have enabled COMPILE_TEST
Date: Fri,  3 Oct 2025 14:39:34 -0600
Message-ID: <20251003203934.1030125-1-trini@konsulko.com>
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

Due to how we implement the logic for selecting what should/shouldn't be
built in a given phase it becomes extremely cumbersome to make these
phases link when configured by "allyesconfig". As a starting point for
being able to enable "allyesconfig" and expand our static coverage,
disable all other phases in this case.

Future work can be done to enable other phases as time and interest
permit.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 458dce01700a..debc59b1d713 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -12,7 +12,7 @@ config SPL_DFU_NO_RESET
 
 config SPL
 	bool "Enable SPL"
-	depends on SUPPORT_SPL
+	depends on SUPPORT_SPL && !COMPILE_TEST
 	help
 	  If you want to build SPL as well as the normal image, say Y.
 
@@ -1630,7 +1630,7 @@ config SPL_AT91_MCK_BYPASS
 endmenu
 
 config TPL
-	depends on SUPPORT_TPL
+	depends on SUPPORT_TPL && !COMPILE_TEST
 	bool "Enable TPL"
 	help
 	  If you want to build TPL as well as the normal image and SPL, say Y.
@@ -1638,7 +1638,7 @@ config TPL
 source "common/spl/Kconfig.tpl"
 
 config VPL
-	depends on SUPPORT_SPL
+	depends on SUPPORT_SPL && !COMPILE_TEST
 	bool "Enable VPL"
 	help
 	  If you want to build VPL as well as the normal image, TPL and SPL,
-- 
2.43.0


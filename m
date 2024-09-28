Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A63FCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F7CC88DF5;
	Sat, 28 Sep 2024 22:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bqtl1Gj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98EFC88CB8; Sat, 28 Sep 2024 22:01:24 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B878F88D47
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a0cbc08b38so16273515ab.0
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553678; x=1728158478; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+F/WpACmL1ADaAlWd1Ohes5qvI/dcWOvBqEgDQ6uGM=;
 b=bqtl1Gj7DdpSHknrH0rBC1uhd0JKOq388Rv6YfZYyXCL5zsc7DBMlIYj2E4LHKWyXY
 /Mi/Wrfe8SUsNenCGmdCqFiyEKMabCXhT54nCgLv5qa3GeYG1RRsqJSy5eilZeoXHgJf
 HrxGYk2DYaLGJfWp71V9Qoab1iZtW/MxE7zNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553678; x=1728158478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+F/WpACmL1ADaAlWd1Ohes5qvI/dcWOvBqEgDQ6uGM=;
 b=ELmumTCYLDFnQVRBgajHucrBx7B5gKRzEZ2Uz3fQg8kmyMSvUdXowcEDhzYvJx33ft
 pOaLwiQ46PVzvSNyTTy0vzaSInCqgrX9GihqdxqqXCv8Iy78pN8sDx3MKo2TVAPI3QeJ
 oRh4rog8Wv7nLEsyiwrczH/7Gf4E/Naquw1feVcJQDBe3Riz4pZEWf89OBpjByB6r/UX
 fjdshPOgFMINp74kGDWKO5AyEdrSle0E3WKHE/BDKlV7EmPxxC2z8IHQOHPzZE3hPGH8
 flXXaMSDRQW901q3myqzzaKHSFMiywGpkF3uNHsFgqUe5qKLoRJ/s3AkUk72yOTNAS+O
 CYww==
X-Gm-Message-State: AOJu0YwfoYFbVMrX+rKDeRNCTSRUHwKWJmn7zIBlTQs53t5GeyD/+AvB
 OdrrORhkgBUD/jq45WTychszM7+QJlXyEM9vSu0hgEft8vj99Ufqixz+d/cr8+ayQgUt2WXNA9A
 qzw==
X-Google-Smtp-Source: AGHT+IEMXOMNPCV+CCqEinS/q5m8IEnqFcYlw2l6wdzJrxon/l89LK5GDmoOY/4Xg3d4rwSN2p5mYQ==
X-Received: by 2002:a05:6e02:188e:b0:3a0:91e7:67cc with SMTP id
 e9e14a558f8ab-3a345174631mr59866635ab.13.1727553678441; 
 Sat, 28 Sep 2024 13:01:18 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 28/30] README: Drop SoC-specific comment about SPL
Date: Sat, 28 Sep 2024 14:00:28 -0600
Message-Id: <20240928200030.194546-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

This should not be in the generic README file, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 README | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/README b/README
index 54ffbd0975b..5115d28fac1 100644
--- a/README
+++ b/README
@@ -213,15 +213,7 @@ board_init_r():
 		there.
 
 	SPL-specific notes:
-	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined and
-		CONFIG_SYS_FSL_HAS_CCI400
-
-		Defined For SoC that has cache coherent interconnect
-		CCN-400
-
-		CONFIG_SYS_FSL_HAS_CCN504
-
-		Defined for SoC that has cache coherent interconnect CCN-504
+	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
 
 The following options need to be configured:
 
-- 
2.34.1


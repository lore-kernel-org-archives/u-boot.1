Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B8FC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6915D876F9;
	Fri,  8 Dec 2023 23:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bLLQGgLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B074A876FF; Fri,  8 Dec 2023 23:31:36 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0AC876B1
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so30626645e9.3
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074689; x=1702679489;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4tcdqhu/YPrTZG+VE9jx9mo+yCI/RsZ7riQIoBINg8=;
 b=bLLQGgLvykprJMwukqDQlUmGM/odBcY/YZrBignAU6lw3UD1booCfC4cjoNYX4CJHx
 SZgO4W3AVnj9ebc/SMEdno4WuQiIm7MBSF2j5deGilH83/peSnFuu/JgzDNrkHVbv3Xt
 sb/BaOEySt2iOFOQ6VAZtg5mKzVEHkaUKSz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074689; x=1702679489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4tcdqhu/YPrTZG+VE9jx9mo+yCI/RsZ7riQIoBINg8=;
 b=JsffsFvBjxReVm5kLPcEn7I/Ze+2cSpPJm6pkurY+opo8iIwpSVq8gjTvV4vQIkBgz
 pTit8rYDWLBppfk96OmJcnC2oDjALKfKMByfpNGmVjoPY7Y7/iBDD4iU2n6NemlbTIXL
 wYgeEl1QzGgWfhXKt83OjLpwct26kWCiBGLFV5cSaBnkzQnFLToIK36YfbpYZtJxlZSf
 vnkPByWQXeQXBiS6AGDSw3GEZe6AucFhSEU54WtVDsHQm5dxXuIyVXLREBxJQPj0zqh3
 80feH308m9yjkTAWNCvKxmm132qJcxrnCEF5ZSdimMxPkpue8EZn1OQGszra5vk1F9Re
 OHgA==
X-Gm-Message-State: AOJu0YzWbtm+nV9XePgLjj2VJ5bLS6R2b8zOh30bLV1D0vd0i6RKbbL1
 m0R+RKRB1ZylgnCJnSJW67O4cZmLMFDbScDJ5tDZ2g==
X-Google-Smtp-Source: AGHT+IEJZ6wgrOndnotvUEPsIPUAZtAM5g7f3MVLSLyMTf09kCsiU49pFVmg3RRQS7FEX6pEdBkrnw==
X-Received: by 2002:a05:600c:294:b0:40b:5e21:bdcd with SMTP id
 20-20020a05600c029400b0040b5e21bdcdmr285157wmk.92.1702074688907; 
 Fri, 08 Dec 2023 14:31:28 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:28 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Roger Knecht <rknecht@pm.me>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v12 23/24] cmd: Set modern hush as default shell
Date: Fri,  8 Dec 2023 23:30:24 +0100
Message-Id: <20231208223025.55076-24-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8b49a97aca..c9d4375ebb 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -28,21 +28,17 @@ depends on HUSH_PARSER
 
 config HUSH_OLD_PARSER
 	bool "Use hush old parser"
-	default y
 	help
 	  This option enables the old flavor of hush based on hush Busybox from
 	  2005.
 
-	  It is actually the default U-Boot shell when decided to use hush as shell.
-
 config HUSH_MODERN_PARSER
 	bool "Use hush modern parser"
+	default y
 	help
 	  This option enables the new flavor of hush based on hush upstream
 	  Busybox.
 
-	  This parser is experimental and not well tested.
-
 config HUSH_SELECTABLE
 	bool
 	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
-- 
2.34.1


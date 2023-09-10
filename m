Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8245DEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 18:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FC486CEB;
	Sun, 10 Sep 2023 20:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Az6jTFaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7547B86CEB; Sun, 10 Sep 2023 20:25:11 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07FE86CF3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 20:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a9f87adfe1so2971831b6e.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694370307; x=1694975107;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMKD00v3SvGytGxeXJ+8xcW77YWBFMkm0BWwKHOWhe4=;
 b=Az6jTFaDMbmav8KjX7+jCbmn6wNiyuDRa+ZuEnokIZtFjBDIj0RABfFBVRfkIShzCv
 o8DBmzFAjL/Ye4Hb910QdC/aVXUx5PopIUQckLiQJ2zjpmFDpIhobjZRB3b2XGWveX6C
 nX4nWbCKKE89P9ndvReCNSqVglYHIqYz8ntyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694370307; x=1694975107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMKD00v3SvGytGxeXJ+8xcW77YWBFMkm0BWwKHOWhe4=;
 b=bXb5qkNQzEATL4eSO7wEXzStkxMqkBH8IwIw4dtBdHnM/Ra+bBghXZqiT7kBp8HIkT
 s7QZbZkyH3yZUK+IwIWaRPEhKvm+LsFbbX5BsFwrtJ4VvtiiFIvS8qTWWbacZfi4xuJB
 b8iRQb8ZbDHHfpo5ZHAWnGF+bDDOiwekBDeuOe/5XFN7kAvm13Fl4uoxr9FrRctAbsO3
 AYXYvstfcheoY5fP2+Zc474SfeAkxFF6AMhsZHwiQhoThJEQ6VFUYrChN6nrmNAUxJqb
 qBtQzhXcldvuFFfaGAce1BkcoEbZi650yX2kTQfMjAbEel6EiZ5SdXhKUD/xYbWw1Ctl
 WgPw==
X-Gm-Message-State: AOJu0YwMo+gdaelLS1VTr77FYUWE2pNWjchPFwG6u1+UhVzXsCdAygR6
 aM5VQ5CTZBC4WPXOZ3hkRmRxcA==
X-Google-Smtp-Source: AGHT+IFaUFWGRVvPgLoYI467zmT7YzJ6DEYHI9OwTXsLO44ZxzBTFyaCFvzFoLIVu7MzwkemSfrhsw==
X-Received: by 2002:a05:6870:5a3:b0:1d5:1a99:538f with SMTP id
 m35-20020a05687005a300b001d51a99538fmr10474658oap.15.1694370307417; 
 Sun, 10 Sep 2023 11:25:07 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a655c85000000b0055b61cd99a1sm3720593pgt.81.2023.09.10.11.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 11:25:07 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v3 4/4] rockchip: Add support to generate LZMA compressed
 U-boot binary
Date: Sun, 10 Sep 2023 23:54:48 +0530
Message-Id: <20230910182448.285542-5-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230725035101.281325-1-abbaraju.manojsai@amarulasolutions.com>
 <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
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

Add support for generating a LZMA-compressed U-boot binary with the
help of binman, if CONFIG_SPL_LZMA is selected.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v3:
 - None

Changes in v2:
 - New patch for v2

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8f248f941f..c8c928c7e5 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -58,6 +58,8 @@
 #endif
 #if defined(CONFIG_SPL_GZIP)
 					compression = "gzip";
+#elif defined(CONFIG_SPL_LZMA)
+					compression = "lzma";
 #else
 					compression = "none";
 #endif
@@ -66,6 +68,8 @@
 					u-boot-nodtb {
 #if defined(CONFIG_SPL_GZIP)
 					compress = "gzip";
+#elif defined(CONFIG_SPL_LZMA)
+					compress = "lzma";
 #endif
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-- 
2.25.1


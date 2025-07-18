Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609EBC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 01:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76988357D;
	Fri, 18 Jul 2025 03:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mrBZJFdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB02B835EA; Fri, 18 Jul 2025 03:15:41 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C54688354B
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 03:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-41c3addd37cso1180135b6e.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752801338; x=1753406138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=o2YRp9bpn8/iWgi8wGFMEGjNiLeaz+htdckzZ22ACgk=;
 b=mrBZJFdIB93JCp2UYZY4sO1y6zCNNOZVxti6x8huUcILUH9VtV5H0KwhiH3GwC9zbg
 UK0hua1kWTv38j2NtHayGlJjV+A5k9r6jzqMT2fSjLAR1jDENQP8LIwBbRl5ewGM8+7Q
 fH8yd3Cm2mAE9zoLYxTAMu652XGQ6Cn++1LBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752801338; x=1753406138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o2YRp9bpn8/iWgi8wGFMEGjNiLeaz+htdckzZ22ACgk=;
 b=OPn2k8cmMh4kBehA6h8jeC0quSvuM7rV2eRrTtwM+4vEqD+wBGOFOUVvNj0cQeIEMX
 xmjA6KffhHTqehLgZrOnWUfIEPyh5LCHCxXL+iVeT88B1oDWiCekv1TGPAXLvf9L5zbG
 bOL07nPQ7s0OCzVpTzEvla41F2hC7cu0bu/ucjtfTkuQfRD+Q9so5IjTINcdEyVYW/Ck
 GrEoLBsVTEPpTBVPJ9wsdnfZowau9m1symDlnIpfqjR9yacAUkRSkR5zKFtCPf72rZb1
 lxZ6Wsve+0ul39F/VNXkx1LU23MFGItcvGi8Q5FSrjnMATaVLAgj0hGArhgF8EmagNdq
 0BHg==
X-Gm-Message-State: AOJu0YxAJxf5GC7gemVPUfvq+W5aVgEEbDJ2Bw5gR9KmCZFTISnsfTbm
 WboJhRgYO3biJrotbrk8/THOGZYADELPxZuQ4Y+VC9LY5UoudQitOJ3Cwvcx8Dn82jMpGZT2rHB
 u8GYvlK8=
X-Gm-Gg: ASbGncvmwU6emKm1R4pHwmv/xjfqV+2mQKsz97awixW2kbmanG12BLW44ahCndvEdHr
 fLIOIsCLURl+MFeQLnT/uQuTNtAxieKqPMjeWKYWABQY5icRMTnwe0bq2tRweCtT6/cTLHfbTml
 HBDobgrO9Rz99BygtcvPe8l5gUE2TVtBnhEMC+Z32rRNx+lELfmuyG9wNaHYV+Y8Dqi7+Kq8mb/
 3J/YSIImLKsR95+qOXpLKJiUi5AqQalY4eGc3wFg+eeWGBrxDECwyKwjArMM9qezNQR0gzFGpsV
 svPX/bXlIkEvkBc32XhLMpxbnoBWCTk12DQdIv35cv9lD/Ui+OCltmrIf+9ylXoeEil0ESogSZ8
 0kIopKxKF5BR6nLeBYVXmXSB8+kZdquajoKpjn+bkYueLCGFCQPfBZIS7fZE=
X-Google-Smtp-Source: AGHT+IG7Rr153c8JkHaEL3atF+fGpXxZtR4RGN6+kDcIXgc4VOW2vcQBdeEYY8cdowqcmLYpwfRk5w==
X-Received: by 2002:a05:6808:148a:b0:41b:e029:bbb4 with SMTP id
 5614622812f47-41d038e6d93mr5888263b6e.15.1752801338485; 
 Thu, 17 Jul 2025 18:15:38 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-41fd10c22a3sm88481b6e.8.2025.07.17.18.15.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 18:15:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] net: Add <cpu_func.h> to some platforms
Date: Thu, 17 Jul 2025 19:15:37 -0600
Message-ID: <20250718011537.1333932-1-trini@konsulko.com>
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

The common portable header for CPU related functions such as cache
flushing and invalidation is <cpu_func.h> so add that to these drivers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/net/fsl_enetc.c | 1 +
 drivers/net/hifemac.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 97cccda45190..a4ba27904bcb 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -6,6 +6,7 @@
  */
 
 #include <clk.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdt_support.h>
diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index 90cc247b3b6c..62182f922f8c 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -9,6 +9,7 @@
 
 #include <dm.h>
 #include <clk.h>
+#include <cpu_func.h>
 #include <miiphy.h>
 #include <net.h>
 #include <reset.h>
-- 
2.43.0


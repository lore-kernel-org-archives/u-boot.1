Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27E7C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 13:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0029E84728;
	Fri,  8 Aug 2025 15:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IUaYO9Sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D1CA84701; Fri,  8 Aug 2025 14:31:38 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939BD846F0
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boewingloh.linux@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-af66d49daffso364674666b.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754656296; x=1755261096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u4dqgGxrpX9Mua/Oey2bL4sRRIE3lCwhnK90Ja4bLRw=;
 b=IUaYO9Sxg/pXxZG7qNp62BihNbP2PGcnSZaun0N+fJzWkJM9e2SmRzvWzbc3DaKlmC
 U4XU2YOGZdz2HRYZ3YQzQOHbirOSU2jfA3LbAaOoiBIAFAqwjv7J/ZigNBYDC7WcUa2y
 tXOIdWj5EvWOonO8f0TJP8N5u0h/rNUcttzppYffP7EWVjJ3nVEswJ5Ku99nRTNDl2bF
 A+m/cyUVCtMgadC3yE0ksuHsEI0cCvJNC8E8yqHQ16y31tV0aOm2dShgZ4D4o7bk0BSy
 m3Fl8XIBLnr85pHp1skhngwyvykEEwfG2TZPwiirG7jenaamYY5yYtAcASnKFek8LEMY
 gxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754656296; x=1755261096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4dqgGxrpX9Mua/Oey2bL4sRRIE3lCwhnK90Ja4bLRw=;
 b=epBLfglvhAI6jw9ULpOofRLDRlOpZsXiOp336Q6qCPDqRkKuBrsIVbDF9ejWNI+kpy
 o3kPy6cmV0aYYkGJObGyDJqye1lN/E6bNBtB+mzgNFucA6Thyw4ixYApKAXAeP/TLX7G
 TuWaqTHGFjJbqGjUCRqMZMaP3zQA/7AEFm8vwiydx1QmR18R5IlGQdQs1p8jpBROK44h
 m2RLLaj9Yl/MOJMIb5uS3ad9fSidDspHGinAXU5PrbZPaDTfNYL9cqKTmONmmiTPftmc
 ve10Ly12OnoPglpQ4iURfbiXYjT3yxJbMaY0IXiVO+xgW4AS9mKtPjkfwD+1dk9C6ujR
 zjIA==
X-Gm-Message-State: AOJu0YxFP+C6PeeEPaFJmBhkcUlEyYEMKrgkKqCe5r/B8CO6d5Gn29TO
 /3oXIN/q9bSn8Uot8XrMYsWdQ9bhA+9AboGlMcBwqlpV706wbcbgt6pzzC//I7fRs54=
X-Gm-Gg: ASbGncsT5Il9RtGMnMNIfLxNGf6Wvzk/IIG2aWXigG5Uk5aqcwyJPu1TWZJJ8iqMm/5
 X+tSbFbLQA6neh1s0iIDAc/wHpvCvovvd0JUOhGxqda6+KHnUzRlH6poqHbaIk/nto9EE4RGHQM
 vO+BKjfVcz0LbGSqrWNY8CI25otIj4YNP6ucsQzh+BZPzoC8rkl0UM3exiwFMjwR2KgKGAnAj3d
 1n57S/fquOdxn+unnKj584kXQXHn01YREUFU0wS/423W6GLGzRNFJKIgkS4RonQUGPljpIvUyJz
 HCplwosBgtfqh8LDoMbXK0MkuBRo/O/WZ5K1dYyvc3D+4EfLT6lIwvmHZcAFPCTbVIgNVMyWTGv
 S6WKvDFWR/cLo6mlykHIrbWLdmTFKdjyoL1tHw5VTxjXDPr6bNvEcXwxv1FWtYA==
X-Google-Smtp-Source: AGHT+IFA8XbRmIrU1zOGucIMkbePuQ4LGmlZx7CxWEnxY5K2RkJpHkFX+jmTwNoqf8GCjL3QjC0wkQ==
X-Received: by 2002:a17:907:70a:b0:af9:a5f8:2f0c with SMTP id
 a640c23a62f3a-af9c64f4460mr228418866b.28.1754656295692; 
 Fri, 08 Aug 2025 05:31:35 -0700 (PDT)
Received: from FrankBo-NB04.beckhoff.com (p4fe4d101.dip0.t-ipconnect.de.
 [79.228.209.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a219ecfsm1484667166b.94.2025.08.08.05.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 05:31:35 -0700 (PDT)
From: boewingloh.linux@gmail.com
X-Google-Original-From: f.boewingloh@beckhoff.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Frank=20B=C3=B6wingloh?= <f.boewingloh@beckhoff.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 1/1] soc: xilinx: zynqmp: Fix zu1cg device detection
Date: Fri,  8 Aug 2025 14:31:34 +0200
Message-ID: <20250808123134.636-1-f.boewingloh@beckhoff.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Aug 2025 15:05:08 +0200
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

From: Frank Böwingloh <f.boewingloh@beckhoff.com>

Currently u-boot displayed a zu1cg soc as "Chip:  zu1eg".
A value of 0468_8093h in the IDCODE (CSU) Register defines a ZU1 soc
not only for the EG family but also for the CG family as described
in the Xilinx Zynq UltraScale+ UG1085 documentation in Table 1-2.

Signed-off-by: Frank Böwingloh <f.boewingloh@beckhoff.com>
Cc:  Michal Simek <michal.simek@amd.com>
---
 drivers/soc/soc_xilinx_zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index 0c45c781fef..4b69ff3de13 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -63,7 +63,7 @@ static const struct zynqmp_device zynqmp_devices[] = {
 	{
 		.id = 0x04688093,
 		.device = 1,
-		.variants = ZYNQMP_VARIANT_EG,
+		.variants = ZYNQMP_VARIANT_EG | ZYNQMP_VARIANT_CG,
 	},
 	{
 		.id = 0x04689093,
-- 
2.47.2


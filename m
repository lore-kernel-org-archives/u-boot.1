Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CDDC83F2D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90A9C83013;
	Tue, 15 Jul 2025 16:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h1DQxs6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF3E82F8E; Tue, 15 Jul 2025 15:03:54 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049D182BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 15:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso6900750b3a.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 06:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752584630; x=1753189430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBrjjrj2OpSBnmyqye3bRpHbY/WN2jQr8x2Qh7e5hIA=;
 b=h1DQxs6KZI1fot0oszcNbstpuOjJevfznCzds6EwYm8qy8UtL2GFoofW0dvsWI86A9
 I48yfNn/Xt0pGaMOIM5jyCUCfGHndILfqT1aR9FKLmAPP47lSps3lcTyr0J9Wr7noOzs
 sKyW4yuLNeQ0csIxH0inygM+lE/YnVi/2QDTSM70ZDHoJWgen6RQQ/QdtyB9ad916Hai
 4CNKEPyL93ZEBWzlXjZQLOtHbwL6Naz2B4U7Y4kzEp43elXVlqUPDI/P03gqosJo6gWz
 mi1mbhYlHvjA5LvakGWlFA7J+pEyQku1xbHEogdtv9MXwc5rrXbhAZFAxHIpB68AdUIy
 BiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752584630; x=1753189430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBrjjrj2OpSBnmyqye3bRpHbY/WN2jQr8x2Qh7e5hIA=;
 b=sQoKrGyUOYaO5hbLGYbjBwTTfMKDVCIBx+uPLHMwtD7mFP8hwbyRIhDhlJquPqSmO5
 Bvpd5SVu1qtA92CZtkR1H2CbEb6a3QdeDKriRNMH7hR0w3MBIKl5s6UWCFZyNR6gIwWj
 T9GkgoEr0yFCISLPMWptF72Y2dIKgtGiTykgVh3Wx//0m2Nxuy34cRaIebpDcRbjF+iq
 osu1E3s+UA10dVW5qTgbNTIEfJ3RwjPSmFyw/zbXezmPbusSFPXu9ZvqDsgnd6p+TzXX
 rxKhKUNb0wrjWpuyaYsDSa0hZkvgEvkTYDORDF5poejk4pewm0N093/SBCnfX7sAOob1
 55gg==
X-Gm-Message-State: AOJu0YyFRFwG5zzwZm6vfc4/7siA9V0cpd8SVOngrQhIdkGn20cHo4l7
 UFOeouqzQB/K2yJkXTpwO6ijP7TbsoCAFZDzkoJuMZ8ImjiBb/0+AqTtspvFww==
X-Gm-Gg: ASbGncvJFCsshx/fyZ5cnF1OzOq2rpzD1x6Y9vsTV7bggt3DH4ggX5CXgdkWf9W2hnD
 6UlZ8zMYmAgYTbIvBPHtwf/MGwXa6heRfkm3N3iJD61QZ3YqB85XsSTCT6bal8QdGDmrioUGrdV
 D/avZA2rcwqdPR5PG+CaOHVmkBLumd6PYTR58ukjsrDQdpLprG4XiKrLXlsBbucpUKPE+nJpnX3
 gCwnqGbwifldCUR9Z60sWsmlQVSnBHhlqervB0s0UvE4dNZ0Lxh3MUeKH4s2YyD4kGoWonryzZl
 yu5Gf6/NEXXgUMjYMET9AbLS4wvj420+7y23ucTcreG1UgpgD1znYzHiTwfWQPJiGmZDSoIIaAK
 1/6px1tC1wQSCiQXNZlZFHUat/APpS343rltnIZDtXsEJs/E7nkjqma6xZyjRhq1BnXeHfp8=
X-Google-Smtp-Source: AGHT+IH8uSjdyTJwEyiE9bOwi7bYeGTHVJZ9sskk2As2nflO2ywY4i8Lz8XssjDMr14aHxqDOGl5zQ==
X-Received: by 2002:a05:6a00:b49:b0:742:b3a6:db16 with SMTP id
 d2e1a72fcca58-74ee2955a4emr24803220b3a.20.1752584630055; 
 Tue, 15 Jul 2025 06:03:50 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5fc9sm12392356b3a.2.2025.07.15.06.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 06:03:49 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jan.kiszka@siemens.com, baocheng.su@siemens.com,
 sjg@chromium.org, ravi@prevas.dk, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/3] arm: k3-am65-iot2050: Fix invalid default
 configuration reference
Date: Tue, 15 Jul 2025 13:03:05 +0000
Message-ID: <20250715130317.3886-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715130317.3886-1-aristo.chen@canonical.com>
References: <20250715130317.3886-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 16:47:06 +0200
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

mkimage introduced a validation step to ensure that the 'default'
property under the /configurations node in a FIT image refers to a
valid subnode. This exposed an issue in the
k3-am65-iot2050-boot-image.dtsi, where the 'default' property was set to
"ti/k3-am6528-iot2050-basic" and "ti/k3-am6528-iot2050-basic-pg2", which
do not correspond to actual configuration node names.

This patch updates both /configurations nodes to reference the correct
subnode.

Without this fix, mkimage will fail with an error:
"ERROR: Default configuration 'ti/k3-am6528-iot2050-basic' not found
under /configurations"

An upcoming commit will validate the if the default configuration exists

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index f49d6f262f2..b3d64485249 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -208,7 +208,7 @@
 			fit,fdt-list-val = "ti/k3-am6528-iot2050-basic", "ti/k3-am6548-iot2050-advanced";
 
 			configurations {
-				default = "ti/k3-am6528-iot2050-basic";
+				default = "config-1";
 				@config-SEQ {
 					loadables =
 #ifdef CONFIG_WDT_K3_RTI_FW_FILE
@@ -265,7 +265,7 @@
 			};
 
 			configurations {
-				default = "ti/k3-am6528-iot2050-basic-pg2";
+				default = "config-1";
 				@config-SEQ {
 					loadables =
 #ifdef CONFIG_WDT_K3_RTI_FW_FILE
-- 
2.43.0


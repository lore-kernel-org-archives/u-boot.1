Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB5DEE14A9
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC18086177;
	Thu,  7 Sep 2023 03:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a7+WlG6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482A286682; Thu,  7 Sep 2023 03:47:49 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6687B8608A
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1d535fe4798so94174fac.1
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694051265; x=1694656065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a8G1suoncOXyX39ToEIenB0cazSPm50sKD7opCDEIRQ=;
 b=a7+WlG6ymeRNFNpv/FnoqKnvB/kmCyolMeuFioLtweScKHX5NXZpyD8MyQAAnqCqsW
 mkCy4rFDCuchKup0hjoP3AL6wy2CggdRy7i1gJ1IQprU2XkiuLLrv4KEbt+M8gyPLiYA
 AQRYvweDORfhDXNrNh/W39R8hfJRtxxmn2ZWAQAl6+5d7gHGtE/vo+iCrEuGzyNUD+QT
 yAysGCu7GLbmOnkKQ/zSgKC5DhYl1n8PImxv+/Ptm+i98gas8BFcQlH5vice2vbNZB5K
 m86AHDjCwLVFFWQvtXjwXh053/hGUTuOXZflVcQv3wHHjkBZLwfBzhGf8c96XsY+dpbD
 UtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051265; x=1694656065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8G1suoncOXyX39ToEIenB0cazSPm50sKD7opCDEIRQ=;
 b=Y8QfhmKWuCqP7K6ls16wnQuqwTqkluIBPPgwOZiDo2C3wcWZQAwzdx0Izbn8MPkeyi
 AS16IS9tjD+RJM5pWOqJLN3M/TRKp3ucN8IxVIUUZDLz+kp48jJQ30eaRRcRfa0UmjN6
 resI43c3x5Mfuf4a8XQSNQKLfP/FAI8DJvj1KA5OtkP1fctGEeWktxpjBqWo9jPAHyOR
 RZ01j8h+OEoWg0XDxMOde0SqBMYoZGtMfdo9SBCsXh8ko2WSK8bvD6oh3Z8kKwQVgPqk
 VAUVZwoaPi8e8+JPr3CJBMLCXUQ6PO0LsbVFQauR0AXYHTRupbZL7+1IBS3Z45j80365
 Ojsg==
X-Gm-Message-State: AOJu0YxTuUgJxUJqg5TxccJ31bB0XgzZejEn42VEqxx+yxifUHsWDIya
 /z7w0anpuKDfSkFKMvZSxKI=
X-Google-Smtp-Source: AGHT+IEyyGYPztrO/8hyxLeDM/nrLIfpxybL63EUFuNnGNVlvlupv8ZSyiJdvWMPuxHaVXLpVVghTA==
X-Received: by 2002:a05:6830:c85:b0:6b9:b987:1337 with SMTP id
 bn5-20020a0568300c8500b006b9b9871337mr15959145otb.1.1694051264883; 
 Wed, 06 Sep 2023 18:47:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:9526:31f7:eabd:d5f9])
 by smtp.gmail.com with ESMTPSA id
 i36-20020a056830452400b006bf0f95f702sm6951989otv.64.2023.09.06.18.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:47:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Eduard Strehlau <eduard@lionizers.com>, Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] imx: hab: Allow hab_auth_img_or_fail to be called without
 ivt_offset
Date: Wed,  6 Sep 2023 22:47:25 -0300
Message-Id: <20230907014727.371324-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Eduard Strehlau <eduard@lionizers.com>

Since commit ea91031b2232 ("imx: hab: extend hab_auth_img to calculate
ivt_offset"), it is possible to call the hab_auth_img command without the 
last ivt_offset argument.

Currently, calling hab_auth_img_or_fail without the last
ivt_offset parameter causes a failure and the command usage text is shown.

Fix this problem by adjusting the argc logic to allow
calling hab_auth_img_or_fail with only the address and size parameters.

This way, both hab_auth_img and hab_auth_img_or_fail have the same
behavior with respect to the allowed number of command parameters.
 
Signed-off-by: Eduard Strehlau <eduard@lionizers.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/hab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 439cdaf07a7c..6cacca069d9f 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -659,7 +659,7 @@ static int do_authenticate_image_or_failover(struct cmd_tbl *cmdtp, int flag,
 {
 	int ret = CMD_RET_FAILURE;
 
-	if (argc != 4) {
+	if (argc < 3) {
 		ret = CMD_RET_USAGE;
 		goto error;
 	}
-- 
2.34.1



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F1DCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5747838A5;
	Fri,  3 Oct 2025 22:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VTyQUfxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3727838E3; Fri,  3 Oct 2025 22:39:25 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BE7838A0
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-42e7b22e007so6242185ab.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523962; x=1760128762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=m/A8+TvAzJPp3GxcH7VuNp6SCUNPgSbSxzLoOFmFfLI=;
 b=VTyQUfxcNKky3faeuXMLUmXdOx1bdUaDfDYCxmY7M7ANiYKMz0i9L8FDB18nuvtE5q
 PYk6q83ggFen+JHq90iiQvaDwB9nJno2eZsru4BLmnsEAlRalHoMA2UWheDWzZYrJ96P
 MdJFi3XY/JE1HcVKBXe0ytBtTQ9ZGhXel+jB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523962; x=1760128762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m/A8+TvAzJPp3GxcH7VuNp6SCUNPgSbSxzLoOFmFfLI=;
 b=a2D+gp3K+zP9AM7hEWPwPS+Nm/7ycsOKcFlKOq03XprKXIIO5U1kYOPQO2SUChXB+1
 tLgsGWeFM28UKnUq4NKXsMDJmQmVrCaL/r3W/e9dlrE7+EmyZRl9bVHZJtLgFEtZiEak
 xSkgvtuH9F2dT/gcOa3t6XD88od1iYL08r1GwgTLUOxQSvgkL/dPH7ksN3iRxh3PcKDA
 QFQ4V/RcyIwXfaqF1JlVvE6ix7fiz7G4WxQBMkJ5ZbWmgEdPYxxfWp5YzlnYaa/dAMcz
 ks0xTNaepIyaxq9KbZc/LhNTxZaj4Vi1+IbP5XrCLriBoRiFX8wpwfxC9CMR2NYGf2Fp
 5pJQ==
X-Gm-Message-State: AOJu0YwRH+rzIC23ZGQ4xO6eVh6Tc+QnRntHRmekAzUN62aNs2nqR7Xg
 dtxalxvalWC4ZT+eBaMYXWtTVdCrGTB1+IFcaWF8Ow/SId7Rf1YmotuLdinyV2sSXHQSRN4vK+x
 ofmyzqs4=
X-Gm-Gg: ASbGnct13uzEufRYsXC2KcKZw4EFGVlFOjXgvP1sZQvXY1uJXKy3LEdViWG7Xr4fXVm
 Ln0rTG9I4r+hbGwix3KEzK65vUUbnvZVtcpjT/ye47+NKVqHdzS6m0oeAGvWDiahYWfdIu3UxWP
 bdT+/2U7515z0rCyxMU8a2Gc2sjPg8I1AwDAR8E/cQyEC1RPOnxxZ/Uwi1ZSl5Mx4Od64BR7IUE
 JOedixflIu87d1gd5NSs0G8sic/Nj1SarzpbYystvUd6Uv8d0apGFYewVGC7UMZkj8eMrEbQ1aM
 42NDvZSdBxtWeK9X+ZGid0LDEJU80rtDQSLbx0hD8DCFsYN6k1tkHAEFc6HAFysUCTwzvCT4/z1
 mH4PeUmV5/YoaQpxr5xN0q487xw0I844Lrtmau2HJ2tnzwJoH8Opka8EeQs2Q2EhAcyviwm+wfo
 VBp7IdRC8dmm+UnVkvC1C0Lts=
X-Google-Smtp-Source: AGHT+IGHr7oj4BnQ8Ez+CvObguVQxGMdtea0FwF4ASSOpqLjFuhOFWPoKVGQ9FyxcYLnRoi576HJgw==
X-Received: by 2002:a05:6e02:1546:b0:40d:e7d8:63fa with SMTP id
 e9e14a558f8ab-42e7adca144mr52662685ab.26.1759523961921; 
 Fri, 03 Oct 2025 13:39:21 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b294ddfsm23908255ab.33.2025.10.03.13.39.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:39:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spl: FIT: Make SPL_LOAD_FIT_FULL depend on SPL_LOAD_FIT
Date: Fri,  3 Oct 2025 14:39:20 -0600
Message-ID: <20251003203920.1029967-1-trini@konsulko.com>
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

Today, only a few platforms enable SPL_LOAD_FIT_FULL, and all enable
SPL_LOAD_FIT. As can be seen in usage, the FULL symbol is a superset of
the first symbol, not an alternative. Update Kconfig entries based on
this and simplify the only code which checks for either being set.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig       | 4 ++--
 common/spl/Kconfig | 2 +-
 include/test/spl.h | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f21a67b2d3ee..8de99981b306 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -204,7 +204,7 @@ config SPL_FIT_FULL_CHECK
 config SPL_FIT_SIGNATURE
 	bool "Enable signature verification of FIT firmware within SPL"
 	depends on SPL_DM
-	depends on SPL_LOAD_FIT || SPL_LOAD_FIT_FULL
+	depends on SPL_LOAD_FIT
 	select FIT_SIGNATURE
 	select SPL_FIT
 	select SPL_CRYPTO
@@ -282,7 +282,7 @@ config SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
 
 config SPL_LOAD_FIT_FULL
 	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
-	select SPL_FIT
+	depends on SPL_LOAD_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
 	  of the build. This contains U-Boot along with information as to
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 63f6f8d962fa..458dce01700a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1574,7 +1574,7 @@ config SPL_AM33XX_ENABLE_RTC32K_OSC
 config SPL_OPTEE_IMAGE
 	bool "Support OP-TEE Trusted OS image in SPL"
 	depends on ARM
-	depends on SPL_LOAD_FIT || SPL_LOAD_FIT_FULL
+	depends on SPL_LOAD_FIT
 	help
 	  OP-TEE is an open source Trusted OS which is loaded by SPL.
 	  More detail at: https://github.com/OP-TEE/optee_os
diff --git a/include/test/spl.h b/include/test/spl.h
index 5fd28d927064..c5349b06e290 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -133,8 +133,7 @@ static inline bool image_supported(enum spl_test_image type)
 		return IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER);
 	case FIT_INTERNAL:
 	case FIT_EXTERNAL:
-		return IS_ENABLED(CONFIG_SPL_LOAD_FIT) ||
-		       IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL);
+		return IS_ENABLED(CONFIG_SPL_LOAD_FIT);
 	}
 
 	return false;
-- 
2.43.0


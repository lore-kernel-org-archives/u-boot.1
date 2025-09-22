Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF9BCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 13:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9040E83211;
	Mon, 22 Sep 2025 15:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="a/+0hCXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AED58341C; Mon, 22 Sep 2025 15:32:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7127682CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 15:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-62f4273a404so9867495a12.0
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1758547954; x=1759152754; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/YPq8lHCxFQCg2eEVu91BP+LCMLjlXYw4XGynZJFxo=;
 b=a/+0hCXF30b8CIK3rwzO8wd8bO8EZnhTmHpk8Qc/pa4HJAhnV1jl9kB0Rx0CGDOs5L
 0ToWLvb4peOUUt9peIauvCe/8/9DWnvpe8YEXEl0fDOsfIYwIzdhs1jO1l9NCAfyPZCQ
 1dOAMR7pRvgHzoACRTpaHpIDdWhddMXL3gs4ZMm1Jy+oQ2LQQ7STNgmFO3Inert9KYl1
 oMDgzE+HR5TewpLrIJw9e97qQlPhMamf2eiGFDo74sM8UJx8Jj7zfgGJv66VaGMwhv4f
 8cfH2Umt6dnDLsT55tF0vcZgPRVa+fA+KHBPr+0azusZLafTpp9jdPLXBGOa3t+MCrvC
 KWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758547954; x=1759152754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/YPq8lHCxFQCg2eEVu91BP+LCMLjlXYw4XGynZJFxo=;
 b=mKd/3N+qcpHmVtA7mCryPQch0ghu8KN1mn5MoKxUFOeYZlMnBnOlNDfpW0/yFo82ZN
 HFvfX41S5A8sOqwGhi/pcbffbP1CYz50DnaGWTKIw5M4lIl17bDOd4/YOGlTBKSa943H
 6BZV8xUYh8nmjR1nTs1CizPAud5U0FyOH4wTuHQQjz3fzlxhM3Od2DvVt47xC+kj0GAX
 gzRHpvs+85/n6WHvyCg8hQmonPUlEpQE2rsRCao4GTkvyZDfv8xzDqojhDjeacF9qppl
 Prz6lLTMIDIK/33O6iOK9qC2jOR1xggWktxHeFosNRsq8CsEhEFivXFxVKZ9uMVE3w4K
 kWPg==
X-Gm-Message-State: AOJu0YzNXh1LpYVU6MeotrD7OiqrGuTJo04CWpM0XrfHmU7a4QTQEz4W
 lSxb5+ThY8ao48n+lamVC5VkkhGHYjPKFY9vt8EBtYfeBoR+lCKfsdeSna9Wlw==
X-Gm-Gg: ASbGncsHCLVvoIAKsONGbxpSLoRBbDybZJiIKTt3rrStMIOs09ohv3EJFlnazkOT79/
 4mSqg4AyNYvTGCjj2yOOfeXGpMC6KZgea6BAMGAQ3eml1TSAHJcm6L0BIMd6gVrqHTVew/ENKdw
 ISue8aCmSLokOQmBQ9Sk6VBywpWqbqG36disGI+9fqocUSL9DU7UnGV7+h3CWrtv7m6lU5Fk3bl
 HJFRc+revZug6KWwiVcXcsJmoYr80zySmxd8qWN7bLhRd7OOmrhMKZtCjQJJ12Lv+bB26gcI4u2
 UWtTNCxeOW+NDrs4vjhBwBXpvCpcL7kXAi+HM/Dr9dvEzdQHUqMsFRKUajZBKLgR76DKIvg0dJt
 bIuRW9mMjaCWgwB5vXsev5Uttqn/t6SHjQuUgYLJSSaRVJhCsS3WL1+SAZT7wPT7ArwEU91pmxE
 GW+cGLHYdzENYk4w==
X-Google-Smtp-Source: AGHT+IHK+zVUv/H+w32g9h//2G7JqN7Xoe8UcrhzsyDjk2vuJQ1Z23COd/OMaq2huY3ANnxD2nD8yw==
X-Received: by 2002:a17:907:2d0d:b0:b2e:f8df:f5c9 with SMTP id
 a640c23a62f3a-b2ef8e00bcfmr62710966b.6.1758547954070; 
 Mon, 22 Sep 2025 06:32:34 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b29e6597caesm464830366b.73.2025.09.22.06.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:32:33 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] net: fix RMII help text
Date: Mon, 22 Sep 2025 15:32:29 +0200
Message-Id: <20250922133229.4180942-1-yegorslists@googlemail.com>
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Replace MII with RMII as it is a Reduced Media-Independent Interface.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d1cb69f85ad..7ae28c4e0d5 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -662,7 +662,7 @@ config MII
 config RMII
 	bool "Enable RMII"
 	help
-	  Enable support of the Reduced Media-Independent Interface (MII)
+	  Enable support of the Reduced Media-Independent Interface (RMII)
 
 config PCNET
 	bool "AMD PCnet series Ethernet controller driver"
-- 
2.34.1


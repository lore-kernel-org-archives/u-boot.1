Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDC7CD5BC0
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 13:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5583C86ACA;
	Tue, 19 Sep 2023 15:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bpnBratJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5AE86B64; Tue, 19 Sep 2023 15:39:23 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E9586A26
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 15:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5733d11894dso921624eaf.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695130760; x=1695735560; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hXRXGCB12BsVmBmYy3hUKs8fT8NIQL7751FWqtcE/w=;
 b=bpnBratJ9TzqvCNPs/ZdlAdOtMpowETKJFFAyfDuMkKe/e2xka+zLuzMgcWUv52J78
 /XnUQG4dOS1A4YY2ICsRTd+y3m+p8GUEXUPi7zUpb/p+YDcCSvslmTwUKraf3RpkeyKH
 XAHaodEX/ZdPj1y5IgGRWbk9dJoaAl+I99gLUhfCkFBll/Q41DizeLUyK+NhMZWyif/6
 YZwaiq4aB22bWl6Qhcj6ZLsYxF99T1+3Vt+snSa3Y7s6/G2hf5QsA/2+XKM5fAPNikuG
 KF0intGLBUa8WHFg3Q6IwufQeM8otrV5WnfEHKvGSD56W6hqWwHqGiWa99Ay6Hej8Q/5
 fcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695130760; x=1695735560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hXRXGCB12BsVmBmYy3hUKs8fT8NIQL7751FWqtcE/w=;
 b=AEG3RfzVzpeCEONmQS3ekL6gJ3DFSIOQ8FnbLRqVFSzFdhisIeS3sgzjht8JJyy40K
 z4KSP5PMXmzTOEuqtOGsSt+hRK8lByfxyMqwI3cYtEF8oc2ZPfMZrtK8UrjvuBHWNG5k
 FRgVKY/nHSnp+rgqlDm8l0HFLOK+To6clPzIL/SeAqsdWE63sGtPD7t4pIW63ukoWDVv
 sKhQq6jxaCnbYCNydduVwRJiDKYYTNlsfOYGzf6h5jKGmg8PFHL5jKMpjpe0NTI8w1QL
 e4sMc9GYw/dVibBOzChfh4WDJCpoTUuzQOxRYzGNieIyuJEmGiBFHa+PCmh+j/3w/zSC
 t6aQ==
X-Gm-Message-State: AOJu0YyMJmAX/wFiP0dW/wRgPBzB/jQCp+zeiSmx9G0fmlv9HDzg/Xuy
 ppIOcqs5tb4tYwB3Z1X5VYfCHaZ7cdk=
X-Google-Smtp-Source: AGHT+IF53q33dDTzgjQrPJn3B88eYP2BWIG9omcIcDWDZ79xUXn0vRNxF7kUXJa+b2rvfZbns+MfAw==
X-Received: by 2002:a05:6820:2081:b0:573:3a3b:594b with SMTP id
 bz1-20020a056820208100b005733a3b594bmr13888214oob.1.1695130760236; 
 Tue, 19 Sep 2023 06:39:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:60:e185:815a:b48f])
 by smtp.gmail.com with ESMTPSA id
 p63-20020a4a4842000000b0056d361ca33fsm5632698ooa.16.2023.09.19.06.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 06:39:19 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: otavio@ossystems.com.br, u-boot@lists.denx.de, trini@konsulko.com,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] pico-imx7d: Remove Vanessa from MAINTAINERS
Date: Tue, 19 Sep 2023 10:39:11 -0300
Message-Id: <20230919133911.3416072-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Vanessa's NXP e-mail is no longer active.

Contacted her offline and she told me that she does not have
access to the board anymore and it is OK to remove her
from MAINTAINERS.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/technexion/pico-imx7d/MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/technexion/pico-imx7d/MAINTAINERS b/board/technexion/pico-imx7d/MAINTAINERS
index 325e1735c39a..5dccac4d55b4 100644
--- a/board/technexion/pico-imx7d/MAINTAINERS
+++ b/board/technexion/pico-imx7d/MAINTAINERS
@@ -1,5 +1,4 @@
 TechNexion PICO-IMX7D board
-M:	Vanessa Maegima <vanessa.maegima@nxp.com>
 M:	Otavio Salvador <otavio@ossystems.com.br>
 S:	Maintained
 F:	board/technexion/pico-imx7d/
-- 
2.34.1


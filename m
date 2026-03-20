Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331911099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EE78419D;
	Fri, 20 Mar 2026 21:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EwzDL8mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E00383FFF; Fri, 20 Mar 2026 21:54:00 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F7F484082
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d77b179b52so1792761a34.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040036; x=1774644836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zfZpDws/vbJJwX1xHV6nv+XobHegGMm95rrZTHZfF/4=;
 b=EwzDL8mzgoNcnt9LNp3976zLmq/9qYTTicHSaEDD+HK42H1VECXAjn3SbI07SBF5++
 zK8/BC39ZBhOSF2KpkDgUDtyU6fpULsCc9et2xelMZopY3T2trFaBX93kuzeyW+0I3I7
 pskB0wx7XH3Nq2TBhLNufDjFV5g6i4WT53798=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040036; x=1774644836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfZpDws/vbJJwX1xHV6nv+XobHegGMm95rrZTHZfF/4=;
 b=SJdIpmr8oaOBt/dXrFCbVROJ4zs3ETN+1hPWmq3jcAUwUOCIQfrrlT3ELXYRIJYQzo
 l2CU+E/pRWeqHLvhFXGpVhynT8ssu8enVN+tbUXjvvluCA+A3G/Nehxja7Kof1r9kdu9
 ITD9GgJaa0M6W5QzK3M0nQgw56N+eDzQzx6+IfIGTv/6IxoOLvM3QuQ1W7XlK2xctn/4
 sb7g5suoYKr95gLFsSJl46t0CBoRtiwn1A7KZ+AT2V8LHAlO6ZkkHlHRGiFk5r5oEfw0
 Vr2tEoXC/Vbkr5hyI2068CMvnfk/ju2akEwncogJCS6zxTdOqv02/CRqm86GDAE2aNU/
 TGRA==
X-Gm-Message-State: AOJu0Yz3wA6nE/jJhBL9N2m4iDq1Rfpqd3Y9mZOkThAJ0xBsW5ZrSCUB
 Cei/DZjw75Cy3VIuYxcgs84hHBu5lRdrZ1R8naGIuAD9IifvNxdtD7XttKHdh/7UbAzGNLe/JQg
 QrJVCJTk=
X-Gm-Gg: ATEYQzzqKS9UGrLMIBJ9HgK7Be5Jd/+gSXSfHIVCB42pWiFvO/GrIZCLOQoRP+3P49Q
 sm3IDHrWAdhVgjtPFvvZztec5odo1yHJaeZAGoXeOsshji+A+0YqB3L/0OFBK0j0TzdfL3HiMaM
 udX/TPIoOkbjXLhZDCgIAXSDceZT6USBaKZ/I+j5/cUHHdFhl04BOTQqkwdDP2HcP7+Wtka/j5d
 YuF1VcIg9ReOLnAuFfqZa/d+tQWxorZSQ9tjXPAc3EiL7zcy3eUefEGLrXPNe6MHQNqATVOTqv9
 dLQ5vkoSgpYaNBeqicisMWiHwbQ40SeGSwXsR668HFNd8VOFE0jKveftp4p5+MkTo22Uyczm3eY
 wbUCbJO+l/OmbJQG/oXNvBqk/W9srP3tc7IgJufWL3PW283woNUgmmZrPX2yoOfDdMOxxH11jY8
 CLY9+QHeeIt1zwXlfcUmDYoyZBSdomxNw8Ort+jA0ZLkC35x0dqlNbhCcPRl9HbvJxwkXAXCf1e
 Tx6Epqx+fQyHYQSXa2jz55da3yv6304UlKKKbRXZDV5/mWrz0o=
X-Received: by 2002:a05:6830:67c7:b0:7d7:4639:43ee with SMTP id
 46e09a7af769-7d7eae4213bmr2825566a34.3.1774040036020; 
 Fri, 20 Mar 2026 13:53:56 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadcb757sm3092694a34.15.2026.03.20.13.53.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] video: Correct dependencies of LOGICORE_DP_TX
Date: Fri, 20 Mar 2026 14:53:54 -0600
Message-ID: <20260320205354.3789141-1-trini@konsulko.com>
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

In order to build LOGICORE_DP_TX we must also have enabled AXI, so add
that as a dependency as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..3b61bb50215a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -857,7 +857,7 @@ source "drivers/video/exynos/Kconfig"
 
 config LOGICORE_DP_TX
 	bool "Enable Logicore DP TX driver"
-	depends on DISPLAY
+	depends on DISPLAY && AXI
 	help
 	  Enable the driver for the transmitter part of the Xilinx LogiCORE
 	  DisplayPort, a IP core for Xilinx FPGAs that implements a DisplayPort
-- 
2.43.0


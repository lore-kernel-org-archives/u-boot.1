Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59904C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCF182139;
	Thu,  3 Apr 2025 19:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i3MWF1vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9327482140; Thu,  3 Apr 2025 19:54:29 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF22882006
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so1056093b3a.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743702864; x=1744307664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d4tfF39Df0uBS43SJ7ZzWXlRQ8gVUbzLvHUl4QS+ry4=;
 b=i3MWF1vo2w3MkL+nUwqbVuyW7vEddU55HagiJtMStyQr3CeCFu/jEv8MLKMhq/Kl5V
 v1OVdIkR79claUXZTwPt9VHwDpxg5aKptof67CBGuHeaBnuCmlzPGtnY69pBXmwrRihb
 +qElvXANVRMdjhknNQxy7P67NQ9wwoFneXZoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743702864; x=1744307664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d4tfF39Df0uBS43SJ7ZzWXlRQ8gVUbzLvHUl4QS+ry4=;
 b=wW3lKqjfzjlofMfFwrQ03jsGvQhjJjaxDzkSzkcppJZ7kE7+JVvGIid59d9ePpJq+/
 KJVY+RHva4E6yPhNeSTd0rlQm7d5+tlsxO3bMbZSledexE4/cBNr+ba8LATF0C37HKs0
 xzYUf+tTKUBXB4wvGCQHuMYTMWq70TWD7HmLCPEqoGfHmTz4j8ex8AftYHjcp+a/msKs
 098VuxK0abYmxdVqcs1127TU3wJxCRdIWc4Hi+RfUMxpR+h2FbD9cZmzPZF/qSFK1mon
 lpsd0OM0ZEC3r5fExJRm1n1HbyBHVAATd5PmtDtNd0r+yrxAi2YrpO+gIgX3EHX+USK1
 HC0g==
X-Gm-Message-State: AOJu0YwoxrjAUj7D+gaAErLypCa2qYlqL9qqckZ+w6MZyUpxYGH9dAT7
 ScgmjMwkQ8WQzb+ghg3t0QU5NSLgtNqn1G+T3c46y76gygadxkGLyIZqi3RzrL3PS7I55FdZQxV
 3cA==
X-Gm-Gg: ASbGncst9B9xYM/wt1Xh/0ePhyLPUpqa/Rcej/oGhH3KA7py8/SDIgO3NWETY0IeAIN
 CX3TRfmmfHNT23PkRLpIRjOtYzdLcUc3ghXk0T3LLqCU9Z4t/EWDLUxSanvBD4MBuuue1NuM9G1
 Hxp1aD6Gsh/XMcGus2vmcjJrGzi7nANrDZSwhoCpR6QC38wNS3dbJ1i0wjo/JzWKecLwQHUo693
 MSj+uunek+6gl/yI7a2VPe/ks2REiF/en/z+vmaO45zQq2U4ImbJuE2Yf+pKKcFHjYQfgKxgsEn
 HsW0wjZBH9rjb2Sjb3vFYLU3Bque5J0CtnuWSiPCNb4=
X-Google-Smtp-Source: AGHT+IF8mtyvA1LRzwZ456DVGSrs5RkrjfSPSauIm5cgXA+4yqi/3F0CXE/P1r6lFw4PwCKeGzth5A==
X-Received: by 2002:a05:6a21:1515:b0:1f5:6e00:14c4 with SMTP id
 adf61e73a8af0-201047a581bmr399423637.42.1743702864122; 
 Thu, 03 Apr 2025 10:54:24 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9ea089csm1787036b3a.111.2025.04.03.10.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 10:54:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH] fdt: Allow OF_HAS_PRIOR_STAGE to be disabled in defconfig
Date: Fri,  4 Apr 2025 06:53:49 +1300
Message-ID: <20250403175408.2211779-1-sjg@chromium.org>
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

At present it is impossible to change the qemu_arm64 defconfig to
obtain a devicetree from the U-Boot build.

This is necessary for FIT validation, for example, where the signature
node must be compiled into U-Boot.

A proposed change to QEMU has been blocked for several years. As a
workaround, the only option is to use QEMU's dumpdtb option, merge in
the signature node manually and then disable OF_HAS_PRIOR_STAGE

Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
to hack the Kconfig. So update it to allow use from defconfig. This
avoids needing to patch U-Boot to get this working.

Signed-off-by: Simon Glass <sjg@chromium.org>
Link: https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
---

 dts/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 2e88d210bb8..2fe4468d1a9 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -190,7 +190,7 @@ config OF_BOARD
 	  earlier stage should enable OF_HAS_PRIOR_STAGE.
 
 config OF_HAS_PRIOR_STAGE
-	bool
+	bool "Device tree comes from prior-stage firmware"
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
@@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
 	  development purposes, but it is not recommended, and likely will not
 	  even work, for production systems.
 
-	  Note: This option must be set in Kconfig and cannot be enabled or
-	  disabled in the board's defconfig file.
+	  Note: This option can be updated in the board's defconfig file if
+	  needed. E.g. for QEMU to support FIT validation the devicetree must
+	  include a public key.
+
+	  See also this for context:
+
+	  https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
 
 config OF_OMIT_DTB
 	bool "Omit the device tree output when building"
-- 
2.43.0


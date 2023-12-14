Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512A3C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD97B87ADC;
	Thu, 14 Dec 2023 17:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mUEdGM5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4103787AC2; Thu, 14 Dec 2023 17:51:49 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CB187ACC
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35f49b80192so2133635ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572705; x=1703177505; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqlUquu0I55v1hvQor3uryWpofiAdEq0Tbakf+dGhwE=;
 b=mUEdGM5KC7Njo5C0ogKYswZrJmbeqfsnBXSlZRF2zyB+rTsQGnDmr9txdRukjaVuyB
 eniUYfxW06//Ex5Dze06+TYurLUx9zo1OoNhi0iCeq+g32HLhN5LHpZbOOsrrJ0DaB0c
 nxYDXd7EyCicMAuv8sCM8s8pkHJ/2zLQKtM8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572705; x=1703177505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hqlUquu0I55v1hvQor3uryWpofiAdEq0Tbakf+dGhwE=;
 b=agMiSzRg7Ezw1GNWCxvfUZj9+CcZ26BxbYP7tt86z+tHKtd4VM9HY5VgC6h8JouW7t
 Splic7bKGYGpdeFy9pEHnITDCKo+xK2E8v4RA0TMH95gXTihNG4a2PACqEiP1yid/JNF
 5prZzbxpJmyvGxrKw9E5XIvhn+h8xjKojxHbfpUTDEerjLzeBX2eIpMYPxoMKuqPwyEI
 OqgYfHVU4is5FjZRJgx93QedjYxuMgBfP0GKwz/NWYt7oIyFeyNmzLBUuOPrMI62gCyP
 SWi0Xueew3xQzu58fE3T1/EhTqr34irHS+/WgwSX0oVXUzpTbYC5FOlO3U6zGOqqHrmn
 Fj3Q==
X-Gm-Message-State: AOJu0Yw0Aqtn+H+BLTbsMYeF6uYIOeGxT39OqDuqiIuhsDRTswOdAH2G
 clXdXgmEuFVTEcw1yUH3mQq90bgEugZVqZEt2yeqZQ==
X-Google-Smtp-Source: AGHT+IFbAFg2/uyDtW4ZYaRgDnQ++ZiK2yX3dRai6SAq+cga3LEGPn4iLSTLQbwbi3xxDX409j46tw==
X-Received: by 2002:a05:6e02:174a:b0:35d:6241:194b with SMTP id
 y10-20020a056e02174a00b0035d6241194bmr8419685ill.2.1702572705637; 
 Thu, 14 Dec 2023 08:51:45 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>
Subject: [PATCH v2 03/21] ppc: Add a reset_cpu() function
Date: Thu, 14 Dec 2023 09:50:12 -0700
Message-ID: <20231214094939.v2.3.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM.

This is only needed if CONFIG_SYSRESET is disabled.

Since there are lots of reset functions, this one actually just calls
do_reset(). Future refactoring could correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/powerpc/lib/traps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/lib/traps.c b/arch/powerpc/lib/traps.c
index c7bce82a44b3..cf8da2e5df0d 100644
--- a/arch/powerpc/lib/traps.c
+++ b/arch/powerpc/lib/traps.c
@@ -4,6 +4,8 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
+#include <command.h>
+#include <cpu_func.h>
 #include <init.h>
 #include <asm/global_data.h>
 
@@ -17,3 +19,11 @@ int arch_initr_trap(void)
 
 	return 0;
 }
+
+#ifndef CONFIG_SYSRESET
+void reset_cpu(void)
+{
+	/* TODO: Refactor all the do_reset calls to be reset_cpu() instead */
+	do_reset(NULL, 0, 0, NULL);
+}
+#endif
-- 
2.43.0.472.g3155946c3a-goog


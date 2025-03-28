Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9AC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196EF82051;
	Fri, 28 Mar 2025 16:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aeztOWJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A798206E; Fri, 28 Mar 2025 16:36:28 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B16481E6C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d571ac3d2fso20784055ab.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176184; x=1743780984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAaHfJ/jR+4E9zoNlQTFgwOCEgiPIwofFrNKl5tPYiA=;
 b=aeztOWJnsCRzhlpayj+96KXL3aMXbNH3NAUHk/dFIAY6yglCGSDtSvBiR711HzctJ3
 1p5tNxcXREvtGUoWKHnvprURHKVMR3m3rf7w+ES8TZIrFa/zIbJ7lRlNQFsoVXdZFTvA
 /iQWxRFWNPdxUSQk1pkkf57R4maZA1AKdwa0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176184; x=1743780984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAaHfJ/jR+4E9zoNlQTFgwOCEgiPIwofFrNKl5tPYiA=;
 b=c+BuH9aE+BBbBSFaYYaqXcYFPR73kEFthqHHcqhRmaVRoSzuGVyqWYDSiMZyyhKyYI
 eDIKXvVJtHm/lciUc74FdrfIhhWhjf8/2dVJpB+HgUZ7HbB/oBmJdxj8+mZreD3miYJi
 MTmiaq6OZ2A/TnIlBbvlOgmTnPb17iJSLtnCBKJw18EMUVUvOFPqQqzUWX4bzQP41WRa
 YSZcTUpXmijG3iqdSY3XAHwj+KGkj5AfQhZKC4Cmj1Rt7tZ+mLOUS26GcJXehTdD8rdX
 IlZndFvDQl0A5Rg5RcMqisPr+lFoIKIRV+pJD9NVSo4mLpD9a0B5mfM5YyGqOgDtEsWJ
 5ZCA==
X-Gm-Message-State: AOJu0Yxk3PG4HHiXJ5u26iWHjOxj0yngct1W0SFlCDuLmPKer6TCD95o
 oXC3haLEKCnXXlbJzFdeeH4qKI20IXilnfgzSOudbI8y7529hyone5KWd5EDL2QS3ZCTsL2berE
 =
X-Gm-Gg: ASbGnctnG6Dovmn2LdoM5jhFgihI1vLH1dMMhsAJ3/aIbTpJAtHiltbsxnV3fPWY7nb
 IZ5+WrGAXoPl8syzSBfYbzuAojDjj13jmnZ8Bb8S13WDrdDrZOw4sECbb3eATUYZr2rnz8qCC6h
 MQvUcY3CdYLMOSPFghSK0WTu3zw1DQpDaxqLQUqz3trFxMFKxvmjyxAR+NAgIy5EKNWiHLmfWr7
 330diy8SgBxdKrQw95PBFkT+2tflKfY7D43k0ZaLOQHpx58Vocianig7xUgdc6xjTxDm1LC2BEz
 B8dYFi48II2YRXPPdD5wMw69jrKhHg7bEXyeQbF1MvEmvmp9Fpbg16fnOF47WO+ZpMffpdbNHto
 c+PpRuA==
X-Google-Smtp-Source: AGHT+IHDuLJcKjp7VoXMtK7kxgJuSQ2tf8aGG0GIB2lKdqh/r5PMBiJepcAHKGqzRwEMmW4hzj+GDA==
X-Received: by 2002:a92:c263:0:b0:3d3:de8a:630e with SMTP id
 e9e14a558f8ab-3d5cce18eb6mr77276285ab.16.1743176184443; 
 Fri, 28 Mar 2025 08:36:24 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 22/31] rockchip: Allow SPL to set up SDRAM
Date: Fri, 28 Mar 2025 09:35:02 -0600
Message-ID: <20250328153522.3555472-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

The current logic assumes that if TPL exists then it must be setting up
the SDRAM. This is not true with VBE, so allow this to be controlled by
whether CONFIG_TPL_RAM is enabled, or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/tpl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index cc794a7dca2..2a261199179 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -60,10 +60,12 @@ void board_init_f(ulong dummy)
 
 	tpl_board_init();
 
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret) {
-		printf("DRAM init failed: %d\n", ret);
-		return;
+	if (CONFIG_IS_ENABLED(RAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			printf("DRAM init failed: %d\n", ret);
+			return;
+		}
 	}
 }
 
-- 
2.43.0


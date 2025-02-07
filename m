Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09D5C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD62780C93;
	Fri,  7 Feb 2025 19:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hMs1Y8sp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C68AD807AE; Fri,  7 Feb 2025 19:32:23 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2A5E80C65
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e394395aso60949839f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953140; x=1739557940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERTz+5NpgrbM96u00+qlY2YJvajisDMIOiuDMbmitTE=;
 b=hMs1Y8spKjMt/erYagoti1YA+Bpuvq7UOmCC23GrCfjwPo7nD1Id1/XfEK7lqJYQCX
 L+tUILZCK0Q4uT42tSdmg8rPIIS7Pu01V/BSfWsKeB0RO7H0FbDU2HCp84rHBtFApWs3
 iUja3eIoYzB6HZB+1eMRCuKgIR59cVUg5yjzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953140; x=1739557940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERTz+5NpgrbM96u00+qlY2YJvajisDMIOiuDMbmitTE=;
 b=hxEYWW/d7LUhhhc5CWHCQxXvufXeshljKUWrpNnMnY7jctFOmPscyrOkEaaNHMM/Rr
 8DZrfbeERzrSn0cPrkBn61FREtvc+9rK4+K7GSLEYe5SR/4AuzXB4TrPIkq5pO6ApLEL
 2LA6N35FvVxaB9iZBl7qMLnzeZovWsrhQcBABBtMNMR4Rf65/oyz5qLOoJu/nUh3Jiqi
 mMeBsDz9dvm6+EFKbw6BbQ5cr/g+dHhxBOyMX7thMsixYqczG4TDCaK+XauzEj+E+rnP
 QyvvonETmXVj2akcPPLahRoGZyX66OKs0s0kViiFfWN/86qG+TLsnSVBvGEBoDzCMLdQ
 aa/w==
X-Gm-Message-State: AOJu0YxgznKM2CfX/5aSnP0AciCk4V1AXOOoWMm7C87jcGPHORBrv5R4
 SVqrOSM/tJT5vS96mXxHxulJUZVu3A7+ibkRgI/Pg+IyM57Zk2j/qmoN3b5ElxXVgMXtL5lLkQM
 =
X-Gm-Gg: ASbGnctlTbfTjf/Vp/mOIT9aQp0M2cc/CUxPbxfyrmqEPlYD8zmbcSC0Vy7H/pK3Uqf
 Q+pr0YD31iLUV0Zv1XCdm39l1kw2A6D00rdR82jQ1bQitvOXhYcsM5N2DXNHLrI5M+IBH4VU8J9
 +0algxJQE28wmZrodq6l46srnY+D0t+v55Ht8VV2Lxwk63Iar8VZUzb06guDcz70NDyDjaLmvVi
 mA8hEqWMOCPHtLngjribCYsuHuiXl3G0HYOyWFMp2JrfOO2Rfl2kbkkCrSV8LoaYLpNQE6/MsKh
 5z2JqHcAN3w4sQizYLNeDhWx0yWdfo81eMVAKt9aAtAKjMec1UkZ
X-Google-Smtp-Source: AGHT+IEli1bjyoXmgZo12cQ0flRwR6jhMBS3yHvZMgExvgcmjUPa5Wqchz1WD49zy6psSY6oRbGAOw==
X-Received: by 2002:a05:6602:4c0f:b0:84c:b404:f21f with SMTP id
 ca18e2360f4ac-854fd9055bdmr452623439f.13.1738953139858; 
 Fri, 07 Feb 2025 10:32:19 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:32:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/29] test: Rename optee test-file
Date: Fri,  7 Feb 2025 11:30:53 -0700
Message-ID: <20250207183121.117663-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

This has nothing to do with commands anymore, so rename the file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/optee/Makefile                    | 2 +-
 test/optee/{cmd_ut_optee.c => optee.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename test/optee/{cmd_ut_optee.c => optee.c} (100%)

diff --git a/test/optee/Makefile b/test/optee/Makefile
index 8793fd7ad61..ec56750fa80 100644
--- a/test/optee/Makefile
+++ b/test/optee/Makefile
@@ -3,7 +3,7 @@
 # Copyright (C) 2019, Theobroma Systems Design und Consulting GmbH
 
 # Test files
-obj-y += cmd_ut_optee.o
+obj-y += optee.o
 
 DTC_FLAGS += -@
 
diff --git a/test/optee/cmd_ut_optee.c b/test/optee/optee.c
similarity index 100%
rename from test/optee/cmd_ut_optee.c
rename to test/optee/optee.c
-- 
2.43.0


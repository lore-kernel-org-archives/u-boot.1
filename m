Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E165DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C877808A2;
	Mon, 20 Jan 2025 22:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K3Dm3PJZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA348032B; Mon, 20 Jan 2025 22:54:31 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4AD80836
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844eac51429so383360239f.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410067; x=1738014867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zE6cbJMYwpHQZxG0VZBXGcOJdDDi92TKttyNWmsWA4=;
 b=K3Dm3PJZB1YkAFIcOJ7q1qyPtGj5tKkql85VIKhK6r8Acte7C+o0k9a3ms4rJHg00S
 mA6wIuYLsqDWTxpx3XH5z7sh0u83VtC0TL0DbAudFN1nioTP7WwF+rQnDbyNjX7aL4MZ
 g5KhlnKu9om6hHO239QdEv9xTNNSlOFW8ZI/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410067; x=1738014867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zE6cbJMYwpHQZxG0VZBXGcOJdDDi92TKttyNWmsWA4=;
 b=ataqNJzr9Sb4J79w/UK3zXUfdMPjHYXG5RyDTK0dDFzG0XWDBMSSZiGJFEFL3L79yT
 wPIM2zLV0Dj2A1lBemHF/dTFAO9TNLSXZZorbN4l3uR8/ixCRSSzDwzxFBDpfSKSpm7I
 9sMaR7i/pldWZGE6ty8rUYusexilDQ4tvZsPKtAlPDtjkZn8qGtvr49dz8b60Q5WjpbD
 sFghOJzlF02pDqIGnWN+/YA4soUghe/8+54aWuTAM5mw17ck2JJ211/BQKedjk2b8iRt
 AvkzaUIb2AfE+ylL2BDH+viU5+pPReu+Beb/HyXl2iamLZ8zAewCq4aEk6c/pZ8vk/3Y
 aFOw==
X-Gm-Message-State: AOJu0Yzws0Wo9b7F4iVvHCwCEIPcs0X4Q+Xt0pziUgoyfC2zwTTvMQN2
 kQTRcthyLMd0w9TehHT9GUnnXJAzC51oMybBM5ShuEZoB0juXRPDaWEzc4iW2DAKY1R23ukeIl8
 =
X-Gm-Gg: ASbGncudHjmtyxam+Q3j0FPCcgZ6aaj7QG8ujfFu2OD1DPxX0tG9MZadnAX39hsiFPD
 LPqdFrt99ptiy+cAt7PhJ1WWaW8gmH0IdcC36p0BFqoO1cIQE5nQXbtiwcGY50Cf5AodQ4wyLpW
 iWL8LIuhEbnHx8zSgyz1WLb4ic5nPfgCjLTsrfuEdHpMLLfxfN73FdE1oc6CCLBjWl9VWmUSsuI
 JSa/sISU9FhAQQGICmKYlVrgA+eooItTdO0h9k+I4ofWxI8m+z0owZNsrOCMoSICwuxyDmISJ+t
 J6kOd3TfOJTTVRj2C4tVUN85K2uTHJ8=
X-Google-Smtp-Source: AGHT+IHt+0kUwzEdzVHhSTxq0QTXMCYQ2W7jnLczFxVTc2MTTS0e8lzkra6fst4po9xOt4sj8EQhuw==
X-Received: by 2002:a05:6602:27cb:b0:83a:b500:3513 with SMTP id
 ca18e2360f4ac-851b62426b6mr1524839939f.8.1737410067257; 
 Mon, 20 Jan 2025 13:54:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/28] test: Rename optee test-file
Date: Mon, 20 Jan 2025 14:53:21 -0700
Message-ID: <20250120215340.617194-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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


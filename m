Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7C0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE7987129;
	Sun, 12 Nov 2023 15:44:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KYJuJwPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A0F871A2; Sun, 12 Nov 2023 15:44:20 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13EF886DA2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7affff20d38so99207839f.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699800255; x=1700405055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhvlHRGTpW0ubrVQfkZebzeYZgMS2J5nLxQjyaZXeF8=;
 b=KYJuJwPjGUghVeXP+9up5qwpAC8AhWvK2hm2aKpFWox0UIUDhkpSosLdyvJJ8u9o2F
 qF6KrpODI0ARQTO6o4ame+yHYOznB1DtY5sRBQlW8g4zWH/jXZfEhj+ht4ZS3k0U02VG
 ZKNYOC3ucplJD4mIh4yz73dmlvAzkf4FWp5WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699800255; x=1700405055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZhvlHRGTpW0ubrVQfkZebzeYZgMS2J5nLxQjyaZXeF8=;
 b=DSN00n2uPW8gHKMcI48yByhXWn9iumnOaE6ZfbFD6buaYQI6Pu+rR30+nPlxUU0yuC
 Lo9JsdBkctYMs8qV0ogalmtDmhYc+Tve9mjAiNk8rLhJIbU0C86imE1VaPZXSEWoNbu5
 wS1HKqIsxqx1Mopbsug1glOdaXiW/yEYlXPtzr44ibs8UFBBT/+wleOMxx6L0ASwgHj5
 5QSp+ZkChmXufZbxKSuXcOfYj0HjfJguXYQD6vCRsGXK5gr2PtXzCUYHuTM6M813OMH5
 Z74eSytMc/IZ0W1Au2eiOSi65FjAfqv21I1AgSYUPDG+QhIqAZiNL0Pbz/Kt5/Okft57
 lkuA==
X-Gm-Message-State: AOJu0YwTHLVjZ6u1CUuc7nxRLHEVyw7gKbeJ1Hw08SeUXe0lvmLo0Nn1
 9uLAusEEYinRko1oONSTVyfmVYhmvztlwQeT6BJuvg==
X-Google-Smtp-Source: AGHT+IH1psuKC07Bll1Bpjp5ib92Y7Dj9m6cRZOKSLxAI8vBtBus3De71w8xNnVumEmPnSpyZHNO5g==
X-Received: by 2002:a5e:8b43:0:b0:7ab:ec1f:f486 with SMTP id
 z3-20020a5e8b43000000b007abec1ff486mr5340454iom.4.1699800255586; 
 Sun, 12 Nov 2023 06:44:15 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056638168200b00430a20ce88bsm452856jat.174.2023.11.12.06.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 06:44:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH] sandbox: Fix VPL instructions
Date: Sun, 12 Nov 2023 07:44:09 -0700
Message-ID: <20231112144412.120369-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

Fix the devicetree used with sandbox. This is needed because the
default (full) devicetree must be used by all phases of boot, with
sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/arch/sandbox/sandbox.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rst
index 23902dee89e7..9c69dea81ed1 100644
--- a/doc/arch/sandbox/sandbox.rst
+++ b/doc/arch/sandbox/sandbox.rst
@@ -427,7 +427,7 @@ VPL (Verifying Program Loader)
 Sandbox provides an example build of vpl called `sandbox_vpl`. This can be run
 using::
 
-   /path/to/sandbox_vpl/tpl/u-boot-tpl -D
+   /path/to/sandbox_vpl/tpl/u-boot-tpl -d /tmp/b/sandbox_vpl/u-boot.dtb
 
 It starts up TPL (first-stage init), then VPL, then runs SPL and finally U-Boot
 proper, following the normal flow for a verified boot. At present, no
-- 
2.42.0.869.gea05f2083d-goog


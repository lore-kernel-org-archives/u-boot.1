Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ABEE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE88680291;
	Wed, 18 Dec 2024 16:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UzL69Lqr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BB180274; Wed, 18 Dec 2024 16:08:09 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277418022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a9cee9d741so54625185ab.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734534485; x=1735139285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9CfrNX2ENn+nkeHA09ubuxwUqRkllILpcT6js4zx0TE=;
 b=UzL69LqrvcKJplCexGaUgPAJL83JrF7vHz4IftPuYwgsZw3BVqNy4xVOp7i6ztXHdt
 ayqmDXWm0rPvgyQ2aZ8MSOko/TcHO0H5rqdEGMB6Gr9fCYE5gIz2kH2RPrBlynNuQPKU
 TVPRevNNjdflo8cgEofRODPKcMnKFssUmn0K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734534485; x=1735139285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9CfrNX2ENn+nkeHA09ubuxwUqRkllILpcT6js4zx0TE=;
 b=FH+CKZhlgjMmPGeqj7UjUVfyaH5WAQ1S/jIUJXr+WLPfVbC7ltVrcfKjhOrqSwG2/U
 dfBaGwcZzFBEjHr+2VHFAxKEz+hExziG2jBGVjbnrWPADiJ5Aapk2dKD1ogA2ObzG8pE
 DkzCwCeV5fb73UXD8eB96dueMMyhWWlw+vmdWTASAT1K6RSljiGRGPemVzUUanG8hPrJ
 KPyDow2rB0lcuWKUrBdFiBl7sOtqEiEHki13SRWRQJwfiprxGs023WimvPk7WkNFYMg5
 2ojhgWaZ5TgGdjx+P1+6a97TvJlW1n2W4rtqrXojdTPtCpmCgPZUphtM5H190lM5XDOp
 8ujg==
X-Gm-Message-State: AOJu0YwiRRiUsozQ81TpHirk4j4YIdYxPJUez/4rBCT15e/6v3ceNpF3
 EmEoR4zv4qfAodma+JDGgOTWsbdaYPIU3E8xMQ2qDBZXe+kBxQtBElAypwKeOHdMmSy+6faqMCI
 =
X-Gm-Gg: ASbGncsSLatQkaObMD15RLqfDlTMW6DuQHWN+f2c3l6pYbA/NCuo7ybcJGHn5WZ/VJC
 SkGIxML4+PvfoExlNjwHq/wTgWo3H/+CRtLYC+oCHahjUKgrXI7QtZZ/eBIl7gk5LxMIMCP3Vmd
 ssYP86dQqAOQmZo64tpMhe00OefhkibpRvhhDkkoNXfuvyrKCKvsz6IoCBFsG8niny9uTbR2X8/
 u7eWx1aUjG4kDgqlEYkwDUD9JDk5IuaBMB4Wp31etSAxrjGqC5Qc+kL43mxdgHkVRfMG8o9Pi+y
 dpg/pwZc9nQ45Zz+7w==
X-Google-Smtp-Source: AGHT+IGZSv6QlXXPY3s30cDEVRgqyxEIERNWb5QZNaBRtYkGHMufO0SFNXJ0j2LWaRS19uWdzdKHBA==
X-Received: by 2002:a05:6e02:3706:b0:3a7:e01b:6410 with SMTP id
 e9e14a558f8ab-3bdc437a9a1mr31010685ab.18.1734534485374; 
 Wed, 18 Dec 2024 07:08:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e32a3529sm2249628173.95.2024.12.18.07.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:08:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] gitlab: Add a Rockpro64 to the sjg lab
Date: Wed, 18 Dec 2024 08:08:01 -0700
Message-Id: <20241218150802.4064561-1-sjg@chromium.org>
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

I have one of these boards with Armbian_22.02.2_Rockpro64_bullseye
loaded. Add an entry for it so that it can be used for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 61563c87ea6..c620cfd1e34 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -705,3 +705,8 @@ colibrimx8:
   variables:
     ROLE: colibrimx8
   <<: *lab_dfn
+
+rockpro64:
+  variables:
+    ROLE: rockpro64
+  <<: *lab_dfn
-- 
2.34.1


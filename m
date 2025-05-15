Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537E6C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E6FD82B63;
	Fri, 16 May 2025 01:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R0o7yJIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A2882B2F; Fri, 16 May 2025 01:42:19 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428548059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7300069c447so1416494a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352536; x=1747957336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c34c3prZtL5VRqZjBSbIK9q9c10oAIyUuG2ZjpcCGEw=;
 b=R0o7yJIClNBvsNurKCrGLqh5pTRLc6LwgMgciqz04fVSfDU8YnCgI58XZHbEBQK2BZ
 YzpckF8QJjEgIMcPuwoK217pagSEJ6hqi2CJIQAJ1ogdaPlj/rNvu33NNGjfln1CLW/9
 mYQ/1nuQvQVVB8sZEAuH2CAoTP4K9puXnlLsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352536; x=1747957336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c34c3prZtL5VRqZjBSbIK9q9c10oAIyUuG2ZjpcCGEw=;
 b=MPfUDiHIcQmAHHgGHpNnLbEYMMxwhaAkIh/XkgEkiK1Fav6FpHSFE2UKykggWzm213
 xkD5xdnuMa+hpyv33ZJLXEmbo2V/Z/Pq0fMviZdWOTgfD3WF6jQDHYXFIaEu4+jA3ljZ
 KLIYeIkBEcQvM16y8ij9ebpqB5+pspTZBdxv5N/qKBU5KqZo10KybstXaeiW3T1upjuw
 mNPsoUpVSQxBau/vPSG66NcUmMKYneZMxcZug2VeoIR3/KmJF4Q1b2N63Le4NQ7z5Npn
 nfai1W1/wLS/xHhvnd4iRrnqjbiRhHhBiDpgvvqRkaH15z5445gFQin171LoBa7L9WFQ
 AIRg==
X-Gm-Message-State: AOJu0Yz2lLXxbkXUTcULtgMg4zK10GyFyG8RvcHKpEMZMd+wQT4nYd2N
 /sZi2IWxQ+7tMr1v9Ba9pK/EcikUjtezo5EmLREkqRJ88+HCe9GoA9I/qAadrj0LUYgTNsGeUP1
 nAVV0714=
X-Gm-Gg: ASbGncsaanJHHBOzltiriOUGa2+zX6roV/kQJqceExhhWKoRbbucdDLHyNEhv9HheiC
 4WCHeMtFoCG4JR/yZnC464Yh5a7Pj4q0qG4LMi9jR3YRK2NTa0VSTY6zFvdD/DuvlajJtlluDlE
 MvsOSK6YZkkTMZ54uUoXqHzBL75I02VZROso3cVJZPJikPQnExl3Y+rIDOf0DrDFEwfgAiDfRU0
 yiXR+DZhRjUCgQMDo05yg+niF4qBmVFwzU7qKxOIyLUUKZbLo3T3Lj49+LSidWCcY4NcvG2p2Vj
 L2/fLGNRrUyORVCOEKqnibFhJ3igTnCcX4etgYSvXy/2C4cBW6NWWzHBxpYMMjg/46RF7SVeERw
 lw6hlOYm2hwEyYo8=
X-Google-Smtp-Source: AGHT+IGLIcxEZDcDIBSdJv1E11L9IJCWUeAq+x0Hn03Bo4hbBMY5/Yr8BYsvWy1LcBgVyajAsLCnHg==
X-Received: by 2002:a05:6830:6882:b0:72b:ae42:3530 with SMTP id
 46e09a7af769-734f6afdfe8mr1085228a34.15.1747352536055; 
 Thu, 15 May 2025 16:42:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/22] google: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:44 -0600
Message-ID: <20250515234154.1859366-16-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/google/chameleonv3/board.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/google/chameleonv3/board.c b/board/google/chameleonv3/board.c
index 4d3049689d3a..d8ffdd25b387 100644
--- a/board/google/chameleonv3/board.c
+++ b/board/google/chameleonv3/board.c
@@ -2,6 +2,8 @@
 /*
  * Copyright 2022 Google LLC
  */
+
+#include <env.h>
 #include <net.h>
 #include <errno.h>
 #include "mercury_aa1.h"
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154E8C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B69F822D7;
	Thu,  1 May 2025 03:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QSZyoFWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E448056A; Thu,  1 May 2025 03:05:53 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA09582163
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d9327d0720so3862715ab.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061546; x=1746666346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DEdJU/0OsQg3UR1+sNaUef2MvapFAIUTVs5fGZGYq4=;
 b=QSZyoFWh1Fw8tZHvhJbvk3XfEfsoz8SGHiZgNoXCH9UEtVxOLwgFTRn3xd1hLGkSoG
 NCOFIxGpCuU4RhOQuP9JFO+GaHCrAxXO+LwOixiD8fklIIY8/IuZVq+R1qsWrtpH+Db5
 WxtmqdZWVDFV2AK34eJkaiV68jSD5rqVYJ+9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061546; x=1746666346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+DEdJU/0OsQg3UR1+sNaUef2MvapFAIUTVs5fGZGYq4=;
 b=mALXBLWAy3fpFE8ZihDrakj3V+ETSIoXzoQxNFEDRhlj7fAh9a2J3kczB6PsS9PF+Y
 V/rmzDy6HOeUkTLK9KzR21qTLEGLEaSKU4RduXblOkpyVIYQu+BtQMre7557UJ/0/+1r
 gv2jrDd4hWMC8WjTKt82+OhbKOosAtTnwNdr3/5a2hLoLcJGRPhqaBEBqFX4gwoMWueR
 TpiUeDUpLU8GK2HJW1cEJYKRBKDUePh5Ne5V/QCujctdGY3QJZzueU6Dw2KvqTGll6Na
 UH2HnOaVTtDi5JoSWou0LV8vxovrzFoFBEpbOjNy6l1oDpmbS8+nlQ8krINEjFnF6OH4
 w/RA==
X-Gm-Message-State: AOJu0YyWtZzvjaJFyaOB/xxhgQpShvgyvIfmYdWECxQExzRC8PBKtPdo
 DJ/+9e6kZXQUCb0HW1+e5w4jNbQoPz3LxlBfnG3ltBFdXWru0UNNrfoaJjhmdqRTq51GhBbu4AI
 =
X-Gm-Gg: ASbGncuxNpnMk4sJn+LijdGTkDsc5J5frDMsh1X0mpLqqcbRSxPQodmxj3L+T7Rbqgk
 14qTztPBGiQCMT8ErscbROXtWE4GDoUI/e1RnaO7G5jAH7hhrYEWRR1rwi512EE/NtIhe9AsDJB
 USTkzBT8fFRMknEnSJ2lTD535qtG+FpMRJONrGHa14ePidZQilyOKEQwvJBPfdVHB1p9HoR/7zh
 oLmd7r2eu1C/fd1Th1FpM3xmfCw4AuYgWCm1xOb7visELNnesshQ9Y8MQEdZjnNptV3sXAI6nDI
 JO4z5dXjAFmUzz1UMIsejHVfkff7x1IgK+/6pPy8Y3bd/5ChPJDCvVaJ5zVPbt3/Jos7emMqX2J
 EqsBKDTU/DT6N
X-Google-Smtp-Source: AGHT+IEfZM8GbN8YexqK54Id7T0gsAOEao5OT0sgCZJepyhDr1eVCGkW7zXrolc5LA5t/qVgYchEXg==
X-Received: by 2002:a05:6e02:2591:b0:3d3:d823:5402 with SMTP id
 e9e14a558f8ab-3d9676c62b2mr58578975ab.7.1746061546454; 
 Wed, 30 Apr 2025 18:05:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Phil Sutter <phil@nwl.cc>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 11/22] synology: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:36 -0600
Message-ID: <20250501010456.3930701-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/Synology/ds414/ds414.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
index 1a4cea87e1a..02d6a4a1ea8 100644
--- a/board/Synology/ds414/ds414.c
+++ b/board/Synology/ds414/ds414.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
  */
 
+#include <env.h>
 #include <init.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
-- 
2.43.0


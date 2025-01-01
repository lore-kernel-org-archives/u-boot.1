Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348B0E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 19:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3215A80107;
	Wed,  1 Jan 2025 20:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UgMfbaKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD8380317; Wed,  1 Jan 2025 20:58:31 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E051800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 20:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21a1e6fd923so99983495ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735761507; x=1736366307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VQn4FC1HRYyXYybTMsDD0lQyG3zB8HjaeksmfGDweMI=;
 b=UgMfbaKLHT4UvX9TItN5f2krpJtkFwFhDnXUBflCjakDycn88tJcdVRklYjPFCs/CC
 s8FkohnbTIC6ddRH0oWgqb0kiJbM984rojPtmzH+LCrsuDNZ3j+QV7kpTd3gj7MaYPUf
 QZYgApd9hYsLAfG48xZLLDa9pndTKgiplgk8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735761507; x=1736366307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VQn4FC1HRYyXYybTMsDD0lQyG3zB8HjaeksmfGDweMI=;
 b=BC0tHxEN2CMnqulV0z/abifBDk1aH19OOrFfCWDzDTMVRm2T5y/e2uBBQl3TqGSRUO
 9Y4GluvB3kJpgbbQHoQ9BzyIPnXR6JpZpTkAPN846P5ECkHhR1zWedYYhYb/7HPc276R
 AK+NwJchOT/DG0KdgMpUhpEp20N6Il7PPBewzXk4lnfII5OBOM91WCCr7PkOpCnrA2Ba
 R4TBdgp8VElA58tZwE02Uwgy2shDnkU/uHmd91biVVB+kEH88wWuJV87fMNvQPe7XHfO
 Lb0DOLccG65NalMiv3cB1Ao+urbK44IfgSGeWK0fOIxAvb0IhdZgcZZLzZ6WnyCDcOup
 VwSw==
X-Gm-Message-State: AOJu0Yy2522KY8ppXMzHh8IuR+o9P1j8Z3nqGmBGnSqJu28M/TZAoOqb
 26sqrxW25+V1b6uy1qSHVeLNC1M6n2n6pr4ks9KzTsS82t1iGHsG2NJBMz/2iIs6A9KQ89Qtzug
 =
X-Gm-Gg: ASbGnctLwLMkwpAkBXgV7AEkEX3DojAZLzlz6IGI6C8I1ShPeu9+PXo1+rwghXIgWDP
 MJL2A0czYlDLMYvkV8xO9WkiRzY7eqZyHhx+5s9AuvTiNM1rHPbd7TPvSv2iBVT5z8MSxmohEEN
 ZITYqzKTkhV6EtqzL0BiFpnvu4eaW9a6qrkyBFgwwO7S2a7392ZAXBnBRVtyFzLcTUig3nVUfjU
 GivKsJHhiJU9K7FNhkEWlMU7Xspi7cKyYaOA/IdsuU/giwDzJIf3aQ=
X-Google-Smtp-Source: AGHT+IEsPYkIwG0tYy3Dz7sbAGV4krKdy6APHA4iFR7PRMdJ4+0P/de1citBc8Chcohpo/Ig9B/DbQ==
X-Received: by 2002:a05:6a00:ace:b0:725:d64c:f113 with SMTP id
 d2e1a72fcca58-72abdd20f93mr61965282b3a.3.1735761507216; 
 Wed, 01 Jan 2025 11:58:27 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90c24fsm22807457b3a.193.2025.01.01.11.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 11:58:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] bloblist: Drop BSD license
Date: Thu,  2 Jan 2025 08:58:15 +1300
Message-ID: <20250101195817.995321-1-sjg@chromium.org>
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

Linaro has decided to write their own version of bloblist from scratch,
so there is no point in having a non-GPL license on this file. Change
it, to better fit with the U-Boot project.

Signed-off-by: Simon Glass <sjg@chromium.org>
Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215

---

 common/bloblist.c  | 2 +-
 include/bloblist.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index ecce3da9331..c441498ec56 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
diff --git a/include/bloblist.h b/include/bloblist.h
index 7d462e71914..be7303e1504 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * This provides a standard way of passing information between boot phases
  * (TPL -> SPL -> U-Boot proper.)
-- 
2.43.0


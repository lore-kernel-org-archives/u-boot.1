Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766CEC3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 06:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D343283156;
	Tue,  8 Apr 2025 08:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fT5LXqyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B82831C8; Tue,  8 Apr 2025 08:29:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4768312E
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 08:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so8282659a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1744093740; x=1744698540;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VwrJ9cRvUs51R9IHH9G6L6h0Ju7CNrY+uR/6yrf1WX8=;
 b=fT5LXqyyw4ph8HY4KM6toMO383psCqc70qBaQgiPqRpihExvbpBZmrCCX90gGpId3D
 xgL2IofUqxVcuBJ0ZfheqGjnQrqk1Wy0SYrABRMzIBV+2KBYYvLPNERtx4Ys8MI09uBS
 Txw6PF31mpLESxDqb42LBrhwcNwrwV1Rqcd4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744093740; x=1744698540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VwrJ9cRvUs51R9IHH9G6L6h0Ju7CNrY+uR/6yrf1WX8=;
 b=tboi5IiuEK+Jc4W1U3rzjedc52a9GqbTahBtF6YJ/KD/ud42Cfkk/apUmxXRTwQmfL
 hpa0PL8zYoeZx/nM7QzVBnAydKkw3RHYHPdDQVNDiu5OrDF+hDX5LZ0a+w3OKyUIYsOU
 o2VMJtOREI8PP5UeQzk2eeUj6KHyiHooV0C3Lb3quQDbvhr0cqpW4hqlP+xSKfuuzi+d
 n+NwNbVM8gy2GC1ekC26KA/84lGZOZOM3IMMTJPhZ/OW9TGcPhMI4QGZEO4gm2nqqB7q
 nf7skcoN0VAzrTy966eDt+jKEtn2FnhTSEQA9MpnqCM17rDnx51FKM78QTbet7lHejR7
 4fEQ==
X-Gm-Message-State: AOJu0Yw9wZfvQRDya2lNOGLT2DSNyEtUAtcAl/8TwIN+zohsVsKtiJ0M
 ZshNTxzjCeQUZ74zSSNQ5gbZEVKXtoG0wKy/NJdO8cezdHSnkZ0sOvK4PYJ+rGg8ZssatykkQI/
 N
X-Gm-Gg: ASbGncvUSSUT6PSJhGCAagus3SWqL1l3f8Sozy4Fs4Th2rabU0RJl2G2rjiAbNKeSOT
 WVG2Y2rX+i/8f3Hpu4hMe1u7nAgVUPFfHg5TxFkQ0L5uVZD1DuihMM7CpM+F3PveIC6/XSzlP4O
 pLFAq34Y4AKTdXTTBOWArWJAsSPVVVZIUWJJNuniAUyZmSOpOqQJKeDUrHYZNrKMht/hT4RxRTg
 DwAH7UGwSvc50ugGWQEtNWu04ZxF3pjW7/zTSvloE0dROkPAJ6TK3jQkBylbOJO4JiHRFs9qUlt
 vZPfKKCJnSjQnDLeIPuiG6pOqB2swc/xG1F3hkD+zoQLrFU/nOMU8j5KbAFIWhXC5w9XpDJD27U
 +dkqAkc1YfGE54GrRcVKsG15sGQn2b7DICy9HS2JaqkUnoLzUDB0L1KFYDBecb83UTh4QtCoQRK
 0R1AW9snlQqvc=
X-Google-Smtp-Source: AGHT+IGF4o7vddIAZDLHqRcVFID5wkwv11oyx6eHHREUm0Yik8/G/G1Yu4iw3/lTSPJa+nhmhx6ulA==
X-Received: by 2002:a17:907:97c7:b0:ac6:f3f5:3aa5 with SMTP id
 a640c23a62f3a-ac7d187218amr1294806266b.16.1744093740294; 
 Mon, 07 Apr 2025 23:29:00 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-25-86-232.retail.telecomitalia.it. [79.25.86.232])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c01c2170sm870785966b.170.2025.04.07.23.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 23:28:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: release_cycle: fix next release version
Date: Tue,  8 Apr 2025 08:28:28 +0200
Message-ID: <20250408062847.1520368-1-dario.binacchi@amarulasolutions.com>
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

The release commit for version v2025.04 forgot to update the next
version (i. e. v2025.07) in the section where information about the
merge window is provided.

Fixes: 34820924edbc ("Prepare v2025.04")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 doc/develop/release_cycle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/release_cycle.rst b/doc/develop/release_cycle.rst
index b108f9b11e00..cbbc2bad0ebd 100644
--- a/doc/develop/release_cycle.rst
+++ b/doc/develop/release_cycle.rst
@@ -53,7 +53,7 @@ Current Status
 
 * U-Boot v2025.04 was released on Monday, 07 April 2025.
 
-* The Merge Window for the next release (v2025.04) is **open** until the -rc1
+* The Merge Window for the next release (v2025.07) is **open** until the -rc1
   release on Monday, 28 April 2025.
 
 * The next branch is now **closed** until the -rc2 release on Monday, 12 May
-- 
2.43.0


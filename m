Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918D0CF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E32483FBF;
	Wed, 19 Nov 2025 15:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i9nDgAJ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC36883FE7; Wed, 19 Nov 2025 15:55:44 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB52283FF8
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3ec96ee3dabso69833fac.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564141; x=1764168941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lf/jCVH11h8Cd6oo2kCuf0i1//cPMS3YDKUCPi76JGQ=;
 b=i9nDgAJ/W9lpzad0SFXoucEAh949QdUVw4egaxzb5+MCM7d0WnXJsZ46UMkkYESdv/
 0sOnuO1dvv3LWPsBgVwIfJJGmRcBmZzSkDN6SfuJ9FRamwUayR6Mop93zPZCWmYEVbw6
 38MXkvwwoIvw+rnV+4OOpWbE9L7rLDmGXm4EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564141; x=1764168941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf/jCVH11h8Cd6oo2kCuf0i1//cPMS3YDKUCPi76JGQ=;
 b=kqGq2eD6CYt5RjANcmNmCBZfd1qSGGyYd8Zpp+iXJmZ+LryJnRXHFwXLd2iAer9yEt
 hBvXrYEPdFfWQ0RcqhWbJmFK4aipPjtvduMH1GuRNw/CCZ52ZFgxvTsxYuOKRaOBQ/rO
 0ULMyxrqAMU5rO8+cVTg9jNH4RmsC4Boe7zOlMiBpGMPm4DlHeVlYsD7uiZ8f+qgtEl/
 Ji8214D6RprgUbgt4YQcCV/mPhdUH4N9WfSwN/mw7fp40iqWOcZlA9NZeif2XJV+herg
 usxsrjX21qkruRu2oyIN75em3OhjllpWnItZGK+8dbIWacB4l9Mfbb09SQ3Gu9vyXp2a
 UNFA==
X-Gm-Message-State: AOJu0Yyf4JyjiBsS/fwAkdfBNv12wkpHP1m8m5GrMDq1B8Kild8LIGGb
 3mo81q2hY6zn1m0TM1X3JE+Tx7lKPab2eRz+EHwMaVh9B1tHN0ipVSWTTs8Mc5wgB5nnoO3/6sK
 JzvbzLlrGdg==
X-Gm-Gg: ASbGnctv3jEqbUJufzcJmrT/q6bDDviZLjk4szjmBvTpNq3UWRpPg75Dv6eamGAq+cD
 BdpR+PJOo/SVwWZxBW+nTdujR9n1DLj9xI0JLqhe3n8mRyJ6BQpEglIKUjHGdyLKpRODtuQbIri
 knuxiwUGmQ5HmvjTYR/l9ZdBuqPV0kEMdXLXQqfof5UnXpY8gq3Kgcq0wa6TzY6dWCkt45BXOLb
 yyKimdeFvMHpyaXjR8yi+iX17ET+IL1oykkR3/pIcjk3kiPzQA/EDRoYxrVYYms4ruAzN2jGtL6
 s9ap4eeMXf6Pmggyc0mWCtLS0ikpr9jZYbBe/QXMrBXihFJ0cjiUWO5pxIBLLMUW0W1VcCZmGpU
 2kNFLgDJY1OfUUVZInOx7SYwolCKfD2L/NNEsdI41osfO4kxyi/YcflkKPODWee44nvO5BQEooh
 ivc1rFWKytMa1e5qt2z8c9g4RXeb7Gj4adLj7gDLxVjzLET84hcg88coh6gi+rqKc=
X-Google-Smtp-Source: AGHT+IH2twdb7Q5A2DhMSrDcBkS0v18hohTNVodbNNjH0job3NV5E92Il54T2/dWJnU2Lpviy78JKw==
X-Received: by 2002:a05:6870:322b:b0:3ec:4f31:42a with SMTP id
 586e51a60fabf-3ec4f310719mr4355829fac.7.1763564141464; 
 Wed, 19 Nov 2025 06:55:41 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e852043499sm8310421fac.6.2025.11.19.06.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH] tegra: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:40 -0600
Message-ID: <20251119145540.843448-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>
---
 include/configs/tegra-common-post.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/tegra-common-post.h b/include/configs/tegra-common-post.h
index 2f08dfed020f..a9c0cea4e149 100644
--- a/include/configs/tegra-common-post.h
+++ b/include/configs/tegra-common-post.h
@@ -50,17 +50,14 @@
 #endif
 
 #ifdef CONFIG_ARM64
-#define FDT_HIGH "ffffffffffffffff"
 #define INITRD_HIGH "ffffffffffffffff"
 #else
-#define FDT_HIGH "ffffffff"
 #define INITRD_HIGH "ffffffff"
 #endif
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	TEGRA_DEVICE_SETTINGS \
 	MEM_LAYOUT_ENV_SETTINGS \
-	"fdt_high=" FDT_HIGH "\0" \
 	"initrd_high=" INITRD_HIGH "\0" \
 	"boot_targets=" BOOT_TARGETS "\0" \
 	BOARD_EXTRA_ENV_SETTINGS
-- 
2.43.0


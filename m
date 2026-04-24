Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B201FFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5470384359;
	Sat, 25 Apr 2026 19:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fVaApr2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F350084413; Sat, 25 Apr 2026 19:13:16 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BB784359
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 271FE3FEBB
 for <u-boot@lists.denx.de>; Fri, 24 Apr 2026 13:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777035914;
 bh=Ij/TqxRxiYQ12F7McVoEBejZG0xyP0w1nK9SUfdP6p8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fVaApr2lt/9TAHBVx34wPDmniwN7BNHaEg+wfLbX8KKqDpZLdpqs2RgO20NW2AtNI
 FDG/+aVHIS4p38jCcInMrTqQmdaj1WLFYLimKs5FVk2Ts1ci7R1G91jpdJxs4K/bLG
 dXRINyQh46EDfoj+WX5nTvHzfpDM/sCwte1gdhlHV59k2OE71Wt0ds/0Kphme6OWU5
 jtzz4EQqgi5ZhgL6kdLLBaRJ649ZTMfur/s+Oj6BofkN+GJp0A/Cg7Fpuhwh71Wbqw
 6NkFdvqU7fwG71w4F8er1fAJQI6kFrYLKkateFS7zQ0p91cI4l1rNi9WBwtF7xiyEw
 +cm7USGRT4OdCd5SYQzPFM5VR+eU2qeBc2LyDD5f7bMpsjdyol4shTbOIX5pF2xGgc
 9xE9jMtg4fiWctTBZoXhzTMfJ3Kuor9nspfk54ijFdnwb3M58grpkuL4VNY9ukExZv
 etRf/d08IKCvTZjOX80WWlDI4jfevSJDBaDVUzMRX6MykUoN1chzQXZU1E8WcSW11p
 RgSaWQaL5O2TMcqD8jejCmuYY+bXSlGuBbTUFU0tHq8e445DeudgiKDnH4XeAPNEw+
 Nqmoa2wrgvQRndFknW1JzTRbaSmMcjcEY8m0PAKPN0yKHSzsUgAITSYaPrdJDSvu9h
 FpfIv1NujLxSLvtkO3+w7bLY=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488be33b7a6so55747545e9.0
 for <u-boot@lists.denx.de>; Fri, 24 Apr 2026 06:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777035914; x=1777640714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ij/TqxRxiYQ12F7McVoEBejZG0xyP0w1nK9SUfdP6p8=;
 b=AQCgqfRYjR6eddv8vUmQdOI6hMIhZ++88DRTIkJ+P9FlO7EY9bHiMfh0gmYMX29Jfx
 7wNVhe791Pk8y2K9MXLGqels/stp5UmiBwPVILdUGgdBOCf25Q8t5NfSRVQYZw3be4cJ
 VUcYNAOT+/2UpHFZxkjehNUc5v5MLp3VvHQDdL/IImiWZtTYUJLH602EpUrFAtEfvLVU
 64b4cNpbY7i004/lHUm9/i9PMa4BcQggB2fPl4nVka/SVseDqcMCmtemXwc0cN7OTB4C
 9IBNBDfETRBzAr2fuwOM4L1fpRJIak66fem3r1pi4KmlRwZMLdx9vvimY/hN7YzsNMSG
 FWlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lCZiJAasgUT/Cw7q1qSUoP0EnmyEjUQL2HwtJPzgy+4cSfyLx2ovjdFJpD6HWTum9MWjtMck=@lists.denx.de
X-Gm-Message-State: AOJu0YyycPaZIGem4v2l5OpoRnk600G7FHyVaOFB3TvTxs+RY6qq55/a
 ifHr/tbRRemSk8HbNm7fUNaPA+P5zgf1twcVp+v+nK5IaArXB4dcejHWLpTgxJmIUVSvL+amn5e
 LIQwjj3D87W4CvPXO/Ie8fUafbY/ZUOgw6wHUxEZjsVftI4ndFSXxKwUT7ugfQXB/5K/gUN748A
 9zrUI=
X-Gm-Gg: AeBDietHBfC9KqU71sJaVM5xrm+jsrYvouK/NGVg+I/rsYXTM8aVYUIx01b2oP+uqFo
 kAZ55iIUi876aCALjfN2BcgqZvV60hx/CpaY/PTZ+7hMz3QWscEl6lCg4bsLgi197kUGMGbUasZ
 LUq1Fo4AN0ekWPSj/y81Z3yTx/Z+7NQ7ogmcYIT/keVKenG2nB20OPsGZ/fFMbLr9cn50KMRvLI
 NvZLYcgGU+7P9/eHWAKgxybhFz+K/goR3CKrqJLoYuxo29yaTaGNOwmE/DfNsJB+3vmLPP0W9ym
 hXyUf6NcDf9Bxr0pEgmHapRUNCPDLj06dNXqajEXkw8QG1eTHBuY888IOxMUFEzmd9CvLyX0yoS
 jA100/ZgtiGnzGQb6Aw7tEmEgx55/djquiHBehz2+AMNv7nuCx9AEo+dxfPUn+JOueQUuE77iKk
 QTjSdHTUFDbPfM4PgUvS3xyvN0CkmWarF7BDro4a/MZzPYgF7n0YEXhlHD8DIU
X-Received: by 2002:a05:600c:19d4:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-48a5339ef15mr263245035e9.3.1777035913618; 
 Fri, 24 Apr 2026 06:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:19d4:b0:48a:5339:ef0e with SMTP id
 5b1f17b1804b1-48a5339ef15mr263244225e9.3.1777035913044; 
 Fri, 24 Apr 2026 06:05:13 -0700 (PDT)
Received: from workstation5 (ip-176-199-115-125.um44.pools.vodafone-ip.de.
 [176.199.115.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489fec8f7cbsm309410985e9.11.2026.04.24.06.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 06:05:12 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: .clang-format description
Date: Fri, 24 Apr 2026 15:05:10 +0200
Message-ID: <20260424130510.275226-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

We cannot use .clang-format without modification. For instance U-Boot
has some for each macros that Linux does not have.

Adjust the description.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/develop/codingstyle.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
index 2a69162fa95..26881cf3900 100644
--- a/doc/develop/codingstyle.rst
+++ b/doc/develop/codingstyle.rst
@@ -80,8 +80,10 @@ Code Formatting with clang-format
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 U-Boot provides a `.clang-format` configuration file that was copied directly
-from the Linux kernel without any modifications, ensuring complete compatibility
-with kernel coding standards. Here are common ways to use clang-format:
+from the Linux kernel, ensuring complete compatibility with kernel coding
+standards.
+
+Here are common ways to use clang-format:
 
 **Basic usage for single files:**
 
-- 
2.53.0


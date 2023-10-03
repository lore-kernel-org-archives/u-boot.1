Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAACE7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D38C8726E;
	Tue,  3 Oct 2023 08:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hPP8zXoV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179A887478; Tue,  3 Oct 2023 08:37:14 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E6C287461
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5046bf37daeso611161e87.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696315028; x=1696919828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhHy/gbx5fgaYaEj2DSWQipG3mUbqExdYXyeqnr5XLs=;
 b=hPP8zXoVuJqGCXPIeSH5sfEDBlv4tIWiLyyogwNAN5UohEyG/ui4TdsDxn43ikjlac
 pJ/MzpUvWOxLBF0vI5mRm6jwtkR+6p4XIEwaJ/OTXUkUqMkBV8jTks0GEwt+lg04uh08
 ZNaL1mH6La6Zh1spqRVEFMgdWI675VbBS04M+AUjRLH+tGgVgCHKAByI0TEMvFIADhV5
 /cKnOLlYrCrW6zWK+tkqkL7mgphEFZq14NstCI7Q+C74bnDVSEFPWY+pooEwRNZ9tqtp
 Mf3SuiLbWjCS8hF+gaAj3+uk0DsWWuPKboh3S7V93Vt2tJ6eqQdJlI4Ei2czanjyupDc
 7XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696315028; x=1696919828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhHy/gbx5fgaYaEj2DSWQipG3mUbqExdYXyeqnr5XLs=;
 b=VVKlB2QskW4ElrclfAIFnkGKGFKjbw9V5Qzw05QV9/4Ow/6G+KAl+HriCm0f+pijkD
 NL4u6JzNggaJfae1G3NbWVoFZHPGgoR+u6F8Ft15pHEJyf51sma4xl7oeLbPhE9b6CVU
 WUyaPeb9gG3cWJFegKyxoz1fBmxe1ZeZ9sSWLwOWupGRv2oP7A/1JtuZYhJ1IcUhn+/z
 /ugoD+y4JH6NoC+ek17ONwQSaV0cbrPq9HhDSP+jBORqik34WtT7k0zx1JzcduNxFeTS
 N6Doq+y+e16wP/EPXDbattzVx0BzUmbaWqIgeuq2XbSSGgg4sb2U9pgBK354L+WHZuhO
 flIA==
X-Gm-Message-State: AOJu0YxBLBgViqUBTw8z/ZOqsYyxEo1VA5cjQ+DNbVHKc7/6mVLQzC/x
 JPvn39gcsE3zVd5+GHL9/RAMz6VXvdA=
X-Google-Smtp-Source: AGHT+IEhKdDzc7feUX3ytbqRjil/MNhyFN0+8vzuWHCx4BKXrwiv/yljkRkvm0Zu7syZEanyej9/Ow==
X-Received: by 2002:ac2:4f0b:0:b0:500:953b:d112 with SMTP id
 k11-20020ac24f0b000000b00500953bd112mr13281548lfr.27.1696315027701; 
 Mon, 02 Oct 2023 23:37:07 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 s1-20020a19ad41000000b00502b04e2722sm79636lfd.3.2023.10.02.23.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:37:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 16/16] board: asus: lg: move config fragments into device
 boards
Date: Tue,  3 Oct 2023 09:36:47 +0300
Message-Id: <20231003063647.42770-17-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003063647.42770-1-clamor95@gmail.com>
References: <20231003063647.42770-1-clamor95@gmail.com>
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

Move ASUS Transformers, Grouper, P895 and P880 config fragments into
their respective device directory in /board/../configs/

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/grouper/MAINTAINERS                             | 3 ---
 .../asus/grouper/configs}/grouper_E1565.config             | 0
 .../asus/grouper/configs}/grouper_PM269.config             | 0
 {configs => board/asus/grouper/configs}/tilapia.config     | 0
 board/asus/transformer-t30/MAINTAINERS                     | 7 -------
 .../asus/transformer-t30/configs}/p1801-t.config           | 0
 .../asus/transformer-t30/configs}/tf201.config             | 0
 .../asus/transformer-t30/configs}/tf300t.config            | 0
 .../asus/transformer-t30/configs}/tf300tg.config           | 0
 .../asus/transformer-t30/configs}/tf300tl.config           | 0
 .../asus/transformer-t30/configs}/tf600t.config            | 0
 .../asus/transformer-t30/configs}/tf700t.config            | 0
 board/lg/x3-t30/MAINTAINERS                                | 2 --
 {configs => board/lg/x3-t30/configs}/p880.config           | 0
 {configs => board/lg/x3-t30/configs}/p895.config           | 0
 15 files changed, 12 deletions(-)
 rename {configs => board/asus/grouper/configs}/grouper_E1565.config (100%)
 rename {configs => board/asus/grouper/configs}/grouper_PM269.config (100%)
 rename {configs => board/asus/grouper/configs}/tilapia.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/p1801-t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf201.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tg.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf300tl.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf600t.config (100%)
 rename {configs => board/asus/transformer-t30/configs}/tf700t.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p880.config (100%)
 rename {configs => board/lg/x3-t30/configs}/p895.config (100%)

diff --git a/board/asus/grouper/MAINTAINERS b/board/asus/grouper/MAINTAINERS
index 18b4f0641f..f4068d8562 100644
--- a/board/asus/grouper/MAINTAINERS
+++ b/board/asus/grouper/MAINTAINERS
@@ -2,9 +2,6 @@ GROUPER BOARD
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 F:	board/asus/grouper/
-F:	configs/grouper_E1565.config
-F:	configs/grouper_PM269.config
-F:	configs/tilapia.config
 F:	configs/grouper_common_defconfig
 F:	doc/board/asus/grouper_common.rst
 F:	include/configs/grouper.h
diff --git a/configs/grouper_E1565.config b/board/asus/grouper/configs/grouper_E1565.config
similarity index 100%
rename from configs/grouper_E1565.config
rename to board/asus/grouper/configs/grouper_E1565.config
diff --git a/configs/grouper_PM269.config b/board/asus/grouper/configs/grouper_PM269.config
similarity index 100%
rename from configs/grouper_PM269.config
rename to board/asus/grouper/configs/grouper_PM269.config
diff --git a/configs/tilapia.config b/board/asus/grouper/configs/tilapia.config
similarity index 100%
rename from configs/tilapia.config
rename to board/asus/grouper/configs/tilapia.config
diff --git a/board/asus/transformer-t30/MAINTAINERS b/board/asus/transformer-t30/MAINTAINERS
index c6c15323b2..071a9c04b8 100644
--- a/board/asus/transformer-t30/MAINTAINERS
+++ b/board/asus/transformer-t30/MAINTAINERS
@@ -2,13 +2,6 @@ TRANSFORMER BOARD
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 F:	board/asus/transformer-t30/
-F:	configs/p1801-t.config
-F:	configs/tf201.config
-F:	configs/tf300t.config
-F:	configs/tf300tg.config
-F:	configs/tf300tl.config
-F:	configs/tf600t.config
-F:	configs/tf700t.config
 F:	configs/transformer_t30_defconfig
 F:	doc/board/asus/transformer_t30.rst
 F:	include/configs/transformer-common.h
diff --git a/configs/p1801-t.config b/board/asus/transformer-t30/configs/p1801-t.config
similarity index 100%
rename from configs/p1801-t.config
rename to board/asus/transformer-t30/configs/p1801-t.config
diff --git a/configs/tf201.config b/board/asus/transformer-t30/configs/tf201.config
similarity index 100%
rename from configs/tf201.config
rename to board/asus/transformer-t30/configs/tf201.config
diff --git a/configs/tf300t.config b/board/asus/transformer-t30/configs/tf300t.config
similarity index 100%
rename from configs/tf300t.config
rename to board/asus/transformer-t30/configs/tf300t.config
diff --git a/configs/tf300tg.config b/board/asus/transformer-t30/configs/tf300tg.config
similarity index 100%
rename from configs/tf300tg.config
rename to board/asus/transformer-t30/configs/tf300tg.config
diff --git a/configs/tf300tl.config b/board/asus/transformer-t30/configs/tf300tl.config
similarity index 100%
rename from configs/tf300tl.config
rename to board/asus/transformer-t30/configs/tf300tl.config
diff --git a/configs/tf600t.config b/board/asus/transformer-t30/configs/tf600t.config
similarity index 100%
rename from configs/tf600t.config
rename to board/asus/transformer-t30/configs/tf600t.config
diff --git a/configs/tf700t.config b/board/asus/transformer-t30/configs/tf700t.config
similarity index 100%
rename from configs/tf700t.config
rename to board/asus/transformer-t30/configs/tf700t.config
diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
index 0ad29563e9..13c8588d0b 100644
--- a/board/lg/x3-t30/MAINTAINERS
+++ b/board/lg/x3-t30/MAINTAINERS
@@ -2,8 +2,6 @@ X3 BOARD
 M:	Svyatoslav Ryhel <clamor95@gmail.com>
 S:	Maintained
 F:	board/lg/x3-t30/
-F:	configs/p880.config
-F:	configs/p895.config
 F:	configs/x3_t30_defconfig
 F:	doc/board/lg/x3_t30.rst
 F:	include/configs/x3-t30.h
diff --git a/configs/p880.config b/board/lg/x3-t30/configs/p880.config
similarity index 100%
rename from configs/p880.config
rename to board/lg/x3-t30/configs/p880.config
diff --git a/configs/p895.config b/board/lg/x3-t30/configs/p895.config
similarity index 100%
rename from configs/p895.config
rename to board/lg/x3-t30/configs/p895.config
-- 
2.39.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B289E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9097680304;
	Wed, 18 Dec 2024 16:54:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zWtgjRSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BFC80312; Wed, 18 Dec 2024 16:54:24 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC838022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso68957615e9.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734537261; x=1735142061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GT1vHcgT5ZCeYIZlNTu7kydDcBrhOwED+EnNq6snnlI=;
 b=zWtgjRSkHQWBxOEAMuJAFVwhaLx8O3SLQevajCMwm/vK8ZIr8GJhErI3dwqvYOT/qk
 96p+xH27LqWZ9PLNjSO1hIxoo2OYvHKl3gw0eAObt2U7FG9cmJOxC+sVPZoRUB62j/Yt
 8MwPvq5W3cAfx7eLWGvnykP+TkrNLskTUuIZdutEEWyVS39/ZS7fcFb8Scakxa6OVCnn
 rq9RT4x1yTs6mABbbpsor4pgecXLjlELGB5xE+0YBVFbmJWQ7DbBZa4lNOhsnOWbm7cB
 CsR50vzAezA3nA+ZSKqVSq+cZG0JQmxYzzvXItBOKqHkOt9yamHZPEO/rHJAXJ+B7i9V
 xSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537261; x=1735142061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GT1vHcgT5ZCeYIZlNTu7kydDcBrhOwED+EnNq6snnlI=;
 b=R7+i7ozb6ZdDafjlleSV5p1ux8F0yAwb4nl8s3gIQGBFM5fJWYpeJzL7UbasmUjnpc
 B1QfFVpCNw/FEcLEdYW0aTgOKqDIJnXf3AvzMwxBf7F0H+yqVBmy4o7kQRyo7P57jfpy
 o2TP3+qAOJT+cmBJPa8cDrXZAGZrP787Te0Fo3A3vz2J3tKbbEvXVNYPIgGXlSEHQdcs
 CVJn2K712hkLaOwfiFMBmuZbGR95+dEWrNtPNtST6dv9g9bw+RI7XGhHQuiASwVUteXu
 DIGV05og8mfvx4vL97aS73AVyC9ki5V1GBt8h1Y0VjsmNUaqkgSeIUctPUod7XCXyv1P
 UIuA==
X-Gm-Message-State: AOJu0Ywj8wCO2XXrbPYIDZFqoqj0ohwivqY1SxBqAGX7Tu3Bcg30bMe2
 r2SnYdsl2MNbhCCNqv5dSfO8E3xRhHfhoGOz+ph92vnf1sGYHdikvBceMhp7D4gblXTrLoujl0p
 y6js=
X-Gm-Gg: ASbGnctVdlcaNRURHAqMz/2g0FFX7aA1uvJASy6YIK9exBnnD3EqN8K1PMuEHioLP8v
 3atDHxYvGu8dvzuOAEiCEodPbnvplLTN/Pi5n2FdqvJUZgmwsUOlKonoa3lliehb9IBjsQdvMjI
 29BvTSKeQuamI/8OKUKi/tD4L0wDe001oROUHbMhuOFNBI/+5lYbdy8AECSTQQCN1MfF2fvxkVj
 NttiT8t4tUgIqfoMGpYK91w1uEk6XVsC+lBqzu0jvKVG4Xmmr9t/0W72thM9OLnFg==
X-Google-Smtp-Source: AGHT+IHxgO9boawWaBbIfI1Qb1fNxkicQSLphcaf+8fuz65T+wvyX5piMR6R3WYtMpRWQnGSP8ilbw==
X-Received: by 2002:a05:600c:4586:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-4365534535bmr29473485e9.5.1734537261376; 
 Wed, 18 Dec 2024 07:54:21 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc125sm25181705e9.6.2024.12.18.07.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:54:21 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/5] board_init_f_r(): use static calls
Date: Wed, 18 Dec 2024 16:53:56 +0100
Message-ID: <217af7ee46d45348bb825caafa20bd91f18ff957.1734537135.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734537135.git.jerome.forissier@linaro.org>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
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

Replace the init_sequence_f_r function array by direct calls.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 common/board_f.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index cebed85ed4d..f47275a2230 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -1016,8 +1016,8 @@ void board_init_f(ulong boot_flags)
 /*
  * For now this code is only used on x86.
  *
- * init_sequence_f_r is the list of init functions which are run when
- * U-Boot is executing from Flash with a semi-limited 'C' environment.
+ * Run init functions which are run when U-Boot is executing from Flash with a
+ * semi-limited 'C' environment.
  * The following limitations must be considered when implementing an
  * '_f_r' function:
  *  - 'static' variables are read-only
@@ -1030,18 +1030,14 @@ void board_init_f(ulong boot_flags)
  * NOTE: At present only x86 uses this route, but it is intended that
  * all archs will move to this when generic relocation is implemented.
  */
-static const init_fnc_t init_sequence_f_r[] = {
-#if !CONFIG_IS_ENABLED(X86_64)
-	init_cache_f_r,
-#endif
-
-	NULL,
-};
+static void initcall_run_f_r(void)
+{
+	CONFIG_IS_ENABLED(X86_64, (INITCALL(init_cache_f_r);))
+}
 
 void board_init_f_r(void)
 {
-	if (initcall_run_list(init_sequence_f_r))
-		hang();
+	initcall_run_f_r();
 
 	/*
 	 * The pre-relocation drivers may be using memory that has now gone
-- 
2.43.0


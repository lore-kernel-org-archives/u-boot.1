Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC39CF58E2
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09041893B8;
	Fri, 20 Sep 2024 09:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kL3X8ev5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C523893C0; Fri, 20 Sep 2024 09:25:11 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 748C0893CA
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso14197715e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817106; x=1727421906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cAqMOdVkPXMZkqYPqQrvePRcBkZSMjsPsIe0sheqGs=;
 b=kL3X8ev5ixtlnbuvKaK2wz2Z9J2DhPHy3HngtopcARL/ra6Z9lKDU/FuRvxHOwk+Qv
 +RjoCoybIYOQqdJi85yZlv552RsufQnsBwDvuXIcKTKpJu1bO7P5gmV6s8yWzEZE+gi+
 mcvxPdvzTfHRZ7uBfaiAhUxUYwNIusBmYpV+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817106; x=1727421906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cAqMOdVkPXMZkqYPqQrvePRcBkZSMjsPsIe0sheqGs=;
 b=QoWQqUd6dLngsl9+aeegQ4Kxw1rtUG9wf/qMtXNV2Te4ktdvMxtvlCRZfwWf051zR/
 fTFTjIprY6FwhzA/umn0ylxv5LUQa/w9vQIBbFqm3MsFbVmV2dOi8/xo+F3NVdGVR2DI
 QLtqRLlnl5zYUBgJatWDzdyaJUgetxLwrusTZV79N1mbQ41BBgy/1E2vYeg2hR+0weKW
 o2Q99bkX534JvKG3ruh3qorXCLBfcXxzgbiwzb9PO8wFPc+4dFkv1z3WHek9D0QYjbfN
 prpT8b5qfTfJmaWvy+mO8bzZD0mVzdSgIMLoE+NbnMcXPFwv3BjcgkS6FWkaKum0LL2N
 OShw==
X-Gm-Message-State: AOJu0YxjnPz+F4SDB5Xb8W5uKczXZOeowTWHnK7bsKbKkU7yHVtVbs/0
 nHol91kGyYODP8XMfirVeAhGlDh/K1P1e+DOmD9Aj4enpDvj/Ru7xNbL/+8lqWih/OfNTRNPq3P
 uG78u
X-Google-Smtp-Source: AGHT+IGh1dWRCgI04WrehEA/F1XtqLR9EO0q2CpDCvotJHea0gbZV0apLA5+xQWJn2/y9mel3VYkBw==
X-Received: by 2002:a05:600c:548e:b0:42c:b7e2:3bc3 with SMTP id
 5b1f17b1804b1-42e7ac244f3mr11714665e9.19.1726817105361; 
 Fri, 20 Sep 2024 00:25:05 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 "Gaskell, Oliver" <Oliver.Gaskell@analog.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/18] tpl: Support numbered aliases in device tree
Date: Fri, 20 Sep 2024 09:24:30 +0200
Message-ID: <20240920072444.134997-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Add an option so that this feature can be enabled in TPL for boards
which need it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index c39abe3bc94..6b4330fe4ea 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -152,6 +152,14 @@ config SPL_DM_SEQ_ALIAS
 	  numbered devices (e.g. serial0 = &serial0). This feature can be
 	  disabled if it is not required, to save code space in SPL.
 
+config TPL_DM_SEQ_ALIAS
+	bool "Support numbered aliases in device tree in TPL"
+	depends on TPL_DM
+	help
+	  Most boards will have a '/aliases' node containing the path to
+	  numbered devices (e.g. serial0 = &serial0). This feature can be
+	  disabled if it is not required, to save code space in SPL.
+
 config VPL_DM_SEQ_ALIAS
 	bool "Support numbered aliases in device tree in VPL"
 	depends on VPL_DM
-- 
2.43.0


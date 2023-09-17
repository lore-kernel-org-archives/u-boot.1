Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5C2CD13D1
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 19:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62E086545;
	Sun, 17 Sep 2023 21:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gT8W0RyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D00B78654B; Sun, 17 Sep 2023 21:26:53 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B043A86758
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 21:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=abbaraju.manojsai@amarulasolutions.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c43b4b02c1so12806565ad.3
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1694978810; x=1695583610;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0f2I7WwiAlncznTiAR0FCDCIMo+PQqiVyW2A56fHXI=;
 b=gT8W0RyVyarZFHiy68JkBA8ZrofEtajWWtsuTHdLvNVjF7wuK4n34r+ueu4C5tpHga
 yTAtg9O3fBz9gi9ziJn4qnof0YjNGWNoMPnydP30BQKGcqWCHEwaD5NbcWgsvSvu2Akx
 dJtsejvQTaip/ISo0yUaMtjKFqL+CQ2nE1IVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694978810; x=1695583610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0f2I7WwiAlncznTiAR0FCDCIMo+PQqiVyW2A56fHXI=;
 b=O2USIQ9v21MWzXoUPDLsE/SuCnlpNKK35bTWfQgGOY+6QOf3UAcJen4Mkpq5siBhcu
 8FBRb2DQGYh2rlEG9bsIe5zMXiXM/5+FoESF+eUl7t2zAmKr02bbFXwgR8+8yRxTyCjJ
 eig9X0QOT00HToNeJYfEKcuatMhK31/d+PKI84+vkUmL2E6Q+CyEk9jnReqwSM09Ti+a
 BS4CCbn5WDYCLX9ozjn6QV0I93Rlgju5LaBD9CDfibTBriyAGtLoeq66NjtypIbN+sE5
 s0+5Us+44LOzPdHeDtU6odpgF8yfXL6Fwwlg58CRQxr1Q4BCbjv8m3fz2y/x5vg9EWGI
 PIxw==
X-Gm-Message-State: AOJu0YyT7ppdpcTOcFqyj92v/enH59aPKAuU2Df/q8jYPghe+hJ0p2FQ
 j+mjGab+p42Ka0SZ4eKTqN3I0w==
X-Google-Smtp-Source: AGHT+IGcC4V8TiX5EjHFedH2uWmm2APM7teevZfT1XgrryB9AWUkGHE+dyH3T00nlTd0huddISr6bw==
X-Received: by 2002:a17:903:24f:b0:1c3:52ed:18f9 with SMTP id
 j15-20020a170903024f00b001c352ed18f9mr6560899plh.62.1694978810110; 
 Sun, 17 Sep 2023 12:26:50 -0700 (PDT)
Received: from localhost.localdomain ([49.204.31.54])
 by smtp.gmail.com with ESMTPSA id
 iw7-20020a170903044700b001b83e624eecsm6976991plb.81.2023.09.17.12.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 12:26:49 -0700 (PDT)
From: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: dsx724 <da@lessconfused.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH v4 4/4] rockchip: Add support to generate LZMA compressed
 U-boot binary
Date: Mon, 18 Sep 2023 00:56:28 +0530
Message-Id: <20230917192628.363502-5-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
References: <20230910182448.285542-1-abbaraju.manojsai@amarulasolutions.com>
 <20230917192628.363502-1-abbaraju.manojsai@amarulasolutions.com>
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

Add support for generating a LZMA-compressed U-boot binary with the
help of binman, if CONFIG_SPL_LZMA is selected.

Signed-off-by: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
Changes in v4:
 - None

Changes in v3:
 - None

Changes in v2:
 - New patch for v2

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8f248f941f..c8c928c7e5 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -58,6 +58,8 @@
 #endif
 #if defined(CONFIG_SPL_GZIP)
 					compression = "gzip";
+#elif defined(CONFIG_SPL_LZMA)
+					compression = "lzma";
 #else
 					compression = "none";
 #endif
@@ -66,6 +68,8 @@
 					u-boot-nodtb {
 #if defined(CONFIG_SPL_GZIP)
 					compress = "gzip";
+#elif defined(CONFIG_SPL_LZMA)
+					compress = "lzma";
 #endif
 					};
 #ifdef CONFIG_SPL_FIT_SIGNATURE
-- 
2.25.1


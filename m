Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C27C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026F6876C2;
	Fri,  8 Dec 2023 23:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nX+WBqUI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B638768A; Fri,  8 Dec 2023 23:31:11 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7646987695
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c256ffdbcso26856115e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074666; x=1702679466;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ismp48oEL6JutAwHlMCruy7oPdpEnb4dUu6uMukT8U4=;
 b=nX+WBqUIIhxeYXRycnopARmQfYnE1x+bi+S1F4TXiWDbSRID5tY5qZ4hY1Nwiz8XVD
 z5IzKdb/e+2XHsbMrMPor9kM6OTAThF4DdVBS523NXVSSf2FefjtKBW27LZo4pIurj6p
 pFRjJtNgcmfFoLII3sXneF0CjxN+1DWS/cjMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074666; x=1702679466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ismp48oEL6JutAwHlMCruy7oPdpEnb4dUu6uMukT8U4=;
 b=xBgChKOLkr2QSYqOojfKBUPVANNrBySZQNmRQJCr4b9RMTz8YULWJ6q+coae50wSEO
 e901CucyEsbB5lS1An411LYnZ1cJgIj8OKlIJMpC00f76HZLuC8MYkwhTfysleXNBtC3
 EoyQmpY6OEP/BlPX+RF9xf2WZ0wXzBGlWwnXTRvSkaPTImcHHOUOiCQ8vXALUihAa+f0
 WVAg5FIbOckn8K2snJDuF/IK8pKYD8bIbZZAMx7A5XZjpjsc3jVvd4TtzNOxM2U0ZSEX
 ufdG1dPEo9mEoiSMHZGoRNTXwX7OW5XyalFEz7i+dZQNdQKB2YuzkLZ6lK17BNFkO9PX
 0V9g==
X-Gm-Message-State: AOJu0Yx/MDgNIh8D/wbql6awAah9RPmAjO3y3Wqe7tgNg0g45XtxME9C
 slhlVXtq+z3nA40N3xZEsyLikBjS8P30R7WV12ToZA==
X-Google-Smtp-Source: AGHT+IF0g1m3KUU8g5fYX5QZdt15NbfFoXvj51QEfsV3wSJghu3WzDdJJAit26J1i3sLtJ3xnKTsPQ==
X-Received: by 2002:a05:600c:44c7:b0:40c:246c:bd70 with SMTP id
 f7-20020a05600c44c700b0040c246cbd70mr342979wmo.91.1702074666009; 
 Fri, 08 Dec 2023 14:31:06 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:05 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Roger Knecht <rknecht@pm.me>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v12 09/24] cli: Add menu for hush parser
Date: Fri,  8 Dec 2023 23:30:10 +0100
Message-Id: <20231208223025.55076-10-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

For the moment, the menu contains only entry: HUSH_OLD_PARSER which is the
default.
The goal is to prepare the field to add a new hush parser which guarantees
actual behavior is still correct.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Kconfig     | 13 +++++++++++++
 common/Makefile |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index df6d71c103..30ea081a10 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -23,6 +23,19 @@ config HUSH_PARSER
 	  If disabled, you get the old, much simpler behaviour with a somewhat
 	  smaller memory footprint.
 
+menu "Hush flavor to use"
+depends on HUSH_PARSER
+
+config HUSH_OLD_PARSER
+	bool "Use hush old parser"
+	default y
+	help
+	  This option enables the old flavor of hush based on hush Busybox from
+	  2005.
+
+	  It is actually the default U-Boot shell when decided to use hush as shell.
+endmenu
+
 config CMDLINE_EDITING
 	bool "Enable command line editing"
 	depends on CMDLINE
diff --git a/common/Makefile b/common/Makefile
index cdeadf7202..23851a68e2 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,7 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
-obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
+obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
 # # boards
-- 
2.34.1


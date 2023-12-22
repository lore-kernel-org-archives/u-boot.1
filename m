Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A80C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063C087863;
	Fri, 22 Dec 2023 22:03:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="f7LlEWDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC658784D; Fri, 22 Dec 2023 22:03:32 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A2A877BC
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d352c826eso27057065e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279000; x=1703883800;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7UTWC12KI6C3dj8uWKOWXZ7qA9DGYhv3pylwBy0So4=;
 b=f7LlEWDBUyklKpoYchiavGvEuRH4VaQJiq7068PbLKgo5W2Rt+nnZrBpm3UYPqbvH3
 sbDNCbSrkYmTIpJmT0is6vV2MwbVq3OnN+4K6Wu9nOiWy5R99SviYpEHadAH4DFhW7RY
 SG87GUUs9XLQCNPP00coDb3wzWCSr682SAwBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279000; x=1703883800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7UTWC12KI6C3dj8uWKOWXZ7qA9DGYhv3pylwBy0So4=;
 b=kNw8MmiZpeit6n5btkIi96NAH6OF+dzvwKdmPQcMizaCmUbA40xtPJz4O/dlVth00y
 je9TZaSeu+gtccn3zPvZMaC4OzOk7gF/CLgiPEr2w8/yOou7JLoHPszjMbQBS9J8HBnd
 k1v3V3BgD7MmRwUdphKt+YH0MBjet6x1cH3Y/J9jlkz4PwdXGa61uSV/0higXf+OXDa7
 sAiKYcsLLAGL8PqWSaG9lqE8LZ3Rr1ZBMnzwrOrzjKFU8rPslUT2/refmHKWWw9QdsDc
 124TJ6/jog8tQy7PmL0UJeR/N2L303+zYhkLsRUIVl3ALpNOCUJKFHTpeDW2svV3RV31
 JwPw==
X-Gm-Message-State: AOJu0YwJqn6HvnvZ6F1cKVOk/Nhm06jhZ30bxsUuZYBR7qunzt9JMCMa
 DayNmEDRqdD0qnnzvOjFbQ+VbLIG6vtYZDKoPvuEQ7irIo8=
X-Google-Smtp-Source: AGHT+IHJ3o0TSP+OzGdZoJniAalkGiYGEMVnWYiRSjbD4xdA1IsI3B7eIlo5sfoetX72VBNAArfZzA==
X-Received: by 2002:a05:600c:5407:b0:40d:355e:ab76 with SMTP id
 he7-20020a05600c540700b0040d355eab76mr1380929wmb.49.1703278999952; 
 Fri, 22 Dec 2023 13:03:19 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:19 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Roger Knecht <rknecht@pm.me>, Devarsh Thakkar <devarsht@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v13 09/24] cli: Add menu for hush parser
Date: Fri, 22 Dec 2023 22:02:29 +0100
Message-Id: <20231222210244.91830-10-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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
index 5a7678f0ac..15715ac6ad 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -22,6 +22,19 @@ config HUSH_PARSER
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
 	default y
diff --git a/common/Makefile b/common/Makefile
index 1495436d5d..3bb33b4e36 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -9,7 +9,7 @@ obj-y += init/
 obj-y += main.o
 obj-y += exports.o
 obj-y += cli_getch.o cli_simple.o cli_readline.o
-obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
+obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 obj-y += version.o
 
-- 
2.34.1


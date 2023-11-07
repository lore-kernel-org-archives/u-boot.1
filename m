Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A3CC04A92
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0613B87653;
	Tue,  7 Nov 2023 22:42:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pEBpHOGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3C787687; Tue,  7 Nov 2023 22:42:14 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB7378764E
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso3779092f8f.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393326; x=1699998126;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFz8XJ9Y1inDKhAcFYZqXosMA6iRMWtvjunu2reo0kg=;
 b=pEBpHOGRCbfeXCwjx/jAlwFqKj0ZXthOg36M2v8WX9Ffu9+mhg+DBoIzsZkvK0OD3w
 SSRK9VX2cdvh9bh6DhcBidxmzNNnEylkMyX24H2m84ch7vHjnNg6Ntu4SNmHRHY/Ku1v
 ZFYUTZKG4txLhvWvg/w8lARRdTEhe/f6/8ELA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393326; x=1699998126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFz8XJ9Y1inDKhAcFYZqXosMA6iRMWtvjunu2reo0kg=;
 b=l1n4Osj3XfstRlBUl6VlWhmf4WtGcn+H9Hfxs4TpXC3NvcBqxKIQPKXUHUfKC6jUe2
 uqxl/RS+rpe14GAFh6ElpfUDdUbkv1FLAlvMLnBMUwuGQimvQej2dJcm9gI5K8QshBtj
 ZQvNBYSJsdmCxy87yw3ENZcZac/uOsRf84THuOareBjr+tJrSUmIF87zCDM0YuP/kN5+
 ve/NqCdAU/wh6SH2YWscDgUsG8btyKMJ9+J7kqv8NDs2HgbO4SUFIpbslCHOE+CXfYFB
 Ol94OpqxuDTazaOlOIriXv7jhpyQtaCi2bznVHIf+Mq4izkx/wuDM4MEQSNSqNp8ktvl
 +KaA==
X-Gm-Message-State: AOJu0Yxs7XTP8TeXe75zCNJNocG/SaNNWUbvVGjBrxtpyQk2s1SQJQ16
 k6rF5QILCdpSTffojE9ftBg0jUIlDWK4KgwxQmA=
X-Google-Smtp-Source: AGHT+IHi3ZqUTYFtUGboFMsFKPjph7v/S8cu/M14wpGGrSBwA26hmu76os7aALvuxfr2eRyANHII+w==
X-Received: by 2002:adf:ebc3:0:b0:32d:96dd:704d with SMTP id
 v3-20020adfebc3000000b0032d96dd704dmr31618wrn.18.1699393326250; 
 Tue, 07 Nov 2023 13:42:06 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:06 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ramon Fried <rfried.dev@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 John Keeping <john@metanate.com>, Michael Walle <michael@walle.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v11 09/24] cli: Add menu for hush parser
Date: Tue,  7 Nov 2023 23:41:06 +0200
Message-Id: <20231107214121.132079-10-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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
index fd16c3a48e..f3a00ee59b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -23,6 +23,19 @@ config HUSH_PARSER
 	  If disabled, you get the old, much simpler behaviour with a somewhat
 	  smaller memory footprint.
 
+menu "Hush flavor to use"
+	depends on HUSH_PARSER
+
+	config HUSH_OLD_PARSER
+		bool "Use hush old parser"
+		default y
+		help
+		  This option enables the old flavor of hush based on hush Busybox from
+		  2005.
+
+		  It is actually the default U-Boot shell when decided to use hush as shell.
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


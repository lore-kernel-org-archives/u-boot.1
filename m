Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB42EC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339DF869D0;
	Tue, 15 Aug 2023 00:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dUHJnX7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2369869A2; Tue, 15 Aug 2023 00:41:27 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DD48662F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34992fd567bso9843905ab.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052884; x=1692657684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nPC7MGRSkmOVzRh2gVawNvjMC0yQxP/asyV6TlAk4g=;
 b=dUHJnX7V6ob1Jwqcysh5as8Xq2/VmSp2jAGOtpzYjZZP0oqEsC1hVpitrJqKK++cSu
 MN/aukBh9U2WVCJVhcnI5QyZ+aNYb4a9/A+xgCAkPhfDp3HNrlljX6xoivXDmqicnOe3
 sDzzF2Ss7Ngi1auOE6fv6tWSFvXOqD6VT5XrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052884; x=1692657684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nPC7MGRSkmOVzRh2gVawNvjMC0yQxP/asyV6TlAk4g=;
 b=GrD+/Td2ZWBYbTuIsaYf3QgywAxTADj9SFidxtrszmWRO+Q2s8ycwBk8NLerj59Zw3
 T64Y880t8ap9Xha7jvijMSIi3HxrRb6a6LSlDMR/AhXy23UuZfPVnlpqYxRB/JHwCIZU
 KhHeyPHpRqjVwCu1/YbrUJE+LIsotQKK1PE+DySWuhB2BbOVZw1ck7Ij1BRMn5rzJ9zH
 UC9C6UgZlBwJh8EXsCSUhdrMZRyD9t1fVxg14nTIRMr5kb+rmwKacajv79nHYbYvh1A9
 ofmFqrb3g3UXUVbJI2ggGKKp+p6Lcy/H1RDOt0h2qmksAZ+l+6kqttS37gNafoRvHMC7
 1JtQ==
X-Gm-Message-State: AOJu0Yw/gHdeqn7t4XqfVBCBjISFV66DEoxN7ZfiTjJlOhflz6vswnP+
 ukWTpS8+5p3SGS8Tk6FVGq6Jog6wzsRdTP4Ko1c=
X-Google-Smtp-Source: AGHT+IEJHnnPvEoGZJbonpfx4q57uHOGzbSUdiz4/45ttnDc00Jkz0MaV+TP9fcV5HdSmm28oYjw9g==
X-Received: by 2002:a05:6e02:1567:b0:34a:8bb5:8736 with SMTP id
 k7-20020a056e02156700b0034a8bb58736mr368395ilu.12.1692052883979; 
 Mon, 14 Aug 2023 15:41:23 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robimarko@gmail.com>
Subject: [PATCH 10/19] expo: Move cedit theme under bootstd
Date: Mon, 14 Aug 2023 16:40:30 -0600
Message-ID: <20230814224047.535491-11-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

This is related to standard boot, so put it under the same node. This may
simplify schema upstreaming later.

Mention themes in the documentation while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/sandbox.dtsi | 12 ++++++------
 arch/sandbox/dts/test.dts     | 12 ++++++------
 cmd/cedit.c                   |  2 +-
 doc/develop/cedit.rst         |  7 +++++++
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index f0ee0b3481ac..4a0a5e847bef 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -16,12 +16,6 @@
 		stdout-path = "/serial";
 	};
 
-	cedit-theme {
-		font-size = <30>;
-		menu-inset = <3>;
-		menuitem-gap-y = <1>;
-	};
-
 	alarm_wdt: alarm-wdt {
 		compatible = "sandbox,alarm-wdt";
 		timeout-sec = <5>;
@@ -36,6 +30,12 @@
 	bootstd {
 		compatible = "u-boot,boot-std";
 		filename-prefixes = "./";
+
+		cedit-theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+		};
 	};
 
 	buttons {
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b5509eee8cfe..9641776c8ba8 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -100,6 +100,12 @@
 			menuitem-gap-y = <1>;
 		};
 
+		cedit-theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+		};
+
 		/*
 		 * This is used for the VBE OS-request tests. A FAT filesystem
 		 * created in a partition with the VBE information appearing
@@ -144,12 +150,6 @@
 	cedit: cedit {
 	};
 
-	cedit-theme {
-		font-size = <30>;
-		menu-inset = <3>;
-		menuitem-gap-y = <1>;
-	};
-
 	fuzzing-engine {
 		compatible = "sandbox,fuzzing-engine";
 	};
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 5f0e84403f5b..e98121b067b2 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -65,7 +65,7 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	node = ofnode_path("/cedit-theme");
+	node = ofnode_path("/bootstd/cedit-theme");
 	if (ofnode_valid(node)) {
 		ret = expo_apply_theme(cur_exp, node);
 		if (ret)
diff --git a/doc/develop/cedit.rst b/doc/develop/cedit.rst
index 48262ee535e9..8f0a554ae918 100644
--- a/doc/develop/cedit.rst
+++ b/doc/develop/cedit.rst
@@ -145,3 +145,10 @@ Multiple scenes
 Expo supports multiple scenes but has no pre-determined way of moving between
 them. You could use selection of a menu item as a signal to change the scene,
 but this is not currently implemented in the cedit code (see `cedit_run()`).
+
+
+Themes
+------
+
+The configuration editor uses simple expo themes. The theme is read from
+`/bootstd/cedit-theme` in the devicetree.
-- 
2.41.0.694.ge786442a9b-goog


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC3C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CBD1887FA;
	Fri, 31 May 2024 16:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkXSY4R6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEFA885AF; Fri, 31 May 2024 16:19:38 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A085887FE
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6c4f3e0e3d2so416196a12.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165175; x=1717769975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V63+QeNpTW4Hq8F3+NUxSgNyjya/yidEOAqORUNFwiE=;
 b=DkXSY4R6NE+b2HtxKvS179I1WALR3d6m4x09THRrRws/geaI3glk1ViaMQIiLGOOHt
 KIr/juVsyuGM1lkZuy5eP+fesaaxz+WMoalkb026wzL2YsKNCb8rK7W8BQOd6zIo+VRk
 mI/l+l823yHtGSOXcqB1AdTRlaM49k1IPG1Nm6T8HQEJy6sqA1gUiaux0q3VFL+Vrrfr
 h33Ubr0N1BLEbH1huMPfjbPrao90QPrb9qBeG4oasIPJubibqQajkYsfeBVn4m1hRx/V
 ObC9xaeSdMnQfgZEAVtjQ7nBu6cKoAOwFkvoaxgxkdIRW9sTGxI78XhDxhYwOKfBf54j
 oX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165175; x=1717769975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V63+QeNpTW4Hq8F3+NUxSgNyjya/yidEOAqORUNFwiE=;
 b=JOeHCOH7UxqyzSvVHxagNZp60jniIm6XLJEvtP835nMy2gayn/FgElFoQusx1Dm/Y4
 +pLBc0vJmKogOBMhqfBZ5jg7jkgqpR2Tu/C3i3jwq3fT63Rv4pa0cTlhK0jgONxzkeaJ
 53s714RB8E0dxsLKw9AbSxsQua/Cw0YyBiVnRF2juGQnYR5N3jtIJUUqsAGyCLJteUhO
 XDrZHtsrY8fc7Fzg+g1h3MATtaTXpmyIgbXnCFnwxB+gXHnzD3OYtaUkOK7V0zd1CKRo
 VYUGH/Jlextz9sFbABtALJwCQMRYUIPca1EibZE7od+C0y4TAWHlSOrSXAIJM/exowx1
 RjOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSfKJInNrBjWfmQNe+9pvofOOIG/Xg31nuExKdXaSIPbYweWdffOTi6cxLX2XOjjBEU1jEAmHG3mirRGMZYevRArt+qQ==
X-Gm-Message-State: AOJu0YzZSlsqo9EMa8ZgBErlob2yIx0PsoEN8cP4mGEh6uJxHsjrzBvj
 pi+xl3RBJGmziPQdGaJFPij2etteuPPeqLp7zcZBZ4k3ovJvWpAg
X-Google-Smtp-Source: AGHT+IGhkX4v7d0HVpqOoauCcMbzsX/292A7mhdJT0jTas6DdGnSIaV7XcpREU40RhoJ9fLUohq2KA==
X-Received: by 2002:a17:90a:4583:b0:2a0:9b18:daf with SMTP id
 98e67ed59e1d1-2c1dc5cd706mr2088320a91.42.1717165174721; 
 Fri, 31 May 2024 07:19:34 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:34 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 13/23] rockchip: RK3288: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:27 +0530
Message-ID: <20240531141837.13189-14-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Enable DISPLAY_CPUINFO options to support on all RK3288 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/chromebit_mickey_defconfig  | 1 -
 configs/chromebook_jerry_defconfig  | 1 -
 configs/chromebook_minnie_defconfig | 1 -
 configs/chromebook_speedy_defconfig | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index e5d805d7da..e1d31d0b4c 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -31,7 +31,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-mickey.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index 9bc59539dc..dba1466689 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -30,7 +30,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-jerry.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 26fa05e543..e6cf734b14 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -31,7 +31,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-minnie.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 5deb09b28e..90364dfc48 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -31,7 +31,6 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-veyron-speedy.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_LOG=y
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
-- 
2.44.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC098ECE58E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 23:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08AF688EB5;
	Tue, 10 Sep 2024 01:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lGPDSre0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F1188EB6; Tue, 10 Sep 2024 01:45:53 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C6C88E4E
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-160-200.46.114.pool.telefonica.de
 [46.114.160.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 420A440DC3; 
 Mon,  9 Sep 2024 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1725925550;
 bh=1mX5N3mhbFJjpuQp5lsbtmcyBPG14h+On8xpm4pga3M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lGPDSre0ZLv153AAFYJzcv0N8GPU0UrNGcWk9P2sb3ZB5JifS0yfmHc0vicnUmUTe
 +sFav+rjda/zMA8pyrUW7x69sNN67FuNOpJAkm9cgh5rdHRW/OTWrg5BCHrfcVESW+
 AfJygWopXnHvFgdEnIorE4ZFTAzUHGjt++W4MRmDRS0HzwLgtk4iyflLalm/DT4SZ8
 6qW4y0oxTbf1uGHt27lHrgWAugXrJQqf8gX1bytDQbrx2rNzLTsjt/YI7rcAXzhWPP
 vwzsJqLbJC1F3mVuyZPLaFurZogHQxWGPZqKtAh73si7WutLAwKpdgRS5SGpvoUhSA
 huiwyeoCyqNXQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Igor Prusov <ivprusov@sberdevices.ru>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] sandbox: enable clk command on the sandbox
Date: Tue, 10 Sep 2024 01:45:30 +0200
Message-ID: <20240909234530.27570-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909234530.27570-1-heinrich.schuchardt@canonical.com>
References: <20240909234530.27570-1-heinrich.schuchardt@canonical.com>
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

Enabling the clk command on the sandbox will allow us to write tests
for it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/sandbox64_defconfig        | 1 +
 configs/sandbox_defconfig          | 1 +
 configs/sandbox_flattree_defconfig | 1 +
 configs/sandbox_noinst_defconfig   | 1 +
 configs/sandbox_spl_defconfig      | 1 +
 configs/sandbox_vpl_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index dd0582d2a0c..532d85ca39d 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a50fbce8d06..c4d74b3af71 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -68,6 +68,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 049a606613e..99839061d29 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -39,6 +39,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index eb0f064ad28..65fd07e0b3b 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -82,6 +82,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index bc6a430fa35..bb63f389d69 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -60,6 +60,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 96e9211bd19..fa374d69fcb 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -72,6 +72,7 @@ CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_MX_CYCLIC=y
 CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
 CONFIG_CMD_DEMO=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B606C35FF1
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D44817D8;
	Mon, 17 Mar 2025 04:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181298;
	bh=SDhFu3QxGYSG19FG+JWVR/cMR6XFvwrp5Idtzd2HyF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n+7kIbGFC3w1KvyZOGMw5J5QqMk5yDt1e69WNHND5WB8acVpYlMtDOQFLgA5OV+yF
	 lUxudunjtH5c7jNkGXHdEe4zzVh2wwX0bdueWt0GDaSQmRSYkBKeH2uM4VR+q13o8/
	 IpIQv0niIRFkkHaaElfCsUjuugiXqn18J6msRiFAR6RCZb9zjNF1dGznsrE7lmluhR
	 k0MgHcBx6jBf/DMNJEiP/QWy6OucECEiOaKFuGlyHgZTc1F/s0h92hcpS8s2SeolPg
	 v0HCvt96l8Udhk+A3eIZ0+8Oui5jiFsLfh0CPVawty+F0A1WFfHPH6lhMrUvX47nOU
	 6hwKh0SBm9Uwg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4D28168B; Mon, 17 Mar 2025 04:14:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2508A810F5
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Fg8kTls9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B746E101F7A3D; Mon, 17 Mar 2025 04:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181293; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=SDhFu3QxGYSG19FG+JWVR/cMR6XFvwrp5Idtzd2HyF0=;
 b=Fg8kTls9NgHxpKHM+/aa0WSRuA5N4+hkNj0a8x20f7iFPBG2MIbEroIJuaCw1KWCqgEjGu
 FJ6lomf3Q7KnItWr5+ZKjiQYOyUyM/49BPQ45dd6kKd7RO2xDrqU3CXQoptdr8z6k0G4mp
 l6N2rXhccnZnwXTeA3YkgTPZZ3hCUPQp8TusnrTQMzD1CoKAISgVQ+YknkNeuUvmuxtzXi
 pGDGaMxxgeg7DbXSEDJ0mXB5MrkTjqAbnNm9/tjlAMCqCBbKmv80Oq5VC3F04ZAhiUyLDr
 0KVuCvqgjgQBdSy3DQsv3GtAxOQHuRDtBsbZnvShg/Zt5DN4fyS/enxXORZ6WQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 02/11] cmd: fs: Add generic rm implementation
Date: Mon, 17 Mar 2025 04:12:41 +0100
Message-ID: <20250317031418.223019-3-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add generic implementation of the 'rm' command to delete files
from filesystems using the generic filesystem API.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Add RB from Tom
V3: No change
---
 cmd/fs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/cmd/fs.c b/cmd/fs.c
index bccc3a129bd..7f1ab8f0fd2 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -99,6 +99,20 @@ U_BOOT_CMD(
 	"      device type 'interface' instance 'dev'."
 );
 
+static int do_rm_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	return do_rm(cmdtp, flag, argc, argv, FS_TYPE_ANY);
+}
+
+U_BOOT_CMD(
+	rm,	4,	1,	do_rm_wrapper,
+	"delete a file",
+	"<interface> [<dev[:part]>] <filename>\n"
+	"    - delete a file with the name 'filename' on\n"
+	"      device type 'interface' instance 'dev'."
+);
+
 static int do_fstype_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
-- 
2.47.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA51C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1305A8198A;
	Thu, 13 Mar 2025 20:14:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893257;
	bh=283xB9Zrb7P5VctYh30WAq53xbskrYd/K3UC/Vf0/LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YqsYOZ7HOIjQa23DsH9zcsdSeyqTWpOW1hijAjZP8HkCQvI1WH2kb+8C+91pYAaav
	 32UwYFGDGqCw2vmjFico45n5tZMl0KaV6UH795C4Ujm6FV+2lPNwueb7vq1CGS6F/q
	 Fnb15fF865aHiQi0QVMjBZx31t1iUhgEH6CAPrRkqmYsKUmEaLSfZt8BmWPWfcKNYX
	 aJb4rHfd5bYuxNkTrFIiFyuowuKxh0PwPXZjdNo5xh4Vg9hpn4tyncFFQojgPste9K
	 OZE5wLb78RIqGm2uMZD4uoVLd1Me4LrN/SMcGFFOTUKIvdqs2ZhSmGx6k95ycqboos
	 zm0zw4+EgiGJQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85EC28193A; Thu, 13 Mar 2025 20:14:15 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675BE817D8
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Pvmen1ZF"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EBE5510202124; Thu, 13 Mar 2025 20:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893251; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=283xB9Zrb7P5VctYh30WAq53xbskrYd/K3UC/Vf0/LU=;
 b=Pvmen1ZF3QBMFRRjONNr12OWhPYEY6n2JpVi3jBYa+LsJoSr86dPNnXQkL1oKFTCNNHOzA
 iGeIrhx2hwO3xo9Zt/Ohd2BtrmvRz00aFSFzfDLJEHkxNwuhCXfIc0n4HA707Eb9oxtY3I
 +t1kYbw41S5OB/slXmiwJEnummnhQuJ72dhkoZawCxFIXZ9qfGvZ8tnv4Oq64MOOL9Sw4l
 rnUg99MfQoQCFRCACyZ0LULnP39cbzWn28LHziDdIHOrJa3cjnjX79bRitSeAV0lYhW7wL
 nYk6iMhyGU8Wd4jFvWaH9ER+zqkuyT1/onrDSmPYq51+qDHEdx30GOOBs8RPTQ==
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
Subject: [PATCH v2 02/11] cmd: fs: Add generic rm implementation
Date: Thu, 13 Mar 2025 20:13:18 +0100
Message-ID: <20250313191348.170054-3-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313191348.170054-1-marex@denx.de>
References: <20250313191348.170054-1-marex@denx.de>
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


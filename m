Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84C3C28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51FF8129F;
	Mon, 17 Mar 2025 04:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181295;
	bh=tqCHgcaRBPAlt8G9eLQjokhqR5JbH221Y+lddqNldF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w+sdHxVaOU1QeEGBTATOMSIRw0XD42k0sYzJxfzBTLTQrzASyEkiCwlB7G6lxucoX
	 req1KR1WSPqu9d3nYftB1mw39MP1sQ4GmsQT4u4YjaDXwAHDMcIOGsLAgS2ltmFeUk
	 z2/6jdOzqcXXzO0jkMzPyOwI3E1kotDQJeUt1vEZQZ5Opbn2EfU1/LmKc/r9+RAl/T
	 ePo9QB+THj6hhiP/7QumOO2UjUejDq8/E3/UnNZNLKLuSdGWvppTQwjbQ0XLb5dYvJ
	 RBhYO+ILFprANTbAI9d2hbEyVVNnHrGMvGwEaHXZht9k+Aoe6R7xqibxkxKmz6pHon
	 RKFMx41QU/3yg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DDE801DE; Mon, 17 Mar 2025 04:14:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08FFD80F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WuAyvtfT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 716F2101F7A30; Mon, 17 Mar 2025 04:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181292; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=tqCHgcaRBPAlt8G9eLQjokhqR5JbH221Y+lddqNldF8=;
 b=WuAyvtfTUkwdeerREWjpzTOIdjhJCtM+SQoqUwZRCcenBr23TwQsWxtc+BN9vxKrx6vA1/
 HJQhzfipclg8ufKMmaJyEoF/fKUGplTLIbaS+ijZz4ypKo7BObvBGVbBTVvf0YUAL8wVhi
 y4SPHmd5kKa5CfBS/RtSqg2myQZrYBhDsux8WI01GNGBlx3gQIhmAZbDiUMYl3VF6RFeeq
 gu5lGRVpHjev/uu3cIOASvjhj0xFsEHHYFjwME2GS5AvIVzQExmMgMzvpQkSeLHFDHoQA+
 FpIWFpJSX4VBKOPA+1mJYpKedj4XzdWhhyvIF6Fr3yhv306CILsAaTF63mnpRQ==
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
Subject: [PATCH v3 01/11] cmd: fs: Add generic mkdir implementation
Date: Mon, 17 Mar 2025 04:12:40 +0100
Message-ID: <20250317031418.223019-2-marex@denx.de>
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

Add generic implementation of the 'mkdir' command to create directories
in filesystems using the generic filesystem API.

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
index 3faf7627447..bccc3a129bd 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -85,6 +85,20 @@ U_BOOT_CMD(
 	"      device type 'interface' instance 'dev'."
 );
 
+static int do_mkdir_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	return do_mkdir(cmdtp, flag, argc, argv, FS_TYPE_ANY);
+}
+
+U_BOOT_CMD(
+	mkdir,	4,	1,	do_mkdir_wrapper,
+	"create a directory",
+	"<interface> [<dev[:part]>] <directory>\n"
+	"    - Create a directory 'directory' of partition 'part' on\n"
+	"      device type 'interface' instance 'dev'."
+);
+
 static int do_fstype_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
 			     char *const argv[])
 {
-- 
2.47.2


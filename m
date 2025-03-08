Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2253C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD4381101;
	Sat,  8 Mar 2025 21:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464975;
	bh=HmN+uDfJ/C5/S9NbU6MhImZqLrOgo5maN+9earsDwik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nwn+DTyKTYlJokHdjqGhnhB5Ge7/92XuQa5oPYqHCBIUq7HkXPVHMZ2uDy7UOdUSM
	 MdOjdE/EP+ZWNqY5xBOrarVFm/Fk+9BilAG+TgLEMbXJIerzlZSVBxMf+UbfL5MlKK
	 vWBkSEKXQdZFuFaahsN47ogwJDhuXb8I3fH+5fWJ0EiUMA5WW29EcWoNLgrgQf5A1/
	 m5zhfAAuOD8tXHLiQgGLzYV3vPD4AZKG282Udn+S4H56RnSjrgZEfAFJPk9Sav5vUa
	 aOm1rQ56kcKdPXBigfaCJoNnUNi+d9w83+3KfkeePsTrPU+GYDz1mL95IxL63RpB/K
	 OdiC+zW1QLvBQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8549E8043C; Sat,  8 Mar 2025 21:16:14 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D9B808A2
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OCLsNTJU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 16E03101E897E; Sat,  8 Mar 2025 21:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464971; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HmN+uDfJ/C5/S9NbU6MhImZqLrOgo5maN+9earsDwik=;
 b=OCLsNTJUFrkklqGhHSg00lG+m94930asjpwnc/hEhWGtsDd7QOBxF8n+crMucsFWNKx3dp
 WdcmZJ6M+Oajw3E0SHZw+oOxt+qhU7/yZTN1+Cza6albyo3kFEGoyt79qzlMUFZdMXPm96
 paa1sJOl14BG65rx3Qft4IBVfaeM069kuj5QHvDZK6PYCQV+b1d5xUFLoVGZW5Z2V1sKyO
 I6NLnAx3rpOtiU66ZBmVu+n64/ROG5zdkBOrbSw51K2XoLJbleUC+1X/L/9pfK7BSTiU1d
 lROjfax1ROss0ugZVOLXLCZQTraC+Ghrg+5VxTVEsHg70I+FUv0KYpambHDPzw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/12] cmd: fs: Add generic mkdir implementation
Date: Sat,  8 Mar 2025 21:12:05 +0100
Message-ID: <20250308201533.1315951-2-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
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
 cmd/fs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/cmd/fs.c b/cmd/fs.c
index 3d7e06d6f1e..df1f24207de 100644
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


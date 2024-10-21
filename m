Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EE7D15D96
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 13:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCE388E41;
	Mon, 21 Oct 2024 15:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W21e6Jey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6243488E75; Mon, 21 Oct 2024 15:56:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E94889EB
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 15:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729519002; x=1761055002;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+HfHL/3GwxzdULnO0yoV4OhPJ5fY60pzgSD4O/h8oY4=;
 b=W21e6JeyrKS8npnj1I89caSwrWTaOjXULArMSdYWbiT51voqNaJJib5F
 WTpauWby0mhGqG8wGQdWj/PU90KF7dOhlwbQVZSs49q/e5ZRSFZEClyzk
 fGyepU+XHv59qTbfmf5E/FWbqCG5h61nRWwtMx6p6ro/Jbp274gnrGzrJ
 TnD2LcGZuJyOFkjRizeGBgJc0pzhn1KJGy8bbS0mF6rmixA4CXXy6KHPt
 gxqYHkGCsFUBfzXXoDu7lY0pAr0m12WVcPJ9LPZyyEvC7+7h9QguiBBy3
 9+sVx2eNDJgNsbG0nBHtyq/PuS6zqvx+H6fv5ni7rz0SObFS8r0YE7VNn w==;
X-CSE-ConnectionGUID: 1VYNSxrEQ5SUA6KGLgK+KQ==
X-CSE-MsgGUID: H5iCiWX4QwKN2QvHFxKMKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40128473"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="40128473"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 06:56:40 -0700
X-CSE-ConnectionGUID: Z+xq1CyZSoSE5Q4Pm07ZGw==
X-CSE-MsgGUID: 148WOYYlQFOnyjalIX9XxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="79934657"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa007.jf.intel.com with ESMTP; 21 Oct 2024 06:56:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id DA34A1E0; Mon, 21 Oct 2024 16:56:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] cmd: nvedit: Mark a few functions static
Date: Mon, 21 Oct 2024 16:56:33 +0300
Message-ID: <20241021135633.2958463-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Some functions are not used anywhere except the same file
where they are defined. Mark them static. This helps avoiding
the compiler warnings:

  cmd/nvedit.c:201:5: warning: no previous prototype for ‘do_env_ask’ [-Wmissing-prototypes]
  cmd/nvedit.c:315:5: warning: no previous prototype for ‘do_env_callback’ [-Wmissing-prototypes]
  cmd/nvedit.c:384:5: warning: no previous prototype for ‘do_env_flags’ [-Wmissing-prototype ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 cmd/nvedit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 98a687bcabbd..0bd4799dc5a2 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -198,7 +198,7 @@ static int do_env_set(struct cmd_tbl *cmdtp, int flag, int argc,
  * Prompt for environment variable
  */
 #if defined(CONFIG_CMD_ASKENV)
-int do_env_ask(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int do_env_ask(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char message[CONFIG_SYS_CBSIZE];
 	int i, len, pos, size;
@@ -312,8 +312,8 @@ static int print_active_callback(struct env_entry *entry)
 /*
  * Print the callbacks available and what they are bound to
  */
-int do_env_callback(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[])
+static int do_env_callback(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
 {
 	struct env_clbk_tbl *clbkp;
 	int i;
@@ -381,7 +381,7 @@ static int print_active_flags(struct env_entry *entry)
 /*
  * Print the flags available and what variables have flags
  */
-int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+static int do_env_flags(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	/* Print the available variable types */
 	printf("Available variable type flags (position %d):\n",
-- 
2.43.0.rc1.1336.g36b5255a03ac


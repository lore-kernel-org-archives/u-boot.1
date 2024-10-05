Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3795CCFB42B
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078CD88CBB;
	Sat,  5 Oct 2024 21:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="n+ksTh5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D8288CBB; Sat,  5 Oct 2024 21:14:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 730DE88AFF
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728155675; x=1759691675;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cLGI/fDGoLN0LtoJ4QAyOjUu51mdp89HSDyVWxHZKkU=;
 b=n+ksTh5c3iyc6PGKPBSbvidLAkgDnwOzYht0WGcORTrV2SPDjvVfBVCX
 rHAzkB+YibbrWtl8FF/TluhLwSh/elAk1FBk6G7ferg9E2+f+FlPKmjcL
 BEDD3Rd3DhcykXRlGI9W6c1sS2UZMDfwty8u2TjRSDuF6gtbdWmpOG2+L
 Y3pnjXUgxlQdiM9WgCaDSkQ3t18l+dwX011hvX/NDaOsePXEFu6Laaaoi
 9PzCZwtzIYaJBpE/6gVT8aljsostmRNYKbyu4MD2ccg04vbWoao7yMIpP
 DprSyaTbr3matvUhrzbWk8AqCvsYphRGnMnjZFZZOE0osT+Ol9Vj+MIp/ w==;
X-CSE-ConnectionGUID: rSzNZUUeTNed4uzn+G5Cew==
X-CSE-MsgGUID: wWwPm2xZQKuf8S1R5NSKkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27442441"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="27442441"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2024 12:14:33 -0700
X-CSE-ConnectionGUID: 7akJ4CLuTZm4VlTc+Xp4aw==
X-CSE-MsgGUID: rx+a66dPTeiFDsxe45ziBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="75040860"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa009.fm.intel.com with ESMTP; 05 Oct 2024 12:14:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id DA5EB178; Sat, 05 Oct 2024 22:14:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Subject: [PATCH v1 1/1] cmd: irq: Move do_irqinfo() prototype to a header file
Date: Sat,  5 Oct 2024 22:14:29 +0300
Message-ID: <20241005191429.1927741-1-andriy.shevchenko@linux.intel.com>
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

Move do_irqinfo() prototype to a header file, otherwise compiler is not
happy:

  arch/x86/lib/interrupts.c:130:5: warning: no previous prototype for ‘do_irqinfo’ [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 cmd/irq.c          | 3 ---
 include/irq_func.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/irq.c b/cmd/irq.c
index 655aba576a8b..da223b4b2cce 100644
--- a/cmd/irq.c
+++ b/cmd/irq.c
@@ -29,9 +29,6 @@ U_BOOT_CMD(
 	"[on, off]"
 );
 
-/* Implemented in $(CPU)/interrupts.c */
-int do_irqinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-
 U_BOOT_CMD(
 	irqinfo,    1,    1,     do_irqinfo,
 	"print information about IRQs",
diff --git a/include/irq_func.h b/include/irq_func.h
index c7c4babbfc90..28ec0bd83038 100644
--- a/include/irq_func.h
+++ b/include/irq_func.h
@@ -23,4 +23,7 @@ void reset_timer(void);
 void enable_interrupts(void);
 int disable_interrupts(void);
 
+/* Implemented in $(CPU)/interrupts.c */
+int do_irqinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
 #endif
-- 
2.43.0.rc1.1336.g36b5255a03ac


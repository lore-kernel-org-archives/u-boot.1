Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D36ECEFC39
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 18:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F089588ED1;
	Tue,  8 Oct 2024 20:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA4988EE3; Tue,  8 Oct 2024 20:14:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B6D5E88ED1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 20:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D94DA7;
 Tue,  8 Oct 2024 11:15:22 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57EF03F64C;
 Tue,  8 Oct 2024 11:14:50 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 02/14] lmb: add a flag to allow suppressing memory map
 change notification
Date: Tue,  8 Oct 2024 23:44:23 +0530
Message-Id: <20241008181435.1753814-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
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

Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
reserving memory. This will then result in no notification being sent
from the LMB module for the changes to the LMB's memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 include/lmb.h | 1 +
 lib/lmb.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/lmb.h b/include/lmb.h
index 0e8426f4379..a76262d520d 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -23,6 +23,7 @@ enum lmb_flags {
 	LMB_NONE		= 0,
 	LMB_NOMAP		= BIT(1),
 	LMB_NOOVERWRITE		= BIT(2),
+	LMB_NONOTIFY		= BIT(3),
 };
 
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 0763f6174c1..a4886db4c45 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -30,7 +30,7 @@ static struct lmb lmb;
 static void lmb_print_region_flags(enum lmb_flags flags)
 {
 	u64 bitpos;
-	const char *flag_str[] = { "none", "no-map", "no-overwrite" };
+	const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
 
 	do {
 		bitpos = flags ? fls(flags) - 1 : 0;
-- 
2.34.1


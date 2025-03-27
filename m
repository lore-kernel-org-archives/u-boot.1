Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EEBC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2998281E5B;
	Thu, 27 Mar 2025 16:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2E281DDF; Thu, 27 Mar 2025 16:33:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3EFE1805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5B611655;
 Thu, 27 Mar 2025 08:33:34 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C3323F694;
 Thu, 27 Mar 2025 08:33:27 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 04/18] use proper fallthrough annotations
Date: Thu, 27 Mar 2025 15:32:59 +0000
Message-Id: <20250327153313.2105227-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250327153313.2105227-1-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
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

In some cases in the generic code, we were already using switch/case
fallthrough annotations comments, though in a way which might not be
understood by most compilers.

Replace two non-standard /* no break */ comments with our fallthrough;
statement-like macro, to make this visible to the compiler.
Also use this macro in place of an /* Fall through */ comment, to be
more consistent.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 common/command.c  | 2 +-
 lib/tiny-printf.c | 2 +-
 net/net.c         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/command.c b/common/command.c
index 3f691399cbe..0f9dd06d72b 100644
--- a/common/command.c
+++ b/common/command.c
@@ -484,7 +484,7 @@ int cmd_get_data_size(const char *arg, int default_size)
 		case 'q':
 			if (MEM_SUPPORT_64BIT_DATA)
 				return 8;
-			/* no break */
+			fallthrough;
 		default:
 			return CMD_DATA_SIZE_ERR;
 		}
diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 0503c17341f..b8fc8355c4a 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -282,7 +282,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 					break;
 				}
 				islong = true;
-				/* no break */
+				fallthrough;
 			case 'x':
 				if (islong) {
 					num = va_arg(va, unsigned long);
diff --git a/net/net.c b/net/net.c
index 1828f1cca36..5219367e391 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1559,7 +1559,7 @@ common:
 			puts("*** ERROR: `ipaddr' not set\n");
 			return 1;
 		}
-		/* Fall through */
+		fallthrough;
 
 #ifdef CONFIG_CMD_RARP
 	case RARP:
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941C8C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 15:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAA381E3E;
	Thu, 27 Mar 2025 16:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC9D81E60; Thu, 27 Mar 2025 16:33:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 22855806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 16:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B93D21762;
 Thu, 27 Mar 2025 08:33:36 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000293F694;
 Thu, 27 Mar 2025 08:33:29 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 05/18] net/net: fix switch/case fallthrough annotations
Date: Thu, 27 Mar 2025 15:33:00 +0000
Message-Id: <20250327153313.2105227-6-andre.przywara@arm.com>
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

The net_check_prereq() routine in the generic network handling code
mixes case: labels with #ifdef's, which makes predicting fallthrough
situations tricky. We had two "fall through" comments in the code, but
at the wrong places.

Remove one unneeded comment (no annotations necessary between just empty
labels), and move one other instance to the right place (before any
label sequence).
This makes GCC's implicit fallthrough checker happy.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 net/net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/net.c b/net/net.c
index 5219367e391..f191f16357c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1525,7 +1525,6 @@ static int net_check_prereq(enum proto_t protocol)
 #if defined(CONFIG_CMD_NFS)
 	case NFS:
 #endif
-		/* Fall through */
 	case TFTPGET:
 	case TFTPPUT:
 		if (IS_ENABLED(CONFIG_IPV6) && use_ip6) {
@@ -1539,11 +1538,11 @@ static int net_check_prereq(enum proto_t protocol)
 			puts("*** ERROR: `serverip' not set\n");
 			return 1;
 		}
+		fallthrough;
 #if	defined(CONFIG_CMD_PING) || \
 	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
 common:
 #endif
-		/* Fall through */
 
 	case NETCONS:
 	case FASTBOOT_UDP:
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64199C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 17:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E87810E8;
	Tue, 25 Mar 2025 18:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB6B8186D; Tue, 25 Mar 2025 18:47:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EF28081026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 18:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C4A31756;
 Tue, 25 Mar 2025 10:47:56 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCA0D3F58B;
 Tue, 25 Mar 2025 10:47:49 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH] common: console: move break; statement
Date: Tue, 25 Mar 2025 17:47:44 +0000
Message-Id: <20250325174744.1778691-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
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

In console_setfile(), there is some #ifdef'ed code, updating monitor
functions for a U-Boot proper build. This is called inside a switch/case
statement, but the closing "break;" is inside the #ifdef section.
This doesn't look right: we should not fall through to the error case
for an SPL/TPL build.

Move the "break" to be always effective, solving a compiler warning about
an untagged implicit fallthrough.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

this seems to be the only real bug I found after enabling
-Wimplicit-fallthrough in the first phase of the CI. Please have a look
to check whether I am right with this one.

I have about 20 patches that add fallthrough annotations, to fix the other
warnings, and will send them out once I polished them up - and after I
have figured out what to do with libbzip2.

Cheers,
Andre

 common/console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/console.c b/common/console.c
index 863ac6aa9dc..618dbb0255f 100644
--- a/common/console.c
+++ b/common/console.c
@@ -208,8 +208,8 @@ static int console_setfile(int file, struct stdio_dev * dev)
 			gd->jt->printf = printf;
 			break;
 		}
-		break;
 #endif
+		break;
 	default:		/* Invalid file ID */
 		error = -1;
 	}
-- 
2.25.1


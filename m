Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31EAD5E147
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 08:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C0488FFC;
	Fri,  8 Nov 2024 09:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZrBey6wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F5E8900E; Fri,  8 Nov 2024 09:36:39 +0100 (CET)
Received: from ec2-44-216-146-137.compute-1.amazonaws.com
 (ec2-44-216-146-137.compute-1.amazonaws.com [44.216.146.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8937388F62
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 09:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 230d645a;
 Fri, 8 Nov 2024 16:36:30 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] console: Use printascii for lowlevel debug string
Date: Fri,  8 Nov 2024 16:36:23 +0800
Message-Id: <20241108163612.1.Ib408a6723ba954c932968419678bd45b0767a470@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IYQ1ZCS0hMGEJJGkhMSU5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a930aeaf2e803afkunm230d645a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Mww*MzIsHioVNT0STDYp
 TisKCR5VSlVKTEhKS05PQkJKSUhOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTkg3Bg++
DKIM-Signature: a=rsa-sha256;
 b=ZrBey6wi6UfumVfEwN4+jG8UiKUVwLzYDF8T+uk70G+omQ1h5t+vhKQNdCAlIrkhNV79z3jii8JWesHhlzsTAGsMxgmCnh3/IKpaYZNDWPw6YJI+/C6uJ//++WFjKJvBWYAxLVX4O7WXPBs9JHMCsKwWbteenDayYWZlRvEyHhw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=uYWiCq4O0i3Ch9C+PyfwaSmeovTbl5miGBysTNPw+6Q=;
 h=date:mime-version:subject:message-id:from;
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

The lowlevel debug with CONFIG_DEBUG_UART has printascii for string
print, and no need to convert to use printch now.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

 common/console.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/common/console.c b/common/console.c
index 22224701e45..863ac6aa9dc 100644
--- a/common/console.c
+++ b/common/console.c
@@ -745,11 +745,7 @@ void puts(const char *s)
 	}
 
 	if (IS_ENABLED(CONFIG_DEBUG_UART) && !(gd->flags & GD_FLG_SERIAL_READY)) {
-		while (*s) {
-			int ch = *s++;
-
-			printch(ch);
-		}
+		printascii(s);
 		return;
 	}
 
-- 
2.25.1


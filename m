Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4962BCDD1CE
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 16:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30C189114;
	Fri, 27 Sep 2024 18:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB1D89131; Fri, 27 Sep 2024 18:38:19 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EC88839A
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 18:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XFbkJ3dHDzn80;
 Fri, 27 Sep 2024 18:38:16 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XFbkH6whhz11Th; Fri, 27 Sep 2024 18:38:15 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 27 Sep 2024 18:37:43 +0200
Subject: [PATCH] cmd/mem.c: fix undefined behavior in mem cmp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-cmd-mem-undefined-v1-1-56fa57d0927b@cherry.de>
X-B4-Tracking: v=1; b=H4sIAFbf9mYC/x2MSQqAMAwAvyI5G9Ba16+Ih9ZEzaFVWhRB/LvF4
 zDMPBA5CEcYsgcCXxJl9wnKPIN5M35lFEoMqlC66FWLsyN07PD0xIt4JjS6ajqqO1vbBlJ3hCT
 u/zlO7/sBCYnWeWMAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

My linter complains that "When using void pointers in calculations, the
behaviour is undefined".

GCC does say that "In GNU C, addition and subtraction operations are
supported on pointers to void"[1] but this hints at this only being
supported in the GNU flavor of C. And I assume U-Boot may want to be
compiled with clang/llvm?

Let's fix that warning by casting the void pointer to a u8 pointer since
the size variable unit is byte.

[1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html

Fixes: 0628ab8ec598 ("sandbox: Change memory commands to use map_physmem")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 cmd/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 274348068c2..08ec0aefa7d 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -293,8 +293,8 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		}
 
-		buf1 += size;
-		buf2 += size;
+		buf1 = ((u8 *)buf1) + size;
+		buf2 = ((u8 *)buf2) + size;
 
 		/* reset watchdog from time to time */
 		if ((ngood % (64 << 10)) == 0)

---
base-commit: 56b47b8b6a09c777e74fe6c52512c832691169aa
change-id: 20240927-cmd-mem-undefined-a4368d58b5b6

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E66C3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 10:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A56B88B9F;
	Fri,  2 Aug 2024 12:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F8C88B22; Fri,  2 Aug 2024 12:09:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D610A888A4
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 7273164C3B2C;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id z8c89FAK_06w; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id EC92464C3B26;
 Fri,  2 Aug 2024 12:08:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id IW1xDajdU9y7; Fri,  2 Aug 2024 12:08:56 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id A683C64A3D05;
 Fri,  2 Aug 2024 12:08:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, marek.vasut+renesas@mailbox.org,
 eugeneuriev@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com,
 sjg@chromium.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/4] x86: Fix ptrdiff_t for x86_64
Date: Fri,  2 Aug 2024 12:08:43 +0200
Message-Id: <20240802100846.16619-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

sbrk() assumes ptrdiff_t is large enough to enlarge/shrink the heap
by LONG_MIN/LONG_MAX.
So, use the long type, also to match the rest of the Linux ecosystem.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/include/asm/posix_types.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/posix_types.h b/arch/x86/include/asm/po=
six_types.h
index dbcea7f47f..e1ed9bcabc 100644
--- a/arch/x86/include/asm/posix_types.h
+++ b/arch/x86/include/asm/posix_types.h
@@ -20,11 +20,12 @@ typedef unsigned short	__kernel_gid_t;
 #if defined(__x86_64__)
 typedef unsigned long	__kernel_size_t;
 typedef long		__kernel_ssize_t;
+typedef long		__kernel_ptrdiff_t;
 #else
 typedef unsigned int	__kernel_size_t;
 typedef int		__kernel_ssize_t;
-#endif
 typedef int		__kernel_ptrdiff_t;
+#endif
 typedef long		__kernel_time_t;
 typedef long		__kernel_suseconds_t;
 typedef long		__kernel_clock_t;
--=20
2.35.3


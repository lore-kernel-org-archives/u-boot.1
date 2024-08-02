Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB8AC3DA49
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 10:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6F888B70;
	Fri,  2 Aug 2024 12:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA01C88B9F; Fri,  2 Aug 2024 12:08:59 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D667188B22
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 8C78364A3D05;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tMjEA2u4i1NY; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 263FA64C3B28;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id aRGj0udtbCUD; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id DC44D64C3B23;
 Fri,  2 Aug 2024 12:08:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, marek.vasut+renesas@mailbox.org,
 eugeneuriev@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com,
 sjg@chromium.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/4] dlmalloc: Fix integer overflow in request2size()
Date: Fri,  2 Aug 2024 12:08:44 +0200
Message-Id: <20240802100846.16619-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240802100846.16619-1-richard@nod.at>
References: <20240802100846.16619-1-richard@nod.at>
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

req is of type size_t, casting it to long opens the door
for an integer overflow.
Values between LONG_MAX - (SIZE_SZ + MALLOC_ALIGN_MASK) - 1 and LONG_MAX
cause and overflow such that request2size() returns MINSIZE.

Fix by removing the cast.
The origin of the cast is unclear, it's in u-boot and ppcboot since ever
and predates the CVS history.
Doug Lea's original dlmalloc implementation also doesn't have it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 common/dlmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 62e8557daa..44b06e38b2 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -386,8 +386,8 @@ nextchunk-> +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+
 /* pad request bytes into a usable size */
=20
 #define request2size(req) \
- (((long)((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) < \
-  (long)(MINSIZE + MALLOC_ALIGN_MASK)) ? MINSIZE : \
+ ((((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) < \
+  (MINSIZE + MALLOC_ALIGN_MASK)) ? MINSIZE : \
    (((req) + (SIZE_SZ + MALLOC_ALIGN_MASK)) & ~(MALLOC_ALIGN_MASK)))
=20
 /* Check if m has acceptable alignment */
--=20
2.35.3


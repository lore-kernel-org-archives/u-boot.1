Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1431C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 10:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AB8B88BA4;
	Fri,  2 Aug 2024 12:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD17688B9F; Fri,  2 Aug 2024 12:09:01 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1739A88B81
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 12:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id DB8A564C3B29;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id WKDqOzfLJiAy; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 6E9E264C3B2A;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id D7j3vBTZfNhf; Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 1C5FF64C3B27;
 Fri,  2 Aug 2024 12:08:57 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, marek.vasut+renesas@mailbox.org,
 eugeneuriev@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com,
 sjg@chromium.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/4] dlmalloc: Fix integer overflow in sbrk()
Date: Fri,  2 Aug 2024 12:08:45 +0200
Message-Id: <20240802100846.16619-3-richard@nod.at>
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

Make sure that the new break is within mem_malloc_start
and mem_malloc_end before making progress.
ulong new =3D old + increment; can overflow for extremely large
increment values and memset() can get wrongly called.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 common/dlmalloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index 44b06e38b2..c8d1da1cb1 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -581,6 +581,9 @@ void *sbrk(ptrdiff_t increment)
 	ulong old =3D mem_malloc_brk;
 	ulong new =3D old + increment;
=20
+	if ((new < mem_malloc_start) || (new > mem_malloc_end))
+		return (void *)MORECORE_FAILURE;
+
 	/*
 	 * if we are giving memory back make sure we clear it out since
 	 * we set MORECORE_CLEARS to 1
@@ -588,9 +591,6 @@ void *sbrk(ptrdiff_t increment)
 	if (increment < 0)
 		memset((void *)new, 0, -increment);
=20
-	if ((new < mem_malloc_start) || (new > mem_malloc_end))
-		return (void *)MORECORE_FAILURE;
-
 	mem_malloc_brk =3D new;
=20
 	return (void *)old;
--=20
2.35.3


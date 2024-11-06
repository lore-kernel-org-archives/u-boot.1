Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBAFD59F73
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 21:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3673891D2;
	Wed,  6 Nov 2024 22:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oHqF3Ad1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E02E88E63; Wed,  6 Nov 2024 22:10:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79A88903B
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1983A5C4CA7;
 Wed,  6 Nov 2024 21:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E239C4CEC6;
 Wed,  6 Nov 2024 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730927419;
 bh=fPLP8YS+pPMZhBa/pDJmZMobDfgKqXREy3BtFkOYj4o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oHqF3Ad1Q1eZMwnyFi/Ze22lyRACbNt/H4i9tWOHamyVXMbhvMB39qDp7kR08+voA
 xXgltaNOTcl7Qksvdvbu4dhLmrZ+dhyHbO9PD/BuwjbLgxgmrSYAkzQtyPfxkupaqx
 q/SfupEilMvMB6G8ZbvHM1ek1+cD1SOepra77WP2kxh9XyrZ8q5SKBvPjo3QVhCBbA
 3nUVHbGsSt7XBNwwGCFsJb4D7+FaNl1kmynOntV3Q0JXsKCgBM3he6p5OaMnA9yV3t
 0IahCi/Rc3IP9RBW0786qxWMSU6VRlTF6z8Uyfphcmm8LxCnZmIKBhROAyzcOksgFO
 HvX8NoNlQGtTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6F737D59F73;
 Wed,  6 Nov 2024 21:10:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 06 Nov 2024 22:10:09 +0100
Subject: [PATCH v2 1/4] lmb: Do not use global LMB variable in _lmb_free()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-io_lmb_apple_dart_iommu-v2-1-0580f4bdb023@jannau.net>
References: <20241106-io_lmb_apple_dart_iommu-v2-0-0580f4bdb023@jannau.net>
In-Reply-To: <20241106-io_lmb_apple_dart_iommu-v2-0-0580f4bdb023@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=QhJ4eD7au/VVkmrFtpgL/2M1qUSFrO9yqc8R9QLVa48=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTt2xYs8yqev8nq/Fhddjrp7pfEVkml6Pc/J0Ub2Rv/f
 OCb7GbcUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCLcyQx/pX7/MWGqzohg2xIX
 VWRQtCGLyfbUw4ZLZ0P3bGnUC94gyMhwW+Krz/s/cQY7r+43e7bg18F4t2d7JnjN2DA9cWf74yY
 xNgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

It will be re-used with a lmb list pointer as argument for IOVA
allocations in the apple_dart iommu driver.

Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/lmb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 96a055f951e657bf3acc05c9fa804698ce90c312..5be0d9dd89a506dc1e6e6951cc54441a8d4bb0df 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -495,10 +495,10 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
 }
 
-static long _lmb_free(phys_addr_t base, phys_size_t size)
+static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
+		      phys_size_t size)
 {
 	struct lmb_region *rgn;
-	struct alist *lmb_rgn_lst = &lmb.used_mem;
 	phys_addr_t rgnbegin, rgnend;
 	phys_addr_t end = base + size - 1;
 	int i;
@@ -561,7 +561,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 {
 	long ret;
 
-	ret = _lmb_free(base, size);
+	ret = _lmb_free(&lmb.used_mem, base, size);
 	if (ret < 0)
 		return ret;
 

-- 
2.47.0



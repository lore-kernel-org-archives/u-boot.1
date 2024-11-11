Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464FDD12D7B
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 06:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2AB8914D;
	Mon, 11 Nov 2024 07:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s0k7TK9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640B689110; Mon, 11 Nov 2024 07:56:49 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC008917A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 07:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id F3999A40DD7;
 Mon, 11 Nov 2024 06:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08E92C4CED7;
 Mon, 11 Nov 2024 06:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731308206;
 bh=KvOpmHNr9GBVpmLeQtFsyBWpBwiFsd6Kp54DbarTRGI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=s0k7TK9qj/RBKOzDoCoUzYnWIPQNAcxfHpqzb7yz+yvLTVOwst1zAIiufMf5RGO8o
 8VfIEs/rux2z4SoSox0yyJY/HaNjw1jIxfYStZoYzDoJUtYVk9jkYbaqsHQM8vn2nj
 4sZcDvvH7zqFwfWnmYCvnjQMdlE4mh30lJLy6+UD6W4oqMDn29beB0VLqPdunBPN7Q
 J9FfM5SGuUlfavJMWkWOvVpgR5ziEQOBJQCKJCCoYQeSJaQN5s5reiiwXxRo1A1VND
 3SomZs0SxhRfZ2AvkIgAZthj6ISa2lyH0Q6jeIxwDNvqK15BES9Fb3vyAbYlFGg+2e
 OLfvNei0dyD6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC4D12D7B;
 Mon, 11 Nov 2024 06:56:45 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Mon, 11 Nov 2024 07:56:31 +0100
Subject: [PATCH v3 1/4] lmb: Do not use global LMB variable in _lmb_free()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-io_lmb_apple_dart_iommu-v3-1-32c05da51d72@jannau.net>
References: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
In-Reply-To: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
To: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=yY4POAUicULzkGYsRkw8yQkAbaMmPJp0vghM49loTh4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTDVWtK7hyRqviw/51nRvxam8CvhyaYTl0po6f2j2f/i
 0dbBXntO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEzkvTjD/1Dtd1rnHwrNnSng
 53goTFrVLv6k7parbYJ/nbfoXZ6m85/hr8TKuIW3Vt0+UnfxsrPcnjPcibGrvrLcnmVevavLqLl
 oKRcA
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
index 8b306e4de8e1fe35c44d0b4b73424cdb007905b4..cc2554dfa947182806c37b31da292becc1c868a1 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -492,10 +492,10 @@ long lmb_add(phys_addr_t base, phys_size_t size)
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
@@ -558,7 +558,7 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 {
 	long ret;
 
-	ret = _lmb_free(base, size);
+	ret = _lmb_free(&lmb.used_mem, base, size);
 	if (ret < 0)
 		return ret;
 

-- 
2.47.0



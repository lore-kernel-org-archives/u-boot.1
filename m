Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702AFC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 15:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4147E882E5;
	Wed, 15 May 2024 17:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iIgS4rmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41FA588176; Wed, 15 May 2024 17:04:56 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12A278823D
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 17:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 057EDCE14E9;
 Wed, 15 May 2024 15:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766FC116B1;
 Wed, 15 May 2024 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715785487;
 bh=FRRqG/7zbIQrDbvYUPIabC6FzgZYAxFTzDrzF8FYSac=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iIgS4rmgUdrpJ3CecgiztYiLpd86i1uxrhlBYJktdrtlWrnLqvewg4GtZsXN5H8BD
 l7qae4WYGouw9ElzvJuBUTSq38B2vM0OsMuoeQOh9qc7H8zBrON33j8lqiF7zBRwC1
 V7Rw+lpTm81GzEE2n9cj0foLJ4vKKgGLIx3YRYj6RySxSjI2dwBu7UrjE9DJJBBzJu
 Wu1fVbwTqf5wRNBdfNEnE2BnLyhr3868wvKN7lvaBE/Ip7lqGR/HRwZGh+LNDcd0fn
 vPFyjwx60UeCHdc3RbNOMv3uvyf9mrdyjm+90I1Ajbj3aa23eSrQvtdx1aCWyK2eI7
 FL6AREqE0qSIQ==
From: Conor Dooley <conor@kernel.org>
To: u-boot@lists.denx.de
Cc: conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] board: microchip: icicle: correct type for node offset
Date: Wed, 15 May 2024 16:04:30 +0100
Message-ID: <20240515150434.406916-2-conor@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515150434.406916-1-conor@kernel.org>
References: <20240515150434.406916-1-conor@kernel.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

Node offsets returned by libfdt can contain negative error numbers, so
the variable type should be "int". As things stand, if the ethernet
nodes are not found in the early init callback, the if (node < 0) tests
pass and the code errors out while trying to set the local-mac-address
for a non-existent node.

Fixes: 64413e1b7c ("riscv: Add Microchip MPFS Icicle Kit support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 7beac33cfb..5fd0ec66a9 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -72,7 +72,7 @@ int board_early_init_f(void)
 int board_late_init(void)
 {
 	u32 ret;
-	u32 node;
+	int node;
 	u8 idx;
 	u8 device_serial_number[16] = { 0 };
 	unsigned char mac_addr[6];
-- 
2.43.0


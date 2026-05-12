Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A71BCD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8451780398;
	Tue, 12 May 2026 10:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="XxwDNrNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29DD803C6; Tue, 12 May 2026 10:40:58 +0200 (CEST)
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7ABF801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christian.poetzsch@kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=1Xc371rh5av+yRfRFYGo0xJwivtI05pzc2R5Fpzev+E=; b=XxwDNrNY1jTyXErQYkWXeyIHIr
 JgQLMLUpg24h136gpCYepgrPlvxbcSJcoPkFe4qI4WcY//6ZJELEP+3HpDXN3WmZh4AZ7f8RLU5KU
 gbm54kRxqDyUDu597DO3c+MzrAkvut9sYjurjSKK/jUVvXglbXGb81iLpAMilDfkUGduE+yI31t02
 i/U+Sz8erCZ57gU7GtucmM87AL9fIwZ3SAHM+qpCsitT8fpYzStGNr7AsnNbx0bTJgwhxPq3OY2ln
 Qm6CUN25S2pNd6ZgiC3AsDtiMHSVacQxaF8in/8SrnUoYWR8y/J+dgvemqTE7dqK6//vOwMI6StRk
 4jbCZZ5Q==;
Received: from [10.22.3.25] (helo=serv2.dd1.int.kernkonzept.com.)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.98.2)
 id 1wMiff-0000000AwGd-3Ie7; Tue, 12 May 2026 10:40:55 +0200
From: =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PATCH] virtio: fix return value check
Date: Tue, 12 May 2026 10:39:49 +0200
Message-ID: <20260512083949.3493010-1-christian.poetzsch@kernkonzept.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The virtio_blk_do_single_req function returns ulong, which normally is
the processed size, but in an error case can be the actual error. Use
the special IS_ERR_VALUE macro to test for error.

Addresses-Coverity-ID: CID 645833 (DEADCODE) & CID 645834 (NO_EFFECT)
Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
---
 drivers/virtio/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 45fb596a330..7b1d891cdcb 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -13,6 +13,7 @@
 #include <virtio.h>
 #include <virtio_ring.h>
 #include <linux/log2.h>
+#include <linux/err.h>
 #include "virtio_blk.h"
 #include <malloc.h>
 
@@ -181,7 +182,7 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 
 		ret = virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
 					       buffer + i * 512, type);
-		if (ret < 0)
+		if (IS_ERR_VALUE(ret))
 			return ret;
 		i += blk_per_sg;
 	}
-- 
2.47.3


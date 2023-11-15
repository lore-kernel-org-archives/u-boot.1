Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBA4C4332F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 01:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF63187063;
	Wed, 15 Nov 2023 02:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K4rKZWew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CA886FDD; Wed, 15 Nov 2023 02:54:02 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C574A86863
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 02:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc55bcd51eso5201445ad.0
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700013238; x=1700618038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hMvRjKgSagfGhAjd/ayWlVt7uZ7h5ZkFzJYGHzHjyy8=;
 b=K4rKZWewDAi0A+MDCj5UAs09J1h6Omk4FAaAiw38Otlt3TtD9Grw7D4yUaPL0uHnBx
 1x6q2WXvDaGN+hmvEj68Nx9CfYbE1oGDra+VWTPMwj6FSdvtO9QAteNrdGlU1sy6DxD8
 LnoGRURusIGl2zw7vQN/AyZMfdXwgs5Exq2iUxoBro4BM2l5ZRxlhrOTOlXkNmagpUKT
 LZSoxI78riopzCLQSxixAyArlgBfmnc83X7W+JP4xA/I879XY055qpWUykul/G8so8UR
 cm42r0mscM0v1vrH4/p0zJ6I6CEJmrTaGWBamjOBP9bMxMVIZxPRzkuFH7JzMEyQdctx
 qPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700013238; x=1700618038;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMvRjKgSagfGhAjd/ayWlVt7uZ7h5ZkFzJYGHzHjyy8=;
 b=J3MUXS+AeIpOGdO0H6k2S/WQ5k9fQrOVxAhKibykW8Oombl6K0XH29OqtDbnBrE25h
 c1hzqQoBeJNKdgotxhRYHWvCmx/sgXP/H6EVSkvod3tO78Sleqz6/+h+urXkFl2mVGfA
 wSrYLEQ9o+Dbes8e1wgJT0UBR/ajR/i2lKw2QNoSGm3TCCgIcsIsYbyAj9TM9EewZCUS
 fQX+AbUAZDSOTaIawZmbAlqYrxkm6cMJPR2qdHNqrNXybYYZkltArI+c4LtQXrCrWcaQ
 fQolB5nxVhIttNbp2qao+SXcNiduuDAdP/LIUsX0uir//OHPGwAnnCM3ue5lTZjE3tCq
 9PdA==
X-Gm-Message-State: AOJu0YxHQmWc3y0nFdcraA6cYI6B8nV9EvCCpa9i2MmZ2Xixj44p6mky
 6ouODjM1nQmqiV4bEIkPQMtnZA==
X-Google-Smtp-Source: AGHT+IErkTpaX2SIFsxN4HAX/uCk1I3Ba07icvq8ySI2bt3a1xI6yUCLuu5XkhwGo506EkD42sffxw==
X-Received: by 2002:a17:902:f54e:b0:1c0:bf60:ba82 with SMTP id
 h14-20020a170902f54e00b001c0bf60ba82mr1576126plf.5.1700013237956; 
 Tue, 14 Nov 2023 17:53:57 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:4b12:3529:888b:74af])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170903228a00b001bf6ea340b3sm6348864plh.116.2023.11.14.17.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 17:53:57 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: vicooodin@gmail.com,
	oleksandr_andrushchenko@epam.com
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH] xen: pvblock: fix the maximum io size in one operation
Date: Wed, 15 Nov 2023 10:53:45 +0900
Message-Id: <20231115015345.490313-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The current implementation may cause BUG_ON() in blkfront_aio()
	BUG_ON(n > BLKIF_MAX_SEGMENTS_PER_REQUEST);

In pvblock_iop(), a read/write operation will be split into smaller
chunks of data so that the size in one access (aio_nbytes) is limited
to, at the maximum,
	BLKIF_MAX_SEGMENTS_PER_REQUEST * PAGE_SIZE

But this works only if when the *buffer* passed in to pvblock_io()
is page-aligned. If not, the given data region may stand across
(BLKIF_MAX_SEGMENTS_PER_REQUEST + 1) pages. See the logic in
blkfront_aio():
	start = (uintptr_t)aiocbp->aio_buf & PAGE_MASK;
	end = ((uintptr_t)aiocbp->aio_buf + aiocbp->aio_nbytes +
	       PAGE_SIZE - 1) & PAGE_MASK;
Then this will lead to BUG_ON() above.

This can be fixed by decreasing the maximum size of aio_nbytes.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Fixes: commit 3a739cc6c948 ("xen: pvblock: Implement front-back protocol and do IO")
---
 drivers/xen/pvblock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/pvblock.c b/drivers/xen/pvblock.c
index 4ad548d599d5..1df04e239ad0 100644
--- a/drivers/xen/pvblock.c
+++ b/drivers/xen/pvblock.c
@@ -632,7 +632,8 @@ static ulong pvblock_iop(struct udevice *udev, lbaint_t blknr,
 			memcpy(blk_dev->bounce_buffer, buffer, desc->blksz);
 
 		aiocb.aio_nbytes = unaligned ? desc->blksz :
-			min((size_t)(BLKIF_MAX_SEGMENTS_PER_REQUEST * PAGE_SIZE),
+			min((size_t)((BLKIF_MAX_SEGMENTS_PER_REQUEST - 1)
+					* PAGE_SIZE),
 			    (size_t)(blocks_todo * desc->blksz));
 
 		blkfront_io(&aiocb, write);
-- 
2.34.1


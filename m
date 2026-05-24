Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF8CD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 23:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E9784671;
	Mon, 25 May 2026 01:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Px7GMSht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F45884693; Sun, 24 May 2026 17:47:56 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B48F83AA9
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 17:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prashant.kamble223@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ba928852a5so61341945ad.1
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779637673; x=1780242473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CsHj8a4A8LpbOWWYwlqjzE31bQMv4BWO45VzdYdV04E=;
 b=Px7GMShtypW31MZuNNFIMSc99hnfedaxkmUDbSWZrPxwm0cTwE29zl7VQkj7/+2Vwv
 wHW/1r4CxrMijV/TsQ8zhkmI3tYtpYfgmoE+Rb067j7Txqjo7qXHqfns4VoMo6UU5hSn
 MCigP69pdM+ieuO/0h7ordJbP62W2PLxU8VCPo8UK0n9hXLG9Gx+c3SI5S0e0WTGBa+Q
 Qdc/b4WE2YZIprlAn0lNluFJ/rY+AQcv7dwvifScc9Lp80MyrDRxqQWE3A1LzoZUu1jq
 Mm6NJ2llCKwa79Mo6DDId7lNOZbKjRICoqvG15zjeg+8NJV/5f6iWG6KM33KIb9BATfZ
 4qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779637673; x=1780242473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CsHj8a4A8LpbOWWYwlqjzE31bQMv4BWO45VzdYdV04E=;
 b=RHEmjDb8DFQStoYfPuh88hayv/rSPD/BxUiDlJBdpc5HCS+elU7RahX5COwOJiWtD3
 4RJejZmeeCX2YA7hIDf6Inw27E22b2PapP1s3Wq3srBHBkI8x2SsNKTbeaRvS7Cb4SrT
 G6MJKkHHkhPcQF02/LEJlv5Es47BzMLDrkiwWmRjJMgpZ8f3Xdf9gJXYBz2QWukqSH/c
 gCq/hVhI2gVYmN7y9VQGCgc7kefPoXCYJChdFpmblNqC34TjVaw+0Bw70bZl9l+qhUvy
 OIBb2fw+jHaQ2zVePz6fb6WmHp4le1dPOO0++iUQsS2s7FsIoS8QZeg7LFmPW9RzfeRz
 2BKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gMOfEb5PNPyvzbQnPipYwEAqwvxc7yskXuGdNjXMqO/vx8MldehI+O87BtnxJuFXRltH//38=@lists.denx.de
X-Gm-Message-State: AOJu0YwHPYovunLxFuO5G4k8X1WvYj9S97EAR9jif7L1rbrPdQQJsW5V
 WANCgMuBEzWyI0ajAh3RavxxvobUKtkm1ZgvXsJxUURy/uVM+wVbAY2z
X-Gm-Gg: Acq92OHZtgDh5UlCy3lvNFiAVPA3jBYJjzKrkAg+iQrUbVGs93C6GYN0xPdcLJCJjbZ
 ChwTIB2q6tSGoycHS2ANZH8ic1jdQnbyM+VBy8x9hbLs/0r2KmmIBm23dA96xxtjJuWhdoXF9VR
 SZxBm5xXH9vgrqvf86at8w0paADnbJW6lzlI+iVCDR9HgvPtRB7IN4+HyC7NMwtFJoDvG2TQKbr
 aX+C7i+EzNAtrdKN0zogioPph8TYgYrPiJWhaccrcHnZu7FxV3+eCMXRIli8bTcX2RE9MOPIaA7
 O6Il5Rse4bJufe51mQO6+sfs1yUzevAE5fwFr49aR6WqiEztGXw5cYZQ6cJ6Y9SnOz9w2fLJgR6
 hYaAGuyPstbtey5t+H//hSuckPlZwVcPpkzfaD4H5ZkWGxU8+sBN3N/fLBxpQYtPDq6n0lKWfuA
 2fBKhhROylGZKWDfZjn26R5iM0FIhFuNCGqHTu0nQuWirj70NToS0jvea/1ZZLD7sIt+wycZUWM
 qg5fJuUzQ==
X-Received: by 2002:a17:903:17cc:b0:2bd:4b8c:fd30 with SMTP id
 d9443c01a7336-2beb085c6ebmr122894635ad.41.1779637672607; 
 Sun, 24 May 2026 08:47:52 -0700 (PDT)
Received: from prashant-Victus-by-HP-Gaming-Laptop-15-fa0xxx..
 ([49.205.205.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5695c4bsm67877205ad.15.2026.05.24.08.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 08:47:50 -0700 (PDT)
From: Prashant Kamble <prashant.kamble223@gmail.com>
To: 
Cc: prashant.kamble223@gmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] nvme: avoid deleting uncreated queues
Date: Sun, 24 May 2026 21:17:14 +0530
Message-ID: <20260524154718.16381-1-prashant.kamble223@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 01:11:45 +0200
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

nvme_create_queue() may issue Delete CQ or Delete SQ
commands even when the corresponding queue creation
failed.

Avoid sending delete commands for queues that were never
successfully created.

Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
---
 drivers/nvme/nvme.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 9df7824b1c5..980ca919632 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -298,11 +298,6 @@ static int nvme_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 	return nvme_submit_admin_cmd(dev, &c, NULL);
 }
 
-static int nvme_delete_sq(struct nvme_dev *dev, u16 sqid)
-{
-	return nvme_delete_queue(dev, nvme_admin_delete_sq, sqid);
-}
-
 static int nvme_delete_cq(struct nvme_dev *dev, u16 cqid)
 {
 	return nvme_delete_queue(dev, nvme_admin_delete_cq, cqid);
@@ -563,20 +558,19 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvmeq->cq_vector = qid - 1;
 	result = nvme_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-		goto release_cq;
+		goto release_ret;
 
 	result = nvme_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
-		goto release_sq;
+		goto release_cq;
 
 	nvme_init_queue(nvmeq, qid);
 
 	return result;
 
- release_sq:
-	nvme_delete_sq(dev, qid);
  release_cq:
 	nvme_delete_cq(dev, qid);
+ release_ret:
 
 	return result;
 }
-- 
2.43.0


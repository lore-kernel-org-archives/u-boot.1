Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29B7CD4F48
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 07:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071E883FEE;
	Mon, 18 May 2026 09:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UKeh3yz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34C884664; Mon, 18 May 2026 08:09:25 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C2283AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prashant.kamble223@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b9ec9443c2so14609465ad.1
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 23:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779084562; x=1779689362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T7jx2/cAXQNNFsrtNR9USrRB30+wuXE24E7grvoCneY=;
 b=UKeh3yz/+FzcV4G6hxmMTFtS9kg4iJLKZPpaO5XqZe6CQ2kE1bACPXME9vK0s8dN0u
 blgl10PxfQDT2qVENKuwxO2vxN5adzNFusqqYuS7sOG0xywjRAuKI/VAjRAyOrtHrbm1
 x2o3ykgID0iUplM1ZGN5Kz+Ynj2yrAWHv8RLDQnAr0z1aEJ7ipZHbocsEmdSX9h3gdJn
 3hG3DL5wbqXcgKrDlRR2KV8ETWKU6DUIYq6O19m+MT1CIsrT3O7ZAyTMLmTmgEBbtjTn
 aLjdYaW1E4yZHOxAndoCDZF88mIUetUIFEX7XqevEzjGDr7skOtw1s5K7RlJ2JZUa2hw
 qrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779084562; x=1779689362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7jx2/cAXQNNFsrtNR9USrRB30+wuXE24E7grvoCneY=;
 b=RBV06FRh0R6CVT8OQdrqZf67XWqXQ1SHgGDwQN985UH8Z6J9BJLOGlCOUlhAt/DS43
 we/kowVdD97/NwRRQnh8OAm8BUbsZK0XoVukNcdELWfymAmwN6miMBKLQbACEIjXiNjG
 UO6PEaONUf3PrcSR7z+oqJWGpHiVqAeB3IyIZBut9UitFjosG9OMdS2uwXmXJi85tzbL
 Tql51ggz7Hx7sIc+E3q+2m4qmBubkn48N1uaQdcwzGmBaNmPObz+bz7ZVrqxYqGJs5ak
 wia57rNQfYayeCAwqaB2KxKO57d/KocCnkkZ4Zp98RcK3FXibAgt2BMYgTgwYi2LrJ13
 aC9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EY2CMeFJBR9bgy7CsPcfvQnDOQ2YeDs+6Z9O7RtLeeBvu9oA9fBS4TL2CatJFWoJpxiTwoHw=@lists.denx.de
X-Gm-Message-State: AOJu0YxoPPw4mqkB/6+2CVB+5Ql6VPDAWgkQ2j0QPx+m1PYV5NCjn/1W
 dQQN8v/e60d/urh09GXgVUlWAcwoUevUCqW4nBx94rkliCnnLd0FFiix
X-Gm-Gg: Acq92OHjjKDd/oXr8kMsLt1LqeOpeD8CBC/V4fdpkkst0FbCgLtnnA7+VcSwhvt7dIT
 UU33CnfKyIgtK+bjIby+Sxs7WRBi3JWKwlEB7bJ3p3CKwDeJbaNvlrZxuqoDxoMl06XsovSjJIp
 FI+HZB+QhBJO6Pagcl1RDX7aE6iyhwX3uZDJ+fe4gluQ4dwLYp8kSCkOvdesOcHfA9zpJiRnuoI
 vUoK7RsMIZuILora21IGX/4DFqrpriO56DqgkMmwLexblJFD0Xf72CfNsNsf621NWdnJxi3f/aU
 qA421af1TEZYdo9rp1mxkD4r+8bYo41xnBYBj/qoeccQDL10lhsIo3cOveM+bp2seh5HHJK5Tps
 A9Lz1HoIzWeSC9P0fu0gqdSZhqAyg05mAxQDdlNd4bZioTnerMLwXmIqrHBXSqVtfQccT7EmVQe
 MUNFvtiUQ2Lln2jC2FrzYQcPt0bCcqhkf0e0uxaklJZW8Nh120bStaxJDGzJRpq2e3lvzuVCFu2
 bdMeYgsWIwQuw==
X-Received: by 2002:a17:903:1786:b0:2b0:506b:e6f8 with SMTP id
 d9443c01a7336-2bd526ce854mr165885375ad.5.1779084562118; 
 Sun, 17 May 2026 23:09:22 -0700 (PDT)
Received: from prashant-Victus-by-HP-Gaming-Laptop-15-fa0xxx..
 ([2402:e280:3e1d:2f8:2784:8946:6812:98f1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5f291sm140114075ad.15.2026.05.17.23.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 23:09:21 -0700 (PDT)
From: Prashant Kamble <prashant.kamble223@gmail.com>
To: 
Cc: prashant.kamble223@gmail.com, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] nvme: fix command ID wraparound handling
Date: Mon, 18 May 2026 11:38:44 +0530
Message-ID: <20260518060915.45607-1-prashant.kamble223@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 09:24:19 +0200
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

nvme_get_cmd_id() returns 0 after cmdid reaches USHRT_MAX,
but fails to reset cmdid itself. As a result, all subsequent
calls keep returning 0 indefinitely.

Reset cmdid when wraparound occurs so command IDs continue
incrementing correctly.

Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
---
 drivers/nvme/nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 2b14437f69c..4f9473367d3 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -112,7 +112,10 @@ static __le16 nvme_get_cmd_id(void)
 {
 	static unsigned short cmdid;
 
-	return cpu_to_le16((cmdid < USHRT_MAX) ? cmdid++ : 0);
+	if (cmdid >= USHRT_MAX)
+		cmdid = 0;
+
+	return cpu_to_le16(cmdid++);
 }
 
 static u16 nvme_read_completion_status(struct nvme_queue *nvmeq, u16 index)
-- 
2.43.0


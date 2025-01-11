Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5064DE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AE2806FD;
	Sat, 11 Jan 2025 01:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VbzJLDSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC4A80050; Sat, 11 Jan 2025 01:01:13 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC94D806C6
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844bff5ba1dso173770339f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553668; x=1737158468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNzhiYaDuSY2qfMKKPj+FTxYW/XZvJ39nNjskChGRyY=;
 b=VbzJLDSrC1zA+CURqFCWcMsn77XVcZ685NVOQxvHfJ0PEsGuzK7sOSGpwE6upg6LVa
 qsqu2Dr8kLXWSobKu2S+cBEtYmWwXeGXM/5eje1uYt9rZg90OJjA3+S5rvXSg9dXaU9A
 3CMWq5lCzhSeUbPVCLcVNMY4i5J8F27KFu7aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553668; x=1737158468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNzhiYaDuSY2qfMKKPj+FTxYW/XZvJ39nNjskChGRyY=;
 b=Xz2GYIgrWQFawHFtzXSLBGLx4Jhp3OFJ60eg8Y/eg9E2ZbRDbJUgpnqEBmvi9nhkCC
 94oXKrPEujIu7RgBS8GeP1iwqmWfBnBym7Y5RoKZ2OwwxTV+vFdBYKZIQb06RJt7G76t
 HGyEY1izNb7GWU4ofsY7CwVCt4UWvVsh0uToMpy7gO3d+mHj/CuzJpdEhmcrqxfMYL7K
 XyNqMqQsIvrqs4VyMEPzXOtRrWVgx3ZZauTgA7P/A8tiHdOO4Bo3juQkJr4frYHFMSGK
 N/2aJVPitU5oT+2hYGuxcDer4FMQmTVw9jgdkkrsJnGfyhD1YD2BCFsYzF3PWH33GdFM
 sX+w==
X-Gm-Message-State: AOJu0Yw0KwHfjZisC6dpvY9VIrnt83Tq+9BQB++V1ZbPjKixq1S1X5Tu
 11CAZCOwlguSWvcpHs+Dumzs9ADtwcCvBD8AmiY5lUuslZ/T62ljKxaPJz+n8rMje4+QBgbXthw
 =
X-Gm-Gg: ASbGnctW7LqFRhC6EPLvK3HxdinW7lWGXH7D/CsKS3LFwTw69Af71MF3wawekKnQi8J
 fupdCu7JWdIkfndC5FFdZa2RA16PYj/SBdiYKiuHMzjjUJXbPKan3dKH+R69blfkgPf0J8ynuh7
 UCfQkIW0BhnGGx14++x2ohqc9+2Cc16y6Wh8OFdYL3LrBmXkwaOUIIAS+ZGaXwVFnllaeeu+UZw
 VXg3LT+gHGVfe3oU+oGdLYmsBxmEd6yTm4Yda26XmqbwePmb/nhVagmQVHem+d9JrdOmZvx/5UZ
 7gDN33XT008dAvl4ig==
X-Google-Smtp-Source: AGHT+IFVDckHOYyycB9SwpMoIDkHY4CJ/GRPLpX9Fr3D0PlZ7UL2moj5PnPgDa19l4rMyPyu0vcZJQ==
X-Received: by 2002:a05:6602:36c6:b0:843:e9c0:8290 with SMTP id
 ca18e2360f4ac-84ce00bb460mr1277116439f.6.1736553668613; 
 Fri, 10 Jan 2025 16:01:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/30] ofnode: Use 4K for a default tree-size
Date: Fri, 10 Jan 2025 17:00:09 -0700
Message-Id: <20250111000029.245022-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

At some point it would be nice to have the ofnode API automatically
expand the tree as required, to accommodate new nodes. For now, expand
the default size so that UPL can be supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/ofnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 950895e72a9..ec03f6f550d 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -118,7 +118,7 @@ int oftree_new(oftree *treep)
 			return log_msg_ret("liv", ret);
 		tree = oftree_from_np(root);
 	} else {
-		const int size = 1024;
+		const int size = 4096;
 		void *fdt;
 
 		ret = check_tree_count();
-- 
2.34.1


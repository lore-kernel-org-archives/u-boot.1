Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D788E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B9CA80433;
	Wed,  1 Jan 2025 23:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hOdSglpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40C680317; Wed,  1 Jan 2025 23:11:45 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0AC8031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216728b1836so129038495ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769501; x=1736374301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w15osNbfOpEPwrAGm5W6f+A8KLCMapRl0DvpZ1rBEKE=;
 b=hOdSglpzR5kplj7Hp+f4KpZKGZPfXMntu9jYmh1+ckQupCaFIq+DMuoil2PAGI9AvL
 9c4GGskW+3T/IIZ+GDWz840bLbGgnHuiq20TTcnssX8L14BKsF2aeIsx+L8Y8/yRKKU6
 d7AU2ZaQ4T5PnSfj09SR/HkpmRzp1Hb9tNwRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769501; x=1736374301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w15osNbfOpEPwrAGm5W6f+A8KLCMapRl0DvpZ1rBEKE=;
 b=krscORJ4EaV6WsODh5wc6w1SpTk8M4HzRVdOqSPOCWOXZ3SbNauLAPZwbRc9PeQSz9
 zXOeCT9JleIRaCgqctaQ9CsvBUqmZw1g6ZJDyrKsYlNh5uU53f88eRv7vzkoVT6/4zL5
 9Ln+n9ZyASUaynHudl6eGwaJS4FGjG+PHYgWuuTpZBUiLS3hvs7XpyLYWK21GvM3CSMl
 P17Oo9porfiAoxBPrJ56eQTGMth/iWouD6hnZ1IzipvInu42bIuE5R5XIEjV4mej+P9K
 /N1R6g6TfUYiJbuDkbmOAajmZLGXmQR8bLUkYlRYjPZFY3zglqd0Bz1mYseIKxCA638L
 2ZIg==
X-Gm-Message-State: AOJu0Yzo5tLLereCGEUHFVd3VxsI6VNfh16phN4RRDb4Vs6kZN/rbx31
 b0wFIBp0BbdKiJ3MNpdIQebBiaOEJ+bDILD0+qtJh0RV+pMMFMBNLE37kKnVZ++Xpf2YhjGMKfM
 =
X-Gm-Gg: ASbGncsK1voC9ZKkEK+hbzNrR5WxngHzC4n8YcnnHYElMoQ5r2hEBd6XgWyy/NHnOLV
 tFd2xoX0CtlinjyWX2Vp2UmcRDvb7u3BqFmyKds+HJSyJMjyMQ3MlE9TLQs9XE7Y7ids9iKiZ0H
 7IEHRX9nv1uT5NzMgKn9b5zmcJKcRsFDjaXlSvwWV7JmJ8OPBypxvY8zqY337kphWPSWNlodEFd
 hN4R9HCs/76xPZ3IEKZdusIQexhirxSOxQE72agxrpNRYTc1dajIhQ=
X-Google-Smtp-Source: AGHT+IEWLkDZezVbFFDEU83Omet0igMfi81CMrFjv6g2q9mRdq1MXu0skvOw143z5Gy54bztGDcNfA==
X-Received: by 2002:a05:6a21:999e:b0:1e1:1d7c:4cff with SMTP id
 adf61e73a8af0-1e5e08184a0mr72732755637.37.1735769501629; 
 Wed, 01 Jan 2025 14:11:41 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/67] ofnode: Use 4K for a default tree-size
Date: Thu,  2 Jan 2025 11:08:56 +1300
Message-ID: <20250101221003.1944600-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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
2.43.0


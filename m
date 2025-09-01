Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202C8CA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 15:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7CB83965;
	Mon,  1 Sep 2025 17:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VkrrXNWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D56B7839F3; Mon,  1 Sep 2025 17:17:47 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D2A831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CA7F3F284
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756739865;
 bh=Vm8K/xrI0NjNXkRHzjgBkT4FxnD19BMYWfAppajUhwo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VkrrXNWVihgO6rhUOMMcBv+3DBMVYesyKtHbHFpbKXdKgO7H6esZJcvh3jMMyCuu4
 HQ/EETf3gapzuaf0yB/7keueXglVaTDhGMQOoPjOhg/GCgQimnGejnLz/cTIb1nA1m
 ETk+SlJd1Ocefpvh0pSKir2gxHcVsXBZGZPLapObTTaugPTYIqbJMS+U9w3UYzJ0j0
 K13LQeQEj/69N9W7TlbZpJgZ8RridpP6F8hpH1hcTlSj3IltpLbhFzUbG4wH8VIIUs
 qIZqXxo6w5Eh16y/P9o7Ry5nlVbQVM+1SAXr3qLmJMYCTJCkUSaciuLoHtGtBpFmFO
 S0NwAXunDAEBA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b8af0b8deso7557465e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 08:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756739865; x=1757344665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vm8K/xrI0NjNXkRHzjgBkT4FxnD19BMYWfAppajUhwo=;
 b=gSZF714//QI+Gf3KpYEe0d8jg9uPUaaTJdLl3t3joSmW8TvE9gFcDCkLBv7p6kEyn0
 PtadxNp7GHsA6/XJzy0vsIg9AIc7KHgxeaJqG+saf0A0x1G6AVQXd0/5tDzkdmLO/ruo
 /zykX3ug4C8FxC+zdmq+yrYfYZ2s7HBNXvi1lzTGoIUta0ajFOg6y8XX7UXL1jtf7qU4
 z8eB4YYJFjqAnGakToSNHM72NvTWZqe2vMqFdnlRqaytAiqv0tupN5RDkagDEvSZE1j/
 PeBqNXDddBbve7A4m68cEUnuLVs9h/osaRvVFVV3ux716rYMESrOsBRtOWU1P8GC7TxP
 JVJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLnvKCjgy8yMiLTzxKQfWtZkpOfhjZeiuswABss/5ElOqkyWWzmVKUg2xeaW6fCMVjXvISoFw=@lists.denx.de
X-Gm-Message-State: AOJu0YwaPq/33CYkkl84IOCwUPfQkF+HrxidGIyn92sit0n0QjeqN5IX
 VuWp//mUtcCPzV6DJymLVH87D1GqEJ4GfLjM89bT7kUoIXOa98FluDMEeUPum1ICFeTLeRoMGng
 T/4ZqbqKOx8ML6t43mgZI5PCgz9xzaULu008Ps9KfI5HORSzOpV1TUKTFYFcc1BYVjEfKk7s=
X-Gm-Gg: ASbGncsvHcBggc6cZXG941KNIEIXxgqT2rla3K+uDPvmyP8YRoixTD0MUMPbm19DifE
 cKM/4jiJC5fvkN5FylTvBPzQooHlP0QV/YH8UwHPTcoQImCgF8LgbDq0CJrO8xJF6hGJy9FrfLn
 EbzjJNoZAlzmpBHvZ7YuBIwhFfnQVzS3PWr8zaup3C4hcedAgihsqHU3oAlV9DRO+dhTSfYp84B
 C8BRbSUP3zYksZisNKWhv89b8OR/ut0nBusOtGnfNCbJPPvu+mPUkaVEs675ChiYeUvS1IasHA6
 RyXuv6yjbuQcyujIH7jCnu21LSNrxkk/OHup+U4ZMkqNI7ScB2BeHoMOALzNpQpsVQ+bJ2wjvhI
 0IcdZwDTEkLNHSUgZx8OBQThwhr6RPJw=
X-Received: by 2002:a05:600c:4452:b0:455:f187:6203 with SMTP id
 5b1f17b1804b1-45b855983cfmr58127625e9.27.1756739864893; 
 Mon, 01 Sep 2025 08:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/+2wAn+lwmtkkSHnsMZ/9atH4naZUL7CflOTfU7eOonH9pyP9q/2Qduv3y++h+AzXU0OUaw==
X-Received: by 2002:a05:600c:4452:b0:455:f187:6203 with SMTP id
 5b1f17b1804b1-45b855983cfmr58127415e9.27.1756739864503; 
 Mon, 01 Sep 2025 08:17:44 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b838ddbe5sm137175855e9.16.2025.09.01.08.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 08:17:43 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] bloblist: use correct types for physical addresses
Date: Mon,  1 Sep 2025 17:16:35 +0200
Message-ID: <20250901151635.654928-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.1
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

It is expected that bloblists are stored in high memory beyond 2 GiB.
We must not use int as data type for these addresses but phys_addr_t.

Fixes: f9ef9fb033d5 ("bloblist: Handle alignment with a void entry")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/bloblist.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..d5fa62249a9 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -149,7 +149,8 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
 {
 	struct bloblist_hdr *hdr = gd->bloblist;
 	struct bloblist_rec *rec;
-	int data_start, aligned_start, new_alloced;
+	phys_addr_t data_start, aligned_start;
+	phys_size_t new_alloced;
 
 	if (!align_log2)
 		align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
-- 
2.50.1


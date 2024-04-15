Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88B0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405E588190;
	Mon, 15 Apr 2024 15:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cT3rSo3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE54588190; Mon, 15 Apr 2024 15:01:33 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0451188158
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ecf3943040so2460236b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713186086; x=1713790886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1WVZwLp46L2pnHQ6Hu8ODBrXGj3biWEi70cNzjTJDs=;
 b=cT3rSo3hZlXdw0zecBRlpI35z9IlVpoq1dxYuaN9YjBzL/qqM32Kb3of2NTwikqob9
 6xgzQWwERqwDZPdE+lmnxj72UUrzJSILJZMj6QEitKLexeELoVAU3RGNMjriur2Fwbkm
 ojV6OjKyyjFdqeJFQq8RE7M5jcmSYo4D2zlN8rhU4uRQ52t6naks++snUqYagtV3L0fO
 KAyBW3HtouSJjpnuLSE8gvv89K1SONVMbljjYTecziZSca/S00cYwFVx6ypeJA4PlxAM
 x7Fc4ZfERx4dYI2ZHK0SnKNuPlqLYdBUNJSkQw7NJtufUh4nkIwnIe/FQmpJDJQbVYL6
 YB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713186086; x=1713790886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1WVZwLp46L2pnHQ6Hu8ODBrXGj3biWEi70cNzjTJDs=;
 b=gDDPKfX/qu7ig2xr7n8UdWGNb+lm9NRCsvFsW3RjmWguXQVNhSx7nPNzuvy8p2vmgq
 c37jCW7Pj/6BLg8ulmJkBsJZLz4k8s9haEcmjo6pE0sHPflPp+P2+t8gShmg29o2hZ9N
 pGA9gNQeNjppzfaGRxKpaKWkJEPA5YT6OdqjfWx3ylr55G2uLmTtByJeHqjKM4oJ9P00
 kuNQiPVWjNBErHAiwzvfVmrn340ak1zCiKbCNJnXWCkdA133LamdCxg5DwVvoaW93wj3
 MZmEwPS+glJ8UGfZy47fdkpWzCBBIFTGiI4poW6UkU2WQOMOB68sm/xKumXuVoqAVU7p
 wEBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0Wr4RjdwLfacpliVu8xyMhY6rK0Q1R3DkpKhdaq5GULunKIejjfwrB0CRamy7uYwWJDQl24ImSvj4fjMJGqkvNg7jQQ==
X-Gm-Message-State: AOJu0YzbKbGfYJ6Ng5vlCcuLIl7+V88aeGFMivuRgkMnnCpUyDf9BvQD
 nGWic14kCR4XenM3vOlCyo9TW/LwVFsLVRK+28iKGd0zoVz+lLwU
X-Google-Smtp-Source: AGHT+IGb1hGRpGFOzAtLmjldoxV80uVAyAToyGfbq79cpG53flge1RWu1sHoRnmxSdKtk/W0BeNtUg==
X-Received: by 2002:a17:902:6f08:b0:1e4:17e4:3a30 with SMTP id
 w8-20020a1709026f0800b001e417e43a30mr7911813plk.31.1713186085530; 
 Mon, 15 Apr 2024 06:01:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:d0b1:1308:35d6:2c38])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a170902c64300b001d8edfec673sm7851075pls.214.2024.04.15.06.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 06:01:25 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
Date: Mon, 15 Apr 2024 22:00:13 +0900
Message-Id: <20240415130013.26721-2-yasuharu.shibata@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240415130013.26721-1-yasuharu.shibata@gmail.com>
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
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

If tcp_seq_num is wrap around, tcp_seq_num >= initial_data_seq_num
isn't satisfied and store_block() isn't called.
The condition has a wrap around issue, so it is fixed in this patch.

Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
---
 net/wget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 71bac92d84..abab371e58 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -404,9 +404,7 @@ static void wget_handler(uchar *pkt, u16 dport,
 		}
 		next_data_seq_num = tcp_seq_num + len;
 
-		if (tcp_seq_num >= initial_data_seq_num &&
-		    store_block(pkt, tcp_seq_num - initial_data_seq_num,
-				len) != 0) {
+		if (store_block(pkt, tcp_seq_num - initial_data_seq_num, len) != 0) {
 			wget_fail("wget: store error\n",
 				  tcp_seq_num, tcp_ack_num, action);
 			net_set_state(NETLOOP_FAIL);
-- 
2.25.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDBDC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 00:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C77A87B1A;
	Tue, 16 Apr 2024 02:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZR5Lm39J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A266878ED; Tue, 16 Apr 2024 02:30:11 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A748787E4D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e3ff14f249so29396335ad.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713227407; x=1713832207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NnrzLHjFPHPzIsRwImRSFfeIzofhfE0BHGpS6fi4KEI=;
 b=ZR5Lm39JxUpp+Z9PgVUjJLu78fTkbnNvTRMMKWJZKyU1298OrRXEnOJDnfdr1ddnxY
 yZRLGO2xTzHMwWlfc1zb8Pd8le5w8jeIyV+EadHfvvGQ6ciJJDQqdwJixuDs4TB6QeD8
 Z5L0qL2cDg0f7TESUxddpACZ7/FeM8LyhAHSTkMMZuOAixk3alj0BrWrk+XuQCW76Ah+
 3ZUXjy0MsY1K6tx/6LFL3QV4dz8GBQUNH38KH/FrS/ATaZT3H0y/UtX66f8rjWrIYaNR
 s8HSuMteNc50SqHdclWOfS1PIY5TDiKz/qIjjKk2mG79w7Udz6s6ZShq5LsqqLF+LPIV
 49Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713227407; x=1713832207;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NnrzLHjFPHPzIsRwImRSFfeIzofhfE0BHGpS6fi4KEI=;
 b=wfTbzQPcanHc3Koe3MZ9MX/9HG2q3QFQTP4kJIPISwg5g3czih6MJJNOl7SBabARIw
 shFb08NI6M1qXPrv+EnSXGz5M1xjp5g19k1gyJTUGkphiL1i4S8yDlFQUJQXEi85X5Mk
 yXhpr5K8z19/7LWXmeun6/pbMM8fWyyMd3z5r9fkHrHLYTz957ODf3yCOQsDQNB85hUL
 YwAAOgJ6OUvp2QuZ8Xv+nA8Erg//iij1PRyfputhBUw1zQ5z27Bb/XbolXf+86wj9y+k
 pakPdyv+sl0CJoxEUAhB+jRLujISRcifyQ/oDJ3dpAWnpUR3iKPz9UNjKIYRnD0QVDAU
 XmGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTiZzjpjQmt7b+4M73kgfQvXfbbdY+iVRFKNTBcAcvBR8zCUjzJf68GxTmzLzD/BOcProL2h9jNp73bN+Mu1rOWX0hWw==
X-Gm-Message-State: AOJu0YzqRYNB/gS2zQcX2CuLe79JAwFKHpfNeE98h1444JsoaqgIaFRr
 mTf3Lqusi9cajeLs9BbFqJK1f3q3mLVwYwfheaLUAG8XiLU78G+5
X-Google-Smtp-Source: AGHT+IFOW9BjzMMFnt6FpS2ltOk9RWOos6vbjHodeDdJ7klmX5DtWusIGnsdV3/BHnI+MeXqhY+mcQ==
X-Received: by 2002:a17:902:ea04:b0:1e4:39e0:660c with SMTP id
 s4-20020a170902ea0400b001e439e0660cmr1498882plg.23.1713227406925; 
 Mon, 15 Apr 2024 17:30:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:198a:3f5f:c5af:35a2])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001dd88a5dc47sm8547528plh.290.2024.04.15.17.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 17:30:06 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] net: wget: fix TCP sequence number wrap around issue
Date: Tue, 16 Apr 2024 09:26:24 +0900
Message-Id: <20240416002624.1909-1-yasuharu.shibata@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Suggested-by: Michael Trimarchi <michael@amarulasolutions.com>
Reported-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Fabio Estevam <festevam@denx.de>
---
v1 -> v2:
- Add tags in commit message
- Link to v1: https://lore.kernel.org/u-boot/20240415130013.26721-1-yasuharu.shibata@gmail.com/
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


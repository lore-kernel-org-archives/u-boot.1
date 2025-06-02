Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC74C54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 06:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A608291D;
	Mon,  2 Jun 2025 08:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OYCM4h+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244D08296B; Mon,  2 Jun 2025 04:18:57 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5876828F8
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 04:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2352400344aso24503355ad.2
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 19:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748830733; x=1749435533; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wzrrr4ey8IEQUWzl1L7GG68Ms/RzhVaVjAS1jgn+uxY=;
 b=OYCM4h+w0k4H2yhxUcACbRjMfHc8aVgiutHGu9TWahSODGxTvhW5inGWSrTAkRqSz1
 NPOr+J/eReFVoTrVi5FBVuJXgOMotxhJP5tiueYECtiOXnYfbvZFQzeLs+KzhOkvP57c
 uo4rOSQK8YtBPc46phdpkSIQkDBTNxUn7RcZ5q3WItR5fTThczkQUE4lvArEHdEYyOmA
 vIaoCM786Bjr/AyGKax2sPaPUm4onKf7MJ9oblNMAhGOQhMKcrXl6uPdsZcBCSlFN1r1
 cCPHLhlCrHnq6d3MeYX/8cwWMHJuu4NchfzGrB9V+/BT9rWuQp/IvTfxPKFFJ8wNMoCw
 qusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748830733; x=1749435533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzrrr4ey8IEQUWzl1L7GG68Ms/RzhVaVjAS1jgn+uxY=;
 b=iUwgJRDH/AIA+Gq4zbFDDQmG6+qanRGyngfXdEacH8TEf9PIfsbYRRyvyF9uyGdZJx
 1ZK8qfCkzqja8k2ZSkzVFNkUJvOhgcQXsL8RsfqkP279W02AQAkcL3E8KHuxruZBpZga
 TOgUX6wGVcKuIz9u4mbkVKBE8mOaxL9AJSMrjpfuOt3BndgQv6lYxgzFxrPYzTH59SQ0
 zbsFoqfAPFQiJDbVIHmtOWox5cOy/mBvIPu+ub8w3+Bo0IJWvvxrSGah8fNQxKy4CAN1
 e4Ejdngb+JAiM6Nlxqrtz0YsLdWLfIWJDYxJG8WZcJRkX49E0isljfRIPiZ1+H1+Qe62
 XjHQ==
X-Gm-Message-State: AOJu0YzxWd5GK4IBV1DtAUPxGj6s+U3Zg/Rqjl9SyIUJESHCYCrDAofg
 iyaVbAVhzocB4qjeTqixMrFTlkwFZrC4HvM2FI2XcwNY1roH6aGH0wau0KORBqAM
X-Gm-Gg: ASbGncvVhol1Z9KnLpeLyCMnjeEWfpDXxn5OMvOzBPHsh/ndoTIfg4Qj/37ONeq+hmI
 yKrXWiQfNbqmOGDAKazBXWxMIjUJWlnh7i1agSMtNbK4Av31shGNjH98Kj7bJZAi98hacxC0NMC
 32wTJ8Vjs6MAj9P2pnBzvwGlKDp1h00KUsCuSj9xOusChGGoZ7es6+3Q77AvATfnGB0ToqvPD8Y
 ccl9QBJ36ZvUfZ9+wH7wtSY5C6WaWeqItJsen2I/j6V5xgmM9Tah1xJebH3JJSWaPWjtVcoA9l/
 9PFEXhXnVF0l5/DhbZMBq/UfXHCOl/8yNqd2JOq02VRP+88ST0iowakPPP5CrYOF8F0vP/H4bmM
 IMVF8FbUK4dxlU0UlEspJHPrMwlJiQ1rZa1JiJZ/e0AQ2GYM=
X-Google-Smtp-Source: AGHT+IGivylE04Gc+ZYwgMRNxnFragSUqqpaMA5pTFxFoDUuqY1lvupt2C4waFa+fXGswaUkTZA/0A==
X-Received: by 2002:a17:902:c94c:b0:223:653e:eb09 with SMTP id
 d9443c01a7336-23528fedb5cmr149908935ad.7.1748830733137; 
 Sun, 01 Jun 2025 19:18:53 -0700 (PDT)
Received: from noble-leuven.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bd94a7sm60885525ad.93.2025.06.01.19.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 19:18:52 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, richard@nod.at,
 aristo.chen@canonical.com
Subject: [PATCH 1/1] bootstage: Fix typo
Date: Mon,  2 Jun 2025 02:18:02 +0000
Message-ID: <20250602021818.2277-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Jun 2025 08:25:05 +0200
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

Fix typo from heder to header

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/bootstage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bootstage.h b/include/bootstage.h
index 3300ca0248a..528d0ca0614 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -73,7 +73,7 @@ enum bootstage_id {
 	BOOTSTAGE_ID_CHECK_RAMDISK = 9,	/* Checking ram disk */
 
 	BOOTSTAGE_ID_RD_MAGIC,		/* Checking ram disk magic */
-	BOOTSTAGE_ID_RD_HDR_CHECKSUM,	/* Checking ram disk heder checksum */
+	BOOTSTAGE_ID_RD_HDR_CHECKSUM,	/* Checking ram disk header checksum */
 	BOOTSTAGE_ID_RD_CHECKSUM,	/* Checking ram disk checksum */
 	BOOTSTAGE_ID_COPY_RAMDISK = 12,	/* Copying ram disk into place */
 	BOOTSTAGE_ID_RAMDISK,		/* Checking for valid ramdisk */
-- 
2.43.0


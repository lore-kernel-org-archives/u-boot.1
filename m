Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A8DC3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4DD889BA;
	Wed, 14 Aug 2024 14:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRlp3aRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FD2889D2; Wed, 14 Aug 2024 14:47:18 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3170187C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso47876085ad.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723639634; x=1724244434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qpS2dT9NcrP5zDUy7TgyqHj0rv0rOHLeAGet64kFsSY=;
 b=DRlp3aRcdUY5JaGJn8ifwdOA27I9blG58+zjhk60jdyV+ZG105cVo9/8aOyC/HeTym
 p9yVHoDg5xBPd/7feXaixPfmS16cbEJ01Yu9TXYSR246qlC8SQ6NwERvv/mkktsmSuwC
 qXHkldv/ya9p3LAzZdzVuWSWR5QahrvXgY26GJCKEqOrEDx8ES211cAGKoPzJ3zFo3Du
 LfkrZCmCVz9x8QvydOopVJEOUgvIatpibhTLEaMVGrv1Ebd6g4fhRiKcp47LEfjup70s
 UJhXibcHC6MkZhErSdnjkitRuPl8QaOXrt6IRz4NlsKcmnZjkwFtfDYWNqoOjUJQsPd4
 DOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723639634; x=1724244434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qpS2dT9NcrP5zDUy7TgyqHj0rv0rOHLeAGet64kFsSY=;
 b=C2juUgv/4mVRBM4t/QWR50v0PAQN5PDcJMHo/tdRQllqHQwwqXAAiwXv0HLo/9A1YF
 1BHRLNPuYs0cxsbskV0U7Jy0nXV1EpJiovCHN45AMPvEcN5sBD81BU4dHO4ej01y2lsm
 Pr/ExHB3p9So5xfxhyGOVB/ExMlIQBDpC2Jgj7r/VF6KIjSidta8GuXHcaqQlTTPavPg
 9KRWiLZqi/3oe4Ts0+DU1dELCLZxmKKBpV+MLt3+hP2tlidV5finjGXPelmB7+tkJ7bZ
 0sdtd3fIARwhNfx/vNAYPxsxSpYrWeMJdvWm/YnycnfOhQjqAfiJneb5B//O4pVop+nR
 qecg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe38ieb4fCUwC9XUQe99NAWz4P/2MILms0cgURqySGnjoB7bezkyAPHINxL6kExWo5OXmjkaCngljyPIlQX/faSDWGQg==
X-Gm-Message-State: AOJu0YywP6Miy66Wf4sToMSAywATk5LVusXbMkjiq+mcxx/kP/EgFo39
 nbQnia64LrrL+3w+T8axZlFYY6PBFOwj5XFaeGnExBESnEMM5CkKC9nkcw==
X-Google-Smtp-Source: AGHT+IHnek71LAkowYgHMZ1gl8iLqbzqbqsjYNSAavVAikAx1H1G5VXetWKxrzeQp0TsvTKY5eNjiA==
X-Received: by 2002:a17:903:1cf:b0:1fb:83c5:cf93 with SMTP id
 d9443c01a7336-201d644b60bmr30210365ad.27.1723639634466; 
 Wed, 14 Aug 2024 05:47:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:813e:3244:5b45:7c7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1b8417sm28768665ad.187.2024.08.14.05.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 05:47:14 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH 1/2] sandbox: Enable wget command
Date: Wed, 14 Aug 2024 21:41:06 +0900
Message-Id: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
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

Enable this so that the tests run.

Fix a few warnings in the code so that CI passes.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>
---
 cmd/Kconfig | 1 +
 net/wget.c  | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda4..2562701d1e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2003,6 +2003,7 @@ config SYS_DISABLE_AUTOLOAD
 config CMD_WGET
 	bool "wget"
 	select PROT_TCP
+	default y if SANDBOX
 	help
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
diff --git a/net/wget.c b/net/wget.c
index f1dd7abeff..945bfd2669 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -244,7 +244,7 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 		pkt_in_q = (void *)image_load_addr + PKT_QUEUE_OFFSET +
 			(pkt_q_idx * PKT_QUEUE_PACKET_SIZE);
 
-		ptr1 = map_sysmem((phys_addr_t)pkt_in_q, len);
+		ptr1 = map_sysmem((ulong)pkt_in_q, len);
 		memcpy(ptr1, pkt, len);
 		unmap_sysmem(ptr1);
 
@@ -314,9 +314,8 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 			for (i = 0; i < pkt_q_idx; i++) {
 				int err;
 
-				ptr1 = map_sysmem(
-					(phys_addr_t)(pkt_q[i].pkt),
-					pkt_q[i].len);
+				ptr1 = map_sysmem((ulong)pkt_q[i].pkt,
+						  pkt_q[i].len);
 				err = store_block(ptr1,
 					  pkt_q[i].tcp_seq_num -
 					  initial_data_seq_num,
-- 
2.20.1


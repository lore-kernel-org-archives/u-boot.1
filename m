Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A995C4828D
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 16:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E2487C45;
	Thu,  1 Feb 2024 17:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fuuCf7JB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC1787C61; Thu,  1 Feb 2024 17:33:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E16877FB
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 17:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D8B83FE35
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706805183;
 bh=PBpwywCLMlBy/fkl7egTsAbGEz3AXHtfI7A2QQXc/bI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fuuCf7JBdQ55BkHTedZ4zDDji0TM4VhHUW1J3Rf1Cjb+Mtx7HAEGoTeqmoQ1Qf4Zx
 B0VM45S8ZfJIaiwCMTo328V/EmflM7kZ2ZjmX/akvZx7yPG/qrP2p1WiaO54lYms2A
 B1DxCGmy/nL7qiVY2SUL2E32YqAKLKHvQE2cE7afqwNamke0iS0NSFZ2fCpv+0R1NG
 D2l1nPexUn7K4CEJUgFsnrIaUGBFZnhG8CBaU7i1yDqyEg79GWNhvi26i/dE0oUtYg
 hm2NIbUk23fzjv8ov7dWi9MwrRutyJlmg6abyGMSOb4jk2YRIpyboQgTvGJZmWcuvP
 tshgP1/5vYCzA==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso4888005e9.1
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 08:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706805182; x=1707409982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBpwywCLMlBy/fkl7egTsAbGEz3AXHtfI7A2QQXc/bI=;
 b=Orv9X3Rm79+tLYzk8JfsrxOUPthir46GWVKxY0WBBS7T+eBT40QmSTq2blGMcdGw8b
 y6gEKuzJVCb7TZJrDmCdDjQZdQkiEc8NtHps52mAORkSQh7n6965LwpSki6u+6Tp02q5
 UctioQvZCFF2KKuLVNkQtJr35X7zMtQoec9bdfAUkFkxqqwob89lRHbOAt4jQMNdJDvr
 VKxt2rLJ5PthwOgiRWvtgWasOIKxCNdWE0Ykb6xquiszExQ8/KE1afzq1vc+mlTLIaeF
 oDhmceSeUyBeemkkmt7MyNgxaOC9eHz/7CAWI8pL1RMoUvgFAnQmCpBKwT5zheNhKeZE
 l86Q==
X-Gm-Message-State: AOJu0YzZ+01AoE6TCzvSaF1zMxB0jang0+lUgRQ7AcRYexDdLFyURvNb
 /VO5r3W2KubZGPnufa/LucXDUl8/Xw0kKwCcDyMso1jlQr2oAEsWGZQPphY38cNebr4WJj/avjf
 H4vT2Q/JX7LqwgghOm/4werDZy+NfUoMh85KIBmT2TJ/cThyGPbDicW/3erjfcr2ztt1dViMFm6
 s=
X-Received: by 2002:a05:600c:35d2:b0:40e:f88f:c529 with SMTP id
 r18-20020a05600c35d200b0040ef88fc529mr7434795wmq.9.1706805182654; 
 Thu, 01 Feb 2024 08:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnprRWfSNZYaLzCTfdqFUW27X1Nwv/3ZMQL962xKWt4zLdESFp/ASPhB43t/XpbQIUBOhGKw==
X-Received: by 2002:a05:600c:35d2:b0:40e:f88f:c529 with SMTP id
 r18-20020a05600c35d200b0040ef88fc529mr7434781wmq.9.1706805182282; 
 Thu, 01 Feb 2024 08:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX4Hg0qTvsQcoDb4S2eMyb2/Z4CznZg09V9fhSENs29MDlC6f1CtdLqNwGAS7S0gmFPoqCtVW+tUn3UQ5anphJrdSc8eXbrCJr7Gd93So+XuLfvYNVF2B+6sIL5vOqAYCpszs2xowa5
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c444700b0040e541ddcb1sm32807wmn.33.2024.02.01.08.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 08:33:01 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>, Shengyu Qu <wiagn233@outlook.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: board: starfive: fix rendering of OpenSBI logo
Date: Thu,  1 Feb 2024 17:32:53 +0100
Message-ID: <20240201163254.88477-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

The rendering of the OpenSBI logo should look like the screen output.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/starfive/visionfive2.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 6cb033ead04..abda8ac21bc 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -133,14 +133,14 @@ Sample boot log from StarFive VisionFive2 board
 	Trying to boot from MMC2
 
 	OpenSBI v1.2-80-g4b28afc
-	____                    _____ ____ _____
-	/ __ \                  / ____|  _ \_   _|
+	  ____                    _____ ____ _____
+	 / __ \                  / ____|  _ \_   _|
 	| |  | |_ __   ___ _ __ | (___ | |_) || |
 	| |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 	| |__| | |_) |  __/ | | |____) | |_) || |_
-	\____/| .__/ \___|_| |_|_____/|___/_____|
-			| |
-			|_|
+	 \____/| .__/ \___|_| |_|_____/|____/_____|
+	       | |
+	       |_|
 
 	Platform Name             : StarFive VisionFive 2 v1.3B
 	Platform Features         : medeleg
-- 
2.43.0


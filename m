Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3210CC369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BBF881F6B;
	Wed, 23 Apr 2025 16:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6iLM8LP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8527780EE5; Wed, 23 Apr 2025 08:53:23 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C9B80194
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 08:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso6099645b3a.0
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745391200; x=1745996000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DlQROEKVyPCyauV4UIJJMsqfmdTSRp6p/JsfxTIA3rw=;
 b=j6iLM8LP/e2F22qYtledXDZJDlTXVYbi3aAr2TnoGUkw5vHJp3heDau85u5BXPUlpf
 cPNnJp4lSS6c/eTkyRUQIKPQlBluRVPI7USUr4iC9/C2jtQ7cKWVq643zQV4Ltwg+utg
 wt6pZpMy2Og1GyPBa91+UkcZcJHwimGuMyiMQjPaN9oayXQLZfuO+VMFRjYWKORs4fHn
 qZRDjfiEesf3MRln84Utm3g6zfvMxMYQx/mlEeQ1iI57OdsFzLQdTYjnB2Y2Fk2NGqkS
 JqFAkNXABSBOZOyryvoST6rXiS/ylP6mH1s44/6MtddOqzjsnoCIOuqKy009ebLjkyf6
 JQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745391200; x=1745996000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlQROEKVyPCyauV4UIJJMsqfmdTSRp6p/JsfxTIA3rw=;
 b=fITFbreI3fL6geNLvwMI1FOWjPSrOyFWs70qyiKF7Rt2KeyxHLtgOVw5R7tpcXCQxj
 io/mhMjCyBqPxKOOI4ew1SGu1qMy8ReOFWA0PtqwsRKZLZQQmMneOF6tWjbv8OL2Nteg
 1SAVsCMDA99yQXi0y2dkXbGsai1sJUpnUmmadVJpAGQAniCuZSp2o5Qkst8BKEPuddJ7
 V6JyNuIJ+X41syUvWwPeo6UD8s4/62HJ6YFqYP97ZNz1MpeCJJpzgWW4klXslJALHNKR
 NxSxvy7XTPTPOsUqhckyfp5iVj/q5xYcvKcChU0Y93KI+3iYmbGtpna2CS+fFzv0Hzov
 Rkzg==
X-Gm-Message-State: AOJu0YwNpCMsF3pSHJM2Cye5IDfJFV9cokAmTCnzhgUKJtJKbdFuavIk
 f6/3m6yyXbkfOjL0jRYrDXyTojgnXOdj04PrLbTEx6TgjGv2S8u8t54tzA==
X-Gm-Gg: ASbGncsKLTJjnQKn50c2a91oAQwP5iLhAMX/lcagXU3Kz9dr00NdVOCwMI16RAsJbAM
 3UNcqO4jSXt6ho6FBoWJCMeiZ5eDAvXstgKCTQ7CJl+6t4gmQ10wppljX37NKzLIFvbQAqg6pFR
 vmm5G6o8bsU4MAbj9zXw9TkMtMZq+xywJjihlKSzom9YOZHPRebvxcmUeZnvz/E+aYEaqxZcgT1
 I24miuLo43b9+wIt/7dZtehcp4Ld4FCGuNu2i8PAYGeoY+NiJIKfAV5m0/uURTe1BaGT7vWnaPL
 0JQ/DRmPeb9OrOskrFW7tl3fbTujNYicZLxt93HdWRSoi5U9Wx4ZWT0ZSkCxJSTP9tWQW9vQH74
 mXIJGL0WMsJCJKCIsVaYAHQ==
X-Google-Smtp-Source: AGHT+IEKyT/x4D6HemdtbTi+xQVck3gPOsHl2XiX3uPSMqWLjWrjVTv9CcRTyANPfPRqGHB+52hlmA==
X-Received: by 2002:a05:6a21:1645:b0:1f5:7e57:501c with SMTP id
 adf61e73a8af0-203cbd55500mr23707947637.39.1745391199669; 
 Tue, 22 Apr 2025 23:53:19 -0700 (PDT)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13a75d5sm8409191a12.23.2025.04.22.23.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 23:53:19 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: aristo.chen@canonical.com,
	trini@konsulko.com
Subject: [PATCH] doc: fix typos
Date: Wed, 23 Apr 2025 14:52:13 +0800
Message-Id: <20250423065213.58016-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
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

fix typo from "commnad" to "command"

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/usage/cmd/part.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index e7faeccbb09..e7f6e54ecea 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -50,7 +50,7 @@ The 'part list' command prints or sets an environment variable to the list of pa
     varname
         an optional environment variable to store the list of partitions value into.
 
-The 'part start' commnad sets an environment variable to the start of the partition (in blocks),
+The 'part start' command sets an environment variable to the start of the partition (in blocks),
 part can be either partition number or partition name.
 
     interface
-- 
2.34.1


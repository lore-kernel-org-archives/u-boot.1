Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B005C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCD4877D3;
	Mon, 12 Feb 2024 17:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fm1KtWlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFBF4877FB; Mon, 12 Feb 2024 17:53:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD85D8718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 65E4A40576
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1707756818;
 bh=ECSXAkIHmj1wskFMSCcJqNJfTlIu09th+SDXSgyqM0Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fm1KtWlUqIl6e9Edi8oRHA6b7kMDu7NU04eG5aAKQVhdp3ZqqqpA2AlWMvqbTomXs
 e7OgGhW4YzshMhhB3RrmWaWnfXUzPWVlXs34RXz0dML3khj+NHrvOuSPXENpjoTO8H
 yqLyPHVUfCyZxakxdMxlOjCgnX3x9MyIlExYDGxfk1jJQv9LqltdmQ0DJphNu6cYqQ
 Tyb1CrIiC+Mx79Bm5xzwPGOYpEbezb/bu26xt+KZYOzfF+vUGCwWVskPfsZQbJ9K+P
 36kr8VnKYJBZBspe24gwAJehvdaWuSktBz6+6Le7Pu5Perw8nEiAJ2EUsvujZiXhRS
 y/gEeJHc8fD+g==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33b28f50eadso1538664f8f.1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707756818; x=1708361618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ECSXAkIHmj1wskFMSCcJqNJfTlIu09th+SDXSgyqM0Q=;
 b=mP37D3Rz8aOHasBrbm9nD/GZCwq5hxf7m5DvMO+VqRRcAiKIJrvw5z7pG3fJMWDDrE
 WIaO0FEbuWnjOs7KLvBDFjbtMA1HSmJfrWjTbDHNwSu67OtcB00OQY9uNYf2ozhLn7rt
 0QszfyerTUM26ErK2Adt8DajpYoHzWGlEM2uDU12jbak5MFNmFV586BraeCSK4Mjt7Lr
 52WJDySEbwUD6vUyXsY//QO6ReAwFV1RT8SvQLGdL6xsGsuWJgVcwIJz6gCXpRzShJXi
 NPbNBc75/SdW+tKSg5Xo+xJb8rE+ZovIsJtUhPgMEh/T8qg5DZFmZ4CiBMstWMwLOYH6
 KwJg==
X-Gm-Message-State: AOJu0Ywtgg5j2kC4rND+ZPlAG1WalJhASwm8htoV0f8bjxNAMKYbJHqC
 OAbXyBd/YeZnkExbjNCScxod5fuAK0wPU2LrUMfiLrlEACfh0/zdYA/QBe3MEAp/ocXtG6xnx6I
 TCri4A/uyzJR5t5ft2CGqx3+6ylUxtuRxAVXxRdGM/Xxge9fXAjyTkdu9Tg9MVwt9cfA=
X-Received: by 2002:a5d:4f86:0:b0:33b:7560:ce3c with SMTP id
 d6-20020a5d4f86000000b0033b7560ce3cmr4559678wru.64.1707756818045; 
 Mon, 12 Feb 2024 08:53:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAZ5Bi43K8836c1TJejRZNXQIVzgiTJidBwpvtoLgHVm+DqpHzneecokdJhMDkAohyKL0v/A==
X-Received: by 2002:a5d:4f86:0:b0:33b:7560:ce3c with SMTP id
 d6-20020a5d4f86000000b0033b7560ce3cmr4559667wru.64.1707756817687; 
 Mon, 12 Feb 2024 08:53:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ603baF+K0bwybg1Rtk6JReuV3G2JeE3Eqz5P9eVWBV/kp7nO8XycF2LlhV+I4WaU2GEDnsNZ0+2WkVOvUyJHJ/fJWsyVycCevY8LwGZr7+LM5DOhmbNJ8uubtQ1PEJh+9acBwV8urdrPN6CIaIJO+9oSZ4O7qqnHrd4HBzguQQWCLduE+3jKnAIhNsgdCxU99NWhwJjxn/l6Z7NuX0BIYU9DlA==
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 t24-20020adfa2d8000000b0033b86b38611sm1960240wra.10.2024.02.12.08.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:53:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] cmd: remove common.h from exception command implementations
Date: Mon, 12 Feb 2024 17:53:29 +0100
Message-ID: <20240212165329.17847-1-heinrich.schuchardt@canonical.com>
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

The common.h should not be used anymore.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/arm/exception.c     | 1 -
 cmd/riscv/exception.c   | 1 -
 cmd/sandbox/exception.c | 1 -
 cmd/x86/exception.c     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/cmd/arm/exception.c b/cmd/arm/exception.c
index 522f6dff53f..98a9795b68c 100644
--- a/cmd/arm/exception.c
+++ b/cmd/arm/exception.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_unaligned(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/riscv/exception.c b/cmd/riscv/exception.c
index f38f454a0b1..14ad6c440a5 100644
--- a/cmd/riscv/exception.c
+++ b/cmd/riscv/exception.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_compressed(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/sandbox/exception.c b/cmd/sandbox/exception.c
index c082401ce6b..cfa153da260 100644
--- a/cmd/sandbox/exception.c
+++ b/cmd/sandbox/exception.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_sigsegv(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/cmd/x86/exception.c b/cmd/x86/exception.c
index 82faaa913e5..14b6bd6f493 100644
--- a/cmd/x86/exception.c
+++ b/cmd/x86/exception.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2018, Heinrich Schuchardt <xypron.glpk@gmx.de>
  */
 
-#include <common.h>
 #include <command.h>
 
 static int do_undefined(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907CAC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7F488CBB;
	Wed,  1 May 2024 04:45:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VToc7SRt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D538A88C1C; Wed,  1 May 2024 04:45:54 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF46088C83
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78f05341128so448682885a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531551; x=1715136351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyMeydR3+9pIPcHeKTj6F3qjFtRtAXpYZt30K8oSkYs=;
 b=VToc7SRtB/oKHw1ucwH+Y8C+Ak+xyxOmfz4p44w5GPxyLQ8gFolYADg0RxqRp9CsRF
 IftHRqGry++IrBf4Gyu/KZQsvSQCOiOfK0POiJi8OrM9Kw5zRNv3gWHE+T8icYX/7Cg9
 Xyu/gDJxWudLY5M4sSV23P/KyK/eVP5z6TnaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531551; x=1715136351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyMeydR3+9pIPcHeKTj6F3qjFtRtAXpYZt30K8oSkYs=;
 b=JovE/vanpdmxQnKtnIKYZpCm3MaNqYs/bMLNohJi5tN+y66+n1hK3ZkKARmG0dxnYn
 VfYldNjacf/YjteUxm3knuIcGgm0uTBkYHqbBLiNuX6A0m+uY3Idxq2LeEqH1TnYtSps
 GavuhlzdCXSh//Jnc8lYgSmn7j3NVbqIOAYMyjLLUdFsV938BtDwSKwMbVWWcXQxEQ5r
 HSyIyhtYz4Wx/RaduodWxijY65Xrk+G8ZDhtBm/Jbq5k9QohjGYYvmTs+VTq7v1GNX66
 hhra3E5L+6/WF7f340pvlT9BEvntppmnoz39SVpTAjzs7Eh2Jtb96rl6DRrPfAbn5EHy
 p6KA==
X-Gm-Message-State: AOJu0YwnOwQefidbrTwd0STOiF4qyfkXy1liEYw75zBaIt/Bzh/wT79i
 LO+J8rhNfRrAiyu9Cf/pu+etD5aGmNKO2JJGCwolXenEr1KmE2TZe+SinF0F036tizplu0F9ytM
 gWoIGidj5
X-Google-Smtp-Source: AGHT+IEJknCgtHF2hXWGL2JwgJtpNSmH2C93Wf/3mncyowtRtg8pesEZ9uwt6YN58Htbxc0q+6Fjew==
X-Received: by 2002:a05:6214:2b0e:b0:6a0:ca29:1954 with SMTP id
 jx14-20020a0562142b0e00b006a0ca291954mr1164389qvb.46.1714531551608; 
 Tue, 30 Apr 2024 19:45:51 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH 134/149] board: theadorable: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:43:01 -0600
Message-Id: <20240501024316.1767971-134-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
---
 board/theadorable/fpga.c        | 2 +-
 board/theadorable/theadorable.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/board/theadorable/fpga.c b/board/theadorable/fpga.c
index bc8379cccf6d..56d3647227bb 100644
--- a/board/theadorable/fpga.c
+++ b/board/theadorable/fpga.c
@@ -3,10 +3,10 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <altera.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/board/theadorable/theadorable.c b/board/theadorable/theadorable.c
index 144f122bb206..cca5c3d33b5e 100644
--- a/board/theadorable/theadorable.c
+++ b/board/theadorable/theadorable.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015-2019 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <console.h>
 #include <dm.h>
-- 
2.34.1


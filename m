Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55611C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF6A788AA9;
	Wed,  1 May 2024 04:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SYmVRhVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4BC488A95; Wed,  1 May 2024 04:43:29 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C368F88A91
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6a05f376effso49626526d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531406; x=1715136206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxGxGplxZ1Lul3j1lX4bfbHYYKuK8OpQ2Af0E3xgFrQ=;
 b=SYmVRhVDmO1hMVSDDDz0H4wwquZA8+WxSF2PrE/xRhwwg30B1Tfd7gPzTJHRUFmUOb
 FKG/2c3+yra12dyVzMk5qqXWsSY83pmhi5FPmWSd874SaSYhL661CY94B7lzRCBHA6n8
 Mn+/cjNHeh+ZA/E4RMjbuxGbtrtQNbnsXfqCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531406; x=1715136206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxGxGplxZ1Lul3j1lX4bfbHYYKuK8OpQ2Af0E3xgFrQ=;
 b=XsNKh6UJx4C5JHRNIKlONzBPWp6Za5Y1HVgv0tmsWPDwjTvHRJazvqmuSAZV+XNllJ
 d9Ib1gzS4U2LDBG2XmGgHyoBVVSndizAMoBrcqinpMVsmX8HcZyOB7NLb4AP2JKlF9oE
 xMt+9msbhTj5qZyww1eqlW+auKWvyWILcEgSMbWo685IAGZ7kG643R8UMYnZUDhtYZNQ
 VoAESGPabPUEAc8SuYH6ZRaMEd+Fqbkh/9kk/UhqghFriUSgyTO9vBz9KVwaIauBnQ3Z
 LCr7E8Af5BQwYrEUNR1lSArAGoAbI5QZ6KGNB611Rj5Sm2BVq4mzm2PdgKT+ihSHOTxA
 PggQ==
X-Gm-Message-State: AOJu0YxuIKLjzjGVIsZasvt3foah2qeI8pe1qKm/ie9cPORBOhO33T5f
 9qz5rsBCzrcROHNUysNt5eR2w7uOVjgONfqWGU7qdFUt5uVaPKLTN18SUvdEkHx+axHfkPElhrU
 6S4lC2g==
X-Google-Smtp-Source: AGHT+IFgsP16bmfwC4kT2WZtqA8e0KZTHvf045bXn1eMcLSA0eSoy9dM0s/L8+YN3SyZpu9Mk5+azQ==
X-Received: by 2002:a05:6214:c29:b0:6a0:cb52:b065 with SMTP id
 a9-20020a0562140c2900b006a0cb52b065mr1131415qvd.32.1714531406389; 
 Tue, 30 Apr 2024 19:43:26 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 008/149] board: CZ.NIC: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:40:55 -0600
Message-Id: <20240501024316.1767971-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Marek Behún" <kabel@kernel.org>
---
 board/CZ.NIC/turris_mox/mox_sp.c         | 2 +-
 board/CZ.NIC/turris_mox/turris_mox.c     | 2 +-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/CZ.NIC/turris_mox/mox_sp.c b/board/CZ.NIC/turris_mox/mox_sp.c
index 11d875647170..1591b40deee6 100644
--- a/board/CZ.NIC/turris_mox/mox_sp.c
+++ b/board/CZ.NIC/turris_mox/mox_sp.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2018 Marek Behún <kabel@kernel.org>
  */
 
-#include <common.h>
+#include <vsprintf.h>
 #include <asm/arch/soc.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
diff --git a/board/CZ.NIC/turris_mox/turris_mox.c b/board/CZ.NIC/turris_mox/turris_mox.c
index 00114e6d9156..e4ed7f258109 100644
--- a/board/CZ.NIC/turris_mox/turris_mox.c
+++ b/board/CZ.NIC/turris_mox/turris_mox.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2018 Marek Behún <kabel@kernel.org>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <net.h>
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 3b7a71bdad25..4ee1a394b024 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -7,7 +7,7 @@
  *   Marvell/db-88f6820-gp by Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <i2c.h>
 #include <init.h>
-- 
2.34.1


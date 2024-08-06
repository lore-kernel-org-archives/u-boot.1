Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6636DC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFAA288ADA;
	Tue,  6 Aug 2024 14:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hs5HBD6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD50D88A8C; Tue,  6 Aug 2024 14:59:48 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D5B888A9F
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso2294705ab.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949181; x=1723553981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnoJRYiA0jpgdtUTiaY1SSzDLCyCKyPzj2aCRxRQE1s=;
 b=Hs5HBD6fpiZey0LMup24CNbuScnSYNnzEkIic0unc7yqQp5o4646XKY6pKBP8qTFze
 9DgiSi6cOtHi/sSx1uquwL0LXAwwcihM03rvkuqeM4EPNMUBaUb/GCBqD22IOl4Y2R8S
 aY9jZMrokNdBsBMRFdUc4ENmNSD5gmzsoeZ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949181; x=1723553981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnoJRYiA0jpgdtUTiaY1SSzDLCyCKyPzj2aCRxRQE1s=;
 b=Q+jUDxoeZMNXN03UkTgozrpvHP5/R1YqvH3CBQXB80d2eR2BUp63D5iK+gGvNxygHx
 hNiz9I/4RgWU3reFZ5KyD45YsSIe1zCsd7EZXBHN3z3qE2iv29i4cJznlwF4euotiVpx
 RZ/+fLAbcSLg7/Gm7OT5/r2c1ixGBIeZ4PjT9Zn1AVP7Svt2+3BUFYH9ymqe/FJGOZ6x
 kR+xkeAEgfzDWGuJFxdQoLDIfNwmWI7RBMcM8nVh4MjciU6LJb7DN8nhBPlqFH56kQYt
 DL3Q0Oy9rSrNdCYUgV6ftvRK/pSLKrtEv2iQgWBGMAyvxDf6YooDesChRv45Xbhwq60H
 AUAg==
X-Gm-Message-State: AOJu0Yy3zNMBAOVkuqA1jAUGtSsZUWViJydTePe0NmyvC1iSANmxoycw
 h9dsblvzus3aXHY803+tZ3E8U9PK9uS51BKPP45pebjZgW3VJ43tgnOl1H9WkxCraGV4dceUZOE
 =
X-Google-Smtp-Source: AGHT+IFWcB0yIUJ6BLavTYwL2rfmznJp7FlsIYRWRxmryMzDHpagb5NMNhn3g70D6juvmQVbmVn7yw==
X-Received: by 2002:a05:6e02:15c3:b0:37a:9ab7:ce34 with SMTP id
 e9e14a558f8ab-39b1fc0f59bmr209658695ab.19.1722949181286; 
 Tue, 06 Aug 2024 05:59:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/39] efi_loader: Put back copyright message
Date: Tue,  6 Aug 2024 06:58:37 -0600
Message-Id: <20240806125850.2316956-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

This was lost in a later commit, so add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: dd860b90ff4 ("efi_loader: print boot device and file path in")
---

(no changes since v1)

 lib/efi_loader/helloworld.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/helloworld.c b/lib/efi_loader/helloworld.c
index bd72822c0b7..586177de0c8 100644
--- a/lib/efi_loader/helloworld.c
+++ b/lib/efi_loader/helloworld.c
@@ -2,6 +2,9 @@
 /*
  * Hello world EFI application
  *
+ * Copyright (c) 2016 Google, Inc
+ * Written by Simon Glass <sjg@chromium.org>
+ *
  * Copyright 2020, Heinrich Schuchardt <xypron.glpk@gmx.de>
  *
  * This test program is used to test the invocation of an EFI application.
-- 
2.34.1


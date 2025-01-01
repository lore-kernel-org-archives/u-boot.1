Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60996E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CF2803F6;
	Wed,  1 Jan 2025 23:10:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j7AbaYzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4C2803E4; Wed,  1 Jan 2025 23:10:54 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25109800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163bd70069so47500335ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769450; x=1736374250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhqduXdLf9D5KofvKzMvgCOAzQd/Rxt++tQTBhk0SQg=;
 b=j7AbaYzzVZ66/vb13D6YDx/4ZIEZxDjJmmsz8b3hFWF/OOYNTCj/czaeyEjFmac0kF
 CdA5TiE4TkQ5KKfC4Uww6BISXYJiEX99+isNhValanbDMRSOHUpDllbCq4j+Hybxbt3q
 XlAKN1g1Fr7s/eXaSwGcMIJ3xHIbiFXOC1QKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769450; x=1736374250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhqduXdLf9D5KofvKzMvgCOAzQd/Rxt++tQTBhk0SQg=;
 b=gmx3Xbs4Ypk6WSUY7xpi1fi2z3KL/TZLzfrnDl8ffWpkNOOre6Al/F2T4tgEk2aHN1
 HF4nETY+dxDAv2eb4z6LC/3tieXJOq5gIIxHwILQ032JPr5ZS5DG5cPx1cys1uJH5lzT
 +PgkBhgMVof0GAgnTiGf3MSrduEx9Xy2pJ/x6j/4xSh4oGcxF66XMVGMn9IV9NztOs6I
 waDOVE1PxJG7jMgZT0a4QoILUugxjwvO5Pz+1dyLBk4Oq2boqxMlZ2temcI5zhenPbYJ
 01Et403Pjuo9EqaPom2/ZE9hdLQmNxaqceQyycoLm4F5sEKW4xP+QELDYIfwwrYBdIbw
 uFjw==
X-Gm-Message-State: AOJu0YyjL7PkC68G79f3puTXBzNzzvyOY3WjypKsLGEuYYrJQPu7nour
 FCiwmS3EpJF9om7KxO5fNtEqCIgrwbe9x/usFh70fLiH6kj4w6LoNvik10zs85RI9P6ZJ1PwRx4
 =
X-Gm-Gg: ASbGncuqliK/KTDycaVc3GNJl/I+FxeyRAPsZbTaEFS8xOzzrs4yOxMlgXGWk9ORcpI
 7HxB5hkSYQV66e4EXuPSvf6GaeCWBEOspvxyCNNafAyvhVAYZvCyXIhjYJyaP3UDhwJ1TdPJDvi
 /CBa5CuAMscxpheuwGXLH8yRXQgzqWQwkwUGJQPohaOp6r3L8khkYPLj3QqvPk787+EBNhZuiYK
 SQcGIdhV4ee+nUE8x6R9Y6R0eWODa/V+43F8eiNGWRvOAWWITsPSqc=
X-Google-Smtp-Source: AGHT+IEEHxfGF+lsLxJHB7kAAxSSMbYDYZMDrJqVGakJp4yV5rt6bs71bLp0Xydvxpu8XayL9zTu1g==
X-Received: by 2002:a05:6a21:9985:b0:1e1:b183:2243 with SMTP id
 adf61e73a8af0-1e5e08432ecmr68487155637.39.1735769449763; 
 Wed, 01 Jan 2025 14:10:49 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:10:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/67] abuf: Allow use in host tools
Date: Thu,  2 Jan 2025 11:08:49 +1300
Message-ID: <20250101221003.1944600-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Some header files included on the host are moving to use abuf, so adjust
the header-inclusion to bring in size_t correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/abuf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 76e314b9a47..de21cefade4 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -9,7 +9,11 @@
 #ifndef __ABUF_H
 #define __ABUF_H
 
+#ifdef USE_HOSTCC
+#include <sys/types.h>
+#else
 #include <linux/types.h>
+#endif
 
 /**
  * struct abuf - buffer that can be allocated and freed
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB98ACD493F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 02:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BFC486C23;
	Thu, 21 Sep 2023 03:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bNOTLlp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C76A86D69; Thu, 21 Sep 2023 03:58:30 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5715086C3E
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7a8b522ae46so195586241.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261499; x=1695866299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sb7bBWAiDNoaqdOtKTmuTaynVR7GHKOEwpPsieeGxKY=;
 b=bNOTLlp46hBwj5vr/tuu6BSL8PmJwkX4T5BjtWHDMTmDa7PjHffBhU23y6LOIikbNj
 fwpnjZRRLZ9fd8SnsUFnMreVGaBtKnRoXE7cGdoZvzORhOtTdYmlkmN0T2pNSKFysvXU
 lRQ9mYYNz/ak9nXCw+npLz3jS1QUg76ZsLPFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261499; x=1695866299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sb7bBWAiDNoaqdOtKTmuTaynVR7GHKOEwpPsieeGxKY=;
 b=IybZn9d6HY7XC5uf7uVuH2DneCYYBv8nvXdatFK2v/uMowUUucSyIzCArAauyvj172
 oYxe5zWdrIyGtzjq9K5GBbvKZlwJN2voAV33J8yJtmOfvcgMBKIDpfmXq/e/fZLH3Y5e
 edvQ7FpHT5R6/iFjJsjF6crleyouqdLo5DQ1ajherDM1AYBrlSp10bzoRLwHCooFTfva
 7qd4OWGZ8aYf+kk43r59IhL8ZkwBJq6WBmgMGGo80UK5YQcjYsP3SpeAKx7d+HZbNsVK
 HOHaaD05x8awrKJzxMU3w9rocKLY0pczaZtHXwYry4Ab8eARHibuXk4gpSIMoiTrftQk
 zEGQ==
X-Gm-Message-State: AOJu0YzRuu/CEPhYACv4cwe16wKJZmXqymbfZdUo2GCpocM8bl7PmK0h
 lwjg+huSakDSZvA1+5uAnfB9ti11l027mnQc2/Y=
X-Google-Smtp-Source: AGHT+IFY1Xhs0hPWG4T0URAg02QLIsZviEeUDaom7t2Z6AdS+Wab0r4x4Wcq6w5Q3xYEujp0UPw8Nw==
X-Received: by 2002:a05:6102:418:b0:452:67b7:42be with SMTP id
 d24-20020a056102041800b0045267b742bemr4422159vsq.4.1695261499156; 
 Wed, 20 Sep 2023 18:58:19 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:58:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 31/32] command: Include a required header in command.h
Date: Wed, 20 Sep 2023 19:57:20 -0600
Message-ID: <20230921015730.1511373-32-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

This uses ARRAY_SIZE() but does not include the header file which declares
it. Fix this, so that command.h can be included without common.h

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/command.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/command.h b/include/command.h
index ae7bb4a30b05..8aebf7a95bf8 100644
--- a/include/command.h
+++ b/include/command.h
@@ -15,6 +15,9 @@
 
 #include <linux/compiler_attributes.h>
 
+/* For ARRAY_SIZE() */
+#include <linux/kernel.h>
+
 #ifndef NULL
 #define NULL	0
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog


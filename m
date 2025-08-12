Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC77ECA0EDF
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C9238304A;
	Tue, 12 Aug 2025 19:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pu5ZjT3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64AE88304A; Tue, 12 Aug 2025 19:59:15 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385588304A
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-741ab3e03aeso4310467a34.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755021552; x=1755626352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kq6rvsJG/q3CUMK7gpfE+r/ZQBq3RfOSfFYnCXy3zIQ=;
 b=Pu5ZjT3y7dT6shho+qClsLoDRP7gpde7XrwOKaP9JYuVukkhXXbN+JWlH+Y90mySbt
 Vptd4T/xEDODMvbaw05Kl9v2SGWBOfygPOFyw4fTgwjfIMJFzvP9F9TMi34O8unEq40Y
 Ye8vSL8RlikoJ5/rx51vZyBpcQvnqFy29kKYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755021552; x=1755626352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kq6rvsJG/q3CUMK7gpfE+r/ZQBq3RfOSfFYnCXy3zIQ=;
 b=vQRHiS85fxX94ahXCF8vFEtFKvyDsBHGQugj2uqKC5Bzs/3tRVg+16cFoJ5IaEwadu
 FR4YlbyyulCBaW7iIMUF7mUPqCYVxfiqAjOPOX/Nlrxl+tmzRld/FPV+yLHtcLnszcpi
 Fkw7QpZPNKTYqmSXPWh8NmQ/kafzUlgKS+2oLD5T13VncKZqaU7hKQaU2xRVLkPZqEoQ
 jUaedTqtOA38FMQYx1SKqkURNM8ySW87bkAt+/8Rxus3b4SWkUYxa8tWkajsXe/zUEV8
 aXQ2C3smqRtFiKmsHH2GuJYdn17TphOWDf7dOZxkfPBKjUV17NdYwhl669a8ZmKmegRT
 2AKw==
X-Gm-Message-State: AOJu0YzCDEbijg+eMvHoCPup8O0MIqpxSND2lrThL4fw1kNt5cOLihDg
 meRb7MSvnryB3VeS960WVmJkep5M0eczRccqd7k/825HXOQHII0VN77HymBcZAWVPgQirAZAw7/
 QXeS0J/I=
X-Gm-Gg: ASbGncsj4RERgyPVy2Hj8gEGN2S9pftTvMKWPF8xxp1BgtYZdhoM+xHbH1b/s1pPcN4
 OjYfH4Je/w921GGiSNSV2ChtNouSzXmDvIteXJqCSpY4QNe9N+gECguZvg92F632sgeWU1pFbaQ
 a4NslXMS9phCWvpP6jWPgBusOD7J2hrcdv3+zteVPFyt0BgG7o9qFuwBbV8S0K8HERptfPBgtG1
 cfyQADYAdNuEZbU7jYSkgzgWHoHFgPpOjTLPJ7jQLOuqzq8LVRaSGn2E6R/DldCeCya6MT0Wauk
 JqdTrbrxUJgXa09+lNiSVoMDlLo4aFBvJoXePwyIGzmsnA2dL+LfykA2TmcvnlaCQqZ86l7J0pw
 yBfaJU420BEsHzTP3f+RJ0g6ag/bxOY6LRwJOJkUEg0QBKEffHT3N4+I0Fjc=
X-Google-Smtp-Source: AGHT+IGREuDDhSljmRnUK7ADKlahIGuBfz9F4JpaDkAmWrvPHjM/V0V4erjmcj9gj4ibOqeNisycIQ==
X-Received: by 2002:a05:6830:4121:b0:72b:8a8b:e02c with SMTP id
 46e09a7af769-7437538ac9amr207119a34.2.1755021551889; 
 Tue, 12 Aug 2025 10:59:11 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f87a162sm353684a34.17.2025.08.12.10.59.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:59:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] sandbox: Add generic asm/atomic.h
Date: Tue, 12 Aug 2025 11:59:08 -0600
Message-ID: <20250812175908.3057051-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812175908.3057051-1-trini@konsulko.com>
References: <20250812175908.3057051-1-trini@konsulko.com>
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

In order to compile code that uses <asm/atomic.h> on sandbox, we must
provide this header. RISC-V shows us today how to do so with the generic
header implementation, so copy that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/atomic.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/sandbox/include/asm/atomic.h

diff --git a/arch/sandbox/include/asm/atomic.h b/arch/sandbox/include/asm/atomic.h
new file mode 100644
index 000000000000..2fe49f52f34e
--- /dev/null
+++ b/arch/sandbox/include/asm/atomic.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Based on arch/riscv/include/asm/atomic.h which is:
+ * Copyright 2023 SiFive, Inc.
+ */
+
+#ifndef __SANDBOX_ATOMIC_H
+#define __SANDBOX_ATOMIC_H
+
+/* use the generic asm/atomic.h until we define a better one */
+
+#include <asm/system.h>
+#include <asm-generic/atomic.h>
+
+#endif
-- 
2.43.0


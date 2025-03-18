Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9190BC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980A18193A;
	Tue, 18 Mar 2025 13:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y2CG+ULs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE16811B2; Tue, 18 Mar 2025 09:31:42 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566E580107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 09:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so830371666b.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742286699; x=1742891499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3XEHhdFfWOItOIH/XN/FCgOGZC8dwg/Xx3+RYNnWdw=;
 b=Y2CG+ULsSSM/9QdVjutB9/MakCDAPp0CZxYQloTCTP7zu130y/a4SePGdwiMi0vCmr
 0B6OcPQiMn57uJGqPOF4L981AMdIIwsMAp9zFOHE4fdZp0+RrfSO8ciXWGgaXNpB8uq8
 IELcjIJjw8lFE9KN6Plo88pL6eOHE2kS8nvKkH4W04w6BzKakMflnKKTd1PVS2UQFPMt
 u69+686Rd7yl4bPACe9DpXOgISAKgm6TxUVCPloc5Pq+e6DoKICoi96PX4HD+2pvSMgh
 dDtwPueAXujXWjesuDhILee34HU2kXiAcjUJuoLzYxW9cpPqwyB6Jkm88DqXBVhAcyC0
 7nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742286699; x=1742891499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3XEHhdFfWOItOIH/XN/FCgOGZC8dwg/Xx3+RYNnWdw=;
 b=Pc+vQf+XvA/MotUgp7DPY/73pqpm+nBRrdVHyNqyk51zSr0VaB63+k/Z2+aCE6d2xO
 wIth6wDW/iy72+XdiLCNyhR1ZPm7x4d/DCz3KlIr9VLRapS4L1UoUvSJnXeZrHiQeDXO
 tWCxB3DWq8PYEmnr8pEyWogSDBNQm5vcwCrA4B/3QD12YrPwWcr6jqaRQ4VCoDXj33DB
 08IEHOVvlvRLvC60sWndpC3Js6izlrqfU9hP+ckN58SZGqrv75Ae+prNpXcV0TwaeZLQ
 GjEm33iflZ7GdSzwDnNf6/TVtBZ7MeOEKnOOWW4slZWZtFu0iI4RH6kk3V62lFXv0IHq
 iWAg==
X-Gm-Message-State: AOJu0YxWrWYN+lIxcMD+xTNwxZ/KrFaRAFmgbTcPbBFFZImZBC0g8Phv
 ngXkHJj7esJRF7Xoa3rAGVaWrNyjvKng7m31sRUtEUHnQiR+U5NSdZ96y/+Y
X-Gm-Gg: ASbGncsYeu99NmFnGvQtBOxij8NZ406b/0GeuaP7v6qVvB6rZH3QKMZTvHuQTX7IvRB
 WpXHTHzPWnnQJi3LUPAio2OSjLUNU8P9o8teBKuDEn8XzS/QXgtdRZ/qVR8g/v2DFU/CcGV4bcN
 ubnJ/hhN0BnaYwEnPA3gXEld2c9TmG9qyreplNMMBuDbv5yk+pKtJmpytSgcFmS869vKXmmzjXH
 kyDMKwQyeGtJn9p2djDRpcSKT2DVhJxcNPEo24/JLeszycbPcjFb9a9OIXx1w+KVpEpf7v/Bfp6
 f6I9brgVYp9kB2b/WbKGDVK1FpGv39jbquy5lC/BwKBbYPZgmY8p
X-Google-Smtp-Source: AGHT+IEzGue0Ul0npgDv0DSlqeHOZn4GjRVKKO9kt6+kHmavvpOL9pZ0tEQoWuG4GO1/PQD6u5HaiQ==
X-Received: by 2002:a17:906:d554:b0:ac2:a42a:999b with SMTP id
 a640c23a62f3a-ac3304e33bamr1391942766b.52.1742286699149; 
 Tue, 18 Mar 2025 01:31:39 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:4e11:d045:a94e:c696])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314a3e0acsm816189366b.142.2025.03.18.01.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 01:31:38 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH 2/4] tegra: respect CONFIG_TEGRA_ENABLE_UART* options on
 Transformer T20
Date: Tue, 18 Mar 2025 09:30:45 +0100
Message-ID: <20250318083103.63250-3-arturkow2000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318083103.63250-1-arturkow2000@gmail.com>
References: <20250318083103.63250-1-arturkow2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Mar 2025 13:47:17 +0100
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

If debug UART is set to anything other than UARTD, U-Boot's SPL hangs
trying to communicate with UARTD which clock won't be ungated. With this
patch it is possible to boot with UARTA enabled.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

 include/configs/transformer-t20.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/configs/transformer-t20.h b/include/configs/transformer-t20.h
index 6a3d9b24036..d3a98cc5a70 100644
--- a/include/configs/transformer-t20.h
+++ b/include/configs/transformer-t20.h
@@ -16,7 +16,17 @@
 #define CFG_TEGRA_BOARD_STRING		"ASUS Transformer"
 
 /* Board-specific serial config */
+#if defined(CONFIG_TEGRA_ENABLE_UARTA)
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTA_BASE
+#elif defined(CONFIG_TEGRA_ENABLE_UARTB)
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTB_BASE
+#elif defined(CONFIG_TEGRA_ENABLE_UARTC)
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARCD_BASE
+#elif defined(CONFIG_TEGRA_ENABLE_UARTD)
 #define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTD_BASE
+#elif defined(CONFIG_TEGRA_ENABLE_UARTE)
+#define CFG_SYS_NS16550_COM1		NV_PA_APB_UARTE_BASE
+#endif
 
 #include "tegra-common-post.h"
 
-- 
2.48.1


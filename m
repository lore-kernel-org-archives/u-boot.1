Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CC8C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 19:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725E281E6C;
	Sun, 30 Mar 2025 21:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kCqT7JOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181B481879; Sun, 30 Mar 2025 21:27:11 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D33A812BC
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 21:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=arturkow2000@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso602238666b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743362828; x=1743967628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oodi4r5n4jMdoH4V9LG6kkv59sQ2PZ5q9ReQZ6Uk1WE=;
 b=kCqT7JOrMuv4hEemVzo6Lz09ZhO3+7xjWdFQrdnpX8zvLm0uMxkilQAiiaLjvJD0Tx
 5nw9clOS0g5ng7m7qIIoDbIsmuLF33O7U1HiPU6FJIh2xGte8vcxj0IgZ8lDLG0FeIug
 At3FKP39bCEwq+LyKUjzkT8eGins5NTDeaXKukG5ag8fdeMEQRmNH4FGeRsms9AK78Wk
 C6tqpjuIHCM3qTuJQIzVhFVmKGngc2j2n2UIpD7LUrwZsXM2NxnvZeOLaMi/FXvLFf/I
 j2+LE2o0fZ9SM8HJnsu+XnLmhtpWWsJ3bFyGZHXeJP6hrptODQJi41M2u182VGtwA2Lp
 pTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743362828; x=1743967628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oodi4r5n4jMdoH4V9LG6kkv59sQ2PZ5q9ReQZ6Uk1WE=;
 b=FhfCSs+A+XWzjRx7tIvVqZDSwixufieRMJnEK3pBw0Gq2aYTlj1IYUZX/Z8oUbc+aa
 c1rjCCa15N9+H8tbZAsnbDRXITVBTM7cYgXV3ZNvcL95+bKVjnJjxpiX5d0U7wqcZ/m+
 nBFhJKERtNYC+TNtLY3LK7FKCfOnvMN1HRPqsIsCXzwM5RWgeXJPhwKvgwPmnxp+l3m9
 nu+7hLINxTTR91dnxQtHUYLFVZhNru/2Xc7+KN7QmLD5Ox7I7ba088R/qh2dIlU7hi6l
 7bMGjxdEp8ISUCKDrpDUAjSxk9QZ1B5k8S/XOB/gPZ+nV52HqeKYQTg4Xd3UBcqMUIh+
 ALWw==
X-Gm-Message-State: AOJu0YynRpTMoTMFHyl8ujx2oGseVon5iZCN9S46bYu+TXessrXoyH5/
 mI52BwGQc0d7JdZ8PJXRKS5PbgBRTI69PLAaCD/hyyOn1H5sgZQaU5wObkoU
X-Gm-Gg: ASbGncu1Y9148iBcjnxzPYznfJWQzs2Q9UZUS3GM0PdZrA3DJb53EJ727eoL5wg9z0o
 DTQLhK7qDloVRTtTU/sSdMeGj97MENSjKIUFH3Uno1CO/Pf2ERmrD9OPu35xyoesjJByYgZGHd9
 Ae3knxpBPontBMRxX7WfWjsB4i8dwGzsUbO+syG/yB9EStiyAUpL2rw0oHKE8F/mNvibK3MfJMy
 TYtYAH1vwtuahrecbRIBAX+RmFn/3VniXRNcR/x5OkfdDdO9aKrRx5b3TAV7G0VPHO12sNJ4zf9
 FAvX0liFPIoFCAUFFUwLXRObmv63MGiY0nJyWQe/aqtJi1HYanA=
X-Google-Smtp-Source: AGHT+IGfulPc9/qufjhOwDWqxh26iJRyptUYzMVyJSOC4WUk8wMZWNtrmLlQ7l+yf1iEABP3enTmMA==
X-Received: by 2002:a17:907:86a2:b0:ac3:4139:9346 with SMTP id
 a640c23a62f3a-ac738975c1dmr605977866b.9.1743362828057; 
 Sun, 30 Mar 2025 12:27:08 -0700 (PDT)
Received: from eta.play.pl ([2a02:a312:c49b:a180:1d7c:64d:f4dd:a029])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71922029fsm522118966b.11.2025.03.30.12.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 12:27:07 -0700 (PDT)
From: Artur Kowalski <arturkow2000@gmail.com>
To: u-boot@lists.denx.de
Cc: Artur Kowalski <arturkow2000@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH v2 2/3] tegra: respect CONFIG_TEGRA_ENABLE_UART* options on
 Transformer T20
Date: Sun, 30 Mar 2025 21:26:40 +0200
Message-ID: <20250330212638.v2.2.I04194142897633b6272f2f235daed4f3a0b8939b@changeid>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250330192656.1280403-1-arturkow2000@gmail.com>
References: <20250330192656.1280403-1-arturkow2000@gmail.com>
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

If debug UART is set to anything other than UARTD, U-Boot's SPL hangs
trying to communicate with UARTD which clock won't be ungated. With this
patch it is possible to boot with UARTA enabled.

Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
---

(no changes since v1)

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


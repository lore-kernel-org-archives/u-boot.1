Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7148C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A82F884A7;
	Tue, 28 May 2024 12:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GmB+s9H2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFE08844E; Tue, 28 May 2024 12:00:05 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AA687C75
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a633ec1cecdso53390366b.2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890402; x=1717495202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NTlL8CuLxeDmvt2IUiEJ88QGrA/bPHcw+MB5xnTyrSQ=;
 b=GmB+s9H2FHiS39ZddsY8EqNN8K//dnwsC26UnBWsfbjeK2mQRY+8MdKU7aaVh843IQ
 V9aubLfptKluWoorKFhvGypAwJS5RKr673acWVuVWW967k/SxOairODa5fefOCbpRb7/
 B6ARYfhrSHrVbQW5dKIvi9l5aD7hHZtSQEj6qIAkEfhX9OqphCeDZ21TQhw23uKwP9NR
 78DE43C3WHSU461AXuYYSB0Hos12xk8+P6LypvGdDWsZVA/tlJObzmkn6R+U3JjHIBy+
 y/RrKQSfZfyjerrUW/l7ThN5yLVCLHsO3sUVf7F/f/jtPoUhBblJ0tCPTzucMSls+iUa
 t2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890402; x=1717495202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NTlL8CuLxeDmvt2IUiEJ88QGrA/bPHcw+MB5xnTyrSQ=;
 b=xTwz/9Aw19IPRcYzA3QYsXPVQqC1dEIzIOKRehzpFsPYXF+1Ln72GZ4qjdEG+A0ksN
 h8h0mY/oBQmB/O7wa+hqlRVRi13pFQhAuq+spXahjsZou6Nwi16o9pa6CFbjYm9ttF4i
 aMkxkd5f0fz+UK6pgbKFJ07kQ1d6/5ObDvObsuE04FJ1KfmcF0qZTYDr3gwkc8g+vJ/D
 FnprG4ejdhUtL6hlZO1arQxiKV/ZW7nVGFQdSY59V/qmQRWJZBXsz07o/dsYm41omtSh
 6GdAk0oqtScpD9Mq1kvsZ3QL//HnC8LpIudOvjvX7yDGd8yRVSrtxoQhbGMkQmJS5POH
 rmGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4sysMVJzETMF0qfUyH/l8pdNFdRuBrgqVHkecsfS8ctvFcZynwF7Kg8uxW1vEpm7cmiouqa5kW1PnQcFVhFsIPRD9+Q==
X-Gm-Message-State: AOJu0YxPe9HTRtbP7Kto6TB7F23vePT0+LDrLzpAra6QRqRzu30yULTd
 QYf2wZWxjoI2KwlOohdkh+3skEcoQ4j7bEdhSDavaRQ+kCC92ZQ1lRTev7XhJAA=
X-Google-Smtp-Source: AGHT+IG5IqGLZ9pC/RWwESiVWZQfpCcyqfEXVzCeG2mo8oenuJXhfReJtN7Q7ff0F7h+3XqIht1Sng==
X-Received: by 2002:a17:906:e258:b0:a59:8cd2:5b2c with SMTP id
 a640c23a62f3a-a62646cd7d5mr744212166b.39.1716890402533; 
 Tue, 28 May 2024 03:00:02 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a634da2e2absm33239266b.87.2024.05.28.03.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:00:02 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 4/5] toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4
Date: Tue, 28 May 2024 11:59:40 +0200
Message-Id: <20240528095941.872693-5-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add new PID4 0089 Verdin iMX95 Hexa 16GB WB IT to config block handling.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index f0d5a82b864c..ec41d4ea3c5b 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -159,6 +159,7 @@ const struct toradex_som toradex_modules[] = {
 	[86] = { "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	[87] = { "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	[88] = { "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
+	[89] = { "Verdin iMX95 Hexa 16GB WB IT",         TARGET_IS_ENABLED(VERDIN_IMX95)    },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 277f8bc6bb4c..122a7aceabd6 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -114,6 +114,7 @@ enum {
 	VERDIN_IMX8MMDL_2G_IT,
 	VERDIN_IMX8MMQ_2G_IT_NO_CAN,
 	AQUILA_AM69O_32G_WIFI_BT_IT,
+	VERDIN_IMX95H_16G_WIFI_BT_IT,
 };
 
 enum {
-- 
2.34.1


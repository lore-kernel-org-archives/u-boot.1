Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89223C25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF78888346;
	Thu, 16 May 2024 14:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="KUMkD6s+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DCB8824A; Thu, 16 May 2024 11:03:48 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A1788256
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5b25cee6b7bso4248704eaf.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850223; x=1716455023;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ootu72CHt6KCt0/12EACO8/j+U/grLLwqPxdgvTjGeI=;
 b=KUMkD6s+w3Q6TUxahsxGx3qJLkTOFXN/g7G9wLOCG5Dpf2HSNiKwk5fenTymSYq+KC
 +Sktohvg1oWxkrqs61wNNOz83mkjX/RdFaAaFLCq5wN2unC8FRykSQs7VbOr+zty+esZ
 QcvL9CF9qER2phdYu/hBYon6jIf1iETcELxvXSpr6Xml2W3LiiI/P4qqzmHxFheMXhJu
 Y10Inf9mpZEoPKMZmZ2P/TFJdkNj8xu3J+XZvhg/XL4YsxXQM3STcgh/gaNvfyG+NWk+
 eJCiryWCdCVC9nQjFtsdDUHuNoTJ/uqkiseMVWTnezJOOqsrAVeG2QCmBOn3Ugn1kF7v
 yACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850223; x=1716455023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ootu72CHt6KCt0/12EACO8/j+U/grLLwqPxdgvTjGeI=;
 b=vLNs2UuCn7iU3RzIN8X2qW1Aw6ZKK0Uw0L4opgYq6ByDdD3dOQ5Xlm4URXzb/55s4T
 wQHGDBmjlzPIGSEyYz+Cwey593rJAEM3sBAfNlktD7VIBUPK5hDm1e0IW6swVUIMEhfO
 1mciMbEhz0D9mlM4z+EHZDNLCbDz5uCIyW7znxDo0iwiVKeELcJzj7rfvY6KJ/APMeZ6
 nzJdpeZZUDEaPVWl1/Hwg1cOY1AhCrUpdtma+JhlW0xXh67IPY7MUwAvAEXX66c+OfR2
 UoIkGcrlLySpnScThuPhqyd6nHq147caQknbRmt7n+PiB1jEEudxvO9Ll6qsLWpxEqHH
 6nMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJwm2qvVIoFLoPywZzcpXOGEvFsU8Vo1ETP9jWVdFaHYH3euG73L56gpAhQtQajAwSgX4PtBjo36xWxDZ9Anpc/hpMEg==
X-Gm-Message-State: AOJu0Yzzvil23f1XwwPO2DCVK7v06SdcrDe2aFjKr4z5NS+Jd0cnQDyg
 WNjoL9HOQZv0QXx520LWIFUtldZbALH59zrD/DLQibbKzVbk3rKON/LLPjNdMio=
X-Google-Smtp-Source: AGHT+IEhWhVp5BRsDcMmJcs6WZJHFTH26kA250Sp+4qvBVQeOTNbxTo2onykS7Eyrn26fkaWx7y6+g==
X-Received: by 2002:a05:6358:3220:b0:18a:634a:6cfc with SMTP id
 e5c5f4694b2df-193bcecc5a2mr1428248655d.22.1715850222807; 
 Thu, 16 May 2024 02:03:42 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:03:42 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 6/9] rockchip: RK3568: Read the reset cause from clock
 reset unit for RK356x SoC
Date: Thu, 16 May 2024 08:59:06 +0000
Message-ID: <20240516090031.2373-7-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Read the reset cause from clock reset unit for RK356x SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/cpu-info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 77833c8fce..114608b506 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -12,6 +12,8 @@
 #include <asm/arch-rockchip/cru_rk3328.h>
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
 #include <asm/arch-rockchip/cru_rk3399.h>
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK33568)
+#include <asm/arch-rockchip/cru_rk3568.h>
 #endif
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
@@ -22,6 +24,8 @@ char *get_reset_cause(void)
 	struct rk3328_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3399)
 	struct rockchip_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
+	struct rk3568_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.45.0


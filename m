Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F4BC25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 10:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF0AB88489;
	Tue, 28 May 2024 12:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xt3AKlIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D968845C; Tue, 28 May 2024 12:00:04 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF7D08844E
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 12:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-579cd80450fso3277742a12.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716890402; x=1717495202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUhgo7vzr5uWqNY/zLlafWR0bopXL1LEQh6Ai7ZHEFE=;
 b=Xt3AKlIvkL7D3XRzrCnnK3i1B1Oj1hqjHLX5I9cq/YGqVpg0S5KbYhK1oEg45C3/m5
 Xzo3QMpRDFCe7boa57wIH6muWNl2WA1Gxf2qiReL1Ms+II1gj/Lz87J6pxhrS2oymw71
 oaZ1R+GZrZvdQ7IJVUkXOy8jxUHAh1/r8BHOiSrVnnh0SjUPeNicjc39xt3E41FCUQkr
 DX885Axs3gPY4t4u0mF1fHBtPxbEB18B5CAfWHiFEWvOOHejhgPI/Yn4GuPMxutu8oQ/
 fJg/6RTmdN9sPMVYI0yAso1PD6V+BTGcHxUCTThtn3mcr0VNMGrn6Yk4UIB0QJK6+jvA
 61iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716890402; x=1717495202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUhgo7vzr5uWqNY/zLlafWR0bopXL1LEQh6Ai7ZHEFE=;
 b=dEM5V63SqSKP2/NW9zf21dfGNEZn4bn/fRHxDvnmAEX05R3UeyLUx4Zsugj4Rsk8M0
 rVVuAaGlX2EU7T45FB8/Ysntzvm5b2JoVHwsrvo1f+hd/xRpaMq2YzZaNLRaHHvQ9Bmp
 GbU+02ZhK0GZzkyDrTh9Rek4OGr/8f4tU27p4iTn5BefsSwFVmQeLSjHJkn7O92ex8Sq
 +DLnd/hmHWD5Vop83qLJUrmwwC8rARTuzt4IXyfoTEXY7eHpJci5N0ePMvsw+EcFA6tc
 NFC6wNZXHDjhshYP6TwTKOrLMdwRtIyaHFXLhX/QuUaeOuznlVeXcSYfeUkCiEhpuFIk
 xjwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZLu54TAr+uqWT+gkuflCwxldOE9+9fZ0dT/SYocrnAbe8jU9lXpTrOqtcTKQML37Jpl+LVrG5K4CX1VVhgYZkhsxzxw==
X-Gm-Message-State: AOJu0YyJmPdREj+xwPovZGn+ipR0AqgXrrJ3Ezgc0JpJmcACy0BRzHeZ
 EBp8AiDZafJm5M3Y5qMuVrFP/Lh0iFwxC8OG1G9MbmIN7WkgxERb
X-Google-Smtp-Source: AGHT+IG1vgPDX7HUUh+tuwfkss9lWyZkdDagjIFZl3M/Mhlwlo+mipXLCYi9s21WEK/zUm5q4lMh5w==
X-Received: by 2002:a17:906:b88e:b0:a63:38bb:b92a with SMTP id
 a640c23a62f3a-a6338bbbf62mr129080366b.10.1716890401887; 
 Tue, 28 May 2024 03:00:01 -0700 (PDT)
Received: from emanuele-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a634da2e2absm33239266b.87.2024.05.28.03.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:00:01 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 3/5] toradex: tdx-cfg-block: add aquila am69 sku 0088 pid4
Date: Tue, 28 May 2024 11:59:39 +0200
Message-Id: <20240528095941.872693-4-ghidoliemanuele@gmail.com>
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

Add new PID4 0088 Aquila AM69 Octa 32GB WB IT to config block handling.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 board/toradex/common/tdx-cfg-block.c | 1 +
 board/toradex/common/tdx-cfg-block.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
index dcf00d2b6325..f0d5a82b864c 100644
--- a/board/toradex/common/tdx-cfg-block.c
+++ b/board/toradex/common/tdx-cfg-block.c
@@ -158,6 +158,7 @@ const struct toradex_som toradex_modules[] = {
 	[85] = { "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENABLED(APALIS_IMX6)     },
 	[86] = { "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
 	[87] = { "Verdin iMX8M Mini Quad 2GB IT",        TARGET_IS_ENABLED(VERDIN_IMX8MM)   },
+	[88] = { "Aquila AM69 Octa 32GB WB IT",          TARGET_IS_ENABLED(AQUILA_AM69_A72) },
 };
 
 struct pid4list {
diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
index 183ee0f2dc99..277f8bc6bb4c 100644
--- a/board/toradex/common/tdx-cfg-block.h
+++ b/board/toradex/common/tdx-cfg-block.h
@@ -113,6 +113,7 @@ enum {
 	APALIS_IMX6Q_IT_NOWINCE, /* 85 */
 	VERDIN_IMX8MMDL_2G_IT,
 	VERDIN_IMX8MMQ_2G_IT_NO_CAN,
+	AQUILA_AM69O_32G_WIFI_BT_IT,
 };
 
 enum {
-- 
2.34.1


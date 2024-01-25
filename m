Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67D0C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA4687887;
	Thu, 25 Jan 2024 15:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ti2f4SBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDED87866; Thu, 25 Jan 2024 15:05:46 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C6D8786C
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d71e1d7c78so41334015ad.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706191542; x=1706796342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9QfwjjOjTYSvR4bsSBfYeLV+M7GwON/WlQUjHkqYUeI=;
 b=Ti2f4SBxtxHKUj2OIGXjRHOKxhFwpRA5KkAIIzUqv7G8F+ejpqHsTRbblslXDcSNpQ
 glSF+Irx9oBO9TU87grK+IuKzi0rk/pe6yRRniSFfcueCN72pQZYsZ/O9IOkxDpnFSuR
 kuUVAD2BpAx8z1FtNUgMGzAdzF7ltVWYiXFqQYO3eWSfeG8aT08GzEYgrh3DAVOPSQgi
 QTI2xiYTYUGwFNxG6y5QvFNulfGcQV/wiKBjoloelAeGLFOTD/C4hcIhKw3MmXVYjw8v
 1jEu2LTxrdYk6Iu0oy44qrg3ag4PBiLDfOE2gI8AjC/25khqw6FjPtEh30DN66lUogtf
 +TOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191542; x=1706796342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QfwjjOjTYSvR4bsSBfYeLV+M7GwON/WlQUjHkqYUeI=;
 b=lWy8v6KnzQbMsFvOyUNyQgzYYrTFkcIp+b8hjP0R3AF0KgdG72raPtea32CuF0aKZy
 OIwS5n9rAb8R2t1as/vwMijRLJW9/X2WQCPj//XWX5M19FvLZBl6qi8zeuXj739Zjo5m
 4iI3GLnukQY2/hCqZE+lPuIHMPR1fAuPAtXdZ7GTqs+Ayk1w1Tji2M+MY8gieO7vr768
 /BAb70SKTDsBFRqQPxeR84X7ogQMn7P3XpwvPpZuuVCvJpqEGJExqhQXDmoFLreM3TU0
 5W9+uBjfpCuJp2tt/0+HBV3M+a3yMq24uBQfkfH5xtbb6Wi39QUBNL9gWsUh8JQh4NYw
 /GVA==
X-Gm-Message-State: AOJu0Yy6B0Hxb5+80kXISA56EplpHCmPpzyCFAyak99dDCy6Z8O70d3X
 /KeCmkwBACP1BQaJWk/c46kyjVyxPUNTNErYn5X2sCRn4Z2e+cHlGNPiWdwk/w8=
X-Google-Smtp-Source: AGHT+IFN+oiAP8lCibcu2IxCg1JTbA4m59tlrFfhOhG/fqzQRRcEp+wkwHgkYGfNPqnQuQAUnhtjkA==
X-Received: by 2002:a17:902:d905:b0:1d7:27a0:127b with SMTP id
 c5-20020a170902d90500b001d727a0127bmr882523plz.19.1706191541869; 
 Thu, 25 Jan 2024 06:05:41 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 p18-20020a170902ead200b001d705836d0dsm11925699pld.200.2024.01.25.06.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:05:41 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH 3/3] cmd: rng: Add rng list command
Date: Thu, 25 Jan 2024 14:05:02 +0000
Message-Id: <20240125140502.22400-4-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125140502.22400-1-o451686892@gmail.com>
References: <20240125140502.22400-1-o451686892@gmail.com>
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

Add rng list command to list all probed RNG device.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 cmd/rng.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/cmd/rng.c b/cmd/rng.c
index 52f722c7af..4818133f94 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -18,6 +18,19 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	int devnum;
 	struct udevice *dev;
 	int ret = CMD_RET_SUCCESS;
+	int idx;
+
+	if (argc == 2 && !strcmp(argv[1], "list")) {
+		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
+			printf("RNG #%d - %s\n", dev->seq_, dev->name);
+		}
+
+		if (!idx) {
+			printf("*** no RNG devices available ***\n");
+			return CMD_RET_FAILURE;
+		}
+		return CMD_RET_SUCCESS;
+	}
 
 	switch (argc) {
 	case 1:
@@ -57,6 +70,8 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 }
 
 U_BOOT_LONGHELP(rng,
+	"[list]\n"
+	"  - list all the probe rng device\n"
 	"[dev [n]]\n"
 	"  - print n random bytes(max 64) read from dev\n");
 
-- 
2.39.2


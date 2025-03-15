Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A14C28B30
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 14:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112B880F91;
	Sat, 15 Mar 2025 15:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Byxp74Nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1458281ED8; Sat, 15 Mar 2025 15:28:42 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E095A81F30
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1932455f8f.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048917; x=1742653717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pcg90l1jRbB5AHpHadrVl+7bPISm830OmrkRvdO1JBo=;
 b=Byxp74NvCwFk6jb9Enbey7vbq0sE+IFuuBjAJ3sf0aR+H5D0QnlZrQu6MDLHsLbxFj
 7y3OFKGHpxaNIWol44jiseVqlqcXxNw267LzW2hqpCVTgDo/vlhGywoqgeP3RPW+VvQu
 txwFtEufT0zPIgOaQ6DWA9sgU8+aQyaq1zxto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048917; x=1742653717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pcg90l1jRbB5AHpHadrVl+7bPISm830OmrkRvdO1JBo=;
 b=SwCP+KmeQPmWt6+DHXSuYCH28OLZWJYsIMLiLKHPfB4ee2WPlmn9lYS5joVIsriyiA
 4ERHJtYbQ6Q9IxnfgzR9O9gZjBDEg4U5sc4x6dp1A/fm2W7FtxHV+c7SxAGtCDj+LF0j
 51aRvMjcl66IJUwX6gVsLp15MPxpW+bgEGlU8aKjYVUHV+l9Kw6hSXA1wA+j3NSOncwY
 L7i4jD5r9BuEkDi+iePf0xtXzTWqaB/VVCaDgDLnSv71iUaSGql/cnNrm0U2g6pBvhds
 elutvYMWjYGNBwa4pxoLzcK0lSTyI67PUXaRDQsDfwjhsMYzOtxHGxa066OOtz09uaIR
 iJjQ==
X-Gm-Message-State: AOJu0Yy3mRwMYu9X8zh2BaX5upYcR+dZqZ1qe3tA2Kid3NbM4lOR+5VG
 A0jA+h300QHnLOLQr/2mO6V6EgeSAq6djjsSfG9Oh8f469ocxBQLH+lNgvTidBtj+wvoHnUDQnX
 2eQ==
X-Gm-Gg: ASbGnctQWmRuavvc34Aw3bSSrMUMpSdDrjGF9UA2bge7+wIZYAj8Ud2uTQ1X1M7aaqg
 nJ8xnA9lKKZRq/eQ+PBx81dyBnrEbIBlK/vKQ6X8VlBP0CW79x3orCHFkqgcxlkBx1TPTczuDfL
 mDEmoW6pxKIxi44bIbgJ3BoGCTVX0DwWbQLlMZTDlkkW+DTezed+uO596K7LFdeYlc+dzVlMPj+
 v6j5wc1fuS4maqqkNmp5cU1yV75MjfRJ7z+YTbD1tDtfoc1+Z/SQSsGPZ9BazFuwKNihaGs15M+
 DCRFuMTelZYx7pXJIHzk5FErY/7fxxVIl+YhF4yeTQ==
X-Google-Smtp-Source: AGHT+IH5nNmnugbyvscH6xKwv1aQ6C8tSHUvsh2UWl/QzFQFz8EFKKTX2sSGvidLtaDZjHPx+byd0g==
X-Received: by 2002:a05:6000:1866:b0:391:2a9f:2fcb with SMTP id
 ffacd0b85a97d-3971ee44653mr7936538f8f.36.1742048916942; 
 Sat, 15 Mar 2025 07:28:36 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 40/46] boot: Support IO UARTs for earlycon and console
Date: Sat, 15 Mar 2025 14:26:00 +0000
Message-ID: <20250315142643.2600605-41-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
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

Update the string to take account of UARTs which are connected on I/O
ports, as on x86.

Fix a typo in an error message in the same command, while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support IO UARTs for earlycon and console

 boot/bootflow.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 58a1afa7a75..4054a966af8 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -942,8 +942,9 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 	*buf = '\0';
 	if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_16550_COMPATIBLE) {
 		snprintf(buf, sizeof(buf),
-			 "uart8250,mmio32,%#lx,%dn8", info.addr,
-			 info.baudrate);
+			 "uart8250,%s,%#lx,%dn8",
+			 info.addr_space == SERIAL_ADDRESS_SPACE_IO ? "io" :
+			 "mmio", info.addr, info.baudrate);
 	} else if (!strcmp("earlycon", arg) && info.type == SERIAL_CHIP_PL01X) {
 		snprintf(buf, sizeof(buf),
 			 "pl011,mmio32,%#lx,%dn8", info.addr,
@@ -954,7 +955,7 @@ int bootflow_cmdline_auto(struct bootflow *bflow, const char *arg)
 	}
 
 	if (!*buf) {
-		printf("Unknown param '%s\n", arg);
+		printf("Unknown param '%s'\n", arg);
 		return -ENOENT;
 	}
 
-- 
2.43.0


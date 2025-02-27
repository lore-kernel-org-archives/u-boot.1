Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E6C1B0FF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D97810F5;
	Thu, 27 Feb 2025 17:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zvsud4U0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C4C8118A; Thu, 27 Feb 2025 17:50:33 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A0480BA4
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2233622fdffso24053445ad.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740675030; x=1741279830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pAsvJsE6XpsjDt3OUAoEdrl2whfcpuNZ5cxeWHtRpDA=;
 b=Zvsud4U0jXbzd9ccY1LHRC1BoIkxU/ZCp234Tj0RtQGrvtvJNl1ewcKA4kRxPHULIX
 vAiclQnNWWqAjsJEAax0lZhj5USWN/rMBnRAgJ6Qb2YQNJDknZa1LPvoxt9Ek9XywxuD
 UtW8nT9UjmvBgh0w0IYpj9VLyBiPTAVFVu6ED4Qko8RMROxsyu1cPgfmmTtVwhUUBBEG
 cHcsQMWzzHqPs5KNh3knqUwgZfoKRyO/BCJz1nXIVUJIYtyUN/cbvVwQSGNcqUhj/l22
 W2JEz3xHHFfRZfqujEgkofLhBKWaIrg+BxFzgpYR/E6FSf7qFddsxxhYVOHhivuuCuxg
 Q4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675030; x=1741279830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pAsvJsE6XpsjDt3OUAoEdrl2whfcpuNZ5cxeWHtRpDA=;
 b=fQfViRfOdI44EfGmEqLoDMIAy1HWIi4E19+ENFSmOkNr5Xyh+f+OJscd1dQt3A1nma
 r493qCizKEwN6xc4/xgUicb0y1iTBw3gNMzgDBnSNDg+lDENeIrYF0X5eCvGJFVBt1Sr
 SCXRRaL1pTx9QmeHZu9mmxzUpZ6C7NRGYwwlTA7qImSheCxxmcmtzNd6eKmSXH2SRWxK
 NSnjKXcg4tUUyS/ed35ZsGwQOQRvHFXloi0PYGzDAx/2TgZ10cfWpKNYCkusx380c2tA
 fP7X+LPMSd0lukhMHyQ5hPOezMm1ws9dtrppRRVCRgY33MCevtjRy2AwUsCw+ASYgTl0
 auCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrmeEei9v9OOY/wf1BiFMkPgv7xxyTZw0txy+qREe/ICcGneeaC3dR2bGbZjKahOXK+rKmE/A=@lists.denx.de
X-Gm-Message-State: AOJu0YzIqn++G9IbKzEjoIJ1U1DQXfxGC/reCr8LGJQ59jkYBkPNnxLp
 LdJde8/jkeSZyhc7lUx/IIlXOFXOjtQDWVz9r9h6/JRpUg+TDFI/vwv+iA==
X-Gm-Gg: ASbGncvXIdOqCn8aKrtuAOsf0q80vSppyWPDvcGZ1svhdrmqfBxAsC9heqJg3rtNX8I
 xF7uFyUu6k5AvENuU/tl7gh/uD8F5MgHoIHLbh7Tss23lMK+ykC+Dyt+OTcFUaMmcRscff1FN0M
 2NbdmX1K/XfpXkwGLxGyg7z/RRWCGK/svHuvY2OA+TZ4Hw0nXavHucDwocHoWgZL3Xezw1s72Pp
 vjVfJ8VPy10PnXvwttUFQK3R+4r2NO+FDwM88T904nxS7WDO0NG9RF4NPEcvIFGHgwNY0M6HF4v
 sNVI1ELTovDVpGAkMtBlb9Hy0sQBOMpK+fa/oxy6
X-Google-Smtp-Source: AGHT+IEG00rNb0OvEoy60GtWCIXSKQ8j4lgEHgDdv5LzSOSegVZ+ilyEO9Y7aZTPojb8fLl7OdKpXQ==
X-Received: by 2002:a17:902:db0f:b0:220:efc8:60b1 with SMTP id
 d9443c01a7336-22307e6587bmr191773155ad.39.1740675029563; 
 Thu, 27 Feb 2025 08:50:29 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5a29:6887:1512:7ff3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223504c8665sm17223355ad.156.2025.02.27.08.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:50:28 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: ye.li@nxp.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx9: container.cfg: Guard tee.bin inclusion
Date: Thu, 27 Feb 2025 13:50:01 -0300
Message-Id: <20250227165001.252176-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Guard the inclusion of tee.bin with the CONFIG_OPTEE symbol to fix the
following build warning:

  CHECK    u-boot-container.cfgout
WARNING './tee.bin' not found, resulting binary may be not-functional
  BINMAN  .binman_stamp
  OFCHK   .config

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/imx9/container.cfg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/container.cfg b/arch/arm/mach-imx/imx9/container.cfg
index 91a973161d10..a018c365c821 100644
--- a/arch/arm/mach-imx/imx9/container.cfg
+++ b/arch/arm/mach-imx/imx9/container.cfg
@@ -12,4 +12,6 @@ IMAGE A55 bl31.bin 0x204C0000
 IMAGE A55 bl31.bin 0x204E0000
 #endif
 IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
+#ifdef CONFIG_OPTEE
 IMAGE A55 tee.bin 0x96000000
+#endif
-- 
2.34.1


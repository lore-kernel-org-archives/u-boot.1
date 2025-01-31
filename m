Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD7DC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 14:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DED82119;
	Fri, 31 Jan 2025 15:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgNjdywe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E29D8213E; Fri, 31 Jan 2025 11:04:53 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9759980F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 11:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5439e331cceso2045699e87.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 02:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738317891; x=1738922691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dRex07OEWIPZnUyZsm6OPwzbjYcK8WABYtuZhS0qjkw=;
 b=SgNjdywes+iwM0YOFTPwDwSEEKD5gb+z3eHv2/W32oyGtHiQ/zKkggWu6tYzScPz3P
 shFTZBnCfwnpCuM+Hlp3yhZVF2vsf3nIrjsWfKGyuYN+xwQYBF7SGab3wpIW0zTWlvX8
 sxstiBVdfIZ7xmMcDm5ciN3rN7T2nfEF/WBYhljcNVXvbmJLRpgZFmvuBVvtzJVYc36X
 ZsVs39GgbOjFQmg2ENC7zCzpif1BbNOiDprWk+lrYpWoSXyTxvwkEh0IjrPAbS6E5tsU
 GGqZOIdePIQRqZPktpBFIJ+raxNOXmIr7881rUBLSuY+yKuPy6XE6zlOPEglDslatzaU
 Luiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738317891; x=1738922691;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dRex07OEWIPZnUyZsm6OPwzbjYcK8WABYtuZhS0qjkw=;
 b=AeLKIzG6KrVFHPDpFYWFvsGl62Qz5huvhAQ8ISqP1s2KjmDKZc3mzqiOxxEx6qDs9w
 YbIYlSaqvXWI8ZeVLGiw4khgWlgjVTOaAX6M3E7q6EWFqXRRE1QcxEZc/NXD+ziTSqI3
 cBT+qJZNenjKGwtuj93Nl0rbGC8+qU/SVD379HB6qlobYJ9Vix3Bl5uUfv6coxCqfMQA
 uOXjK6MxlUfIQ9pPX4a7nn5EJBhco0j0tBANvjk1wWCU/EUsJiVbVwvtUCoTxCJS8rAl
 w0b4/fVB9N/bNSYUvp0Kl+7EglLpJ1a61cZao978oj3+dOAGuS73MNb0J59sRzhvac6e
 ycQQ==
X-Gm-Message-State: AOJu0YwM1r7qQMTuWCbAikRsKn5z6o3wRl9EpHZ6OsYzV0TrHSqg6LIm
 Z8Tth2IGHfyvjVZNMUcWXAou9RY7BlStGgvIIuz+SYVScLn8q3+awJM44w==
X-Gm-Gg: ASbGncvw3zErnLdb/kmZ8LEXpHCuvErS7eTrYlRNjUICqnzJzJIbmM/dJBGG0jxn71U
 d7PwNZmHJP60TI2RkGSmey+lTTuffytSRKKRWneO+T8SSAoC4zhhUCmy/IgS0xq7/CZGguV5S+k
 KqmbHmzdUqgzgSG1jxGCHsqmRUfgyNmkuK13TRRmNTOVd8pPP5Y1WM88QEk+zFPKOVvAumnaxLH
 B1I9VW5FEM5lD2CkGBVSr7rcBykG26ZMtzqCHwDn071CKofDSUEzCg6y4lskdFiFPGdxoAuWyVt
 kUqPAZx+115JA+3jLySVGFQ=
X-Google-Smtp-Source: AGHT+IEKamJoh9wDJYtIZcLxMBrKCJJ3ytVOwR2FZCP0bxT6nBs2weIkDUUkvXqFxDTbQ11Dn4W39g==
X-Received: by 2002:a05:6512:402a:b0:543:e406:6367 with SMTP id
 2adb3069b0e04-543e4bdef29mr3561309e87.4.1738317890455; 
 Fri, 31 Jan 2025 02:04:50 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543ebeb0633sm424250e87.141.2025.01.31.02.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 02:04:49 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: imximage: Fix potential memory leak
Date: Fri, 31 Jan 2025 13:04:46 +0300
Message-Id: <20250131100446.1668349-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jan 2025 15:13:17 +0100
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

Dynamic memory, referenced by 'line', is allocated at imximage.c:761 
by calling function 'getline' and lost at imximage.c:793.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/imximage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/imximage.c b/tools/imximage.c
index 467d9f27d2..55231caf8f 100644
--- a/tools/imximage.c
+++ b/tools/imximage.c
@@ -783,6 +783,7 @@ static uint32_t parse_cfg_file(struct imx_header *imxhdr, char *name)
 	}
 
 	(*set_dcd_rst)(imxhdr, dcd_len, name, lineno);
+	free(line);
 	fclose(fd);
 
 	/* Exit if there is no BOOT_FROM field specifying the flash_offset */
-- 
2.34.1


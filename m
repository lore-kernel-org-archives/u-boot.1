Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C463C47079
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 15:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0112587909;
	Sun, 31 Dec 2023 16:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QhDrKZ7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77788878F0; Sun, 31 Dec 2023 16:26:23 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A018878A5
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 16:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ba903342c2so589725839f.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 07:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704036374; x=1704641174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rstqArcNelG3IVr1yF1v1ESKHomY5lRGyhdl5dvysQY=;
 b=QhDrKZ7/+CyIyzoag1We0KrVc/Nx5evJ84cMpq9h9cAmaZ7/YYLd9lKS4Ub0O+ZRuD
 pJi4xnyvAmEegRPzsOUz51jS0fDZZ3dzVDI2DeEyf5Ou7KtHgIdLEs9eR3Hlb8cwA8zD
 k2aatLp8US+/eZ42G+fr0VJwwrv8JjrQ3zNqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704036374; x=1704641174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rstqArcNelG3IVr1yF1v1ESKHomY5lRGyhdl5dvysQY=;
 b=jhG8lDS6Fe82Udvpm9jhsI5aymY+YkN3pXdU2YarddE852P3sdadGFNSCbZwIuR8zC
 lsq2kGQJUsmFK0GfZXr5A7sHTeLszieuHpeGbVsXmOf9fvco4DfbapGEGGeOs4ko9CsI
 xoSKV/2pBzEhSQRl4O3ITigc0NMTVf0LsubLKch57TeaSQuWN2MKGoNesseeJyqwLqvp
 dO8LNMVBtZYb2w+DxhoBkyBRQw3T6SFvAW1rLjMAzHuxf6lGO8RPpggJDlea/KcLO8Nn
 sdlTQnnSKwIRMf8eUM9lNDY/7oRe5fLCxLjhXU46OK9t3Kc6TuV2Z4+RMzYn93Gi72X1
 v/dw==
X-Gm-Message-State: AOJu0YwtKPyDbkK2aAi8cBpO/c95dsIHHMf34Dxu1VNEYZuflIftiYav
 jWevQD+Lwsgfubs0aPPnLms08GRXBV2GV9v2SaD3/e2Tgixj
X-Google-Smtp-Source: AGHT+IGhDBwECfnxZHC3OHlJADb0Un65TEn6ZoYVL/NjBEmc0DfXk/pTd3M8lEe3ASJunjWUtZCtJw==
X-Received: by 2002:a6b:e00c:0:b0:7b7:bc01:3723 with SMTP id
 z12-20020a6be00c000000b007b7bc013723mr21268874iog.20.1704036374803; 
 Sun, 31 Dec 2023 07:26:14 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cz9-20020a0566384a0900b0046b482039ecsm5632625jab.55.2023.12.31.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 07:26:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v5 07/12] smbios: Require the caller to align the SMBIOS table
Date: Sun, 31 Dec 2023 08:25:50 -0700
Message-Id: <20231231152555.464874-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231152555.464874-1-sjg@chromium.org>
References: <20231231152555.464874-1-sjg@chromium.org>
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

All callers handle this alignment, so drop the unnecessary code. This
simplifies things a little.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v5:
- Update comment to mention x86 alignment

 include/smbios.h | 9 +++++----
 lib/smbios.c     | 2 --
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/smbios.h b/include/smbios.h
index 77be58887a2..49de32fec2d 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -258,12 +258,13 @@ static inline void fill_smbios_header(void *table, int type,
  *
  * This writes SMBIOS table at a given address.
  *
- * @addr:	start address to write SMBIOS table. If this is not
- *		16-byte-aligned then it will be aligned before the table is
- *		written.
+ * @addr:	start address to write SMBIOS table, 16-byte-alignment
+ * recommended. Note that while the SMBIOS tables themself have no alignment
+ * requirement, some systems may requires alignment. For example x86 systems
+ * which put tables at f0000 require 16-byte alignment
+ *
  * Return:	end address of SMBIOS table (and start address for next entry)
  *		or NULL in case of an error
- *
  */
 ulong write_smbios_table(ulong addr);
 
diff --git a/lib/smbios.c b/lib/smbios.c
index 7f79d969c92..cfd451e4088 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
 		ctx.dev = NULL;
 	}
 
-	/* 16 byte align the table address */
-	addr = ALIGN(addr, 16);
 	start_addr = addr;
 
 	/*
-- 
2.34.1


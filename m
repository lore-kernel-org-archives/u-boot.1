Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF8FC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA51687D9B;
	Tue, 23 Jan 2024 18:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X3kDmWzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E8687D25; Tue, 23 Jan 2024 18:17:17 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C271887D50
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3046221b0eso220728566b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030230; x=1706635030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzWHW1OHNi3+9A3wFVqFpbO6Kn7tL3IPriQdm+LGgeQ=;
 b=X3kDmWztPtHJ2XUkspEarBKeuuVJUB8vrh0E0foR6tsDfIUN9ber+AZLCe4FjDHL63
 HbgSnH/Hglq5F47MG1xSt8l0pZVAIspSBBVj2CcAfYuZx0hqBAtYBGvI80kKyclC3pr5
 /pA3lFRxDDgHkekL+2nHzBPaZx0NZ5BYz44XDoRVrkkFuygL52kYPe1jiCKuGLCpW5X+
 TnQG3YwMzr/kBPIMN+dxbUZcAHBZple3ZDSuw/eonnJrB/iDCBToA85wTunCmicNkULj
 UIyRwnExYcRht8bLPODh9bg/TZrHHc2Uve9+iPo+zXrXZwk3/xt8lzz3gNC9xDR45TFS
 gCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030230; x=1706635030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzWHW1OHNi3+9A3wFVqFpbO6Kn7tL3IPriQdm+LGgeQ=;
 b=bajuIbRgVnyb+O/3t7nQe0Ib+UAInnuQTFAJtXDKw9BP2rup733WpcNGa9Oha0drb9
 eLaUzewpZQS1BrDdPcXYH6GiTSwjohTp41wvdPee2t7XeBSXcZJX7n6eJcyyz8XdFEl/
 xJ7ZuSxH2GweCy4Im8X9YW4Tq4oSFC3cE+H4xOLuTfKFApydGKWkPY8HX4s255NDPRHl
 m2r8tbq4PXIQUdPaVDdImAqJRrWGYwh4X91ekCW2sSh5ZWZ3E3DlhAzpfrnUlSghXiQ3
 YfxbN3hRArb+3XK9sjhUExaO18H0tQydEzK+MuqeFF2pkUFCWCfaHmWAFyBnEL4YN1xA
 U35w==
X-Gm-Message-State: AOJu0Ywnbt6CDkhvXpg4GXN0a/jmfsNbIWdCxosev+Q+99NRnvIPglQd
 O3JOK26Jk50Vmw5dYwn7iPiO6RrSTSooQreQOKRrZJ3QRLvokx+9
X-Google-Smtp-Source: AGHT+IFx9biRjL1MMMgZybtqwquB12M5JNHquepPsORljVUG1S0DE/C6kpheMMui76N0koEKeep1xQ==
X-Received: by 2002:a17:906:3389:b0:a2a:767f:29cd with SMTP id
 v9-20020a170906338900b00a2a767f29cdmr98701eja.75.1706030230230; 
 Tue, 23 Jan 2024 09:17:10 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 09/18] video: tegra20: dc: fix printing of framebuffer
 address
Date: Tue, 23 Jan 2024 19:16:24 +0200
Message-Id: <20240123171633.246057-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

Framebuffer address should not be a pointer.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index a8e32e6893..000a0e02f8 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -429,7 +429,7 @@ static int tegra_lcd_probe(struct udevice *dev)
 	uc_priv->xsize = priv->width;
 	uc_priv->ysize = priv->height;
 	uc_priv->bpix = priv->log2_bpp;
-	debug("LCD frame buffer at %pa, size %x\n", &priv->frame_buffer,
+	debug("LCD frame buffer at %08x, size %x\n", priv->frame_buffer,
 	      plat->size);
 
 	return 0;
-- 
2.40.1


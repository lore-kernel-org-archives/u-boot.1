Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B05C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B4E888E13;
	Wed, 21 Aug 2024 18:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PirGz4kJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833A388BFE; Wed, 21 Aug 2024 18:19:40 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7411088C0C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-704466b19c4so3975514a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257177; x=1724861977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2VvIZslOyTJEYHNUNDzPUkSdUgEmdjJxFMCtKA45Gg=;
 b=PirGz4kJDxs0fTbWRxsTAjuDGt/xMybWMhJLtsyQ/oKD4Q1IjBU8aPxyjGfqWfmU5r
 5ZxV8PCaWL8a1d5zlF+5HIZf5YYi11CE/6Hwy4j7ubwooJib0b9aBDcN0izfGyEPz2Ns
 D9RNBs0IuUM8MHr2nMDdGAQ80lEHZ6RX9yhxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257177; x=1724861977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2VvIZslOyTJEYHNUNDzPUkSdUgEmdjJxFMCtKA45Gg=;
 b=khyWA4ITYC/58V7hTvSCFibYnLlwGTRBdGEo/GnWNhYWkCJsR+nyBlYeDQg/b/YOun
 ERnbO/elQahhf/t2Hfx/wZ7P0/34tCbuzbNXRoqImNGy4+0XCDglVyJ9vU2DG5SZq6Rj
 QINTVbclaoCEJ+WS+SDKu2uhnxvP69RtTBvKSl8Lt94fUOTzQHd3Vfo15npiKpaRBDfo
 p3TI+5VWdNxXlrnpQqgYYaWz/vJyJg6TCdiCMy9FWZXTQ6OBZMbfOm2uHwOGfeaEPaKk
 ubKN9sIrvACIyFbjaPU/bYXJF8XRMDnPXG/JgVY0UzfsPOdvsWus2XXM2XNmOtHKwxHM
 MLzw==
X-Gm-Message-State: AOJu0YzjKU4nJaUkD2eGRtKq2CzLwTShpE3IfcUyCAlXYkL1m8GmDogn
 /SCffBKO+6mjnmOZ5u+S8xgcYkVfIgD6Ay26+dLGSkioOeznPO5F6mypD27Ad2rxbwIyePuSDE4
 =
X-Google-Smtp-Source: AGHT+IExtZECofIyQJaV0rthIFR8YnhnwFrmTov9MLMccUX8DcxbIf+vEGB1Ct1ZvqHNvNw05WAMwA==
X-Received: by 2002:a05:6830:25c3:b0:709:3839:b7d2 with SMTP id
 46e09a7af769-70df88767ebmr2441286a34.31.1724257177127; 
 Wed, 21 Aug 2024 09:19:37 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 02/35] x86: Drop use of global_data fb_base
Date: Wed, 21 Aug 2024 10:18:54 -0600
Message-Id: <20240821161927.695717-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This value is set by not used on x86 so there is no point in setting it.
Drop the assignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/fsp/fsp_graphics.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/lib/fsp/fsp_graphics.c b/arch/x86/lib/fsp/fsp_graphics.c
index 5f7701265a9..ad25020086c 100644
--- a/arch/x86/lib/fsp/fsp_graphics.c
+++ b/arch/x86/lib/fsp/fsp_graphics.c
@@ -103,7 +103,6 @@ static int fsp_video_probe(struct udevice *dev)
 	 * For IGD, it seems to be always on BAR2.
 	 */
 	vesa->phys_base_ptr = dm_pci_read_bar32(dev, 2);
-	gd->fb_base = vesa->phys_base_ptr;
 
 	ret = vesa_setup_video_priv(vesa, vesa->phys_base_ptr, uc_priv, plat);
 	if (ret)
-- 
2.34.1


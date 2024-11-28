Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7480CD6911B
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F6B289D98;
	Thu, 28 Nov 2024 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d7BLMe3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511F989D93; Thu, 28 Nov 2024 16:48:58 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF5A89885
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea5e405870so445911b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808933; x=1733413733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mc2SOHZscXBipI6MC5Tl7VBc9MmxrFpy3A5HNEHk54=;
 b=d7BLMe3fhW8UwftnZ9Kwq9jPmuw9e1F1yScNpUmsIjz9uHN8WI0Y7CKQ5HkGUGxdAn
 VaUAVycBp+woG8JWg0rwxdDYr/pFiQAeA5RBhU19pOXiimsLk0gpzftJq0TBaW0ym/fm
 k86uPRdS0qm85VSORSffud5M4slhU+ohBPVAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808933; x=1733413733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Mc2SOHZscXBipI6MC5Tl7VBc9MmxrFpy3A5HNEHk54=;
 b=wBaE4sNapw3OG0WnQi8EX2SS4kFaW2kWFHLeL9Z8ArGfErHFRAMLPBvyZQTn9MrD7z
 +mCGZi5ZHxAFiukUHjPu/BI0eBXzdTT1QLm1lZNXLH0cTRUDwzeHq2rqj8Sg7uYzvcEz
 Bf2MB1lEt0K6uacjUW3qjLYDeYruQeGIIWSVfDmSF+M0bol5tmHXH4E63xPIGLdsaQgO
 SKpN5Ltzl4f7PRlPwlKsU6HIoSiNB4DJiLc0p++6P0iNDvvv7DlA8XdNHuqPYZhRCE2u
 BPAAuiw/ofvw3IxoRUFPcejbMjh4hUxSxe5XsarzhbohGlOzM38Ff7PtcWbi++qgTsOA
 kYpw==
X-Gm-Message-State: AOJu0YwJ1WxhhUCVZ4+s/Kd7g0InWJ/DcfcJPR0axDPwRvnqdxt2VzlW
 QIE/+pLrDSGL0OKG1JJACrX8YUVLxHlYYP7GjJBnqbAsYPsHbTtVy00ntvGr073orWuRJ62ldjc
 =
X-Gm-Gg: ASbGnctz05w61UPx6ADL0xd91koUSEoVK7c7g2+FD/dZTWxb89BJSDQ/jg81acn9St6
 Rz70cETYpGs9i4xlm42/wh1EG0beGYqYpF7N4+pmCiVNNkcz0qtPItqeoB+iEPdoqVVcF5pOITm
 lExns/OOHPWFCzfyiCPeQjgtCFl9Tm43OxdqmJBHZQfpgktT6HNm535Uwh6h4yMMYE5oPcWwrX6
 HJu5gsx8EboFG8dWdw/FVqWim0dzEnM8kKTUsBCZPbnvA==
X-Google-Smtp-Source: AGHT+IEa1IfAB7mNPnPUABBRHAN8+GfeFOOdBAV9zxYeo2w/88tsQCCG0p+hYfwmrXVvkOBGANekvg==
X-Received: by 2002:a05:6808:1a02:b0:3ea:43b8:29f2 with SMTP id
 5614622812f47-3ea6dbebf9emr7485491b6e.17.1732808932773; 
 Thu, 28 Nov 2024 07:48:52 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 24/28] efi_loader: Correct address-usage in copy_fdt()
Date: Thu, 28 Nov 2024 08:47:23 -0700
Message-Id: <20241128154727.771871-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

Update this function to work correctly with sandbox

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index fd89ef6036f..72902a5ade3 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -486,12 +486,11 @@ static efi_status_t copy_fdt(void **fdtp)
 		log_err("Failed to reserve space for FDT\n");
 		goto done;
 	}
-	/* TODO(sjg): This does not work on sandbox */
-	new_fdt = (void *)(uintptr_t)new_fdt_addr;
+	new_fdt = map_sysmem(new_fdt_addr, fdt_size);
 	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
 	fdt_set_totalsize(new_fdt, fdt_size);
 
-	*fdtp = (void *)(uintptr_t)new_fdt_addr;
+	*fdtp = new_fdt;
 done:
 	return ret;
 }
-- 
2.34.1


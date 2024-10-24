Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716C4D2CE17
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 11:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B198A88D29;
	Thu, 24 Oct 2024 13:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sDf0BeEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3C8888DDD; Thu, 24 Oct 2024 13:02:10 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE6F188C7B
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 13:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso103132466b.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 04:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729767723; x=1730372523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sNzap3v6utQCWiqRgZAXhaFtMkAn8PTb1BCz0semqcU=;
 b=sDf0BeEzSfBk+UJaR0J8ULoaVYbxUDQ7Rz8Os02dzU9VJWnXYkUOunIPm3ndf/q2cZ
 Pj+WOmzjcXnvAD2fPl2mWBBW+0/EEASGxPVFKtlitqW11plFZVbs/VZHe3h7RexGPVgW
 WDUcVesrP11uUMmL+EzYBUWfZpJ9sTSkwZDXvmJImDMoSMDHie0irxi2YzfZeEJO1bKe
 vyqNrp2F+GjwD8V83Tm5xUZ2kc3qVZWRQLhtpRlFtWrnl6X6Muva7xSaOSIyhE+484Sa
 Q5U8Y3A825dY5cPVKOs7ViDOB4p46lLJHzTDvrvDH3/U16Ks582LmIOXjVGxLZ1yU6mk
 qrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729767723; x=1730372523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNzap3v6utQCWiqRgZAXhaFtMkAn8PTb1BCz0semqcU=;
 b=v6pT8GoueupeQ0cfrks6l+Y/Cwv7gdJ3UxuucgZ07z70SpYI3pQPvXWq8Q7xIzJeRg
 CJe4FP1GlHEqoUvftOKZ/b/IjWxOpJSN0cjE7Hk7uxm5lV5xpnsgmXYhtr/V338jcNqV
 sSN23fDUhlPGxurUUEEkqlJQLx2U25Lmi23KKYl5m+UKOBgCtWo9T63fqRM0KUVHAFQS
 0mMGHIDUcFQWb+HbjpgSNthTYe4Bjo4mn4SRsn80Utk6qsg3+wZyWsLfNC0FDabvKT5p
 gDEe402XA/x13UK1UKzCfaSEv4njcVlIfBQLaa22mwqYifCy1ByHwYRtfSLJuuxMEsBA
 gzSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwJQxpgbeZZuvjIGoW4kli5wOcYU6t21Wr1pRgAOHqAsuuv1TQL5HTuwWFZFvSKRhjFU3Rqo=@lists.denx.de
X-Gm-Message-State: AOJu0YxlizVc0eI00oCWZVFdUF/utdWvCRkQL7oBbL9mL4f8A3M2R7pY
 ZUdjcJngzbFntj+gXwAVYC0AGg2HJDOQq6DKqCgHPCi/B9cD16W/PuAXpbfET9obUX03/GvBTDn
 8
X-Google-Smtp-Source: AGHT+IGOow8FOuPRv7Rgx1cR+ZQrAMEC6ev2P8F9n6TTRHD8sRR5MGzz0wW7EhXiGCfdbyCk2G8Vew==
X-Received: by 2002:a17:907:2d94:b0:a9a:26dd:16bc with SMTP id
 a640c23a62f3a-a9ad2710a2dmr160559266b.5.1729767722857; 
 Thu, 24 Oct 2024 04:02:02 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91572c37sm610495866b.172.2024.10.24.04.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 04:02:00 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Simplify efi_free_pages()
Date: Thu, 24 Oct 2024 14:01:55 +0300
Message-ID: <20241024110156.1353756-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We currently call efi_free_pages() with a notify flag and explicitly
update the efi memory map. That's not needed as lmb_free_flags() will do
that for us if the LMB_NONOTIFY flag is removed

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_memory.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 84be5532a655..e493934c7131 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -524,7 +524,6 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 {
 	u64 len;
-	uint flags;
 	long status;
 	efi_status_t ret;
 
@@ -539,18 +538,17 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 		return EFI_INVALID_PARAMETER;
 	}
 
-	flags = LMB_NOOVERWRITE | LMB_NONOTIFY;
 	len = (u64)pages << EFI_PAGE_SHIFT;
+	/*
+	 * The 'memory' variable for sandbox holds a pointer which has already
+	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
+	 * it back to an address LMB understands
+	 */
 	status = lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), len,
-				flags);
+				LMB_NOOVERWRITE);
 	if (status)
 		return EFI_NOT_FOUND;
 
-	ret = efi_add_memory_map_pg(memory, pages, EFI_CONVENTIONAL_MEMORY,
-				    false);
-	if (ret != EFI_SUCCESS)
-		return EFI_NOT_FOUND;
-
 	unmap_sysmem((void *)(uintptr_t)memory);
 
 	return ret;
-- 
2.45.2


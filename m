Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4736D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C0D89613;
	Sun,  1 Dec 2024 16:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gxr0ceJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD2089610; Sun,  1 Dec 2024 16:25:52 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2685A893C2
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841aa93433aso109740739f.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066747; x=1733671547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G8jc5CRegbUmx/vnisYl4VtZDIY1pXlrRot/VyiKtAs=;
 b=gxr0ceJ2gHTWsa5B+YHS/YIe48m4ZSoNZh6zdN4ofbEVAcSCTimmuw1H+fXeiwrZ68
 wKM0LtuWYxPG3FPNBmqSujaW4xt2d/75GwAuQpo4FTxvidJvytH7oL2nueoNI76x77Kc
 7xsIlOZpUiKMgBM8jMbgBxeEsUmFg9Mt/H7hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066747; x=1733671547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G8jc5CRegbUmx/vnisYl4VtZDIY1pXlrRot/VyiKtAs=;
 b=Xv856tkCbz7/qVQUT8IUCHJTq395bM43Qm8y0bEahMsuzAgvDdcQlHPuQYOxWSSFDg
 PCpWBShg8akhqIgUHKN4IAYDNw7sDnkX7rFu/aXXGkHkRiup6nYboAbEpR9awWceg6S7
 U9qDuWuF1Xvxc6UwsP885kNK7+xrd/BREZ1/ZrZWEHc6TyWdk7jjvrcsyfYzdoKxAKCf
 uBDsXD52S2QDfue7M8Cea9JSPs4FNaZErPd+9np1cuvl2Qadm6dzIOFuvcOgvMTCoMyk
 Ay8fxqx1byvvia4zs7A11VXAXZs6wCsGD4RKOf/ZBU+4C6qtgpBO+84k+h9eqagJrl25
 FI/g==
X-Gm-Message-State: AOJu0Yyo3UEGNHttgNBgs2v/gmj1gAbMtqwVeg0HwbhnDBA4teBFzBxh
 7BpuFTd7B6VJZkJ9ieDzXo/mujaFXTgnlRoIEftynPc+ewdpDLxrl8zT/wNckrvmmmJAaAFOd74
 =
X-Gm-Gg: ASbGncvbmZdX0Bi21HIFPsaS9SLbsI0tCWyCCDXYKggaZab6T0/PZlDgiK9wxdZn3Uo
 UcR3q2vaPWq1G8PNaz5pLNVVmFG/n+y2LbkkNLMDxywYpPSaVf6X/fSc4YPrNpi9kh91aZaergm
 4icpGM9VxJ7laiJyuByoRE7YG63N+SBwSSdJ0v88SEqw1f0I7DKJ6t06+YFIFTZ+YUqVzTrvXR2
 l+6h4j9y01ohjIf/lgyJ+4ekvzFqDtD7hHM2uCR7KSO
X-Google-Smtp-Source: AGHT+IFCND154UfA67YpeGGBwCoJKGqQ/Nys4ElI/sgCyAwNsgBHcjfJn+JhIRPF4o6/3nCaXZXhcA==
X-Received: by 2002:a05:6602:610c:b0:843:daae:e16d with SMTP id
 ca18e2360f4ac-843ecf9e2f4mr1823081239f.6.1733066747420; 
 Sun, 01 Dec 2024 07:25:47 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 12/25] efi_loader: Drop reserved from priv_mem_desc
Date: Sun,  1 Dec 2024 08:24:31 -0700
Message-ID: <20241201152505.1666789-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

This field is not used. Drop it and set the value to 0 when the
memory-map is requested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 518b8cff61d..81e40fc923d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -35,7 +35,6 @@ efi_uintn_t efi_memory_map_key;
  * internal format is converted to the external struct efi_mem_desc format.
  *
  * @type (enum efi_memory_type): EFI memory-type
- * @reserved: unused
  * @physical_start: Start address of region in physical memory
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
@@ -43,7 +42,6 @@ efi_uintn_t efi_memory_map_key;
  */
 struct priv_mem_desc {
 	u32 type;
-	u32 reserved;
 	efi_physical_addr_t physical_start;
 	u64 num_pages;
 	u64 attribute;
@@ -705,7 +703,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	memory_map = &memory_map[map_entries - 1];
 	list_for_each_entry(lmem, &efi_mem, link) {
 		memory_map->type = lmem->desc.type;
-		memory_map->reserved = lmem->desc.reserved;
+		memory_map->reserved = 0;
 		memory_map->physical_start = lmem->desc.physical_start;
 
 		/* virtual and physical are always the same */
-- 
2.43.0


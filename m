Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94BCD59D6C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1B789A9E;
	Mon, 25 Nov 2024 21:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VTlszsyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA0B89A9C; Mon, 25 Nov 2024 21:45:44 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 850DE89A7F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-84386a6669bso13949039f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567541; x=1733172341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvGGIlI7n2nX6b0pt6D9Yna77Ycx5O8OQ6dV8ZvBacM=;
 b=VTlszsytoCZl/mWEuic3RoFAqpKAGXzBsZ6xQdHJEAgqNvCeqgwovgODf2EYhiFR/E
 t310QRcsGXolrjaKe+rY549uPlSRCb1GgghHLLXHT4Q+r+gguynKsz6b2KDk+DreDR+V
 xg5vp0Id0eTlGpn+hPv5Rnu2jIARPF2Xxo8+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567541; x=1733172341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vvGGIlI7n2nX6b0pt6D9Yna77Ycx5O8OQ6dV8ZvBacM=;
 b=f45dK9Y3eOZY0Ssk3PR61qO1s+h9INLky/MtqD68UKKaMVdP3a6pF+XCcV7UInEMYl
 F+ubnn6vPJDW35Yg2S201Ip+RLh5BUQRcn2XwgJ9Jb/UbZPkC61xMpgaDWODy/QDEBO8
 DDxSa93xAMYDesK+qRluZsXWj/len/RsUNJOswXuuUYe8eUQgdRja+e2UipTwzMtidRW
 QA96UY/ETU8viJyWhBQ022nqu54aV1NpNDPIR4DS26HuOmhR+bNdLP24VgvPvUR3+88E
 +PVTQvCZ4yaPRtUTbJRiW8iFkuJecnhsQXJqddajUHYoI2o9sTp7GXOGpGibpifQXZS8
 Vc5g==
X-Gm-Message-State: AOJu0YwMCIpva49sSEXFmJrm/FkpqjZDXBF/zO7KKMnSEK+raqhKi/PL
 sS8vb+7aFibnKg2PEMrlXSgahN8cp+AkTNOemznauJ11hxq6W8Hgyn7fh30h4ER2WlcbuSHDhZ4
 =
X-Gm-Gg: ASbGnctGEzYfT3vVPE3m3ICJ7yA9DWGO7qh2lXooMMBZtRCgMLqjfI4Noa98Kf8Ht6g
 oReJ32GtQ6lZyWZME/HOyanwoIP/c0VbZvb6xJLGolTirXfqaNFaxZABZK+zGaJ4QLlL+tZdP5A
 LNBQPx/lAsiD+HS4PjKiHjsIaSIERFsfvrzzbl66QLR/d84ibU2/1YVKjvchLNm8b+Qj5qU5uav
 7KYoCoHPm8A0wbrbT4KgwvQBj7FliS3sXZBkbzvJl1ImDA=
X-Google-Smtp-Source: AGHT+IG6ZE0Kkx9GSuatJWSfkSL8NistjfZ8aSHCSRkloMzegTen4agvBl3a6z78nrIc7aOLtf7ucw==
X-Received: by 2002:a05:6602:14d3:b0:835:4402:e2eb with SMTP id
 ca18e2360f4ac-83ecdc60ebemr1331415439f.7.1732567540792; 
 Mon, 25 Nov 2024 12:45:40 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/13] efi_loader: Tidy up efi_reserve_memory()
Date: Mon, 25 Nov 2024 13:44:50 -0700
Message-ID: <20241125204456.1525752-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

Adjust this function to use addresses rather than pointers, so that it
doesn't have to use mapmem.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_dt_fixup.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 0dac94b0c6c..ddb0d1f8fce 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -9,7 +9,6 @@
 #include <efi_loader.h>
 #include <efi_rng.h>
 #include <fdtdec.h>
-#include <mapmem.h>
 
 const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
 
@@ -21,14 +20,11 @@ const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
  * @nomap:	indicates that the memory range shall not be accessed by the
  *		UEFI payload
  */
-static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
+static void efi_reserve_memory(ulong addr, ulong size, bool nomap)
 {
 	int type;
 	efi_uintn_t ret;
 
-	/* Convert from sandbox address space. */
-	addr = (uintptr_t)map_sysmem(addr, 0);
-
 	if (nomap)
 		type = EFI_RESERVED_MEMORY_TYPE;
 	else
@@ -36,7 +32,7 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 
 	ret = efi_add_memory_map(addr, size, type);
 	if (ret != EFI_SUCCESS)
-		log_err("Reserved memory mapping failed addr %llx size %llx\n",
+		log_err("Reserved memory mapping failed addr %lx size %lx\n",
 			addr, size);
 }
 
-- 
2.43.0


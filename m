Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BD9C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15A2E881C3;
	Thu, 25 Jul 2024 15:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l3TGxiA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13A8880A7; Thu, 25 Jul 2024 15:58:49 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A32987F19
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-819c1f5348aso9313139f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721915925; x=1722520725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c96ChawjIolVPrcccPepHwumUNCTPU6bJLiWbLDj9Oc=;
 b=l3TGxiA7lfBfV2lWLclFWas8LLcghZYKgFapKDRHITqTf1CH31xtfmqk1Vy7MRkRaX
 6iXmS7wO6hjsfwuHtyXyMSBK2aNV9dQ8mtBCoMb0GvFHQ56Op6tePSQbAyIl0NbSPpHn
 B3xzkNh5U8I0jJ5inoIBowlx3bv99DAqFkbBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915926; x=1722520726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c96ChawjIolVPrcccPepHwumUNCTPU6bJLiWbLDj9Oc=;
 b=tn44e3y83wWML1Ax/TgpDrZBtWpSMeww9mUzix0iRxfu0g5VoLXM4Ui8FaClsLqnxD
 MFOuCD5GAZKtZ3v+XEH8wEq/jINAhsxP3DFpu8fIBQb/0AMTXKRuBUNyXuJ3d40BZ6yd
 iKIWmZ2uVuttA14Cwg4uRf93Wq/GjzcfWcsQx6zPU1SBrGgHv9WhbM5WQrqTZyl/qegc
 ZbroUFkO5x4DYK825OjKcWzrf9xBXGTH6QYG43vU9ST+mPzY7FUBPGMJzEmuwkBDNw/1
 us9kZaO7+EWIb0pZ6+vj6uhmqa/yzZY6dEl2sTyIsL6HKmeyDJ4/5aPwmpuaw7R9d9RU
 a/+w==
X-Gm-Message-State: AOJu0YzYHrrQuXgHlVz/fcJztStg3qf/W+8G3WnSe8V5EyypQo0rTl2I
 Dg61QncmqrqF+YKHrD0ZiXsCwO0GMD5QZcnh+ga8WZ05QK5y7rwGe752Ndw+rMhe57XxBHTiTy0
 =
X-Google-Smtp-Source: AGHT+IHTuF2h6spkELLQ4bPTvcoPbUOkgav74kQgId9JglR6VWZt4OnPYXohQcCm7QlsAZdsLL3PCA==
X-Received: by 2002:a92:c24a:0:b0:382:325c:f7be with SMTP id
 e9e14a558f8ab-39a217e6744mr38384945ab.4.1721915925710; 
 Thu, 25 Jul 2024 06:58:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a23105f6bsm6015445ab.76.2024.07.25.06.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 06:58:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/6] efi: Avoid pool allocation in efi_get_memory_map_alloc()
Date: Thu, 25 Jul 2024 07:56:27 -0600
Message-Id: <20240725135629.3505072-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725135629.3505072-1-sjg@chromium.org>
References: <20240725135629.3505072-1-sjg@chromium.org>
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

This function returns the memory map, allocating memory for it. But it
can just use malloc() directly, rather than calling the pool allocator.
Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 087f4c88cdf..2945f5648c7 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -850,14 +850,13 @@ efi_status_t efi_get_memory_map_alloc(efi_uintn_t *map_size,
 	ret = efi_get_memory_map(map_size, *memory_map, NULL, NULL, NULL);
 	if (ret == EFI_BUFFER_TOO_SMALL) {
 		*map_size += sizeof(struct efi_mem_desc); /* for the map */
-		ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, *map_size,
-					(void **)memory_map);
-		if (ret != EFI_SUCCESS)
-			return ret;
+		*memory_map = malloc(*map_size);
+		if (!*memory_map)
+			return EFI_OUT_OF_RESOURCES;
 		ret = efi_get_memory_map(map_size, *memory_map,
 					 NULL, NULL, NULL);
 		if (ret != EFI_SUCCESS) {
-			efi_free_pool(*memory_map);
+			free(*memory_map);
 			*memory_map = NULL;
 		}
 	}
-- 
2.34.1


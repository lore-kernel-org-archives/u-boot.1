Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED13C52D7F
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 07:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525DB8899D;
	Wed, 14 Aug 2024 09:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="h9TzDIED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70971889B4; Wed, 14 Aug 2024 09:14:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9070687B1A
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 09:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D4403F670
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723619666;
 bh=gIls3TPo87UUYYCwEUT86shm7A/3KlKL87Xmm/tJrks=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=h9TzDIEDzI/8a5XyWo2+EvX6gJxnHXto2EUiLfXdjeuJeaeg/5kYQSS82Bgqv0Sz+
 CUupU338kAyPKsOxN0z+n8hOLp3eYEvaTW6ruFj9rAP0iw+FpsBpDzVL4owy6+IODu
 9PBlYcK7sOYEeyXDOk0zbEL5qUWAP/OlwxUxMLAz6cV8h68rqsE/umg5xg9gj+Q2/V
 /JEBUFqvMNdls8flMy9bUnxFRxf31dstCXuzhmv8s/kEnexFWoa9IFUPHO3mftvpC2
 YL8S69SSdZ8/Et/cYl0OKmIBtXh4EAdRW1zuRSWxnI0atEzxVVgzJsxEuJG27j3Ahs
 cDcHhrQJoDwwg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36832c7023bso3146492f8f.2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 00:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723619666; x=1724224466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIls3TPo87UUYYCwEUT86shm7A/3KlKL87Xmm/tJrks=;
 b=HjsBeE4o9+xzR3w6X3OZHvQCbGbZ6WHlvEDM1EuH7J20egBZllEd6QmsFpZoQiiKMG
 +72FWQfH0nvIFVEn2iq/DmhpqNuMCd+/47D+LL//BMUAb83aAegSB1A9TZjEhxw21xOo
 4340t/NKk5W6e3AkrXY0hQOsDekBHGGENZFqN6BfkkhxhDSXPuueJgtQrZVKjr998Uqo
 vqnpbzTsZoEGtbh896n0GgqPRVbLEdyDUETXwUlg+mrhSkqzIOi5riw79qZk2awJlAU5
 2Lpea1Mv8kYTgJ06xBd9BtGu7acequSPPlbfmLknb4TDBxImHCJEXGnn6WmKdNFJNQXe
 FOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8HjchHwHKt+SizuPRw64rEhBYHvJys6kBA0qLOWCFE/lcXLFTR4bsHX85TC+3h6+67846XQBftwzO6469Kl3hYROUTg==
X-Gm-Message-State: AOJu0YxN+069v8K6DHbe67lTyH6AI0LBRZ4RpzyWbepKgULuQdInDS1W
 X7F6huZ3P2twV1kLntiPmfU+hcYBYPcKhV8VpXfAZxeRCIyAqKJa18y6kO1mmgaVKYCD0lT++6V
 k/4huRRT+UTzJBj0ocsIc9t79RSOKtMXIhXEYz7L96gDjNsMc+K6R/gdLT4N33o7FYg0=
X-Received: by 2002:a5d:5710:0:b0:368:48b2:95ec with SMTP id
 ffacd0b85a97d-3717775cdadmr1299031f8f.1.1723619665794; 
 Wed, 14 Aug 2024 00:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeXfeqRKAu7CcD8d9DUkQ6TSVCoKmpRPzAwL/GhvjcLi55xp0iGS3yCTpyu3yJ0NUcmwjOgA==
X-Received: by 2002:a5d:5710:0:b0:368:48b2:95ec with SMTP id
 ffacd0b85a97d-3717775cdadmr1299010f8f.1.1723619665310; 
 Wed, 14 Aug 2024 00:14:25 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfeef76sm11983757f8f.59.2024.08.14.00.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 00:14:24 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tools/mkeficapsule: correct printf codes
Date: Wed, 14 Aug 2024 09:14:22 +0200
Message-ID: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

uint64_t is defined as unsigned long long on 32bit ARM.
Convert uint64_t values to unsigned long long and use %llX for printing.

    tools/mkeficapsule.c: In function ‘dump_capsule_auth_header’:
    tools/mkeficapsule.c:694:66: warning: format ‘%lX’ expects argument of
    type ‘long unsigned int’, but argument 2 has type ‘uint64_t’
    {aka ‘long long unsigned int’} [-Wformat=]
    694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
        |                                                      ~~~~^
        |                                                          |
        |                                                          long unsigned int
        |                                                      %08llX

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 tools/mkeficapsule.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index f28008a0829..d346c217f09 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -691,8 +691,8 @@ static uint32_t dump_fmp_payload_header(
 static void dump_capsule_auth_header(
 	struct efi_firmware_image_authentication *capsule_auth_hdr)
 {
-	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
-	       capsule_auth_hdr->monotonic_count);
+	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX\n",
+	       (unsigned long long)capsule_auth_hdr->monotonic_count);
 	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
 	       capsule_auth_hdr->auth_info.hdr.dwLength);
 	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %08X\n",
@@ -724,10 +724,10 @@ static void dump_fmp_capsule_image_header(
 	       image_hdr->update_image_size);
 	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
 	       image_hdr->update_vendor_code_size);
-	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
-	       image_hdr->update_hardware_instance);
-	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
-	       image_hdr->image_capsule_support);
+	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08llX\n",
+	       (unsigned long long)image_hdr->update_hardware_instance);
+	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08llX\n",
+	       (unsigned long long)image_hdr->image_capsule_support);
 
 	printf("--------\n");
 	if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICATION) {
-- 
2.45.2


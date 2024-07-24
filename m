Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91EAC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 13:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E77F28881C;
	Wed, 24 Jul 2024 15:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vLqTakCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AD8A8889B; Wed, 24 Jul 2024 15:26:27 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CF488805
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 15:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F3BE400E6
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1721827584;
 bh=fvyqCn5hwMVnTUx7BXc1+1BmBKBZ3RuBR48EEVJ4aXA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vLqTakCfF/CLEEFI2nyEkcGCtx6OtzaJHGx/UI5O4AqYMNndDANOxZfVZxJQHAo8l
 7tc0EGz++dPrVV6+pjLVCg4yvJLnF5U98AGTmjIrh+LOW7Og8E05fAQ3dhb9mVE563
 r9frhlfipRM2MQNXSql7B0RiG7Zun4Ru6hwX5LY1rCrntKUDDfe43jmh/f2JGcthvT
 o8CTKC672Aryi7P6kYujN2KddVkztCvAEr61MLk+9eiPEtuumtWpJoP2OnBFArtO9N
 bVgAHXqS1R8C2sglkcGpLLCwn/j0XgHdsWaAjX02bagQ/ZgLdy1j501NUCJ4fSuRdK
 Zi8WIhErpXJ6A==
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52fcf2b5287so1013096e87.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 06:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721827583; x=1722432383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fvyqCn5hwMVnTUx7BXc1+1BmBKBZ3RuBR48EEVJ4aXA=;
 b=CofwzoqP0t1CJ1speVa45yxnVkWWB2DSyaLR2vztTfYljVpQzVdp+Zp0wHlSbr7hLh
 5bMBG7X7iczkgG+0Px5CPU4+S/UljkMkesqw+PMpEHiQ4VIUbGVXpoUfhbzPq495vP8Y
 4Z7z2YSJcIUEO0yugkUTDTrMsvXZP+Iu2A/V8zeeMybOnnengHKEkK0kOd4AyxgA+GBK
 V0DVeF3tBv/p0pKq1L1pSo8jbH7r5k6FcU+CIniGtkrT/L8QAgGQpKjTbd8r6sCXKpDD
 yt14H99LBXPXkNg1Lz0zI6KTUVlAJQcARTFvaUYcd+MNZkghWEuBA6L7BMf7vdHYZYm1
 TrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx7dmJOVckPrKvI7oHLi58ZhlIO0yQ/lMGFPUX9TS/7w2iyv9D4BtixsVZBdQkSub53OrYIHKNwdYNmG0zxsVHi65WKQ==
X-Gm-Message-State: AOJu0YwCFPKB9hnaFZgiBEshJpGSRKBVYTWHjbiHpaz0VNFiS1YIByFf
 rcCYI8GjVGfsB7p7k4mnM7TECgx99v2gLq/SK2WYJlsf2yx6Mx1o1tkPfqy9vQtcOYyrdA1bMyr
 5DpE/RfoGWGKPm1jWrtUCuiOVRGrzKmpC9Ru/wQGzKy6eGn4npufkCoe2wLa6ZK/00QA=
X-Received: by 2002:a05:6512:3056:b0:52f:cc06:c483 with SMTP id
 2adb3069b0e04-52fceff2814mr1645709e87.24.1721827582784; 
 Wed, 24 Jul 2024 06:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Z3w4LGwnvsjA3Wh0Q34A88/p0SVRs+dcfwV2+CrWOV7jiGVFwxwZjAclxumA9zbacg0TPQ==
X-Received: by 2002:a05:6512:3056:b0:52f:cc06:c483 with SMTP id
 2adb3069b0e04-52fceff2814mr1645686e87.24.1721827582350; 
 Wed, 24 Jul 2024 06:26:22 -0700 (PDT)
Received: from workstation5.fritz.box ([2a00:20:3:e380:1d25:e955:fa20:743e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7ab5528925sm53170566b.108.2024.07.24.06.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 06:26:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: correct check in efi_load_option_dp_join()
Date: Wed, 24 Jul 2024 15:26:04 +0200
Message-ID: <20240724132604.168177-1-heinrich.schuchardt@canonical.com>
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

After assigning to *dp we must check this value and not dp.

Addresses-Coverity-ID: 501792 Control flow issues (DEADCODE)
Fixes: 58bef195f94e ("cmd: eficonfig: add support for setting fdt")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 348612c3dad..65d2116381a 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -133,7 +133,7 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
 
 		*dp = efi_dp_concat(tmp_dp, fdt_dp, *dp_size);
 		efi_free_pool(tmp_dp);
-		if (!dp)
+		if (!*dp)
 			return EFI_OUT_OF_RESOURCES;
 		*dp_size += efi_dp_size(fdt_dp) + sizeof(END);
 	}
-- 
2.45.2


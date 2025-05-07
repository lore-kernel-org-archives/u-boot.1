Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2921BC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 14:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8673D8216C;
	Wed,  7 May 2025 16:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="geQsrCX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38208216C; Wed,  7 May 2025 16:45:39 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F9B8211F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 16:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so6233916b3a.3
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746629136; x=1747233936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11IOi4eq5wt5FSh61jq7eXDbbtZ+5As8FyBzlo8NPrc=;
 b=geQsrCX/C4VdldAlkhrJonNi7Es/Jgw1LT79i++gFdvlA+U8YhbGkroujYCr2dKEpA
 PYGgsOVd7tPENgdoVGhZjHno1qUJD66dk9LTG8mOpTx6zozTWAf9HpS+dDG7RBuQuHXR
 nPgQBfRPz89kEBI/PGrM2sISXLUQ2td3cOdMMdQ/4+VzPvQdFbxJpp0wKKv/5LhLeScd
 wERwvNOYwBTQGnbEVjDgyiYTPaGL5LeNtbnIl2itstljXudb+1xMBkRn0HxFcSFe14HM
 GxwwsntceG/bImF7kBcwVrFYculrC2sWyPm7knL3Ds2gPHPgnl8C3aCdZu5PV0i9A94S
 2vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746629136; x=1747233936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11IOi4eq5wt5FSh61jq7eXDbbtZ+5As8FyBzlo8NPrc=;
 b=Rti0KoUiFJ4Fjag3xA6sbL1lHYPea9gQIZetT1HdXt+Pigo2LXkW73MpEkxY6oXep5
 SdDASTuyunFJrMrCRKOCGIPIuqK4MAP24D4TmcVMIj7WnKPajSrCAXV9176+IjxnUmZw
 3P1zoQcm37fPWVZRup08X8yjXPCA9Blt4a6ebw2AVTPGvTYykjL8lohThEWyltjwSLaY
 No6UPHMO9yaXFhZ/SvKa6oZiL26u7ihQIG1wTOJVyao9MKoEWGS5oWmkBM7xd4L66Xsu
 tx/48B3QHIz+h8xu+wcRbul76HGH3acGH8Agb1LqZ3Cul/0OSUTEgpwZXuPPqFQ5ph/1
 mvkg==
X-Gm-Message-State: AOJu0YxVb3lGoOE0eXHS0G/9WnMiDy3yshov7Ihq3lWKIyC4Wckt1A/M
 lA8jNvM/Lgw8iHBIBS30+w7jb/L+ttIUWQKEZ04LP9jUM2snjhaEvhqbwi3UtCQ=
X-Gm-Gg: ASbGnctSf/V/LP/atEy5XoPMyN7f4lvu0darlpqSECMRmshwxX1B3BM78mbgXrNc4SX
 +FMMUdb4dO/pz8GItc9EOiZMd3SEu/uOeXUO/y0Q+cls/xTArU58MWjS+WZfTDTOx3Fbe0QzpxY
 jeYIZwAJhTA2EDYz7O3vQAIky0hmShkW0iifulI8cwiN2lA9ejjlYD08Ol6TTbXF58e26YGOpOI
 8u+/Q1l+6NhWuqbyI3t0Ev6wdes0n/fXej6g5dNLnw03EVgo+rueszunPtf8TNwjTZLHttkdBTX
 By4PdTM0C3a5wOFPz/OwbyxpemZOdUthWDkCQjSXxn7jdhTAZA==
X-Google-Smtp-Source: AGHT+IGGnPEZ82Ff9rKuZsF+lywmIOxp2yttxuTgFVlWgJg7vEfxztlC1V9tC6EEqtFcv6ya9ITGaw==
X-Received: by 2002:a05:6a00:4404:b0:740:6615:33c7 with SMTP id
 d2e1a72fcca58-7409d00fdecmr5589831b3a.23.1746629136175; 
 Wed, 07 May 2025 07:45:36 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a30esm11710235b3a.13.2025.05.07.07.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 07:45:35 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/3] efi_loader: initrddump: use efi_uintn_t in printx
Date: Wed,  7 May 2025 10:46:17 -0400
Message-ID: <20250507144619.3288456-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250507144619.3288456-1-adriano.cordova@canonical.com>
References: <20250507144619.3288456-1-adriano.cordova@canonical.com>
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

Use efi_uintn_t so that it also works in 32-bits.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/initrddump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 615119043d1..8d08f7c5cd5 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -99,7 +99,7 @@ static void error(u16 *string)
  * @val:	value to print;
  * @prec:	minimum number of digits to print
  */
-static void printx(u64 val, u32 prec)
+static void printx(efi_uintn_t val, u32 prec)
 {
 	int i;
 	u16 c;
@@ -342,7 +342,7 @@ static efi_status_t do_load(void)
 		return EFI_LOAD_ERROR;
 	}
 	print(u"crc32: 0x");
-	printx(crc32, 8);
+	printx((efi_uintn_t)crc32, 8);
 	print(u"\r\n");
 
 	return EFI_SUCCESS;
-- 
2.48.1


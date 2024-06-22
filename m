Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6D2C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDE2C87A09;
	Sat, 22 Jun 2024 16:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g7BDbyKh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11F378818B; Sat, 22 Jun 2024 16:36:44 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1582A881BC
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso435829766b.1
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719067001; x=1719671801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpPJN/CRk5cREWKnqLbDTJX3oPpy42QB8VF7teH+aQU=;
 b=g7BDbyKh4rg63NeRWmzoXR/zoRxbUxW33H8V7vW8S9Yg32umywQAPSBryOCWJFmcQR
 yyT2X9aImvN0KtBa1rkOPquSi586vdW0ShNyI+zG7I+A3senkBLIjhfiJhkwciUNzkqE
 rIa2sEVf71rHK3ZQ0kATpP0ROeg8Gpb8qwIxyMMnRYUlA3M4LuQjh9WdSmiowWpaflaa
 /AtWzTCNbRaMSPY30qTFESBR9jxWuDzESXk3eOm+JPA9JHaGhTylDlvBOafgo+z5LNFQ
 onh5evyOD7gtHX8dxNnpM2Y4kRA5/t9HENkVbk0DTxpHgEZke1maU/TeOQnE5JE10Srj
 LHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719067001; x=1719671801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpPJN/CRk5cREWKnqLbDTJX3oPpy42QB8VF7teH+aQU=;
 b=mT/2z3eYIvmUCeimXmXpHxeFQPQq+GfkiBC2AArdb1I2NhhYPL9wDSGKYeBje+5mAD
 i/CNsuMutOoQQodSDSwBp8saRMBvq4GfPPEQvxD60v08Zu1PwnD8weVuanz1xVUzQYU6
 KegujngNJc4mZylrxAB9uzRNx9YOW4mTDH1GDSBEPkstvSRYN5VIfxcOI04TcFmvWNjn
 tEOaSHAKEsYkiAl7Anyi5RPSFKdqmJKafgKmtKZgjtlw692m6DyzHq9ZgdGwEJb6HquG
 OFPI64A3g8edCSz3HJVMGUmmlMlpVS6Ketj14tETvZeYJWrJFOQjSput0P1qW7TQ7hcK
 vrdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXav7mgtNCzuGDT0XrSIIdALegiZGWWS+lT0wNcnKyf0S/3Q9otHoH+l4YRHphi30eSR3nzSLQmYrEiSKIRvOzS/qVXPQ==
X-Gm-Message-State: AOJu0Yx2O7momSu+H/KYxXGlv8PS1zl+hZaykSF1kiqV9KHoaFMamRj/
 kBhrMjPm3BgTwwb9XtGH28nKoj68nqKu1Mmgdq0Z1Wz/UzdUIsr7r+oizDq8E9E=
X-Google-Smtp-Source: AGHT+IGeRs64w5uADirwixoujZO0LK6dOcaJp3zGJw8Ofvpz96lv9j/MgkQWP8nDLa+82MeqyvTrkQ==
X-Received: by 2002:a17:907:a785:b0:a6f:6ed6:1961 with SMTP id
 a640c23a62f3a-a7245b45a4emr1914066b.8.1719067001400; 
 Sat, 22 Jun 2024 07:36:41 -0700 (PDT)
Received: from localhost.localdomain (ppp046103020130.access.hol.gr.
 [46.103.20.130]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf54a534sm204005366b.136.2024.06.22.07.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 07:36:40 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: sjg@chromium.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
Subject: [PATCH 5/7] efi_loader: remove unneeded header files
Date: Sat, 22 Jun 2024 17:35:41 +0300
Message-ID: <20240622143601.187723-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
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

efi_tcg2.h already includes tpm-v2.h. Remove it

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index 10c09caac35a..c654d2cbd704 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -16,7 +16,6 @@
 #include <malloc.h>
 #include <smbios.h>
 #include <version_string.h>
-#include <tpm-v2.h>
 #include <tpm_api.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/sha1.h>
-- 
2.45.2


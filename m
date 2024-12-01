Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A73D4977B
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FCF8894C6;
	Sun,  1 Dec 2024 16:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jNId5sTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03B4894C6; Sun,  1 Dec 2024 16:26:19 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862588914D
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-841acc8151aso121998839f.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066773; x=1733671573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cr3TbyOKsaJHJwF4eb0+e2EVFJfcg0y4Ei6vq3EwSpE=;
 b=jNId5sTFvPn5Hk4KMacRISo4bw73+dX8rg3cAlouMO1fwi9LpGk4Yban0dVWZ+r+zO
 jG3O2XidDkjck0Rps2yaxVHNBe06ukZnGSBoZa6VoocBPm/fXFYCvHeg1RyDJMKcPEqA
 qmH88rNvU22NS7wxJZOGQHygugfaCEBTwgmsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066773; x=1733671573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cr3TbyOKsaJHJwF4eb0+e2EVFJfcg0y4Ei6vq3EwSpE=;
 b=jcU9A5DMaMvDOYvCGvUluLd0NDGEUUXLdxuUz1dWdaNYQ0IoOcbaJxPgnA0/6SUmaP
 lzqEQ2LjswNJX3j5qzzmcfh5UXAAUsa7VeeZGpKzzLN1ETlXTzTXhYH9UFPRND8KRawv
 9+yhs2xb1rs8fKUpo8fG0M99UwFQ5l2iTOHJz35egedjfNkCaFI2XQCoSEmLKU+h3j8a
 nxG6U6L5cmo2fq0FsI14YWn0NFd+2C2sRqDI57WyENp/4NwJTOoM6OugOMkRj6Y/M/Fn
 QObemj9+mt6qkXaqLt5Y0sujMmIlH7L1XQzmoLqvvdnn4INe7J/OkzLLDQxPTEml+yzW
 q/oQ==
X-Gm-Message-State: AOJu0YzfPo1zPMJ29QcNiOnRI1hVAU7hrvWGInpBCeuL1oqvw9PsGdWM
 hgLqe03dt/xuIQj9oIbFs3o6/UNbJdd8mqgOkfUGF1jVFK+m0MQIs39HOQFqYQX7Xx+LJaPa1tw
 =
X-Gm-Gg: ASbGnctTYmmsX0WrhUHYMpMU6K38Usf8va0TYLHMfIDc2tJ8j+FJQwNOs4otMhgeNFb
 hDBDOrHLIF67AEWbScRCGwdQ9Ssnz0sgGIgjjYnAMvo3i1lKKbcFXltRHcICBEsrqP9o9+Kn1aq
 GbZUD4XN6wqSBvmRvMP/1BLhEFKydxdGqswYn88OHVvgCoRm5Caz/uc6vobc8YeCqiU8ZgYgBPZ
 hNPFkl6K2qqtWZHEqwodMtzB98I00rYEdQPrshZ0Mc+
X-Google-Smtp-Source: AGHT+IEb8KPDzD5iEHOyyNpog4Fs5ImgGzIUPc1S5Oibm9JfRTs57AkpFkFpYr4yeNMys+p9mPTIWg==
X-Received: by 2002:a05:6602:164a:b0:841:9b5c:cfb3 with SMTP id
 ca18e2360f4ac-843ecfc90b1mr1601739839f.10.1733066772860; 
 Sun, 01 Dec 2024 07:26:12 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:26:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 22/25] efi_loader: Correct address-usage in copy_fdt()
Date: Sun,  1 Dec 2024 08:24:41 -0700
Message-ID: <20241201152505.1666789-23-sjg@chromium.org>
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
2.43.0


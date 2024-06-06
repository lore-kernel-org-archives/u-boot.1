Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F277C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5366C88444;
	Thu,  6 Jun 2024 14:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fhg8/tr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F7C2883E3; Thu,  6 Jun 2024 14:24:19 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F575883F4
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42133f8432aso5749715e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717676657; x=1718281457;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=akH7wafWap/WqtkDpFosaPadShJvWPq9cHlDuqv/8mE=;
 b=fhg8/tr6AC1qpjkkJ0ROi9IelDpOnRnEtikGs6yijTbzYZ95BjnMZvVfxJaOysI6fS
 I54yOaqWXzLaSgaBiBqwYNs83eV5ZCcHDlebuULEJk/6als2eCr2WoBmdTY6qWKU7Xru
 7Tqm+NGqBqWnixUq4d/7n+8hW6WVwhN8TU4boq5iDNo4AKxxEjfhij9kx0I3L4Je2QbS
 K2E63BSuFNat47h08qtad1Nd4H4e9J0eaicbrCQnhSqKX+4Z8TcJZJTTEs6iSlQOQ2+C
 Ia+BQWYyQXSO9mFKfqedO5uLQKptl3br5x5/DjHQ13AzFA+KZUaGP120N2LWgZl1PlVv
 zUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676657; x=1718281457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akH7wafWap/WqtkDpFosaPadShJvWPq9cHlDuqv/8mE=;
 b=fakj57Ef+jMvZ2/er5F+VugKkGsT1aDltBovpfCGPRVCYhHWMWct0mR6LTsawkruC0
 HsZvVdXwdMl8pX/iyhiZ9rH2+VJs0nHfl0PUFMg1aslwII6J8bD6Cs0fIAHdlag8X8me
 OfvvnhVPCvBTXnd+uPmU2OArifDZ4Jjrne1RB0p4nS/lTUn/93QywGcZtQzPSfe8NzvG
 dVISTRIVxLqowCpqHXXlhRLfQZsaaMlCpUnwrn1l4/zXqRi3ObshkRmwsOF023/+4xJB
 OxBA7sYnevz3/hpAor2SoMF/9u/upE7yHq/pwEx8bDOD0fkeQdFWYFaK2uSvTJEiXKc+
 tJdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqdcmzzd1oRWa0X1VqLb217dnL+Qn3VpTgkMqyQPx0vqrBbQOOfUyDFw7qgn6n5fJaABgXzDmICuF/HXe2QmI9NRVg9Q==
X-Gm-Message-State: AOJu0YyGXXKz2DxaM5wwfyxb1iUh6iz1qj1VJTGEv8c3oe7IUk8asAMx
 9YHdE1VACV2O2Hni6OpGg3x1fLHq5yHBSZPHAqIUy6MXI1rjxfT/BNudRNe/Acg=
X-Google-Smtp-Source: AGHT+IEvWQcPGUBMCsadqN8y4giJzsvvOq5ec1kiUNEf0xqzmH/vBvnDJhIKmxgIibMIr01ZqYfC4w==
X-Received: by 2002:a05:600c:4692:b0:417:e00c:fdb8 with SMTP id
 5b1f17b1804b1-421562cf4a2mr42986515e9.1.1717676656924; 
 Thu, 06 Jun 2024 05:24:16 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d01sm1432828f8f.50.2024.06.06.05.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:24:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 06 Jun 2024 14:23:53 +0200
Subject: [PATCH 1/6] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-bootmeth-android-v1-1-0c69d4457cc5@baylibre.com>
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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

When calling android_image_get_dtb_by_index() using boot image v3+,
we should also pass the vendor_boot ramdisk address.

Use get_avendor_bootimg_addr() to do so.

Note: on boot image v2, this is harmless since get_avendor_bootimg_addr()
returns -1.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/image-fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 56dd7687f51c..8332792b8e80 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -502,7 +502,7 @@ int boot_get_fdt(void *buf, const char *select, uint arch,
 		 * Firstly check if this android boot image has dtb field.
 		 */
 		dtb_idx = (u32)env_get_ulong("adtb_idx", 10, 0);
-		if (android_image_get_dtb_by_index((ulong)hdr, 0,
+		if (android_image_get_dtb_by_index((ulong)hdr, get_avendor_bootimg_addr(),
 						   dtb_idx, &fdt_addr, &fdt_size)) {
 			fdt_blob = (char *)map_sysmem(fdt_addr, 0);
 			if (fdt_check_header(fdt_blob))

-- 
2.45.0


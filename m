Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6AFCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 08:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C1384702;
	Tue, 26 May 2026 10:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DA3pN+8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06EBE8469D; Tue, 26 May 2026 09:03:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB1C84843
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD1D53F863
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779779031;
 bh=lVN4CR/19BzDH65kB8p3l/vwPDb0GOGZGDp49Rt+bmA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=DA3pN+8npbXatT4ygNR1e8UnKjGPSGEnj/eecq626bFmnq3vDGijzR9HUb7OkGp8j
 HkaclKAkjFj9LPoJjY4PEfhGu54b5fjkOwntwI20sylB5jK6uy3XHVR6/bss+LeVHC
 vz7JuEj/o2GfkSVyUrlgE5xMEZNhXgh/xfPTvrH6zrGPT5TAqiyP9hbJcqEXpxFc3b
 3AYo6z0fpaXyXxXdyKvSFUDmpVYvjx/FczopJdtkTn8Y4bM7C1j27PZCcVy/myRi1g
 KzGKvhUpYYM44kr1pejYEqeI3VEm76/heL2Cl9gpBVcjhsuku7FPTQdCrK6ciDH21e
 7cpCBE3M98zc5ajiTbedbBuE7iKIoKaDnuxR6unvokcjimYHqRCJTg6chPDT48/11S
 fbQ8iBGoT1UeIsL1kQLFzay/+gDHkMxBLLD9auYswG78RVcBoMfKlBm2K5hPD249Dt
 DoytHG+P7ZJfAWyPP3byEEFqEUqXLtKpm2RSb9z++H80cQW4aqo4sND9t5njqn+A5+
 O4Io7Fk5PTQi8A4brkIGPX53RZ3b9jxHpx2vKsg1fb45+HlWCUerCXO+XxSYzrbgPe
 vpSZH/w0q9NMcjpXcBMEyZlBIfrcVlt/tqrjasTBOOkMVFXInEL+mTTf75TKxf9vQ6
 ichmF3Os2iiV7fCiXMpN8N/U=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba5f794825so80954575ad.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779779030; x=1780383830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lVN4CR/19BzDH65kB8p3l/vwPDb0GOGZGDp49Rt+bmA=;
 b=MsBFI3LMkuDwnS2TSslADxrwPo8LLexJBly+od9jfvrFxvCeLW8kfCBlXUa67GPw3k
 g7bolT/tzhEA4s/lZTSZwZ8/DXIJwrpNXq0fVB1PsAyez79uRZ4WQTjia5Vya8t1Qon0
 VdBe0ju6wVQ4oNcTOcsskeC6rLMC4u+Q1wVV2jbtyOWpEhOfn4TQ60V+pFXquOLs0dxZ
 nH/17f5B76ziBYAdryPpMGuk54zkK0SlTvQ7PRLO5IRD/9o57zpM+rw8obX3X7OoiDLm
 5dqQ+MjKFvSEBbJ+FqUQRAJHL/5bP+oQuWlgo3AFCemMju5TXx7ldUiHw9834bmBfB4f
 6tGw==
X-Gm-Message-State: AOJu0YwDdp461q6qho2Qfp6MYKmDzpSn0J7IhZz1L1ayjiOdXRHwtQdJ
 jVvIuE118PnuqsFnC4JNTBl8hhht1oW7iv5KYdwgPi5SsH8XqP5mmj9HRSzo6gwvBT5GNR/Lo2o
 uhwRgv33hC/oR98OmoncLZmkkYEI72/g3J96gZnHLXwItLAKOBJSRMiq/1NTpFven/+xyWqo2Yn
 aoi9qOWlM5
X-Gm-Gg: Acq92OEtooiD4SnudVc+fzRaehOYx5zZg60OOrbYJX3h26Ph76sm5ayaN9/TUULMogS
 +prDQ+Z8dmjQIutA9EadSxgwkBqwvG8cpTLoURApIGGmmNqu8fUhpJRjlTfbSQh1Bj92WLT14MU
 C0NdLPeSwIpHXDQpKi0Bu6kDUK8SUn3SKfIbjx8BJM+6up7dftZjVPKb0e/2W71VOYt4slarqAW
 fpMptxChsqNeF6OiPBt45A/5a2u73IVXtA8UJT/O+VRVg9T5QrM/aKaYhcraWphvTR7MDnynNgc
 BU6f9LX2hCSxk/0TAT2LJ+AiTr27K9S8zNW4Ybr1hO1aUrqWYjkBkyxRzaM/KRYdz2H82tzFsK/
 6VdFsTYtBgVSj71W90b+Q69tPjC0kQMwg1hKQrHOA1qBi9ysb9jsTKDS2xHTVAvUKrEpQb5m5XD
 0o2LOEDAKliFFwkbY=
X-Received: by 2002:a17:903:2450:b0:2be:260b:fa58 with SMTP id
 d9443c01a7336-2beb06ea868mr181185775ad.1.1779779030266; 
 Tue, 26 May 2026 00:03:50 -0700 (PDT)
X-Received: by 2002:a17:903:2450:b0:2be:260b:fa58 with SMTP id
 d9443c01a7336-2beb06ea868mr181185405ad.1.1779779029823; 
 Tue, 26 May 2026 00:03:49 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm117133795ad.21.2026.05.26.00.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 00:03:49 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] tools: mkimage: fix get_basename crash on paths with
 dotted directories
Date: Tue, 26 May 2026 07:03:32 +0000
Message-ID: <20260526070336.23199-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526070336.23199-1-aristo.chen@canonical.com>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <20260526070336.23199-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 10:34:48 +0200
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

The get_basename() helper in tools/fit_image.c searches the entire input
path for the last '/' and the last '.' independently. When the last '.'
falls at an offset earlier than the last '/' (for example "./mydt",
"a.b/c", or "sub.d/leaf"), 'end' points before 'start' and the computed
length is negative. The subsequent size check uses signed comparison so
the negative value passes through unchanged, and memcpy() is then called
with that length implicitly cast to size_t, which segfaults.

Restrict the dot search to the substring that follows the last slash so
that only an extension in the filename component can become the end of
the basename. This matches the function's stated intent of stripping an
extension from the leaf, and keeps the existing behaviour for typical
inputs such as "arch/arm/dts/foo.dtb".

Reproducer that previously segfaulted and now produces a valid image:

  echo dummy > kernel.bin
  echo dummy > ./mydt
  ./tools/mkimage -f auto -A arm -O linux -T kernel -C none \
                  -a 0x80000000 -e 0x80000000 -n test \
                  -d kernel.bin -b ./mydt out.itb

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/fit_image.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 1dbc14c63e4..6c129117297 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -265,8 +265,14 @@ static void get_basename(char *str, int size, const char *fname)
 	 */
 	p = strrchr(fname, '/');
 	start = p ? p + 1 : fname;
-	p = strrchr(fname, '.');
-	end = p ? p : fname + strlen(fname);
+	/*
+	 * Search for the extension dot only within the basename. Searching
+	 * the whole path would let a dot in the directory part (for example
+	 * "./mydt" or "a.b/c") place 'end' before 'start' and produce a
+	 * negative length, which the size check below does not catch.
+	 */
+	p = strrchr(start, '.');
+	end = p ? p : start + strlen(start);
 	len = end - start;
 	if (len >= size)
 		len = size - 1;
-- 
2.43.0


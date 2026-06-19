Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4988CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 08:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD09847C3;
	Fri, 19 Jun 2026 10:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w7Tx6Ugg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 140A7849A4; Fri, 19 Jun 2026 10:33:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB26847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 10:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so10736745e9.1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781858022; x=1782462822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CYPeBF15Bn+C0ixNxE3VaHJdGF4sJDPI+Wu7ozk4PqU=;
 b=w7Tx6UggehD9WIoT55fJKurgVTNjUwNwNGUZpGIkBewEVK099cBHYMyzHfvZnxjbZ2
 qazRmagusm9cXRWUzJ1mkqHEfWIGq+MclkUNsh2igaO+/s33mBKHp8b2OkzwFo2RYgh4
 5Dq9bKCw3aWaV5TTf1ZW5S+wU+2y5H5MqENvrtBxyM7JPTVyrumpdiGlKi+fmyTyRPXs
 XSomYbKBJ1SedEZGJy4W+ti1wv+YMqgK5SbUTHJQ4mF8zQLdOM1BJU33BCnm58yUqert
 UuvpsBXjWlLh0TG+BJjgn7WYDgHS+X3n5y3IvGRiPIy+ChYJSQCoEUQVVjzODQWRlMe7
 andQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781858022; x=1782462822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYPeBF15Bn+C0ixNxE3VaHJdGF4sJDPI+Wu7ozk4PqU=;
 b=Aa9Wa7gmTKz/2oaX2i7G6v8O32hAX7tlDe9TBVdcqcf27eU6kLjNqh2x4789u0GvjG
 JxNxwzo8jUsv7uMlOPR9vJFu9ntq81wniRV2mTW3nY/wPywpMvqYfchDfLDtg3s2beOn
 2SNQYfEq//2fTQ6COhUuzIC+oLmJ9lffV7WzO2NdKolF9j4vJIGiSZqKA2R/U1oUAb2H
 D/ybXsdGrSHYMpoAY0xRVEVJXLYZDQ1nU0uYCaIwJWsCvTUP+EcMezfq7lFK4TqG7+Ra
 6VQA1lm4IQ+EhUJmgfwYBzxCPCwOsQ8xbKzJ08/DcgmYfbFJwi2D601CFR+sPnk6f/oj
 LTlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ986asmGpHLYPmR2NP/B5JtBNmIPcR9Cr8XAl2zO3sMuKHnjZdO3H4inP6YXAz3ItJnUqwrpEM=@lists.denx.de
X-Gm-Message-State: AOJu0YxdVooGT0vTmJYpmiCxZFLbXDDp2SrUalPAAJta6J0GG2KZDI5q
 ulCwuC4KmgoZShxGF2+oVR+adaUjw3S78aMW6f7jRy2FmD0qvRWiSexiQEMuSyIfUC0=
X-Gm-Gg: AfdE7clRZT14q3OcYkbPyLAX48SdfmbX1dbvvcX8Wy+dV8OQ8DEjrLg+haTGJjhjngP
 XadMFK7tElnhlWhkZkC/mzUzxywCUwpSYPwXFmA9ckMm/aALqp76vbwyWbHXoBGD1/K7m5xfrnO
 9DYDNPlJYLNpe4slckkaSdBzZkFPGkW884ZZtUnYkwvMhT/7bzsA0wtkITyr8q5di9XXd5NNfgF
 nutP+mD2cqVm2574TR4HHlEOzcvLW614r1qcqwX0FzZHgSsAw/ud5/7QFpK1R9kbqm5Tm9dhkN1
 PU+KO3hu5JLo9B8gGTs6p8qC03W5On+0kpNkdOXL89A6Mf+/mHozYbIi4gWWsLFWt80AYOFN7qa
 y3bY1JsoA17omyFm3C2sF9a1p+Xx8njxBnfsZInmyDVzx7mdgG8pNfTZbMsHYA+Xfvk+1bUxJSK
 qGAaOxpPMfmCMdoWypyzzPcCnfsxb3dRv5IF4m9BRNoAtkIaAXCqGNpb6N7EEKBk2d32Mhg7j4j
 5a/N9MO9Z5SO8rGUfCx5BWrSXrCf+DC5iNjK5/cE+tqiUtD1TlGFTP19zOPwfYIa3743VZ3d4FY
 sH0QkNtItLLpwoMo2RXf5OzypPQ/5QVyoePFluh4yvtKTrlGxnnFQcIVvgxKLYB+zbY7dvk9B9f
 HfC//5VP+Ym03FFaUPUKECaZCAGpzxD+OO7Lb4lEAic/ZKF0R6syKNg0hQHxMzxadt2JyFOyac5
 wQSYsr748Vur+835tELl/WZe2QEtR2cHF8SAgigQhTNDSZwAin/BkJX98BcZBrKF0uOhsHlb9vP
 Ov4fb9jSGGBBwhl/w==
X-Received: by 2002:a05:600c:a088:b0:491:9969:739d with SMTP id
 5b1f17b1804b1-4923f5895f5mr50156745e9.29.1781858022490; 
 Fri, 19 Jun 2026 01:33:42 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923ff8a712sm49146695e9.13.2026.06.19.01.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 01:33:41 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: fix memory leak in efi_var_collect
Date: Fri, 19 Jun 2026 11:33:33 +0300
Message-ID: <20260619083334.113161-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Barebox has now ported some of the UEFI code. In the process
they found some bugs.

In this case when the variable buffer is too small, efi_var_collect()
returns EFI_BUFFER_TOO_SMALL but doesn't free the allocated 'buf'.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_var_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index d63c2d1b1cd8..e51b21fe0b0d 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -446,8 +446,10 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 		efi_status_t ret;
 
 		if ((uintptr_t)buf + len <=
-		    (uintptr_t)var->name + old_var_name_length)
+		    (uintptr_t)var->name + old_var_name_length) {
+			free(buf);
 			return EFI_BUFFER_TOO_SMALL;
+		}
 
 		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
 		memcpy(var->name, old_var->name, old_var_name_length);
-- 
2.43.0


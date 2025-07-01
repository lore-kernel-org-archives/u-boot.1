Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731AFC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD51182F83;
	Tue,  1 Jul 2025 15:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lejf6eVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5044B82A76; Tue,  1 Jul 2025 15:38:38 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7652082F83
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so26929005e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751377104; x=1751981904; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m9vIkylaHli+yE4UvhLW9VKNv+kxl6kPyfUakF/hN7E=;
 b=lejf6eVw028bvULuxHDGjwFThZCgwXniVHZV8tqFq7eeH8CsypepT/UTRi54AEX9mE
 OpfdKmt0fKHKGF4m8866GpkmPFo43TO9DPRFIqshNQpL2U2DH5VZOjCanFqQI2lAa7mS
 Lm5IRLSEzixbYgLJNRguvXS/8AZlbVudGlpifhD81ynEEvpXzkMVClHg9zop3b/gMorx
 lBTGBozOSVuq5GgdPCK91vCSX0WyeIoIX/KLe19XRCYZS2i9fLbCtSzqhFEZKowOG/eV
 ptgGJ9GyVxi93ZnoiILf3TfgbDbLYFJHT25TctMxaptBz1HPM9aGStVNngu0FS0Mnn2U
 VCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377104; x=1751981904;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m9vIkylaHli+yE4UvhLW9VKNv+kxl6kPyfUakF/hN7E=;
 b=wqsT5pyhbEjuZ9akDh3wfzQh3nCl0DadQhirRO0DyixQN1YDRqxA+8SAdOtWrgcHsA
 Omeg0vW7hhCJZ0FLGm+VCLsQ2zAHH6Sbs18deSsYTKbPpWGlifLgOMDxMQMzeo6hhFYb
 3zegh4+bABW+QGI4a7PKtXyumismGjEF1Tv6LkzV2uyKbNsGGtV+2C4rmSJhP2dTT3ez
 /uPhIH2+OPEkPqX4yR0JztHnI6uSgHLBmBVi3J2RWgLmh1yikMz67mwSKWSIpVB6TIks
 vfDN5ZNAEMf7NvQo1A7e/lZKRAW9dJXPO2/ZXaVyYJ8O3nLTv16+4UU2agfLVSq9vfKl
 79+w==
X-Gm-Message-State: AOJu0YxXxsGZjX0a9aCSpqp/fUcHANLe6usta1hq7YTqSngOZpHOx+Bu
 e3/z6sNTfL2q8FyxNSHpVMvgEKBPneCXRs8b8ggslHK2EvUBNt43hYUVRnV+I63DtzE=
X-Gm-Gg: ASbGncseCoZCaAdm/iGFxteAqYzTD+dyCpkcSBjUolyMX+zx7ivQfHqXm1SrWAb9XlQ
 UzOpDYyhpqP+5BmMpOeQ6q5ahcPiYI5R/nqiivP/uOPhzA/iJLdVr/XLzXndUkm0v5+ASb7PW+9
 ebPFSlNXLXPB2a+QpvXPW1jp/jtahK76xwa/QP9sjYtCwBM9hUUNJBlWui0CCNJsIwHdV2HEpvF
 DIwXIX24JQnpEcBnYNHL5PaqOYwCKyG3jrRqb7WXe76pPAtjuPDiFqNQM6b0DByAjXqXjcbHfgh
 WhS4XA/PkzoBr4X1KW0L75pQhgU3nIJAqkliJFojZVaqBUrWWe6quvtP6oQplaT9Jr5vS2aZnyc
 F7Am90+xRhongyrI=
X-Google-Smtp-Source: AGHT+IEK1rA5Dc2y6mEXgtiqMJn4tkS8p8H9K7Fvd2gjhupcajoB5On5nL6dI0nhO7ObZ6DJOtFz0g==
X-Received: by 2002:a05:600c:3112:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-4539ebf5521mr88064395e9.5.1751377103691; 
 Tue, 01 Jul 2025 06:38:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:fddb:f4a6:27d9:d8d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6fa2sm197268095e9.27.2025.07.01.06.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:38:23 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/3] efi_loader: Address some issues found by Smatch
Date: Tue, 01 Jul 2025 14:38:21 +0100
Message-Id: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3kY2gC/x3N2wqDMBCE4VeRvW4gKk0Pr1JE1mSsC20su6UI4
 rsbe/kzfMxKBhUY3auVFD8xmXOJ+lRRnDg/4SSVpsY3Z3/xtcMor5kTtB9lcaGNbfC3GJCuVMz
 ABjco5zgd6s32hR7DRwtc/kePbtt25L3nhXgAAAA=
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported that there were some unitialised variables and
dereferencing of NULL pointers. This series addresses these issues.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (3):
      efi_loader: Prevent dereferencing NULL pointer
      efi_loader: Prevent dereference of uninitialised variable
      efi_loader: Prevent free of uninitialised pointer

 lib/efi_loader/efi_file.c |  2 +-
 lib/efi_loader/efi_http.c | 14 +++++++-------
 lib/efi_loader/efi_net.c  |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)
---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250701-efiloader_fix-63c3609c6ed8

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


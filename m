Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007D6CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 23:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 030BB83C64;
	Fri,  7 Nov 2025 00:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k+pvmTBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA6183C65; Fri,  7 Nov 2025 00:28:44 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1B483C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 00:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so89633a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 15:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762471721; x=1763076521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xo1oUYKy0GRQodStEsKX7URiNdYdu6DMIJ4ElGlaIxk=;
 b=k+pvmTBoe9q4cZypPTWFrjEcmFvJK0qwLBhl98/PJVAeSmos7YWyW4Mo48lsZtZx4Z
 ROrd1UHH7X47ycQwrxW9NA9LEA3FV62x1w6MiYjlSKpT+/IC97eA7kGhe5UXdY4azfj6
 rc+kN6TLdsOV5QAk0xaBUX9zc+FLiZOUhg3og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762471721; x=1763076521;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xo1oUYKy0GRQodStEsKX7URiNdYdu6DMIJ4ElGlaIxk=;
 b=gTB4dl6QFq+ep1UwSD1JDgfqMRrq1kg9CVw5l8Z8JWlGgo2vDe6rtM4FqbuGjJyCjS
 2lXt4yoB6EsWrvEs1IVfSp5snnGQ8tnhUXJopZEaqKT/eYmFvW6Y+ZUEaFWzg+oCjbiM
 xtlwLrY0w7i2dnhYxgz9jYqChutbTzw64ai64HziwdzU4LYuNkSEmcFLZvjMaXR40hd5
 eDgAv5hZt2T/1UggMZo8t/+4yzAg7IVi11YM92Vk/BWRUX3uXq8JeN9Wf7pKH+sLwk7E
 QAsXg19t/Fq0+U+ycL74C5saHFpAkbfqn7g0i3WnhTTruwPe1oCgiev/kAqdII307dAN
 1LKg==
X-Gm-Message-State: AOJu0YzDjYHU5AtLpFq+L9srS/8px9IT5j0mN3ICZQY23UxrmbbpQuS7
 6OfgZCHRPmAjASzSQ3TPdKSfp1x1HkZglZLnpjAl+c3dWKzyGgL0OCl5BACPfLkm+mn/1djkqQj
 z+IqddWJXaQ==
X-Gm-Gg: ASbGnctItWJSTDibjmbpjJREXkpqsr6vEJ3zfP4xSd1vPIgsrjqWSkVI9OyRLSH6fxV
 7Dpn2qtsWiUXN8m37vsujoA98t0/kl7VzsbVOwF82/3irQvpwOFQWfM3p4Mwi9cqusPu22Am+wT
 4zJYb2CcoWZUPzSYv1Idk8VeOyQT3clC+EKJkEsgtLkSdsYVPttMIcj0PXDXgd9VD7g0xr4L1Vu
 o58WaZxeuCNbWmySxCxqNtCEKfoLMHW+a9ZJpJKKhcsXLWWvaXty4PjNT9S4hALjTPcNXxL3kKC
 rv/QJWy/e9uzW4KMgWudSSCySmuaWM1k3rQteffMGXA4L/mRxzYtCR7tqnZD+zzW0Cj1kvKVquG
 aBChjVoGMW/EjJJwlAn0U5vg4+hkBoDnpMylaAq8waqaOOvyPJRN9PnCfHm7UCXXwscxOGPFR1v
 yzQl9zFaOoAyTYSHyyYV9GqGn4um1EBb93dnLEvDxYyQ==
X-Google-Smtp-Source: AGHT+IFvSt8F/3AgJ+kakfb7xPSjRaVS0oV8fMO/Zp1VW5y8IRPF7WwqY2DEcdy8tpFEmuWz6Opnog==
X-Received: by 2002:a05:6830:4986:b0:7c5:3d8c:f111 with SMTP id
 46e09a7af769-7c6eff1a11fmr1255099a34.22.1762471721606; 
 Thu, 06 Nov 2025 15:28:41 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f10f5c0bsm444852a34.18.2025.11.06.15.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 15:28:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] efi_selftest: efi_selftest_snp: Fix warning when building
 with clang
Date: Thu,  6 Nov 2025 17:28:39 -0600
Message-ID: <20251106232839.3243622-1-trini@konsulko.com>
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

When building with clang, we see a warning:
lib/efi_selftest/efi_selftest_snp.c:63:18: error: field dhcp_hdr within
'struct dhcp' is less aligned than 'struct dhcp_hdr' and is usually due
to 'struct dhcp' being packed, which can lead to unaligned accesses
[-Werror,-Wunaligned-access]
when building lib/efi_selftest/efi_selftest_snp.c. Resolve this error by
packing struct dhcp_hdr as well, as the only place it is used also is
packed.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Adriano Cordova <adrianox@gmail.com>
---
 lib/efi_selftest/efi_selftest_snp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
index b00c76c2f172..290ed3a28f2c 100644
--- a/lib/efi_selftest/efi_selftest_snp.c
+++ b/lib/efi_selftest/efi_selftest_snp.c
@@ -43,7 +43,7 @@ struct dhcp_hdr {
 	u8 chaddr[16];
 	u8 sname[64];
 	u8 file[128];
-};
+} __packed;
 
 /*
  * Message type option.
-- 
2.43.0


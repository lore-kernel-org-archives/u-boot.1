Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB08CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 14:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE7B836C8;
	Fri,  3 Oct 2025 16:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DWV+z0kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AF5E83775; Fri,  3 Oct 2025 16:54:38 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1315F836C1
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 16:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so19910315e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759503275; x=1760108075; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKfmW3Rb6rhti7XoFmjJoaNhDHzmqx5+UfE0N2in7jA=;
 b=DWV+z0kPiSR2Z93AycGi/aXz2UPGn4Nl8lSwQfvYHBbgbdmKlI5847i+XT5iQLqWr+
 tTwNtspLNqbasnoCajVPd+XIaK70He51lvP391swEO6uYhWdj+MG//fMTR7er+C08o54
 HPmcT8xgVGMdnUnRL3oUnedi1KqYvhAWz3YNZ1PPs542w1j4Ys+xUvwPiTts2g46yXEV
 DeKNL3lp4IzCPCUJx0gbvoEnhT5PBzZ2tCMfDZ9KE0faD5eZYhgPfZg/aNM9IB/HVsSQ
 fEl2ydMu2i+CDWlLoC212ohjXV7wsiC/qEMyPK6WqrViWKY32g5YbK2xsexRT6t7YA+Y
 ZZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759503275; x=1760108075;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKfmW3Rb6rhti7XoFmjJoaNhDHzmqx5+UfE0N2in7jA=;
 b=DXhRi/4o+ahZzzgNpW/DNQq9meLfg+9k1Fn0yQF+3fk9NJ5UnhK2fJEP93dEbynRek
 Egiif4bTD3vCBHTz0Lxny/4ONHacFcdilhExwLTR0ZetD4P9dWrkPhhPhXCBkUHV0SXj
 Mb5g+bCPr4fJgBZUWXutkGwBj+kxsegwYW6WF9UHKFsqjNxtB4vFAyPfQ/fBN8oFhC/P
 elW8s5aOl7sGtHC++YUdwY6Y3tw8tShGboWvpRj1I/lMmCG9TZW7D0rQQ+mqrgU5VZr6
 ZvRu6KMenSPIYZI+/dScsmgeTFNJ6NNrlMlR4Damsq3uApITCd5z51coxpuwwjrj0g4u
 Adyg==
X-Gm-Message-State: AOJu0YxwCKJzJRBU1CLMRlZcN71doajyyOJ/dM6SwXPrRKSMAfseklSO
 vYLn3VL3IarDeEEzop/wsotayHreZ495QClewFXfM/3juFHWNi25S7IHn8VZlnpOR/M=
X-Gm-Gg: ASbGncvc3+fL/uwbj1NFcT1YBUkxIPF1OyfQdUtOd1ZwziObUDkjcaR1J0QVtsSKRra
 jeEQYa4VFTq6DODEzvYoarMrmCIyc6bYR/yrvlC78TmJBaU4jGyDM6HEBncTQrJ8wY3rDXImj7Q
 vi1DXgjdZwVMJWoH0IjZ6dqVb4GEpZH0YEFqfPJyJejk1IBt9AbfpNfKxQPmhZ4Qwi30+Z7ra8/
 Pq9XIljv6hzjMBcbqciVQR5+6JnJtqgPfKT7jrNZYLa/p1qvkFHKbvTSRCzBZ2KOqINVbQGmkj6
 lRehTtzZatnUYc/BYi93oRXYhRtAXD4D6/NeDadGXcP5MJaSRKWaNDOwAEVYroSIvXvcuQlTnSa
 Ij8lmEcPJNocCVYlA/zXoVD3sLsmcmsmwh8Jzq1tImSb76K5jazD4/GjP/33FIHMOQEcGSTjZqZ
 5HmNA=
X-Google-Smtp-Source: AGHT+IEyd92pT/ImZQAbnQBor+31g+cVk77Lo2g95PRE9NdgXs6MVTw79LWgv2g+URu4asTtziTYIw==
X-Received: by 2002:a05:600d:11:b0:46e:6d12:ee2a with SMTP id
 5b1f17b1804b1-46e6d12f14dmr31558665e9.16.1759503275450; 
 Fri, 03 Oct 2025 07:54:35 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e5fdsm34208735e9.6.2025.10.03.07.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:54:34 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 03 Oct 2025 15:54:34 +0100
Subject: [PATCH] efi_loader: Prevent leak of memory from tmp_files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-efi_capsule-v1-1-07d5fd09b97f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKnj32gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwNj3dS0zPjkxILi0pxUXROL5BRzo9SUZDODRCWgjoIioGwF2LTo2Np
 aAKpUabldAAAA
X-Change-ID: 20251003-efi_capsule-48cd72edc60a
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

After the malloc of tmp_files and before its value is recorded an early
exit will need to free tmp_files to prevent leaking that memory.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index f19e78ae9d1e250f7bf8362f043877c6d10a9675..31b47a20186e036f6852c6baa4f353a5d7b97632 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -1096,8 +1096,10 @@ static efi_status_t efi_capsule_scan_dir(u16 ***files, unsigned int *num)
 	while (1) {
 		tmp_size = dirent_size;
 		ret = EFI_CALL((*dirh->read)(dirh, &tmp_size, dirent));
-		if (ret != EFI_SUCCESS)
+		if (ret != EFI_SUCCESS) {
+			free(tmp_files);
 			goto err;
+		}
 		if (!tmp_size)
 			break;
 

---
base-commit: 8d22c596c6f82132c006ba89481275c60b5b0e2d
change-id: 20251003-efi_capsule-48cd72edc60a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


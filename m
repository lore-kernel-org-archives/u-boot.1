Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1174CC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE9282FE1;
	Tue,  1 Jul 2025 15:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DsMDNryq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF9AB8300E; Tue,  1 Jul 2025 15:38:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2C782FD6
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so39931285e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751377106; x=1751981906; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r9LP2xXT7GcqUth1TYbQ5GzCkjAw0DJnS8hmWVhdOgc=;
 b=DsMDNryqhJBjW8wKXx1dmTG+QvrHnsUEPk7WOyk6nxeSBFCLWqDwUO1ReyB728Vi/J
 XygOr3sH5BHDnzQ7TtWBxrzX6pYog7en47ePzGqKPaxe8POVQX21f9d5qwXw3RUgHgUF
 FFOvKWLaBR6FK9AMWCKjSG8GYNZYL8po+0ECW5/6FkPGunv19Yjn4DYJQDaJHz/oM0p8
 nCwWVjbbRrkU7NuckxRJbpxVqILeLF0ndNziZs9PSJfukCB8BNsFb2nK3uWrVJ53KwlW
 RMzQtNQRm78HaZegkmu6IURFHJ3ph7Hht2IwzYGXQHFQOy9vyouUPY50Uq7DW3LeBhns
 EFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377106; x=1751981906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9LP2xXT7GcqUth1TYbQ5GzCkjAw0DJnS8hmWVhdOgc=;
 b=UTsJ3DhAjAg1/k/gOPAG8Yj7Gh2LHAAXzgiGYmO4nzBCXnLqZ43cAzicjwIJt49WWc
 ivdduzZvRNBV+0OZjwlqhk2fsDw9tGg9T4YY2Tj6+WBKKjVUDy2oqfpk3vzdA38f/FeF
 T40L0sDn1e/aqj+2PnSDmYKUBEBHoZ/09sZpzn2SflA63sq5bBvhuNz3zehiAZccAKPQ
 AQXeW3n+3ixIQyPzIBUUg/6TKwbpI6Sb0xJJ7AYbTffipTDitj2cfzeIj0/sgnZkS3n6
 5llfxFqO+6tZEmw+kmWAtKIHWNgb9qfiSivlqbIPvpWKlhXFW0bqgoR+P1AdjjeN/CMk
 mpTA==
X-Gm-Message-State: AOJu0Yz4O+X+K/2Fs/IviitpGJOTp+aE3JHC0SF/uPvULpxULlGufoZK
 79WJPMBPNLVKugUCFfNrnYHYwClggngzTgQEs0iDZDK+Hj5ODCT9xWc75f/iETu4wBgp21dSnH6
 Q8BlAZO4=
X-Gm-Gg: ASbGnctWSAY88eJGLIaAmQ0vzDs/dsDGJJnHJIBF0nrThKo3dYDWCFrJU73HwtDx92B
 cqiwfzWly1r0m+DAe40M+qswiQC6irD3TCkLo0+wXPsbHI5/HUoTm99cga+kbSza0VXJRgqYiOy
 53BfHlt2pWzzeX+N5+g+gtTtaq1/2bydr8AIORO6RwbGne2fnSEXNzedsUQ89G+poHnhFKFYp83
 eEsCZbZEzJKOedy0JCvoFpgJgPwOrcxHjGLDiQNhLKyIrQj2q0ib+REv7J5QJKF9Ch6p7xhIJSl
 aLxcJkqK206+9PBOl8V5fdbJ1I9JST64oi+7rh8ztwlZkhIRDCuLR7GDFwg4hTNyS+e6mBO1Vbb
 YDXKxXrSqDuXFqvc=
X-Google-Smtp-Source: AGHT+IHqC+NFI6HmYBDdB7DrBbiS/oUrY+yKjMGpLgvSAMzqWQbFUehmM0euMxH/5eFtaswQXIUS7A==
X-Received: by 2002:a05:600c:6384:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-45422f3633emr25983185e9.6.1751377106290; 
 Tue, 01 Jul 2025 06:38:26 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:fddb:f4a6:27d9:d8d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6fa2sm197268095e9.27.2025.07.01.06.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:38:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 01 Jul 2025 14:38:24 +0100
Subject: [PATCH 3/3] efi_loader: Prevent free of uninitialised pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-efiloader_fix-v1-3-f3c6e0b0ae43@linaro.org>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
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

Taking a goto to out_of_resources before receive_lengths is assigned
will result in an attempt to free an unitialised pointer. Instead
initialise receive_lengths to NULL on declaration to prevent this from
occurring.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 8e708d8d350..3d092523dd5 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1130,7 +1130,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 	struct efi_net_obj *netobj;
 	void *transmit_buffer = NULL;
 	uchar **receive_buffer = NULL;
-	size_t *receive_lengths;
+	size_t *receive_lengths = NULL;
 	int i, j;
 
 	if (!dev) {

-- 
2.39.5


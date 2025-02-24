Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A26C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D0180FDD;
	Tue, 25 Feb 2025 00:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dbgQJcrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90CB810F5; Tue, 25 Feb 2025 00:07:24 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 998A6810E6
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-855bb6041a6so121588439f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438441; x=1741043241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=dbgQJcrsktkCh6VDHc0kyC6hczB79Xm7lU89/sLAGSlKbDdpfB4xI6ZEjKhT1oJBsb
 m7cSiokUIUknHBPHbHQKO3Tnwmwf4wuMh2t3UkmOQsMB9d8XmnIqrNaplIMxdPLUqO0+
 jglQN3UM3WwrfdM/vNKrNW4OrjarmnSiBzsWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438441; x=1741043241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=cU3IiJ+N+gYOXGcxQSXoQd/CTfACW59diOr/GKKXfekRfXqVbvMDCbOABOTGd8X80J
 4U22JDIK0llBuoPH/gd3GAZ9OYajVV+z7CyeQz4MvzaOoLSFD8eWzSaTIsPCHswZJswq
 N9bbJ0cJBhbHvxd5O4R9O2uRGw52gbWqZPV/zlyPBFmSoh8Q1dQgnxB8OlMA8lpxG0YS
 9hQHobYAP/wVDOkUdXk4ezaLsR+C439fgeyyd/WAz82akZQna8j/vdbwmDOq0oYNpuME
 RsEGFPlXAv7Lg4f4608V77IdU5P0Vu9+YYnlWFKObPkWE8bN8abaDA5jjm+4XU02dBgm
 +Szg==
X-Gm-Message-State: AOJu0Yz2fHxaAXOw5/Uvt+OzuiD15PTgegWZZsGAy3t6BJmM03AQJ9DU
 9X+nQ8Vc3AwlSiRKoBuV8Bah9OXMeZJwKgxqaF0guXLTf2y9NdHzjk9DBukfukLLzzrgWIxS1ko
 =
X-Gm-Gg: ASbGncuFb2EKmVpfcr8oMmW6iLWIBHUy1WXqD4EcJiAzAqwPra8CTv3N2qiTzoEenD+
 /d5hjVii1TTIQ/837fdNkIdW3DI+RAb3Fap3J8ryfNHz/4YwomIz99ylM+dKNQKNV2FQIyv8dtl
 dHShBSoNgiHaKS8G3O7M1+3dYGjKo0KpF76jHQVkffyDumv+U6nj7HYG8PQAeGC5Vf61dOYXSdk
 37ngPctGfINdAZ9VhOn9bYDfGqCSuCQqoBVZjxowhMQLy0yr6AivDscH3lvwhTkWS8A5jj7DqBC
 pT/ztpqnSNkbgnLfZkczKQoAaqymOHCl6uzU7RyFMvvqoQOyCjSHgQNgY2s/xeE=
X-Google-Smtp-Source: AGHT+IEWlJKl/jfwuzq5nAA1v84IVQLNU0vREKoi0uz7pwk72wycrM5KMwpTtgUKUAXLhwyiKY5lww==
X-Received: by 2002:a05:6602:13c2:b0:855:9c88:788f with SMTP id
 ca18e2360f4ac-855da9d67f3mr1606019139f.8.1740438440843; 
 Mon, 24 Feb 2025 15:07:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/44] x86: spl: Drop duplicate CPU init
Date: Mon, 24 Feb 2025 16:06:00 -0700
Message-ID: <20250224230640.2665206-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

x86_cpu_init_f() is called by arch_cpu_init() a few lines below this
code. Drop the duplicate call.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 7a033505101..47cf9c862b5 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -84,8 +84,6 @@ static int x86_spl_init(void)
 	log_debug("x86 spl starting\n");
 	if (IS_ENABLED(TPL))
 		ret = x86_cpu_reinit_f();
-	else
-		ret = x86_cpu_init_f();
 	ret = spl_init();
 	if (ret) {
 		log_debug("spl_init() failed (err=%d)\n", ret);
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BECBD68BCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 16:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEFA88E69;
	Fri, 15 Nov 2024 17:54:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z/JYSPIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48CA890F6; Fri, 15 Nov 2024 17:54:07 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B886A88D56
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 17:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-460c2418e37so6624561cf.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731689644; x=1732294444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/h+9XJJT0eXIuoO6OFGBFGdCvrHc5jMRzrsrI7e/iQ0=;
 b=Z/JYSPIaCMfGiurv0QO0yEFmbiFZ+Px7JCLWsswnnUe/mEqqmfYiQB9eeSMdPr02b3
 Yez8VfkzRnO/PTeyQ9z/EVwnksPyRVWAtQSr2zGOhcz6917UqpOpUnU6+jw0UGxIu9PS
 PQrsSb0Yy349qtGFKyxLsSrEEwcccoU5h93G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689644; x=1732294444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/h+9XJJT0eXIuoO6OFGBFGdCvrHc5jMRzrsrI7e/iQ0=;
 b=LZ6bx/ZzzWcugN3z+1dvr/aT6fAJetxJQME4qhTSn35NXVPSz/5ShLXckeHA1HrLHO
 rF+ScNS5BozA4kFUROVHrjAgmWL8ocBRUjcN+IPUWaiMlYZ35UD8n4MLXr8Jet8JpLAX
 eKx+OuUOuwAeYpx645F/fyO2dcaPk0giKH+HNs0oVMM1W2oiMDF8ClI+GmL/LDArX0jy
 aPUE6DnKO/2G3AbatCmcgMQKlVbJcOkRG2H0wcdTDABkoJh4YdShxozsaXj/Q7Qum04z
 XGUHvEa7kVwg5XLprKNzp2K1cQ2GaArw0dR2DVrYpPM8mP1oB/Qc4pg56D5XofIv6VzC
 sRow==
X-Gm-Message-State: AOJu0YyFjDd/8eQL7UwfhKCWQOf3lyw/pU7x78ACfZNhtryvbUhk3+5q
 9wlfMcPGcc+qQ1a14esvif5GGfSlQ9TmV5fBaaVjRrfDwz0Mz9zQSaWtJl1eYSjyJgllZjMJct+
 AO2g=
X-Google-Smtp-Source: AGHT+IEhE1SvQsaxeW6p2s6ppJfyCqjNd0vnX9ILp3cijWD9DeS5Bqpc+JliwdD6BjAL4bRPVkGXZg==
X-Received: by 2002:a05:622a:40c:b0:460:ab29:e6b1 with SMTP id
 d75a77b69052e-46363e97e72mr45953931cf.44.1731689644628; 
 Fri, 15 Nov 2024 08:54:04 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635a9f20c7sm20784831cf.23.2024.11.15.08.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:54:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/3] efi_loader: Fix Kconfig logic around OF_LIBFDT
Date: Fri, 15 Nov 2024 10:53:58 -0600
Message-ID: <20241115165400.2486914-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115165400.2486914-1-trini@konsulko.com>
References: <20241115165400.2486914-1-trini@konsulko.com>
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

Given that OF_LIBFDT is library functionality, the feature of EFI_LOADER
needs to select OF_LIBFDT rather than depend on it being already
enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 58d49789f12c..f41447f2b45c 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -2,7 +2,7 @@ menu "UEFI Support"
 
 config EFI_LOADER
 	bool "Support running UEFI applications"
-	depends on OF_LIBFDT && ( \
+	depends on ( \
 		ARM && (SYS_CPU = arm1136 || \
 			SYS_CPU = arm1176 || \
 			SYS_CPU = armv7   || \
@@ -21,6 +21,7 @@ config EFI_LOADER
 	select EVENT_DYNAMIC
 	select LIB_UUID
 	select LMB
+	select OF_LIBFDT
 	imply PARTITION_UUIDS
 	select REGEX
 	imply FAT
-- 
2.43.0


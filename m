Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E80CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D2A87440;
	Thu, 19 Oct 2023 17:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jSJ7vR6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD5F8727D; Thu, 19 Oct 2023 17:04:40 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A818724A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7afd45199so101646197b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727877; x=1698332677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nQ3QW/FYyqsoKwYJufJErcmKHYSiGgMXBf8RMC88zSA=;
 b=jSJ7vR6vHXyZels7d3rNXfH/Uwt6VVIYQ4URFoAmZ3No/c+UzPfqE7VnEr6xHMmEkS
 MGoXV3wCVT75ZYOSafnyNDDObIAzIv8hxgCeNzBi0zeesqayDkPefOHAzNH/8QngrxSD
 eR7peJnFCuVMq+hyy1wDH12buut1MmXTj3/rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727877; x=1698332677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nQ3QW/FYyqsoKwYJufJErcmKHYSiGgMXBf8RMC88zSA=;
 b=wuBMe52G377BEFEZPEjOGHnmXNxWFKwLukgkE7kBS6rJASk2QcJwTSh9sa2RWIGPRD
 qTeWR5XURzXPygI1QeJbnHw8Pq13OwQwl9m2IRWY0XjnygOS0HCRfxLJ9VKA8w8zLT+J
 JXop+FB/dlkUAIpe2MlwUuwo+IYrkV3nkE+MBa2kLK6wVPUaHdLBLbJ9nC0xOkfRzN5P
 rA7i+0DgcRm6GZgMnXcF4uUZ2WO3bgWHOPIoN4seOE+Z7OFK6H+gcSTSCZ7zkNBHgoGI
 VQ3yNp22D974o++x+otpRa48JYpoCyUAWICItRTNhdZqKswnCbgdC/MOZrFm9jNum+Vq
 YfYA==
X-Gm-Message-State: AOJu0Yz/gtNCYjiYE//0BEJT0lcwvPnN2D7AKIx8Dlmeq9OKTMwB0ihd
 bmo+8Joeg7k7Fz8d94g7H9CauT1nWJh6x0MdukhdaA==
X-Google-Smtp-Source: AGHT+IG1yLPH6r3yVJMfnxQdxIIyKLGuZK4QxrxEqEafO/WuT3+BtStR9ARW/1VPedhHqJV62ommIA==
X-Received: by 2002:a81:a196:0:b0:577:a46:26e5 with SMTP id
 y144-20020a81a196000000b005770a4626e5mr2377316ywg.31.1697727876717; 
 Thu, 19 Oct 2023 08:04:36 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 m127-20020a0de385000000b0059b2be24f88sm2432508ywe.143.2023.10.19.08.04.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:04:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] common: Reword CONSOLE_RECORD_.*SIZE help texts
Date: Thu, 19 Oct 2023 11:04:35 -0400
Message-Id: <20231019150435.750483-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Make it clear that in the options for setting the console record buffer
sizes that we are talking about buffers for that feature specifically
and not the general console buffers.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 93c96f23b013..2d6d412f5e33 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -28,26 +28,26 @@ config CONSOLE_RECORD_OUT_SIZE
 	depends on CONSOLE_RECORD
 	default 0x400 if CONSOLE_RECORD
 	help
-	  Set the size of the console output buffer. When this fills up, no
-	  more data will be recorded until some is removed. The buffer is
-	  allocated immediately after the malloc() region is ready.
+	  Set the size of the console recording output buffer. When this fills
+	  up, no more data will be recorded until some is removed. The buffer
+	  is allocated immediately after the malloc() region is ready.
 
 config CONSOLE_RECORD_OUT_SIZE_F
 	hex "Output buffer size before relocation"
 	depends on CONSOLE_RECORD
 	default 0x400 if CONSOLE_RECORD
 	help
-	  Set the size of the console output buffer before relocation. When
-	  this fills up, no more data will be recorded until some is removed.
-	  The buffer is allocated immediately after the early malloc() region is
-	  ready.
+	  Set the size of the console recording output buffer before
+	  relocation. When this fills up, no more data will be recorded until
+	  some is removed.  The buffer is allocated immediately after the early
+	  malloc() region is ready.
 
 config CONSOLE_RECORD_IN_SIZE
 	hex "Input buffer size"
 	depends on CONSOLE_RECORD
 	default 0x100 if CONSOLE_RECORD
 	help
-	  Set the size of the console input buffer. When this contains data,
+	  Set the size of the console recording input buffer. When this contains data,
 	  tstc() and getc() will use this in preference to real device input.
 	  The buffer is allocated immediately after the malloc() region is
 	  ready.
-- 
2.34.1


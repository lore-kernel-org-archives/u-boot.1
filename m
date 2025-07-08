Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C333DC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 15:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685DE833FA;
	Tue,  8 Jul 2025 17:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IkA7OIlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B0A8331D; Tue,  8 Jul 2025 17:25:13 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2869832F0
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 17:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vtpieter@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-607ec30df2bso8701880a12.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751988311; x=1752593111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3gOGuoVkaXDVljPUp5gGs8/89yaHvWZPuHYqxCuyHc=;
 b=IkA7OIltpKCGAubIxKnOd03h4E+tZ4/aGhLySHP8HZRn1NOS5O/Hprd/EeqSWTRAGc
 MU55Jh/dxcxONVQ+z8A3kGgi1qd5KkVNRcL87zi7SLoQfqI5Pw+jQxWBw/SWjMJx61/f
 WjtfXSIUbPZe73VMr/oNJGb2RT6seQqRoTrhHYPxk1Z/bmgg05ozY3KBmDiqem4mZY6+
 KuoeGKRBknhkEMFi1Dq29cH/180vhYswcOptEDJKsoCmhtvQjT318IALtg0dGesmf/fw
 ede5xvfdIwwZZk2TIa/Kh5TLMHsQRe77swIRTV0e41J/mwccYElNrlrJNY5rV9FCqJ+V
 tE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751988311; x=1752593111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t3gOGuoVkaXDVljPUp5gGs8/89yaHvWZPuHYqxCuyHc=;
 b=glkIkH7hkUZD3LhdNvLnMdlGuA5hCoHVFGDhp2YBdQElaecT0IZ1Pq+9ppqg9fGHoa
 vfXaTePp9WARc1oG2lrofxrkKnSLjp42Vgai5QxR/oviKLSex5ZwExm7tZ3jx6U4Gp2X
 WA/it6Vit9Y5a054S4pbfqHoOr9FRhBFXUNiJe3oPxZASruLPlNcUF67UZdwfu1DCIb2
 GzJCir1xZssxxF9kyBlcfDp3WMn2JqCB20mGhCqHXBsUKxzL9hjP1fnHzneglFiWyepr
 ElMGiqULB8ZLk6eaclYWLPsUy/YMZn8wvXO1H8YBanRsLVsihHc9J4+q0Nb2M5SWgeEj
 WdjQ==
X-Gm-Message-State: AOJu0Yw5SXFS1caVEqkbz1YzZ4w5ezUbVD4TZYEYghYqmdaNGm8TIIKX
 jU1AI4w6ODGVhghjWhudcjN286tywAbgeWsuh2wiRQJD8nSYa8zWv7ZVxzQs7NKy
X-Gm-Gg: ASbGncukUMEFw/Ab+48c1gYQWdAwNU71kKuaf3kNdFsL8pp60mMd5/Vt93LB1c1JVYf
 x/24vAYDc6Ej5IBRg87hEqgWi3/KowZAA7Y0DN2scu4Co+KU0gJKZzJoii8k86lwBSD1mOFuuIr
 iYu7Xkv8HZqH/K/zcnRNWTL3dVT3nqlakCL8E5Sc+kHcQ1jCGRJ+6vUEz68Hb4vg+K53s+fPUSI
 qFcTpy7mXlh6Mi+03JrnetxY8+mvX0iC5QE0W9gsCPsqtoxwRnSIHTXbZnv9K5dD8w33Oa0aNd6
 qsdjtgbRztR0kogUZJCKWeCtJ1E/Jil8w3MntBjeB+2jSyec6iUGMcv8x9i/BKUP9FKcScZm1sE
 =
X-Google-Smtp-Source: AGHT+IHfGs00pcqHOjlOgMq7jGghYx3dBEktbkLwCm+Aif0BrO7Mr6aj5fHgL+dLCuUvVBXAbwTH0Q==
X-Received: by 2002:a17:907:c811:b0:ae6:c158:15cc with SMTP id
 a640c23a62f3a-ae6c1582909mr61333766b.53.1751988309588; 
 Tue, 08 Jul 2025 08:25:09 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.cern.ch. [2001:1458:202:99::100:4b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f66d931csm921950666b.10.2025.07.08.08.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 08:25:09 -0700 (PDT)
From: vtpieter@gmail.com
To: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH v5 5/6] drivers: fpga: fix function declaration without a
 prototype
Date: Tue,  8 Jul 2025 17:24:50 +0200
Message-ID: <20250708152455.1214487-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708152455.1214487-1-vtpieter@gmail.com>
References: <20250708152455.1214487-1-vtpieter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Jul 2025 17:29:30 +0200
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

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

As reported by clang 20.1, fix multiple of the following:
 drivers/fpga/ivm_core.c:593:23: error: a function declaration without
 a prototype is deprecated in all versions of C
 [-Werror,-Wstrict-prototypes]
  593 | long int ispVMDataSize()
      |                       ^
      |                        void

Also fix the following warning from checkpatch.pl:
 WARNING: Prefer 'long' over 'long int' as the int is unnecessary

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/fpga/ivm_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/ivm_core.c b/drivers/fpga/ivm_core.c
index 4ab5dab250a..37d5c5ec9ec 100644
--- a/drivers/fpga/ivm_core.c
+++ b/drivers/fpga/ivm_core.c
@@ -292,7 +292,7 @@ unsigned short g_usLVDSPairCount;
  */
 
 static signed char ispVMDataCode(void);
-static long int ispVMDataSize(void);
+static long ispVMDataSize(void);
 static void ispVMData(unsigned char *Data);
 static signed char ispVMShift(signed char Code);
 static signed char ispVMAmble(signed char Code);
@@ -590,7 +590,7 @@ void ispVMFreeMem(void)
  *
  */
 
-long int ispVMDataSize()
+long ispVMDataSize(void)
 {
 	/* 09/11/07 NN added local variables initialization */
 	long int iSize           = 0;
@@ -615,7 +615,7 @@ long int ispVMDataSize()
  *
  */
 
-signed char ispVMCode()
+signed char ispVMCode(void)
 {
 	/* 09/11/07 NN added local variables initialization */
 	unsigned short iRepeatSize = 0;
@@ -1114,7 +1114,7 @@ signed char ispVMCode()
  *
  */
 
-signed char ispVMDataCode()
+signed char ispVMDataCode(void)
 {
 	/* 09/11/07 NN added local variables initialization */
 	signed char cDataByte    = 0;
@@ -2476,7 +2476,7 @@ void ispVMStateMachine(signed char cNextJTAGState)
  *
  */
 
-void ispVMStart()
+void ispVMStart(void)
 {
 #ifdef DEBUG
 	printf("// ISPVM EMBEDDED ADDED\n");
@@ -2505,7 +2505,7 @@ void ispVMStart()
  *
  */
 
-void ispVMEnd()
+void ispVMEnd(void)
 {
 #ifdef DEBUG
 	printf("// ISPVM EMBEDDED ADDED\n");
-- 
2.48.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDBCC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E22E82EC6;
	Tue,  1 Jul 2025 20:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="in2zUD1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFE582EA9; Tue,  1 Jul 2025 20:43:02 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7BA8300B
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-404e580bf09so855041b6e.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395378; x=1752000178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XAHfMwwz2Qwk5gD+zM4Pc7l01w5nRjFf2BpNtW5hJyc=;
 b=in2zUD1Fw309JRYubQG6R3edxCpP320ckt+4QHcUp0OC2PkyxhLfRvFqVk+5XcGj7Y
 XabJ3yVa6tohMkX8XXZu1eMNuc+egoEDtQuHvR4tESCuEet3ubW/vKIyBzWjBtdh8XFN
 8s83NaMA3dBkbNeE4ezt2A0gDU9QziEmqsADw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395378; x=1752000178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XAHfMwwz2Qwk5gD+zM4Pc7l01w5nRjFf2BpNtW5hJyc=;
 b=OSywk2Nq2jSZrJaCpWzyZMU2f+ZC9azJ1ZeWCknVYuSTsuZdpQEnyckrxci57q/OIS
 f9yk1NhDp8QkCzSN4cYfBOxvWNdmXNrk7sEm1lACpIVm7454MPV3JZWLmVeU+YcHi96r
 Oh8GM5olusgFJ4SJ4OaGaV7Gu94E10H4XJ0JQ5kSUNCts9pfT57AMK966/Qizof1cFOy
 vCujAZd5gXfV/Er9JLGyjnX4eof3fE7n0YHvSRwSHitDpmLi2IijXTwVQyb3FSoYwU/X
 DeoSJaWma0uh4a19zKNI0xvLf9fZ0mhzxvolE+7yQGn2ZYfryLk+H/SPsnIppvlc6gQe
 /8Cw==
X-Gm-Message-State: AOJu0Yyd1/AhEvxw0dG+FDy40+YsY5aTDUR3/r6L/SdyRARatbh2hSAA
 gshlhuzhQdP5JMnUy0+E1AP2vRdlITHkSLfcH2qKC/9aQpAPERVy3MppcTg9gLJXnAs+w+axNNN
 /aTXWMfE=
X-Gm-Gg: ASbGncvW3GgZkOBk2+DmzGYKR8tSvHvFengfG+cY9NHbMukQpnA+iwjfXwUJ1dyWQlD
 8GgBS+qY3uy5c7Uvo9XMcg6L8vwoQB2jT4M3w7uxO9i1LKVDs9hAzAkcv8jLRrQq3O9YvUy5+gM
 /aNXFhpZLOMGbi6HUZAp7A0TgKxqb+h7Yk/GLHwFjbp9HDxulsEm1eDSoN6Yb2HgUXsGVCFsJnB
 ipZf3fmZonT7CXlj49zqUbhc2+YGEQcMarQXbURGvQ5NSJZOXVFqonSzKGukprSsklPKiGwRN0o
 M9IzgWcSbZkAVa9QUXR/zKN/RkxoVSgiOeZkUfP7d3/ejxUHP3UUd3mwa1MG/VpIOqP/A12FPID
 jGNvPb84RoQ1ldIvxBqBqor3fDA==
X-Google-Smtp-Source: AGHT+IG7asilqv7i2cr9VY9JphnAy7JHYjVPkoWKKf2HornsWh4cnVVjM6wsWrtlBBRHVqsrM0zrpw==
X-Received: by 2002:a05:6808:3089:b0:40a:5356:6581 with SMTP id
 5614622812f47-40b33c29d91mr16204534b6e.2.1751395378558; 
 Tue, 01 Jul 2025 11:42:58 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32420c83sm2234513b6e.36.2025.07.01.11.42.57
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:42:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Add some missing {clr,set,clrset}bits variants
Date: Tue,  1 Jul 2025 12:42:57 -0600
Message-ID: <20250701184257.3191508-1-trini@konsulko.com>
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

Add the 16, 32 and 64bit versions of the non-endian {clr,set,clrset}bits
macros.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/io.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index f656f361cd52..6e3f9547fee7 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -74,7 +74,14 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define in_be32(a)	in_arch(l,be32,a)
 #define in_be16(a)	in_arch(w,be16,a)
 
+#define out_64(a,v)	writeq(v,a)
+#define out_32(a,v)	writel(v,a)
+#define out_16(a,v)	writew(v,a)
 #define out_8(a,v)	writeb(v,a)
+
+#define in_64(a)	readq(a)
+#define in_32(a)	readl(a)
+#define in_16(a)	readw(a)
 #define in_8(a)		readb(a)
 
 #define clrbits(type, addr, clear) \
@@ -106,6 +113,18 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define setbits_8(addr, set) setbits(8, addr, set)
 #define clrsetbits_8(addr, clear, set) clrsetbits(8, addr, clear, set)
 
+#define clrbits_16(addr, clear) clrbits(16, addr, clear)
+#define setbits_16(addr, set) setbits(16, addr, set)
+#define clrsetbits_16(addr, clear, set) clrsetbits(16, addr, clear, set)
+
+#define clrbits_32(addr, clear) clrbits(32, addr, clear)
+#define setbits_32(addr, set) setbits(32, addr, set)
+#define clrsetbits_32(addr, clear, set) clrsetbits(32, addr, clear, set)
+
+#define clrbits_64(addr, clear) clrbits(64, addr, clear)
+#define setbits_64(addr, set) setbits(64, addr, set)
+#define clrsetbits_64(addr, clear, set) clrsetbits(64, addr, clear, set)
+
 /* I/O access functions */
 int _inl(unsigned int addr);
 int _inw(unsigned int addr);
-- 
2.43.0


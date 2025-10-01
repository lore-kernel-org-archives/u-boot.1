Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C23ACCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CAD6835CB;
	Wed,  1 Oct 2025 22:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sYu7J0DY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF9C835B0; Wed,  1 Oct 2025 22:30:41 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96EC5835B0
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-30ccec928f6so144228fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350637; x=1759955437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=eigfywbsjv7V8zDXlrWKAiMRu8fjZX4YIuz990JOMZ0=;
 b=sYu7J0DYSpXuqLI3yPwtLiR74X3AVzLXG+EkmrMyKClGSZrd4vulhLaAtY242PN6WN
 O4aGFwhAau7DPEE9GXUYLi/1gfDDlJizBqCVSwxZNjKdSmssTZ1X0c3VXVlB7igM1oO4
 27r31Q0rQr4fhwCbD0ETqLGAqTZtCxyxe3FSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350637; x=1759955437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eigfywbsjv7V8zDXlrWKAiMRu8fjZX4YIuz990JOMZ0=;
 b=rLOEDubNVvnaQKftjCqpkZRNwu3LshKkvfa4NPFLWfVEqOPcdgcOhmukUDRE5/vNfk
 YRd8WsPA83Dmby+2Oh5d1r+3FplQFxG+mUq9s+MCuXzyqWCufG4Y4sFmIkwLOubml0U7
 d5zkHhwlg3DYPvhKGIWi7JY4ngNRySlcnm415YshCveoGu4reasZwEWGBldhmzlCerLI
 l6tDojxl9ede8wKlcdyBLRBw2a7zLvSOiy3acuWoLY6lXrv2Ev77C6EykmjADkU5VjiG
 AhQEM7m5SX8j10yHyZotHUqMDkT42a9W5Sh12Qz0EeWxVY0SbU5aqD701oMNuWbQJ86e
 Qnig==
X-Gm-Message-State: AOJu0Ywyv439edgkhtAQai2Vl2F5mH9maW3NJqdO28C2Mzz6AXj9013U
 QWS3nUKwoUzcQoKBoqR6YaaYULt3o+3XZf615mhR76JZf0Jd35dQpA1hVVwX7NRQH5aI7XCsZK+
 UP++u2qE=
X-Gm-Gg: ASbGncsZ93b68ygSL1iiSsFVrJEAYB4tajn1wnX3TmKrkxIvsK5v62hVYDMpu5xajWc
 DtsAmNzL1qRdIiraotWdPjjB6nDKDEGV3jtWTgeKIIQaj0zGdNIxk3t7hzqFuUgnQ4fKyUjzyC6
 ed0wUl+XYUmQFTpDtLZVUUiNQhDDa+QkdRaCcsFnenCtW6YR9LnwG2oA8vVs5w98ebYTwV98mxi
 aEhE1O4EinrZGLv1BCs+slIq0iEhHIWoGsAKG2Hh3uRHBtatzfiJp2t+krcndkeGGSsRQHhjQlK
 30ufzLr0g0vHgaK/VWm7iKRpbTVsBxpA4rhgs5g5iHwGWIRh86z0atRaPh+JwLD63u7OS0hTUBH
 0gT39JMuNe42ggYT2Ejdz93nQjnoNpptX/4DhEcWDpyxYCLC2rmgE5ddHd5HEslhQ4jCNzIkhKn
 hYLAG01wXrhsxmBSoRnQ==
X-Google-Smtp-Source: AGHT+IGoluuLQ8CH5QkU3XphQC7XFkU1p68Yu+dnz7VcOVhrM5m7liJxDNmesx4mg5OgrU+gXyndFA==
X-Received: by 2002:a05:6871:5825:b0:348:5d07:211e with SMTP id
 586e51a60fabf-39bb8449e2cmr3077799fac.44.1759350637333; 
 Wed, 01 Oct 2025 13:30:37 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab913db079sm215417fac.20.2025.10.01.13.30.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Rework readX/writeX macros to be more like ARM
Date: Wed,  1 Oct 2025 14:30:35 -0600
Message-ID: <20251001203035.2828243-1-trini@konsulko.com>
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

The way that the current readX/writeX macros are implemented on sandbox
means that when IO_TRACE is not enabled some code will throw up
incorrect warnings due to how sandbox_{read,write} is implemented. We
instead need to do the "uX __v; __v = sandbox..(..v); __v;" trick that
ARM does.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index cd3f5d6fd401..e3034b9c7032 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -44,17 +44,17 @@ phys_addr_t map_to_sysmem(const void *ptr);
 unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size);
 void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 
-#define readb(addr) sandbox_read((const void *)addr, SB_SIZE_8)
-#define readw(addr) sandbox_read((const void *)addr, SB_SIZE_16)
-#define readl(addr) sandbox_read((const void *)addr, SB_SIZE_32)
+#define readb(addr) ({ u8 __v = sandbox_read((const void *)addr, SB_SIZE_8); __v; })
+#define readw(addr) ({ u16 __v = sandbox_read((const void *)addr, SB_SIZE_16); __v; })
+#define readl(addr) ({ u32 __v = sandbox_read((const void *)addr, SB_SIZE_32); __v; })
 #ifdef CONFIG_64BIT
-#define readq(addr) sandbox_read((const void *)addr, SB_SIZE_64)
+#define readq(addr) ({ u64 __v = sandbox_read((const void *)addr, SB_SIZE_64); __v; })
 #endif
-#define writeb(v, addr) sandbox_write((void *)addr, v, SB_SIZE_8)
-#define writew(v, addr) sandbox_write((void *)addr, v, SB_SIZE_16)
-#define writel(v, addr) sandbox_write((void *)addr, v, SB_SIZE_32)
+#define writeb(v, addr) ({ u8 __v = v; sandbox_write((void *)addr, __v, SB_SIZE_8); __v; })
+#define writew(v, addr) ({ u16 __v = v; sandbox_write((void *)addr, __v, SB_SIZE_16); __v; })
+#define writel(v, addr) ({ u32 __v = v; sandbox_write((void *)addr, __v, SB_SIZE_32); __v; })
 #ifdef CONFIG_64BIT
-#define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
+#define writeq(v, addr) ({ u64 __v = v; sandbox_write((void *)addr, __v, SB_SIZE_64); __v; })
 #endif
 
 #define readb_relaxed			readb
-- 
2.43.0


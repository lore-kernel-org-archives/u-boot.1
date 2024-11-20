Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A63D44171
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC50C89673;
	Wed, 20 Nov 2024 11:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iy6k2tac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0720F8966E; Wed, 20 Nov 2024 11:02:36 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 560C98968C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso16164425e9.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096952; x=1732701752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kocb6slSXHHclKNWB/UXW6eV5o3UraK40/Ny6RKtJ0o=;
 b=iy6k2tacfzdyOysMHIKLf5DCyPd0bHDo+EbKkIGyDzlruEWSM+GMqiqVkQeKs/H4Pw
 x37R2rtrAr5TnnTFY3y15clmNKGq9hMtIxTIT3/BOGLLHFTdWb4G/rqZtPRgvaTZYWGy
 9crkC7UbRrZPZFCqmeQY2UBK96ztBPCzm+jCGGWI83IdDzVOeeg7dsFNixckfVOzOMjN
 6RY3J2vx7LEXN9CSsbdq03mfsZPZHt6PLVU5dfIfoPbs7ml8ezo9w89ulBBoKWnaNZws
 qnGmVidIIWV5do5ut507IO1bu+Zi+hIvUoThuQBBmDRU2Hv73SnWXM2X/GZyOb6wo9WN
 wBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096952; x=1732701752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kocb6slSXHHclKNWB/UXW6eV5o3UraK40/Ny6RKtJ0o=;
 b=PyERJE51Iyn5W1cLqnuAmHAt8VciJhZbx3ffKLQKBrSbffEiOQy3OoNeX9NropMj7f
 Q1NUjMrOiWIe1L30Lcwij+BZqvM4HPjMJX0NA1v0mzhwQxH5qTRiVeOUPiQT+7H6zOEJ
 yCB/Oft4vIHE+7HT1+iACvFddnAoUompPEUAXT0eNsrsDjoalmopKPqhK26H/NWRP8P8
 ckLIQbqi16ce8B3IgWzsNraN4XstQndrDnEWpXBiBem5ogVE7TCVOK+/ODc5BvfJXeOF
 WD7X906xqFdanFBJPywVQQ3Uj+qPlTXPwSBRyKAn0irlqgqe00dn8Tnw/DGP16P8nbag
 /t/g==
X-Gm-Message-State: AOJu0YzOgnQ+CnZI5S6TR7eLWw2BwBCqMz9CrkeUourhzNOuJJ08uBYH
 KWxpfNumn9WvccOP5ONgOZ8sB98kv5BuWarSqu/GqFCuOrDIDB2wChkck5eK4afEZnyFMe584dN
 24+Xu7g==
X-Google-Smtp-Source: AGHT+IFiUS9iFI4an1cN3rfkdEgu4d9fimei85q81PcMJRpHHj1nsvb1qLuO3fWRfeKStfh5Y1OXiw==
X-Received: by 2002:a05:600d:1b:b0:42f:7c9e:1f96 with SMTP id
 5b1f17b1804b1-433a4caad70mr11606545e9.1.1732096951820; 
 Wed, 20 Nov 2024 02:02:31 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45fa706sm13572655e9.16.2024.11.20.02.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 02:02:31 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/4] sandbox: Correct guard around readq/writeq
Date: Wed, 20 Nov 2024 10:01:54 +0000
Message-Id: <20241120100157.485418-2-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120100157.485418-1-andrew.goodbody@linaro.org>
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
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

In include/linux/io.h the declarations of ioread64 and iowrite64
which make use of readq/writeq are guarded with CONFIG_64BIT so
guard the sandbox declarations of readq and writeq also with
CONFIG_64BIT.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v3:
This is a new patch in the series at this point.

 arch/sandbox/include/asm/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/include/asm/io.h b/arch/sandbox/include/asm/io.h
index 3d09170063..f656f361cd 100644
--- a/arch/sandbox/include/asm/io.h
+++ b/arch/sandbox/include/asm/io.h
@@ -39,13 +39,13 @@ void sandbox_write(void *addr, unsigned int val, enum sandboxio_size_t size);
 #define readb(addr) sandbox_read((const void *)addr, SB_SIZE_8)
 #define readw(addr) sandbox_read((const void *)addr, SB_SIZE_16)
 #define readl(addr) sandbox_read((const void *)addr, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_64BIT
 #define readq(addr) sandbox_read((const void *)addr, SB_SIZE_64)
 #endif
 #define writeb(v, addr) sandbox_write((void *)addr, v, SB_SIZE_8)
 #define writew(v, addr) sandbox_write((void *)addr, v, SB_SIZE_16)
 #define writel(v, addr) sandbox_write((void *)addr, v, SB_SIZE_32)
-#ifdef CONFIG_SANDBOX64
+#ifdef CONFIG_64BIT
 #define writeq(v, addr) sandbox_write((void *)addr, v, SB_SIZE_64)
 #endif
 
-- 
2.39.5


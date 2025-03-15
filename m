Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29DBC35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FB4812D9;
	Sat, 15 Mar 2025 23:18:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EPWJuslr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB066812D9; Sat, 15 Mar 2025 23:18:24 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35FC80F4C
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fd89d036so64422465ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077101; x=1742681901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5pajEj7L8VOs5I0MNxExeq9eMU+8YlTLkvNuuFod4Tw=;
 b=EPWJuslrWhfL/IJ0zcgsjqtsRQBCIFCn+reQ6lvQqDU8QP8+OmgT5YxPpichofuLcO
 QhWzzIeTtiGoVvCTagCgCuwwLvpb9r2lACmpuPESi4Hgk/lJ7dMqaY26O5Ae+LMTt8r4
 AK/hwfS0HMbTC7fmPHuWDb8Eo7rNJGXJzYHTQJ66QMbL/FMGDoriPFXC6+KSzDYj/FsH
 Hx+R7hHKo8Ii7BbD5JwZUzSJ/y2Fj4lDUe2X0DNRcbKYN6VszpXuvLzxV5IpoLY3Gsy3
 HL89loNSnZCl/hugNz3E/o02NJLw1Vl39QQm/f7ZnpvBzg7VbfWvs2CcnwVRu8HhGwLC
 xohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077101; x=1742681901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pajEj7L8VOs5I0MNxExeq9eMU+8YlTLkvNuuFod4Tw=;
 b=O+AhiwQkET41pPp7Pm6pw4rVbWG3I52r9ewU077XkX2Ew44KS2qBZK66GRau3Pi+u/
 8qA8DaKLxDg64j1KgE3p+IW6UJybAbsc8TqelAEGJb7ge1mLAamDAm87gcHAdABxN1ka
 0NHx0+pC4UAKImoFsq6C/8zZj2VmV031dx9j0nwTF6ISaA8x2cXFyDN+2rG6MdMzA8SY
 6eAiHBSF1yiPJd0sbKkzPbZ26/tFA1f0aGmsVnkZoyQmI4TNnIkyf4u0FCyFJFxX/UiD
 ta1kodx3I6q2tvRtDGPtViDIr71QXPx0BOEFIC3wG0ttCADkfqTWllBbXI5j8jFfiZwZ
 0RVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1NFZa5/Ou41/6PyC0ep2ZyU9S2XJZ9G9Myum5IbHYEUBsYKT+xZD7mFGyZ97opSKwq08clNQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyPDKFZ3eA5CjXQpZ7F4jEvlm1+a8h+muTUt7fEZKOP8JToxZqB
 OM84HRv6VKe7A4nuXUv0r4dQwrFRV/P70kjd0E+TJwfYDmIlzBq6ggm2NrH6aP4=
X-Gm-Gg: ASbGncuc5Y1oKWiggtoBWeB1BMNnLihKabXINK66OGdSF0j2lLXNDYSbnHrND4p4drr
 TQs8e31vqRzC1aIZOjgFp4rvcRgmNgzxFwFyi0xqV5lNOa04DGl6fTjpqvhZ6SpaWCISUmBQWHV
 R2nZ7ZrXb2KPgVGhAArN18swhcjxPPo0tdR4h4t8quJ3WpCciEXClXNfQpRz85aWP/HEDWFEorx
 zPyJ4yBqRQBFnbVwSvJQ12eYlkeBLGcqPHrqvlIp5chVmJiBR7Eus1vMbqDUALg9hrltsAHjf1o
 sfXyjzzgRFcU+XPzdjnC8VeoMLGqIXeFqdXVg+65aNMUwBb8/p+MALo=
X-Google-Smtp-Source: AGHT+IHfnFB7tXgT4w+Lk3WYebmM8gLgcmdhyZ177hTmj1bJYixXGgVs5Beice9YIIZFQfKmcUabzw==
X-Received: by 2002:a17:902:e5c2:b0:216:6901:d588 with SMTP id
 d9443c01a7336-225e0a5fe4amr98224925ad.15.1742077101221; 
 Sat, 15 Mar 2025 15:18:21 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:20 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 03/15] arm: Add __aeabi_memclr in eabi_compat
Date: Sat, 15 Mar 2025 15:18:01 -0700
Message-ID: <20250315221813.1265193-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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

LLVM's code generator will sometimes emit calls to __aeabi_memclr. Add an
implementation of this for LLVM compatibility.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/eabi_compat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
index 602efe04c04..e4190c049a3 100644
--- a/arch/arm/lib/eabi_compat.c
+++ b/arch/arm/lib/eabi_compat.c
@@ -37,3 +37,8 @@ void __aeabi_memset(void *dest, size_t n, int c)
 {
 	(void) memset(dest, c, n);
 }
+
+void __aeabi_memclr(void *dest, size_t n)
+{
+	(void) memset(dest, 0, n);
+}
-- 
2.48.1


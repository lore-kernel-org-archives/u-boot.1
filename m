Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385F6C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7BF80F64;
	Sun, 16 Feb 2025 21:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmFVYdzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D90480F96; Sun, 16 Feb 2025 21:45:20 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA8D80FB4
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d193fc345aso8595775ab.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738715; x=1740343515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=nmFVYdzcldDtW9BwtXIbpkW3n+N+VtDAcAxYLx0XIoA901X+BJo3irIEZT/aT1e2iA
 53a6Dkp8+mG43W4nKP7tN2Pe+OfVq8nZNbEU+rYQCaPwPOwpZe4irZ6Uz79SWGbuJStl
 mz72wcjqU3KF8Z1N04jQ13twhnG8zFFSHiDR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738715; x=1740343515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OHbEsnHwRxX59csm80YE2M40ZbkK24iC/vPmoTrBDE=;
 b=fAPHO2jCI4dyvvZZFbia6eJfT8L4PwArDocoi+jNsVK6nsvaXUofSP5TxEtG7NIa/n
 nGI+XpoUikiLJmBKenjYuLbD22UFvQC0X6ghoN3Y2Se4o0whRRDKZSt7ihWrkLY91zHU
 NzQgYa4/dpUMchDD6KlsU9Fhx6EFcbBhotNpmd8ntF+Xm+KKx90PkZFsRvuncq0C0UcH
 gvs0xUHDLYG64LcQYV62+MSDRR8ZImkQYDQzWQ6+/pxjGcZzHNqdFVB/8/x+GfjFuWWW
 B6YQ/sashQK994ySJAJyy7d06pIMvb0395dddBXAj4ahSUJ9IZW/rnIT2TBpytvLzkbY
 vavQ==
X-Gm-Message-State: AOJu0YzU6737UxprKs00WG0j75+X6c0Qat2Mi0AhIY6BgmAbga9BjjAw
 O9fI3kA5zYCOmVC1r4MrvLwWf48xVvcsxag0nNJolG6VquZOwvY2YizukQX9edWF98g8BTPk6hQ
 =
X-Gm-Gg: ASbGncuFlerhbnie+fJhW351exkpulCjMe4PQD1rNQVdeYVoI6J/nM7jpXlNY+F9Pif
 v9V94B2os7d5fW6znBTNjPu3b7QWLhPknXhAr32c+Rt2UEYh/vpX+YvDWsxKq0TlrPgxgkfsgLl
 7tVV/ujQ63+qqA99Tg20Igc9M0vmhWPvJ/B7Fh56Eeh30QUaS4+Z2HxKe+eFSUt3mNOl2/4Ctuy
 Vaxjtqomjrb2vt2C8N8YIGGh5wzbf2eNWIbcsUmUnKZwC7RBqDjfzGtu9yeJiV/fqPcT0sxTMPC
 flFSrfNI+F11sIPUB2mfthF0YUoAM8mp9PiJEInOCV3MSPh7XHJM
X-Google-Smtp-Source: AGHT+IFYwQSLbuKyEq9yE38ho/hhx6iv0TzDmblug/lbQ/XeEAzy2pGixjJUAhKaGqNxHOBwKlo8KA==
X-Received: by 2002:a05:6e02:3206:b0:3cf:ae67:4115 with SMTP id
 e9e14a558f8ab-3d2807bc8aamr61101635ab.8.1739738714792; 
 Sun, 16 Feb 2025 12:45:14 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/28] x86: spl: Drop duplicate CPU init
Date: Sun, 16 Feb 2025 13:43:56 -0700
Message-ID: <20250216204421.3560012-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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


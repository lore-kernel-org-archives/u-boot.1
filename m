Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C11C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31FE3839DE;
	Wed, 28 May 2025 10:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="COmERvfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574F2839F1; Wed, 28 May 2025 10:26:33 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 409E8839DD
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-861d7a09c88so87364839f.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420789; x=1749025589; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2epqPWxPwBLSpTQ7bm6Wr0M5xlkgDdD3Dggy2D5UU+k=;
 b=COmERvfVJh/fsC+RkfOZym+zXYrjHTugE4iQxthyq/F0NE04feMgY0aq2he7CyXqRn
 c5LKfsIXSg09E3l7LrrOlEmCfItAzUnFp8pqaDMXyYr7XObsUsiFZjAbQ8omggkRUye9
 M9yDXa4Ax1yDGvxVGcnG8X5ZMM7HV40wcQxRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420789; x=1749025589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2epqPWxPwBLSpTQ7bm6Wr0M5xlkgDdD3Dggy2D5UU+k=;
 b=FF6/j6URowCNlSawpINxT6OURlsimWXkuaP4teZdr/gDG08EXrsylm1Yf0jwOTF0Nx
 zgK47m8+BDMYOedxUPBHo+XjpL4yr9ObYWCiqhdDPuuJonsXD0/9K2pzSl5lPlNN651e
 x7saAh8iGRE4PicYZdIBDIekI6biDXJT8zBGuPntxD5S0XHDOIhXkMVJn+pJqiv0Cquq
 uzpjFQ6W7vqMTp3n6koeThHO0lrVI7a6dzFcAZCeb4GSjGbYDZJ+R06K7PZLb+4SEoA0
 5tBY113ZtzjoGXcTOapxeg3H2hndylVG4Z4f8uQa3BmIGhiW4Kv1GS0qj8hNamlC4lF4
 SVXA==
X-Gm-Message-State: AOJu0Yz/x+VMvoDPEnlFv6bqyRdzfPy0z4S/OQDCJ0i+J+BSMcWgHyaC
 LSWBa8LmXAV1N3uFTGzPunpq8Ml07nT2hN565Esh66IMYvpT+jHskjP4VjUlss7xdC56s1nX8L6
 l27gzHWEQ
X-Gm-Gg: ASbGncvOroBeJ3jny+1zIY045zMPeMRH454ZC3jahnExglMjJvNn1D34hinhZFXYhrs
 L6jGoip6mXZ8ga98ErT8gtorLifhrZ6yewYtmUB6ZLPvDKA+YEAx7rJWZyz6Ib2dsdT0zvRiLJK
 g4ov0VqNzWzH6pwyZ6qtpy4CdKtETSSQLEfZ9PsYcWBSCb71pAz/bUIifDb5a4NL56eLU/F5YUs
 xvPGkq1xqIkTyTIcfl2denUsNp5xTToppsIowupu5fdxXVMBcHPSZI+6CJkh63GWyaArEK7RWqd
 me6u1h6SRmySyXj6klPzVbL6V19TcjHFY6/L+OQB8jJ3nCbPsNNzglacoQBqN+i44RHoaR+Ad0Z
 9ymVB8ehC48x4
X-Google-Smtp-Source: AGHT+IGP0tcvPm3rspQngx5cdP4pWMFZrAmz2rdy6QkaxK5kC0JnR0xfKLUqdVU3FBswfSYiQtnxKw==
X-Received: by 2002:a05:6e02:1a4d:b0:3dc:8b29:30bc with SMTP id
 e9e14a558f8ab-3dc9b7739d3mr182747955ab.21.1748420789409; 
 Wed, 28 May 2025 01:26:29 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/27] x86: efi: Add a few dummy functions
Date: Wed, 28 May 2025 02:24:47 -0600
Message-ID: <20250528082520.152391-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Although GD_FLG_SKIP_RELOC is enabled for the app, the code for
relocation is still present in the image. Add a few dummy functions
needed on x86.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_client/efi_app.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/efi_client/efi_app.c b/lib/efi_client/efi_app.c
index 1aa43b511b3..60834202088 100644
--- a/lib/efi_client/efi_app.c
+++ b/lib/efi_client/efi_app.c
@@ -31,6 +31,16 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+int copy_uboot_to_ram(void)
+{
+	return 0;
+}
+
+int do_elf_reloc_fixups(void)
+{
+	return 0;
+}
+
 int efi_init_obj_list(void)
 {
 	return EFI_SUCCESS;
-- 
2.43.0


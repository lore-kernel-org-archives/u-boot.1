Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDD4C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2439A80FB9;
	Sun, 26 Jan 2025 19:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nE06Kaix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A22B80FF9; Sun, 26 Jan 2025 19:44:12 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD1C80FA8
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-84a1ce51187so99295139f.1
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917047; x=1738521847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XiNX0STw6l/CgSs9uXfRPIjrCrj+9H3/XZgVcDv+1QQ=;
 b=nE06Kaix3K/r3ngaK2D37HsQvZkPuyQ0+3/1883dl8yDXwsaMb8y6wqW6I4uoboNTx
 ayk2ZyOV9vBttijoQUkBJHfr5Devtefs2dSkYPTPgwz8HxoKTysNmjpA4/SL14UUZNuI
 DLUfAuCDgqmHATrnr/Deyxj8ILB4NeSKTcf7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917047; x=1738521847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XiNX0STw6l/CgSs9uXfRPIjrCrj+9H3/XZgVcDv+1QQ=;
 b=SeMCYKG6G0obMZienU9GaZ8s2aGzBU0KoVfWa8qFkhohrSA8CS9huJ9acn6BNkveVr
 vMk2QbiZ8XmYwRgNeIwWNBEwKr3D3LNPgNWyQGPFL8tht8K2n+/DsaqvEHZBXCEdTBR8
 OrdSIb1Imtr9fGfmdL94T/NIzLravP3RELVJETlX7733uBwH/FLzU03RBeexFbrEuAbz
 ZQPkkASLv0OVLB6lBDDrKodcgEmnMAqInMKOhm4MujPPoPUzuwfOk674ekee1/69eNaB
 qN+CE99CfYSYo6+uyxS5nL1+gmj1qMobiIV+MTTu8NeXTb+uq8Mf2YIK9O/nwaXhVtKu
 JtKQ==
X-Gm-Message-State: AOJu0Yx6xmg7Qv0Ru1vVwopl69RJmGORME9OJpAS2KcSllIvMWDTzLR8
 o7v2wGdvybrroQW43nFevX4/AzMoZK0GpXsx8f+Z4h3afL13Na1WWb9uRGE4RWcYHVQqMUuHDe4
 =
X-Gm-Gg: ASbGncvDEio9Z07wyLIIlR+7vWFli045u/LjzxPUPxMN/6J9z/F3WvXNf1mnnVOXrbH
 d8jwWUD+DaIN/RUNbzxxE/dXp+a8t+F6WqNWyHbE9CNBZzbf8fcJcOh2GyOKoi2Q1wNWxccdxUk
 VngGsqkNNuxh0xCUf4bOUCQOyeYPtdYKS00ysfq1lP6sbxh6t7QEYogC4KoQlV7wMZ4VL4cZa55
 qTdxCk8sTueTbHDjpvWAzE0DuV5lBve279j1/mrNuQnvsVT3/7SXpnwVwKhEx0mN33KaN6+AmAT
 +8o3UdEnBcZT2ZmVt1Ly2o9x10K5jESS3Aq5UI969u2nAM028Efh
X-Google-Smtp-Source: AGHT+IHrgRmqzOG/qlNyrzzzCBT36NuzcjVECU5BCXl+iKpTwO9l7gUW8EKzfTQMe+z72T+44Nc0iw==
X-Received: by 2002:a05:6602:6c11:b0:837:7f1a:40af with SMTP id
 ca18e2360f4ac-851b6522d65mr3070133639f.14.1737917047399; 
 Sun, 26 Jan 2025 10:44:07 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/19] spl: Provide a way to mark code needed for relocation
Date: Sun, 26 Jan 2025 11:43:20 -0700
Message-ID: <20250126184333.4058848-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Add a linker symbol which can be used to mark relocation code, so it can
be collected by the linker and copied into a suitable place and executed
when needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/sections.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 5b040d0acd0..90eba30b68d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -67,6 +67,9 @@ extern char __text_start[];
 /* This marks the text region which must be relocated */
 extern char __image_copy_start[], __image_copy_end[];
 
+/* This marks the rcode region used for SPL relocation */
+extern char _rcode_start[], _rcode_end[];
+
 extern char __bss_end[];
 extern char __rel_dyn_start[], __rel_dyn_end[];
 extern char _image_binary_end[];
@@ -78,4 +81,17 @@ extern char __dtb[];
  */
 extern void _start(void);
 
+#ifndef USE_HOSTCC
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+#define __rcode __section(".text.rcode")
+#define __rdata __section(".text.rdata")
+#else
+#define __rcode
+#define __rdata
+#endif
+#else
+#define __rcode
+#define __rdata
+#endif
+
 #endif /* _ASM_GENERIC_SECTIONS_H_ */
-- 
2.43.0


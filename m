Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DEFC28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7915B81B42;
	Sat, 15 Mar 2025 23:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lv1v70Ej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F2381CC5; Sat, 15 Mar 2025 23:18:39 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFDB81A0C
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2239c066347so64839725ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077115; x=1742681915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zC75K261DEwIBnQmAz5hKZ6h2fopWo5Ud/LKAcDIBQI=;
 b=lv1v70Ej1lAv4MYDsXxSRV5SZsJ60vKTumrto4n+jSIBV1pZPen3vGkIrtoEmJxZu3
 a6CmvsmdmSZfvUVnpJiUwHfO/4x4Pnweos9SuIvqRNknrnNXXFGt8teyNUsT+sTFv1D8
 zRSS8EsBH0U/VQUrTndzrocC2GgwFSvsvaeaKbZzbILcSrKoPsAQcObOdJuS67xdkhrL
 3OQ7g4NsxRQ+e9brF4qCFSzUOoTINwJZYRvfCrDIdX9aGtdERpuudeyjPlBfF+4JXmLg
 7b6c8a9/VPDdKxKmQpOzjMDTHR9Z9mCeKwLa64WjCMslLrwD9Lp/p4X/MqN8FT5BD/5K
 bwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077115; x=1742681915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zC75K261DEwIBnQmAz5hKZ6h2fopWo5Ud/LKAcDIBQI=;
 b=uGX8aoZiIt9bUwGR/3G9sabye+IR7YJD1GWxxH/Q7LQ/+KmEpW7RFrMYlMT5qEulDW
 KohEbQbsWG5G8cH9cNdpmdQZn2tM0/RWWeWe47pI3OhNRsNCqGE7fw0ISN3OLLAmTR+r
 TQRzdbUYuwCfd63DkrBJvUp4R5S9hovXoSvqPUSR9zwE3R40U/LIIzGA3J+ikOAvkSgP
 IVDHcZjrkGU3VM3kFqR6ad+ljIBvGFrwL32AqpSwtLkku2VfVAyy4bJgopChQs1/htTI
 nUQDm3k+HQlaGZBtXMRcx/Ag4+uWJrIV4lrdbbaDF5TBVCFsn1vQchSv88d7orQAdtYe
 uLUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq/JnxOHRSM7Uhw/mB7zZB4+XLEquthI6s28w7ovih1eBUovSpHetBVq9358aDfMOn+nq8LEg=@lists.denx.de
X-Gm-Message-State: AOJu0YxHtcH/XDGQok1DemyB5vmcOV6ozTyNleY+Oa+lM7REujYG+lbv
 4kQRFk+vPyrjuT1gsF5OYcqzvLfMBPzxMinxXeIhGFBmYE1URVZe
X-Gm-Gg: ASbGncv3bV9ZCv6/cJTgZffdu3F4uLE3CaLAPPwUpTLrRNcqkn+Rs7dl5D29HHle/gF
 xJzs11gd8NylstNnZTmcAw/Kt/C4MU/fzTS1m8PWGPw+GgbGnxjn0U7fshFcdAxlCVq9Oj5mP/B
 2vf5oPd/Tcoeb38V1YEjEaksbniXGiCCSO/XuG7xHdQDHzQAiiRZHgDw9YMImnqa7diODc2kVLR
 RAQqY1JL/kR5SywF8GJbuW0CxRIpQuOJPq2Pp7Bp04PLLUP0m7R8htfDM83obvDMis/7negvxre
 doXeaHA/6AwLdaD1HQIstBy0W+CLb10YgxjUgQDQ75or9srC8CyVM/A=
X-Google-Smtp-Source: AGHT+IEoTEa5Tw9KMKCjkHm7QWIZeSMPxRbtItWN7h9Bn4nP/jWZ9zI2AdfBsF4V6YuRiv4/hwJR3Q==
X-Received: by 2002:a05:6a21:e8d:b0:1f3:418d:91b5 with SMTP id
 adf61e73a8af0-1f5c11e7130mr11100614637.24.1742077115392; 
 Sat, 15 Mar 2025 15:18:35 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:34 -0700 (PDT)
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
Subject: [PATCH v2 13/15] scripts/Makefile.lib: efi: Preserve the .dynstr
 section as well
Date: Sat, 15 Mar 2025 15:18:11 -0700
Message-ID: <20250315221813.1265193-14-CFSworks@gmail.com>
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

This section is required by .dynamic and llvm-objcopy will exit with a
fatal error if it is not also preserved in the output.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 scripts/Makefile.lib | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 18993435eae..275c308154b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -513,8 +513,8 @@ $(obj)/%_efi.S: $(obj)/%.efi
 	$(call cmd,S_efi)
 
 quiet_cmd_efi_objcopy = OBJCOPY $@
-cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data -j \
-		.dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
+cmd_efi_objcopy = $(OBJCOPY) -j .header -j .text -j .sdata -j .data \
+		-j .dynamic -j .dynstr  -j .dynsym -j .rel* -j .reloc \
 		$(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
 
 $(obj)/%.efi: $(obj)/%_efi.so
-- 
2.48.1


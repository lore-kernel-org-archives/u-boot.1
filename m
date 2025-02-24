Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29540C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51AB80F56;
	Mon, 24 Feb 2025 06:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7nXWH2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06D8810E5; Mon, 24 Feb 2025 06:56:22 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97467805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220e989edb6so107466955ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376579; x=1740981379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYDEzIspAnPgiN7Ub6El7JD+hLDxzc5GQVHreV+d8lc=;
 b=L7nXWH2xE0OEzNgjV2J0v4ndAiKkL5Y9f/mo/F5qx28lIXCbwatpqM8yoHJLTI2LQM
 7uDqxrxQJBCWwdmOLze3FW07Pa1IOcUW0KZoZF12amWmGNL0gCOF7WQZs8bGTkNp6cfs
 rkOkxH3PbQVyMhjvPY4sca8BcbtIDvDhpSaktVYfobyCHVpCFXbgOu0isF6ORsKc72g/
 RCIM6M6tQTdxlYh7uNoK6zd2Fg3m1Qks3ZH7D2DJRWaaQqIVNP3I4WgiRk8a/nO1cAld
 Rp/k60o1iOrAj86Y9E/lmrdAV52BQTQXM63FNp1bvbXGoqED1VXowdEU/DA45jMJSr8v
 cLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376579; x=1740981379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYDEzIspAnPgiN7Ub6El7JD+hLDxzc5GQVHreV+d8lc=;
 b=ZU6p6sRhbtXRiokGWSNpKbY/xgqQ9E06oYdOEfz6ppXhcSAD5lVpOd1tzeKCYTP2RR
 79aRymTG/5a12urlwrsZcDMnRvkhDj3WAsmrQvwRlw3tkvWSLpT4xDtQ+iQHD74BbRDL
 SZLZmXK3n0KL4NU1pT6kPoZfJg9buzi+yGj4mFnCcJF+/tpESkIRTmsnM3pQan5bCD/x
 F68JB4OM4M4N6lqZuFjd7j7cX4t6msEkgZ9QYwhZxjdClM6M2tUBU3X1ncxJyyu4gyLJ
 ErrU/svT+u8MzfB2Nut/9dmqdAeRCBOGV354KFGdq5SDamADmT9MhU9rZtvDzvZNEa1x
 yPpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOnJrUqagEBnVHeMfPgw/NWb5rmltX/4CC/R4paWUMOUjZSV25Fj4GTxm9l/Oy6EqhK55gX4c=@lists.denx.de
X-Gm-Message-State: AOJu0YzuIv2LIaZ1elGiPt6CQgG52DfBraT0MMGjrpC7F04VNumXEa40
 C1hoOIgh8U1gTBDna0tvpGwo2zIDZRjG41FaTGZqQRAhAwuzBngJ
X-Gm-Gg: ASbGncvXSR6BzNoBpT2dHe2cUamCfcA58UtSOLvNkRLx9ZYCR0xXCNiLyJ0Jjc9+Wo+
 tTVmg5uxxM8Y57rP66Gxio8xPiDoX0evikBs8Cwca2USBBNN552OM8OPFQP4xY27f0P3eY16jRk
 lkdaHZJ1CKNUJ7pt3iiHtBoqiFIaLyu1Qn+EMgw06rMb8LoXxwEMGZIdKduXU/81uELmkYgGQ21
 Jc4VadA0Agfw+xgMc2AXqjBS748Kcs33odiuYoXPCVNNbfW3h+YS89Stqkms+NPOhDsmt3ICKFd
 tN4LrhpJEnkGhLLboEjDktmcswJ0U7IIvUlrSA==
X-Google-Smtp-Source: AGHT+IGWoEtRxVWmeOqnVxUjDhJ2e1PT1DqqwNrkUzlYW88OPjOlv6EBdmblUhgHs1RJHiU69yU/gw==
X-Received: by 2002:a05:6a00:98f:b0:730:7d3f:8c79 with SMTP id
 d2e1a72fcca58-73426d6b9e7mr20502630b3a.19.1740376579140; 
 Sun, 23 Feb 2025 21:56:19 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:18 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 15/17] efi_loader: Remove ENTRY(_start) from linker script
Date: Sun, 23 Feb 2025 21:55:22 -0800
Message-ID: <20250224055524.1334929-16-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
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

The EFI apps are built using ELF only as an intermediate "linker output"
format, with the final PE header crafted within the ELF to take effect
after the objcopy conversion to raw binary. As such, we really don't
care what the ELF header indicates as the entry point.

Because nothing that uses this linker script even defines a _start
symbol, this directive has no effect. On GNU ld, it is silently ignored.
On certain linkers (e.g. LLVM lld), a warning is logged. But in any
case, no entry point is set.

Therefore, remove it to silence warnings and avoid confusion.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 lib/efi_loader/elf_efi.ldsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
index 190a88fb69e..dc4d1a3660e 100644
--- a/lib/efi_loader/elf_efi.ldsi
+++ b/lib/efi_loader/elf_efi.ldsi
@@ -10,7 +10,6 @@ PHDRS
 	data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
 }
 
-ENTRY(_start)
 SECTIONS
 {
 	.text 0x0 : {
-- 
2.45.2


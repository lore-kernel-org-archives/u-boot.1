Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41BBC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4745980F67;
	Mon, 24 Feb 2025 06:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W4ZgyTq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCFF680FDE; Mon, 24 Feb 2025 06:56:24 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7431E80FD8
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22185cddbffso80804295ad.1
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376581; x=1740981381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niK+R0mLMg4CQB3zGADDQDLAihUJkpWwNl0cmdaYfFA=;
 b=W4ZgyTq2xjEN0gUJyYXqUzh3nPATqFhAsrHUsMZ8rA+818ARNU94h33Q2VGEO+kqPL
 B0vzQ0K/0NdU0rMJKu1VF8HM1IWpKYBgRXbOjL9P9Fh2jLnY2GJrZ4aVAG1TsVa3HDNN
 OdBjosExtL5NZusOKxAALu2QNX8e5o9ornBn8upEOnG8jwZQuGiAXJDP0SdgeaykhtOh
 ZehzBRVR4JRW4x39ExaN13sg3d5kR/+Fq063hP23s60LWmc+IjPasAxFx4QbQmyjG0nP
 cl6+YCrasX+hcSQRbb5b5Tt+nU1RpVk22PpYIc1YLkLo+mETBoqD6TFlgv6NIwZs9pxu
 Lp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376581; x=1740981381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niK+R0mLMg4CQB3zGADDQDLAihUJkpWwNl0cmdaYfFA=;
 b=ck9VEb5Gs3VeMWXTX4yPHXlkhWq6YoO/DT7zBN9cVMi17nalRXO7wfmwCpmEXSbbw/
 K3qZ6BOidwPVv0w/rgr3wRsnQaP8Q/7/imf7Wfgfj3dNQ4iXb+mGAwladrYE0GGuqI+z
 EHDUhgjc7mQkYsznim42gEd5xVRNoM1dB9epsfYPVZ4LRN6KCouoSO9w72zjSsaFcns9
 cV55OjYugOv/oGswkZd+p4UfExCp5WhucMNecsoQXAsdfmp0Fcpu7kynToVTbIwhEmhN
 sIHpecjOFqUNHlU5BWhrAsqSSa8tDeeYgQUk5BNnHhv3IEtMt6izTQ4W4h5O98TrlTfe
 czbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOVe6nKLS+0kTS/iLXdR469MvirurXIOvXDHj4KyEAvpvntOFzfg2DFGb0m9hMTdxCB9L/zWE=@lists.denx.de
X-Gm-Message-State: AOJu0YzqAQd/5yIKDVhrYf3uPGpSEG+oLaTvF1veU6lbYJqDuegKFcvG
 Iyr/4WPrS4H1R7VYfADTZNpLXFv/JERUitJCnJpIjp27FRQ1UziY
X-Gm-Gg: ASbGncuQ9W5em9WEpVLGotptmp07BIAzB1Rgj/iQvcO+hzyVDEpoaoHDLnUyTRGB8QU
 xgrI9GrjHMkH6FkXT6D69OzvFgAulKiGhUyRyGStIKAHKFR8RxJmtHvAGMIb+84rjAsatiroaQ3
 ZrSSFodlZd01a4BOCEqC3vaR9QVehZx9INooj66lR89gbi7kCMMxXPHwdgA+2oTwvm7PFm1lZV3
 hSIPw/7SJ36hBI/0IwQLbPsOXmKK9gGuxsnOyw3Ev4L23VzUVZWcuXjxca/KG3ptlm8mtqt5MLl
 /mwTQKmDGsPQJ4zr93ZNhvOZtliLAJJlfkOAXw==
X-Google-Smtp-Source: AGHT+IEskh973g19O7SuGe82jRHbjACRBvkCByLFz/uCYWbTjyu91WrRHAgUI9K7MFI8IuUCjPTp4A==
X-Received: by 2002:a05:6a00:1906:b0:730:940f:4fbf with SMTP id
 d2e1a72fcca58-73425b39e17mr22851120b3a.2.1740376580893; 
 Sun, 23 Feb 2025 21:56:20 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:20 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 16/17] efi_loader: Move .dynamic out of .text in EFI
Date: Sun, 23 Feb 2025 21:55:23 -0800
Message-ID: <20250224055524.1334929-17-CFSworks@gmail.com>
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

This was not proper: A .text section is SHT_PROGBITS, while the .dynamic
section is SHT_DYNAMIC. Attempting to combine them like this creates a
section type mismatch.

It seems that while GNU ld does not complain, LLVM's lld considers this
an error.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/elf_efi.ldsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
index dc4d1a3660e..acf02eba4d6 100644
--- a/lib/efi_loader/elf_efi.ldsi
+++ b/lib/efi_loader/elf_efi.ldsi
@@ -20,10 +20,10 @@ SECTIONS
 		*(.gnu.linkonce.t.*)
 		*(.srodata)
 		*(.rodata*)
-		. = ALIGN(16);
-		*(.dynamic);
-		. = ALIGN(512);
 	}
+	. = ALIGN(16);
+	.dynamic : { *(.dynamic) }
+	. = ALIGN(512);
 	.rela.dyn : { *(.rela.dyn) }
 	.rela.plt : { *(.rela.plt) }
 	.rela.got : { *(.rela.got) }
-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB76DC35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3A378198F;
	Sat, 15 Mar 2025 23:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XPOrrxb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FBE80F9C; Sat, 15 Mar 2025 23:18:27 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774E680FF7
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225e3002dffso23573915ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077104; x=1742681904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IS0FuNU7VEOourPEwEAErHQeLT9PqGFReADgFvKMAk=;
 b=XPOrrxb2BaqdR1Ku8zB7L+ekrKR/mLSTefeh7NNPIgV96BA7TIw328PgN14VNDfp9Q
 9XgOCAozLWzHr4ezXWIyZoDOXMYen4BOMAWSmx8qaqhCf8fiWyVhy9+y0uQbknRv4+yf
 9jJHfeRZESRSmXZZ/CXI0sUTXUF1+pP8AghPrgpnz3/d2P481ePdAi6kKTh1RHm4/202
 gt1NF6l1vqm8dM5F9/abUtZfHijWVY97MgvEcyAueE4X9HDyRuEQZDvCqWTYDxONtQcJ
 vXZYaI0AzlP4otdrIx8/ACIF0ZhrvUZuxgGb6pgH2cLr3Ynz5QlQpqbuBQdCwTui0yGU
 nPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077104; x=1742681904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2IS0FuNU7VEOourPEwEAErHQeLT9PqGFReADgFvKMAk=;
 b=xSpQgxAKEFLtPLq7HkqsbAp+kXciBQHGE3yK4h9VfMJ22h52edZK+Y+lYkDpbHkN6w
 S4PRkdKJ3iAY+hU8cbAaNZe3RFfmaHsI3/8kRl/lQMxXSUA16MLPivODtAquXG0FoyzU
 yXradYx2AdGBhY4hY9X5OF9Qkl7VkMKJIrzoffk3MTweq5T0ghyQ13hDPDFiHtU6RzfG
 oNjQcpxtzr0Kw7kIQ9xY015modwE5tIrwzi7ZpFCOTvW28CZkYygbO5G93+hxJKWfP4n
 lAPaeaUaidKsu1O0EmM7iWbco/4UMAFOwes4erA4YXfkrheZU5aYnHdjHylRhSbROSSu
 fSGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYmH96DgKp6aWNjTOAGk03KSL9MWp1Dt5QmmpNyDlBwzDAOjnbVRwtc55hjHIZDT/fcTEp8kQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwlzAErpu4dAjNELzKHhQtb/wnBofidyALAi9VckQk6cRVDuaEQ
 SHWoKa8tt9sYt8vM6EJKQODHH9rHgiy7D5sljQmFyjhRMuFZAc8D
X-Gm-Gg: ASbGncvVyUteRbb2kXPh+amr074vzM0PuzuKrosnOHgmQHudFmkxSULVgaXMqJyAzkx
 HODCIoimq6Hr2avQVLrpvCRJuF8NjqIDuWoLu2EH5hswnneAfDOG+KNBf7Bj/kk8OEhv7TmrlUI
 pv8f1GqBK/R5aCvOGAFTqwJOTgxzA++b8PIo2a/FX69jNprFteunCVTWSFhko/u06GjR2sIcv2w
 lAu7YAr4z+i2NmKCWHQc3aMCgEfidTJeeR4N6CJbLk+0YwiQFnXTq5j98n20ZlfvHjfStH/Dpci
 4y0IZ+ZffHxY8NOa8f0S8zgMYcSx8MHcW2w7gHjWCHRbjLQncUiEGRY=
X-Google-Smtp-Source: AGHT+IGUOzVZyEngZEwPLGNNgY9CpyN+cI6KkLuIqfMubV+nSp7NjgLOHgdL7JCYFsyuoOPYvXs64w==
X-Received: by 2002:a05:6a00:4b03:b0:736:5486:781d with SMTP id
 d2e1a72fcca58-7372241f756mr8689846b3a.19.1742077104055; 
 Sat, 15 Mar 2025 15:18:24 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:23 -0700 (PDT)
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
Subject: [PATCH v2 05/15] arm: Discard unwanted sections in linker script
Date: Sat, 15 Mar 2025 15:18:03 -0700
Message-ID: <20250315221813.1265193-6-CFSworks@gmail.com>
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

There are a handful of sections that are not useful in the U-Boot output
binary. At present, the linker script moves these to the end of the
binary, after the _image_binary_end marker symbol, so that they don't
get loaded.

The linker script syntax supports discarding sections that shouldn't be
included in the output. Switch to this instead, to make the intention
clearer and reduce the ELF sections that have to be handled later in the
build. This is also consistent with the other architectures' linker
scripts.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm/cpu/u-boot.lds | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 63e82a09fad..817e7a983ae 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -181,14 +181,14 @@ SECTIONS
 		__bss_end = .;
 	}
 
-	.dynsym _image_binary_end : { *(.dynsym) }
-	.dynbss : { *(.dynbss) }
-	.dynstr : { *(.dynstr*) }
-	.dynamic : { *(.dynamic*) }
-	.plt : { *(.plt*) }
-	.interp : { *(.interp*) }
-	.gnu.hash : { *(.gnu.hash) }
-	.gnu : { *(.gnu*) }
-	.ARM.exidx : { *(.ARM.exidx*) }
-	.gnu.linkonce.armexidx : { *(.gnu.linkonce.armexidx.*) }
+	/DISCARD/ : { *(.dynsym) }
+	/DISCARD/ : { *(.dynbss) }
+	/DISCARD/ : { *(.dynstr*) }
+	/DISCARD/ : { *(.dynamic*) }
+	/DISCARD/ : { *(.plt*) }
+	/DISCARD/ : { *(.interp*) }
+	/DISCARD/ : { *(.gnu.hash) }
+	/DISCARD/ : { *(.gnu*) }
+	/DISCARD/ : { *(.ARM.exidx*) }
+	/DISCARD/ : { *(.gnu.linkonce.armexidx.*) }
 }
-- 
2.48.1


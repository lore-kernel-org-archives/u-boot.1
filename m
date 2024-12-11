Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A9DE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 00:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA1A80217;
	Wed, 11 Dec 2024 01:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Voziiomo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D61980239; Wed, 11 Dec 2024 01:45:19 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5311B80209
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so13101215ab.2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 16:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733877915; x=1734482715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPLJuFSWThHwwTj5E5oAiwknybFK4QL4TImEugWi/DM=;
 b=Voziiomo0A8mVzTh/hU/I8lYOdrcCBfWE5kWN1V0Rq+4n54BLErPRHDgKPLBHe7HNx
 njNW641ClSvU2c8TdrLVuw2AsYwBbp4YoIKP42s++lwEeuEYLa1HeUT0JnTqUpV+1LQ+
 ioOErVyykCP2300O/1fu2ML2Kh4IHTb5o/RyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733877915; x=1734482715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPLJuFSWThHwwTj5E5oAiwknybFK4QL4TImEugWi/DM=;
 b=qZ3AM+HvMMNYf9CZnyodoAwgt0s0L0TCmMsxWV/Y5bm6MGcfEenkuM+ca3L1Y38PB6
 JNBxO0Ek88I+LZew7oCa9rKFAxRcmJu11KWMiiOVVV/1lYTI4IeLrgViB5IpjWX1zUID
 f4oFosTTzRX8WC62OB06P35XH1I1QKUGSHka5SCdGPSj09zotceQTFETk1jbco6nPQdi
 jEHmeeDil5oVqWPUZugYf+iCHMruROLgNOkm0Hhfw9BgOKbu2ur3dgb+T/HySBP6USZ/
 AcXr/tUbrhjCW/V+FjKmelJ87ZrdXcr4Km03tQWrZS9Y6GqzqpEmuLhBtz1wMcnzf1QK
 24/w==
X-Gm-Message-State: AOJu0YybOZyM6+ficmsc1+yt4t9vdfFzoFbgRNzuekKYStS6H7XcE5ib
 ohEFjhL7VM7L3PHZj/y6ZZR1XiAP6cMR1KZN2Wr/lM92kL9Gl8HdxSaJ9sIKzEbhfEsTPyYfz4A
 =
X-Gm-Gg: ASbGncvyrvfMao7Ps2n39jE0lsLDDLfwemQs0UfsU1JMsiXsZ8X4KYxCHGbq15VTTiD
 Onznx17TGmmCXntCBWToJSoL+Bs4CY+26K8MfHhLGUhe9ER18AdgT7w6DD/Y25SqCEJt84Dwyuw
 9tHGVFu8I01nYyFlO5c2Kqx9gVpwzz713fyKrSf3RsboW/gVt+83iAnYHkBiR+C+hXb+HLl+yfI
 la/wptRrI0yf2J1R9HhlrMXnw+l1jqnmYoVPfKHA3/f0mYupcC8k81JTy+3zAXo9Jol00T9xh28
 gsXowRtABYnyTUQ=
X-Google-Smtp-Source: AGHT+IFGADgCQyWcjmp2uqtAfgObijGK9559S+t5OcXCw+7XLA9lfJ/6RmfWi3FUpm2QhTU/CaDoIw==
X-Received: by 2002:a05:6e02:12e8:b0:3a7:7124:bd2c with SMTP id
 e9e14a558f8ab-3aa088b0a42mr11480145ab.19.1733877915118; 
 Tue, 10 Dec 2024 16:45:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a9ced6dfafsm17251305ab.54.2024.12.10.16.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 16:45:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] efi: Support an embedded DTB for the 32-bit app
Date: Tue, 10 Dec 2024 17:45:02 -0700
Message-Id: <20241211004503.3775922-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211004503.3775922-1-sjg@chromium.org>
References: <20241211004503.3775922-1-sjg@chromium.org>
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

While this is not likely to be used these days, it seems best to keep it
in sync with the 64-bit app. Update the linker script to support a
separate devicetree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/elf_ia32_efi.lds | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/lib/elf_ia32_efi.lds b/arch/x86/lib/elf_ia32_efi.lds
index 6d89c1fbd53..37a6c386b81 100644
--- a/arch/x86/lib/elf_ia32_efi.lds
+++ b/arch/x86/lib/elf_ia32_efi.lds
@@ -87,5 +87,10 @@ SECTIONS
 		*(.eh_frame)
 		*(.note.GNU-stack)
 	}
+
+	.embedded_dtb : {
+		*(.embedded_dtb)
+	}
+
 	.comment 0 : { *(.comment) }
 }
-- 
2.34.1


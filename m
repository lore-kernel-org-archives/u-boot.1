Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC14C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A71C87FAD;
	Tue, 12 Mar 2024 15:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iBp5ThKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0EB387F78; Tue, 12 Mar 2024 15:09:07 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A789387F69
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-568107a9ff2so6257127a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252542; x=1710857342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyTGDcjnbgrI/Feob4SwLA7ZO6R4QQDrl/SKUTNkZvw=;
 b=iBp5ThKKi69dIKMAVr1mcufMFdeNwsQK1BCYmqqBGl0qkyH2FE/zzM3JQ/j2RXNsAl
 EuQ0ANlgK583TIDgydwJhzjFdZ10NXe8LgZZsxLuDi+fx2+sAtyBmPH5eFjIrzW3Csr7
 Ffz8g523a9xksvql92CiYOiHziJAZqw91FSarafYW5N7zU0cP0TUAXrn8gM8/IzD0W7l
 dFCYOMdDVjim7C0Xvy+VGxUUmOZKOvmedsjTwhnRLoW7YllXIbbmAw7Uacm0kjEVF5L7
 wjOQ62SD6Dkl1Rc/LaLn64kVlNxEfKBjD8JAAlGUQgEG96YlMaJyajy7MwGuu80189AQ
 4/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252542; x=1710857342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyTGDcjnbgrI/Feob4SwLA7ZO6R4QQDrl/SKUTNkZvw=;
 b=WZVU1YP7IUSn5OgIN0vDcx44lDNSek3YtEb71TTIbeG7AaPSC9t/KtrmRtGbr0dHY+
 BEKnFP8DjRDvgpLvBTqV5Tbb3HoG7fZ+LqjBWLFInCq5XPzxvag7BDt2qr28LlHPTT33
 /bpKxkdqHE1sSGbpobJEDYB5AtjYN/oAup8dcY7pHZ/nFZmy/Woqnz5guQKGqFXnPbEN
 jPzZK/RePf0kIsRy7/xssefoExHMegiQpiFl6OpwcCWMFx5Emv5hGg92HYt9szFZ5WkE
 LbDfTBQJDdOc9IbU6Eog+43PDMnIpX29vNo2wBRaDHvNFwXEwvSQtI4aum0wml39nZz4
 VaJg==
X-Gm-Message-State: AOJu0Ywl0HDx+wvn9PsakEkbceuVKIPP4ijz0gilzUIk29qyPiUOOTvr
 RzEnRA0Uq76oOnKTucPkJ0Mko0sYNEWOHa3vBPKYbYpFgbyDMOsa690kXdkcKGIFbIFL6oprQR+
 8B00=
X-Google-Smtp-Source: AGHT+IFeHq7dMtYZ/Fq3sykOppM9UyyKnwbF/FcEfdC5chseddugxzDYlCY1mtVLhFHNrig0ON2AXg==
X-Received: by 2002:a50:d618:0:b0:568:2ad2:5d96 with SMTP id
 x24-20020a50d618000000b005682ad25d96mr355184edi.40.1710252541919; 
 Tue, 12 Mar 2024 07:09:01 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:09:01 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 5/7 v2] arm: fix __efi_runtime_start/end definitions
Date: Tue, 12 Mar 2024 16:08:27 +0200
Message-Id: <20240312140832.1968215-6-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
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

__efi_runtime_start/end are defined as c variables for arm7 only in
order to force the compiler emit relative references. However, defining
those within a section definition will do the same thing since [0].
On top of that the v8 linker scripts define it as a symbol.

So let's remove the special sections from the linker scripts, the
variable definitions from sections.c and define them as a symbols within
the correct section.

[0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")

Suggested-by: Sam Edwards <CFSworks@gmail.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Sam Edwards <CFSworks@gmail.com>
Tested-by: Sam Edwards <CFSworks@gmail.com> # Binary output identical
---
 arch/arm/cpu/u-boot.lds        | 12 +++---------
 arch/arm/lib/sections.c        |  2 --
 arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
 include/asm-generic/sections.h |  1 +
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index b1065ec8063d..df979986a5ef 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -43,18 +43,12 @@ SECTIONS
 	}

 	/* This needs to come before *(.text*) */
-	.__efi_runtime_start : {
-		*(.__efi_runtime_start)
-	}
-
-	.efi_runtime : {
+	.efi_runtime ALIGN(4) : {
+		__efi_runtime_start = .;
 		*(.text.efi_runtime*)
 		*(.rodata.efi_runtime*)
 		*(.data.efi_runtime*)
-	}
-
-	.__efi_runtime_stop : {
-		*(.__efi_runtime_stop)
+		__efi_runtime_stop = .;
 	}

 	.text_rest :
diff --git a/arch/arm/lib/sections.c b/arch/arm/lib/sections.c
index 1ee3dd3667ba..a4d4202e99f5 100644
--- a/arch/arm/lib/sections.c
+++ b/arch/arm/lib/sections.c
@@ -25,6 +25,4 @@ char __secure_start[0] __section(".__secure_start");
 char __secure_end[0] __section(".__secure_end");
 char __secure_stack_start[0] __section(".__secure_stack_start");
 char __secure_stack_end[0] __section(".__secure_stack_end");
-char __efi_runtime_start[0] __section(".__efi_runtime_start");
-char __efi_runtime_stop[0] __section(".__efi_runtime_stop");
 char _end[0] __section(".__end");
diff --git a/arch/arm/mach-zynq/u-boot.lds b/arch/arm/mach-zynq/u-boot.lds
index 16245fd4ac2f..fc0ba0ed9a84 100644
--- a/arch/arm/mach-zynq/u-boot.lds
+++ b/arch/arm/mach-zynq/u-boot.lds
@@ -22,18 +22,12 @@ SECTIONS
 	}

 	/* This needs to come before *(.text*) */
-	.__efi_runtime_start : {
-		*(.__efi_runtime_start)
-	}
-
-	.efi_runtime : {
+	.efi_runtime ALIGN(4) : {
+		__efi_runtime_start = .;
 		*(.text.efi_runtime*)
 		*(.rodata.efi_runtime*)
 		*(.data.efi_runtime*)
-	}
-
-	.__efi_runtime_stop : {
-		*(.__efi_runtime_stop)
+		__efi_runtime_stop = .;
 	}

 	.text_rest :
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index 60949200dd93..b6bca53db10d 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -35,6 +35,7 @@ extern char __priv_data_start[], __priv_data_end[];
 extern char __ctors_start[], __ctors_end[];

 extern char __efi_runtime_rel_start[], __efi_runtime_rel_stop[];
+extern char __efi_runtime_start[], __efi_runtime_stop[];

 /* function descriptor handling (if any).  Override
  * in asm/sections.h */
--
2.37.2


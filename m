Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C35CE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 887FF803A9;
	Fri, 20 Dec 2024 23:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tU11QXYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC8280463; Fri, 20 Dec 2024 23:26:26 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46DE8006D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d933736380so26382496d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734733582; x=1735338382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQHDftwPsupxo/i75IzlrHlMdsupUwMmnlfnJAat5Nw=;
 b=tU11QXYRj0qDqIJCA47BCFQpfC1TQnOnoBWttIcQPH9y6j3xJELzmiAqj5k/HqIwVj
 VAZxqUFyKTNsM6sDYG89XIwGFhRsx1Ynhjo98jvl2GK3oqgkFqusBBTpW3TAswckHA/U
 EYr01n6M2az9NmDzvDKqsY4tptuvpfUXklmPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733582; x=1735338382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQHDftwPsupxo/i75IzlrHlMdsupUwMmnlfnJAat5Nw=;
 b=GlHCeSXgJqbs+c9cDgpHZpaxI/kC8nkBhwzSXWmmpqQ6Ly04AUFQW5yzCXcSYIlO5d
 CMNbvJ9oUj8+CqNQpVZhM7Ra24hiqj5jwSFXAnvZGJtxO5oVXH2KZBY2snikkVi96oTX
 SXwkaSXIRbs1XrlEPfVF+wiqqjrn7QwAvKkJdBNvLnHqsnkZtkbcxJB0ZPQFxXgoogWB
 IgeKXf1J/ym92mA5Anfz2CAcsOOr67gDHe2OvxDKWVHH9nJ+k5SvOqQBjxUzk4lLURDd
 SWy2urA2RAby35L8ZWEM3fgZsVBYfNUT6r1vEb76Qq7+hVYRQOlqm4z//nnKeVeKaJX1
 36rw==
X-Gm-Message-State: AOJu0Ywwtmmcp6fBWTkheElzAdhnT+EuzKTwGKHSXMNXHr0sOO9dSQZh
 /4OH3ocH6/GbPrGz+ddp3E914dCG2xC4f+6pBB68D78SC3ZnooLCUz5hqB297XQsqA9ibpiKNU9
 mWvA=
X-Gm-Gg: ASbGncti4ZY2NTXmTH4h3GzDGFbNPS+WMGOdW7AruLvh8aXuGo8u0vKJMBvdpH1/6Qi
 pLZMj8M0P11DjfCJSOATeocsaLzjYKJhI0jvSFXa2bGNm7MnK62mSYwTiSP2oP0+UG6AmbDon6h
 zCHSUUypU9Z1Mv/24EaU1VB0AZqTnQW44dkInspZG2FvJDS+hKH9DIKxcQnHUeMCU0RTOu2/1jL
 VB+WgT6UnYfcEenis3OkCWLyWK3N6P/nFbawdLkDPc+UbpemsyW1gA3lVOjYhEWcK6B0dcX2qIA
 aUs=
X-Google-Smtp-Source: AGHT+IHMk7LOv3PiqdXjLFLphrK0W4X0OL4Ov05kwfD6DRswSRlN3nwEvJ2PA/F3Bd3ZylGtG8pLNQ==
X-Received: by 2002:ad4:5d67:0:b0:6d8:86c8:c29a with SMTP id
 6a1803df08f44-6dd2331a3cbmr76243776d6.10.1734733581795; 
 Fri, 20 Dec 2024 14:26:21 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm21055606d6.87.2024.12.20.14.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 14:26:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/6] efi_loader: Depend on BLK
Date: Fri, 20 Dec 2024 16:22:19 -0600
Message-ID: <20241220222612.1757884-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220222612.1757884-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
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

In reworking the BLK usage in Kconfig, I found there's a few issues with
EFI_LOADER=y and BLK=n. In general, we can easily say that
lib/efi_loader/efi_file.c also should only be built with CONFIG_BLK.
That however leaves the bootmgr code, eficonfig code and then parts of
efi_device_path.c, efi_boottime.c and efi_setup.c which functionally
depend on BLK. While these calls can be if'd out, I'm unsure if the
result is usable. So rather than leave that buildable and imply that it
is, I'm leaving that combination non-buildable and commenting that
EFI_LOADER depends on BLK in the Kconfig currently.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c46ffe3a9d89..798dced475e0 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -8,13 +8,14 @@ config EFI_LOADER
 			SYS_CPU = armv7   || \
 			SYS_CPU = armv8)  || \
 		X86 || RISCV || SANDBOX)
+	# We have not fully removed the requirement for some block device
+	depends on BLK
 	# We need EFI_STUB_64BIT to be set on x86_64 with EFI_STUB
 	depends on !EFI_STUB || !X86_64 || EFI_STUB_64BIT
 	# We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on !EFI_APP
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
-	select BLK
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
 	select DM_EVENT
-- 
2.43.0


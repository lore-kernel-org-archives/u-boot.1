Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949C8CF34B7
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CE383F20;
	Wed, 19 Nov 2025 15:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lb5c6EWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0933583F30; Wed, 19 Nov 2025 15:50:32 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EE683EDE
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c6cc366884so2008598a34.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763563828; x=1764168628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=06kEwdGzzjC18TJEHD19VMrYIiNJcH26bS7LRz/GaKo=;
 b=Lb5c6EWegrjVBmDah2csXtiEHuE9KgwE3uEWg1FzgDk/EZYKcxMig0AuyfSudwf4u/
 h5KLrN/AxtK6W4e3g/qgQpdvHYIGrJT0viIiRL1o0ee1IbrzoAp7IvUxeEMASq+UaTV2
 34DM7WUlCX4JEDj0Vhjev+xJtxh3zqpdKVJl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763563828; x=1764168628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06kEwdGzzjC18TJEHD19VMrYIiNJcH26bS7LRz/GaKo=;
 b=SPqY25vwXTULj1EBYMD4eOHAJuxjZQfx5G4K6jXJhT3J33Chw55dXflOqMru2VN9rN
 OFFaw/oVapaBma6iejcE8XQ0e407jcai/0pNtQV7ygK36IMG7AkHKgbkPHjkW+0tndvG
 expTIrfeD4L/6lKY3YKqDVHUYT/fwLLR6Om7gt7AfRzTnRe+97CSvalmpAxhg/tqXizm
 XKw0qF+BrMGFI0rsvMKYEYOl7Vr9mzHq/a9II0pDsgM+CK8igehoykUo1nqHGuHdZfdW
 LSdy4O3zQimWQEAiRPc3PYkivCrGIMNRf6czJCFaSDrHE7SVjmyW6PrygLe0hdLBPFcN
 J/QQ==
X-Gm-Message-State: AOJu0YxtYY4zdKhMTrC/yAt5Ke3zcccxQ/46t8CPMHvPh59VfH4f3V5P
 GIow4Pbv1/uUtkoI4ikOKc1VqJU/DW8hRIvvsUlRWMA2/OFS+8kza/gIMN6mkFQVI8LYgLDwNlA
 6oNfS0A6Dkg==
X-Gm-Gg: ASbGncs3R5sMAJKLqdeo5rxcSb2YF1yPFSUHsL0a4ZBoDs/eztl7SDtErH+xRER2qM1
 pla2yaULEBVoT1aHj/aHT4BM1Pph0AHfAPTddVF+knXYs59t/ZwO50VLrsqQQPc7dlCF1ts8mbJ
 pcM82NgwhkmjGxl7DFGY+v37m/Hr/WvVhMT7p08rLyMWLUIynKRivw6lf1H5SB+4khW7Uo3gBzO
 VVhgvijrhjMeLK7UiLNx6KK31iwHINCa0wgaQy/dxPbWcYJkysRT32DIbuJCsYcBjob9A/j//Xi
 aTtJmDTWauylXBBljGmQ17X6qwLiJpWV/9FYscSyPCRFhRWn7hwxCvtbSTjMxNbBpFGouvS/W1e
 latEWD3r8U+n+VNGBOIgz9AXFN5TT/EA+NM18dPVhTrdMJW+8xG8H7X12PmT1rqeXbbhtqVIRXk
 cyaIQmdphcc1Zj5cPtFccdOOf5ZMgJrm2HKIXILg000m1Nm740rajETSA9c//CjLySuQpy7PMgc
 w==
X-Google-Smtp-Source: AGHT+IHTG+KUQ/a538NoFDhE6cyLpjCniKSM7Y8XFdE+Eyf+hs9m1SND2dN8LqnYSfVVnlVKyVu3pw==
X-Received: by 2002:a05:6808:80ac:b0:450:d1e8:6f5d with SMTP id
 5614622812f47-450d1e881a4mr5474886b6e.5.1763563828589; 
 Wed, 19 Nov 2025 06:50:28 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450a5f5e1a9sm4044733b6e.12.2025.11.19.06.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:50:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Marco Franchi <marcofrk@gmail.com>,
 Alifer Moraes <alifer.wsdm@gmail.com>
Subject: [PATCH] imx8mq_phanbell: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:50:27 -0600
Message-ID: <20251119145027.842101-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Marco Franchi <marcofrk@gmail.com>
Cc: Alifer Moraes <alifer.wsdm@gmail.com>
---
 include/configs/imx8mq_phanbell.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/imx8mq_phanbell.h b/include/configs/imx8mq_phanbell.h
index a30d0da5050b..972f9def5512 100644
--- a/include/configs/imx8mq_phanbell.h
+++ b/include/configs/imx8mq_phanbell.h
@@ -34,7 +34,6 @@
 	"image=Image\0" \
 	"console=ttymxc0,115200\0" \
 	"fdt_addr=0x43000000\0"			\
-	"fdt_high=0xffffffffffffffff\0"		\
 	"boot_fdt=try\0" \
 	"fdt_file=imx8mq-phanbell.dtb\0" \
 	"initrd_addr=0x43800000\0"		\
-- 
2.43.0


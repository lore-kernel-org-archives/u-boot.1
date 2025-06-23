Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28906C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D611682F00;
	Mon, 23 Jun 2025 14:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZzKSc0oF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CBD82CCE; Mon, 23 Jun 2025 14:10:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3965982D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso701651666b.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680639; x=1751285439;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bTwhy/ElUORNAldoeh25l2J0S6zGLBZeg9bQIc1LhhQ=;
 b=ZzKSc0oFhvrajnTxcewbnB0twZp5Fgo6vh3Zw2SP6B5mk1tngPOJD5nMH3k5tP4kSl
 /ciAZXlnrhmT8cExhvcSehRKRw3vDd/gBIOqp3fmLAVknuyxrLfZxN9I1iqmgyP2v86R
 s4RASaJz39eicmjABr3Iskl7myaXt/pmtGk/71NnBPFfGt/bdpB4Sdp/o6N+X7wgPMVb
 qNoRyaUNUBvc034zqWU3AOLbDQotNShy1EjditPD54pJPNw+2zxJqQH9tdq1RQKGsbgB
 J64QyHimAWKsU/VnzilJIwHvOb0HRcjzLNkYTersEQ5IQ3IkAkIMgs6S4Wp8EFlKBaqP
 fU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680639; x=1751285439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTwhy/ElUORNAldoeh25l2J0S6zGLBZeg9bQIc1LhhQ=;
 b=kcT2QnJ4aVk79evm1Ec2tAqlmmsy3GBS/TRPu6o23lWcncNnHH4CIZUWufW86fB8NM
 ibPJzsSxQBfPyDalX1qWjK6lUmQfxnUJh/SI0TEpOFwGwm8vPPTZIDyz+jiVoyzQ1TaQ
 accr3jhlvskmRN95v0H6MEdIyCHDlGkYOWPT3V/u5QBoAQhpOXfAj7r4uXCHvLvwkeRm
 7rhzC2YAlxjHfU98JthLdCDhiriKFOPYfLucwVFIgtK46GBG8epEMg9s51xt3677TVTy
 +MNf0/4QVy7+xIc6DBzTy+fefJWhC9wi/d4bRfSFSsDnXTrhStf7x1i7axQwWgWNgK6O
 9l/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3PXXUE2kiPoib6RauqK3fDC1EAeqZEazsgCgUUVhn/9Anqd8JQIuCqw3vHSVcaF5EBW/y15A=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh8y3uzpvJLKjNGhSILAV4RjB9j8UyleZbKEcOnr8EUp/ulryL
 e8RXceeWcC8UE7n5gZSEzR1HEjfRtwy2DohdOFzfCmLyh0BH+nu91IIGwcTKPhyF1mA=
X-Gm-Gg: ASbGncuTQYjhjH/I2YmfEBRDY/gVjyvy3DUl2vfN/itLXUkA/n58ydBhV2BbPXwytNc
 T7sxIY/kIGwdv7d3SyFk4deT3byHKG9xjq0t56a7qiAqUasDuA7U6fElbWfcw/9FU7sjRTW6NRy
 KzD7+V9RvoSOOd/LnZH7ZevX6x9qAqAtz40Mp1V/uHluw7+g1LnJwzcO0hgNrgH08j7boypUKkX
 p6JnRpTEupdoQfW1sGKdSn9tOWZGuR2SMNqrTwcXVDflIHC8PEZVnQRY0U0V5jmCgU8HZAHJA/O
 34J3HYfZ0kbMopSsElF3mpB4/qurcSJVDMCCHcLsw5+8g1YsGhQYmUseBr+fAOGxcp8+aQ==
X-Google-Smtp-Source: AGHT+IHjNQD0+pxwRpukE28rzRnspVDiN364EmxzdobD3Dknh1pAWi0WG3kmU0mNA2xtyXrNl18ohQ==
X-Received: by 2002:a17:907:724a:b0:adb:1b2b:fe20 with SMTP id
 a640c23a62f3a-ae057f320bbmr1002020466b.34.1750680638640; 
 Mon, 23 Jun 2025 05:10:38 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae054209ad2sm710710266b.148.2025.06.23.05.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:38 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:32 +0200
Subject: [PATCH v3 09/22] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-9-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tWY8CYc81bR4qJE3wq17NTxxt0dZ2stIy2lOwJpOQE8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI55dfMkISlkmY6cqtqT197BGX94GzDIva7fYy8iuFT
 Nmj66XTUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABP528vI0Gii8b3F0PauhqSi
 VJYz+9tnvOyLhZ/u0Cn4638sIfcHE8P/euufu/rMOOJ+n7HWNwqZvOFh6sfLAgFdfkH+Kh+lLlT
 xAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index aeec07f6067abb40dfa4019344e0782ea7b7f5a0..aeba6696bb2c103f704fb227e436fe73a71e245c 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -253,6 +253,16 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.49.0


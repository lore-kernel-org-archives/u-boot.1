Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B53FC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B028352B;
	Sat, 24 May 2025 01:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CY8YDWL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A708333D; Sat, 24 May 2025 00:59:05 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A0F83409
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so166184a12.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041141; x=1748645941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2rGRAUsuVNAOj2RWzOAxGF/Ggjq55NgdwXzx9/dMYs=;
 b=CY8YDWL3ODDe4UEyD6Q0h/yngZGtLRMaMzcT8L743CEKFbiMh26N0/ciUcN2SW/BTz
 i2DbnkJ/SdyRlji2QvnQeMBbkIEaUJIN2feX88v7ijQZyrLTJ7Xvrd15+joPGNs2PRpH
 ohCbKXAqOHMN4O0l8LSWPYFxUGVHjmTRxCWFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041141; x=1748645941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2rGRAUsuVNAOj2RWzOAxGF/Ggjq55NgdwXzx9/dMYs=;
 b=Uf3fCCLInH8EaZR/nkcL4+edQLM0HDE6iAiwEI4kD8c92H4bdob1UG351r1Nijg2oj
 6/Ew2iq2HVEBGOKe1R/mWGIEJ2HgW4YkKP1rzg3AYuoLOaOouxIiyQvrrFWaUBloGpLl
 l7f1KcA4tGakhwVInYSz3ZCuY2Ldh2D3ssIrlhpsM4yfVTE0qBnFa3Z7UqyYrd/uwkfz
 EV5fFct8L+22fZfnRyu7ZBcnLmQzieKFcCCeSYf73SY9BYtINCofsZd9AyaOwUp4p2QR
 M4/jrwRyf6C3dvdyxqK0nuhugRF70MHRT0mtrhpptIfoG0GE0QyUM+FU3Foe5YEWWjUM
 Hozg==
X-Gm-Message-State: AOJu0YzwMG0bOUPa6BEZoE/zDrnHsX9NFn9Yh00GuoS2IjR6rtRBv1mo
 Mseh//SSfR6AerP4S4cIBtbhE4O1JgWD9MdDWBKMS1o7rHX9aZbiXTtlMVnz9wqzLW4WbXDEfb+
 1B/U=
X-Gm-Gg: ASbGncvVenEyiRDXr4HS7W7joXxKF317PrxzOoUjEUUcjgLry2jr9/pKPfv9tVlMqEb
 UyvRV1EN9Xvg39+y9QxMIm2bgJjTTWnrzqtHw8Ycv/ucnsnLSzXGblfKiSgtuSzXL1XR+TR9QyH
 g3wz0w/7/6QZjBG1WZsx6XnUUjSvFlaSrbkni25AAm6g3/a6PZZKYv9vYLltHzP3RoEVlXuiJ5m
 SRCnaP8IZq4eUmxlgrQHyEaIoXupQ+2oxuLB/Jyf4snFgHdQj8867yO+vBBW365DwwVO/fYkAa2
 fzhWgNu4adhX5Zr6g8KPTtjWfF0BMXAFTvTgQECUOoCK5s6mtCG8FhadncmAqZ2WOfW/e062hhx
 bpqwzSoCPCxqjkEHGVHRqQKgtiQ==
X-Google-Smtp-Source: AGHT+IEkssZOru1hTNJ90BR1LjNzVDAF8YkxyxdpGyjtKchDUM+/OFucW1vmGUYQD6Rd2N0JYwFUpQ==
X-Received: by 2002:a17:903:1a90:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-23414fb1a9dmr19426305ad.40.1748041141514; 
 Fri, 23 May 2025 15:59:01 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-231d4e97798sm129182215ad.147.2025.05.23.15.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:01 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 09/28] coreboot: Set gd->ram_base when parsing tables
Date: Fri, 23 May 2025 15:58:24 -0700
Message-ID: <20250523225845.2311989-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Set the base of RAM to be the lowest address memory bank from the
coreboot tables.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/coreboot/sdram.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/coreboot/sdram.c b/lib/coreboot/sdram.c
index ac9a95b1d378..25918af003f9 100644
--- a/lib/coreboot/sdram.c
+++ b/lib/coreboot/sdram.c
@@ -56,16 +56,22 @@ phys_addr_t coreboot_board_get_usable_ram_top(phys_size_t total_size)
 int coreboot_dram_init(void)
 {
 	int i;
+	phys_size_t ram_base = ~0UL;
 	phys_size_t ram_size = 0;
 
 	for (i = 0; i < lib_sysinfo.n_memranges; i++) {
 		struct memrange *memrange = &lib_sysinfo.memrange[i];
 		unsigned long long end = memrange->base + memrange->size;
 
-		if (memrange->type == CB_MEM_RAM && end > ram_size)
-			ram_size += memrange->size;
+		if (memrange->type == CB_MEM_RAM) {
+			if (ram_base > memrange->base)
+				ram_base = memrange->base;
+			if (end > ram_size)
+				ram_size += memrange->size;
+		}
 	}
 
+	gd->ram_base = ram_base;
 	gd->ram_size = ram_size;
 	if (ram_size == 0)
 		return -1;
-- 
Sent by a computer, using git, on the internet


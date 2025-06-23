Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CE7C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A41F82D2B;
	Mon, 23 Jun 2025 14:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ilCYzIJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDAD82D4A; Mon, 23 Jun 2025 14:10:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7938210D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6071ac9dc3eso7067678a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680638; x=1751285438;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YTiTDqiArzhFCyUmneiPCd6K47IcqFjXCp3gu/YZ8mw=;
 b=ilCYzIJF+ZVrSxT05RXnrojuf4Xnf5CHTFBPSWhxFrFs2wsnL+nRa/Tmrkcv4LJrBU
 yPQqW5C6YxJBFI6ou5zCHVSzYVzx8XfBLlofvnUhKrMaNbP8rFcmb4WAK0zVPCUfUbDs
 p9znMJCgzkeKziW3EIWhP28yJWr9OriwZkCcMC7exwV7JDSQv0pnuWQAxgFVz1delpRO
 37fO/tpOYLFVkpP7692UVDbJi20m0omqQ0K7RmBzqE7zEkloK5ph+W8w626f8ySA4eXj
 DNOzcMwGpw0pLbclRRtdvMw4ItL63s+B/QSGplLfwIWHjCzkYkvD57eYRcMppgqPBhpv
 mdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680638; x=1751285438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTiTDqiArzhFCyUmneiPCd6K47IcqFjXCp3gu/YZ8mw=;
 b=sBhrQ0Z26MnoYPI6q1WPOSg8Fvc3OuWcXErER988ifX6/u2Itesl/XhImKERSObcsj
 ymch6QS6f0h+T+75YLbfL09lCw9HQUsWrUVKeHrFKXBwDEMowig87XLhNz4BMKlotH4i
 jyqje64gGWx8jQS/0i4Q3GaRh/tSiKzCXZkoHa6Y1U2xBzVbUiv2oOchMhA8BeHulOov
 SFHTEqBI5JvLR9LD9KZSR/mvfDNScEHLe45x+rhJQ6U9d/TtXbwT/1c1Hbg0HAC52Wnt
 iIMNueVyVfDqIMKpdHirzIqGATdrC51Y9CgMDgAr7NPYlNMzPFksV6szXgRVsQ0RmD5X
 oEiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKFISECfAYJGEOcHYgVQ/M5jfXuAemK4Wk9JXOFGkQLAN+HpXUoEjtN/bTzJ1WkIaEQYPlBG0=@lists.denx.de
X-Gm-Message-State: AOJu0YxiJafJ2rqsxFJf6lSH/KSdlxV1nFUO4xVBBM7CUQl9sxitj13Z
 RmwIeo+u2toZxcaT0MW58VXHVjGoehCXh1zgeGQCitbIJa6keBSbCMRnRsUXGUrv7yHgczR17Ev
 Th2RL
X-Gm-Gg: ASbGncuxEbyvSvmOUypjaoNoq5MR3NWVkXqRxdLLO3amVEXmW1gw2bCzOTKn7AKaSF8
 uPqS5ljj9NnBBkhZBBkdUB7ggXCozr0sUvtjL/wsjGtQgkYTK2uGKqG6MYEeBGwJvQ1De4H/PpU
 ueqIeHzOcDWseK/3SfQQvbBs4FjycQcdCQIlQCsc33LEDTtD96xdzFVYLCrCUHI6zkV3vMlUgJK
 OcenqB/fUdU89bYatDStMDPGgHT3vFux7/v8sNua63hjnAp13mh5vmJpkB1JStZO1ZXWggmHzFF
 peVKwr83AnBXa5OsOrfZD551vCLVpth/vrQKPNfM/cu+WNzZ2G+uYItNV+ClQQPQf2V4lA==
X-Google-Smtp-Source: AGHT+IGjeStcEVzEvtI/dbQ2g9snuTkxhEDKlOQ4R9roRQC2SKWXDkzNYNd5iXyxjYJPCjmdv0fs+A==
X-Received: by 2002:a17:907:3c82:b0:ad8:8529:4f77 with SMTP id
 a640c23a62f3a-ae057b6c33emr1342634066b.38.1750680637450; 
 Mon, 23 Jun 2025 05:10:37 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0541bbdf3sm708273966b.137.2025.06.23.05.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:36 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:31 +0200
Subject: [PATCH v3 08/22] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-8-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=EESWjygFPTSaNr8Ul5do4mt8imh/euSMdw6KOrLFIUo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI56czXhhwnf6dZZYntlLuduhvLaG2TwzzWw+s1Fm28
 HDNHFaWjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI0Q2MDOv63ykZ/WfaviPO
 6XJp5IVenuwbO/88bXRft8OnvHG2cxEjQ3viut+dH48IeYX28kg1mFtZsgl9WLRofSPf9d37gu2
 juAE=
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
 arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 62b90726cf14273cfc1cdbeb89d6723ed864818a..f660352320e60d01c6fa1c89e6879f544c3637e2 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -196,6 +196,15 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
 #endif
 	spl_enable_cache();
 

-- 
2.49.0


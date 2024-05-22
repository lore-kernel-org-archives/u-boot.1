Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD737C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:35:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2416885C5;
	Thu, 23 May 2024 01:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E5oiFuPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 675638855C; Thu, 23 May 2024 01:32:03 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371D58850F
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f0f5633a45so2685331a34.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420711; x=1717025511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huWm+D9jGBOCac6oNDKL8UaJkATXpleDIsRJ3c0gbNs=;
 b=E5oiFuPvAf48xBA6vEwSOuC+QVS3mqaV5SWPa5YOJlLW+BdAefjen28cl6fYNQqw1Q
 h32bLuoqXSvJogUQuXZQ0tbyrnJ9BOqE/1R5vJzGb6U58XwSzW8axKt+sjUu4NYUceY9
 in1zss721joaDi+5z/tSh1OvZIOvN/9jwWGWcwa7mV5EhANvKa6FJFu45v0bWTU9sibL
 R08xg775pnqyJAK9YExTYG6QVclQMqw32fOmgSvl3Uy8grHaeDaXwVagwG0osi4KcgDQ
 y6Oh/VmEZfs+DVu39616bOgGhEhXpX9CmYkAC8/4/Vne2Cd5sE+VxVrssCpX4ujTk7pF
 LJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420711; x=1717025511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huWm+D9jGBOCac6oNDKL8UaJkATXpleDIsRJ3c0gbNs=;
 b=sifK3BU+Vsf0n2OHXtC75oqyoESDfee/EJ9hvCbhmJo5xG41OFaa7OAbFZX2WURf4/
 7NSbfEy+Nn8p+jEK54H49xotvon0yF97mPer6lqdC2/zE5qihIQlUxWcF6PJy0HSpoTu
 qP711JyqjjXfUIzzmoTea8baYH9e2z4UfSgkklwzNwo0oulf0tbw3Nkgak1G0OtqnJM6
 V03XQkAGdd0k0WwkyWrD2vMhpd/t5J664ZBNqJlzPv8gPgRqrCBfm6c83fQzzh0nBMid
 n0JJY55IJX/lwONAcgUUO1oUxfiAkPTZXcq4hpehrBomiOzU6eVfUcX2b18qdnC0Jhz7
 73XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJF+dRN0HIOu5ZX0OrXlRd2IxoHh8YJjr3tuY0Y00Kimn8LSjtsA5NMemlxkUQ/DyTFqdxxwb7YFMC4Ysi51otQYpRhg==
X-Gm-Message-State: AOJu0YyR69k3eO8tAVJjLtKIr7H/CYuvLPjQVXD3RQIUQIP7+0PC0VAJ
 FOaY3MKkrpHxPScSjc+1ZIU7rCZyipunlVFSCpxf9s82yrlkYxtcLX4ggGSmTF0=
X-Google-Smtp-Source: AGHT+IGyBr1of8CbzqGuvVX2q5dKJOAHWA7XwuutpSijZcmf8p1aKCkxFVlp/H2aTmu3iWqlopkPPA==
X-Received: by 2002:a05:6830:1d95:b0:6f0:e4e9:67e2 with SMTP id
 46e09a7af769-6f66a0d118fmr3530184a34.33.1716420711002; 
 Wed, 22 May 2024 16:31:51 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f0e259e71dsm5150541a34.56.2024.05.22.16.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:50 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 18/42] arm: exynos: Add header guard for dwmmc.h
Date: Wed, 22 May 2024 18:31:11 -0500
Message-Id: <20240522233135.26835-19-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
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

Add missing header guard to prevent possible build errors.

Fixes: 77b55e8cfcee ("ARM: exynos: move SoC sources to mach-exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm/mach-exynos/include/mach/dwmmc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-exynos/include/mach/dwmmc.h b/arch/arm/mach-exynos/include/mach/dwmmc.h
index 59c28ed54c58..811e9a04c6e3 100644
--- a/arch/arm/mach-exynos/include/mach/dwmmc.h
+++ b/arch/arm/mach-exynos/include/mach/dwmmc.h
@@ -4,6 +4,9 @@
  * Jaehoon Chung <jh80.chung@samsung.com>
  */
 
+#ifndef __ASM_ARM_ARCH_DWMMC_H
+#define __ASM_ARM_ARCH_DWMMC_H
+
 #define DWMCI_CLKSEL		0x09C
 #define DWMCI_SET_SAMPLE_CLK(x)	(x)
 #define DWMCI_SET_DRV_CLK(x)	((x) << 16)
@@ -25,3 +28,5 @@
 /* CLKSEL Register */
 #define DWMCI_DIVRATIO_BIT		24
 #define DWMCI_DIVRATIO_MASK		0x7
+
+#endif /* __ASM_ARM_ARCH_DWMMC_H */
-- 
2.39.2


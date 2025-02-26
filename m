Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB20C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD00B80FFC;
	Wed, 26 Feb 2025 14:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="hm6tj6HM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B963D80FB6; Wed, 26 Feb 2025 14:56:55 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD03C80FB6
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e0573a84fcso9341458a12.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1740578213; x=1741183013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lptYdQWjxqaw9JeiF23UzRatCTLwtupvJCE94PjKlhc=;
 b=hm6tj6HMqTrcKtigIuJsnsZDGxbuDeb4YJx4VZwGTakBq11RIORF/VL6CBVOfzgpMH
 /ObVbw3E3OUdyGpNuRixa+wV9cAhET4j6qwxD7HXc+LqZbytnbOzoTU3nYSqctBhZFpx
 KOWs5h7p6mt63GzPu0TXwE5O8ojL8546rED2WpDry4prVksqabEz+G5qOhwb5jpdwQJ3
 P5pRUwjeH8n2JQv4rLeQrUcDXIXCY6g+/pgMISScY/gNLiNhPPMr0RB96DBKp8Dtgc7I
 jR1yZHkHtvF3saZd+rIr6ag4c4V5R/2TohT2r/EgLB7QqFGhavrvCpWBqyA43+bGSsYx
 MkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578213; x=1741183013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lptYdQWjxqaw9JeiF23UzRatCTLwtupvJCE94PjKlhc=;
 b=IJ8WWvdDraBSY8xqQLpEAP9oOVM1NLxXeMSCrOJBekKnDxdb09AdelURhDVW8Rm95i
 c/7eXElRUcrscFbABtpxktjzPxWYAjQuDcEQeAl28/kvynvxs6d3P1HuPzf67BpljoCC
 VyP0p4NqWMygrroA2miurINdQ6QYEtdblIwcCkff0ndcD4Px7/YPee1jhs0FXFmpoeDU
 AsA3xu9Y9xn50rH5cqX/LQGyZHtRPl5NIy9UgfxUzhjJyMg5SD9aK6PrXj+Av9J1v2eq
 n25nDYYHwqEHtMhFynRSTwxzGGpEw1Sw55iHW8CjxcarkpazBWDUOeUGblJW0yeJaZ3o
 nDLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4uL0+VRIwTnCLIpoAS2PaYhQxRRGdxhwZMkagNTlffoDIdqHkzVWfvanc2zkJpDMduX4XMC0=@lists.denx.de
X-Gm-Message-State: AOJu0YxyU/byji2WjkvJ0/X6snhXx8VY+hcY9sBhy0v7KI7LLXYN5FRC
 B55CwxHnDZGteYtEIDt0CtCPGH6l2f1+GKX/wS8PRYZ3ge+i+Ghe2iBja2kXgtNwCC7Z6sxlalw
 zbQo=
X-Gm-Gg: ASbGncv0qAwq1FAJFujTigO4sCHnquMcLhGqZjQn4vMv18Sc0wGBLRmXJ4ChOVkXjje
 Ii4U1N9L/WwM2rN7UjcKIWK2YSB/ByaXhKg98yEXJdCjVQghJIO5gx1GQ7GjdM/K69UInq3/rzX
 nyfEC4zmWZzG4V0MGJqfb2s3991IOfNhbSH2Pu8zNojGycpprkrP4yEQswSKBjrYGHIEvsTglsN
 UG0PqyyTdNOomeIM8UKl6uhcCRuBXqX3gAYKZdSXUFPh5mL7BfmPnnC5XfVdvBW4LKptrmctjjI
 ycJbe15OcRtbFy1XxNErRDCJm7rrh6GrQSo44meL9lgBE3VjKgb4hXWYdXpTH6L9D4XDAKYhjBb
 WzHcnZFKaj/xJcKbl+UM4bdlH
X-Google-Smtp-Source: AGHT+IGjP/aZmrxoH+XEJiV8GpakFUHazoW9iihWn7n6ivUIgByUkbwZNynjAXXdGDJuqfa/UFaAyw==
X-Received: by 2002:a17:907:3f8e:b0:ab7:83aa:b19 with SMTP id
 a640c23a62f3a-abc0de0e4a9mr2494330566b.42.1740578213088; 
 Wed, 26 Feb 2025 05:56:53 -0800 (PST)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20121adsm335104066b.91.2025.02.26.05.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 05:56:52 -0800 (PST)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/3] emulation: qemu-sbsa: Enable PCI enumeration
Date: Wed, 26 Feb 2025 14:56:44 +0100
Message-ID: <20250226135647.194842-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226135647.194842-1-patrick.rudolph@9elements.com>
References: <20250226135647.194842-1-patrick.rudolph@9elements.com>
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

Enable PCI enumeration by default to get the Bochs display driver up
and running before the boot medium is scanned.
This is just to enhance the user-experience while booting the machine.

TEST: U-Boot logo, version, log output and the U-Boot shell is visible
      on the display device.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 board/emulation/qemu-sbsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
index f4ad63e681c..728cecae6b3 100644
--- a/board/emulation/qemu-sbsa/Kconfig
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -49,6 +49,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply CFI_FLASH
 	imply SYS_MTDPARTS_RUNTIME
 	imply SET_DFU_ALT_INFO
+	imply PCI_INIT_R
 
 if DEBUG_UART
 
-- 
2.48.1


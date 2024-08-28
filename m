Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D60C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDF288BCD;
	Wed, 28 Aug 2024 03:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TrxyX0dl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D68C988BDC; Wed, 28 Aug 2024 03:45:57 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCEDA88B31
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-81f8f0198beso303641339f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809554; x=1725414354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AemHjMH26JQitJdNApRCK9Jo6O02SdrZMmQcDiVpuwY=;
 b=TrxyX0dlSxDIsyO+FMqtXJfGifAeoKKywEb1y8ymcVYKwniavlHrZqBcaLFWdHRYvr
 QGzvPSavskC3IXaj7QaksBTqsfSflNl+VE9tLgKFTSVEBMhUxBrePuSiIYmbdlF5Y+BN
 ilSYY80NDht/6LpDrN9CmjTwuq1H035Qe9OGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809554; x=1725414354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AemHjMH26JQitJdNApRCK9Jo6O02SdrZMmQcDiVpuwY=;
 b=vsywCs086rCK9QzY8VwlFke+0NSpzqN9HiVsZmoewNo5PAWeWEf6zDN70DWYcLzMtL
 R2os1RWNxFIopKR1LhRpYL1nAMMEAQeA7RPqfhjh7Q1eWeo+4fmJwS9fBntttbOLleF8
 sRAVcM9SHKs3hBLPmWp9nROc0OuXtssRi+gGLa22a9HK/z+QTGkg8zNWR/6oj6tJMLFL
 sAv1OO8pNWUHGrcOaTKJYPCNiKhqVUsfY9T7viAESo3JKZwqM6FMerHqTyFOFF2O9r3F
 Zp9NnPGX8HVcrRhQfcbQanZV0DAbYbLT6NQs7dYQqL7H5hXVIzfgA7K0yTRjpDt6pSod
 RxCg==
X-Gm-Message-State: AOJu0Yye7yKYzyMluQArLjBpoJeuJHoE6NzUEQVao6a/eLhh9S2dBcZc
 ZyfaImTD+CdrVoqejqrQmQdp6m7FTyPN3CgPwcwfAlt6lByLYf5fhu/cIItuAj1g9D+5AzQZ8hc
 =
X-Google-Smtp-Source: AGHT+IES3/LEAkaZzmnkeoLFCJoPAdIchLv1d/jRUn9DYSG3fW8RYavHxafs+ePEg079/OcpiM3tPQ==
X-Received: by 2002:a05:6602:6b84:b0:81f:69c4:e026 with SMTP id
 ca18e2360f4ac-827881cd945mr1467797639f.16.1724809554381; 
 Tue, 27 Aug 2024 18:45:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Robert Marko <robert.marko@sartura.hr>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 08/18] serial: Support debug UART in TPL
Date: Tue, 27 Aug 2024 19:45:27 -0600
Message-Id: <20240828014538.3322013-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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

Some boards want to use the debug UART in TPL so add an option for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/serial/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 3a1e5a6f287..8b27ad9a77e 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -539,6 +539,13 @@ config TPL_DEBUG_UART_BASE
 	help
 	  This is the base address of your UART for memory-mapped UARTs for TPL.
 
+config VPL_DEBUG_UART_BASE
+	hex "Base address of UART for VPL"
+	depends on VPL && DEBUG_UART
+	default DEBUG_UART_BASE
+	help
+	  This is the base address of your UART for memory-mapped UARTs for VPL.
+
 config DEBUG_UART_CLOCK
 	int "UART input clock"
 	depends on DEBUG_UART
-- 
2.34.1


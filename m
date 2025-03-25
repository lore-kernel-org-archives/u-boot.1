Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB1C36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABF381D4F;
	Tue, 25 Mar 2025 03:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hiZ1ppiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF6D81D4F; Tue, 25 Mar 2025 03:55:16 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0D0819B1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-477282401b3so33474751cf.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871312; x=1743476112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0UsQxRZcaybRAIz+9S6YfYF2DHjN3m1SOrqmWPzXtM=;
 b=hiZ1ppiPajzay5NN7ZgKMwtPLDJCjeza/gC3jit2o1fTZfYO2/uR+4sU0QmHTHE+bD
 ei1zkahEZI8Kxaz8rcWMLj6YtyEKlqnqRsmfCo+9SLZfBpScm0rYbhCa9Vwpk/NZlvse
 gRyde2XeFiUqZZNPUZNCzus4tt4vd4E+N6wbkXrYS3ugpVh8GMiWsNMQAmFt/Btr4H9o
 Zf1JDHR7XtVppTI6S5ErjZqz7rDD9zYbjFrb96bN3NJa/2y2WWhINEpn8SH20nXj8DTK
 si0k2fbiSrdeGw9scul6/ZB8/Gu9obVf7OX6EXw/LDGOZFs3RjFKWu4OWgDpR73Npj92
 kHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871312; x=1743476112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0UsQxRZcaybRAIz+9S6YfYF2DHjN3m1SOrqmWPzXtM=;
 b=njrQsBlsTqSkgCJ9GyA1c5T6+CvKW2US8zxU7pA55JJztbVS8ykXFiW9Em3IbQdReT
 7abEvQ7s5/qQ859aRaGNg7NtMvHOS5EGRhyqbdMjXd4j4l3yCSJjnYy11es1I66Vo9jH
 1IDT0ZT3UlHEgtVrVztKb/joPQKmQSj1iIqDr7jtNpcjCnAd7lwKLOvSbMl4fot/iKzd
 9pf3ziwHMAHkgRi/layZkkY+5ze3AfpB7EF2F9S+DbfVdLGsCO0WaFSctD7N6J3d3bUy
 n9+1Pyc7VvBcTKyEdmwvwZJanNiQq83gYM62UW2oHjVsm6osdi1HBVoRocaMwJKOkiob
 hgLw==
X-Gm-Message-State: AOJu0YwlASVYdfVQZtN+8wN2CrSzLmUUH9ilA+VHXOUMreUCi1Kc1z7h
 /OLMcO59p9onnjFZLz7meA+LvVFnK8tVjyKKWFFssTijgfLg5FtkJxeSEw==
X-Gm-Gg: ASbGncvJUGH4zzi+ii1ypJxP7vbd0sQT0EPREkEJSBM0GR8lMItAPTbdy53+/1ecKLB
 pvNBluIKF/9u+EewCRr5vL6HRt5/4nqlUcoaN0Q77cPHTg2qpfJ0cAzMRT7pIbyaf+io2UMSgwi
 MeYghtGJBkKNHVXW1Xi0NZQFW5JhuPTVoQx+B81aQNCyLN0u03gEP/YarvW6v9Xk+mN21fTd8W4
 yTxA8rHvGceeNJaVtdeAJ/ASMCRLU3AriO7NEYCljLXc8oQ7h96/Vn2NvAkIbJV3F/DYZdk6Zep
 ocg6MRINQZADyKugU92evgnaCWnv0cOvKZWqGZyXBSJVVd6zHF2QAd98omCn3ashjkTl5DgVyX6
 GH1HoK525CeIjB/SM6VQ=
X-Google-Smtp-Source: AGHT+IFMS0gdVtJS2mHd+sJRSwlIcaWc7NInuxL4m6hgHACuZP8mWSY8l6Uy0oLMIORFdbO/epW72g==
X-Received: by 2002:a05:622a:5511:b0:476:8595:fa09 with SMTP id
 d75a77b69052e-4771de1584fmr239010611cf.40.1742871311662; 
 Mon, 24 Mar 2025 19:55:11 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:10 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 3/7] imx: imx8m: Imply IMX_TMU
Date: Mon, 24 Mar 2025 21:54:44 -0500
Message-ID: <20250325025452.950303-4-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
References: <20250325025452.950303-1-aford173@gmail.com>
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

If the CPU Information is displayed from imx8_cpu, it displays the
cpu temperature grade and operating temperature if CONFIG_IMX9 is
defined. This behavior is similar to what happens mach-imx/cpu.c,
except that the latter checks for IMX_THERMAL or IMX_TMU.

In preparation to make imx8_cpu act like the previous implementation
for any CPU, make IMX8M imply IMX_TMU so it will be always displayed
unless a user decides to disable it.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 89f2b50c8a2..8ee699a343c 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -8,6 +8,7 @@ config IMX8M
 	select LTO
 	select ROM_UNIFIED_SECTIONS
 	select ARMV8_CRYPTO
+	imply IMX_TMU
 
 config IMX8MQ
 	bool
-- 
2.45.2


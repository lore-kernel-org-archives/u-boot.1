Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D2DC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E33681219;
	Tue, 25 Mar 2025 03:55:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bl9vY7Hy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5CB681D3B; Tue, 25 Mar 2025 03:55:25 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EEF80107
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4766631a6a4so51607281cf.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871321; x=1743476121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cahiz8eSpjQqCaDiF7Wowg2XzKSzshqMzs2oIOXL3tI=;
 b=Bl9vY7HytccrAAz3YZxg72zhMFNuopyy5AQ/cAUovuinLxjfVqMciIkKcvH0dPhtE5
 7qJeKto1PUK4KNcwHQWGG7zoccHD7NoHGIAZ45/bsD2By9MX1j3J8M+qYgMZtWKI/NN0
 Blrkq++3xXTDUwQAjUp6KCyWkVYbCx5QtObz0PsxZEZ7u3NeiEhBDMNF2lof51RUXh2G
 62fCZYZzzzJwWzdF/KQexsJTN7i2XtX/l/s1WEvS2eCWkNtn2aYcxgImQk2Tlf+pWFgc
 LgVaSDkV4bUyY10NWPV505gsajURuMI5W8YFvlrKcSAsS6Vtt4ycY7tiIwpa5Lx0GxX5
 aElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871321; x=1743476121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cahiz8eSpjQqCaDiF7Wowg2XzKSzshqMzs2oIOXL3tI=;
 b=OpzI+cd4WT7ul/423XxzIdD9SANXSo0p6hIPtTiAUYZqKdLWcrp1mZriOczR5c7cg6
 QYPDVI7gmb/PhbaAY7g7XyFK8XWICIAUghgZRWyL9xf/rwkOzbZx3SbA4kGWDilez3rw
 WEf9jxg9s4J9s0m/uyfzm2y4TPNa5C9UCbb10T5Y/Curo986W03NmjtAh7GsFX0vH4iR
 rEjRTGDcag7jcjPE2caeuUBq1404zI40DOW5jyiJobr1pAvhIFzwuGt24d/xYwrSpzb0
 XwYWG7iTndStoOcK66GlovWLkMBC9Y8CiN7HAiDbTuIH0mo6x2ffQVIDNldZO7gbLHep
 B0FQ==
X-Gm-Message-State: AOJu0Yyh4I7J6shBsIOQSrM9X1dsg0tlPDUg5sikebQowhXIyuCLZWwR
 hMLes/+s3XF+JKfc5/meMNzAOh/bt0WehhfRFF17GZtXS3LZr4WZsJs3FQ==
X-Gm-Gg: ASbGncvDommJRV7At00K38zE4KF5uDHEaUXpjDTA5ogodboqpOpJ2WAUAXZxF1ssEX/
 /58QVAWKQDH+Zisy7QX53CnWfoPoQI1bR8bpdJnho0+dKF/dZcIAZiXYDbWaOfQ1GH1qZ6dalBT
 ajPYXAd/6cQQgXv9jqG5HBfbFB3e29PUajZms0wgggoWyxsrlsp5dSrOwLJMkBAwQhlnJF6rPfR
 NvV1Hvgf+XDVqRR1KsOy7kK4qNTmv1RFZFAfLNx2mWgooafgh5oP6otayujF5CnSVtsintqZ1UP
 n2T19/gczccU8edUL72nXx23cBPLWm7ggNK6bd6+9RJxPKvOcPgv7Qdk47GBLtjQJUHM1skyyDM
 SV0LEUhyCZQzNDGukn3I=
X-Google-Smtp-Source: AGHT+IFbEqT1R9aaR5Fp8VzfsQ7eWfKoH1xrcuvX6M/FdQjIoZ78uSpuwiMYgIkeJuDoWfz1FfL57Q==
X-Received: by 2002:ac8:6906:0:b0:474:db2f:bd32 with SMTP id
 d75a77b69052e-4771de10564mr248865841cf.38.1742871321520; 
 Mon, 24 Mar 2025 19:55:21 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:20 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 7/7] imx: imx9: Imply CPU_IMX by default
Date: Mon, 24 Mar 2025 21:54:48 -0500
Message-ID: <20250325025452.950303-8-aford173@gmail.com>
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

The imx8_cpu driver is a CPU Driver that supports the i.MX9
family to display the CPU type, temperature grade and
current operating temperature.  The older file,
arch/arm/mach-imx/cpu.c, does not support i.MX9, so this config
is enabled in various IMX9 boards.  Instead of having this option
enabled in every IMX9, select this driver by default for the
platform.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c3e758e103a..1ccdb1cf64f 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -8,6 +8,8 @@ config AHAB_BOOT
 config IMX9
 	bool
 	select BINMAN
+	select CPU
+	select CPU_IMX
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
 	imply IMX_TMU
-- 
2.45.2


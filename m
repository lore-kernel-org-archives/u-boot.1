Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C901EC36002
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 413D281219;
	Sat, 22 Mar 2025 19:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b97ynbrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BB6581CFD; Sat, 22 Mar 2025 19:38:39 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA67D810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-476a57a9379so43427291cf.1
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668715; x=1743273515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0UsQxRZcaybRAIz+9S6YfYF2DHjN3m1SOrqmWPzXtM=;
 b=b97ynbrVuu8LcQ3wqok+CafJ/j3XhxllY28ezJ32Z1HKyjta0Pwigj8woX+hzNF+rv
 yDbl8QBXSZj8FfzEKG5eeZ8YJpFYxwymFhYbNvfn7moxAJs9Hi8pdh3NTiL/suZEEN2X
 lLx/evMVKdRCa+EVJ/XJVQmsM7MLV1xfq4UKP4n3yOvafW+sjGwnBKFayAnlw+Rm3NwF
 XfOP+0CKijlSSnTPqgxcha836DjB7Ff/wP2cyhTWKyD+mRkS/2UdWWyfhy60qNu/oSr/
 09rlbS3Qm+h7m9FHQjAwgCp/pmuK7olQvWaIr7Bc043OvSMevXHY1S2cjjZf426Uw7nS
 sppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668715; x=1743273515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0UsQxRZcaybRAIz+9S6YfYF2DHjN3m1SOrqmWPzXtM=;
 b=ac0bVcDpszueigNn+YLlG6JyRZOJftucrvHLBw5iDqlM45/Pk3US6obJ69RMSQ173Z
 9J9JVYC6alr0ZllH+RDxXBvppjgZ8UZBVaPz6TlYP7SXvQF/NCG2ekNG/X55sE2wsmUp
 uh/KFyRaNWS5RFYU8r8pRAfEv2V1oJS9bPQsGPMmwLgtVN+tsZiLr4ZwfFvwwk8RQDFG
 vxRSVgNTtTUU8x5VkwRupOImLSs7dKkY6S/NZxaPe9ruWpX2pYVeeOtdngHempEYbcS9
 kdtAhH1q1hWAE2M8lNiNQIuQOKb/1MSWN0IdmyKC2/+IKXqlG2rJcSy2XpXrQY0pQYq7
 FS/A==
X-Gm-Message-State: AOJu0YwLtQqkRXr1jpr53zgy0POSJaJzjRPzpKXH6OJFDTQw/nk1gSEi
 XppREpA4n/G7Z+jcUSb4+AQItIxaJIacjhF8+futTXIoACtOKnwQAfT2bA==
X-Gm-Gg: ASbGncstcr29LjErwLSuvV4IFoclm/5lkbia2wrT08Nm6dTqN2IL1MUm+kWE+dBThqS
 +2qmP4PaGWIma5skUHeevMRUBVSFwds13de+VPUD+ayaeZmIAoTtapyKZy2k/kJ0K/nyVqaBvwU
 pEw0Fd5oriWisKSnk2o2HAlnEuK0MzKZSxBT6IAqTsXOXW4kIwxBhofX9tLALRnJDIMrQ+ySB1j
 UposRJQhj6AoSpmoRJOjOYFm2K91OddkdnBfPJ3Zsix0pMymrc1OHIcK9JTKCa/vsTmmtibckKg
 ctijMPqypbkAGmaaB/4Tyo4wJ6QFpp/HX9GwoYyG2uex6UXa8WWECDow3Au0GeQ5V999mn75iC7
 BKeYikeNr2iLuFRZqO2RwRygjmGPgwA==
X-Google-Smtp-Source: AGHT+IELzrTInx3mPpKaXIpuompKKmOBygbIwY/jktn4Aefs+u6oExypD57WL6p4lFGUUMPRO8a+PA==
X-Received: by 2002:a05:622a:5814:b0:476:884e:52ee with SMTP id
 d75a77b69052e-4771dd60828mr133192131cf.11.1742668715109; 
 Sat, 22 Mar 2025 11:38:35 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:34 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 2/6] imx: imx8m: Imply IMX_TMU
Date: Sat, 22 Mar 2025 13:38:04 -0500
Message-ID: <20250322183812.784676-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250322183812.784676-1-aford173@gmail.com>
References: <20250322183812.784676-1-aford173@gmail.com>
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


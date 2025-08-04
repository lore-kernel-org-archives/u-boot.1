Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E1BC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48DBB83FED;
	Mon,  4 Aug 2025 23:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IgScN8yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B2F83B1B; Mon,  4 Aug 2025 23:54:31 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42CC83FC5
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:54:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3e3f0f29d09so16032525ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344467; x=1754949267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gkw5BY9nqM7uAbBzvlezH1HBmMgSTN0qJdSf/hFl0oY=;
 b=IgScN8yo+UdBxLk6/eSc4y6lUy/g+r6E/TdPKXeYBQkqhFpe8C5rPBl7C+Hy7kw010
 ayn8z6dUA2C6hLRkVeCWFILxEM1tT83GDTFHvKEC42jvTsMdO/+/q6zxW9BHz0cVjrwA
 DwKBMhnNx0jp0isARQ7NuIU4VjwUIzWnK2RAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344467; x=1754949267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gkw5BY9nqM7uAbBzvlezH1HBmMgSTN0qJdSf/hFl0oY=;
 b=JbxNM9VRmu4o5E7TFYhemaM2lsOR7Uc9kVFeGpaJmIpmZGq8WEl9rcV+L9pXPoWEhH
 lhHcLeberCEYKiyRwlEkkpjEEuvC+EltoHHEHe59gJBKUzTC16tdLFlgnAo+vANH4uwQ
 Es9mURNqdJEc/iGyycADXp+8aTjwXZOjcS0v2jd5+Gi21sgVaCA4oXI5Qo1rSL5azuYu
 XFYOUFf6BuLFtAXL2AsmEx3QRA0/Hn/ioCU2A0tC243nRH0RTT/ROf8CPklHLW2gZ6Vb
 dAuy+jFmO2tPlKjNRU9gqlGLDVqpf18cM/4od7BCCksO004diHTVPAE8XS5k8E5UZj3B
 KfJw==
X-Gm-Message-State: AOJu0YykQF8tTc83D4Pl/2sNNq3zEVEnEFzAdOzrEgz7VVEDhIPPlvNU
 Vp9gqwTi04SqBZC1QbMFRb2LH9WD5pbHDTjBcICtkTky5w+Xy6HWQecCrsPs0B7CxMLTwiqrKZI
 eG3Cevvg=
X-Gm-Gg: ASbGncs43hBVtjaF7WUhDIY7Q9kAW6O9+D6ndy8Ovwu/Tdhr3dhbHMXqWNWUia2wKe7
 2JYi//hNe51PBc3upjBqsTjkjjK0OIsh/cfScTc0Jseu9AI+PEIIoTbRIKI7Y34MzICi1o73OMS
 XbEerVD26otTuD/12dlFfOFGvW4aHpMblBpySNfFPqeq9DcO7lwqlnuQqoi0bcAbsxiHvHHHkLF
 qLtZUpC7ur8PytEr1sWmR4Fb4QZOzbwmg7c4sYOMIP4xCDfwMqV4MeXBM7zAqXTX0gqfHnsReYa
 T4/K9sqtvR2rTpOsRGFUWAW4F7wH48odutNp4l0NBy6PEYZzhdMW6Z0riu1PjxirSPEw7fflOyo
 MmbIT2K6ysC1+G8JUMKeKhmz+JIMVNJBZCs5KJzZtkhzvDMbRPgahT2G7cE8pu6iDr2/P
X-Google-Smtp-Source: AGHT+IF5ik1AEvqTaAn6x65u/k79TtGMTZqGs+J4xtPHwpddncNIMGRnAmsaThkjivFdOvqsQkO7UQ==
X-Received: by 2002:a05:6e02:2386:b0:3e3:ebf4:d2ab with SMTP id
 e9e14a558f8ab-3e41618be72mr212773455ab.10.1754344467552; 
 Mon, 04 Aug 2025 14:54:27 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a7ff89f02sm1996337173.31.2025.08.04.14.54.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:54:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] remoteproc: Tighten some remoteproc driver dependencies
Date: Mon,  4 Aug 2025 15:54:24 -0600
Message-ID: <20250804215425.1412704-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215425.1412704-1-trini@konsulko.com>
References: <20250804215425.1412704-1-trini@konsulko.com>
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

The TI IPU remoteproc driver cannot build without access to some
platform specific header files. Express that requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index a3ecea05e20f..e9f19a694332 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -125,6 +125,7 @@ config REMOTEPROC_TI_PRU
 config REMOTEPROC_TI_IPU
 	bool "Support for TI's K3 based IPU remoteproc driver"
 	select REMOTEPROC
+	depends on ARCH_K3
 	depends on DM
 	depends on SPL_DRIVERS_MISC
 	depends on SPL_FS_LOADER
-- 
2.43.0


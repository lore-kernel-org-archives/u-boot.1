Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF190C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 21:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B068E8804A;
	Fri, 15 Mar 2024 22:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KHYCPbmx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E668803A; Fri, 15 Mar 2024 22:57:42 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F5187F6F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 22:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dc75972f25so19150295ad.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710539857; x=1711144657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E+09vePX2RPdwDuOquD7LvUyRw6lnyD09ef8pQX/cRU=;
 b=KHYCPbmxYeW3WyqkkHbmy63exWIiTn2EVjYAoMup6IwnFHfYfAIbPuu32hsnYbHicC
 Dsk0aPoNKHbkqtzWdhF8CdR3K9WVin2bh7K7pjDHS2dGONQmroOFiRjLUkSEJYmtPgwe
 jdW3QC/dA0QRqqZhd78JlzqIAhxdJmLocFvlsDQwovGE7qo22BJdDHMn8w4gsHtMUuiT
 slDSKqDXIPLwsyr2Jb2e56ZKn3Nb0Qny75I7loJmHVKMQ9oXU5Xb7TizSoRjFjhmGtwl
 biG13E8A5OFgQ3wokJCmoB0vQFwx0O2aYETkD1WydtBW/mnHVQTXYMYcMqJqsjgR707o
 772g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710539857; x=1711144657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E+09vePX2RPdwDuOquD7LvUyRw6lnyD09ef8pQX/cRU=;
 b=iClb7LET3oV1DwjYOYPNN3NB5DrpgfgxUPUr+m/5956YC+ILAsQQRsP9HuMc0uzWXj
 SYRViw7ndbH0Jb4nsS2Po3Sr6WPvGg2YYNSSmvierw/aXcH9HWzZ4UM4/cV1/kuzjygd
 4GB1CQBDthfmco+IP3AsXAIXQ+vqgActGdPvC57WPJqUmiv7RB1yJuh/MPlHr+ylyE9Y
 4cvZObIBurxKLddDddHvpcjtyocItbuWyFo0PfzIRmgUS6rv4B1oonPY5a2M+tEQap0F
 llgOQCiLFc9r7uuaVWBsvOjOxjXV9BWf/EKvABZcbmBCf1CqPmEnpCINX40HzDdN15Gt
 Fw0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp2YHtEuTMNN2Pp7JU1t8AHkZU85XClc01b0rFg42admS0OeuP/ejNV20AdvtOmWSGJTtpLTE1EoLjQURhu+dUEP8tQA==
X-Gm-Message-State: AOJu0YymX1wLxwNibfbwJzoY8k1Mt5H77nM/ejScBHcFBWsMtRex80tT
 eYn088Dj+dTB1eoOMRfV+ItGm0VC1z2GHxxRFYg30vKlVKES9EVQ
X-Google-Smtp-Source: AGHT+IEULpfGCkgd69D6vIigJYz7O9dR8cd0UOulVp1QzacJBlO+rdXRS5p7rDpcXCuAvW27EvXIJg==
X-Received: by 2002:a17:903:22d0:b0:1dc:fca8:f9b with SMTP id
 y16-20020a17090322d000b001dcfca80f9bmr7515517plg.3.1710539856798; 
 Fri, 15 Mar 2024 14:57:36 -0700 (PDT)
Received: from frhdebian.. ([2804:1b3:6602:ff36:f144:8c19:ce75:7f2f])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a170902dacd00b001dcfc68e7desm4353315plx.75.2024.03.15.14.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 14:57:36 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Francesco Dolcini <francesco@dolcini.it>,
 Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v2 0/2] Update and improve apalis/colibri imx8/imx8x docs
Date: Fri, 15 Mar 2024 18:56:55 -0300
Message-Id: <20240315215657.160967-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Hiago De Franco <hiago.franco@toradex.com>

Update and improve apalis-imx8.rst and colibri-imx8x.rst files with
newer software revisions and instructions to build U-Boot and necessary
firmware for the imx8/imx8x boot container.

v1:
  - https://lore.kernel.org/all/20240315143930.29155-1-hiagofranco@gmail.com/

v2:
  - Add Reviewed-by: Francesco Dolcini 
  - Add a patch for apalis-imx8.rst as well, improving the documentation
    similarly to colibri-imx8x.rst.

Hiago De Franco (2):
  doc: board: colibri-imx8x: Update and improve documentation
  doc: board: apalis-imx8: Update and improve documentation

 doc/board/toradex/apalis-imx8.rst   | 32 ++++++++++++++---------------
 doc/board/toradex/colibri-imx8x.rst | 23 ++++++++++++++-------
 2 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.39.2


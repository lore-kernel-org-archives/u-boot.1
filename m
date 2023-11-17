Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACC4C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 07:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC9A86FB7;
	Fri, 17 Nov 2023 08:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UadiyATE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE95786FDE; Fri, 17 Nov 2023 08:53:14 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61061863FD
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 08:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9dd6dc9c00cso235021766b.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 23:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700207585; x=1700812385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6j8Ygf0AQTvc3l7HfA+uvS2JOlSC8Sq7YYtyuq9wtE4=;
 b=UadiyATEuwnbbk4clhLLR4v+c0d9gaHinj7UUbboGJZnCpjlql3DEGCw8fqxZnIpm/
 vic4tkXE0jAP5W8F408z/wy+YYeqGOgjVYlP7NzOOf3epW3O61sFeSWvPPHUO2cFcLSR
 RUPSkKY9NNpVvNvNLd//I3rcDnOX77ByyLGEI9qELIYh5x5CniOYBcfprgK7pXN93O9Y
 bNMCjRRBXonvDMUud/NUOYn6JR87xPg8BV7zdlk7DZhuauik0Yv9ubUq0mA1Rbn8KLT+
 A7TdCKgQy04ZXhB3c792nnBBdIjZkkLxGAdLQem7z8JZr0QwvY5P936i0qrtXplrMFfz
 uatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700207585; x=1700812385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6j8Ygf0AQTvc3l7HfA+uvS2JOlSC8Sq7YYtyuq9wtE4=;
 b=WSp/OBuBeFJ0ubxf5sN2lt8GerdPlfS7ehu17iipKcajZF4qWJ9xMcC+OQusGxkPA8
 pJscfX2zv8XkpPs4Kdt7/O3qczXGku1WtyHnlVQqZ7SZBv+OyMUbAjwxTJcvHtMHro96
 ObWNBm00mh54NJhJjVuVH2KC55D+lzMLTcoI3raHWlLZua+PBg6qP8Rin0N6lJYJ7PvQ
 2JTCRDVt0pfwFhDokGgqpGIUc6JVwy4r4MgJcRJ7QFawQzn/uorkENv2JroEyG5OBkj/
 sFOHzFMa4q7z+gJiSF3tQ3dEGDSMrk3HmO8t2Cg+U1ZuHxPDNhmaMrkHoQcVn6UPRNVe
 lElA==
X-Gm-Message-State: AOJu0YzwYatXLIg6e4IjY5vIkoEBz6V03i1LR+lDdvfageOfxqvaO1d0
 MSM7tKnrRwG18JnCtFwv5Tk=
X-Google-Smtp-Source: AGHT+IERJiv9pPcmXGDDPdpsjRHKmm60uh8N33l6AcT2E2boEFLoZK/tju1H/VFRMYQVhIlNU+5u7w==
X-Received: by 2002:a17:906:a0d1:b0:9e6:1ee5:be0e with SMTP id
 bh17-20020a170906a0d100b009e61ee5be0emr4285562ejb.21.1700207584656; 
 Thu, 16 Nov 2023 23:53:04 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lo7-20020a170906fa0700b00988e953a586sm503967ejb.61.2023.11.16.23.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 23:53:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Fix clk-gpio driver
Date: Fri, 17 Nov 2023 09:52:39 +0200
Message-Id: <20231117075240.15741-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Existing gpio-gate-clock driver acts like a simple GPIO switch without any
effect on gated clock. Add actual clock actions into enable/disable ops and
implement get_rate op by passing gated clock if it is enabled.

Testing current driver implementation shows that it is not fully capable
and lacks gated clock manipulations.

Svyatoslav Ryhel (1):
  clk: clk-gpio: add actual gated clock

 drivers/clk/clk-gpio.c | 47 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

-- 
2.40.1


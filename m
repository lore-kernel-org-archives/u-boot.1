Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D64BC30653
	for <u-boot@archiver.kernel.org>; Sun,  7 Jul 2024 08:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9D588427;
	Sun,  7 Jul 2024 10:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qsLDZ2Zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1FB881AD; Sun,  7 Jul 2024 10:20:09 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3618882B8
 for <u-boot@lists.denx.de>; Sun,  7 Jul 2024 10:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77cbb5e987so207090266b.3
 for <u-boot@lists.denx.de>; Sun, 07 Jul 2024 01:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1720340406; x=1720945206;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qq4IE2LqkFUiiBPDh8OElQvcVLMBfb5hlV+0J9G5jls=;
 b=qsLDZ2Zmsm3lULyWN97qbZ7Gz3fnshdxlcnlK7d67GAk24X7DkcQbbL4mRZhVIsrmN
 dF7ku8pwjWcscKFADyokYwwsaQ75dKJrlcKURrPVa0XcqjHuil5wktMcNpOFHel8CW0A
 JFfl5UG46TcoH1+0FCmXFJGrkGfPHLcW/OggM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720340406; x=1720945206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qq4IE2LqkFUiiBPDh8OElQvcVLMBfb5hlV+0J9G5jls=;
 b=GShR161uC53FiVio6Zhd6WwApIKWA9iwR5jstN0mVAa6xGjdWOOps+blMIDgl+ELRc
 VH/zei8aitgeU7RLPQqy8OnRlrH3MyvE8dLo8ZyHZh+1b2fagBKYCYd9SSvjkMWVrjOG
 Cz+oKOS5e8ciQ9iOtTm5xBkhWr/MwKxHxPNQk1gjx8n48R8iUwyly7MoiMkbKuexItza
 DsgsIPl5BnxhklrJXw1k5wJRmU76kh7BY6dtnNDZPWqXEB1mpl63bGYbtvdimZ/6Ktvn
 iP0Srmmcu0YYELP01lV9dGluk9Vtz+37vJ/mzTCCostWxFJdbcEpU7yNORC0mCyPtTbL
 rICw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQTgkH3lLN0v11RsnFM+eA4B2cKRlPqlrqXNtwpwZlIFMjE1WJ0X/7yllXzRulpF/S54oYJniK+1lt8Yr7pRZxkR4qBA==
X-Gm-Message-State: AOJu0YxfbZk80wrw3Cizy0ayNVzsObHB8RyOqqHYz0ZUq1Umqw/jpGRc
 yI5ZtMp194Do91ul2KSHIc89bPzjgKEozfLn6GQlfcXMnH80aLCZYqFJi0uGU92/Flq8LYw7D16
 csK8=
X-Google-Smtp-Source: AGHT+IF+J0btHsrn5tWBT603FFkXVVkyssq7exZWPGRqZPtab+M5cdp0TSVw7X9KNg/4jLhwX8epnw==
X-Received: by 2002:a17:907:991a:b0:a77:b3c4:cd28 with SMTP id
 a640c23a62f3a-a77ba44d1ccmr634167266b.9.1720340405964; 
 Sun, 07 Jul 2024 01:20:05 -0700 (PDT)
Received: from panicking.. ([109.52.6.228]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e4a8092dsm111708666b.58.2024.07.07.01.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 01:20:05 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, linux-amarula@amarulasolutions.com,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 0/4] IMX8 series small clock update
Date: Sun,  7 Jul 2024 10:19:57 +0200
Message-ID: <20240707082001.20746-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

This series is cover other part of my internal review work, that
will allow us to support the video subsystem of imx8mn. During this work
I found some small issues that fix several small problems but it will
help as preparation for the video one

Michael Trimarchi (4):
  clk: imx: clk-imx8mn Fix nand and spi clock parent
  clk: imx8mn: Make parent names arrays const pointers
  clk: imx8mm: Make parent names arrays const pointers
  clk: imx8mp: Make parent names arrays const pointers

 drivers/clk/imx/clk-imx8mm.c | 157 ++++++++++++++---------
 drivers/clk/imx/clk-imx8mn.c | 151 +++++++++++++---------
 drivers/clk/imx/clk-imx8mp.c | 242 +++++++++++++++++------------------
 3 files changed, 303 insertions(+), 247 deletions(-)

-- 
2.43.0


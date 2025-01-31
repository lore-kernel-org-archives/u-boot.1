Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB8DC0218A
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 02:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CD880F50;
	Fri, 31 Jan 2025 03:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k26m6Q3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B3680A46; Fri, 31 Jan 2025 02:39:10 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955C980C96
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 02:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kikuchan98@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so1942894a91.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738287545; x=1738892345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=igO7J67+FUUn9lSAcCZ2EqHNS6t79l0rV01arCa9MKc=;
 b=k26m6Q3Oq479Qr+lH5haeJNDRkfqgcm8gtxYuiOHDpibGg0dLiAgLqnPkC8/r4NFCD
 W/Vd7VU8bX+vhPI3PgMw6xE8YQ469xr/VCSlsAFjgsdVymTeNubP0IKxEIloyQVcJ67p
 YQ3Bv93+frBy14S+TO/m+EuHOa7mhvuwto2jxZcWcK25jLi88ElCw70AI7fuwotl1tpp
 EWOaRSVHg3ve9z0Ctx/KeUGoLvRQCfhG6Rbyjgd0eJXkbZY5c8Q/xhqUBkL1B5gBRkM2
 xAmq3huFyBreJ1ClI50T9NIZB9ZU8JJb3hjX6BYidnUixyDRswsPBcf/yYffLjMmhqdk
 5PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738287545; x=1738892345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igO7J67+FUUn9lSAcCZ2EqHNS6t79l0rV01arCa9MKc=;
 b=TRlgY46AuNBw2e+9FR43BRFRFvVtec76Jr5UW3iIxqjhcOAXGbs3wP5pPYpODxYCQy
 /qPC1B1fg8m0cKJYvQ++3pmZBVUOXskkhVkd3N6XiOKGBKp6U/wsJENpsRw/KzfwG+BT
 0UMxLVa1kqwaqhTUKdBavP8jZhqKmtOG3Txk8DPt6QBjt2dfqnyIoWmqgxOWSam7yovB
 5iyTLYe4oklzHlxMO2sUlVWw0mO5Db8R+TplA2/y/4s2ga9OmyKPkNeRZIj0D8Z6UuK0
 02fseNLcLBYVtsQUKeeplckbwkwYsxuOit22tElyragxzKQ9U/JfqMRQBOzgJG8X7Nop
 +hhw==
X-Gm-Message-State: AOJu0YwiavQfpM4fc+suXz4QLwlsDN3KBttsVaXCrS7X2KMe7vE0zZSS
 Ht3ITbMBuZcM2r+kV1s2VOfqCIuqP60Gt5fNYgcJ6g4fa93KEIryt5MG5+an
X-Gm-Gg: ASbGncs9ZNQ3pKbFfukICCK7AVgrtDqPChEMtKuBodfCOKKtst0S+5AJSK58XOGigaJ
 lxwEdLTkbvhiXP/nrm+6BnWjSY1mPj00tQU00Qz2MTdrhyKo3WjFCmhPi6ZdcC7y8pQCI5Pmo3D
 jvrC7BkTXdeMxKforacjJcVavCaJDqtx8AHNxJGAkna2zxeX4piTR1/r3mRyFjAfKufCC9Cw/oa
 660AYS1PVtQVfVNn6ufv9jB4cwfQ97024CxYE7S7K/nCWbUKRuX9p8r/prHASllya5KNfZddXBK
 PcK0PA8y2xGSJuVG3qcLQ9TfeIk=
X-Google-Smtp-Source: AGHT+IGS6KRv5LgOvU7tG4i0jG4O46wwCHtPK/UAGo5HBR+MMlooLuxyzuVE3J13yG3fCOo4C7Kr3w==
X-Received: by 2002:a17:90a:c2c7:b0:2ef:33a4:ae6e with SMTP id
 98e67ed59e1d1-2f83abd996dmr15827954a91.12.1738287545048; 
 Thu, 30 Jan 2025 17:39:05 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de31ee01bsm20081385ad.47.2025.01.30.17.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 17:39:04 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: u-boot@lists.denx.de
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Software Engineering <wd@denx.de>
Subject: [PATCH v2 0/1] spi: soft_spi: Add support for SPI_3WIRE
Date: Fri, 31 Jan 2025 10:38:40 +0900
Message-ID: <20250131013843.3844148-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jan 2025 03:40:28 +0100
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

Add support for SPI_3WIRE on soft_spi driver.

v2:
	- Remove the wrong patch
	- Add `GPIOD_PULL_UP` to prevent the bus from floating

Hironori KIKUCHI (1):
  spi: soft_spi: Add support for SPI_3WIRE

 drivers/spi/soft_spi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.48.1


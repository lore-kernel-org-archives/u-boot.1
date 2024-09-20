Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D384CF58E0
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBAE893DE;
	Fri, 20 Sep 2024 09:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nss5sCwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCC3893EF; Fri, 20 Sep 2024 09:25:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD82893BF
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so15783305e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817115; x=1727421915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwBkOs9bDu7Hw+se9VudOUbKN6FDGhNYn8RcAN9fPrA=;
 b=Nss5sCwXfewB6ZzqOaqk18pWfy03GJqbnO5A0QKd4mTtCf+BC9bDJStQ4XnJkVVEmt
 SmCRkAU/bDkYDnoHkjQCF8/seTGUwbRajzHjjHIZV1LXZ5ttUgbV2yHpo+v8st68JGs3
 H7qYLBLq0sG5+fn1QfKlK4liYJiu4habTdjZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817115; x=1727421915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LwBkOs9bDu7Hw+se9VudOUbKN6FDGhNYn8RcAN9fPrA=;
 b=Xsf2HU1x7k8sSB5njX/ZJtoFnNbWyYtsZOaEBjAb3skFV9SG9+Or2LZNUi5FIYXBVe
 6NYbnRJz2xARyrcu8KbfbY1mD+lFZejBXtnotOlmlwyIUardDkDKMzMWDIVTIeaZsEvY
 0Lrpxe9/3s8UQZx9BP056ud8LquHeKitHmYkp4AsHyvzd8/6JanyPcehOVO5Lp0Rkjjy
 5kenxz+4ELqhWQfh4b9DpyNA2ARM94Es/sJTZwctQ7NWFO15k+CB9agQzVIHF2Dif8px
 xmDyebBMlM4S+EyIC8rXnENlIpF7tFdgwESwLVk3EWK7fruaEpM8Bl8umG9eP6oSGDQ8
 aJng==
X-Gm-Message-State: AOJu0Yw3mvxAHoTXPv/oqEHyXMhqFb+5agUJxLj6ZvHoQhOAC8r1QKRb
 WtG7CTah+pLko39mkOTd2JSRZLMw0aC0VnYXlfzORwVHV92Hz9fqKPfL94sqQ5siDAX+eVgJvfP
 Sy15t
X-Google-Smtp-Source: AGHT+IEqVRGSqLhKpTFXa/8QCRa7IJvjIHcx7eYbem8/4kJIslChMffvqghWFSSCE2jnvHYKIw2g5A==
X-Received: by 2002:a05:600c:5359:b0:42b:af52:2525 with SMTP id
 5b1f17b1804b1-42e7d143601mr7533315e9.16.1726817114841; 
 Fri, 20 Sep 2024 00:25:14 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/18] mmc: Support driver model in TPL
Date: Fri, 20 Sep 2024 09:24:36 +0200
Message-ID: <20240920072444.134997-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

Some boards want to use DM_MMC in TPL so add an option for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Default this option to off to avoid TPL-code-size increases

 drivers/mmc/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 982e84dc3bc..22c65681f0a 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -61,6 +61,17 @@ config SPL_DM_MMC
 	  appear as block devices in U-Boot and can support filesystems such
 	  as EXT4 and FAT.
 
+config TPL_DM_MMC
+	bool "Enable MMC controllers using Driver Model in TPL"
+	depends on TPL_DM && DM_MMC
+	select TPL_BLK
+	help
+	  This enables the MultiMediaCard (MMC) uclass which supports MMC and
+	  Secure Digital I/O (SDIO) cards. Both removable (SD, micro-SD, etc.)
+	  and non-removable (e.g. eMMC chip) devices are supported. These
+	  appear as block devices in U-Boot and can support filesystems such
+	  as EXT4 and FAT.
+
 if MMC
 
 config MMC_SDHCI_ADMA_HELPERS
-- 
2.43.0


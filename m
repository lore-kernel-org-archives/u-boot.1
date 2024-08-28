Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84368C54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C4288C09;
	Wed, 28 Aug 2024 03:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DdWvNVKu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FBDE88BE6; Wed, 28 Aug 2024 03:46:01 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104FA88AA8
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e856a173so99438839f.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809558; x=1725414358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMZ1XEvybYBo5tEuQSH7U4QrYUeXtptZ9+L0c8nCdhk=;
 b=DdWvNVKuo2Xvg8bZ+TWp5ay9mvY7F6QwdRAxohhmpdiXNhKOl+Mzb1+sZDrNIs67Su
 NqJxLQcoM/sop5Ns8fsAqwNWRTDWCtlteftd7qZPmtf6GnDVfjr2ogguvfMGiKkC//oN
 hyZw9ySfqWnUwx8axdt9/SaVNKNGa8mBRbHCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809558; x=1725414358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMZ1XEvybYBo5tEuQSH7U4QrYUeXtptZ9+L0c8nCdhk=;
 b=VyjXteaqKtSBCa3f96H6IRfqwx2hT/0CIuTqC7KPg/2VVSFiCc9N7zgD8z8ehorn1S
 g3t/nWfPcCFUUJe1onEU/jzNy8Uj/g/mBzyYc8rHKIySBKwz1I+OCOzPGyz9n8wAjFgu
 KSbLU7C4m9cPplzYNxf3OukwluGHKtohVdrhLic76sa9NMXX+Aaz1eL3zD0SwEwSLWS5
 95s88wdIy2tjwWVFfFCuTfwJT1M6Ypm6Y6Ml4OTIYnZJ5Wca1U8GXcenG5hR58/RHKAu
 xSGEVP6+d4sG0JrNCqWHH/v94AbY5bmNRVpC8eRDd0eQQxcL+a+RGePD6DYtrZ0i9hE3
 QENg==
X-Gm-Message-State: AOJu0YwWVSrfMeVDxe8cTidgdXFxoS5IDfd5sN3ygsn4Dq3YZQUOu94D
 2DTKodgDhHin29WC1M8M4og5SDyTpzbOdOBbP4lhN41B/R0Spo3TLwFNSfm37rCxM1FDpkGlw2k
 =
X-Google-Smtp-Source: AGHT+IHsGps1tZsqleSE1wXqRW6S/uQGYFcxu2tfnNswMYg7LujRIbm6MiJC+ZJhDtwejS42Dp5JSQ==
X-Received: by 2002:a05:6602:154f:b0:81f:8ae9:8f02 with SMTP id
 ca18e2360f4ac-827881410eemr1763927139f.5.1724809557643; 
 Tue, 27 Aug 2024 18:45:57 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/18] mmc: Support driver model in TPL
Date: Tue, 27 Aug 2024 19:45:31 -0600
Message-Id: <20240828014538.3322013-13-sjg@chromium.org>
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

Some boards want to use DM_MMC in TPL so add an option for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mmc/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 982e84dc3bc..2b55ddb7af2 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -61,6 +61,18 @@ config SPL_DM_MMC
 	  appear as block devices in U-Boot and can support filesystems such
 	  as EXT4 and FAT.
 
+config TPL_DM_MMC
+	bool "Enable MMC controllers using Driver Model in TPL"
+	depends on TPL_DM && DM_MMC
+	default y
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
2.34.1


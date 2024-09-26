Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE71BCDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6362888FD8;
	Fri, 27 Sep 2024 00:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UZY95rI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB11187B77; Fri, 27 Sep 2024 00:42:45 +0200 (CEST)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E3788FE1
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-45815723c87so12650171cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390563; x=1727995363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKQcJ2gEkVXmtIBN+wHA9VF54jyK+RUgfncFFJHAQZU=;
 b=UZY95rI1NAXe7tjdhcsaOtivEgNKTRg4wrxOJSn3N/hVakUvUQFiU5NyYjf5iqnw2Q
 b8upMB7uF3NhEVqfPIMDaM625adV9Dw52YBPjT1x4hMI6uOvA6L2GStyppXmwXchfiKR
 VF54F99E7mEB44EupwnA9hb+milaPTgzg7bik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390563; x=1727995363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKQcJ2gEkVXmtIBN+wHA9VF54jyK+RUgfncFFJHAQZU=;
 b=G7vIXT2vv4snPj7wPFImSs7IG0CZ9T5Kl1hAfrK8TlpWX1qmhFOoGmx0BSr45K4Yx8
 FxKwuoTxqndWe0W06XRUBmplWpgkQOe8y6o5ukvHOEM9ie8x8qz9z+lLvF0ORxxrAja/
 QVM0aNfNUllqCcHSE/1nuMgBGbYUtCemKFvKFcJg37KG44Kw3n3kZRelxlDlx+lGw4p2
 q/7uyX0Hyl1UXgnXzdZ9B/H8F1bX1rhUkFXgTp9mF7nFbz8Ves0dCPgpnL7VTXyb8QRa
 qis/nPVecfzrrTR99HCDKsVqj8ZC3l6VIgxD+jQRl8etoG0jp0oxvteDooio0tJXWXcH
 MwMg==
X-Gm-Message-State: AOJu0Yy97RLz0Y42rEzWuqgq4dH00ILm3zkea89gm5abhLLERNkf2ZN4
 MRJ0BYeCdzGQ/MQBnE0jza7xsyswmAZ69ce5g4eCVfV4bLkowDl2kit6DiTZ7rwTVrmhaWBuNVH
 QthZfNIM=
X-Google-Smtp-Source: AGHT+IEiDMsAoFuc/IDPZ12EzQZJocMm7Il0OLQD5Ugn5MrMGEIexNxEftG8AnFjRIwu1U1uwsQieA==
X-Received: by 2002:a05:622a:11c2:b0:458:2b63:ec41 with SMTP id
 d75a77b69052e-45c9ed4da27mr20198651cf.30.1727390562690; 
 Thu, 26 Sep 2024 15:42:42 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 19/42] mtd: Simplify check for SPL
Date: Fri, 27 Sep 2024 00:35:44 +0200
Message-ID: <20240926223814.1276764-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Now that SPL means SPL (only) and is not defined for TPL, simplify some
checks for SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/mtd/Makefile      | 2 +-
 drivers/mtd/nand/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index db010417b86..2388d2aa27c 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -16,7 +16,7 @@ mtd-$(CONFIG_RENESAS_RPC_HF) += renesas_rpc_hf.o
 mtd-$(CONFIG_HBMC_AM654) += hbmc-am654.o
 
 # U-Boot build
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 ifneq ($(mtd-y),)
 obj-y += mtd.o
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 68b53dced1b..ad02095b35b 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 nandcore-objs := core.o bbt.o
 obj-$(CONFIG_MTD_NAND_CORE) += nandcore.o
 obj-$(CONFIG_MTD_RAW_NAND) += raw/
-- 
2.43.0


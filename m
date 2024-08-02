Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DE9C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599D788BFF;
	Fri,  2 Aug 2024 21:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FsmLBDVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5208888BF5; Fri,  2 Aug 2024 21:48:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C89A884BE
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so55052775e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628131; x=1723232931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=znsWRXvbkdlyLYJm2hQZNHw2cNPsfhZhxH4KVY7uzeE=;
 b=FsmLBDVL1VkkpQFof7bM5fNSqD1yLjeR5FWjAkT5xrupJtLxhHhB33paYXa4xNXRxf
 EQr7Sm/YqU3D/L4TvFqboFm/GVJRsK16mMIwOvW29m/4wLHAlpP/MjUHTdikiuepmoQM
 Aot810gyIwp3RS2YJ7CUBaf9ijkDki7JvnGWNz2SPbIOBXFtNEPQlG++HKfUh6vk5EJ/
 T9BFYeIgvnE6cAU+pkRI5xg8/Si+9IToH5/M2oXGFvOY4zciHbTrswjIj43d7tJVwhbe
 WT/fCOCG9hHqkO7WdXYkwzyzXzgLO505sMBSKbZwGXAwyis0X0AzrBPEFn20OvKzYCnr
 BZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628131; x=1723232931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znsWRXvbkdlyLYJm2hQZNHw2cNPsfhZhxH4KVY7uzeE=;
 b=q+d/gbQi2YaOpZcayhMwNhGGwjxZca45gzw77FmJZ8vX/q/hDHimACC+zakm9q1EiP
 +rF0uSd4tROSjOOrhG05Sae9S+C9k9eHZl3LoBk00rab7KOtdP2fbQsQxReUDB1sSpU1
 /hvRwC30CAMT0PvjxVqUV+9nFKxsB96AC3OxTlkJ0CYWlFwozHIpnc7ikrqA3UeEw0lk
 49Sia0+csplfNPtjn0nxC+Tgo6dptT0rAse5XYc+L1qbav3JanbKBIjAa1mSg8umdFEM
 MalYvMSRHtPiSMMAglONyzKtyvmbM7FzsGCR1a5ztvkyqDHj2322BaEbZP6QLs++MixH
 GrXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfFTrhfoT/+PPYCvU35hGas2hpPWqx01QJaOlGPxwqv+PDdYiB+Ku3IxSAzCClIfmqKMOP5XEV/KgWoog4rc4WbF6HLA==
X-Gm-Message-State: AOJu0Yzviwj+e6fZ1w0oWl2rGWEDbJgyTNTxYZM6+bBNkCGEimm6ihu3
 QpDHxt2Z+tqcoW2Kl6nI/dy6Pt1gj2U3MkCm7BBUncPZ0q7b7JcT
X-Google-Smtp-Source: AGHT+IH3jE7a5miowM7z1AHRX9Mb38Q+vTwS7rn0eJ3YGoLCRYDv1Ofob9UIlEMBZV04jyihQeNgxA==
X-Received: by 2002:a05:600c:4515:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-428e6b9590emr25573925e9.35.1722628130513; 
 Fri, 02 Aug 2024 12:48:50 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428ebbe18c0sm24827455e9.17.2024.08.02.12.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:48:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 0/5] clk: mediatek: mt7623: clk migration for OF_UPSTREAM
Date: Fri,  2 Aug 2024 15:45:00 +0200
Message-ID: <20240802134511.23608-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

These are all the required patches to migrate clk and correctly support
OF_UPSTREAM. This will align the clk index to upstream to support the same
clk implementation with downstream and upstream DTS.

Christian Marangi (5):
  clk: mediatek: mt7623: fix broken peri_cgs clk with XTAL parents
  clk: mediatek: mt7623: split clk tree to dedicated topckgen and
    apmixed
  clk: mediatek: mt7623: define id_offs_map and import clk ID from
    upstream
  clk: mediatek: mt7623: remap apmixedsys clock ID
  clk: mediatek: mt7623: remap peri clock ID and add MUX

 drivers/clk/mediatek/clk-mt7623.c      | 326 +++++++++-
 include/dt-bindings/clock/mt7623-clk.h | 832 ++++++++++++++-----------
 2 files changed, 757 insertions(+), 401 deletions(-)

-- 
2.45.2


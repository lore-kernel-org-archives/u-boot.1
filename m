Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94AFCD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C65388875;
	Mon,  2 Sep 2024 18:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dTPvOIgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C08A88C59; Mon,  2 Sep 2024 18:31:25 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB5588860
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42c7bc97423so21720365e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725294682; x=1725899482;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ohgXiGysGRgjwtc3oN4t1LeYOS2E/43dJj8URgQ7jMw=;
 b=dTPvOIgfIgLWT9QcOirJez4Q86zoSVg8QzKIqxNsbptq1D7iIUPYm/b+Llanff0g2b
 KgkgXwso51BuAKYw/q2/Ptg3sSnXw2WBwnA88Iwvl3zSR5j+bhqExODelcJDXqFIWhAH
 Df1HrafQoHsTrgw4iEUgpCjKHduhijm8O2xQe5h7VtbtPg9iE0IkyJMgQrZ2F/m5xTLp
 Vgd3LIOjHt4tqoppuvwQRCik+/RdU0V0prKeoQrdfekzosndxQLcfU2/HPYzevn/YbVz
 DMbR21O+ZmlbecUhrFqI8QBaq/E7fbgkounRXde3ESf0Pj9mRl66buFSU3woc/8/9qeQ
 NbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725294682; x=1725899482;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ohgXiGysGRgjwtc3oN4t1LeYOS2E/43dJj8URgQ7jMw=;
 b=IMgmuj61SxAY2EzZTATm0ysQE/vnnm6U/6CRRUkYjX7YmKAlQwbOxI7TeuG2Wkm44l
 YCyq99qdLDBa0KcAW1HXsDRfy25L9UqfFSSKlrT+S1/wAEdcvtnBRxT26faMQL+2ofA+
 C3GGCcAt+Tpe2g6FjJ/WKryi4SIVtr05HGOewD9pR6GvhD791q+FpTT8NtzWeMNHSMvV
 Hdc2rN8X0rSgT2wJtioeSjFrGsO2kuCc1lci0ftOOV3UxOgblVwznwfDZa765NlZFT7o
 3f7vn2/Oi+XhlNJdMgAXuLT3CyAGWPEESS3E7GP0P9MI8aKcUT2wRBABq9nZ9+A9p0Or
 vh7Q==
X-Gm-Message-State: AOJu0Yy+Qceq4v4SAVVC/WCydEwgZ30eIbfrg08gJctdmw8O1ZvlR3sf
 nPVgHQYyki/A5rwVCGb1ft4rWY7CBBsPwLaj81sCarNParmoaRISyuSfINQK7e4=
X-Google-Smtp-Source: AGHT+IEvjU/L2BedUWvWSDIUMVC0DRdWXhT3a7XMLTxNlbV6v8Y+BLDGsrrB19CRfMESR4bTW0ZXqg==
X-Received: by 2002:a05:600c:a03:b0:426:5f09:cf53 with SMTP id
 5b1f17b1804b1-42bb01b9c73mr145898215e9.15.1725294681626; 
 Mon, 02 Sep 2024 09:31:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:36ea:3dbe:c83a:7e39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e274ccsm145122185e9.37.2024.09.02.09.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 09:31:21 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/3] Add Android 14 bootflow support for AM62X and AM62P board
Date: Mon, 02 Sep 2024 18:31:18 +0200
Message-Id: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbo1WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC2MD3eLMksSixNKC4pKi1MRcXdMkQ4s04yRLCyOTNCWgpoKi1LTMCrC
 B0bG1tQD9Xf+WYAAAAA==
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Ths patchset add support of Android 14 with boot image version 4
for :
- AM62X-SK EVM: https://www.ti.com/tool/SK-AM62B
- BeaglePlay: https://beagleplay.org/
- AM62PX-SK EVM: https://www.ti.com/tool/SK-AM62P-LP

Android Images use to test this series are on the Official TI website:
- AM62x/BeaglePlay: https://www.ti.com/tool/PROCESSOR-SDK-AM62X
- AM62PX: https://www.ti.com/tool/PROCESSOR-SDK-AM62P

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Guillaume La Roque (1):
      board: ti: am62x_evm: Add android bootflow

Mattijs Korpershoek (2):
      board: beagle: beagleplay: Add android bootflow support
      board: ti: am62px: Add android bootflow support

 board/beagle/beagleplay/beagleplay.env | 30 ++++++++++++++++++++++++++++++
 board/ti/am62px/am62px.env             |  5 +++++
 board/ti/am62x/am62x.env               |  5 +++++
 configs/am62x_a53_android.config       | 34 ++++++++++++++++++++++++++++++++++
 doc/board/ti/am62x_sk.rst              | 14 ++++++++++++++
 include/env/ti/android.env             | 31 +++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+)
---
base-commit: 57949a99b7bd0aa21abbde1ffa7e50e5d9e10a4e
change-id: 20240830-sitaraupstream-5b18f3b9824f

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61626C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECB7879FE;
	Wed, 17 Jan 2024 11:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GKIVrYZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385F487A0B; Wed, 17 Jan 2024 11:18:08 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A21876D3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so35857745e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705486685; x=1706091485; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKh3QnixkZ4ZAaCzS5Mc+YociiZUOY+6IGoz7S6jYuY=;
 b=GKIVrYZ4DTNKEoFewCYFZmNy+v6cu7mRR8df7qSolBjBZyCOidM6wB+sOglv6WEFfR
 yCZaYI+YXCggmQpJqB9gyUR1ZLqvbDkowExEGM6UAY1Yo1eKai52ru/e5eiY9OE6WVWh
 wAc09/qboczPPsvu5sNvhiPv407Iir74zpstCJ55ahIIZOnuYKMEeBBdY/DEjnVaTs2O
 eiSLcG+okLG77svIcxCJjXAdAf++sZ541bCC0JArnWhq8Uk7bcJD02AGUKEz2assfMrK
 2G7/qawJ0D/UfCbthXOQpIm7A4rWLTwkd4WL2OzQR15hIdfEcfQRe3XyF6VEgTWz1Lb2
 sUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705486685; x=1706091485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKh3QnixkZ4ZAaCzS5Mc+YociiZUOY+6IGoz7S6jYuY=;
 b=hqZSko5NsJN0/2Mz8t/lwokmL6o/PQ8AkPu691NSsYRmu+kjr5/7U/URGBHtHFdjVL
 3+KriTYhH6lxuLjHbD3/j6q7ojLv5RM8ZDLMYrbo586lSOTu0H38rqxhBLpnvUp2zPNc
 v0VOWl/51K3vi7e5VtVuq5YaiHDUA482ERWQ9FpZvtLtna4JujvZuE7o+QdBWRNnuRyp
 owxwr16GzthwrNoIOaN0inDWBxEiJu4e7ngIIZTbszux+6rbif9csIxJVYLeZ9lNSyQ8
 sFTq3OUBMwSXYEHmkeUbEenJ3yI0bBzShuaWWlXd2u9UBrUPmNfTwZywJniWIy91nPbw
 4Ctw==
X-Gm-Message-State: AOJu0YzPCuZIR0JLY9Dr9TuqZs6ajrPkph3EiVQ5yD/BTHtxU9IMHiqz
 lnR9UWtMrskHRMFPNHV6JtE=
X-Google-Smtp-Source: AGHT+IEnQBN4H80Q8rgN+QA1do7eyJboRQyb2RBZJ9A6ukW3HoDaWfFSTqml7L9RD+wS1GeC4cxP/Q==
X-Received: by 2002:a05:600c:15d2:b0:40e:6a93:1c42 with SMTP id
 v18-20020a05600c15d200b0040e6a931c42mr3709825wmf.26.1705486684917; 
 Wed, 17 Jan 2024 02:18:04 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 s14-20020a5d69ce000000b00337478efa4fsm1305849wrw.60.2024.01.17.02.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:18:04 -0800 (PST)
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.oss.09@gmail.com>, Andrew Davis <afd@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kamlesh Gurudasani <kamlesh@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1 0/4] board: verdin-am62: set cpu core voltage depending on
 speed grade
Date: Wed, 17 Jan 2024 11:16:45 +0100
Message-ID: <20240117101743.3955852-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
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


The series moves the existing access functions to the AM62 Device
Identification fields and adds function for the not yet accessible
fields to be available to all.

This is then used in the Verdin AM62 board code to set the CPU core
voltage according to speed grade to gain more than 100mW power
consumption reduction for the slower speed graded SKUs.


Max Krummenacher (4):
  board: verdin-am62: improve comment on usb phy core voltage
  arm: mach-k3: am62: move device identification accessor functions to
    header
  arm: mach-k3: am62: provide more soc feature info accessors
  board: verdin-am62: set cpu core voltage depending on speed grade

 arch/arm/mach-k3/am625_fdt.c                  | 23 --------
 arch/arm/mach-k3/include/mach/am62_hardware.h | 39 ++++++++++++++
 board/toradex/verdin-am62/verdin-am62.c       | 52 ++++++++++++++++++-
 3 files changed, 89 insertions(+), 25 deletions(-)

-- 
2.42.0


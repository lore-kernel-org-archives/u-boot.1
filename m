Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C14DCF58F1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:06:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC4489335;
	Fri, 20 Sep 2024 11:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BRUaqmnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED8589357; Fri, 20 Sep 2024 11:06:15 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D73289329
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 11:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-536584f6c84so2434284e87.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726823173; x=1727427973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eauz3hm6CkVrf+MXMuXwCVdJCze6jJ4Fh53QZGnCk5E=;
 b=BRUaqmnCeHs8qUnuxEj8oX1ml0ER2eAH6glqxl+1+KCZR2OKo0iLl/zeP5xSeg8zDn
 stLtcYMscUTrzu92btOCQgxPyOasGY6GNRNHKZ3IgxiwNx1NdrHxeg3oaKkGeCvEJ9aH
 U2R5Hez77x5kDfz0XZa83AyPeXzCu63Lg9kY3b2I6kzNySK8w0naPpEHTC1eAAl+O5aF
 J9QEfAVSVMskqg91lKGfzkdATRRybrc2YFlizwt2UegdnN12NcjNIPcd+i3TPgMbSZLh
 i3i+jBgUk8EF5HJYtYN1j6Mq2DowFPsc0ZGhqbsZUfbmXLSz8G3bD8GgZMiD1dEh5Jio
 UXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726823173; x=1727427973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eauz3hm6CkVrf+MXMuXwCVdJCze6jJ4Fh53QZGnCk5E=;
 b=fYP6mT2xZOO4KXtvvmL6knFRTLg5Mt89HtuWqiY0GQqm9gz++SZQU0lI2krMzpsT9T
 yQ7Fn2NIZBXUt2To2P0i0pLxmIBtT+qLa9UynMrNTwHd1i2DPyz5ifl3w+S2i3DQtxVn
 1gKSDRntmGFBfhzFobqJdnnkx/cgkkaOBCH4bdiPaYSILYLNO9Xke8nxhtxFKvpzV4iv
 QGGOMuuZLJ+9t+PC5xVeOqUVBsnwfVXKXGGX2M/6dg404GeK7+XifStADCnrpxd7OtsO
 l5FtA6h04iJmm0Af0iWoMAMxYDR0TOr/TXGzSUIzHI3ksAfioAvPQykirqRsLkqe7n8q
 KGsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/25OXkWH3dRCthMAk5pIjt6DUwXWxXoO5JBjFddjZnfnlNqOEMG3A1fXLMwczg0UmdHB7g20=@lists.denx.de
X-Gm-Message-State: AOJu0Yzvs8L2+eqR5+ttJVL+sQyycPXwo0BoGKgKPE0bHXXTV8shva77
 6F152+K/vuQ/Np6D4dxuVNwMRaRajaoMam5I47rGRq1VoH92Plmu
X-Google-Smtp-Source: AGHT+IHSzUWrqeCQnuea26tZeGsbiC7I/z5Ls5um4LyTGGmKkcZMUnKdWBwWr9YBsREFz5FuTpnv1Q==
X-Received: by 2002:a05:6512:6d2:b0:535:69ee:9717 with SMTP id
 2adb3069b0e04-536ac2d675emr1379240e87.3.1726823172492; 
 Fri, 20 Sep 2024 02:06:12 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870a88cbsm2088682e87.222.2024.09.20.02.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:06:12 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 0/2] riscv: add GPIO support for the LicheePi4A
Date: Fri, 20 Sep 2024 12:05:22 +0300
Message-ID: <20240920090532.280504-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

This series adds GPIO support for the LicheePi4A board.
It's based on Alibaba TH1520 SoC that has DesignWare APB GPIO controller.

Best regards,
Maksim

Maksim Kiselev (2):
  gpio: dw: Add ngpios DT-property support
  configs: th1520_lpi4a: Enable CMD_GPIO, DM_GPIO and DWAPB_GPIO driver

 configs/th1520_lpi4a_defconfig | 4 +++-
 drivers/gpio/dwapb_gpio.c      | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.45.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24784C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58CCA8814B;
	Mon, 15 Apr 2024 14:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dqxwjSdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9915288150; Mon, 15 Apr 2024 14:33:46 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 385D388137
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7d6112ba6baso48479539f.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713184423; x=1713789223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rhVSNMmi2MFhhmO+HIAXt7axO3jlDE9QIA36SiPzerw=;
 b=dqxwjSdFE0bib3axgqB8Vp0qXiFEWyo5frUaXxvoiYZ5kdej4S9OKxZsMSoscyIfKd
 wxJ9RsMl/HEXlorhItOhJOI7OvFn0vBe8nSOqxHXpFVjlkO0UKLVXjoD4fU7IEHFJuhh
 1yzmB1SgnHq2CG9ask8VIf9oF+LhvBnoBAAAWWLN8GpD59xkdpeFF8lGFdB8yaszu57N
 uPcciCe9CTqeLdL5MOintNsllQ2I8l+Ct/+Hf52K8F27bnHX64iJdHVBHpp7SQDa7I1I
 Zgcx8hG39fL9YRZLBHejwZm/b9kQMPgt/T2rUfARTNLky4eC54Z+txO0TaWh/4hXDsyi
 Rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713184423; x=1713789223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rhVSNMmi2MFhhmO+HIAXt7axO3jlDE9QIA36SiPzerw=;
 b=M7yFbCFp+bUIRgx9nXhpFjiufjYzP7BX0m2X70gAvsDFOjdXLxqe8jlSgbxEV6e2UN
 n3Ys1P4BhzO/8HSRiAvMR7XN26o4wnPER+NYuc6WqXKyRmMckUiQM9M7Tnt6HWhVDfy6
 4/Da9h5FkaDujAF7eGLwwfszC0CNmmqXNt6Frx+Lb1vFD2VHdBtyAgEXek9YPvAl4Iaz
 f9xxiEP9OLdhAWvGVSOan76RGTyTE/MjMh9nvp+fc5VrkPlJzcfkDWSIVqRt6tD2s0CO
 SNNLEjSlYIgXayGj9AXeyS/p8mfNjrIoBlLdNGfEKo+Ira6AYhALLxfI36Abo56Yd3kQ
 /8Aw==
X-Gm-Message-State: AOJu0YztkTm8dqop6zTXVsO51hURGu4+KMNYl+20ydqOrZb6Dne4qgzU
 pYMlfL/jdiLYhzd3+jejisTAvA1EdnrVksCKK4eCOuSSBAVOLmE2uSsDoA==
X-Google-Smtp-Source: AGHT+IF6JKU7+Q4peH19yZ6bMpvS7QCLs3BOkA68s4EbWWwX6LIq4mNaReLc8WocFY7MQ5LBGxg/4w==
X-Received: by 2002:a92:c006:0:b0:368:8d92:3262 with SMTP id
 q6-20020a92c006000000b003688d923262mr8370879ild.2.1713184422890; 
 Mon, 15 Apr 2024 05:33:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c83d:27e5:9428:1ef7])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a656558000000b005dc36279d6dsm6018505pgw.73.2024.04.15.05.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 05:33:42 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-master-20240415
Date: Mon, 15 Apr 2024 09:33:40 -0300
Message-Id: <20240415123340.3620031-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/master, thanks.

The following changes since commit b03b49046af5dfca599d2ce8f0aafed89b97aa91:

  Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2024-04-14 15:58:31 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-master-20240415

for you to fetch changes up to 8ecb0931940cc19728d686b9dba06585f4d93709:

  clk: imx93: fix anatop base (2024-04-15 08:09:41 -0300)

u-boot-imx-master-20240415
--------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/20348

- Update the imx_rgpio2p to only access one address as per the dt-schema.
- Remove unused imx9_cpu.c file.
- Only use the LPUART ipg clk for i.MX7ULP.
- Use the correct anatop base for accessing the PLL clocks on i.MX93.
----------------------------------------------------------------
Peng Fan (4):
      gpio: imx_rgpio2p: support one address
      serial: lpuart: use ipg clk for i.MX7ULP
      cpu: drop imx9_cpu
      clk: imx93: fix anatop base

 drivers/clk/imx/clk-imx93.c    |   2 +-
 drivers/cpu/imx9_cpu.c         | 224 -----------------------------------------
 drivers/gpio/imx_rgpio2p.c     |  42 +++++++-
 drivers/serial/serial_lpuart.c |  42 +++++---
 4 files changed, 65 insertions(+), 245 deletions(-)
 delete mode 100644 drivers/cpu/imx9_cpu.c

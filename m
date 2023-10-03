Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC39E7B5F9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED2686DD5;
	Wed,  4 Oct 2023 14:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qamm0t1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F4986E5B; Wed,  4 Oct 2023 00:14:40 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C097886E43
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 00:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nicveronese@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a21ea6baccso18253097b3.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696371277; x=1696976077; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I82IK+rT7IW3Rsxx20APvx1xw1Pf3lNDcy2a9c7bo8A=;
 b=Qamm0t1TmGMyRyuNCeFN1zUEvMi00aOy3u5nbU6eSZh7WM8qKsgRJpjnMxCmH/tekP
 irHXiLZF5yOZaCf/upICVmavznyyKX/uOysbzJ0LkVfzHXZjeDmRhhYjG7wncDVmwMAe
 kEOS7UHLMfc7KgZ1/W9MEEGl2TkBH0JnyDW2t3wal/9Iu3eEKHdCEgi0Qq7i4TnNkAFw
 NYjByZ11aIcOTdMtLG9lqnvHmidAQJUqhEm8QkHQVu578524oVOYIm5kc9P7kuZHLwi1
 HATU+LfEGEukaa2L1RmXm7S2RvKeYF1ZMC2QS7Awmf2Hgjitw65ts2FRZFm79VQTFv91
 rmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696371277; x=1696976077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I82IK+rT7IW3Rsxx20APvx1xw1Pf3lNDcy2a9c7bo8A=;
 b=C9wmtjttp9rWcZJWYEgrszGCUj4HWCdeOH0kb1HYEm5dFuTe5bRnNC3n4xI9JKfDi9
 fp3MnhZW7RmbSvzk1Cdp/6f2tAHG33kFjFiBN4Vw2NzQatt44zsRLMSu8nyaYE7oZ9sX
 IM+Xjy+VVkNUgM1kh5L8RglfUAqOX/OgxblT6bC43NZ25KXpS/MMNv3nmVGy/gLYpdxs
 UXtoPfwgwLtFkLCjttbLma+e5ItFKWvVQ/5XzHJm87ET4frB0yH2Ip0jo5Jt4o73i0Ao
 uQEV5besrBcfXsaQhDEa2AdbWAEwKMbz70iCb+do/j00a+Rysqv4/8O2wY9NIFO0RsBP
 thGQ==
X-Gm-Message-State: AOJu0YygbHHbyTw29K0t7rNgiURD3nEvm6Q/1aJFMwDtJel2DF3i7qmr
 irdIeY4wKijbgfVTKDyg241n+ejSIhA5iIj3uzvWttwkC+Kg86vn
X-Google-Smtp-Source: AGHT+IE5gqzJzOlTIcRl5KqzEccFwuzZfaiXgKYWPMwtUZVBmIx4KmmwIeXwM2dQtVWkL+vhrXro6q17jfGMiKwOI0s=
X-Received: by 2002:a25:4e05:0:b0:d69:8faa:5a28 with SMTP id
 c5-20020a254e05000000b00d698faa5a28mr490415ybb.55.1696371277254; Tue, 03 Oct
 2023 15:14:37 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>
Date: Wed, 4 Oct 2023 00:14:26 +0200
Message-ID: <CAC8rN+AFz_Kh8uRgZJD8N_NF=jpobRAyVMoc-1wq7g1WdGD81Q@mail.gmail.com>
Subject: [PATCH] spi: mtk_spim: prevent global pll clock override
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 daniel@makrotopia.org, 
 jagan@amarulasolutions.com, Weijie Gao <weijie.gao@mediatek.com>, 
 "SkyLake . Huang" <skylake.huang@mediatek.com>, ftp21@ftp21.eu,
 chunfeng.yun@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Oct 2023 14:04:49 +0200
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

With commit 793e6230118032a099ec42a1ea67f434721edcc0
 a new system to calculate the SPI clocks has been added.

Unfortunately, the do_div macro overrides the global
 priv->pll_clk_rate field. This will cause to have a reduced
 clock rate on each subsequent SPI call.

Signed-off-by: Valerio 'ftp21' Mancini <ftp21@ftp21.eu>
Signed-off-by: Nicol=C3=B2 Veronese <nicveronese@gmail.com>
---
 drivers/spi/mtk_spim.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mtk_spim.c b/drivers/spi/mtk_spim.c
index 418e586b91..90f4c3cecb 100644
--- a/drivers/spi/mtk_spim.c
+++ b/drivers/spi/mtk_spim.c
@@ -409,7 +409,7 @@ static int mtk_spim_transfer_wait(struct spi_slave *sla=
ve,
 {
     struct udevice *bus =3D dev_get_parent(slave->dev);
     struct mtk_spim_priv *priv =3D dev_get_priv(bus);
-    u32 sck_l, sck_h, clk_count, reg;
+    u32 pll_clk, sck_l, sck_h, clk_count, reg;
     ulong us =3D 1;
     int ret =3D 0;

@@ -418,11 +418,12 @@ static int mtk_spim_transfer_wait(struct spi_slave *s=
lave,
     else
         clk_count =3D op->data.nbytes;

+    pll_clk =3D priv->pll_clk_rate;
     sck_l =3D readl(priv->base + SPI_CFG2_REG) >> SPI_CFG2_SCK_LOW_OFFSET;
     sck_h =3D readl(priv->base + SPI_CFG2_REG) & SPI_CFG2_SCK_HIGH_MASK;
-    do_div(priv->pll_clk_rate, sck_l + sck_h + 2);
+    do_div(pll_clk, sck_l + sck_h + 2);

-    us =3D CLK_TO_US(priv->pll_clk_rate, clk_count * 8);
+    us =3D CLK_TO_US(pll_clk, clk_count * 8);
     us +=3D 1000 * 1000; /* 1s tolerance */

     if (us > UINT_MAX)
--=20
2.30.2

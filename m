Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDBEC36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45CE81E18;
	Sun, 30 Mar 2025 11:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggd8EQYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD0A81E06; Sun, 30 Mar 2025 11:36:14 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D628129B
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so563218066b.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327372; x=1743932172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8x2SdQ3mx6jOEm9o69WcriQwgn1f12+4PqGt/GU1h+g=;
 b=ggd8EQYoQsIpxNtFHxgU4ZExm+otAo3zOnFmEidQvK4Clwd/K7pSsXzGBKV6/u9oWG
 wpnIFv9fb0fYKFj5OC6LRyDtzpOx7HihCdxrbkiily4GuucJSNgeFA8jZ2oYY3yUPvOq
 p1fvmMjUaP1N6Sr/tNEgRDz5LOHNBliGpoGXFJWPYpUhIiUhVwYRbrE7LCXlZbTcVtTf
 kmutgGXVlo/F9ybSqSSESifDdHbyPrf85vg/G7T5YbEFJnU7xjuo2obbpdh3+DaBR4hc
 hgRQyr4TPeWb1OU2xMpcsJlUi494t8OHMyFSN7mpa2LPeMiw7/PujZpOs32qDBu+9W/q
 pvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327372; x=1743932172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8x2SdQ3mx6jOEm9o69WcriQwgn1f12+4PqGt/GU1h+g=;
 b=u+gGJYY8C9kBQ1DsdDd+uIGBnHVnAmspy6PxLrGHlcIY/qjLRI+/sGz0anYLyEy05I
 B+n9MaArkfHD/K6rSy5YZmb2z8H87yEpc6Lv2ZsQYADe+hIQEgvKGkp/JSiVksOKNwnd
 eA/Aqp6rMLdU8ofb4JQSwGvkr2egVwVI7/tLYhytlHX3X3pUxDTyyiHCIGlGc8LwLEXZ
 /+dQ9omPjUA5z0a6jXtTYyIx+uepYndtm2Y/74pZrAQhjhwwPrYc1vGl1gPc3W4W5RBl
 /Jvdn0v6NS7jrW9rI04/99+yJEdPOW47I0dyMMAzsnVb1GMSNNNVIFwGFIj3wcQlZe08
 EyFw==
X-Gm-Message-State: AOJu0Yze+7fDkis6KkYZjvBi9pNenercIPXCyDPJURvD0hkQ39y5JJko
 myEEF1cQx6RedmXU7sQYti7FiAzOzjqlBECtHhVODALMoHhfem4V
X-Gm-Gg: ASbGncvy9Dhr6DrGBYTiS9E7HBOJZaGEJ36H7JXb/Jkzklu18yAbdUb3MxGrg4MDLaB
 E1MRCPMBksGqnUQl6HcOAM3q0hj1gflilO5ZOOI+nL8FWYPeDa7CzQsIzWyco937puyOIFq5Awz
 bAEYdCqFY7MwgV/jGuiv12LrNAXTLQMqU9qjoD69zjXNtnHVYfFCRpgPQGxsLYeCLwvKRlWaTrI
 /dktL93GdATUWr2bPdl2l6TXloEPNy5tgdBqlyYMAI+hwkoajNWmWgt1EpS9p0f7EyqPMgh9A4J
 ZmRqKLPuPupdQxjvKHoDMXdYoxS7tLH/NDI7t9cCoExNM68=
X-Google-Smtp-Source: AGHT+IE2efgPeJBGYLW2LJ0puGnSIey7ZCOc4lfWyBK/sFdBCZuGYNgR34/DeLaxZVlVBz7X45hJIw==
X-Received: by 2002:a17:906:e28a:b0:ac7:391b:e687 with SMTP id
 a640c23a62f3a-ac7391be985mr382709466b.61.1743327371873; 
 Sun, 30 Mar 2025 02:36:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71971b7cfsm455273866b.183.2025.03.30.02.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:36:11 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Alban Bedel <alban.bedel@avionic-design.de>,
 Anatolij Gustschin <agust@denx.de>, Thierry Reding <treding@nvidia.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/5] video: tegra: adjust namings and paths
Date: Sun, 30 Mar 2025 12:35:55 +0300
Message-ID: <20250330093600.10871-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Adjust driver names, configs and paths to better reflect generic support
of multiple Tegra SoC generations they provide.

Svyatoslav Ryhel (5):
  video: tegra20: dsi: add Tegra20 support
  video: rename tegra20 to tegra
  video: move tegra124 into common tegra dir
  video: tegra: drop prefix from file names
  video: tegra: adjust DC and DSI config names

 board/toradex/colibri_t20/colibri_t20.c       |  2 +-
 configs/endeavoru_defconfig                   |  2 +-
 configs/grouper_defconfig                     |  2 +-
 configs/harmony_defconfig                     |  2 +-
 configs/ideapad-yoga-11_defconfig             |  2 +-
 configs/medcom-wide_defconfig                 |  2 +-
 configs/mocha_defconfig                       |  2 +-
 configs/paz00_defconfig                       |  2 +-
 configs/picasso_defconfig                     |  2 +-
 configs/qc750_defconfig                       |  2 +-
 configs/seaboard_defconfig                    |  2 +-
 configs/surface-rt_defconfig                  |  2 +-
 configs/tec_defconfig                         |  2 +-
 configs/transformer_t20_defconfig             |  2 +-
 configs/transformer_t30_defconfig             |  2 +-
 configs/ventana_defconfig                     |  2 +-
 configs/x3_t30_defconfig                      |  2 +-
 drivers/video/Kconfig                         | 10 +---
 drivers/video/Makefile                        |  3 +-
 drivers/video/tegra/Kconfig                   | 51 +++++++++++++++++++
 drivers/video/tegra/Makefile                  |  9 ++++
 drivers/video/tegra/TODO                      |  5 ++
 .../dc-pwm-backlight.c}                       |  2 +-
 .../video/{tegra20/tegra-dc.c => tegra/dc.c}  |  2 +-
 .../video/{tegra20/tegra-dc.h => tegra/dc.h}  |  0
 .../{tegra20/tegra-dsi.c => tegra/dsi.c}      |  5 +-
 .../{tegra20/tegra-dsi.h => tegra/dsi.h}      |  0
 .../{tegra20/tegra-hdmi.c => tegra/hdmi.c}    |  4 +-
 .../{tegra20/tegra-hdmi.h => tegra/hdmi.h}    |  0
 .../tegra-host1x.c => tegra/host1x.c}         |  0
 drivers/video/{tegra20 => tegra}/mipi-phy.c   |  0
 drivers/video/{tegra20 => tegra}/mipi-phy.h   |  0
 .../{tegra20/tegra-mipi.c => tegra/mipi.c}    |  0
 drivers/video/{ => tegra}/tegra124/Makefile   |  0
 drivers/video/{ => tegra}/tegra124/display.c  |  0
 .../video/{ => tegra}/tegra124/displayport.h  |  0
 drivers/video/{ => tegra}/tegra124/dp.c       |  0
 drivers/video/{ => tegra}/tegra124/sor.c      |  0
 drivers/video/{ => tegra}/tegra124/sor.h      |  0
 drivers/video/tegra20/Kconfig                 | 38 --------------
 drivers/video/tegra20/Makefile                |  7 ---
 41 files changed, 91 insertions(+), 79 deletions(-)
 create mode 100644 drivers/video/tegra/Kconfig
 create mode 100644 drivers/video/tegra/Makefile
 create mode 100644 drivers/video/tegra/TODO
 rename drivers/video/{tegra20/tegra-pwm-backlight.c => tegra/dc-pwm-backlight.c} (99%)
 rename drivers/video/{tegra20/tegra-dc.c => tegra/dc.c} (99%)
 rename drivers/video/{tegra20/tegra-dc.h => tegra/dc.h} (100%)
 rename drivers/video/{tegra20/tegra-dsi.c => tegra/dsi.c} (99%)
 rename drivers/video/{tegra20/tegra-dsi.h => tegra/dsi.h} (100%)
 rename drivers/video/{tegra20/tegra-hdmi.c => tegra/hdmi.c} (99%)
 rename drivers/video/{tegra20/tegra-hdmi.h => tegra/hdmi.h} (100%)
 rename drivers/video/{tegra20/tegra-host1x.c => tegra/host1x.c} (100%)
 rename drivers/video/{tegra20 => tegra}/mipi-phy.c (100%)
 rename drivers/video/{tegra20 => tegra}/mipi-phy.h (100%)
 rename drivers/video/{tegra20/tegra-mipi.c => tegra/mipi.c} (100%)
 rename drivers/video/{ => tegra}/tegra124/Makefile (100%)
 rename drivers/video/{ => tegra}/tegra124/display.c (100%)
 rename drivers/video/{ => tegra}/tegra124/displayport.h (100%)
 rename drivers/video/{ => tegra}/tegra124/dp.c (100%)
 rename drivers/video/{ => tegra}/tegra124/sor.c (100%)
 rename drivers/video/{ => tegra}/tegra124/sor.h (100%)
 delete mode 100644 drivers/video/tegra20/Kconfig
 delete mode 100644 drivers/video/tegra20/Makefile

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457D6C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9905681DE3;
	Tue,  1 Apr 2025 18:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvD0C3nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2344E81ECD; Tue,  1 Apr 2025 18:10:03 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDE7C817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so8715011a12.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743523800; x=1744128600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8box3QP5qcEDZuiztsFQPyATIeaGYrs6YXgWNJAuLHg=;
 b=TvD0C3nrLE+2ncxinZzN8fjOzpAq4w+BrkxtTvu5bfZFIsL3P9ergQMYAGpCTA/xaB
 56e48b2WZ/9hkNyAvCvFmnyjllzlX0c+MqSw6gLeNA9gNWaDoaOp213zlfDLnjDVH9+L
 /0azjxe2AWGxQsPKQ1NyYsA1+16H7dRAGGrVE+9Dxb1lHeiHwyQ3vu7araKrWKicGnMB
 IZZZpIOukBi9o5JoDO3LOV7FfsKuwio4Ootrfql3RRJ0WdgFDZcV12SCUyfMUA/UbgNs
 bC+jrhtJzuDVYlILkqNjpgAytLfrzJCdkV2z0MW6EftWDBRSUy4phChlbVtcFr+PVcs/
 KOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743523800; x=1744128600;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8box3QP5qcEDZuiztsFQPyATIeaGYrs6YXgWNJAuLHg=;
 b=L+O9evDT6RGSOX8LiBskab2G+ro55WmWcqZcLhuY00HjxzZkYt4I/b80I8BplywQlM
 YpzCWLZYUJzcyE4zVrj7gZY7O4sC7cfrpxYwXLGX87teks4xYy6+2G1d0Zm2TSoQeZuY
 pPDmm9yLhYRUzLvvxZGkKtXr84mStpTXEn/ucrKePwUuTzVg9DXuLxr6dGqLnmtlw5Y8
 jXQG/biqzh11TrF002YOlvvBApZnKWsZ80tbHoCi4U0cQWlqtUaRxRepYK9ChSqF1GTt
 umhfOFkby4nd71QvJzOK7jkzRZKmVl99aZnipAqZX+LQzVEUcV4GfPK3tsKC4+yxNqcF
 NXGA==
X-Gm-Message-State: AOJu0YwM+XL875n/7FOsF5/F8g77pQRwlQDpZr7HeB3PT4k7RFjnO9TA
 00I/05tlWnzQthCav67F9EnatmDU29qbVAlTksjlMlrl1H0VzCON
X-Gm-Gg: ASbGnctBMxxVeHmhste4P8XmjFDIWKuhLfFA9bv2twRJOM+y0tTcRL+pS3LyJ524x/J
 bp4IO3cu4/8KT0MCYVHSWk3UZyQq5bzRh8JMwqqeCmXQ90EsxZorSz8at20rp4c0/JKb8A/DlAz
 TjO7yVtQ58DMzOqiEzu2zo1jsfNAcz/5Q5Y1dV4DL3ubOEb2FSR5BfCtzfV3yeTEwmTB8tSCTcw
 xH42d8ActeB+ZUHQwNCHQIGh3QJDbAnWDgPoEwPx000XM2K8JB2nn75S4XmIuaeIG0eOB+KzHhJ
 AmtqOn7OdMlDfmEll2SggGt4Fi6+wOyadFT8gWpMQIwNHuc=
X-Google-Smtp-Source: AGHT+IFmi9uMFfPU1MbG7OQzakO0mZDDzTBzdjKxBQlgghaP+q97WpAiznf9Q2LUplgTMvawHBxDAw==
X-Received: by 2002:a05:6402:268c:b0:5e6:17fb:d3c6 with SMTP id
 4fb4d7f45d1cf-5edfdafe2acmr11099984a12.25.1743523799777; 
 Tue, 01 Apr 2025 09:09:59 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17dff0bsm7197965a12.70.2025.04.01.09.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:09:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Alban Bedel <alban.bedel@avionic-design.de>,
 Peter.Chubb@data61.csiro.au,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/3] ARM: tegra: replace per-device config headers with
 generic
Date: Tue,  1 Apr 2025 19:09:46 +0300
Message-ID: <20250401160951.69056-1-clamor95@gmail.com>
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

- link CFG_SYS_NS16550_COM1 to TEGRA_ENABLE_UART* (instead of setting it
  in every board header)
- convert CFG_TEGRA_BOARD_STRING into kconfig (instead of setting it in
  every board header)
- replace per-device config headers with generic Tegra (per-board device
  header is still possible if board needs some specific configuration)

Svyatoslav Ryhel (3):
  ARM: tegra: board: set CFG_SYS_NS16550_COM1 according to
    TEGRA_ENABLE_UART
  ARM: tegra: convert CFG_TEGRA_BOARD_STRING into Kconfig option
  ARM: tegra: replace per-device config headers with generic Tegra

 arch/arm/mach-tegra/board.c               |  5 ++++
 arch/arm/mach-tegra/board2.c              |  2 +-
 board/acer/picasso/Kconfig                |  6 ++++-
 board/asus/grouper/Kconfig                |  6 ++++-
 board/asus/transformer-t20/Kconfig        |  6 ++++-
 board/asus/transformer-t30/Kconfig        |  6 ++++-
 board/avionic-design/medcom-wide/Kconfig  |  6 ++++-
 board/avionic-design/plutux/Kconfig       |  6 ++++-
 board/avionic-design/tec-ng/Kconfig       |  6 ++++-
 board/avionic-design/tec/Kconfig          |  6 ++++-
 board/cei/cei-tk1-som/Kconfig             |  6 ++++-
 board/compal/paz00/Kconfig                |  6 ++++-
 board/compulab/trimslice/Kconfig          |  6 ++++-
 board/htc/endeavoru/Kconfig               |  6 ++++-
 board/lenovo/ideapad-yoga-11/Kconfig      |  6 ++++-
 board/lg/x3-t30/Kconfig                   |  6 ++++-
 board/microsoft/surface-rt/Kconfig        |  6 ++++-
 board/motorola/mot/Kconfig                |  4 +++
 board/nvidia/beaver/Kconfig               |  6 ++++-
 board/nvidia/cardhu/Kconfig               |  6 ++++-
 board/nvidia/dalmore/Kconfig              |  6 ++++-
 board/nvidia/harmony/Kconfig              |  6 ++++-
 board/nvidia/jetson-tk1/Kconfig           |  6 ++++-
 board/nvidia/nyan-big/Kconfig             |  6 ++++-
 board/nvidia/p2371-0000/Kconfig           |  6 ++++-
 board/nvidia/p2371-2180/Kconfig           |  6 ++++-
 board/nvidia/p2571/Kconfig                |  6 ++++-
 board/nvidia/p2771-0000/Kconfig           |  6 ++++-
 board/nvidia/p3450-0000/Kconfig           |  6 ++++-
 board/nvidia/seaboard/Kconfig             |  6 ++++-
 board/nvidia/venice2/Kconfig              |  6 ++++-
 board/nvidia/ventana/Kconfig              |  6 ++++-
 board/ouya/ouya/Kconfig                   |  6 ++++-
 board/toradex/apalis_t30/Kconfig          |  2 +-
 board/toradex/apalis_t30/apalis_t30.env   |  9 +++++++
 board/toradex/colibri_t20/Kconfig         |  2 +-
 board/toradex/colibri_t30/Kconfig         |  2 +-
 board/toradex/colibri_t30/colibri_t30.env |  8 ++++++
 board/wexler/qc750/Kconfig                |  6 ++++-
 board/xiaomi/mocha/Kconfig                |  4 +++
 include/configs/apalis-tk1.h              |  3 ---
 include/configs/apalis_t30.h              | 27 -------------------
 include/configs/beaver.h                  | 21 ---------------
 include/configs/cardhu.h                  | 21 ---------------
 include/configs/cei-tk1-som.h             | 26 ------------------
 include/configs/colibri_t20.h             | 18 -------------
 include/configs/colibri_t30.h             | 28 --------------------
 include/configs/dalmore.h                 | 23 ----------------
 include/configs/endeavoru.h               | 23 ----------------
 include/configs/grouper.h                 | 19 --------------
 include/configs/harmony.h                 | 31 ----------------------
 include/configs/ideapad-yoga-11.h         | 19 --------------
 include/configs/jetson-tk1.h              | 22 ----------------
 include/configs/medcom-wide.h             | 26 ------------------
 include/configs/mocha.h                   |  6 -----
 include/configs/mot.h                     |  6 -----
 include/configs/nyan-big.h                | 22 ----------------
 include/configs/ouya.h                    | 23 ----------------
 include/configs/p2371-0000.h              | 23 ----------------
 include/configs/p2371-2180.h              | 23 ----------------
 include/configs/p2571.h                   | 23 ----------------
 include/configs/p2771-0000.h              | 20 --------------
 include/configs/p3450-0000.h              | 21 ---------------
 include/configs/paz00.h                   | 25 ------------------
 include/configs/picasso.h                 | 23 ----------------
 include/configs/plutux.h                  | 26 ------------------
 include/configs/qc750.h                   | 23 ----------------
 include/configs/seaboard.h                | 28 --------------------
 include/configs/surface-rt.h              | 21 ---------------
 include/configs/tec-ng.h                  | 20 --------------
 include/configs/tec.h                     | 26 ------------------
 include/configs/tegra.h                   | 32 +++++++++++++++++++++++
 include/configs/transformer-t20.h         | 23 ----------------
 include/configs/transformer-t30.h         | 23 ----------------
 include/configs/trimslice.h               | 26 ------------------
 include/configs/venice2.h                 | 24 -----------------
 include/configs/ventana.h                 | 23 ----------------
 include/configs/x3-t30.h                  | 23 ----------------
 78 files changed, 221 insertions(+), 843 deletions(-)
 delete mode 100644 include/configs/apalis_t30.h
 delete mode 100644 include/configs/beaver.h
 delete mode 100644 include/configs/cardhu.h
 delete mode 100644 include/configs/cei-tk1-som.h
 delete mode 100644 include/configs/colibri_t20.h
 delete mode 100644 include/configs/colibri_t30.h
 delete mode 100644 include/configs/dalmore.h
 delete mode 100644 include/configs/endeavoru.h
 delete mode 100644 include/configs/grouper.h
 delete mode 100644 include/configs/harmony.h
 delete mode 100644 include/configs/ideapad-yoga-11.h
 delete mode 100644 include/configs/jetson-tk1.h
 delete mode 100644 include/configs/medcom-wide.h
 delete mode 100644 include/configs/nyan-big.h
 delete mode 100644 include/configs/ouya.h
 delete mode 100644 include/configs/p2371-0000.h
 delete mode 100644 include/configs/p2371-2180.h
 delete mode 100644 include/configs/p2571.h
 delete mode 100644 include/configs/p2771-0000.h
 delete mode 100644 include/configs/p3450-0000.h
 delete mode 100644 include/configs/paz00.h
 delete mode 100644 include/configs/picasso.h
 delete mode 100644 include/configs/plutux.h
 delete mode 100644 include/configs/qc750.h
 delete mode 100644 include/configs/seaboard.h
 delete mode 100644 include/configs/surface-rt.h
 delete mode 100644 include/configs/tec-ng.h
 delete mode 100644 include/configs/tec.h
 create mode 100644 include/configs/tegra.h
 delete mode 100644 include/configs/transformer-t20.h
 delete mode 100644 include/configs/transformer-t30.h
 delete mode 100644 include/configs/trimslice.h
 delete mode 100644 include/configs/venice2.h
 delete mode 100644 include/configs/ventana.h
 delete mode 100644 include/configs/x3-t30.h

-- 
2.43.0


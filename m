Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE8EC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA59080F88;
	Wed, 26 Feb 2025 12:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QoCQzJau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A0180F88; Wed, 26 Feb 2025 12:54:09 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB9BB80977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e4b410e48bso389873a12.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570847; x=1741175647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DCneXRVCMe/+tnrogpEQIfbH1LFB8p2C1FRG836H8ac=;
 b=QoCQzJauUZM1KoPz/rqcirsjASvzZiJdQKeR/O+Ny9Ccf3lEF6LHS3Mx/lSK6+6amL
 vsYul+Y88FxGzgfpp6vUBJNrAYSBwOoQFRhXHxwH5lOlR0/C/6q2kUumJt2Kh63aJn6E
 wqX+oZp/XD/zq+L0JZ3t8v1sLVRbm76j2lZm/o5SXkTab2QyequK4pePVkeaO1dAaWJj
 BXNHEbSu6nmwZ40Zsat6TIZAie7+vvl60iR65k22u74d5rAB7mLyBBQOHfSTKNE3g995
 qrzEaMxBpgyWUCwqLC2VfFq+E1hkuHdPecBdnMrO/j/LUBAt7v9F8i58ORJNua+8pIqe
 47Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570847; x=1741175647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DCneXRVCMe/+tnrogpEQIfbH1LFB8p2C1FRG836H8ac=;
 b=NqmHfN5sy6+EtAC83soPetT2zG+O3dxoo2t0augo70LfuY7JuSwNv/rB7twpDt4bve
 YWEIoFovqKrk9qH0OZmagqOn0p2WZoOaNBBEkFsQAWZ6OxUYWM99U+hFgIpesCHqSUmD
 js+x2iNnLQ3pV+AFGB/CWFqOgEocD72NYaLfOTNQ8Zh7UcLa18EhCtToIehyqab0Xm3j
 gjDN4oSCa7Xnd1fFdYKdrxlwCWyRQ61Ra74loGCduFMDaXXA6AgywCfILP7WOSxIshF+
 oCP2tkDYiUltRPkk8EjmljpadvpfFuBVt8IUWQ1Ww+ESkZAf6kHO0x2sJ+pReWWjA4qH
 DZng==
X-Gm-Message-State: AOJu0YzhpObfYhlS/fkVaOb7eM8QZcqxtDgUKAZRQkprl2adMvERfW98
 qrQmcpy33/pwMBxbhwbY+QAHRfF0MtkGQIFLMwLm4qyGkoakOmZI
X-Gm-Gg: ASbGncuOXEKpXc4w/NnsCo+iKK2HJGG/wdiVpBu9HQcwQW8on4BCZA4NdpwB+FDOeUp
 FjItArKPEWvSR/amh2hexgHPKYewQH288m1YPiifoCDIUkqJDQXy5pT7gdsKc0vc7Nf8JspRFi0
 EGiy/ImY75ao8kb/2IsJ8l2Zjy2ciucS8DB8XnCyuvFAgd+y+UGLcxip+NBQj4uEAkcbKuGMTsn
 1b6KFaI0yYqGE3q37NhjLJ/NDAWDEF8Ol1pinhCjih0hgg0+qOdFCWR69MFL/e37FqFQ6TZXxSL
 JGczCVXxSkLXxResUA==
X-Google-Smtp-Source: AGHT+IFR5aw8ZrMRn1Hc+AfDnfvVhk8NfT59xvl1N06Cr0oJ+5ZBFkKi5r9Q3kdJnJCOpc6c8GwBgQ==
X-Received: by 2002:a17:907:8688:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-abc0da33a30mr2587541966b.33.1740570847027; 
 Wed, 26 Feb 2025 03:54:07 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 00/12] Tegra DSI/DC code refinement
Date: Wed, 26 Feb 2025 13:53:26 +0200
Message-ID: <20250226115338.42832-1-clamor95@gmail.com>
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

- Use DM based clock API
- Switch to upstream style DSI panel bindings
- improve ganged mode support
- remove hardcoded Tegra 2 parts

---
Changes in v2
- ganged mode logic aligned with Linux DSI driver
  implementation
- improved packed calculations
- improved lane calculations
- dropped unneeded changes
---

Svyatoslav Ryhel (12):
  video: tegra20: dc: switch to newer clk API
  video: tegra20: dc: remove hardcoded Tegra 2 specific parts
  video: tegra20: dc: remove excessive headers
  video: tegra20: dc: improve code quality
  video: tegra20: dsi: check for panels among child nodes
  video: tegra20: dsi: switch to newer clk API
  video: tegra20: dsi: align ganged mode implementation
  video: tegra20: dsi: make SOL delay calculation mode independent
  video: tegra20: dsi: calculate packet parameters for video mode
  video: tegra20: dsi: calculate lanes for ganged mode
  video: tegra20: dsi: pass source on DSI configuration
  ARM: tegra: endeavoru: adjust panel node

 arch/arm/dts/tegra30-htc-endeavoru.dts        |  23 +-
 .../include/asm/arch-tegra20/clock-tables.h   |   2 +
 drivers/video/tegra20/tegra-dc.c              | 104 ++++-----
 drivers/video/tegra20/tegra-dsi.c             | 219 +++++++++++++-----
 4 files changed, 215 insertions(+), 133 deletions(-)

-- 
2.43.0


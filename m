Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADC2C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAC89801DE;
	Thu, 20 Feb 2025 18:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AEW3YzFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E3D80F5C; Thu, 20 Feb 2025 18:06:56 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF29801BE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3072f8dc069so11932891fa.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740071213; x=1740676013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3gimbtt0o4/BwUnwCTrdLX0NalwQQz0m3NXTS0xb+/o=;
 b=AEW3YzFHBpXO6NrX8DUvL0STvSbkKFxWR56mVTyIYh4atSoc7prh1VfJONOnJ7DWr8
 XcNouEDEX/e6+u24amArHeRxGKzSXTm3JuE7zCz2+kf7yDHsLKHOrrQUGeJ3spZvwHxq
 7JIEU6Ib4rVEa56i5yr5/NJhse597G9q0gCXZwj+xUauKbQedGdYN/2UjBz9XlMSesXH
 LCG+f0G8KXrD3cdoFXhWqAnRYMTQw9qc9qvu6ttsFxV7ij3fLt16eyc1zbv8PktLZmOB
 SvZcEE+BqL7DcHFX4J9FhrYpIiwwX0LLfa9nz1bPKfxmzWcOxtkfTCg37uiXGo7/mJPe
 3OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071213; x=1740676013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3gimbtt0o4/BwUnwCTrdLX0NalwQQz0m3NXTS0xb+/o=;
 b=Pc7DXjn6gVjFdGvTAbb3c/MHc7/BFJ9Q51iSRWCz8i2Wy7lzjo1SbpF4VR2hFNMO5e
 xmrenIzrEcK3HYTcccSyZiwM4nYYa27y/U8EMpmeHvmoNolv+LZcHzbERvsWtRWQRDzc
 kZs+gliiDmxxNn0Qr8CU8uariw7iFSt8VIQ1WGQZrSgHBUrdXyC5YI7gVztBAtkRsPJy
 AJPVBg4M2p1yd5JUZAu6q7wt/dZfi2li3jmFgILT7dofMyRqZP/rluGzBdkm4g38Hsvw
 G4r+1K3mUSt8afd6lflmn5NNVSb3eQ5cxKkqfB5105wpt4nwXFuUmagQgqazM+xKe70A
 Wr9w==
X-Gm-Message-State: AOJu0Yy3Fm3tjbOcZ4QwupmwoZf29RFTfaBHbCfRooG565gVKz4FitPe
 SCmPwGgn++Op9Cm6WsUfnhi98GkMgpQH4KqCl846fz74AeoN0Zdj
X-Gm-Gg: ASbGnct2lyCW//5inN3whm8LbRHuW+xq7NlDKhp6C9UU37f/Io85CaTsslIBq+uCALP
 eIfbRogubcuPX3z0r5Ji/4wt2m+pqtQYOvu4LUcpggW7Fpm2kL9ASp2WYTrFguDsTK8vq3gH1Dg
 xxho0ZXnbhuxfPnfdn2SKwXkjXUHD1b4ro2/st6JPTemfQQiU6/+kqBtrUvtbFs8hH3aU8pzHtD
 4mWfphtbxAhSasLL1TLXW9XCeFZrqOceMTK8r27Tm/mIPQGKjMUJezGdLNfqgYXzY2RDnMc8a32
 pQ1ekTE=
X-Google-Smtp-Source: AGHT+IGrlRGm60F19HOLpwsrj+pN3zsCFQ0YUzoU/e1qO8Pp+Uaq7GcIdGRjS/UHyM9cfKg6ba712A==
X-Received: by 2002:a05:6512:2398:b0:545:ee3:f3c7 with SMTP id
 2adb3069b0e04-5462eef4e56mr3509513e87.30.1740071212872; 
 Thu, 20 Feb 2025 09:06:52 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-547df6106f6sm81828e87.204.2025.02.20.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:06:52 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/3] video: bridge-uclass: add get_display_timing ops
Date: Thu, 20 Feb 2025 19:06:26 +0200
Message-ID: <20250220170629.228485-1-clamor95@gmail.com>
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

Add get_display_timing ops for internal bridges linked to
panels that do not support EDID (MIPI-DSI panels for example)
or have EDID not routed.

---
Changes in v2
- adjusted get_display_timing description
- added LVDS de/encoder bridge
- added video bridge test
---

Svyatoslav Ryhel (3):
  video: bridge-uclass: add get_display_timing ops
  video: bridge: add transparent LVDS de/encoder bridge
  test: dm: add video bridge tests

 arch/sandbox/dts/test.dts                  |  46 ++++++++
 configs/sandbox_defconfig                  |   2 +
 drivers/video/bridge/Kconfig               |   7 ++
 drivers/video/bridge/Makefile              |   1 +
 drivers/video/bridge/lvds-codec.c          | 128 +++++++++++++++++++++
 drivers/video/bridge/video-bridge-uclass.c |  11 ++
 include/video_bridge.h                     |  21 ++++
 test/dm/Makefile                           |   1 +
 test/dm/video_bridge.c                     |  67 +++++++++++
 9 files changed, 284 insertions(+)
 create mode 100644 drivers/video/bridge/lvds-codec.c
 create mode 100644 test/dm/video_bridge.c

-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD30C021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 12:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED46B805C3;
	Mon, 24 Feb 2025 13:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WUDoXETc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A03EF80EC0; Mon, 24 Feb 2025 13:02:37 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86EB180079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 13:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5439a6179a7so4811029e87.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 04:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740398555; x=1741003355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DYmUWW0buoPEsjcMC1ygQARPr26/LQYbjbhR4qhBCUs=;
 b=WUDoXETcsKi+QnkQHOHJAyt5q2tx1mGabgnCnRE1Q+XIO0uHnCwCaJ2prvAoam5yGl
 vsRPFIm7Tk9nxQ54yEqPzypewz3RkKJ3vy669f177qhdZW1xdvSubVwktrgHwXLr+yHx
 QBK6QIUDbUQIoMxpM7Avb3K8BNkup+mAJZqCZ+Gg9WvGfNqTQjjnSMnvJmP5QZSj+Lv8
 DrgzvmiFnzelsphxlc4gO94jmito8pU43PShuO3aeG/q3y4DXwd2a94WR6MOFVLaEDt3
 4Yd+qj26B9cyzO6gxtzoL7haA7gxEU8d5QeescxYcwWUgPZHWeTVrkES5DrWwHVkGeYR
 BEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740398555; x=1741003355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DYmUWW0buoPEsjcMC1ygQARPr26/LQYbjbhR4qhBCUs=;
 b=ffsSgMjdHdpf01Ix7agcTjxVdWC+D78ZrSHvQyOxOhejCkYqKI22Kk+pVS+XThSC9V
 /d90n04sKBJbhJXOG0Pba9QFaalHMf9VD0HSlLsB/hFHD3EIX+i6qEeYpSVj0JG+vy+z
 S4+45r5+NJeWllovMj7Y+KjwcbBF62pOg34A2Nq+6N+xBfUpp+N4aakrVnq9c+uCLL4R
 91ILs8rErEGZrAqEiBIDaJcIALvnHfOrqyl9mcjnMjQDM6jNTQzFOjLUDPt4LhIwxKxq
 G00zeRyoeTn58wPm3at0RXRRgpH2mfIt9ymO2Oe5207ZPkGCM4NAjaKpmk9AYcPhoqtM
 BkQw==
X-Gm-Message-State: AOJu0Yzh0pzJv3wXZOzNTFdU/fswx+jCPpk+dSpO7k7xuy/3Vs55UiDO
 UlBeNay8IFTfqRAqyveutE4ZG9TfMdigXcd9HEddFLFDH5DDf6ZW
X-Gm-Gg: ASbGncuTlR6I+IC1oIWXgJvRMk4T0/Nd73fXRS9J3l2Wc/1b4J09iSVY7Fccvvhz9/J
 cjMAoK0Z2ebp1vmvXLFuXbJeUPjqMhI+ZA0EGE1/HozbLgj/Y/i1VMxcqvkcaQ0cjwA2pSfBkiP
 rZKYBV6yn1MruomiAlgfggBKDb5XvJo+e2I7YOnGO67jv+K9RrxgWYIdK3+jcpA/sn0TtU6io9H
 MtHNM+bPK68wJBfGtG4xACq6xyOH5fmxZWlsQG+0qY/XEiYn92VTDDo6epFAFyJM58T2mz63T/+
 nIKsggaWsE29WWJE
X-Google-Smtp-Source: AGHT+IGe2R4DYXn2JDb4Zi3YyQ/1tzjqYnIUZt4K7pgmZjkHnbzTAAHVkfHTJLoNPMuWvsc+2Fzyyg==
X-Received: by 2002:a05:6512:3a8c:b0:546:1fd8:3876 with SMTP id
 2adb3069b0e04-546e46633b3mr5842880e87.14.1740398554428; 
 Mon, 24 Feb 2025 04:02:34 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54838eabfd7sm987159e87.187.2025.02.24.04.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:02:33 -0800 (PST)
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
Subject: [PATCH v3 0/4] core: ofnode: add of_graph parsing helpers
Date: Mon, 24 Feb 2025 14:02:10 +0200
Message-ID: <20250224120214.147646-1-clamor95@gmail.com>
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

Add a mostly complete list of ofnode analogs of of_graph parsing helpers.

---
Changes in v3:
- added fallbacks for video bridge functions

Changes in v2:
- added tests
---

Svyatoslav Ryhel (4):
  video: bridge-uclass: add get_display_timing ops
  video: bridge-uclass: add inline fallbacks of video bridge functions
  video: bridge: add transparent LVDS de/encoder bridge
  test: dm: add video bridge tests

 arch/sandbox/dts/test.dts                  |  46 ++++++++
 configs/sandbox_defconfig                  |   2 +
 drivers/video/bridge/Kconfig               |   7 ++
 drivers/video/bridge/Makefile              |   1 +
 drivers/video/bridge/lvds-codec.c          | 128 +++++++++++++++++++++
 drivers/video/bridge/video-bridge-uclass.c |  11 ++
 include/video_bridge.h                     |  54 +++++++++
 test/dm/Makefile                           |   1 +
 test/dm/video_bridge.c                     |  67 +++++++++++
 9 files changed, 317 insertions(+)
 create mode 100644 drivers/video/bridge/lvds-codec.c
 create mode 100644 test/dm/video_bridge.c

-- 
2.43.0


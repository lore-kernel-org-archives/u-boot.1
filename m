Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D7FD3EE84
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 16:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD908397D;
	Thu, 22 Jan 2026 17:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0pW48m5m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A226383AEE; Thu, 22 Jan 2026 17:38:26 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A9580077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 17:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1027014f8f.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099903; x=1769704703;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DP51i+PIr9Q19RabKvqDDpI7zhnOuJz0fNildRkET4s=;
 b=0pW48m5mJF9t4Fy5U8O8NdQGxKoBybGCsibjOZJV9LXVcBEQadUCOWGdiwEKzs6ffY
 1LV0tlMDzswM8MAhTQ/gaYdYz1ZZ21oLB/TxBBnPqP4qFmZVdE55d79u0osNm6mGqNiD
 iNwGKrCaoNzCfg09/2vIDNHo+Se36qIPubvB7EAl3ipcdh9QKZ6uRigzkLZWu+l5BAUJ
 9RDd00YAC3GEGw7XwJauVQ/fzA25nbj71NoaaY579szDi5S8HbEl1HeY1n3UxfxgbE8i
 1VHau270AgZZ1OYaBSFd1nycgEcAtIGDo+P6M0HL4AoYWNo+mQ66+jyWvcRsR3o1DwqW
 wPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769099903; x=1769704703;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DP51i+PIr9Q19RabKvqDDpI7zhnOuJz0fNildRkET4s=;
 b=NtXQJOc0QwF805IKwQFhfarRoRrQZUNxsluOwzNMG00AURHzKTprbgaZASCM2Ft02S
 vgGfaUhGc+1dA7zZlrqNd5S7ox858qyB3xUTYrMLpy74PEwT2NwduvyCrpdtECvwcMxh
 8QnPaQPNLh+kq/Ga8nzfeV51oDEnNOnIT4uqqH811xEGH/kf++WdhULY+PQhaD1JioqF
 +kiZ6F5nLPJfT+WuRg28CVWLd4DrERya7znaSDyCLdwRvM5aZn3UGEBwfIjgz9mHg7BC
 EtcFoW9sgboeiZ6SbAS/CJVeylkwxi/tNooOgtyV+4OZ0yCdXmPrhcDLTC5+edmgP89w
 LjfA==
X-Gm-Message-State: AOJu0YyV02ucFaKDYGX8DCWB1oomtLmTTbA2Df1V8JaTqprIdVyGOVPp
 pX1+ebInZPqP2Xjg4RrQcmMJeNd5EWfg9t7DIRbthXIMxlKpNW2LGtkafbEsSmgX4EA=
X-Gm-Gg: AZuq6aLEex16UC1s2PuTza3p9gONbUZRCLgKnPkjmO5oE69suvZ/tOCM+2LZmhlTooi
 1qXT5AO2UFWtGCHuYczVAO34TKYAXUkgT17XgmT4cttUrJZt+wC/0jYDLQgYvdGLKcjdBhgPu9k
 Z9UM3tQqwdZUwnhzY+7PJeIafV+Wdy769+kiie4rBwOe6j48F4owQRTddAOU9glmNJ8Pk+XyR2y
 r1w0Ne80/xMf0anRhfRtC9Ovcqyk1eSoIMheOajSmJy9Io0kMk4fLtnl07A2aLPH706ueri3s3P
 7ueUCOsk+wg1g0S+MFlmPJ5HqJqWkZ4f73buuXV0/lg74dyih1O5s68T6L8F54rkW322S6eW77v
 cCVU2TXkAm/Op0odPksNa0YhDJb18yYDvlRshZztnRWtXAoTcWaSryGGAmcPDMdlViKglB9q/3z
 7ltC46Tt31mm+9Rj23RX7Izw==
X-Received: by 2002:a05:6000:2886:b0:430:f494:6a9c with SMTP id
 ffacd0b85a97d-435b159cac4mr234448f8f.17.1769099903459; 
 Thu, 22 Jan 2026 08:38:23 -0800 (PST)
Received: from [192.168.1.35] ([2a01:cb1c:39a:2200:c85b:67ae:76b0:e0c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435924ae723sm19468949f8f.41.2026.01.22.08.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 08:38:23 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/2] Add pinctrl driver for mt8188
Date: Thu, 22 Jan 2026 17:38:21 +0100
Message-Id: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Ouw6DIBhGX8UwlwbwgnTqezQOyqX+iQoFNDXGd
 y/aoVvHc4bvfBsK2oMO6JZtyOsFAtgpAbtkSPbt9NQYVGLECCspIzlulcJjrGldYweTjH7AYXb
 O+ojLgiuRcyF4YVAacF4beJ/jj+bLXr/m1Ig/2UOI1q/ngYUe9mhVhNLqX2uhmGCjTN4Jxrjk9
 N616wCd11dpR9Ts+/4BG0aKrtwAAAA=
X-Change-ID: 20251203-add-mt8188-pinctrl-support-547d9379974f
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, "Jill.Wu" <shu-yun.wu@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

The driver is based on the kernel driver for mt8188.

While at it, also add pinmux_property_set ops for mediatek pinctrl framework.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Rebased on master
- Removed b4 dependency since MT8188 support is already merged
- Link to v1: https://lore.kernel.org/r/20260116-add-mt8188-pinctrl-support-v1-0-fdf3b9227c71@baylibre.com

---
Chris-QJ Chen (1):
      pinctrl: mediatek: Add pinctrl driver for MT8188 SoC

Vitor Sato Eschholz (1):
      pinctrl: mediatek: add pinmux_property_set ops support

 drivers/pinctrl/mediatek/Kconfig              |    4 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     | 1344 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   12 +
 4 files changed, 1361 insertions(+)
---
base-commit: 64662b99c0ebc56c2773ca32a20aa055d25719f7
change-id: 20251203-add-mt8188-pinctrl-support-547d9379974f

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541F61061B12
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 16:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93FEB83FD9;
	Mon, 30 Mar 2026 18:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3CLlF1+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECB383D17; Mon, 30 Mar 2026 18:01:33 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F260783D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 18:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4042fe53946so1782427fac.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774886490; x=1775491290;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=amuXKCnnLLvhOVhgUM5gHbyVLCaAtDLjU8fSZWNig/Q=;
 b=3CLlF1+kNsLpYIQTMLgJueS4M0JCVYpSIxvmrmWw0wfGD2gXjYZUP6wQAYPyHQXDP7
 ArAMoK8oD5kJcl1I3DszffAgi6+21Aj4qrUxRwMS0k8u1d4Ftfn8vnmWfBuMULoDkP34
 jpiC7P3BYx4Nm53tTF/Ttb3eIOojxhM5WCxPJES36/y/vCz+mb6cFe2eZyJMmIzMRmOq
 ayelBHYRaxxoSgJu9mSR8iwclMj+VLtBim8sGce5ZWC7X5yCRo4b9EkxM4xwnz567+Az
 l6g57WZ7dJfuLii3oJzSHdT+iDu/C9sJjWJR2PpkK0WjFF8HjVH1dixoncZYqzq0tG+5
 SkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886490; x=1775491290;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amuXKCnnLLvhOVhgUM5gHbyVLCaAtDLjU8fSZWNig/Q=;
 b=SEAS9iD2D/SxAMaB4etE+cfsE27HeZoHieZy1JeCzeiJ1jKaemnBU25RKHKqnwBbs/
 3xjIUYfIZoSs5M1mXp5RnTnNTts3XvKp3JN4jFDfz3Mued2Crz13mGl0KxejMW57LOu/
 k96zVgQFWq3kPZDfnwhYdA5NAecT956/19ihS5Z6tT9Aesyof42kJiG/gc4DjKKPYxYx
 5oZT80zdSTclzIZATmMqTTj4h//JPCXT4cYxLv7NiorJBn61Y210tNyVGrfIAe4f5FRJ
 kVtwpabt8f21TocdXebCllBRFOAgUyAydhviAwtRuw2pb54MlWLPwURiaBYgyvAaap4i
 kuOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXej5ju7VMMqt6DpU1Txbj2wSTfeu7pYY81gewuLqe4Uld1W+UfKvc6on1Xlo9s2mWs03IKp7M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0I9D4qx4RYjZVagzKjau2PRZMSB9+4q+P3K24ap3D0NM6lRkq
 UZB3/FRehwlbCIqG7jexV4Bg6tVnwYRRgxHuz8X+qvSFvGrzvGr1fP4+SDuAVCtEnPY=
X-Gm-Gg: ATEYQzw1qF+yS52nyPn6QcbSLi+VwsQwuJ+VsjfFKtivLegnicpbALauOVYUKFusGmc
 rRbCLOvj+CezbpY+QNwINENp0VVu7NP2/Ww3xol+PxA3VhUyuyLtSuDgin3YWWPFpSkuDatScRE
 SkCUqxjfPeQ7xQeflLgFhpoFPM5ZXrEKqhLl2F0ENpd942b6X8NSuQ0LlEDBkg/784uAYk6RjCj
 X9y6ugwqtv7Q2yUJeWV9FzkOeyeengJrANcI/jGoJMyFNNfWU25a3++cdavkGmgJedKD4gD7aHY
 JWMbzYDG7SXJMO7wZw0tuMMyr/M73BptaqWESabF6SIJYdQL3noRPVoG4UHJrmSVfercQv1rsBG
 znph5VhM1hSbC9cTTS28YKyVbktLgkTu1F5I7DuBhUpjZyND1tUpiLBu1IlHq0so70RrA4w8496
 BslK8Y1wbPjNI5tTSezI8aqeWlxvZj
X-Received: by 2002:a05:6870:6487:b0:40a:6360:2db2 with SMTP id
 586e51a60fabf-41cec15daf7mr7092364fac.21.1774886489066; 
 Mon, 30 Mar 2026 09:01:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5432952fac.4.2026.03.30.09.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 09:01:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] pinctrl: mediatek: fix mt8189 MSDC and I2C pins
Date: Mon, 30 Mar 2026 11:00:32 -0500
Message-Id: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOwQ6CMBBEf4Xs2SoFQ5WT/2E4lLLVVWmxLQRC+
 HcLeve0mezMm5nBoyP0UCYzOBzIkzVRZLsE1F2aGzJqooYszYo05znryKjgXqwNT6ZpjPfET2f
 GtVC64FKLo4QY7hzG7wa+Vl/t+/qBKqy0n8Phu4+N4WuDWnpkyrYthTKxjm5kDgbHACvgTj5YN
 21DB775/20aOEtZkYqmyYVuMBeXWk4vqh3uYwtUy7J8AAmDTOEAAQAA
X-Change-ID: 20260313-pinctrl-mtk-fix-mt8189-1f7cf61af74a
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cu8rqjVEjgZ2KY5bdAEN4vc3HBTw4B01WqNFYBWWHHc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyp41d/6+YGB1TkP/fFA6NVl6uwutfxWqrpAp7
 M3M0v5UcGmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacqeNRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiuAIAJTzX3YLaS255DrBaGcop7rmM4dMgKhNurUlCql
 MwLKjhuWay42VmA4AwbywpjEu9pDbbJ6K8Tdnc34JEzNHU0AdEBZwwwDhUTQygS09iyais64mCo
 7AYqdrfsAEYSIoueS15AT78+30enKXQtRYnp4IILk3VgxquiotDyHmAFvYnS0taztoea4P/Hr4X
 0m6uT4rwrA+NLr8XkTuNhF5RNBk7c2hwZ5n7PbJs6zBBJ5DGYK42/BYf6KV2cKCYtafcwWw71Ps
 rVvUSYwVvsRJko0VFwkX8DsMwbbDybmsu8EBCFOxviyGHy1iZ6d6er8tT5O9HcdHnJqhskTtNr+
 8KFE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

When trying to use the SD card slot on the Genio 720 EVK, we found that
the pin configuration was not working entirely correctly.

It turns out that there are a couple of different ways to set bias
depending on the pin. One requires setting an RSEL register, which
hasn't been seen before in U-Boot, so we add a new pinctrl-mtk-common
function to handle this. Then we can fix the mt8189 driver.

Finally, we add some additional debug functionality to print the bias
registers when printing out the current pinmux state. This can help with
debugging similar issues in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Simplified code in "pinctrl: mediatek: print bias info along with pinmux"
- Link to v1: https://patch.msgid.link/20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com

---
David Lechner (4):
      pinctrl: mediatek: add handling for RSEL register
      pinctrl: mediatek: mt8189: fix pinconf bias
      pinctrl: mediatek: print bias info along with pinmux
      pinctrl: mediatek: mtk8189: set get_pinconf functions

 drivers/pinctrl/mediatek/pinctrl-mt8189.c     | 416 ++++++++++++++------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 105 ++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |   7 +
 3 files changed, 342 insertions(+), 186 deletions(-)
---
base-commit: d9eee3d17882ec40f8ca5e231046bbf287ab4369
change-id: 20260313-pinctrl-mtk-fix-mt8189-1f7cf61af74a

Best regards,
--  
David Lechner <dlechner@baylibre.com>


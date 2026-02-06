Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8CEE209D
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 12:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB4AF836D3;
	Fri,  6 Feb 2026 13:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZEGRHVsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84EC83AAD; Fri,  6 Feb 2026 13:50:45 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7368D8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 13:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4362c635319so436182f8f.2
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 04:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770382238; x=1770987038;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/CCzLn880DHAJyj8knj639RJu7r0Bf4zjY9cyAvA8xs=;
 b=ZEGRHVsh1Qp2wWzSDxat7ZU2980RIV1tOlLo9MMG6KfR4/5vJqhweeJT9RSWxqCG7Z
 Ot6SHacYOPiqWJbPYVVcinoWWPklUXc5q3ofLFAFsFFFYK3GhhUIR258R4D8DxI9qpvK
 cwFNytfx704Ke5O/qMmdKIbIr21RIEcG4yiFynbamCzCn3ZjUvYoKsCspJgI+fyteo3I
 k3Uz1jZg3DlEBawrgswfl5ryzKb5dZTXgn1cjXDbEaaJVoIo/kjFg4Kzho8f+zFzOY74
 oigJQl88eXw+PzKzqaKn2xWQTezTJbWuMV7Nah/8h33g1rjdJqU4JgKg0pD5697OwdjS
 Jtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770382238; x=1770987038;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CCzLn880DHAJyj8knj639RJu7r0Bf4zjY9cyAvA8xs=;
 b=Rz5fXJRK1+jbdkjUzK+qXKK0dRdHckyI2rrtuomyC6esphjweugCaBV+nh+pOpldAv
 59yPric2kyOIWqxK42RUhYKDbtox/5mvcijMYqsgJ/y79YsiO05ghEs8Q49Ba7MWieNQ
 iriJYlRXhmdchevyVnrj/grKePVslraqzHAL98noLLJHl/JsbMw14NBy+x8YjUEvjLiN
 42SQbr6gqZDCAze8EtUEt8pyhgR0/YOt5zgkQc4erZUnWuUyBAgmJ8vLRm/R1xZiZv95
 yDvW7qE75cW6zpy7/TS6e65ozus8P7fcdvPO/e1y1uxO1wsv+HKOrNawpC+RmAxVikbY
 WFYA==
X-Gm-Message-State: AOJu0YxYOoNrMZfnKqpamqiV/GE5x8seGJHZVo+qLBh4xAmsYqV8eEYE
 gj1uKBppkIB0dzI4jsbHkV1JK012v7AqIxXCjXFRx6JmC5Y9n13+tZhVSkZjtOPKiv8=
X-Gm-Gg: AZuq6aJ6GDjyFyN/5m9Zuc2221foY/J21KTKx6c+doTkG0RUpsoAedDktaFHoFaMy8N
 8FZqzmFwCkeIAUaNgn/e84fDCdb2PQhNaRIFCv+eXQjErlohSU93kI71+cq9/N/6lcfdVyt7/fj
 AHyDY5Peybxfa5SkfNELwFnpe6EjFqGb7foaAB9oS2iuYe2301Z18A4n2xfEmOsoSvbl8ADmJK6
 0J7MkAfwF707pc8WDnsgYfHcW6BqdATuw//zZC/YH31r7NZrbQaX61zBaBNymB3sW7b7F+4DdsE
 sv+XMDdaoh4cLtb9AeGHFR9H/NXmikxhqmggIW7SbkSIDhcim9gMKusxvTisLZRU2KRJoEH4cO8
 MM7CJvFOSbM2UQPixAIXqQKiYQXTMyn6AI6lE1wuefrw7NN8696UOCIs7xbs8426EzYd3CMXpX3
 myDlflkbDHmqXZwMUtX3VmhKUJRBCgGfKzQ7EgUiv8wsuxDaofzq/MJbdc5K1uD+4SZUxX+DXbA
 B5PVRhkvQ==
X-Received: by 2002:a5d:5f82:0:b0:430:f3fb:35fa with SMTP id
 ffacd0b85a97d-436293800ddmr3855668f8f.57.1770382237828; 
 Fri, 06 Feb 2026 04:50:37 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-56a2-efb9-07f1-cf08.rev.sfr.net.
 [2a02:842a:d52e:6101:56a2:efb9:7f1:cf08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4a1sm5812386f8f.17.2026.02.06.04.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 04:50:37 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 06 Feb 2026 13:50:31 +0100
Subject: [PATCH v2] board: mediatek: add MT8370 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-add-mt8370-evk-board-v2-1-105c606f80dc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32POW7DMBBFryKwzhhcRJFSlXsELjjkKCKsLdSCG
 IbubtpqUqX8H5g/7z3YQinSwpriwRLtcYnTmIP8KJjv3PhNEEPOTHJZcclLcCHAsFplONB+A5x
 cClAF2dZlpThWhuXTOVEbf9+zX9czJ/rZ8vp6lgzdQuCnYYhrU6CWQiG2waOwQiJpwUtprDZWG
 iKL5LFubcv+UmXIk0lnnhsMznfge3IjbDOEbe6jd/kbuCoYNKVWwtTNLtiLp4vLOqX72zpXL6D
 /BXcBApRQWVOrYEv9ie7eR0x0yRLsehzHE9bCDIdLAQAA
X-Change-ID: 20260204-add-mt8370-evk-board-6d2f94630b67
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Julien Masson <jmasson@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 David Lechner <dlechner@baylibre.com>, 
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

This adds support for the MT8370 EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

MT8370 is based on MT8188.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
This series depends on [1] for several cleanups such as memory map.

The new defconfig file added here is not yet part of any MAINTAINERS
file, waiting for comment on [1] to be addressed.
---
Changes in v2:
- Add defconfig file, missing on v1
- Add dependency to [1], for memory map cleanup
- Remove board/mediatek/mt8370_evk
- Link to v1: https://lore.kernel.org/r/20260204-add-mt8370-evk-board-v1-1-3132f953d845@baylibre.com

[1]: https://lore.kernel.org/all/20260205-mtk-mach-clean-up-duplicates-v1-0-b7d4a43c18eb@baylibre.com/
---
 configs/mt8370_evk_defconfig | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/configs/mt8370_evk_defconfig b/configs/mt8370_evk_defconfig
new file mode 100644
index 00000000000..48d3f64a42e
--- /dev/null
+++ b/configs/mt8370_evk_defconfig
@@ -0,0 +1,28 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
+CONFIG_TARGET_MT8188=y
+CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_IDENT_STRING="mt8370-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8188=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y
+# CONFIG_RANDOM_UUID is not set

---
base-commit: b5213bbfdcb1812be510427857827ee8becb9f8f
change-id: 20260204-add-mt8370-evk-board-6d2f94630b67
prerequisite-change-id: 20260205-mtk-mach-clean-up-duplicates-a6d7b7453179:v1
prerequisite-patch-id: c807f91e384d7853a624dcdac51146f533e83302
prerequisite-patch-id: 2985130c9247aa746578d0999ef36afae5bfe81a
prerequisite-patch-id: d7f2bde6b8c257d93ae3155dbe51c2b1e956a87d
prerequisite-patch-id: 68791866bda399c0744095f456da7e5e50f50a48
prerequisite-patch-id: 2605f6c13e06821386bd3bfbdf09e57bd8f3c940

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


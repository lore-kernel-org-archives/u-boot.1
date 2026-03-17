Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90277FD877E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1B6843EA;
	Tue, 17 Mar 2026 15:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qWIiC+qG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DA38439F; Tue, 17 Mar 2026 15:24:34 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC2584399
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso8665665e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757472; x=1774362272;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M5JNoIOuoyji/46zdjPuPcHlZ1p1wv56YEjkIpe4kyY=;
 b=qWIiC+qGHWK5j2BsE3OScWOJm4xFU6Z6buK7sKDf1uyWLRfuJDWcRHvt80tpknomIA
 VTQsL0jOxmMWsefl7MsZQD6MzaYExPZwrkjvNLQN/T5EnZs0Zh63gzJ/4k5iNgbo+JBb
 ilLaUvzBkgag3UlSPtu1clNHQwWiQfvJJWckhQTVvWciyAEbYIIS37fg2pWb0Fs7+kHF
 ja6awtq9ati4dq9RTOE9OUO1YJZu0MXnP8DrZ584tMyMwQ+W8tOiFVJS55TE1FB2DZGR
 K2HbHZ8JPnvG70GZuc05MWH/R8YCb3HfVPu5uQtx3bHkncRFwcy0CjBgu67jt1gq976E
 JAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757472; x=1774362272;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M5JNoIOuoyji/46zdjPuPcHlZ1p1wv56YEjkIpe4kyY=;
 b=FKctnk0s4+gqCu9uBI/tEHR/KeMZr+fy9V8PbXNewYSVlYxjCQXXWnork1GgI4b6gO
 e/UL0hGUkOawx3QS1Fp6QlbXXAAhEs0Vx009WDhPIcokURULbNtbVTsoNA6tLfA08rE6
 Gq0VlE1nWVUn2/wnonNYEzR/P3zfYw9CJyZxwkKdFTSJNrNTPAY5T/Fn7OtwQ3txaXV5
 N9lT1B1PeWbJOF/QoX1Wywop/v4NJPyag5kHYlpvDXnE1XOLECs5xU4XyJkKeaiBypsC
 ekxFQpm6RCucR57OBubLLS55fOGyKhK6GMuYAB5I24trBIyekbcuDr4bQsULcIQY/PM+
 tlvg==
X-Gm-Message-State: AOJu0YwYMnJnLLy2/g7Naz2uw/fTX7nUtO7i3tQhpYN8PQFiPiuh35Nx
 hKCGbJLfT2tqYK6cRAFLFSaYlYC+kWKZhsL/m2szkk/C6c9QrMXgLNzf6UgQNi1g7kY=
X-Gm-Gg: ATEYQzzU6ylpXb3A91nnTwhLwDTk3gQSmhf0x0+OUSItdqQuEzGnay5cHT/AIXxZSo/
 g9/m7qIM5O42wVYIALKNpE1Ynl0yXnrLcnq86kPdL0Wvzuoe3jOwGS+DnNzeQSnBqrPuMBh//fP
 py9htKV3z2D5Fm7oqA5EARkNc5AehsHlYoPzArPPbcyru/q9sIW1TnaD8kGMujnHrEk32QtcgM2
 HPsv6jNXYim5HoS1Uub5DPd/cxjObBjb2knKNf4r7io87hpTzXFdYKxhEDj1D56qPd3SxwPCjGi
 Uwpb/zyC8QmfzkDKG2QgqzSyOBn7Y6jKsiTP1mA7YhUt7Ds1zCoj1wKnU2ErN+noTKF30Cu5LwW
 XJRmNdKFWMAshJRz8l324VlyjMeFMpJXAi0bbgO/zSSSN3jxeDnknYOen7pL7OholY08E/G4YFA
 zXa4IUg7kIcst757KNbH/eYKbe42X4bnzWUb3WguHTjm/oi8APHb6U6U+dU8KGnwd8YLnVf1oTR
 gYksWjWzlwglPsc8WZM70SoE5m1Y0bwsWvV0BKkLajoPqcn5ShXZRdneSoyNIM/nEA7Vpj/AMpW
 xtZpD1mastVJf70G8w==
X-Received: by 2002:a05:600c:1383:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-4856eac2e70mr57334665e9.8.1773757471909; 
 Tue, 17 Mar 2026 07:24:31 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48556400f76sm125425675e9.1.2026.03.17.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:24:31 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:29 +0100
Subject: [PATCH 11/11] configs: add new defconfig for mt8395_evk_ufs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-mt8195-add-ufs-support-v1-11-7d731ec438ae@baylibre.com>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
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

This new defconfig is based on mt8395_evk, where we remove the mmc
configs and add all the ufs related ones.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS       |  3 ++-
 configs/mt8395_evk_ufs_defconfig | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 4f371592059..dba620e57d5 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -21,7 +21,8 @@ M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
 F:	configs/mt8390_evk_defconfig
 
-MT8395 EVK
+MT8395 EVK (UFS)
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
 F:	configs/mt8395_evk_defconfig
+F:	configs/mt8395_evk_ufs_defconfig
diff --git a/configs/mt8395_evk_ufs_defconfig b/configs/mt8395_evk_ufs_defconfig
new file mode 100644
index 00000000000..9a9de689953
--- /dev/null
+++ b/configs/mt8395_evk_ufs_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk-ufs"
+CONFIG_TARGET_MT8195=y
+CONFIG_SYS_LOAD_ADDR=0x60000000
+CONFIG_IDENT_STRING=" mt8395-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_UFS=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8195=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_MT6359=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_UFS=y
+CONFIG_UFS_MEDIATEK=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.52.0


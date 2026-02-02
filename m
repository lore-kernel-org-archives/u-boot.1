Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4218FE73158
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 12:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABD5483E1E;
	Mon,  2 Feb 2026 13:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aTMIaoBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E689B83E52; Mon,  2 Feb 2026 13:28:30 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19D983DFF
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 13:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so37204465e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 04:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770035308; x=1770640108;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+/m+08YMOXegWoDKzW67rUU5uOD76RohJQz8IgntrY0=;
 b=aTMIaoBp7dLR7w/Txe7pBo+Nn2Ozjayy/aqMailMublzphM+P5gdFgxNf8dD9pMiuO
 fF4vGs/Qots2UIuiJ1mzY57FQHKp+qn7qR4pf4kW52Ci0NuvI6keRfqdo+F20sioATIa
 Edwh2oOEFpbsFbaBV19JsjviMo21pXnTTT2fl0XDvktPTHdynhdbbL/Q3flQFwM7/kWp
 ckSzmLNvlfU4uuYdm4YDzVHhH8wR84A5l0dLTwteS64YczlMzjODbYxOuf/DGl0ZV91V
 +JX772tmih6ZSZVbICZdt4xm0dwuzddUkUmYARav62aycL8VSSgEjFW8/KbiRn9nH8qB
 erNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770035308; x=1770640108;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/m+08YMOXegWoDKzW67rUU5uOD76RohJQz8IgntrY0=;
 b=eCSi2A97bg1pJoKF72L1ASteZgt/FSzjJAEMc5iUgsC1IzlmZa03EpghLSQIxzvZht
 pRv2gRFL8LdDStcArnSejj0dkeNL2qQMZCVCapw9Czvlti1i9oy0C7joKiiUj+On5rad
 zlHsBdp3ZXsv2GHmCWNVoFmsqK5mEdlEdIelXfSQzY4iEu9h1GMdV8CNE6pZlzvabOgU
 5h7P7SGOXj6UWl5Sgm7NWL6vBBajkufY0A1uApLeGqmjLACprdIYzVjKVltRPV7zB3ln
 vdpt4jsub2o/283NxwO9wRAeuwIFKoHIcuGXHe8+Dp/SR2uBKXd6Igu2D31VB5xD8qFE
 IVAw==
X-Gm-Message-State: AOJu0YwZTkpGUUIMhkL4h09pmwtWAPhoWnZXsCqZUSLNXCu57CoPdkG+
 pdRdXX1x3YBxVHI4ltWUVjT9W8Fs0nFtbI78aJ/I8ieCMWseMLSYe3hvvRtvXaX/ga4=
X-Gm-Gg: AZuq6aI5+P4Xrs2xZYmP2U46nSg/KLhwFk9AQzUBSRWE9XpZ5jUXgdJV0KvU0la4HiZ
 sZMmTlrEEXmSqP2970Ph79Bnf7BH8pU5VNs982Csm4DD4N7bYi/NUMSYBOfvS7RRje1/vYn0stL
 CFoJSIJ7atsaX7tLAZjRFmvtVt7HeeP6gJ9oz9dWE5tSkbosH4TVfRBq0kaQojb9VFDuMuFkjdB
 JcknOgU13NnqP6Cz3bFmTM93MA3ESg8Czg1hRXOA5Sw/29G9PgXAjcEolqX7MuLA3pwLFCIBK+c
 2o4iK1GoDDx1HA4meDn3cVPleZbggAzhAgEIb7h+nDwJWXi4mMd+De8lYJ396HRiJ04c69fIftJ
 uVNDJThW1kXVwrTXcFN/stbSjgGj9JPAHUJX5B0ICqJ+14Ck/ia5ve+Z5QVD/PgkZMuyFWkmF40
 3RIg9Q0RalIjhgivQ33PWieWlloBsF0j/mPmXNBjIVqY/tlwCtUH1JNi2cBSJWtYz8/w/IhhG7a
 ABg9rqpdw==
X-Received: by 2002:a05:600c:590c:b0:47e:e7de:7c41 with SMTP id
 5b1f17b1804b1-4808493b586mr129935895e9.16.1770035308182; 
 Mon, 02 Feb 2026 04:28:28 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-1bf9-06eb-939c-90d1.rev.sfr.net.
 [2a02:842a:d52e:6101:1bf9:6eb:939c:90d1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd79c7sm410977115e9.2.2026.02.02.04.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:28:27 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 02 Feb 2026 13:28:26 +0100
Subject: [PATCH] board: mediatek: add MT8395 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-add-mt8395-evk-v1-1-304bd45f609b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12OywrCMBBFf6XM2kAySUPSX5Eu8pho0Laa1iKU/
 rvBbsTluXAPZ4OZSqYZumaDQmue8zRWEKcGwtWNF2I5VgbkqLlAy1yMbFiMtC2j9cZsq4OyDk1
 CA/X0KJTy+ys89wcXer6qdzlG8G4mFqZhyEvXEMVWKC9E5MphMs4q26JwUfqUvJMUrPERE/z2d
 M1/jag1jzyGpdxZLHmlwniSSmKyWmrTrQL6ff8AAQ5aRu0AAAA=
X-Change-ID: 20260129-add-mt8395-evk-956c49a28f28
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
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

This adds support for the MT8395_EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

MT8395 is based on MT8195.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Hello,

This series add basic support for MT8395_EVK board. It is based on
MT8195 SoC.

Cheers
Julien
---
 configs/mt8395_evk_defconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/configs/mt8395_evk_defconfig b/configs/mt8395_evk_defconfig
new file mode 100644
index 00000000000..9978dc4ddf7
--- /dev/null
+++ b/configs/mt8395_evk_defconfig
@@ -0,0 +1,23 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
+CONFIG_TARGET_MT8195=y
+CONFIG_SYS_LOAD_ADDR=0x60000000
+CONFIG_IDENT_STRING=" mt8395-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8195=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

---
base-commit: eed514b11d04a2f8a949521ad3bffba3ec98bd2f
change-id: 20260129-add-mt8395-evk-956c49a28f28
prerequisite-change-id: 20260129-add-mt8195-pinctrl-driver-0f3432f96368:v1
prerequisite-patch-id: 5dbe4461fa3456f3c7d80a7fa5a60d52bc719f65
prerequisite-patch-id: fac65a0526e9c15e8a4b3f81d85e61d1947dfe16
prerequisite-patch-id: 0d12fae50ce6da8dc7b0d978e4640431038d5904
prerequisite-patch-id: 95a410145f65dd7219a67db5ce0849b09a5f8524

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


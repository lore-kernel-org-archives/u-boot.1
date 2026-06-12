Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA03CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FED6848A6;
	Fri, 12 Jun 2026 14:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Iunemd2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372BF8005D; Fri, 12 Jun 2026 10:59:24 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51ADF839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so481990f8f.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781254761; x=1781859561; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r6e30NnIxfUjuwrRrL3yBaUltNvNuYyG5DP69IAKow4=;
 b=Iunemd2h37aV9PB4yZNFkmkGZnjK2qzVCIQsWNBsPjlctX7WtkA/dVMUASbs6idDVz
 XqHrnLypcH6W/W8LPyeOyMpDg96d+zXJh+QyHVwfOgu4Se/fl+YCzuauX8iZZrPulw4j
 rQeh0aeElTs9yt50sv1RkUsYW/h38mS7P4mECh9GzPMUkmhO8+7jtq4g4cwT/ry8J+MG
 Qh61D01ouU/+6BkP9nbhadfxIh5j/XX3KpmSjlPTA7ZkQRVEBZJw3JBVKxdvC5ZrySC4
 sntchp9XOCzEJOMiQQ2fMZR6PBp4KVPPyc6lDuceDpbobkn9FAro4Na4ehXvneZREdoJ
 N8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781254761; x=1781859561;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r6e30NnIxfUjuwrRrL3yBaUltNvNuYyG5DP69IAKow4=;
 b=r+teUgAS+JjWYxBddDOLeCFMGOGdpB1HBDdM2c7ah+LW24rBFgNmEJD9I0khG4Re8l
 WDx/bu1vlIXnsyTu15flzeG/sIEq+KKiHMCM2KayqFK3eWjtiRixfa8sAPxKuBFVuJI/
 7vzVuJrq9m/dCgcblHACcGKtPSTGdLMLE5niKVh1psYVQ3NMovrvBX39uFL1s9yddzT1
 bnP0rP1/K44JQfEif3EWfzNMZtjiCU2iY7xmkzPnLxdQJ1kfKcqqJBmjg2sk6lFEMfLn
 iPyKYjrTEdgu+Tt/vlxTd1i2wc9+P4AkfjPrYrL73OHtfa3tXmOE4zINMbYKrU0IHS2K
 1ImA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4To5ZbuDjtt0maA9Cv/ekDfIXensBuUg2qiNSW6Tb9mZhWSqp5MH6ELHLd2iUs/+q40JMSqc=@lists.denx.de
X-Gm-Message-State: AOJu0YwFBAcTyyxwvFCrM/5Fr7slCe/Q0GGFL6WDKUONpVfPCImKw1ZU
 zJ+kaZ+3SWJr/6+7bRf28ZZPYrxtPidtRpJnyR4fkCM6UWDHMkd2kNWI
X-Gm-Gg: Acq92OG33IUJlf3bVLC8GDH1eE6SZGEBRqohWEXLaiQT6dunFcdUGUzCsq4cHDrElXY
 flOC5KgK4RuTLeudD0tWm4r4CPxgMq4+9vtA9XQ0zeF9gbelya9gdsrQpESY6EJme9Ty8xRH8EZ
 L3Tru8i5B2KHWa3uMvO6xh9q6cjkO+XRriKA6pjWuEI/jeXWDHq/YQv9Kc5aS+qrKlpi1O0q1ke
 GxtLpZSTunKp+47OHrKp4dipUgjOviJAvgAcru4eHlva7om8uvHXqRkv3d6NQtFhR6DT+qyn/4J
 N1051/ZgMwc7JS3v7iVlV3Gwzpkfp4N1IXM1IqugiXaX5tEvn/cDM1B5+2lbsXRphPeJxPifpqU
 Evl2VGrIX5dFYen2gbzNNUHjtZyfFO3UXmHRkvtO6aRvlcEzizweGRdHdokfhpEW5aat6AED3H+
 R7EJMNNf4kC0r3MqzryMu/tyg8HHlFl/kXm55GLV8G6JG20kYxCj0GZnaQRJ4YivK0jw1M/Xwr9
 FB/47LffQCrCq4u/m/lZl5EkHcKovIDOzJmWXwIgzt3f6SmZrnmnxOnCpagSH7svr7kueywmKBE
 xQ==
X-Received: by 2002:a05:6000:438a:b0:453:e3a1:6580 with SMTP id
 ffacd0b85a97d-4606dbad46dmr2764533f8f.25.1781254760975; 
 Fri, 12 Jun 2026 01:59:20 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm3976896f8f.11.2026.06.12.01.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:59:20 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Fri, 12 Jun 2026 10:59:00 +0200
Subject: [PATCH 1/2] configs: toradex-smarc-imx95: enable PCI_INIT_R
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-fix-smarc-verdin-imx95-eth-v1-1-851197b36dcc@toradex.com>
References: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
In-Reply-To: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:35:35 +0200
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

From: Franz Schnyder <franz.schnyder@toradex.com>

Currently, the ENETC device on iMX95 is not enumerated before network
initialization because pci_init() is not called. As a result, no
Ethernet device is registered.

Enable CONFIG_PCI_INIT_R so the PCI buses are enumerated early enough
for the Ethernet Controller to be detected and used.

Fixes: ff0540fcfe49 ("board: toradex: add Toradex SMARC iMX95")
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 configs/toradex-smarc-imx95_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 9363eb5cbb6..9abadb0ed1a 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -44,6 +44,7 @@ CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_BOARD_INIT is not set
+CONFIG_PCI_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x30000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y

-- 
2.43.0


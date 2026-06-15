Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7986FCD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 19:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30FA84704;
	Mon, 15 Jun 2026 21:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="dmxBVfys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A988488B; Mon, 15 Jun 2026 21:24:36 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CE2846B0
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 21:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69e98c0516dso2895806eaf.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781551473; x=1782156273; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VzComrvON6DY6bjRImdOwqYVWPJB2He8OyJ2Z1suTmI=;
 b=dmxBVfysUj6nlzjhm4pPcIkJV1QbUmqbTbir0z3YQm1feX6zijqf5vIPxcwZf8ewDN
 yyRCdUGM76KNoBEt0Zyi3/PupRuf4I+Al7BCphERlzeB7M0Xex9Yf2t2MLFiNtynwQ7f
 3Jx+W080K7t7GiVin3Z8SYT8aH8QYgqvXsM1V+yhLkFl9r825lubz9ZSBXQc5nC9ygHE
 pd/mxfygFXApD9l/ZpW2j4aG+VooiDT7TA6l8cP3EJux5LYqR0dTC2p7+xDvR9SVKAZG
 s64gZ6WYq0ZXtXfkJxtCj7lFIJzftqyA+JILcEhP7tauAuwlQbi9PByS5T0P2rmPy7dy
 rUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781551473; x=1782156273;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VzComrvON6DY6bjRImdOwqYVWPJB2He8OyJ2Z1suTmI=;
 b=Vbyg7p691nzqj0MZ/8d6nVMnrbtHD6a0u1Dla70TUUpstujTTsQ8v7gT+hCTzIsKH/
 xOt/lVlG85//ZpUz37/n3uQPalG1unjPbAQ5aSVom7FJgYiH5x5eP8qwl8fDonMlRLWk
 vPF8anAWFXb2B1kSWrZXs13ee/2rVEEuv8aQTXUldQIdmBA41ncmgMTqJZiQ/DwmNwes
 7AEoznaBw5nqf8TFBHxso4WUFyEl1oRwn/lCLyTDSxUwIFYZTv2DecuPlFx1/gTxxmHt
 SKsVIkvFpRRUmW4hxKioi0qVxMp2Kxgkv0kTkNICvElVOk+sVVIGf1U0E+UFHraOLcHC
 F1lQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GgwFpWyoTqD9Vpblun2lZP6trRKePzk8viGR7jxce420suscmSpXoTdK7K912z6ZxxziJDDk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywv+QIIyG6lAs8GJ3cdCDKSQlOTXXiAFx1PNZBaTrjU4BJQ6M93
 A8yjwSow3RZE1vPtjVfLetfVQER/VzWNyXSO8T39JcVN2RhSwAG/f6z/3h9BCXO6wL0=
X-Gm-Gg: Acq92OGfGwrGW07wOPCEMq8zv9WnljabvsPUPlHDyEIhalD5BBwaAZThy10U2t1jjKc
 a8/pmxP+iyTqVF/fiJCNZyVG0df29Y7Tu5Qu1BkFG/jbbNUr10s4jmOAsJ3oyTNrfE8oelvt8oJ
 X3/ViH5uRSMHuTKxxsaGvcfqMqwLyca2QpnTy6IOG8157slLJwwj058G/rSQmKMWHJXKNxlwzkl
 FwjmQemjk+7SvgZxtxzknTFr9KwetztXSqlr6P9zymAK6RyoD26LXUyhDKbVx3KocCXrduhFuy4
 8GXh7NATZ+vCTYnIt/7y1C1MFwfv3ipyBif/Spm7hq+4yF2hKji3nvzcuzik+HvoBcioCVfJgKM
 xzMHMyM79jy3gN0XCTQ+0foc2OmRkW7jHr7/T0DOvCldqEUnaaZe8NY2NLeeGfswfNlOGH/qT99
 Rm4756iLJ6m172S+kD2fNqYqpqaKXT
X-Received: by 2002:a05:6820:162a:b0:69d:7777:75a0 with SMTP id
 006d021491bc7-69edc679560mr9458949eaf.24.1781551473428; 
 Mon, 15 Jun 2026 12:24:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430866fa15sm573450fac.0.2026.06.15.12.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:24:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 15 Jun 2026 14:23:31 -0500
Subject: [PATCH v2 1/8] mmc: mtk-sd: select LMB_LIMIT_DMA_BELOW_RAM_TOP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-mtk-fix-ram-size-v2-1-f72cfc52ce58@baylibre.com>
References: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
In-Reply-To: <20260615-mtk-fix-ram-size-v2-0-f72cfc52ce58@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Rudy Andram <rmandrad@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=meP0Ie77VZmKx8M3zANArqNoanwRozOdHem2EHVKVs8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqMFE7O3KQ+0Pbh1ssV6WDZc+teVJTfy8daXyWb
 9Ywoh0Y+XOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCajBROxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AGekH/2bdXwnxTcG/n+4+L6NSHHDOkaFRMBnBOKbBD/j
 P7qyQvu2BveBPvRJnyafhByT376kLv2q1Qgg95mSlW8wGo8MUNlsXTIV/WvXVveoGl9lZAZOXnH
 hVcHq3CuqUtnylZTi4HNiNYOlGJ6KfibIKJY5JOX2yNgX/z0BQMbjfTSzeQkUOaIbIQ8H0DIkOd
 6s+VZG6fNSdhcEDimD686QfQgbi1EAEnJEEpaTilpQ/WFl/HxGuXpsEa3urnWT2+zZ+t0H+EsuQ
 7gVc+1ba2gYLD17cx762XLddYxVClvAkqRV5ZTrb5nPrTlp7rtBoWsL8FsI6+U+9B4jtf6b1S25
 DqLE=
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

Default to CONFIG_LMB_LIMIT_DMA_BELOW_RAM_TOP=y when CONFIG_MTK_SD is
enabled. The MediaTek SD controller can only access the first 4GB of RAM
when DMA is used. "imply" is used rather than "select" in case someone
want's to turn off the option when DMA is not used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/mmc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 24bd16ad5f3..6c513328de2 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -858,6 +858,7 @@ config MMC_MTK
 	bool "MediaTek SD/MMC Card Interface support"
 	depends on ARCH_MEDIATEK || ARCH_MTMIPS || ARCH_AIROHA
 	depends on OF_CONTROL
+	imply LMB_LIMIT_DMA_BELOW_RAM_TOP
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
 	  If you have a machine with a integrated SD/MMC card reader, say Y here.

-- 
2.43.0


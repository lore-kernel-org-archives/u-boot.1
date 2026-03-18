Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCEC10775E1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 16:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD59839DF;
	Wed, 18 Mar 2026 17:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wJDPLufM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F8383BC8; Wed, 18 Mar 2026 17:50:54 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3CDA83952
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 17:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b4d734678so15945f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773852652; x=1774457452;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1zK4iDvx1CQcJuD/sEuwy2eFFvaqD3vY6Y3mOnjikxU=;
 b=wJDPLufMwqb7AOvjMdigUkQfuuen1h8+hQEgftLDiDHI/dMmZae4znMOdACxXoHDDU
 vvjmS8GSIlPsJ0G1DJDuITtHLw5566Zpaq4605WIILmlwoUUIK8yMgIH8s0nmqQ1stor
 GJG8/TUrNW1fuoXje8drGd04u1I1EXbkzJgHmx4eNH+iMgyuuIZCuboqFDGnF8CfUlAi
 yoRtLyDC3W0Tzq8Wqb4rRljtFayN6BH7Lxf0xs60W++SfVT2jUG42iMByMCC1yTfHJw0
 G1EISwgu1CRm4cjINxfb4qsAVG6jT7jMnutu5cRHtx+D6NSBNujeFO0LjBAKN9uGpr0G
 DE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773852652; x=1774457452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1zK4iDvx1CQcJuD/sEuwy2eFFvaqD3vY6Y3mOnjikxU=;
 b=jD6Xw4JoKm4HeFZ/eiD0T5ijPnQ2LzAWb7oR+uN+1CRO93yNnQ3dFFPWl0RQGkiv2U
 bNoYqQMiWK8tPnqAvTPK9v0MVf9xXoCHRtITkFFaAscVCP1M3TA8HwoPrjFnKwXxw8jd
 oVfjXQo/pKyabtAsr3YhR51EoR0bInpuKb4H2SH1JIx0XcvFRoPJL9RducOth84NTWqh
 RWIqG/hXUQ37Z18K0KOHFGxRkZFZGEZ3I5a5tYThHX+b0XQqts9KEOgFLsRCDSBWZr93
 6380bzEXYjHUWgXF9kU1OPAo9YAxlzu2o4F+zEYV1benBhW4+sgVW7TgbCvIDwLN24Fk
 k45Q==
X-Gm-Message-State: AOJu0YwAdQ0uJ32WQeem267gVc4GF4WEQytz+mlPnVdSOctbuSKPsucb
 WWW0MUeu+vHETwLKdmtA5nurnqRvjC2Wf5GdsAabNSvNGWNPkOIc+fTygZPf5YpUQq4=
X-Gm-Gg: ATEYQzwkt4UPC0A7XAML0ILXiHbZxKCN9md8SjdOg6rOqrRIEjIAyvuzTTBUJzIuzI/
 Sv44uCpTtrNpsf0uie2ouNVHEjoStz2JtkOJ4SXjhrnQKPdyJeA8J36jXUGoAJmUWX7L8yf07R+
 xS1Y1OEBu6LpjtyDYf7CcuSgEq7lo0yUVeaiiyrm9AHPoPWZ7a1Vz0FOmlaI1r9stVoVRU5NFbB
 5wUh73LWE5nORDN0vCIBoXfnkYY1DPWIvOFWy1sR1UPgshxbRhJ2Mv8q1LOBc+GeoODLJLmKuI0
 zEFC+uMBMHJlL6Fr4+pzVb7+xd5Fg3+BgrT8woPpD/eptSmshrgPritCd0TPu1VQ3+Lgp0j4/es
 v9Xked+BYU9xvbjwrw3KUQMAATkpT7MNuFK84/a6xo6++aGJ9fgVMdgufW4MGErWVrWMmX+Cky3
 GZCH8dINkmXBsMkb4savXAfK6TxWysAMzAs76UX3d3n49A82BnruMFDhbDo25KJC6Q7fIxxGIJ0
 YeHgxsnt8kwMcUVfNpguTii5Pw7fw0wDmcHArhwo7QFlB4wTkg97imtY9DBKq612rDv/FqaI27S
 5rb2f0U=
X-Received: by 2002:a05:6000:2501:b0:439:c42f:10c4 with SMTP id
 ffacd0b85a97d-43b527a97b3mr7206905f8f.15.1773852652307; 
 Wed, 18 Mar 2026 09:50:52 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51892290sm8639527f8f.20.2026.03.18.09.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:50:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 17:50:53 +0100
Subject: [PATCH v2 1/9] drivers: phy: phy-mtk-ufs: cleanup headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-mt8195-add-ufs-support-v2-1-f18eeeeb0e72@baylibre.com>
References: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
In-Reply-To: <20260318-mt8195-add-ufs-support-v2-0-f18eeeeb0e72@baylibre.com>
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
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
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

Remove unneeded headers and sort them alphabetically

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/phy/phy-mtk-ufs.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/phy-mtk-ufs.c b/drivers/phy/phy-mtk-ufs.c
index 1eda3df858d..14a90cf2064 100644
--- a/drivers/phy/phy-mtk-ufs.c
+++ b/drivers/phy/phy-mtk-ufs.c
@@ -6,23 +6,15 @@
  * Copyright (c) 2025, Igor Belwon <igor.belwon@mentallysanemainliners.org>
  */
 
-#include "dm/ofnode.h"
-#include "dm/read.h"
-#include <clk.h>
-#include <dm.h>
-#include <generic-phy.h>
-#include <malloc.h>
-#include <mapmem.h>
-#include <regmap.h>
-#include <syscon.h>
 #include <asm/io.h>
+#include <clk.h>
+#include <dm/device.h>
 #include <dm/device_compat.h>
-#include <dm/devres.h>
-#include <linux/bitfield.h>
+#include <dm/read.h>
+#include <generic-phy.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
-
-#include <dt-bindings/phy/phy.h>
+#include <mapmem.h>
 
 /* mphy register and offsets */
 #define MP_GLB_DIG_8C               0x008C

-- 
2.52.0


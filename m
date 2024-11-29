Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB2DD70E01
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 00:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D592989426;
	Fri, 29 Nov 2024 01:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732839266;
	bh=Gf6oPdHbbnY4gX8I63pcQBD7S8xoRyqCOU0wJP57jmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=shylyxswkd8Rojb6bsgKPK266DaUAUK2Xm7LR3080/YCKnFQKDwV20CeHcxM3MiPQ
	 So0S6boP3fHk3oTfKbpXCC52DCc7glkoLYds7X6PWeUIK1kGFvhf+7Rfz4Qmub7jJo
	 p1oj40C4in60c5drxn19U3YL1OIaHAVItq7dyhnf8/Zlza6+NlrY52bPwS/h2Hgcau
	 kByj2wHceLQ8u0bu49qgTBKLNMGGUHknE0WGyp51/7KTejn7lWb1PtBv7Ovh9ZCQhq
	 FWKqgv3tMd7vORqRKYvzfu7t4XAjrms+GUO5GEcFuw/nQPlZxkUh/qLKcB5/AFkSxs
	 06iGwfTlDTHMg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BD77B89493;
 Fri, 29 Nov 2024 01:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732839264;
 bh=Gf6oPdHbbnY4gX8I63pcQBD7S8xoRyqCOU0wJP57jmY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zAYq3ehd1hcZj3IXY2IaLY3idgGk8ZRwZIjNsbfqbfAF2t72HOHp9jS9W4HysH1Vh
 w93z2jxRWTlWESwWeMPD4ikUKxHNmi+y33LTad+fble1og02BB9VHQBvZ0JUMovzo+
 cDG31gDtkIaE3T4oc7E7CB1j1oqeQsl8IbmV3oqi3QndIQ6yLaEmqAFzb9oAj5lC9w
 7v/8oZEdusthLxCKqcMINoDAHPxCa2wMqzWDTSNu/sazpY/bzB+C1sl9X2nEVkklCP
 3HXvfL/+4sOGGQbjONuLOusLLpMJqqMnkCkhQJWd4iw9wJduijbJIZiBsVeqagPIph
 s+4Vh5BkdoXIg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] ARM: dts: imx: Pick safe DRAM size on failure on Data
 Modul i.MX8M Mini/Plus eDM SBC
Date: Fri, 29 Nov 2024 01:13:54 +0100
Message-ID: <20241129001409.218850-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129001409.218850-1-marex@denx.de>
References: <20241129001409.218850-1-marex@denx.de>
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

In case gpio_request_list_by_name_nodev() in board dmo_get_memcfg()
returns error code, pick a safe default DRAM configuration instead
of bailing out with some sort of hang() or panic(). The BIT(2)|BIT(0)
strap option is the lowest known option of 2 GiB , use that.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
NOTE: For v2025.01
---
V2: No change
---
 board/data_modul/common/common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/data_modul/common/common.c b/board/data_modul/common/common.c
index b5f83908771..9e35dc5d6cb 100644
--- a/board/data_modul/common/common.c
+++ b/board/data_modul/common/common.c
@@ -47,6 +47,9 @@ u8 dmo_get_memcfg(void)
 					      "dmo,ram-coding-gpios",
 					      gpio, ARRAY_SIZE(gpio),
 					      GPIOD_IS_IN);
+	if (ret < 0)
+		return BIT(2) | BIT(0);
+
 	for (i = 0; i < ret; i++)
 		memcfg |= !!dm_gpio_get_value(&(gpio[i])) << i;
 
-- 
2.45.2


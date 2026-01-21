Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D96C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D0F8341A;
	Thu, 22 Jan 2026 00:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vmZKqO26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F028B83A3B; Wed, 21 Jan 2026 23:38:27 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF0F18341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 23:38:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45c962424daso123164b6e.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 14:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769035104; x=1769639904;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xdKC+tSKytwRcrB9zU/qNc8ORyWr8hBqnDbzuJdoRds=;
 b=vmZKqO26eVFLGVShMipaL8tA8OyUy6mGSDEtyf77satpmb01aaNC9SfHD9RRXqIYtp
 EBeAjE2T7Ma6OX58KuR1HoW9sOysvSr9y3gyUvD06G2uNYt+SKSmY1YTXlCRM6M3mBlI
 VTwP6/6b+14MP/Ds5MRpvl8F7vRB1j9L1k5r36eWj7TZLADNBHiolj0ky0rsG0xgSPEd
 GXl3hisFFGLmPrEAkBvL81qeguNAIvjKB1lPXKMzLpe+K+nzTPJXG+xmmvR8V275EEPF
 Oz+o9Q0P/ou1s43WcRRC2sECCkunBSh+efwK3FDo9SSTJmitxcS6hCg1b03t1Zje1xWw
 W3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769035104; x=1769639904;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdKC+tSKytwRcrB9zU/qNc8ORyWr8hBqnDbzuJdoRds=;
 b=FDfdifOjQgsUVRWpDjURH47BPf5j4EZe/WAXntREdWVNCNy6cK3PsPMXx8yl7WGwEy
 0Ejwmn4XHk5VW+6bDbSjrHQSJIL7nZGzxrQRO4oAvYG2P/wtLbBTTidvLnMUqwjfucJH
 A4VWoqG45/0ukTNglFSmmoxe2IW2Tcn8zHsW6EYChzLZ1c+vvFilC764mEh1UQb3iKz2
 al7ZNSHvEOl1fLFWK04iVek9FKVjMwipOMgFTIAyszJtlp5k9aZBsj8RgDM0SNtcGK8C
 /KB2PsFyqbp8eQU3OK+ZVr1xlfNEuDdQWSVsUFIjTu13+JKJRlp4Q8x7KuZ3XjfFtZtu
 wnbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcpgnONkJf1kOq+B67XDpSPYOMRHqa0b8SVjMck1B3BG1JSECzC5Db4UO9WArCbBM4qvzTSCE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn/KX+Utt8ZmcWZW9+azZXKNPyZ4OohJ5b5U3nhkrXPKmVFZEZ
 +jvHdNTIkJ06AislaskJFTmUoWwGIV7IQzh3zg+MYpfbB4vMXeWP8IIQ2Vdi9dNv8JI=
X-Gm-Gg: AZuq6aJL1Cuq4M/PB0wYryCYMps6B267yyrKrBZCDdMACUFuMTB6gUjrw15tSq7mJrT
 3x7g1fiVhmAfACG7GRQInX6DN2TAKCbubVLD+jLWMeAGjjB1bbKkZMRSFD1/rURHTkEcRo+AhPy
 y0H/CzdAhG4/RqQAdXNDkhfhV+3oxtUZGcm17C1Y5CW4Jeez6NdFXf6PxH1lwJxnvWum/ggIxgP
 j8VE5B/YdOCOPi3RPJCVvATnGF+dutD3NWynAh1Aw0BQskDYJzAoAwyTqx/f+LD8kTagdO5FCUr
 EsRrIEcgnWOWYo7vybBCR2+MIXNJ91AzF1ZNyJbvFeRoc8bVE792b+ApeWyGHUIiE7DC0vra1NZ
 Pz24SFK8ByXR0urMFPsvn70si2miTQeGjIRYcAotAVtB8nXBpTfKfaOSqjNHO/o7XCdm9Mzd/hZ
 /5X/SeQOc4iZ4o
X-Received: by 2002:a05:6820:1ca8:b0:662:bd3d:9f1c with SMTP id
 006d021491bc7-662bd3da17cmr1073442eaf.53.1769035104409; 
 Wed, 21 Jan 2026 14:38:24 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9a8b:7a9:24fa:a0a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd150dasm12452458fac.14.2026.01.21.14.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:38:23 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] mmc: mtk-sd: DMA support
Date: Wed, 21 Jan 2026 16:36:23 -0600
Message-Id: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtQo4iuEi1MpxrCErUIpLsnL
 d/i/wyRAlOEocoQ6ObI51Eg6wrMpo+VkG0xKKE6IZVA5wy6tKN1GuPl/RkSGrM0c2vbvtcEpfS
 BFn7+6zi97wfC31ZgZQAAAA==
X-Change-ID: 20260120-mmc-mtk-dma-support-ccf3b5d588ae
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, "ht.lin" <ht.lin@mediatek.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=n1sNVlLvZhbE0Oi8JKs406krYADInErrX0RDjGaY5rk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpcVU7UiyAAVOIpHAUbkR9KHjb4T/cggxBi97OB
 iolD/GGwqWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXFVOxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5a4H+wZBoLspzeJ3+wWg06bJRF6sz/RWnb2fUwQ5pVg
 F00HPm5WLIp7kFLE4/8/yhsjbBFZQvi7HHLWwnI+/8+peVNQRd1zxHyPwWx8CpjeUNSf80HBPrj
 FdkdwGtGqq5TGgBAB34NLpDkWcdnMK83Cfq9GzuBSDjy8EdvE8uDmRMWKYygTqtPfgrJ3HfhReA
 VdWSK6pacr1WXr2PWZ8C9u+dFrrxtDtg1bUgALWaXAkYwBKHBbKQW1GSCG/98979b9hXW0bXo9G
 0ZWXh4+NoUZnY5w+TRMf99knrU56u1zRRa17hbr92W3n799kT+N7aGpUn/e9ySdgpWOyDZUhl9d
 Wp9Q=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:22 +0100
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

Here is a patch to add DMA support to the MediaTek MMC driver (mtk-sd).
I also took the opportunity to clean up the driver a bit by making use
of GENMASK() and FIELD_PREP() macros first.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      mmc: mtk-sd: use GENMASK and FIELD macros
      mmc: mtk-sd: fix misaligned brace

ht.lin (1):
      mmc: mediatek: add DMA mode support

 drivers/mmc/mtk-sd.c | 519 +++++++++++++++++++++++++++++----------------------
 1 file changed, 301 insertions(+), 218 deletions(-)
---
base-commit: a334853922a3cd87c70033d02d1367991dc66bc9
change-id: 20260120-mmc-mtk-dma-support-ccf3b5d588ae

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C2AD0D795
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 14:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F4718935C;
	Fri, 11 Oct 2024 16:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kkn9ANYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0337289336; Fri, 11 Oct 2024 16:38:33 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AD88931F
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 16:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so19133425e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728657508; x=1729262308; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YlRMSzP5woErb7cZnqB/1p9krWNZimLtVC4QYEvOS7g=;
 b=Kkn9ANYLyho52rY5i99za9xPhBXAlvTMXM20XcYMV4gnuXv0+lHxpSS2GzXMFvdGBF
 GwsjqjyNYBSSrwPAbPhvn9Un2k4RTvq6o+HUWz2XzXc8Uv67N9XDhy5EZCAYkiAi7xEJ
 bt+b0z9EEHuDrxUgoNNbH5KyrsrYH6+DF1ae07o0om7U+YA9igo1YLP6iOrTAE6C5CWB
 2qpXh98mp1sk6kpGtqOLu37EoxN++gzlmQtiXHkQoaI0ztHW2RtjSXHEBnNH4xET2YaP
 +6xBwIgOTqFXT8UN/WI/+t/0UyC85GQgFqjU1r2S7DpbHOF/D6UF5C5aKzUxBwdUcHPx
 dssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728657508; x=1729262308;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlRMSzP5woErb7cZnqB/1p9krWNZimLtVC4QYEvOS7g=;
 b=EdXgjRtIYmQfPL6l+CkZzAZMex2W0RBXbRYnEkda6JoqE1OAnmQEpa1oF3Udz5ujWR
 13vpWRTU43bb3MfMehFPjWWZzfa3ShdnPivINCQ259vL6+78Exw35j74+CGQX6HiRTZM
 ykjDTnyu6wwR7t8zz7RcNIHS5ALr3EuVFonY2mtI2GioKN6F858YVBZN7dGA2v4eX2eq
 8EaKHYVkKjxxbyx0aXONJnlOi6Tqf3dhq65QKBtQoeIoSDOhYhQGnvctTC2bmpS0SAWa
 tLTgcwbeDQtPTmaEjOQkzhHpbJ8HEyw6gAbNmpiXLt0nEV2TdRhkzAijSULCIK5abxdl
 v/0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFpZKgdRVFFt8RIubFKS5jrAr+wPeES0YLl/r02SLniRTeI2CezDlRfOx26J5lo2iflhq3gHs=@lists.denx.de
X-Gm-Message-State: AOJu0YwTioeSJUtxTLJmAeHRxzi7qjpxI8qZi85NR/NT89sFfRgFsnDP
 GqfY4eLwqYAgc+MTGc83gKUcptVLwwdN/K+698GHbg21GuZi8KCQ5mXJYPphtds=
X-Google-Smtp-Source: AGHT+IEMmOfKEKXmRhuHeLddmLKFvs0cX6dvQbsjS1FNfeGIjBidPRrmuJOaGtsmLqpwAK3bLBSoOw==
X-Received: by 2002:a05:600c:468b:b0:42c:ba1f:5482 with SMTP id
 5b1f17b1804b1-4311df56381mr20243465e9.35.1728657507807; 
 Fri, 11 Oct 2024 07:38:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-430ccf5188dsm75991815e9.24.2024.10.11.07.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 07:38:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/3] dwc3: gadget: properly fix cache operations
Date: Fri, 11 Oct 2024 16:38:23 +0200
Message-Id: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF84CWcC/43Oyw6CMBAF0F8xXTumD1paV/6HcVHLAE0MJeWhh
 vDvFhZG4wJ3c2eSc2ciHUaPHTnuJhJx9J0PTQrZfkdcbZsKwRcpE055RnNmYIBrCD0UdyegskW
 FaXbW1QilfwwtoGVoeC61UoIkpY2YDmvD+ZJy7bs+xOdaOLJl+789MqAgtZUl5QqtxtPNNzaGQ
 4gVWfCRf4A82wZ5ApXUQhXKGJuzH1C8QUYp3wbF8qEwmmqNpRHuC5zn+QV2FCRBcQEAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=isgh+/0vJcc8OYyydcp1DZl8URJfcEfvDDMRIaTNcgU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnCThhdboWPUb5e1hGm7GA0WdzrfEiYtQ7H9goRUYg
 oh7W/x+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwk4YQAKCRB33NvayMhJ0b5BD/
 9XUFsx4XmK6/pagIXkLkf2CfQiXQY3t52hRWw/2Z16a7/JBLHW/JEoDJtW7kmNb0mw2MbAJyhxfBEK
 iS5NqZIr8kONYCiZgl+LZ35jgwRECVJNMydsRlmsfozQ3GvxZXbWEw6LnBnxDEpC5MhiE582Owj6eY
 GHEzDf64xXrxQ2hMgHkniqyvm28i2ID4ercJ/cRwYUSAid6ODmtkRyx1LpFin7ncyaCXvjhqGr6beR
 y1HoU7Xxohh9hw9PdxjISYFkQ0orXImm7jcY4iHwXBfj19DWCfvHyeNkuGGTK/9CGZidWbxBfLGwMM
 Z+IajiQL3lIZxNDmon+vcc7euPv4c5ICnnie8f4xz9q5WVn2xfcJ5SDeMd+W7dGUs8uywIvr7eQqUN
 /Evx7DbhoD6ZUkEh/xR7nD1LaxMzceTOttzRqZbh9nuf4T+dZoWHfr2MyO71UkT/aGOoyyil3GRx2f
 NE1rkviOdH/B3JlBKjQ/chjWVGr4Fsz2wOa3pzgLojBlU96e0mkGRJQO80UN6eu6XdwWSPnrwPFV4j
 wKWY5Y/MdIS/H70N+wGrQWa+akJAXbRBLJqmahHX4DSQTT4/vBmzbUPr/JH7s6kij2kC4BO17wfKAy
 tZdHgZERirVLObc/HP/Q8qzp950FhT+oY2tH0NMcxsg9zrGktbXCu74U8YPw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

We experience huge problems with cache handling on Qualcomm
systems, and it appears the dcache handling in the DWC3 gadget
code is quite wrong and causes operational issues.

This serie fixes the dcache operations on unaligned data,
and properly invalidate buffers when reading back data from
hardware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Go back to CACHELINE_SIZE, and do not use DMA_MINALIGN since it's not valid for all platforms
- Link to v3: https://lore.kernel.org/r/20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org

Changes in v3:
- Cast addresses to (unsigned long) when calling invalidate_dcache_range()
- Drop unused CACHELINE_SIZE
- Fix warning by casting ctrl to uintptr_r when calling dwc3_invalidate_cache()
- Link to v2: https://lore.kernel.org/r/20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org

Changes in v2:
- Fix typo in drivers/usb/dwc3/core.h and rewrite patch 1 commit message
- Link to v1: https://lore.kernel.org/r/20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org

---
Neil Armstrong (3):
      usb: dwc3: allocate setup_buf with dma_alloc_coherent()
      usb: dwc3: fix dcache flush range calculation
      usb: dwc3: invalidate dcache on buffer used in interrupt handling

 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/ep0.c    |  6 ++++--
 drivers/usb/dwc3/gadget.c | 10 ++++++----
 drivers/usb/dwc3/io.h     | 13 ++++++++++++-
 4 files changed, 24 insertions(+), 7 deletions(-)
---
base-commit: ddbcafeb53e7093c58488596bfce6d8823777c3a
change-id: 20240719-u-boot-dwc3-gadget-dcache-fixup-ea1e92758663

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


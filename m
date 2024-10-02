Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3E4CF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E2A890E9;
	Wed,  2 Oct 2024 16:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ct6UxBJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864D1890DB; Wed,  2 Oct 2024 16:39:39 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4823688DD4
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 16:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37ce8458ae3so3076046f8f.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727879977; x=1728484777; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vaGmmxiIY6lbY9schxXTSyY3RpaxlfEytXp4JYAMJ+0=;
 b=ct6UxBJPX+GBntU/5xI+t2//hCIV4TDG26OS6SHlNTkdyZU++sInhZyUfMHe2V6SK/
 B+i/WKYvDU2eVmqNzX66L3pZmyR5/Juf1Cuqo2D68RbN+Qwdez6bV1FtgHHkNyBppj+O
 SlmeUhsVFJGr1CX2ftzt+Tgdd8WxXPMU6Ls+FhaFUwimcpnqD5LRSJXDmt5ZeEaRbRzc
 KN5F8W3oxx2pVUJ1GqUhFLMtenfA8cjpMV9XcKoYCXVWdoKEfdQ1Ytcu+Ef9yyAY92ea
 Bgmuq6qr68lluQJBS75u+mWwv6yo6pUxOmXx4LT36V4R3fwaxMWqfWsQwOnP5uMty8+e
 OEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727879977; x=1728484777;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vaGmmxiIY6lbY9schxXTSyY3RpaxlfEytXp4JYAMJ+0=;
 b=q0aeDIMeBmTcU5taZBx4dtB+xUE54FwVX/oDL9SRnjaw1b1jc8VKS/ma2KfI7DfjEa
 /432SVCfsSkf2YYAoETMBTuiVQj6hrgG12If1mWlZ6nbcUAkDwMBON1qH57nZaZNYDpH
 Eb8P58vsCMhb30juWvzcuotptT+/JF66RizMRDmRy2KnZiZnAR8GS6OblPIzxS2Hdz31
 Xf6vOKtzapiuqlRi1o3tm2P0oHhtqmoX8uYlX8lD6nzbXnX1xzfA2psjRMjV9qdyilMZ
 fDUJVycO5RCKQM7f4Ito/6WB7CjfV1h8ti19wzPoE6DNZ6hCOil9+uFP2RvYIUdUAgRF
 wEKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7IiZ8G/d2DNt/+5oWq/KbzrXK8b/hh1hAZLlyUv0hcvMdaLcgva3rxTFZDzyL0Ai+7pJ/4Lo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp9TOf+u0w7zCScO0NIsJsUJjVRpviCerEvqFv8XZ/0uqIi5Pw
 HPHTH+UbRSctbR5abo9DNJhbYMk/sqTFDssxIAfvnRxDA7sQWuaEY99aVNjRSKk=
X-Google-Smtp-Source: AGHT+IGPRCInLe/z/Wb8LdOvxgyiK74HbOFPAr2uAw9E4TYxZUDlV3B2ja3PT5V6UaM+PG6RAy/rcw==
X-Received: by 2002:a5d:424b:0:b0:37c:cfa4:d998 with SMTP id
 ffacd0b85a97d-37cfba196b8mr2621213f8f.49.1727879976634; 
 Wed, 02 Oct 2024 07:39:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e65c3sm14056083f8f.60.2024.10.02.07.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:39:36 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/3] dwc3: gadget: properly fix cache operations
Date: Wed, 02 Oct 2024 16:39:31 +0200
Message-Id: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNb/WYC/43NQQ6CMBAF0KuQrh1DC5TWlfcwLsZ2gCaGkhZQQ
 7i7hZWudDd/fvL+wiIFR5GdsoUFml10vk+hOGTMdNi3BM6mzEQuyrzmGia4eT+CfZgCWrQtpdu
 g6Qga95wGIOSkRV0pKQuWlCFQKvaFyzXlzsXRh9c+OPPt+789c8ihUlg1uZCEis5312PwRx9at
 uGz+ABF+RsUCZSVKqSVWmPNv8B1Xd9luXX5IAEAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GfbA3zniiujI438rfwCcDakKsGpX25rIoOVqi2MIG8k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm/VsmVhgzxeJXFc8AB+36bvj1054rMl4HYTq0rXSM
 GTFbvQuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZv1bJgAKCRB33NvayMhJ0fEZD/
 4+sKdw/0sa/wCQ2pyIzDlvVdrfm286CakXMsm2JZW1wSitSo+ddQSmE1r6prE30h4S8/SbINnTJt+M
 LPdkIWm5qzkByuz1tv32zSpUS74e/KOT333InFHdzOB4OJYlBOvDAB0sMblF8N89/yNXMnv1HTZ8A7
 st6085sZ3Az+VR8xt2S1dyHOUI0FSg8EUBkBgBguSSHFfM6KP8CVMkP3iIGpnR8Ng/5suB35D/NOH1
 dwBQRFwN7kjZe9Jh9RmTY2qlXnP1z4wUUbiO8cundaQpwRthrlD2cyGD8IJal6C+iAAv/rOPgzvaxs
 NO6PH/YIF/ftBIV3+nOl18RMwL7lQ+uJxvRHsxdHNXRlz99syV1OkLudSpSIQOI5KlhCd02gSbb4qO
 y5UZQ3bWAX0Z5ZxHaisAiXr6COnof3bqCV2/+2r86Sb9N1KF4R4EmotNTTNzSnmXWn6Z3qh1h6wgqd
 YklXjNKLr/7RoyJWCebLHZSnmV5qdfR0cZmTAjsxtyed8AYPdLBkySBMVX630WeZdHRCAn7RSOatTD
 GIKx0gdyMpSBnvCM+Nkview9CbfpqNAklDef2nwnN0POWmSehWULBBKszjlTRgGVTEYg5zXAj3ot0i
 YHlr/TA/FTg/C6w3as1K9Dnnsp8jdMqBXjsRL2gqbNbvlzQbMcrDma1nrt0A==
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
 drivers/usb/dwc3/io.h     | 14 ++++++++++++--
 4 files changed, 24 insertions(+), 8 deletions(-)
---
base-commit: ddbcafeb53e7093c58488596bfce6d8823777c3a
change-id: 20240719-u-boot-dwc3-gadget-dcache-fixup-ea1e92758663

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


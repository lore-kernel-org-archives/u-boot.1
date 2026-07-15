Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBF4C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65ED184C18;
	Wed, 15 Jul 2026 16:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="W1liAttv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389F684AFF; Wed, 15 Jul 2026 15:37:13 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB1D84AAE
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15dd4b9132so786501166b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784122631; x=1784727431; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MV2P4uYLYXAFHNtzFaiABigiNDkddAB2O/NBTeUJNiQ=;
 b=W1liAttvS/e0VZqmqu5L9xmpEytkzY+cAFc8cpAviUM8QYDtrqzwMFgRfX/CvrWMOJ
 FdzvrpVDuqrhkkf9IPwdmFLTmv8jh3j3+r3y3pi3KES5M8mBmpF7Z4Xd7YB/SPp824XX
 jN/VM2O8Vt6qeYF4hRuWqmA0dPOQq5emrSIMdsryO6/PrOHwVfTfoqds8SiiAQvpvtfN
 6INM8U9XoazE0iGysbP0BiSl9iFkOkkz9DXV+9YvCzHtIIlycSCx7VhhoZ8WZXRQ3+md
 nPnb2u/RjmBvJPysXFTK3pzKjaDE2n3LKpS+gH/mTUaictBanGj+a9uDNNQUOeRRhdD4
 w1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784122631; x=1784727431;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MV2P4uYLYXAFHNtzFaiABigiNDkddAB2O/NBTeUJNiQ=;
 b=cEDyPtMYSEsmRx6H3Jp+ElFW3u6Ia5k8dxJgC5FN4KlwRVL/m084dp9pF6KmQn/TYj
 NQlvejZbGHwGYNgX1eVMM/zWxPOQjc1VT2/fj1mVMctbPNt0g4RWtg5BeJbpvSIbPXts
 avo0QJVTTaIsM6JWRhFReoRAbXlKtWaj+nDtTvW5bnaXOx6GDOeVkWvAY6GGBYY5Gqf2
 IZ2S65V4OJa6AyYs6tfff/1eGP2n/pXHoyPMsvnILLaoz7/HpkPoo75V37Xo+T3MFJh/
 zJVmargdf0+vnzZK4lrGkeu3U2HEY8WX+1nNRhoKUzObaaATTuil9XmtZkIT+8N/STZp
 TSRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXH1OfL4BJzaL+4lcK2Wk6XPOcMncjNXGMCju9YTlTCqvGhJo5LiSqYig6/YQQ6UwCW8twdXQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5hNjtIfmzO2MmPQfxL+LkBDRmHQFjvu/PqUlGgDNRFj7+EEyN
 pnqlyOnj/uUI+e2PluudQ1h006ExJ3ClgWhD4lAJ1rojCe43d7eVgTY89z379x/nGAc=
X-Gm-Gg: AfdE7clHP3ir+3TYplNiCvoqbBHWYXDB0mJrFHbiWkCLF/brIkSnIJhazvMt4jwKbmm
 0tveSLFjh2pkmc2R9KKCVSAO+My42sOs1ZGJhwuazgWhyGxU5InqYSAyHP+VvPx0PT2U6g3OUrx
 ptPmvvuKUpCXgw3rpOB5Taz/k6gNMygNIJNwmD8IZumBTF0SBaFW37jtJKn/ecZOQEXkLw4bgnQ
 jWqHY0UOXKvyIJeRBVijL1FDUFO9EYS9x1nx21cud1VNTM+u0+L9fuj1W48l/xkSPo8ZqV2tO8t
 X6TEuhBZlV2Fn7Vd817n/xXezao34sbFHhYUNrSSyOpHkrA+ud8J391jxLBH/J+a8iOOvjnldx8
 MBk9m0vKn3xMmDtF/7LT+yqVfNgSHLiuYlBFLcP0yZCBhlC573FklyoSrIQeRTWmF4eQRhCuOuS
 0xaLBXV3FqBHwIh8stctdMVEuqaWM+uzHTdRHkzaFSRjeqsXa9yxTmIcfXw9EhTRge52LzwpXWM
 Ob1H3IJdeSbLJ8i
X-Received: by 2002:a17:907:3d03:b0:c15:f476:9685 with SMTP id
 a640c23a62f3a-c1667a4d040mr409322466b.30.1784122630658; 
 Wed, 15 Jul 2026 06:37:10 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871962cesm29896166b.25.2026.07.15.06.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:37:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 15:37:07 +0200
Subject: [PATCH 1/4] phy: phy-qcom-qusb2: Sort headers alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-qusb2-msm8953-v1-1-b6e638599e02@fairphone.com>
References: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
In-Reply-To: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784122629; l=787;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=uqRKjaTdoSqwRfn7ke2kicj/LdQgQMRtLHHI7Cv/Fp4=;
 b=qHCSq2aKxSMEMcTd71M2wEWAos5cen97KJqm9cZySp1u86fU4NutrbgypcuU6wEKTqZ9TdkZR
 Hugb7b+BcaHDQEeZ5V4CYc0yQqKJ6j6SsDiQk5xauRtARJCluPdF3kZ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

To prepare adding more headers, sort the existing headers
alphabetically.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index 6278171b100..a6c1095f412 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -5,13 +5,13 @@
  * Based on Linux driver
  */
 
+#include <asm/io.h>
+#include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
-#include <reset.h>
-#include <clk.h>
 #include <linux/delay.h>
+#include <reset.h>
 
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 

-- 
2.55.0


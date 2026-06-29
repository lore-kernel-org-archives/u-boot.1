Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EDCC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C7B848F3;
	Mon, 29 Jun 2026 10:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aroXj2ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADAC84869; Mon, 29 Jun 2026 10:45:40 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37EDE84105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-39af64026dcso13076281fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722736; x=1783327536; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3ql/J09MiR0zVXgQ1EvzoyYSMmaesSpTtqPNkzpNxM=;
 b=aroXj2kozenxV6pNCiUOZfBJZb+gb2NbmQxrLSRbIuhQp5X9qftKr50SK5ybU2auup
 Y/oquO+QEXHoWkwDNoyNBjJp601dwrojwIhTaTSrCzy7lSCUdjSaewqdd5gvaFHPOWJ4
 OkU7E3NdB2LYmA1k4vleDjhWOcPFecTR2bAd7vkscy/2vH3sXiBaXOU579ihE3KwZHDJ
 zVvF9rTTuu8LoaE+82VH9kq+3+I0fI0B7+/mUlKTuAXxX0WnuQZFWKYG4bgvP7qoQftH
 63mNH5ojUlu35Gubnddmk24KQmKGVXRVE1ebc+5puxosLMi+IupyppTmUu2ixhx/R68K
 wL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722736; x=1783327536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E3ql/J09MiR0zVXgQ1EvzoyYSMmaesSpTtqPNkzpNxM=;
 b=DodniPxrlJMCf4GXX1AQe4fBBnaiNyh0r/17JE3OfjUeObP0ciSq5DEhKyx8VUwS1K
 jSACz03GPD2tWVrxPtvvq5paQpwaqOgSys5uCEU9MVyQM8UGJwNznR+0QzogTOvcBR1w
 206tWMIr67KXO9tVjHtXWJD1uugg7egldqYO+lvPW0tA7pBRy00IzUyoxsmfOxnysf0+
 zve5LtGxsIu4dBKdCVIhrTOKg0w3K/C2m3RnGRCFvY50FDzFMxciFfDv7I+XPOT7k2GE
 GFRWynZbx6fgf3eO3Czs4HyPpuBvrfssQOqmPCZZ9h4rb1TRtcnMWBPpI2JNg2I8jfC/
 LRVQ==
X-Gm-Message-State: AOJu0YyCqpeF/Rn9AMWiHBY8846BP1ILID3Z4GEkoQeOmqrR80Sjbs7+
 GktEsLR7nSdNL89U/ad/+r4hvXaVl0nPB13UG8RTDgbg74VAAvq/ik9pNJoNs3fU/kmKPuutqZS
 926VTjwI=
X-Gm-Gg: AfdE7ck6ht9B2aoTsvzuAgVTG7yI6DC7HNx2+CXgx0nxwKfV6TAgvMajp7Xs72YTtLb
 tpZaNtDOkpmCA/sCOUbSzwrxf4rmdStLxYq3VUYt5Epccbbu/NTcAUWh897fw9k2xjiKdIcAAUI
 O1jvD+YNpGTivKsECi0yIXurNRyy/o7DgsYCsVs8sKb1hBJ/76rygUFykpQMHepImCjD85tDaDt
 oePap7tEZyGHZb9km4NptALtpSRcdPeHznY0qrdi/ko8m1nvfgUPqkVx3nBxLh6cna0R7qIr0e6
 rwHrSMFKYqihL6XimlzxsgUSOGmMSerRVkAbOrU/XKBl5OsISD085MBjhxphjngvsjqgsOcrpUL
 2iyKJ0lFLpkiNV+7rVhCMPwCrcTHp2LpZRcTuX1cbiN7uQX6pI4TKo2DNIrg4U5OUe4aaHtq49S
 KUMbUJ89qF3Kh3mpdlNz3sb5YZB56KaEFYx6VUB7E9dmpcGhSOsYZwuFQ0mI1pzZO0e5X6rTqX/
 1hDn8qWQ5Q24rDOJjPE
X-Received: by 2002:a2e:b88a:0:b0:39b:d04:b778 with SMTP id
 38308e7fff4ca-39b0d04bed6mr5434641fa.5.1782722736443; 
 Mon, 29 Jun 2026 01:45:36 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:45:35 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 02/64] usb: dwc3: import from kernel v3.19
Date: Mon, 29 Jun 2026 10:43:38 +0200
Message-ID: <20260629084507.3254232-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v3.19-rc1..v3.19
Commits imported:
39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG
84a2b61b6eb9 usb: dwc3: pci: add support for Intel Sunrise Point PCH

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/usb/dwc3/gadget.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f03b136ecfce..8f65ab3a3b92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_is_last(&req->list,
-							&dep->request_list))
+					if (list_empty(&dep->request_list))
 						last_one = true;
 					chain = false;
 				}
@@ -901,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				if (last_one)
 					break;
 			}
+
+			if (last_one)
+				break;
 		} else {
 			dma = req->request.dma;
 			length = req->request.length;
-- 
2.43.0


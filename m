Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F1FC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6BB84874;
	Mon, 29 Jun 2026 10:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c+Mx18rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963B084A17; Mon, 29 Jun 2026 10:46:16 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8662184105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-39ae03059eeso19817621fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722774; x=1783327574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ficx23d5flTXfdNVIGstOnb8PSR2x0MkWx/QM49TMCI=;
 b=c+Mx18rqBl4i1nbbIRvAvZyh/o+77GXNefHD5a2Y3lAUylY5jeInSnqiOmOKlFPl+r
 r2tsLwYtFZpT7NR5RvJ8ILM4ZSz4jkkrqSP5BGcEMbMICfcCltQMDtOW+1vhBMsNsaJ7
 cWbXeXAKaj9UQRUhlXsXHrU20LcvgnpY0Erhp/9TC2FnoUd1AHzLlo4nzV9cpTXIzdNI
 KNWrQ9fQxEnV+KfHb2QAW3YVbEpjWFXrxptPo33V1QgziYzXdIiX3LECBJwuwMDH1iu2
 IECUlJ9sKXrXTzBceFChGRah1rlljPe6y/RJB1S2IlKMLUHo6XhnrCNBnjs+p0OfuuIZ
 bjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722774; x=1783327574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ficx23d5flTXfdNVIGstOnb8PSR2x0MkWx/QM49TMCI=;
 b=Ji8YWf+6erHdlyanSf/W5H5iqMsN81uXTbvVxlXQ9yZ9HDQNdRk5fWYZu3TCVw77D1
 tgETxeZMMKYM0Gp85wwjqzrOJezEGUG6f2o2RfJKeaV6hbZQJI8oN4rnoy3ORCNECb89
 /9EFJ4Nqtl2G60W+EA7wjfHRl2PrGWz/XfoQH3y4N2e0jeoec0RCJxLy5WRZ6pqwrYPA
 y0W2bm9oKiwpVO9KQXRd/1lazma/NRYkJhbwBFYlqTX1p/E753cUGm87m/oRuJxnoC9U
 6KQPHUN9HQLX5meph0pZ5GAsbENIPjw35yxsJneCALZFAyIXPQmlqygBVOl43mg7zEy1
 WDlg==
X-Gm-Message-State: AOJu0Yx7iMyMwf2zyQwuJ9pVVRauyZALcAi+oTGFQ7oI/lssgM9yEUra
 tXJl6aLwlSv9TSax9lrjLnTvgB7S13IKm5V8Hv1NbR/zCnO2wEUTBCYtaIOBmYghuizhAF75xyM
 3jRDaE0Q=
X-Gm-Gg: AfdE7cl6edoGoFO7mldBx5aYeqsfP2YTLAGtatj8aLhylE54o1KP69FWOKn7UUpZXEO
 iVOExz5jTtj789p8dtPkdE5FY4IJwDoLxNXPOR+7qIfdMlYSXmKEOXpJc+tTnl8MeqSQxAI4i17
 9oK26x7r7GhconmTc1s7SW04xlgrpDsOtbad0Qz1U1xMUY0vDqciMYB++LiEhQh9ji3Qz8hPfmH
 0vNWZdHn4PohlW6jJ4T8yg8Ph7yGLfXC2/tjcPEiB3vXrvT0BMqpMg3p2fWTQPa6zugkr5VMIvR
 PsNtFjDXFyJBKvGRrPVKBl0xwSTVeJGVasmAHAG1sE5rzZGok77RH247T7Ej2YycUBWalN+7sHJ
 Q2e/INe7+5GDXKuNsNxJB7UUsd3NZfbCrwOQEjPHATxINXfAxWQyGmkFeOa0EwKbz5v8yZjgiH+
 4y8/saYhYrb0BIBSrZkuZCaP1/VPd9vNAyS2C9fiyUvRhGZjc6DvPkuw6gLXkLTPxrhk1ddvEeX
 Ifzb9lnECeXj2nZ2kE2
X-Received: by 2002:a2e:b8c2:0:b0:396:7f0e:44c1 with SMTP id
 38308e7fff4ca-39ac9d48bf5mr39244731fa.6.1782722773670; 
 Mon, 29 Jun 2026 01:46:13 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:46:12 -0700 (PDT)
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
Subject: [PATCH v4 17/64] usb: dwc3: import from kernel v4.14
Date: Mon, 29 Jun 2026 10:43:53 +0200
Message-ID: <20260629084507.3254232-18-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.13 to v4.14.

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

List of commits: git log --oneline v4.13..v4.14
Commits imported:
b24413180f56 License cleanup: add SPDX GPL-2.0 license identifier to files with no license
c3cdce45f8d3 usb: dwc3: of-simple: Add compatible for Spreadtrum SC9860 platform
551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0
34a003674825 Merge tag 'usb-for-v4.14' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
e7059ef82a22 usb: dwc3: of-simple: remove include of clk-provider.h
feea468014f0 Merge 4.13-rc5 into usb-next
95aa932c93d2 usb/dwc3:constify dev_pm_ops
c14af973ed86 usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3 Keystone USB driver
0ae99ecba792 usb: dwc3: omap: fix error return code in dwc3_omap_probe()
8bcd9889721f usb: dwc3: pci: constify dev_pm_ops
141769851cb7 Merge 4.13-rc2 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Alexey Charkov <alchark@flipper.net>
Fixes: b1a3ed068869 ("spl: make args file optional in falcon mode")
---
 drivers/usb/dwc3/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 827e376bfa97..75e6cb044eb2 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -990,6 +990,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 maxpacket - rem,
@@ -1015,6 +1017,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 0, DWC3_TRBCTL_CONTROL_DATA,
@@ -1029,6 +1033,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
+
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1B2C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0835C84DB2;
	Thu, 16 Jul 2026 18:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="niRhvk9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E74384C3F; Thu, 16 Jul 2026 15:43:37 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA3384CE8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69e0f4eb4ecso405936a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209415; x=1784814215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jka3IcFHsYd94uPyPHOIWQD9EPDS+oIIGhXnYJxREi8=;
 b=niRhvk9XiFQYkP85qkZ+hlU7UZ2f0GIP7slLL6VF/wIC/V2x67Pbol4rUZtbL2siro
 iOCVqXxkk1cwfOItMqrf3cPzlHB4pbe/51hNfqewbcsceU984sjVA8pQr9gvb2xHFHh3
 NDpFdndzHdDRUZqQBV7f3AQ84tVn8ueDW7z9ZTaW+Bwafad3T3OC0/hT1hCjKGxuj8j4
 ltWv5KwkhLLZb7fgkhQMnL/UPoNgGPECc8lO8W06DHUhnBGT42aussJTHT1M6sZVT1Tt
 cWf+TtfO4QDRUPkSOUaFTvstmMl2Y/E4MkKRZ2r73qCU596pAFLRXgdwBbctmv5CPCwo
 hIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209415; x=1784814215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jka3IcFHsYd94uPyPHOIWQD9EPDS+oIIGhXnYJxREi8=;
 b=L06oGVBc61zN0y2B3QWGEdzWLPmduCxpg/cLS9ee7T9r2jK8ZIOAoc+8Pkt4l4PiV9
 k/Ep5+x3igvD9/Eoh9GOd94wavgGmpRW0q6/vAGvydcnZwUNEc1QQ15OHa59RVOIo17w
 UjwRGbjAG68s4YurkQmmIfsFCpFwZ1t3S/jlmNYJV+X4bI+85rN7ANXgZCMXDYL5BE26
 SVqrcNPptq43JdSnVNmznqxkrcGLDGE3ea6GbXUs90h+KM5BoDvQkaZtvWWQmCnDrDax
 US06ieOwSndDkYqMoVFRMuKRAAXivXRItLDGhlGgHhJS+gwsREc7fDibSfDt1tNVl8fU
 1Etw==
X-Gm-Message-State: AOJu0Yzh5Qxnw9Fani7zGTA0cAoqGyAKExr9Ai9VW+Wo6S+x6I1Uy9Pw
 TEmil7nLNi4r6ojzWsu+RQx6sIR0hhfcbmeVX4JMJzxIB8EQuKruF/vg42nS/4rltdTc/DsHVvN
 Jg4xK
X-Gm-Gg: AfdE7ckDshjWJuweUpccdCzn4epNVA0DXxJV/djmGIZinj+OJw31wOFdljz3pxI8FTB
 LWSrq3YQGteerIkSFLZVr5Mx2YauydXIYUuPYLWIRxBSR90myD/t/N9tCmQbOSlu1Q/nlJS2kcQ
 1T8bW/L5+dGzjS9JSMgkuH3a9XGmFaxAbp8AytI0s81JEe8WbHV8Pavg2mGcGzr6HwRfJCQ8Q8h
 GpNUZUpn/u00Dw5c6AQoMSK8aEIRVn2j36Ly9aemdKLil+8Ar1FHNPcBb963LV/OtDX5eCVA+rv
 6+0/DLpbkq/iNJXB+//s1lzuo6DpMgq6wMCqX+JLBnOH/bD636+W+WvdaONKZUam3WSQ3GSnTL7
 HWb/HZFBda1WkqNB6F1HGslfsSTMb47hhTa+jV453ufT7JxwRottmWH/sejr/qAXh4CyoGNPFJq
 3ZGowJCRDbxvnsZ01rp4i/q9GfUuqm0rq+9AKvJA==
X-Received: by 2002:a05:6402:1cc2:b0:699:f995:148 with SMTP id
 4fb4d7f45d1cf-69c5edb6a7emr6814352a12.0.1784209415055; 
 Thu, 16 Jul 2026 06:43:35 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd289ee36sm4664092a12.11.2026.07.16.06.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:34 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Anshul Dalal <anshuld@ti.com>
Subject: [PATCH v5 17/75] usb: dwc3: import from kernel v4.14
Date: Thu, 16 Jul 2026 15:41:47 +0200
Message-ID: <20260716134305.614278-18-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

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
e7059ef82a22 usb: dwc3: of-simple: remove include of clk-provider.h
95aa932c93d2 usb/dwc3:constify dev_pm_ops
c14af973ed86 usb: dwc3: keystone: Add PM_RUNTIME Support to DWC3 Keystone USB driver
0ae99ecba792 usb: dwc3: omap: fix error return code in dwc3_omap_probe()
8bcd9889721f usb: dwc3: pci: constify dev_pm_ops

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Fixes: b1a3ed068869 ("spl: make args file optional in falcon mode")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
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
2.53.0


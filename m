Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D750C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C494A409A0;
	Fri, 21 Aug 2026 13:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gVgRXU1Usi9; Fri, 21 Aug 2026 13:13:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317980;
	bh=UlkWQftXY6IwUwV1EpLQA9HEc+KChSw5T4F38oOR/aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZCCAeR2uPRGVRUvF3wSAMX0YFHfh9jzkko93nDz5bPbplW7xGKFIafJjGRqpcjXOQ
	 rtRTU2uhvtCE9joJMygbRVDljsXrPFWMSvXnwDz4aqbiPay0KbN1CMzIjoHb9hapvM
	 fBWz6kLNBH3nON7X8PtbI0ovlxnnTT2jocg6zojF1wZfiaFxryWtS3GvE4e+/OyCZX
	 FwMlQjLEpwKOPNgJIYe70ORChZvXVKCKhULYLuBSG0Ya5oMe5/zRrkGp2nDMt9sT+g
	 MqSUYC2bpWFvMomJwJ7povFm+2BCvbWZLil9QYq2T3vhWr/B73VELgfMQOuXJ9evxv
	 +viZDuydYMLnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64EB440C23;
	Fri, 21 Aug 2026 13:13:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 302C34B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 167BD408BC
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwVioc74t5_h for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=V+Dtf0dx
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50B5F40927
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA72784A1A; Fri, 21 Aug 2026 10:51:31 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF27F8404D
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 10:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="V+Dtf0dx"; 
 dkim-atps=neutral
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so6370266b.2
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 01:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302289; x=1787907089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UlkWQftXY6IwUwV1EpLQA9HEc+KChSw5T4F38oOR/aM=;
 b=V+Dtf0dxxl1it+PkBB6gsoq7YSFmUMlDQT5oMj2s4f8VLlX+j5JthlMlWlCDfPkaqQ
 /tDN2lUnf7+zU/gXw6qiWRy54gt9Lqn6+peYk29GbQKu5D6PNvgTQdxwpXF8JCp8UM/V
 WtbePgpp60nYiIcFAFZHLEO9D/5i5eXccbspguk00xey0IvPFX+JaeY1ZTxCm38HykRf
 gsgpZl2swguVXcerkijRR9ASJOjikH/e/PHqvKE9kiqjqE7Bp4H/7TuY+bStwg/EuHZw
 zznMMc8vxurr2v+XscUXRk0jbUOmuLQTiy04YvIiouo8vI/d2iuQSmVGGH2g9QKuxv2j
 hBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302289; x=1787907089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UlkWQftXY6IwUwV1EpLQA9HEc+KChSw5T4F38oOR/aM=;
 b=LWNS2UHV//gw7fOJ4yOpYozGyKVI3kAMlXiNzRRpOrGXvdfpVWrlxWpBbu8l2huNsf
 Jrya0sQ5q2r34rG0VPeGHYcaHZa2YxWGI5rXtaY1UgP7PGtWQoFqqjlmMXfnrtplpmE7
 LyuYZVvjTODC4ALvK0nCn4B66vk9a1HGjHASvRauupGG8tyGVwM9HhJyuHw9tRaCSJ1O
 PVGgH99jIWvlAd4Y6LAKS1Uu6l7YAe8tSuIgQPhvFEa+Kcdy7y3A4aTqrN1O8reGSNMn
 QsWvhAY/+MJ1vzuILZoBn7Z3Vg1Abf++uXPmYneiJTG4K/wgoyOOf8bob0keTIaIdndl
 e+ow==
X-Gm-Message-State: AFuF++mSkvDmJopCbG6dSxoZH+p3vOrie+P73aXEXQtTeWg6anqNQe/6
 KhtRKcLDbi/k5h1eF49Gl8X/DfI0xMmZeDlWGZrp+Ix7bTdT1SCaOXznuIW2VWTqC8tUy+usqjH
 OODoR
X-Gm-Gg: AR+sD132IOfEiMzptFm8+oJwFi57yXyOMYMSuovnhBTEenp+YwZpGwM1CQzqFnFJ0+6
 w2XotHbxs9sB5REhj+e8cjaIGwp3xomQqf26C4maKYHbMIl9esORPTAkxx9Q8gH/j7SeY3YS75h
 CfyIvwUtgho00v7CPCydZOB1d2FXnzMmL1f13pok08xQv65aAL91F3gbVX5O2Tnqc7f1RzO5ETO
 +k6gWxzCZQ7RVu0B56gShc0cb5ixEQajFt8ZUDXTMqmogK8VRtYQqHzraBMra2qFPK+dR6guemk
 u+C1Nq75umR1OiNujcHQ6i5ShpGmSPrFH9GGK7JZ1YncVLZSv2SvonOf5RMfhAApbINCLiI3M+s
 LOap9nE++OD8EHbXisIXQ2TE0VbId9vI7tooKXY05M5x2yO04i4RuhGAhAhPtmHokTyoXEC6H15
 CnIF/h/HKIIGylHxzLVlo0ojfkwQC4NJTCkKFuDWIIbsC9P5TdwEiyT9ofCc9MKbAFiLl9BnJ1H
 1S60dTSqBr1U85xhQrHUi0K
X-Received: by 2002:a17:907:d17:b0:c1c:4ae9:b935 with SMTP id
 a640c23a62f3a-c246a6902c5mr224297766b.3.1787302289074; 
 Fri, 21 Aug 2026 01:51:29 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e2258sm384167366b.3.2026.08.21.01.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:51:28 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 27/87] usb: dwc3: import from kernel v5.2
Date: Fri, 21 Aug 2026 10:47:03 +0200
Message-ID: <20260821084829.2070426-28-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.1 to v5.2.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v5.1..v5.2
Commits imported:
2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA
8d791929b2fb usb: dwc3: Fix default lpm_nyet_threshold value
dd24f9b604d3 usb: dwc3: debug: Print GET_STATUS(device) tracepoint
b873e2d0ea1e usb: dwc3: Do core validation early on probe
c729969b2b69 usb: dwc3: gadget: Set lpm_capable
41a91c606e7d usb: dwc3: move synchronize_irq() out of the spinlock protected block
75ecb9dd56a7 usb: dwc3: Free resource immediately after use

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   | 18 +++++++++++-------
 drivers/usb/dwc3/core.h   |  3 +--
 drivers/usb/dwc3/debug.h  |  3 +++
 drivers/usb/dwc3/gadget.c |  5 ++---
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f90261..4aff1d8dbc4f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -828,6 +828,7 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	ret = device_property_read_u32_array(dev,
 			"snps,incr-burst-type-adjustment", vals, ntype);
 	if (ret) {
+		kfree(vals);
 		dev_err(dev, "Error to get property\n");
 		return;
 	}
@@ -846,6 +847,8 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 		incrx_mode = INCRX_BURST_MODE;
 	}
 
+	kfree(vals);
+
 	/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
 	cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
 	if (incrx_mode)
@@ -893,12 +896,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	u32			reg;
 	int			ret;
 
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err0;
-	}
-
 	/*
 	 * Write Linux Version Code to our GUID register so it's easy to figure
 	 * out which kernel version a bug was found.
@@ -1218,7 +1215,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	u8			tx_max_burst_prd;
 
 	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xff;
+	lpm_nyet_threshold = 0xf;
 
 	/* default to -3.5dB de-emphasis */
 	tx_de_emphasis = 1;
@@ -1426,6 +1423,11 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(&dwc_res);
 
+	if (!dwc3_core_is_valid(dwc)) {
+		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
+		return -ENODEV;
+	}
+
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
@@ -1600,6 +1602,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
+		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -1632,6 +1635,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 			spin_lock_irqsave(&dwc->lock, flags);
 			dwc3_gadget_suspend(dwc);
 			spin_unlock_irqrestore(&dwc->lock, flags);
+			synchronize_irq(dwc->irq_gadget);
 		}
 
 		dwc3_otg_exit(dwc);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1528d395b156..f19cbeb01087 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -406,8 +406,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
-#define DWC3_DCTL_LPM_ERRATA_MASK	DWC3_DCTL_LPM_ERRATA(0xf)
-#define DWC3_DCTL_LPM_ERRATA(n)		((n) << 20)
+#define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
 #define DWC3_DCTL_L1_HIBER_EN		BIT(18)
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 6759a7efd8d5..068259fdfb0c 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -250,6 +250,9 @@ static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
 		size_t size)
 {
 	switch (t & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		snprintf(str, size, "Get Device Status(Length = %d)", l);
+		break;
 	case USB_RECIP_INTERFACE:
 		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
 				i, l);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e293400cc6e9..d67655384eb2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2863,7 +2863,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
-			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
+			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
 
 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 	} else {
@@ -3301,6 +3301,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
 	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
+	dwc->gadget.lpm_capable		= true;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -3384,8 +3385,6 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
-	synchronize_irq(dwc->irq_gadget);
-
 	return 0;
 }
 
-- 
2.53.0


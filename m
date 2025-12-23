Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67488E748FC
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 23:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A813284189;
	Wed, 24 Dec 2025 00:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MPs+cd4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1913584198; Wed, 24 Dec 2025 00:15:49 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B56EF84189
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 00:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7cc50eb0882so1904939a34.3
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766531744; x=1767136544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+1TvHEJRz0u7m0CMsQ5UiLOP8jc42McyeCxn/PkMBA=;
 b=MPs+cd4zXNA5/y7ZOdziP97sn06YEeAwMPpmIztlVFl3zLJVS6vuDor7VIuw032Zr6
 NZzdoEfJy8JfEu9WojhxGvIzWhCX1BmWK28V2skovgvv/RvEHhFnSRE6dGQDDBHQOWEO
 V5Yb0Nhus4RDQpNQsPd5IeIPmW6WSB2OXWAfnvKvwHsE9waJb/aoLTvErq0FkOhf130Y
 ZqExOMlDsL9jIUfvSxDgCE8Fznt+qaUUEScAX1xvVtYtmyMEYq2fbqCEAfi2M31AdA07
 sBwnf4bbimDwxqZ2c1j9ixhLsGMR0tlkCKSVFFurUap4ZUGzfu06vBEs28WOLSHj+nR+
 b3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766531744; x=1767136544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J+1TvHEJRz0u7m0CMsQ5UiLOP8jc42McyeCxn/PkMBA=;
 b=BJvtKt7XB6pVXys6gSCufzhZuDJbUG/MQdxDLOB0f3Wb5SHDBGFKesxa5iRmGjbbsi
 kYEF5krPWSxrnlTPh3Z2WhJx7N3bJRDCXNtwfODH3+ePM7uKU/QLK4NmyYra8ZK0ahaG
 shS8knrH/1ab4b/8SnCCqft+Srqe8oUBm8zuelMzzyA2bNbEmNk4DHn2f7yPRAVg5g2e
 qyXxU3ccaXRNfPL/US2/9MiUO2ykoPBreR5P8S2VCuP+nQ/VgAPGDCuojYlGLYc4ep0v
 iN+C5PFKA0zjOoKwfdnaAruLTBJc6cO5+Rx1KoYLixwyfQBqB7ze+rqs8zbhJz2AM+E0
 iGdg==
X-Gm-Message-State: AOJu0YwgQns+X61Lp9H5CVdJ1z4EAIhRzrbigVc+EZitbCPOXj7cIaFL
 ZN6FxRybFdjmkzBkkVrMHzeqEIg1x0ov7Qr1ajcUbeYUKXnZnO8+UjLXa1WJGzv7
X-Gm-Gg: AY/fxX7e7KAXBbrUm/RIG70IwEsTMy1qAWaxMSRfwAidcDxWyy2tD7rwa0mcbBI+6zl
 yXkSkg+zMBFFemF/JjWNtdPMqXtHnBOduHCF8hyaK/VqeFNlxXSpApZ4GrAQxSLPnM7rbzEz8Mx
 yist6uf3sA6064VuaYC46fbr5Y2Lu/OLTL353GKWh75EMnuslLepOTQra8sUp6gITuVeMvmYLeI
 t5IiVLeTpu6WYv6KQKAGFBW+s/yAWshSLjx3quIwWcsUK8lbuaNESfT0+in4BTYLZuw4XEBecu9
 C7X/86wml/EpIethTUcb4KaREySx6YjZ7bYGZmCIkR91Zl8VWHxhGpiIvsFPRr2SMlgd6M4h5Oy
 U47LWR6YeD4joeAT/WfHaumPH8vLlkDdVD/DWtEKylIn32vzozMmq2Bnm1fQXQTiNpFzruyoVCH
 FJR02wT+QvSZ7SwNyOX7M=
X-Google-Smtp-Source: AGHT+IG3wdt8GNa8hMUtJYFlc2LJegxN0E7K1KR0xiYfCNkD+6hfMx70oF6C/W/r7/MSbofpSArK9w==
X-Received: by 2002:a9d:604f:0:b0:7ca:c723:6f42 with SMTP id
 46e09a7af769-7cc668e0966mr7116335a34.10.1766531744134; 
 Tue, 23 Dec 2025 15:15:44 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667d4f62sm10352037a34.19.2025.12.23.15.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 15:15:43 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/2] usb: dwc3: gadget: Don't send unintended link state change
Date: Tue, 23 Dec 2025 17:13:10 -0600
Message-ID: <20251223231311.1983423-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223231311.1983423-1-macroalpha82@gmail.com>
References: <20251223231311.1983423-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

DCTL.ULSTCHNGREQ is a write-only field. When doing a read-modify-write
to DCTL, the driver must make sure that there's no unintended link state
change request from whatever is read from DCTL.ULSTCHNGREQ. Set link
state change to no-action when the driver writes to DCTL.

Note that this patch was submitted upstream in Linux in 2020 [1],
and I've confirmed I need it in U-Boot to enable gadget mode.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/patch/drivers/usb/dwc3?id=5b738211fb59e114727381d07c647a77c0010996

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/usb/dwc3/gadget.c | 20 +++++++++-----------
 drivers/usb/dwc3/gadget.h | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2b01113d54c..24ae0c232f6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -62,7 +62,7 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 		return -EINVAL;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	return 0;
 }
@@ -1396,7 +1396,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
@@ -1422,9 +1422,10 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		dwc->pullups_connected = false;
 	}
 
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
+		udelay(2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		if (is_on) {
 			if (!(reg & DWC3_DSTS_DEVCTRLHLT))
@@ -1436,7 +1437,6 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 		timeout--;
 		if (!timeout)
 			return -ETIMEDOUT;
-		udelay(1);
 	} while (1);
 
 	dev_vdbg(dwc->dev, "gadget %s data soft-%s\n",
@@ -2137,10 +2137,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_INITU1ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
-
 	reg &= ~DWC3_DCTL_INITU2ENA;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	dwc3_disconnect_gadget(dwc);
 	dwc->start_config_issued = false;
@@ -2189,7 +2187,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_gadget_dctl_write_safe(dwc, reg);
 	dwc->test_mode = false;
 
 	dwc3_stop_active_transfers(dwc);
@@ -2305,11 +2303,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		if (dwc->has_lpm_erratum && dwc->revision >= DWC3_REVISION_240A)
 			reg |= DWC3_DCTL_LPM_ERRATA(dwc->lpm_nyet_threshold);
 
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~DWC3_DCTL_HIRD_THRES_MASK;
-		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+		dwc3_gadget_dctl_write_safe(dwc, reg);
 	}
 
 	dep = dwc->eps[0];
@@ -2417,7 +2415,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 				reg &= ~u1u2;
 
-				dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+				dwc3_gadget_dctl_write_safe(dwc, reg);
 				break;
 			default:
 				/* do nothing */
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index f28a9755dcb..e4f5a096956 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -104,4 +104,18 @@ static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3 *dwc, u8 number)
 	return DWC3_DEPCMD_GET_RSC_IDX(res_id);
 }
 
+/**
+ * dwc3_gadget_dctl_write_safe - write to DCTL safe from link state change
+ * @dwc: pointer to our context structure
+ * @value: value to write to DCTL
+ *
+ * Use this function when doing read-modify-write to DCTL. It will not
+ * send link state change request.
+ */
+static inline void dwc3_gadget_dctl_write_safe(struct dwc3 *dwc, u32 value)
+{
+	value &= ~DWC3_DCTL_ULSTCHNGREQ_MASK;
+	dwc3_writel(dwc->regs, DWC3_DCTL, value);
+}
+
 #endif /* __DRIVERS_USB_DWC3_GADGET_H */
-- 
2.43.0


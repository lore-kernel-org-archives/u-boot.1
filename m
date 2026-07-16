Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD9EC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BDA84E1E;
	Thu, 16 Jul 2026 18:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rt+lIvdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861D484CEE; Thu, 16 Jul 2026 15:44:04 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8521A84CE8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c15de30790bso60031066b.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209442; x=1784814242; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=77fv1ZrRXf/oO8LduAkpFWiMCed8YbrJ68w25EJEAxo=;
 b=rt+lIvdJMaYelQMULWKakGbh0CUHPy5whoQbneCaxpxsbRUElAqTMuJuSFP8Aq8hYm
 P8omQiDQ14e/uCezgZh5d6Bla2egPmxX+a0Bw4EdAhrbRI4NNpgMEKlz+8LyU/87rv7S
 z313HhH/q1C4lxSoF2cOaqxjdwttfy3q2b5zpZ5Jow9iLxl6VknTAIEL1IPvYajPoMxU
 TjFfabyLELGxggZDLURa/wPxvyIi0hFXxO8jxL6QoOMHp044ybWCna6oENnvK7hY58Su
 7ok/RPz+zVeJLoX9yzAEs+Vlk5VP32gyeabOsVJghmKqQRbwyM/A75x6mYzo2PJaDA/l
 dAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209442; x=1784814242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=77fv1ZrRXf/oO8LduAkpFWiMCed8YbrJ68w25EJEAxo=;
 b=bJ7C8qCV93uQAfxNGvsgi2gMVK39aiRF1h2DKWAOK4UwsrAFdjTzfMb9fkUvvJzOsD
 m0y+mIFQZ2wQQWRsN+yiACyGEvDYsR4I3DmMplP0fE1Usg3hzYmnQRlv8ujm0Muj3p3E
 798OA+lkqRXjgGXhVTlJB+0ao/fnXxeFceWl+g9Zzklo550AaE3BIV3zY99V2vt6RF7f
 oiKFyd6ywAIEDUYrzLluBt7/pVf1fjE0/KplgLZVTaz+CHxLKL9K8aAOKSene8ZMcrBp
 G1tQKROOQV9VvX8DxVmpirnOq8eoI/1YqZjJCGd326WqB5bEly+JKrX9wX5H0yF0H+yH
 4FZg==
X-Gm-Message-State: AOJu0YxK/hjyshfEfISbNKydKOzq0qalpovCG1R+jMttrHs8X7NUane8
 4vXpHlckX8FE3GiPdmP0yMjEzH4DfqmsPSDO+mT/9CXKhb13KBKpkbBfqHdNP/G1JBYJXDcxhBd
 tAaPW
X-Gm-Gg: AfdE7cko0gw08owOBveS4pTGPflOcc7Dl0Z2WQEQevw84bHaRob3N1Zu8ipPUBNibKa
 f+0VFQ9aw+kOuzuryR8fV23Apyv+0CFj6BAk4E68nkEciMGpUm/iuL22FW5R9A1C7xz7GH7TlO9
 em5LhEYd8yZBPRMikOUa58DS8uLBixvx/hwDDpEEB/J16Xs0mmDl2tjrl0PKaOcbyzTA+ezUl3J
 5OJuEDYiFQWv30hEA2K677qywknzm9xnN16eWQx+KRohVWNg0/fN1AnHJd+eoAjlE43SWCBoyCm
 a7BZoksPkwhp19KVttMRsLf/Mm8QefabI7PTMG42vhltHyCy1LoMa/luDDRXKI3i54t7xb/3aHo
 k2TPt9/L/J+Y2NkKsxrTz0HzwuTpvUijsG2Z6i3bHTp0nnZ40xfKLZaUK71iI4YNg9YcpkTHqbh
 Q+GDAEb6sLlNjod7b9RLIEs13fL3kLOTJQf+s/KQ==
X-Received: by 2002:a17:907:9813:b0:c15:bad3:6754 with SMTP id
 a640c23a62f3a-c161f409f94mr665539666b.5.1784209441996; 
 Thu, 16 Jul 2026 06:44:01 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e024sm214142266b.52.2026.07.16.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 35/75] usb: dwc3: import from kernel v5.11
Date: Thu, 16 Jul 2026 15:42:05 +0200
Message-ID: <20260716134305.614278-36-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.10 to v5.11.

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

List of commits: git log --oneline v5.10..v5.11
Commits imported:
0e5a3c8284a3 usb: dwc3: fix clock issue during resume in OTG mode
a5c7682aaaa1 usb: dwc3: gadget: Clear wait flag on dequeue
a1383b3537a7 usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup
e5f4ca3fce90 usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression
fca3f1381057 usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
ce722da66d3e usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
a5ada3dfe6a2 usb: dwc3: meson-g12a: disable clk on error handling path in probe

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   |  2 +-
 drivers/usb/dwc3/core.h   |  1 +
 drivers/usb/dwc3/gadget.c | 16 +++++-----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 841daec70b6e..3101f0dcf6ae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1758,7 +1758,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (PMSG_IS_AUTO(msg))
 			break;
 
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2f95f08ca511..1b241f937d8f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -285,6 +285,7 @@
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_DONE		BIT(24)
 #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
 #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 78cb4db8a6e4..ee44321fee38 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1763,6 +1763,8 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			list_for_each_entry_safe(r, t, &dep->started_list, list)
 				dwc3_gadget_move_cancelled_request(r);
 
+			dep->flags &= ~DWC3_EP_WAIT_TRANSFER_COMPLETE;
+
 			goto out;
 		}
 	}
@@ -2083,6 +2085,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 
 static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
 static void __dwc3_gadget_stop(struct dwc3 *dwc);
+static int __dwc3_gadget_start(struct dwc3 *dwc);
 
 static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 {
@@ -2145,6 +2148,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 			dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
 						dwc->ev_buf->length;
 		}
+	} else {
+		__dwc3_gadget_start(dwc);
 	}
 
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
@@ -2319,10 +2324,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 
 	dwc->gadget_driver	= driver;
-
-	if (pm_runtime_active(dwc->dev))
-		__dwc3_gadget_start(dwc);
-
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
@@ -2348,13 +2349,6 @@ static int dwc3_gadget_stop(struct usb_gadget *g)
 	unsigned long		flags;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-
-	if (pm_runtime_suspended(dwc->dev))
-		goto out;
-
-	__dwc3_gadget_stop(dwc);
-
-out:
 	dwc->gadget_driver	= NULL;
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
-- 
2.53.0


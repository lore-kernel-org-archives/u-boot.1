Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDCBC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2FA484E3A;
	Thu, 16 Jul 2026 18:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f859c1i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393AB84CC4; Thu, 16 Jul 2026 15:44:19 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A285B84CC4
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c16879184e7so15212066b.3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209456; x=1784814256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=db43g5sKbZwOxrg5REwK0w2IXwFNs7dmzOwhk+3IJD0=;
 b=f859c1i6NWt3KsyMCAJgGAySU0hm2/9osHcXMNpBa9AfuvDOiopA0hmRpUB/wWe+YP
 nuKqfTUcZCQKA9SaKc1l15wrPIjxHQywfE/tR8SH7X3sIF5CbrZA1uWBNYaHhaOWRlJk
 7eRdxj6Njro4s1+LcaOKJs+tSUqXPTGtQJJlZFyON2fkI6l5fNh2Wl+3zN6t2vOrrqOq
 5vZElugtg5RoNjdlDyUy4z+mL6nhUsiaKNsTeG4zlF2OEQDLOIt5BZbGod1YepaE1QMx
 9i6yiUyCwmDmIyiwPGxY/OUwBYpPD0A/xAsxIqPXtP8NKz9JZzqQFEA4i4inBPI7/z6Z
 QW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209456; x=1784814256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=db43g5sKbZwOxrg5REwK0w2IXwFNs7dmzOwhk+3IJD0=;
 b=XWLsA9GFAieZbKOCTGh6zUKDHwkqqoKUWtc8pepaGpmZyhfptEIHJLu0/NqCVS0p9S
 f2S1n7LQWGHffkpbHWZlpNrAYbd/oPJ9ytGptuAugkG59YXYd6vcVQyJDofC5M02GIfj
 soLdlskhapDHTMwIuQgCshAkaRR87daPSc0tCy20jrACSMO+6xTn2ekH23WB9PsllrRs
 3MTTUfOOz0uvS84+fDBSgQAcIlPZlQtJn0Yw08cLuJu/4fFDV5v2JkGK1gJbeAfhT/k5
 kNdgehl0BJUUGYkQHuX7ZNa5P7LggOgBI7H67Cxa8vEFuhD7gEbHmrhxjnG8FVFCQVoj
 ktsQ==
X-Gm-Message-State: AOJu0YzkLLB1ZR4tm8eVm2e5XMFW3jCXo6zm8drSqpCLwp4WLsLTnCs3
 TrkeMsPr2+w0sFU20OdJMdx3UcuVKq6NcHJ+HjKLNcJOQ94fINBQL4QFpG8iYh+bxzyjJ+MBGNd
 0MdZ1
X-Gm-Gg: AfdE7cn7XJgYhkTZhnGK4/ynrtyhtamWGnVgNwOPPMHRwgr0D0tIe6ymLqp9IdZUPCp
 fSsLcMmUVgiv1H7s5VB+F0sUOO5IRU1EH72TG9cN7ogJXDJLTSB52csAl86h0hwh62t8XtFw0HK
 M9uEYcXpeveWwlNJewN2vVcIsUUHuq3joxTmXqHMVfLtmMOKR1EDQwqPsdPYV1RwSTZbpAwJ7VT
 AH/btkhQHE1jt1/JpVoMQzE1ol64ZSAdFDwRJ4VJDC9/XBO48zOtRoFpaUaQ7xygsyCZC3D+4HV
 cJr9Q1N5S5Gp0l47imXekX6a04ocMl9Mm6clJTlKOtrtv1RCVA1kJq8hqgqvJtvKCiIXt3ByCV4
 ivXelc+ql5PxkfNov8jkzK5/KGs5iWut7ViwD3Eac60lalHfN6xKh19tgLp2wFH541KYnSQthHi
 hwCs0ubqDXli8ocgLPqw6JenATSJLOUQqRGPUW0fhuejCkX3ka
X-Received: by 2002:a17:907:5cc:b0:c12:c7ca:d704 with SMTP id
 a640c23a62f3a-c161f438d78mr694497066b.6.1784209455754; 
 Thu, 16 Jul 2026 06:44:15 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871711a2sm217655266b.21.2026.07.16.06.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:15 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 45/75] usb: dwc3: import from kernel v6.1
Date: Thu, 16 Jul 2026 15:42:15 +0200
Message-ID: <20260716134305.614278-46-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.0 to v6.1.

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

List of commits: git log --oneline v6.0..v6.1
Commits imported:
f90f5afd5083 usb: dwc3: gadget: Clear ep descriptor last
e0481e5b3cc1 usb: dwc3: exynos: Fix remove() function
3aa07f72894d usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for End Transfer
d68cc25b7c7f usb: dwc3: Do not get extcon device when usb-role-switch is used
5c294de36e7f Revert "usb: dwc3: disable USB core PHY management"
ffb9da4a04c6 usb: dwc3: gadget: Return -ESHUTDOWN on ep disable
308c316d16cb usb: dwc3: gadget: Don't set IMI for no_interrupt
f78961f8380b usb: dwc3: gadget: Stop processing more requests on IMI
3f53c329b31d usb: dwc3: st: Rely on child's compatible instead of name
4db0fbb60136 usb: dwc3: gadget: Don't delay End Transfer on delayed_status
d182c2e1bc92 usb: dwc3: Don't switch OTG -> peripheral if extcon is present
7a84e7353e23 Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"
2adc960ce79d Revert "USB: fixup for merge issue with "usb: dwc3: Don't switch OTG -> peripheral if extcon is present""
2a735e4b5580 usb: dwc3: core: fix some leaks in probe
63d7f9810a38 usb: dwc3: core: Enable GUCTL1 bit 10 for fixing termination error after resume bug
a6fc2f1b0927 usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
93440d1fdf0a usb: dwc3: pci: Add PCIe device ID for USB3 controller on CPU sub-system for Alder Lake P
ff2d2bee4750 usb: dwc3: pci: Update the macro names for USB PCIe device ID's for Alder Lake platforms
d6edcdc1ef06 usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure
ec50e114385f usb: dwc3: xilinx: add power management ops support
875296ea8ff2 usb: dwc3: qcom: drop unneeded compatibles
76bff31c7fba usb: dwc3: gadget: Do not clear ep delayed stop flag during ep disable
af870d93c706 usb: dwc3: Fix typos in gadget.c
8422b769fa46 usb: dwc3: gadget: Submit endxfer command if delayed during disconnect
b353eb6dc285 usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer
461ee467507c usb: dwc3: Increase DWC3 controller halt timeout
5265397f9442 usb: dwc3: Remove DWC3 locking during gadget suspend/resume
2b2da6574e77 usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
dff981842a0b usb: dwc3: gadget: Continue handling EP0 xfercomplete events
9711c67de748 usb: dwc3: gadget: Synchronize IRQ between soft connect/disconnect
e1ee843488d5 usb: dwc3: gadget: Force sending delayed status during soft disconnect
359d5a85a758 usb: dwc3: Do not service EP0 and conndone events if soft disconnected
d75807ab9569 usb: dwc3: qcom: clean up icc init
b89bffa2efc9 usb: dwc3: qcom: only parse 'maximum-speed' once
808e8bff6fe4 usb: dwc3: trace: add Start of Frame Number to trace event
37a136aac3fe usb: dwc3: debug: show events parameters in hex
b44c0e7fef51 usb: dwc3: gadget: conditionally remove requests

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   | 100 +++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h   |   7 +++
 drivers/usb/dwc3/debug.h  |   4 +-
 drivers/usb/dwc3/ep0.c    |  11 +++--
 drivers/usb/dwc3/gadget.c | 100 ++++++++++++++++++++++++++++++--------
 5 files changed, 167 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d0237b30c9be..1f348bc867c2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -408,6 +408,10 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+
+	if (dwc->gfladj_refclk_lpm_sel)
+		reg |=  DWC3_GFLADJ_REFCLK_LPM_SEL;
+
 	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
@@ -789,7 +793,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	else
 		reg |= DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-	if (dwc->dis_u2_freeclk_exists_quirk)
+	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
@@ -1180,6 +1184,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * When configured in HOST mode, after issuing U3/L2 exit controller
+	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * behaviour Transaction Error is generated, resulting in reset and
+	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
+	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
+	 * will correct this problem. This option is to support certain
+	 * legacy ULPI PHYs.
+	 */
+	if (dwc->resume_hs_terminations) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
+		reg |= DWC3_GUCTL1_RESUME_OPMODE_HS_HOST;
+		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
+	}
+
 	if (!DWC3_VER_IS_PRIOR(DWC3, 250A)) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
 
@@ -1523,8 +1542,12 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->resume_hs_terminations = device_property_read_bool(dev,
+				"snps,resume-hs-terminations");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
+	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
+				"snps,gfladj-refclk-lpm-sel-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -1687,6 +1710,16 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
 		return extcon_get_extcon_dev(name);
 
+	/*
+	 * Check explicitly if "usb-role-switch" is used since
+	 * extcon_find_edev_by_node() can not be used to check the absence of
+	 * an extcon device. In the absence of an device it will always return
+	 * EPROBE_DEFER.
+	 */
+	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
+	    device_property_read_bool(dev, "usb-role-switch"))
+		return NULL;
+
 	/*
 	 * Try to get an extcon device from the USB PHY controller's "port"
 	 * node. Check if it has the "port" node first, to avoid printing the
@@ -1753,8 +1786,10 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_get_properties(dwc);
 
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-	if (IS_ERR(dwc->reset))
-		return PTR_ERR(dwc->reset);
+	if (IS_ERR(dwc->reset)) {
+		ret = PTR_ERR(dwc->reset);
+		goto put_usb_psy;
+	}
 
 	if (dev->of_node) {
 		/*
@@ -1764,45 +1799,57 @@ static int dwc3_probe(struct platform_device *pdev)
 		 * check for them to retain backwards compatibility.
 		 */
 		dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-		if (IS_ERR(dwc->bus_clk))
-			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					     "could not get bus clock\n");
+		if (IS_ERR(dwc->bus_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+					    "could not get bus clock\n");
+			goto put_usb_psy;
+		}
 
 		if (dwc->bus_clk == NULL) {
 			dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-			if (IS_ERR(dwc->bus_clk))
-				return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-						     "could not get bus clock\n");
+			if (IS_ERR(dwc->bus_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
+						    "could not get bus clock\n");
+				goto put_usb_psy;
+			}
 		}
 
 		dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-		if (IS_ERR(dwc->ref_clk))
-			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					     "could not get ref clock\n");
+		if (IS_ERR(dwc->ref_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+					    "could not get ref clock\n");
+			goto put_usb_psy;
+		}
 
 		if (dwc->ref_clk == NULL) {
 			dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-			if (IS_ERR(dwc->ref_clk))
-				return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-						     "could not get ref clock\n");
+			if (IS_ERR(dwc->ref_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
+						    "could not get ref clock\n");
+				goto put_usb_psy;
+			}
 		}
 
 		dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-		if (IS_ERR(dwc->susp_clk))
-			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					     "could not get suspend clock\n");
+		if (IS_ERR(dwc->susp_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+					    "could not get suspend clock\n");
+			goto put_usb_psy;
+		}
 
 		if (dwc->susp_clk == NULL) {
 			dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-			if (IS_ERR(dwc->susp_clk))
-				return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-						     "could not get suspend clock\n");
+			if (IS_ERR(dwc->susp_clk)) {
+				ret = dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
+						    "could not get suspend clock\n");
+				goto put_usb_psy;
+			}
 		}
 	}
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		return ret;
+		goto put_usb_psy;
 
 	ret = dwc3_clk_enable(dwc);
 	if (ret)
@@ -1846,8 +1893,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->edev = dwc3_get_extcon(dwc);
 	if (IS_ERR(dwc->edev)) {
-		ret = PTR_ERR(dwc->edev);
-		dev_err_probe(dwc->dev, ret, "failed to get extcon\n");
+		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
 		goto err3;
 	}
 
@@ -1909,7 +1955,7 @@ disable_clks:
 	dwc3_clk_disable(dwc);
 assert_reset:
 	reset_control_assert(dwc->reset);
-
+put_usb_psy:
 	if (dwc->usb_psy)
 		power_supply_put(dwc->usb_psy);
 
@@ -1977,9 +2023,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		if (pm_runtime_suspended(dwc->dev))
 			break;
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		synchronize_irq(dwc->irq_gadget);
 		dwc3_core_exit(dwc);
 		break;
@@ -2040,9 +2084,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			return ret;
 
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
 		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287dc934..8f9959ba9fd4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -263,6 +263,7 @@
 #define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
+#define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
 
 /* Global Status Register */
 #define DWC3_GSTS_OTG_IP	BIT(10)
@@ -391,6 +392,7 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 #define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_REFCLK_LPM_SEL		BIT(23)
 #define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
 #define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
@@ -1096,6 +1098,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
@@ -1311,7 +1315,9 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		resume_hs_terminations:1;
 	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
@@ -1560,6 +1566,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index d223c54115f4..48b44b88dc25 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -278,7 +278,7 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		scnprintf(str + len, size - len,
-				"Transfer In Progress [%d] (%c%c%c)",
+				"Transfer In Progress [%08x] (%c%c%c)",
 				event->parameters,
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
@@ -286,7 +286,7 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
 		len += scnprintf(str + len, size - len,
-				"Transfer Not Ready [%d]%s",
+				"Transfer Not Ready [%08x]%s",
 				event->parameters,
 				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
 				" (Active)" : " (Not Active)");
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 197af63f8d05..61de693461da 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc || !dwc->pullups_connected) {
+	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		ret = -ESHUTDOWN;
@@ -293,7 +293,10 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			continue;
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
-		dwc3_stop_active_transfer(dwc3_ep, true, true);
+		if (dwc->connected)
+			dwc3_stop_active_transfer(dwc3_ep, true, true);
+		else
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
 }
 
@@ -815,7 +818,7 @@ static void dwc3_ep0_inspect_setup(struct dwc3 *dwc,
 	int ret = -EINVAL;
 	u32 len;
 
-	if (!dwc->gadget_driver || !dwc->connected)
+	if (!dwc->gadget_driver || !dwc->softconnect || !dwc->connected)
 		goto out;
 
 	trace_dwc3_ctrl_req(ctrl);
@@ -1118,6 +1121,8 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 {
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
+		if (!dwc->softconnect || !dwc->connected)
+			return;
 		/*
 		 * We already have a DATA transfer in the controller's cache,
 		 * if we receive a XferNotReady(DATA) we will ignore it, unless
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index eca945feeec3..6d524fa76443 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -291,7 +291,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 	 *
 	 * DWC_usb3 3.30a and DWC_usb31 1.90a programming guide section 3.2.2
 	 */
-	if (dwc->gadget->speed <= USB_SPEED_HIGH) {
+	if (dwc->gadget->speed <= USB_SPEED_HIGH ||
+	    DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		if (unlikely(reg & DWC3_GUSB2PHYCFG_SUSPHY)) {
 			saved_config |= DWC3_GUSB2PHYCFG_SUSPHY;
@@ -366,7 +367,9 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 
 	dwc3_writel(dep->regs, DWC3_DEPCMD, cmd);
 
-	if (!(cmd & DWC3_DEPCMD_CMDACT)) {
+	if (!(cmd & DWC3_DEPCMD_CMDACT) ||
+		(DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+		!(cmd & DWC3_DEPCMD_CMDIOC))) {
 		ret = 0;
 		goto skip_status;
 	}
@@ -965,29 +968,33 @@ out:
 	return 0;
 }
 
-static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
 	dwc3_stop_active_transfer(dep, true, false);
 
+	/* If endxfer is delayed, avoid unmapping requests */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		return;
+
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
 		req = next_request(&dep->started_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 
 	while (!list_empty(&dep->pending_list)) {
 		req = next_request(&dep->pending_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 
 	while (!list_empty(&dep->cancelled_list)) {
 		req = next_request(&dep->cancelled_list);
 
-		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+		dwc3_gadget_giveback(dep, req, status);
 	}
 }
 
@@ -1005,6 +1012,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 {
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
+	u32			mask;
 
 	trace_dwc3_gadget_ep_disable(dep);
 
@@ -1016,18 +1024,26 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
+
+	dep->stream_capable = false;
+	dep->type = 0;
+	mask = DWC3_EP_TXFIFO_RESIZED;
+	/*
+	 * dwc3_remove_requests() can exit early if DWC3 EP delayed stop is
+	 * set.  Do not clear DEP flags, so that the end transfer command will
+	 * be reattempted during the next SETUP stage.
+	 */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+	dep->flags &= mask;
+
 	/* Clear out the ep descriptors for non-ep0 */
 	if (dep->number > 1) {
 		dep->endpoint.comp_desc = NULL;
 		dep->endpoint.desc = NULL;
 	}
 
-	dwc3_remove_requests(dwc, dep);
-
-	dep->stream_capable = false;
-	dep->type = 0;
-	dep->flags &= DWC3_EP_TXFIFO_RESIZED;
-
 	return 0;
 }
 
@@ -1277,8 +1293,8 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS;
 		}
 
-		/* always enable Interrupt on Missed ISOC */
-		trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
+		if (!no_interrupt && !chain)
+			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 		break;
 
 	case USB_ENDPOINT_XFER_BULK:
@@ -1683,6 +1699,16 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+	/*
+	 * If the End Transfer command was timed out while the device is
+	 * not in SETUP phase, it's possible that an incoming Setup packet
+	 * may prevent the command's completion. Let's retry when the
+	 * ep0state returns to EP0_SETUP_PHASE.
+	 */
+	if (ret == -ETIMEDOUT && dep->dwc->ep0state != EP0_SETUP_PHASE) {
+		dep->flags |= DWC3_EP_DELAY_STOP;
+		return 0;
+	}
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
@@ -2340,7 +2366,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
 		if (!dep)
 			continue;
 
-		dwc3_remove_requests(dwc, dep);
+		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
 	}
 }
 
@@ -2440,7 +2466,7 @@ static void __dwc3_gadget_set_speed(struct dwc3 *dwc)
 static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
-	u32			timeout = 500;
+	u32			timeout = 2000;
 
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
@@ -2473,6 +2499,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
 	do {
+		usleep_range(1000, 2000);
 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 		reg &= DWC3_DSTS_DEVCTRLHLT;
 	} while (--timeout && !(!is_on ^ !reg));
@@ -2501,6 +2528,9 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
 	if (dwc->ep0state != EP0_SETUP_PHASE) {
 		int ret;
 
+		if (dwc->delayed_status)
+			dwc3_ep0_send_delayed_status(dwc);
+
 		reinit_completion(&dwc->ep0_in_setup);
 
 		spin_unlock_irqrestore(&dwc->lock, flags);
@@ -2568,6 +2598,8 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 		return 0;
 	}
 
+	synchronize_irq(dwc->irq_gadget);
+
 	if (!is_on) {
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	} else {
@@ -2718,6 +2750,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
 	dep = dwc->eps[0];
+	dep->flags = 0;
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
@@ -2725,6 +2758,7 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 	}
 
 	dep = dwc->eps[1];
+	dep->flags = 0;
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	if (ret) {
 		dev_err(dwc->dev, "failed to enable %s\n", dep->name);
@@ -3215,6 +3249,10 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
+	if ((trb->ctrl & DWC3_TRB_CTRL_ISP_IMI) &&
+	    DWC3_TRB_SIZE_TRBSTS(trb->size) == DWC3_TRBSTS_MISSED_ISOC)
+		return 1;
+
 	if ((trb->ctrl & DWC3_TRB_CTRL_IOC) ||
 	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
@@ -3568,7 +3606,7 @@ static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		 * streams are updated, and the device controller will not be
 		 * triggered to generate ERDY to move the next stream data. To
 		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitate the stream until the host is ready
+		 * hosts, force to reinitiate the stream until the host is ready
 		 * instead of waiting for the host to prime the endpoint.
 		 */
 		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
@@ -3596,11 +3634,12 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	dep = dwc->eps[epnum];
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED))
+		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
 			return;
 
 		/* Handle only EPCMDCMPLT when EP disabled */
-		if (event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT)
+		if ((event->endpoint_event != DWC3_DEPEVT_EPCMDCMPLT) &&
+			!(epnum <= 1 && event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE))
 			return;
 	}
 
@@ -3763,13 +3802,24 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	reg &= ~DWC3_DCTL_INITU2ENA;
 	dwc3_gadget_dctl_write_safe(dwc, reg);
 
+	dwc->connected = false;
+
 	dwc3_disconnect_gadget(dwc);
 
 	dwc->gadget->speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
 	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
 
-	dwc->connected = false;
+	if (dwc->ep0state != EP0_SETUP_PHASE) {
+		unsigned int    dir;
+
+		dir = !!dwc->ep0_expect_in;
+		if (dwc->ep0state == EP0_DATA_PHASE)
+			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
+		else
+			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
+		dwc3_ep0_stall_and_restart(dwc);
+	}
 }
 
 static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
@@ -3867,6 +3917,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	u8			lanes = 1;
 	u8			speed;
 
+	if (!dwc->softconnect)
+		return;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	dwc->speed = speed;
@@ -4129,7 +4182,7 @@ static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
 	unsigned int is_ss = evtinfo & BIT(4);
 
 	/*
-	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
+	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
 	 * have a known issue which can cause USB CV TD.9.23 to fail
 	 * randomly.
 	 *
@@ -4507,12 +4560,17 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	unsigned long flags;
+
 	if (!dwc->gadget_driver)
 		return 0;
 
 	dwc3_gadget_run_stop(dwc, false, false);
+
+	spin_lock_irqsave(&dwc->lock, flags);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
 }
-- 
2.53.0


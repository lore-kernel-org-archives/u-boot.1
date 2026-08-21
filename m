Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D18C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5B2160E7B;
	Fri, 21 Aug 2026 13:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDuzqu0aIcCu; Fri, 21 Aug 2026 13:17:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318090;
	bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L6qnowjtMGzkQW+3kt4LbRDAAf4VpFCgtTr60HSeR1OVvhn80EdA4qZ1ooiqwHTxe
	 gG80XN9fsjkrGpbbn7Uewo/H1iMCiNvTYAQvwFCm3Dn2mtTDFuqSaUzpVj3pxoulri
	 Cg+GY6rnHgzbUl1kvsmA5B/+7vEw6rkNt9kGfFdNQB9tyKun9IpCydf8oXEXsBqYVJ
	 463Z3AxjdZne18jffutY9pv8T1suNlRcFxIvhJHuVz+09Gte5nHqKUakO86JA9EhYA
	 pmP6HoYpzWIbZCEbuk3HgvkM8mHat+LYzmcdTsZyLJxCscz+145ZHahW+u54AAhFBc
	 EdxtMGC7LKm9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 185BD60EBC;
	Fri, 21 Aug 2026 13:14:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D10D1B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 239F840841
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id foSQo-gFzbUC for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=X06cdNk+
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E34FA40825
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:11 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso166349a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302330; x=1787907130;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=X06cdNk+pWwZ6E3Iy9ZYMIJ1waubAbSWYx6Zgu9NoeG0Ibu/vhCElPcAnHfz0Tlr48
 Y3jRMiSBVZDpVvJRIJ7XZ5pDD39ojTdCKTKsx36UrL6PfrzhM89YdYlB6F+LLo2r90sI
 L6HqPVVxVn9WGWkzxbPpaCL5PUJuMzEZrynlxSjo/xE9nw/lHKxKN3Y4u1k3M8yZjtDY
 T0XW2wfYHANvDdEWyAPJk7s8n+sOT8dKEHr4p4yCDCJfFmaDJdV9goRpWRkCfTWIAa7Y
 b9mc4gpnUkBDuJjpQtvCPuPR3aFcMTdjEPj66TeIx1jezi1JX/BOfal6TpWiVDZ/reU3
 SMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302330; x=1787907130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=E4HFFPH2gxT1fGgfykIzx5TZRBJRQb/RzBEFmADevaW1hTGQJfaMUjP4F3Owf5VhkH
 J6WdLR+LRqeKMUmHiWpGlJJBGH8i4E2hVuKydG0yJ4I2yMDaSsqPQV4RLpIKLKtwV+8W
 f6rE974c6xMcF9HIBScbQj2v8LF8CQ3X0qJifazptPgQolc9fMthvsKmbIkVBA/7yz0n
 zFp6TViB5nX0FNOYuDhJqidc0rP0y1yAQd8YN22/d7nqzsvH8+WlJK5t2/3+y2w26yuh
 HrMeq6SGIGXiGVcdlUX2J105kSIhX0SfvQrES7Px5PP4qaL5TP7ewSGM27KAS9xZPYl+
 MuFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8s26ldfuaAdEtkGMr8oEC/3/g8sun+HxI/JzNUpe5LgNgn5Ff4DLgYSODesaNWl5U8UQuLo4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mcE8o1L2VXhtvw7hnFcSv41m847aCB2R1tA1jaHXNLH414AEYY
 ibXRMLukkouhRAPwlN7EBvxPi0ML/nRual30yzMkcMQfVNNAT+9s5MmXq7EvJzdwicA=
X-Gm-Gg: AR+sD10KPpfTnGvaUc0cJ9FFwiuGC82R9d96aYcdlN2tUBk+aKGonFFlLytGmQwK+E+
 rcpaYgVQwtApSz4nYm/9H2dhSPb0kZmXfLrYjklQ6Lrhi+NpSFZoFSymhBvCP8EYzuage6ULOOd
 8OYMKswliR8WK9pPGVFcKPqFeRA6KxO/FzzyjsxVgr2RmwJNuSiVsfe2LcXPePJ5XKphNmprprG
 O//h0/bHGVibWEf9UxiSRwlI7jejhHzTYwHqsYKUpfic64FxpCInFfA8MCB5FJPbI+du5zWzork
 5OVLwA1ZJW/RIR7xrfB+eFiRTJwSADW5crflaTnQy/IkgWbWk8f45SsT4G2lUw0AC144IH4yxGh
 A813SzWqPY7cSA882AT9zSM8080/q3MjU4W6Cw4hKFLoaUtZPA6hVsCS+b6nxleeP14PYH5W5v6
 Q3DVd/+pIh8ko6FUNj7zCAn5Xw/OmkDWSuulrxyU1IMqdQpHPsC7nhAkG2eyHkZz5K/w/0l+jax
 LKeO6wPnNrZ0X8ZbTLE1OPX
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c246a65fe29mr242863066b.4.1787302329830; 
 Fri, 21 Aug 2026 01:52:09 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1991sm409541266b.12.2026.08.21.01.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:09 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 56/87] usb: dwc3: import from kernel v6.11
Date: Fri, 21 Aug 2026 10:47:32 +0200
Message-ID: <20260821084829.2070426-57-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync Linux kernel dwc3 changes from v6.10 to v6.11.

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

List of commits: git log --oneline v6.10..v6.11
Commits imported:
9149c9b0c7e0 usb: dwc3: core: update LC timer as per USB Spec V3.2
00dcf2fa449f usb: dwc3: Avoid waking up gadget during startxfer
72fca8371f20 usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)
14e497183df2 usb: dwc3: core: Prevent USB core invalid event buffer address access
d504bfa6cfd1 usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
179264157bba usb: dwc3: core: Check all ports when set phy suspend

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 89 +++++++++++++++++++++++++++++++++------
 drivers/usb/dwc3/core.h   | 10 +++++
 drivers/usb/dwc3/ep0.c    |  3 +-
 drivers/usb/dwc3/gadget.c | 41 ++++++++----------
 4 files changed, 106 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..9eb085f359ce 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -108,22 +108,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
 	u32 reg;
+	int i;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	if (enable && !dwc->dis_u3_susphy_quirk)
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-	else
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+		if (enable && !dwc->dis_u3_susphy_quirk)
+			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+	}
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (enable && !dwc->dis_u2_susphy_quirk)
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-	else
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+		if (enable && !dwc->dis_u2_susphy_quirk)
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+	}
 }
 
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
@@ -559,9 +564,17 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return;
+	/*
+	 * Exynos platforms may not be able to access event buffer if the
+	 * controller failed to halt on dwc3_core_exit().
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
 
 	evt = dwc->ev_buf;
 
@@ -599,6 +612,18 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
+		u32 reg;
+
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg &= ~DWC3_GSBUSCFG0_REQINFO(~0);
+		reg |= DWC3_GSBUSCFG0_REQINFO(dwc->gsbuscfg0_reqinfo);
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1338,6 +1363,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
@@ -1359,6 +1386,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
 	 * fails to send proper CRC checksum in CRC5 feild. Because of this
@@ -1576,6 +1618,27 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 }
 
+static void dwc3_get_software_properties(struct dwc3 *dwc)
+{
+	struct device *tmpdev;
+	u16 gsbuscfg0_reqinfo;
+	int ret;
+
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+
+	/*
+	 * Iterate over all parent nodes for finding swnode properties
+	 * and non-DT (non-ABI) properties.
+	 */
+	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
+		ret = device_property_read_u16(tmpdev,
+					       "snps,gsbuscfg0-reqinfo",
+					       &gsbuscfg0_reqinfo);
+		if (!ret)
+			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
+	}
+}
+
 static void dwc3_get_properties(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
@@ -2090,6 +2153,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc3_get_software_properties(dwc);
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..c71240e8f7c7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -194,6 +194,10 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
+#define DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED	0xffffffff
+
 /* Global Debug LSP MUX Select */
 #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
 #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
@@ -417,6 +421,7 @@
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
@@ -1153,6 +1158,9 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
+ *		       DATWRREQINFO, and DESWRREQINFO value passed from
+ *		       glue driver.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1262,6 +1270,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
 #define DWC3_REVISION_330A	0x5533330a
 
 #define DWC31_REVISION_ANY	0x0
@@ -1380,6 +1389,7 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+	u32			gsbuscfg0_reqinfo;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index d96ffbe52039..c9533a99e47c 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
 	if (!list_empty(&dep->pending_list)) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..291bc549935b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -287,6 +287,23 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
  *
  * Caller should handle locking. This function will issue @cmd with given
  * @params to @dep and wait for its completion.
+ *
+ * According to the programming guide, if the link state is in L1/L2/U3,
+ * then sending the Start Transfer command may not complete. The
+ * programming guide suggested to bring the link state back to ON/U0 by
+ * performing remote wakeup prior to sending the command. However, don't
+ * initiate remote wakeup when the user/function does not send wakeup
+ * request via wakeup ops. Send the command when it's allowed.
+ *
+ * Notes:
+ * For L1 link state, issuing a command requires the clearing of
+ * GUSB2PHYCFG.SUSPENDUSB2, which turns on the signal required to complete
+ * the given command (usually within 50us). This should happen within the
+ * command timeout set by driver. No additional step is needed.
+ *
+ * For L2 or U3 link state, the gadget is in USB suspend. Care should be
+ * taken when sending Start Transfer command to ensure that it's done after
+ * USB resume.
  */
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
@@ -327,30 +344,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int link_state;
-
-		/*
-		 * Initiate remote wakeup if the link state is in U3 when
-		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
-		 * link state is in U1/U2, no remote wakeup is needed. The Start
-		 * Transfer command will initiate the link recovery.
-		 */
-		link_state = dwc3_gadget_get_link_state(dwc);
-		switch (link_state) {
-		case DWC3_LINK_STATE_U2:
-			if (dwc->gadget->speed >= USB_SPEED_SUPER)
-				break;
-
-			fallthrough;
-		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc, false);
-			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
-					ret);
-			break;
-		}
-	}
-
 	/*
 	 * For some commands such as Update Transfer command, DEPCMDPARn
 	 * registers are reserved. Since the driver often sends Update Transfer
-- 
2.53.0


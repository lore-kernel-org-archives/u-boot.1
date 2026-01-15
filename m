Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BAAD4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 23:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7125A830E4;
	Fri, 16 Jan 2026 00:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrDaOwBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 057CD836A3; Fri, 16 Jan 2026 00:04:10 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6A980077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 00:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40427db1300so874652fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768518246; x=1769123046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xWo/jbYR9Hc83jbzqPa2moAtBTOt7Otg5Xvo6KS78g=;
 b=nrDaOwBb2Q9MwZ+Gn7OqQUl3XEicEhTpIT36M6BU245ThKXtzc3097bLgGphrdwAWf
 MGusb2b3j8DLVlv+QdoUPuAqw0aUOie1JLlT26hF8r0NBzWBmVWlXpTj/iYgyV0K5n/d
 dEB6N6i0dOYuyHMp4wdmeQzkuPJUXEeNm5iEPP24ZklhhlyxRZK/J8DRui2xgHZ57Nqm
 rvo0g0tdSxQ5gAhwjbartR/LD10VuYPk44OocnbH+uetsc63nKIDJ9a2LAsDu0sCkOzs
 qspUFGynQTL3zRUNu+EiItvkefg4XRF1BnFDTTPCu78+6MC3JfGo3Hw8LfJGFAVnMoqX
 OIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768518246; x=1769123046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xWo/jbYR9Hc83jbzqPa2moAtBTOt7Otg5Xvo6KS78g=;
 b=ebhTV/8FCH9xJEEaSf+fPlQUjk+s5RgkBjoScRV3197IwWw93/7E1gnmRpUP4qLd2i
 hgzZAO96h0r6Oi9KAy+M0c1PUnfSRmN8LhJBIBk2peze95OqaKIz6FExO21XgRfukNZ7
 FzSQhl42bWK5Py3YquE240CO/io9IvpF1A9m++VKwyvVA5HfvtJxfTUCIruGf0c/JxAp
 3uk4Zi/xZtFgN45ZwRTBhASMDxEa0HkWe73zSql6mgbJ5Sh3UV+95J7m3ewNqCxgUwcF
 x+IHHe6PRwxK5JKefWElBJ43arcM9OS7Pw9vDGXXXuC2gfKA3+YRq/YL+afWfu/N/SRS
 xrgw==
X-Gm-Message-State: AOJu0Ywn14cCIX1auOWfXDZi5t2Ng7Xhc9KuIEc7eddPsEzy+pvg2TdM
 Vbx4Xk83CiJFRp+jxWnVQ5d2MHVPkO9k0y80PGexdNJf5OnUdTxwogkFQkg8bA==
X-Gm-Gg: AY/fxX7KfO3FQWg7og5Z2ZZO5WsYcy1rJNJ8vR3rY0bMdVFIKY7yzYBzQskYoEmHOZw
 yUqOIQYhlB10k76Mgltwnkg8akNqHGGnDY5F630dN1imU+oE/qz3M6C+S9hd1uitP4yhIB6wrUP
 VvwV4skYw92GfsWbELD9e+3zDUdRX/vXcS6hTPI3HnExqYujWrw5toeJIULsVzo26E50TWaxbyX
 0n847DIv85EP/Mz9g/YyOBzMmwIW7yF3NPZJ/cJKOWjh9/B3UFW7/XcFx2ZMA1yuyNI4O/uqeqA
 GCpf1sw9hVjFBxdNQjWYf/XjJqcZlr4f/IFuAUM+BMCZ1QqXGzq1cZtiU5MYDrRIMe9kXLIwKhm
 DfRgh0L6u/rICcSgpy7cA5rG9NYGyjzKTsRtpOtEg/zhwzLT+Y8+CqaD6Pa5e0XO5SN8dx6Tq8o
 i+nE75WOoL
X-Received: by 2002:a05:6820:450b:b0:659:9a49:9026 with SMTP id
 006d021491bc7-66117a16466mr418305eaf.83.1768518246030; 
 Thu, 15 Jan 2026 15:04:06 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-661187a0000sm394787eaf.14.2026.01.15.15.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 15:04:05 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: thinhn@synopsys.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 felipe.balbi@linux.intel.com, mkorpershoek@kernel.org, lukma@denx.de,
 trini@konsulko.com, marex@denx.de, macromorgan@hotmail.com
Subject: [PATCH V2 1/4] usb: dwc3: core: Add ip and version_type support from
 Linux
Date: Thu, 15 Jan 2026 17:01:32 -0600
Message-ID: <20260115230135.183158-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115230135.183158-1-macroalpha82@gmail.com>
References: <20260115230135.183158-1-macroalpha82@gmail.com>
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

Add support for the ip and version_type fields from the Linux
version of the dwc3 driver. Included in this is support for a
few additional macros in the header from Linux as well.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/usb/dwc3/core.c | 26 ++++++++++++++----
 drivers/usb/dwc3/core.h | 60 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 847fa1f82c3..4827c83e96d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -580,6 +580,26 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
 }
 
+static bool dwc3_core_is_valid(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
+	dwc->ip = DWC3_GSNPS_ID(reg);
+
+	/* This should read as U3 followed by revision number */
+	if (DWC3_IP_IS(DWC3)) {
+		dwc->revision = reg;
+	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
+		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
+		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
+	} else {
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -592,15 +612,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	u32			reg;
 	int			ret;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
-	/* This should read as U3 followed by revision number */
-	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000 &&
-	    (reg & DWC3_GSNPSID_MASK) != 0x33310000) {
+	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
 		goto err0;
 	}
-	dwc->revision = reg;
 
 	/* Handle USB2.0-only core configuration */
 	if (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index b572ea340c8..cdbfdce76bb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -56,6 +56,7 @@
 #define DWC3_GEVNTCOUNT_MASK	0xfffc
 #define DWC3_GSNPSID_MASK	0xffff0000
 #define DWC3_GSNPSREV_MASK	0xffff
+#define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
 /* DWC3 registers memory space boundries */
 #define DWC3_XHCI_REGS_START		0x0
@@ -99,6 +100,9 @@
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
 
+#define DWC3_VER_NUMBER		0xc1a0
+#define DWC3_VER_TYPE		0xc1a4
+
 #define DWC3_GUSB2PHYCFG(n)	(0xc200 + (n * 0x04))
 #define DWC3_GUSB2I2CCTL(n)	(0xc240 + (n * 0x04))
 
@@ -686,7 +690,9 @@ struct dwc3_scratchpad_array {
  * @num_event_buffers: calculated number of event buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
+ * @ip: controller's ID
  * @revision: revision register contents
+ * @version_type: VERSIONTYPE register contents, a sub release of a revision
  * @dr_mode: requested mode of operation
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
@@ -795,6 +801,13 @@ struct dwc3 {
 	u32			num_event_buffers;
 	u32			u1u2;
 	u32			maximum_speed;
+
+	u32			ip;
+
+#define DWC3_IP			0x5533
+#define DWC31_IP		0x3331
+#define DWC32_IP		0x3332
+
 	u32			revision;
 
 #define DWC3_REVISION_173A	0x5533173a
@@ -817,6 +830,32 @@ struct dwc3 {
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
 #define DWC3_REVISION_290A	0x5533290a
+#define DWC3_REVISION_300A	0x5533300a
+#define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
+#define DWC3_REVISION_330A	0x5533330a
+
+#define DWC31_REVISION_ANY	0x0
+#define DWC31_REVISION_110A	0x3131302a
+#define DWC31_REVISION_120A	0x3132302a
+#define DWC31_REVISION_160A	0x3136302a
+#define DWC31_REVISION_170A	0x3137302a
+#define DWC31_REVISION_180A	0x3138302a
+#define DWC31_REVISION_190A	0x3139302a
+#define DWC31_REVISION_200A	0x3230302a
+
+#define DWC32_REVISION_ANY	0x0
+#define DWC32_REVISION_100A	0x3130302a
+
+	u32			version_type;
+
+#define DWC31_VERSIONTYPE_ANY		0x0
+#define DWC31_VERSIONTYPE_EA01		0x65613031
+#define DWC31_VERSIONTYPE_EA02		0x65613032
+#define DWC31_VERSIONTYPE_EA03		0x65613033
+#define DWC31_VERSIONTYPE_EA04		0x65613034
+#define DWC31_VERSIONTYPE_EA05		0x65613035
+#define DWC31_VERSIONTYPE_EA06		0x65613036
 
 	enum dwc3_ep0_next	ep0_next_event;
 	enum dwc3_ep0_state	ep0state;
@@ -1062,6 +1101,27 @@ void dwc3_of_parse(struct dwc3 *dwc);
 int dwc3_init(struct dwc3 *dwc);
 void dwc3_remove(struct dwc3 *dwc);
 
+#define DWC3_IP_IS(_ip)							\
+	(dwc->ip == _ip##_IP)
+
+#define DWC3_VER_IS(_ip, _ver)						\
+	(DWC3_IP_IS(_ip) && dwc->revision == _ip##_REVISION_##_ver)
+
+#define DWC3_VER_IS_PRIOR(_ip, _ver)					\
+	(DWC3_IP_IS(_ip) && dwc->revision < _ip##_REVISION_##_ver)
+
+#define DWC3_VER_IS_WITHIN(_ip, _from, _to)				\
+	(DWC3_IP_IS(_ip) &&						\
+	 dwc->revision >= _ip##_REVISION_##_from &&			\
+	 (!(_ip##_REVISION_##_to) ||					\
+	  dwc->revision <= _ip##_REVISION_##_to))
+
+#define DWC3_VER_TYPE_IS_WITHIN(_ip, _ver, _from, _to)			\
+	(DWC3_VER_IS(_ip, _ver) &&					\
+	 dwc->version_type >= _ip##_VERSIONTYPE_##_from &&		\
+	 (!(_ip##_VERSIONTYPE_##_to) ||					\
+	  dwc->version_type <= _ip##_VERSIONTYPE_##_to))
+
 static inline int dwc3_host_init(struct dwc3 *dwc)
 { return 0; }
 static inline void dwc3_host_exit(struct dwc3 *dwc)
-- 
2.43.0


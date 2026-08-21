Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C72C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3306140D38;
	Fri, 21 Aug 2026 13:14:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LTVMQQT6Xzjx; Fri, 21 Aug 2026 13:14:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318096;
	bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VgCXA3a0TDm7bj+k+FUioBTDQL6jYD9t7BUMqUTlOOmCppM9pr6TgmWnO8pdebEOy
	 t0kNDJb1jRvBdoLIu74mYB7xeLzGhvdKsxJ0BC0N1biRJRgq4MwA/Nv3eFrVeongyH
	 5SGn+0B6hAnSl482legUrJwF1S5eMq8k2l5JMV2w95UtmyeWrI+bclEtVZ9fwMKMD0
	 QKsZm4L+IvXBngjVnVT7v00OPJ0e/NCdaL5twmfLZTK87YddypGeMSFedl9QEspIxp
	 c/M6MWPc2Mi52JsgYj2ZOOwe0eJ7fGRFaESQqsvYZGTrZAucWu6C/DwSRcYGhehAqm
	 o1yVJ71GngpBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9277A40D4F;
	Fri, 21 Aug 2026 13:14:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 73ACD4B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65BF740073
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jy-pAXol00QD for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=yXs8/s8u
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C27A14006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:14 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a18b91fb1fso166360a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302333; x=1787907133;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
 b=yXs8/s8u2vYI0EpHZcdaGtFeFZ2A7zMGOASWdUwm3eG2l0KqDLqcNLNwhJ6d/st5ph
 UmdDqfWYP4SR2z0mSccBFfsw5iMBRwQGsjUaZXxdLJgBAK3d5YcnY9bWSNYV4ovgDf0q
 w7XLT5zVcIXQdFD707/zcavx1cS9V+uir2Pk7xUxR8DZ1r+o5pzEJxa0VvK2BNh9Lr6d
 VUl9izHp6mJAW5Y3nlbhiGKFXW/7rNkqX3kuuhr2xZDnpSYzJH7nsO6sYe/kPGR0Ryad
 q5aWzc6zMk54UpySNW+ef/SGTcfzahGBlY+C+o5Jz0fchx49KnSi9CnaHw07K/PKjSn1
 9xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302333; x=1787907133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=btR6xMHcc0KGn42Pec4OtlseLtYuwOuZ4H6V7/rtq9k=;
 b=FQJaqIZ8FGTyAiQGAsR35tVeSLdjIfygdp79QZ1EdSor+M9Ok6b0LNuqst1HbhoDcv
 eNkVoRPOdLKMSgkAtc6TRQKNlwhDYz64Hs2Fk8Mzqcelj4YbkjAoJz/cgfbCKFIZjf+g
 MEv5thmQhUS7eXNBREldgn46kcbqLvwn7ytqYo9gm0qvkX9AIvX25EyyLeE1C7DMKVka
 +1jy2KDdehnYflt2njAG0W2nxYm5XE42sSl4RWkRIsVqKk2VeEhKHEuX7BIpzMIFlx+6
 wk28w3efHMgSrmEgdyx9YzpHxJthAcj3PdP10chNhZYViQXcs2GFzDVz/NyQdR1waE43
 HeYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOwATgcJ8p/SuCpgdDyfxFZ+YM171NalugMqoFJBjyeV6u+0zvgXSrvYxFGZviSQ47MaK4+/8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nKHOAu06PMbp22LFcncEBkcZ+we0VJGUxij4ycfeWXbOC/2iAi
 ZDxZOlCS2p4dCGl9aOxgKeqhjLWScBOXct8gdtmdXLjH9hyA8XtGo3j8B3psM4PkGG4=
X-Gm-Gg: AR+sD13aGSoH12IL6vZ8YLga1Kf1KZP9MVDJHN29IU6zVeSbk0X9EJOgIxXNVIFu25U
 v1D3zSSi8YDz/HTl0NJlHszak1gda4iqGUmoy94eVWBw1i0bDpQYdoC/oUIb7hU+ilBEQmGC/MS
 VPztbvXZ1rc3XHHLcm6EVaEOr93IJ4YZgcirOSDG5nmTiVgHyq7AW3+Z3qMjDN2ComoaI0/bn+O
 HR6MZHKhvbIFRz5veilVxBtsDcZGsuV2clfQNz/KR+lrl/nsVEVZ7VLQAErdvmFVO8jrzF4mxIE
 E95BH//SvnM3V134TnrPsN6A32cKxNaFN/UM1dUOGKcmZTMfPup5IbkyfDhemSW3jiRPsSXUDAJ
 eEyb1fxuLN+o82ceYjCnAITZvRpIzhW9Ms3zcOE9MWFZu3s5AvwxWtFcRwXWQUubXbbRNKP957o
 78Tt43HMs1DSq0jQM8fAzxzVtHwAjx0ieNuNOIFqmbhJmWETFJ4Kem/r/6bjPdmmnSBf9jwE7Lc
 M1CGDadzLB/N+AAn4vffYXe
X-Received: by 2002:a17:906:f59a:b0:c15:c651:f28f with SMTP id
 a640c23a62f3a-c246a62f67amr271392066b.3.1787302332504; 
 Fri, 21 Aug 2026 01:52:12 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1780c9sm5353386a12.28.2026.08.21.01.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:11 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 58/87] usb: dwc3: import from kernel v6.13
Date: Fri, 21 Aug 2026 10:47:34 +0200
Message-ID: <20260821084829.2070426-59-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.12 to v6.13.

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

List of commits: git log --oneline v6.12..v6.13
Commits imported:
625e70ccb7bb usb: dwc3-am62: Disable autosuspend during remove
01ea6bf5cb58 usb: dwc3: gadget: fix writing NYET threshold
f5313c8b418c usb: dwc3: gadget: Remove dwc3_request->needs_extra_trb
61440628a4ff usb: dwc3: gadget: Cleanup SG handling
b7fc65f5141c usb: dwc3: gadget: Fix looping of queued SG entries
02a6982b0ccf usb: dwc3: gadget: Fix checking for number of TRBs left
5d2fb074dea2 usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
ce25e2a8d82d usb: dwc3: core: Set force_gen1 bit for all applicable SuperSpeed ports
61eb055cd304 usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic
6ff78df5b3d0 usb: Use (of|device)_property_present() for non-boolean properties
fad16c823e66 usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
9a0749d61a9a usb: Switch back to struct platform_driver::remove()
57d7a6b93822 usb: dwc3: Correct some typos in comments

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c      |  16 ++--
 drivers/usb/dwc3/core.h      |  15 ++--
 drivers/usb/dwc3/dwc3-am62.c |   3 +-
 drivers/usb/dwc3/ep0.c       |   4 +-
 drivers/usb/dwc3/gadget.c    | 156 +++++++++++++++++++++--------------
 5 files changed, 114 insertions(+), 80 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 98114c2827c0..f219c82e9619 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1409,7 +1409,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
-	 * fails to send proper CRC checksum in CRC5 feild. Because of this
+	 * fails to send proper CRC checksum in CRC5 field. Because of this
 	 * behaviour Transaction Error is generated, resulting in reset and
 	 * re-enumeration of usb device attached. All the termsel, xcvrsel,
 	 * opmode becomes 0 during end of resume. Enabling bit 10 of GUCTL1
@@ -1470,9 +1470,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET &&
 	    (DWC3_IP_IS(DWC31)) &&
 	    dwc->maximum_speed == USB_SPEED_SUPER) {
-		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
-		reg |= DWC3_LLUCTL_FORCE_GEN1;
-		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
+		int i;
+
+		for (i = 0; i < dwc->num_usb3_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_LLUCTL(i));
+			reg |= DWC3_LLUCTL_FORCE_GEN1;
+			dwc3_writel(dwc->regs, DWC3_LLUCTL(i), reg);
+		}
 	}
 
 	return 0;
@@ -1941,7 +1945,7 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	struct extcon_dev *edev = NULL;
 	const char *name;
 
-	if (device_property_read_bool(dev, "extcon"))
+	if (device_property_present(dev, "extcon"))
 		return extcon_get_edev_by_phandle(dev, 0);
 
 	/*
@@ -2651,7 +2655,7 @@ MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
 
 static struct platform_driver dwc3_driver = {
 	.probe		= dwc3_probe,
-	.remove_new	= dwc3_remove,
+	.remove		= dwc3_remove,
 	.driver		= {
 		.name	= "dwc3",
 		.of_match_table	= of_match_ptr(of_dwc3_match),
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eab81dfdcc35..f11570c8ffd0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -81,7 +81,7 @@
 #define DWC3_GSNPSREV_MASK	0xffff
 #define DWC3_GSNPS_ID(p)	(((p) & DWC3_GSNPSID_MASK) >> 16)
 
-/* DWC3 registers memory space boundries */
+/* DWC3 registers memory space boundaries */
 #define DWC3_XHCI_REGS_START		0x0
 #define DWC3_XHCI_REGS_END		0x7fff
 #define DWC3_GLOBALS_REGS_START		0xc100
@@ -179,7 +179,7 @@
 #define DWC3_OEVTEN		0xcc0C
 #define DWC3_OSTS		0xcc10
 
-#define DWC3_LLUCTL		0xd024
+#define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
 
 /* Bit fields */
 
@@ -464,6 +464,7 @@
 #define DWC3_DCTL_TRGTULST_SS_INACT	(DWC3_DCTL_TRGTULST(6))
 
 /* These apply for core versions 1.94a and later */
+#define DWC3_DCTL_NYET_THRES_MASK	(0xf << 20)
 #define DWC3_DCTL_NYET_THRES(n)		(((n) & 0xf) << 20)
 
 #define DWC3_DCTL_KEEP_CONNECT		BIT(19)
@@ -915,6 +916,7 @@ struct dwc3_hwparams {
 #define DWC3_MODE(n)		((n) & 0x7)
 
 /* HWPARAMS1 */
+#define DWC3_SPRAM_TYPE(n)	(((n) >> 23) & 1)
 #define DWC3_NUM_INT(n)		(((n) & (0x3f << 15)) >> 15)
 
 /* HWPARAMS3 */
@@ -925,6 +927,9 @@ struct dwc3_hwparams {
 #define DWC3_NUM_IN_EPS(p)	(((p)->hwparams3 &		\
 			(DWC3_NUM_IN_EPS_MASK)) >> 18)
 
+/* HWPARAMS6 */
+#define DWC3_RAM0_DEPTH(n)	(((n) & (0xffff0000)) >> 16)
+
 /* HWPARAMS7 */
 #define DWC3_RAM1_DEPTH(n)	((n) & 0xffff)
 
@@ -937,18 +942,14 @@ struct dwc3_hwparams {
  * @request: struct usb_request to be transferred
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
- * @sg: pointer to first incomplete sg
  * @start_sg: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
- * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
  * @status: internal dwc3 request status tracking
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
  * @num_trbs: number of TRBs used by this request
- * @needs_extra_trb: true when request needs one extra TRB (either due to ZLP
- *	or unaligned OUT)
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  */
@@ -960,7 +961,6 @@ struct dwc3_request {
 	struct scatterlist	*start_sg;
 
 	unsigned int		num_pending_sgs;
-	unsigned int		num_queued_sgs;
 	unsigned int		remaining;
 
 	unsigned int		status;
@@ -978,7 +978,6 @@ struct dwc3_request {
 
 	unsigned int		num_trbs;
 
-	unsigned int		needs_extra_trb:1;
 	unsigned int		direction:1;
 	unsigned int		mapped:1;
 };
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index fad151e78fd6..7d43da5f2897 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -309,6 +309,7 @@ static void dwc3_ti_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_set_suspended(dev);
 }
 
@@ -377,7 +378,7 @@ MODULE_DEVICE_TABLE(of, dwc3_ti_of_match);
 
 static struct platform_driver dwc3_ti_driver = {
 	.probe		= dwc3_ti_probe,
-	.remove_new	= dwc3_ti_remove,
+	.remove		= dwc3_ti_remove,
 	.driver		= {
 		.name	= "dwc3-am62",
 		.pm	= DEV_PM_OPS,
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c9533a99e47c..666ac432f52d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -145,7 +145,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	 * Unfortunately we have uncovered a limitation wrt the Data Phase.
 	 *
 	 * Section 9.4 says we can wait for the XferNotReady(DATA) event to
-	 * come before issueing Start Transfer command, but if we do, we will
+	 * come before issuing Start Transfer command, but if we do, we will
 	 * miss situations where the host starts another SETUP phase instead of
 	 * the DATA phase.  Such cases happen at least on TD.7.6 of the Link
 	 * Layer Compliance Suite.
@@ -232,7 +232,7 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED | DWC3_EP_TRANSFER_STARTED;
 	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4959c26d3b71..31a654c6f15b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -197,7 +197,6 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 
 	list_del(&req->list);
 	req->remaining = 0;
-	req->needs_extra_trb = false;
 	req->num_trbs = 0;
 
 	if (req->request.status == -EINPROGRESS)
@@ -687,6 +686,44 @@ static int dwc3_gadget_calc_tx_fifo_size(struct dwc3 *dwc, int mult)
 	return fifo_size;
 }
 
+/**
+ * dwc3_gadget_calc_ram_depth - calculates the ram depth for txfifo
+ * @dwc: pointer to the DWC3 context
+ */
+static int dwc3_gadget_calc_ram_depth(struct dwc3 *dwc)
+{
+	int ram_depth;
+	int fifo_0_start;
+	bool is_single_port_ram;
+
+	/* Check supporting RAM type by HW */
+	is_single_port_ram = DWC3_SPRAM_TYPE(dwc->hwparams.hwparams1);
+
+	/*
+	 * If a single port RAM is utilized, then allocate TxFIFOs from
+	 * RAM0. otherwise, allocate them from RAM1.
+	 */
+	ram_depth = is_single_port_ram ? DWC3_RAM0_DEPTH(dwc->hwparams.hwparams6) :
+			DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+
+	/*
+	 * In a single port RAM configuration, the available RAM is shared
+	 * between the RX and TX FIFOs. This means that the txfifo can begin
+	 * at a non-zero address.
+	 */
+	if (is_single_port_ram) {
+		u32 reg;
+
+		/* Check if TXFIFOs start at non-zero addr */
+		reg = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
+		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(reg);
+
+		ram_depth -= (fifo_0_start >> 16);
+	}
+
+	return ram_depth;
+}
+
 /**
  * dwc3_gadget_clear_tx_fifos - Clears txfifo allocation
  * @dwc: pointer to the DWC3 context
@@ -753,7 +790,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int fifo_0_start;
-	int ram1_depth;
+	int ram_depth;
 	int fifo_size;
 	int min_depth;
 	int num_in_ep;
@@ -773,17 +810,32 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 	if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
 		return 0;
 
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
 
-	if ((dep->endpoint.maxburst > 1 &&
-	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
-	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		num_fifos = 3;
-
-	if (dep->endpoint.maxburst > 6 &&
-	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
-	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
-		num_fifos = dwc->tx_fifo_resize_max_num;
+	switch (dwc->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
+			num_fifos = min_t(unsigned int,
+					  dep->endpoint.maxburst,
+					  dwc->tx_fifo_resize_max_num);
+		break;
+	case USB_SPEED_HIGH:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			num_fifos = min_t(unsigned int,
+					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
+					  dwc->tx_fifo_resize_max_num);
+			break;
+		}
+		fallthrough;
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
+			num_fifos = 2;
+		break;
+	default:
+		break;
+	}
 
 	/* FIFO size for a single buffer */
 	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
@@ -794,7 +846,7 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 
 	/* Reserve at least one FIFO for the number of IN EPs */
 	min_depth = num_in_ep * (fifo + 1);
-	remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
+	remaining = ram_depth - min_depth - dwc->last_fifo_depth;
 	remaining = max_t(int, 0, remaining);
 	/*
 	 * We've already reserved 1 FIFO per EP, so check what we can fit in
@@ -820,9 +872,9 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 		dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
 
 	/* Check fifo size allocation doesn't exceed available RAM size. */
-	if (dwc->last_fifo_depth >= ram1_depth) {
+	if (dwc->last_fifo_depth >= ram_depth) {
 		dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
-			dwc->last_fifo_depth, ram1_depth,
+			dwc->last_fifo_depth, ram_depth,
 			dep->endpoint.name, fifo_size);
 		if (DWC3_IP_IS(DWC3))
 			fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
@@ -1177,11 +1229,14 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 * pending to be processed by the driver.
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
+		struct dwc3_request *req;
+
 		/*
-		 * If there is any request remained in the started_list at
-		 * this point, that means there is no TRB available.
+		 * If there is any request remained in the started_list with
+		 * active TRBs at this point, then there is no TRB available.
 		 */
-		if (!list_empty(&dep->started_list))
+		req = next_request(&dep->started_list);
+		if (req && req->num_trbs)
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -1384,6 +1439,7 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 	unsigned int rem = req->request.length % maxp;
 	unsigned int num_trbs = 1;
+	bool needs_extra_trb;
 
 	if (dwc3_needs_extra_trb(dep, req))
 		num_trbs++;
@@ -1391,15 +1447,15 @@ static int dwc3_prepare_last_sg(struct dwc3_ep *dep,
 	if (dwc3_calc_trbs_left(dep) < num_trbs)
 		return 0;
 
-	req->needs_extra_trb = num_trbs > 1;
+	needs_extra_trb = num_trbs > 1;
 
 	/* Prepare a normal TRB */
 	if (req->direction || req->request.length)
 		dwc3_prepare_one_trb(dep, req, entry_length,
-				req->needs_extra_trb, node, false, false);
+				needs_extra_trb, node, false, false);
 
 	/* Prepare extra TRBs for ZLP and MPS OUT transfer alignment */
-	if ((!req->direction && !req->request.length) || req->needs_extra_trb)
+	if ((!req->direction && !req->request.length) || needs_extra_trb)
 		dwc3_prepare_one_trb(dep, req,
 				req->direction ? 0 : maxp - rem,
 				false, 1, true, false);
@@ -1414,8 +1470,8 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	struct scatterlist *s;
 	int		i;
 	unsigned int length = req->request.length;
-	unsigned int remaining = req->request.num_mapped_sgs
-		- req->num_queued_sgs;
+	unsigned int remaining = req->num_pending_sgs;
+	unsigned int num_queued_sgs = req->request.num_mapped_sgs - remaining;
 	unsigned int num_trbs = req->num_trbs;
 	bool needs_extra_trb = dwc3_needs_extra_trb(dep, req);
 
@@ -1423,7 +1479,7 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 	 * If we resume preparing the request, then get the remaining length of
 	 * the request and resume where we left off.
 	 */
-	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+	for_each_sg(req->request.sg, s, num_queued_sgs, i)
 		length -= sg_dma_len(s);
 
 	for_each_sg(sg, s, remaining, i) {
@@ -1488,7 +1544,6 @@ static int dwc3_prepare_trbs_sg(struct dwc3_ep *dep,
 		if (!last_sg)
 			req->start_sg = sg_next(s);
 
-		req->num_queued_sgs++;
 		req->num_pending_sgs--;
 
 		/*
@@ -1569,9 +1624,7 @@ static int dwc3_prepare_trbs(struct dwc3_ep *dep)
 		if (ret)
 			return ret;
 
-		req->sg			= req->request.sg;
-		req->start_sg		= req->sg;
-		req->num_queued_sgs	= 0;
+		req->start_sg		= req->request.sg;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
 		if (req->num_pending_sgs > 0) {
@@ -3075,7 +3128,7 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	struct dwc3 *dwc = gadget_to_dwc(g);
 	struct usb_ep *ep;
 	int fifo_size = 0;
-	int ram1_depth;
+	int ram_depth;
 	int ep_num = 0;
 
 	if (!dwc->do_fifo_resize)
@@ -3098,8 +3151,8 @@ static int dwc3_gadget_check_config(struct usb_gadget *g)
 	fifo_size += dwc->max_cfg_eps;
 
 	/* Check if we can fit a single fifo per endpoint */
-	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
-	if (fifo_size > ram1_depth)
+	ram_depth = dwc3_gadget_calc_ram_depth(dwc);
+	if (fifo_size > ram_depth)
 		return -ENOMEM;
 
 	return 0;
@@ -3416,20 +3469,16 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 		int status)
 {
 	struct dwc3_trb *trb;
-	struct scatterlist *sg = req->sg;
-	struct scatterlist *s;
-	unsigned int num_queued = req->num_queued_sgs;
+	unsigned int num_completed_trbs = req->num_trbs;
 	unsigned int i;
 	int ret = 0;
 
-	for_each_sg(sg, s, num_queued, i) {
+	for (i = 0; i < num_completed_trbs; i++) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		req->sg = sg_next(s);
-		req->num_queued_sgs--;
-
 		ret = dwc3_gadget_ep_reclaim_completed_trb(dep, req,
-				trb, event, status, true);
+				trb, event, status,
+				!!(trb->ctrl & DWC3_TRB_CTRL_CHN));
 		if (ret)
 			break;
 	}
@@ -3437,19 +3486,9 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	return ret;
 }
 
-static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
-		struct dwc3_request *req, const struct dwc3_event_depevt *event,
-		int status)
-{
-	struct dwc3_trb *trb = &dep->trb_pool[dep->trb_dequeue];
-
-	return dwc3_gadget_ep_reclaim_completed_trb(dep, req, trb,
-			event, status, false);
-}
-
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	return req->num_pending_sgs == 0 && req->num_queued_sgs == 0;
+	return req->num_pending_sgs == 0 && req->num_trbs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -3459,24 +3498,13 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 	int request_status;
 	int ret;
 
-	if (req->request.num_mapped_sgs)
-		ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event,
-				status);
-	else
-		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
-				status);
+	ret = dwc3_gadget_ep_reclaim_trb_sg(dep, req, event, status);
 
 	req->request.actual = req->request.length - req->remaining;
 
 	if (!dwc3_gadget_ep_request_completed(req))
 		goto out;
 
-	if (req->needs_extra_trb) {
-		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
-				status);
-		req->needs_extra_trb = false;
-	}
-
 	/*
 	 * The event status only reflects the status of the TRB with IOC set.
 	 * For the requests that don't set interrupt on completion, the driver
@@ -4167,8 +4195,10 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		WARN_ONCE(DWC3_VER_IS_PRIOR(DWC3, 240A) && dwc->has_lpm_erratum,
 				"LPM Erratum not available on dwc3 revisions < 2.40a\n");
 
-		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A))
+		if (dwc->has_lpm_erratum && !DWC3_VER_IS_PRIOR(DWC3, 240A)) {
+			reg &= ~DWC3_DCTL_NYET_THRES_MASK;
 			reg |= DWC3_DCTL_NYET_THRES(dwc->lpm_nyet_threshold);
+		}
 
 		dwc3_gadget_dctl_write_safe(dwc, reg);
 	} else {
-- 
2.53.0


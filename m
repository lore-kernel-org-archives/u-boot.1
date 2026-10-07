Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8B0CA6007
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 16:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 215A980EC6;
	Wed,  7 Oct 2026 16:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkOLt0NwB3EZ; Wed,  7 Oct 2026 16:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2D03280EAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791389245;
	b=mpNa5kDWYWrnb++7iJUbYaA2GfDJ/RZocYB5ZTSz5EgrGy2KRbuX834HPbtWT5UJ0MbR
	 Bbfk8GIZuHQh03+VAqjaJjB958BSrCz6vdsySxWycuzs8fN8LLLGTLcp4TL433MkKmHjL
	 tT4/TUi43r9gMIplyLLZMuMkyZv0IHwZHS+9gsLGfWwc8srHErWvbcSfH9HQO4TKNH0OR
	 0Wh1m7KsZ8j24b2pyJZytCgMd0bdvlIomfB/lEgx0fRH4qeFs23FGWvZRjmvKCGDd6UPI
	 QuZgSaK2Oq/zQmSMuXG0zbGJSGjYqalATDu9A5aioG1etHAoyrJLETeRw2Uk9kudgig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791389245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HN3owm61TIIaOfXb10Hl8sBkWCUmdNB0RZpFTKM5OSU=;
	b=Pu8dMc43RhGHPL4lpC40XFmJua/OutjzZD34QZhRJ+Qd58VKkqMy/kpxvC1CFvND6YiM
	 DWEomI+4DXW7+e2MM2/wzAvBOedFDxUk88QSsqAJq01OzCm2kTXWFOYkHvBPLhbtfT5b+
	 agQh1FSVn61RtS7z74GUkLoUB7WxVj4NSglrESXlbB7Niv3EHL2dvvYsS6lwh32XTChsE
	 PzalCzevmAqaPnQi4bU5MeYtgPEOFDblnALe8l+ouTaQ7YUtQ4+H3P878ZlblSigzHyxb
	 //dkd7J1tEzKKYdm83MssHLzX4stLsSFwqkZ+bVHGzOzOPwo+akwd5vxy4dlQELJocQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fwwpVg3G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791389245;
	bh=HN3owm61TIIaOfXb10Hl8sBkWCUmdNB0RZpFTKM5OSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ztFgDmPhV6tJb0opOtdJ2UjQXu2MLgg1PdV7RMguc6Ao7V83BW1yEbAPeSij9jrsD
	 gTPKSOnrOQVLLhiIoVNBk7wAvzIveVlKFiYqDHzyOkc4IJK/FTMol4JhJXgzwYfBxs
	 RKcLuL+VfN+xDOZZQXXzQldCszH6LClJ3tqFEJLH5gscGsaWPhPM6yTZciDcTFx9VE
	 6IBl7FjSHEKtYxt/DL7PjHaW+sOdRqVZmMfJ6KHy0+sm5FVEy+AtCWmNOi/t0fHxcc
	 VNYdUxARV2o6oqWkif9/+idiFtelmxZRWqISIcCcJO26uB4kZ05L90WIw6DdIJqfVe
	 lYeGLCkrdO4EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D03280EAA;
	Wed,  7 Oct 2026 16:07:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A390C335
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8958080ECC
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0eBrR2rEuJV for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 14:45:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 69F2880BA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791384355;
 b=KKXzFZo68Tk21dmZY00m/rDRC1DXNwSBcqZi7IABSyeAGXihg2um7R1xRvA674G1ZOC4
 NsjMgr4tBy+TGHLxjpIhItkDOA0wtRHbsDNM9020NzMv4hRD8kC5cEsnwLG5TMRp269FN
 30RPRUZiPxJZgLM8vfI0vG0SfEiAKA0jF5A8Jdeo1X7LdAl0mZGiNdwWJugqtVjQtIcyl
 n6KNdG7Qsq3ZodCSqtj16aQV8p6/ozOqCrqJ24Wcu1xRjhfcscOu5Py9R/gqHyNx3HiOY
 LGG5ovZnbW9Jc+4YY0Vyu+ZutD5uEkrvqekbxQRk/WqTKJZ+BIYYg1TubCMYXUZDz7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791384355;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=HN3owm61TIIaOfXb10Hl8sBkWCUmdNB0RZpFTKM5OSU=;
 b=MO+P3/1MG8eRSb7wt5t9a23uFnjsHEC4o7bwPuw0AACdnZ7xukxhLw6HpR4KBOvcpr3q
 4KMH6Y8Jizt4uA/DRUXXoWXkSzpkqsqLJ832n22RqV/OwNXlDUJKZiP0/ceFa0BNV+vYG
 /BYPFVcENQkRERY75wfkcnEzz+w/W4ya0kKC54/sIIbtadmWl5YDgplJ0H2+ZVdVLTXQL
 96qOhuTHWs4FZZ3HodjQHVpRsxR5y5AwzYFwULnDAhhNOgNpE4KZqy0Qz2eo7GypZjk7E
 mCmyOWaB5KafkXFGPbOKYP8SzaLFoP1oPuvXa5FiRWTZwZA7D9bYNoIWlR4dr03TZxQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fwwpVg3G; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fwwpVg3G
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69F2880BA6
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 14:45:54 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so40203685e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791384353; x=1791989153;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HN3owm61TIIaOfXb10Hl8sBkWCUmdNB0RZpFTKM5OSU=;
 b=fwwpVg3GyfCAPoZ7ZSuqpcLrjkUMeZhY6OWD2bVmjMphwvKPRuylHeLz9q2EthXLP+
 Hi9KFDNDdp9zzsau3ox5XYdi5W+qQshKCygxErCqD5d4vZg6DCgrCN7x2uEE7/tijlU3
 IH35v6mQFDnMEVwHjWy1Qw9XLG88M3tsBX1rGsbsKBhwncvnZC4AiealV7XJz6VYl4RF
 E7DooE/OzTi92n0NEjCFGUoOWWNXh2kXzGXZ8lLzL87NSJ1feUZ35znhu7fuh/c6skT+
 E+mujNQXp7EleaHBguwd6AJs0xrSgLO0jarBA9yJbOTjz49c6968LfqHMFGKlLbr0/3F
 jWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791384353; x=1791989153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HN3owm61TIIaOfXb10Hl8sBkWCUmdNB0RZpFTKM5OSU=;
 b=kGW8cMrfop7lKPXPXUPP5deF6/jlLKoip3iU1d5FhCE55u163cIowcHrrKsjrA3W4h
 vLgwpKOw5MvMXmV0PE6GMlgNc6rtsxRsfPT9en1VOe89TRNKxljQJ0axcsndf9hUXoe8
 69sfjs/upXUKvOd9ImvXgybPHL7LRs0Rtg1mPGkyw3HgBUwx4rpbeUoUakJF2zPeJZOU
 xFAFajxKhif56M7TwCYU/U/dQiNe3cbzpAT996H12zCVjGzy0jIBkTPlRgrVYUqUPpdj
 hz0IgjCH03cMgNPACtuV7IhsfUOCauxOh14XLoriRl1FimiBqcrW2SGs5j7uQM8rDsJu
 qm3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxKHMMyRz4syHvvK+rVb83LynMitoDLNGZp8HAFxzyheamFv5Vue9KO78scehZt7VjZlIEK3ug=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kJyc03qjVeIQtDqOhX33h/GfaswGLIJBuJ/NZlpbHoTuPcirOo
 YEGR64QD7K/Ut1bRa6yhxahnv7E13gX8edwOL0zFwdRFilpsRzaS0208
X-Gm-Gg: AYBFou3uXe6Qux5IY438cFMjuhQ9SX8x4ym+xUwKXbKNfv7Z9oIxLFwMd3v+bJi/wyz
 siJoQba9U9paPH7jCWcqkuKjQptihosDxNZw5Drv23jl9JKgHyM1FfrAMVc7x1K8/gq8TQLU1If
 Uhej7nL3hqFhcGmvebWck0pUopPd0r2DdHEBxIdToKklma2RHjsvejW/qLlAYfUWPWhGppSiWTN
 0D/XkEjIv6LpYXH9i8kKONH9MTbgj9jFNUKLT9gO8TPsLbXlhh3Urc4K0Il/gGevi9QcFvMkCqW
 JbWkVFTVFkGVmak7E/jmTtQFLkifR47NrclPhH5VGZ078mU1rObZ2dxW2kARWVX/uNrOP4vMi7i
 Pr61XROcv+EtbmG29QePw2gK5NladECtyYZuoXYsQDXzV4L2PNNROxmmWh+2nYsFL2HlfsRoJSd
 fh1+sfdg5o6An/0NbhXEnpKeUziHIDvQO2Ps60GaS5UqiJ7kKnze+IVUYaA7msUCwuuym5Zj/1l
 zkLHQ==
X-Received: by 2002:a05:600c:810c:b0:4a1:7163:3e41 with SMTP id
 5b1f17b1804b1-4a1804234ffmr38717245e9.9.1791384352873; 
 Wed, 07 Oct 2026 07:45:52 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f557bcbsm111620105e9.9.2026.10.07.07.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 07:45:52 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v4 5/6] usb: ehci-vf: take the register bases from the device
 tree
Date: Wed,  7 Oct 2026 16:45:43 +0200
Message-ID: <0b8d75592a76b0c7587b61f5cfae14e0b440a8b3.1791381507.git.mehmet.fide@screeningeagle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
References: <cover.1791381507.git.mehmet.fide@screeningeagle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The driver keeps its own tables of PHY and controller base addresses
and reaches the anatop block through a hardcoded address, although the
device tree describes all three: the controller points at its PHY and
usbmisc nodes, and the PHY at its anatop.

Read them from there and drop the tables. The port number stays only
for the choice between PLL3 and PLL7, which the device tree does not
express, and now comes from the alias of the PHY node.

The usbmisc node already starts at the non-core registers, so the
driver no longer adds an offset to reach them.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
Changes in v4:
- rebased on next
- dropped two comments that repeated the commit message
- reworded the commit message and took the note on the previous version
  out of it

 drivers/usb/host/ehci-vf.c | 135 ++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index e5f9ec0fdbb..b1cfad14b09 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -22,12 +22,9 @@
 #include <linux/delay.h>
 #include <usb/ehci-ci.h>
 #include <linux/libfdt.h>
-#include <fdtdec.h>
 
 #include "ehci.h"
 
-#define USB_NC_REG_OFFSET				0x00000800
-
 #define ANADIG_PLL_CTRL_EN_USB_CLKS		(1 << 6)
 
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */
@@ -39,28 +36,33 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static const unsigned phy_bases[] = {
-	USB_PHY0_BASE_ADDR,
-	USB_PHY1_BASE_ADDR,
+/* Possible port types (dual role mode) */
+enum dr_mode {
+	DR_MODE_NONE = 0,
+	DR_MODE_HOST,		/* supports host operation */
+	DR_MODE_DEVICE,		/* supports device operation */
+	DR_MODE_OTG,		/* supports both */
 };
 
-static const unsigned nc_reg_bases[] = {
-	USBC0_BASE_ADDR,
-	USBC1_BASE_ADDR,
+struct ehci_vf_priv_data {
+	struct ehci_ctrl ctrl;
+	struct usb_ehci *ehci;
+	struct gpio_desc cdet_gpio;
+	enum usb_init_type init_type;
+	enum dr_mode dr_mode;
+	struct anadig_reg __iomem *anatop_addr;
+	void __iomem *phy_addr;
+	void __iomem *misc_addr;
+	int portnr;
 };
 
-static void usb_internal_phy_clock_gate(int index)
+static void usb_internal_phy_clock_gate(void __iomem *phy_reg)
 {
-	void __iomem *phy_reg;
-
-	phy_reg = (void __iomem *)phy_bases[index];
 	clrbits_le32(phy_reg + USBPHY_CTRL, USBPHY_CTRL_CLKGATE);
 }
 
-static void usb_power_config(int index)
+static void usb_power_config(struct anadig_reg __iomem *anadig, int index)
 {
-	struct anadig_reg __iomem *anadig =
-		(struct anadig_reg __iomem *)ANADIG_BASE_ADDR;
 	void __iomem *pll_ctrl;
 
 	switch (index) {
@@ -83,13 +85,11 @@ static void usb_power_config(int index)
 	}
 }
 
-static void usb_phy_enable(int index, struct usb_ehci *ehci)
+static void usb_phy_enable(void __iomem *phy_reg, struct usb_ehci *ehci)
 {
-	void __iomem *phy_reg;
 	void __iomem *phy_ctrl;
 	void __iomem *usb_cmd;
 
-	phy_reg = (void __iomem *)phy_bases[index];
 	phy_ctrl = (void __iomem *)(phy_reg + USBPHY_CTRL);
 	usb_cmd = (void __iomem *)&ehci->usbcmd;
 
@@ -118,12 +118,8 @@ static void usb_phy_enable(int index, struct usb_ehci *ehci)
 		 USBPHY_CTRL_ENUTMILEVEL3);
 }
 
-static void usb_oc_config(int index)
+static void usb_oc_config(void __iomem *ctrl)
 {
-	void __iomem *ctrl;
-
-	ctrl = (void __iomem *)(nc_reg_bases[index] + USB_NC_REG_OFFSET);
-
 	setbits_le32(ctrl, UCTRL_OVER_CUR_POL);
 	setbits_le32(ctrl, UCTRL_OVER_CUR_DIS);
 }
@@ -133,63 +129,76 @@ int __weak board_ehci_hcd_init(int port)
 	return 0;
 }
 
-int ehci_vf_common_init(struct usb_ehci *ehci, int index)
+static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 {
 	int ret;
 
 	/* Do board specific initialisation */
-	ret = board_ehci_hcd_init(index);
+	ret = board_ehci_hcd_init(priv->portnr);
 	if (ret)
 		return ret;
 
-	usb_power_config(index);
-	usb_oc_config(index);
-	usb_internal_phy_clock_gate(index);
-	usb_phy_enable(index, ehci);
+	usb_power_config(priv->anatop_addr, priv->portnr);
+	usb_oc_config(priv->misc_addr);
+	usb_internal_phy_clock_gate(priv->phy_addr);
+	usb_phy_enable(priv->phy_addr, priv->ehci);
 
 	return 0;
 }
 
-/* Possible port types (dual role mode) */
-enum dr_mode {
-	DR_MODE_NONE = 0,
-	DR_MODE_HOST,		/* supports host operation */
-	DR_MODE_DEVICE,		/* supports device operation */
-	DR_MODE_OTG,		/* supports both */
-};
-
-struct ehci_vf_priv_data {
-	struct ehci_ctrl ctrl;
-	struct usb_ehci *ehci;
-	struct gpio_desc cdet_gpio;
-	enum usb_init_type init_type;
-	enum dr_mode dr_mode;
-	u32 portnr;
-};
-
-static int vf_usb_of_to_plat(struct udevice *dev)
+static int vf_parse_dt_addrs(struct udevice *dev)
 {
 	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
-	const void *dt_blob = gd->fdt_blob;
-	int node = dev_of_offset(dev);
-	const char *mode;
-	fdt_addr_t phy_addr;
-	ofnode phy_node;
-	int i;
+	ofnode phy_node, misc_node, anatop_node;
+	fdt_addr_t addr;
+	int ret;
 
 	phy_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbphy", 0);
 	if (!ofnode_valid(phy_node))
 		return -EINVAL;
 
-	phy_addr = ofnode_get_addr(phy_node);
-	for (i = 0; i < ARRAY_SIZE(phy_bases); i++) {
-		if (phy_addr == phy_bases[i])
-			break;
-	}
-	if (i == ARRAY_SIZE(phy_bases))
+	misc_node = ofnode_parse_phandle(dev_ofnode(dev), "fsl,usbmisc", 0);
+	if (!ofnode_valid(misc_node))
+		return -EINVAL;
+
+	anatop_node = ofnode_parse_phandle(phy_node, "fsl,anatop", 0);
+	if (!ofnode_valid(anatop_node))
+		return -EINVAL;
+
+	ret = ofnode_get_alias_seq(phy_node, dev->uclass->uc_drv->name,
+				   &priv->portnr);
+	if (ret)
+		return ret;
+
+	addr = ofnode_get_addr(phy_node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->phy_addr = (void __iomem *)addr;
+
+	addr = ofnode_get_addr(misc_node);
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
+	priv->misc_addr = (void __iomem *)addr;
 
-	priv->portnr = i;
+	addr = ofnode_get_addr(anatop_node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+	priv->anatop_addr = (struct anadig_reg __iomem *)addr;
+
+	return 0;
+}
+
+static int vf_usb_of_to_plat(struct udevice *dev)
+{
+	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
+	const void *dt_blob = gd->fdt_blob;
+	int node = dev_of_offset(dev);
+	const char *mode;
+	int ret;
+
+	ret = vf_parse_dt_addrs(dev);
+	if (ret)
+		return ret;
 
 	priv->ehci = dev_read_addr_ptr(dev);
 	mode = fdt_getprop(dt_blob, node, "dr_mode", NULL);
@@ -241,7 +250,7 @@ static int vf_init_after_reset(struct ehci_ctrl *dev)
 	struct usb_ehci *ehci = priv->ehci;
 	int ret;
 
-	ret = ehci_vf_common_init(priv->ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
@@ -270,7 +279,7 @@ static int ehci_usb_probe(struct udevice *dev)
 	struct ehci_hcor *hcor;
 	int ret;
 
-	ret = ehci_vf_common_init(ehci, priv->portnr);
+	ret = ehci_vf_common_init(priv);
 	if (ret)
 		return ret;
 
-- 
2.55.0


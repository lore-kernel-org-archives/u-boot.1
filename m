Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B08C982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBBD240750;
	Wed, 16 Sep 2026 13:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLjfduWsZdjW; Wed, 16 Sep 2026 13:08:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 01FCD40748
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564126;
	b=O5QXKxjkRcO+1oY3ymXy44x05b8wDKFG//C1bQLyTwUD2q4RS45W8xc9uYJTQdEdDUY/
	 PReGwCKHFRLYEFOamDBYVKwTS0kM8L6i5UU3JCABQkBLHpWc21qhkriSbfQgN02KAe3zI
	 HNl85wPtTZTaEZD2uW5BuG0B9Hq2LPfX78tcEItj7himW4+CfR/QDW8p4LTzY2N/7IB+2
	 UHadzUMUdJlD5zSN8m/Cz2Bz0EuL2PAiO8JJc9h3YKFUDEKUCu+THf2lm99WgO1a8Appw
	 nPDEq8PrpGArY/3Ns9+VdxQvgwxdAT8C+DjbjSFB/dRvhMtTASf1suRuGqQ5lOdAMUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564126;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HmOoRIRMhXGXlxoeZHGZ7jjfE0stv97zdQN5igCx35Q=;
	b=dFq/7UdTQA7javZq3ExB3iFNvB7Y7isDWXxsZ6oqwViliz5+naHs2us7OXPnv0OGSdWl
	 fN0qvZi05DI61miCrHs6TkQVLR2mAdKL9HPsds7lB6s1IKTDcIDgEy+L0zobfgc+W+wmV
	 VNQmkKbeUPZU9G+q1qIDbv6G7H28tuJsWIuju82cuTlbJY6R5qokc/+oavSkuUGqvFJ6P
	 01UFHibsqGhelvgEjHFiLD2I6hQYYDzKHDXHun1ZB2rQLbCvHWU2BiXL0J1M0S0VZgKzR
	 msd+8Jm5bhfuTWciNBn0Qg9i1dtrFt4w2186wx3pDn+y9QxQFj+e3TMCF1ygTJqtAdw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WmmZq8Yw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564126;
	bh=HmOoRIRMhXGXlxoeZHGZ7jjfE0stv97zdQN5igCx35Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L8gtIKCrmZyeQgvE8h+TjzhtBkY2pfmpR5jzfKr9zhaKdZw5f/NmPyTwmZPv0LHmI
	 JrHp9c4cF2Gb+Ult6Bl3O620CeUT1JES2R6c9UG3L7+cnbRTBHpxPA1Kk8ayuXrwQx
	 6VxGeL2SpSxApefnjpj24RK2/sGJY2kbpb05GffRfctR4a44VBX0a7QYNIhhvA//Kj
	 8UhOs7Zgb7rtSPFeBl/qiM54kJO221/L0B2RBEMWRdSnmV7rkR1hUl4hvJHHgLh5HL
	 6NQmNs7HRQVWuNmfSwaX0++7rg66cXpVIXE1y7km90MecrL/WUFxt6Q9ipWqtTOp15
	 VQh/0PodWRmMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01FCD40748;
	Wed, 16 Sep 2026 13:08:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BD812E3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5EAF406FB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MexKU47d-ZTa for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EFDC2406F7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::22"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562368;
 b=nx8sF5LSikU9L3cCJve2nwraz5Jvi8NgmWotq7Glcu3kyOsgl4n1VhhWB7yYjnx/JMIr
 2yx+kXSR3yCA1CrisNPu4ah4EuqQpD1ggTTOoJqu5Hd+YcAbuoxiJXoXqneTlcI7D7O0G
 /ONmSxeGMGvmqP9/k3SK4umUtsmtDE+YjSrFsuz8Vwjc3I6srnti0PSfnfDRLP3UCZici
 gbWWdCgAvgWvTOiZIW1eBIlI7ZKXai7KNL/0cI+/kxg+3Ftv/G1OvpLn8bJCQ4Ex4H15E
 35SYnDdzCkXObIkBOkMFSUnKWzWzYBUt66aqvQT/+OW17aO3mbUkValLZJK14pmDiTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562368;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=HmOoRIRMhXGXlxoeZHGZ7jjfE0stv97zdQN5igCx35Q=;
 b=bp3MctcOhq+E5tpGfFHCsktaCSkvf0Qz7TKppS7AcplXi5EEyABIr3scIDMMz/1Cm2Yi
 8AOUz/KVheRTPRidSjsThFSMrLH0UYGO7b+6Y49CNgVc3Do+pSJCw9TqedvituLV1FcNC
 y7VpehX6pnEb+WXjCISRWU1rnCieOsI8yw8YyARZQ0qc+WXt9nznUphEa/z70SLmpU/l7
 +kOYlyx84R/AQRhIdsEddaa01Y+MQl4M9XA8Y4jUk9QwgZG3bJKNq88xpORWduQGBFL59
 AEtxCrBZKB+AAc9WVNpdEP6+Oe03NdRxFNtMvsK4hJqlJGboGaYIjl+p011mCiiWxKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WmmZq8Yw; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::22"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::22; helo=mail-ej2-x22.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=WmmZq8Yw
Received: from mail-ej2-x22.google.com (mail-ej2-x22.google.com
 [IPv6:2a00:1450:4864:34::22])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFDC2406F7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:27 +0000 (UTC)
Received: by mail-ej2-x22.google.com with SMTP id
 a640c23a62f3a-c250848d11cso12137166b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562366; x=1790167166;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HmOoRIRMhXGXlxoeZHGZ7jjfE0stv97zdQN5igCx35Q=;
 b=WmmZq8YwYUZ0wdS2A6Lriwg0zSWGBEyanaDMXIhx6OHe9lo1Fsv1fwHWLhrjaHlPMN
 zjramenZLSW55qtfQzNNEHrjrICMs4twRXpwOHd+dlvLxYsZ/ftCT5RIKhbzFS9aRE87
 CHrJ28NcqTrT2t+UYIxjwwDzjudKhsR8maPv41VUpFNI6MVLa3XCbJ4eRcMzNaUiwsVI
 xbDVhGqhG6XzVhOrsoTKGZLSzd2OqHO4DR8E2Zke9yKDH7EEPegtTZnMH97P7XW4izd7
 p+yKvnennALLYLqKCteFPFjh9JbopLiMDCqkDjCv18Q0IRflwN389ltL2+rU5IKyu5yW
 L4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562366; x=1790167166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HmOoRIRMhXGXlxoeZHGZ7jjfE0stv97zdQN5igCx35Q=;
 b=NDco60bNcTI21EhHD+RRETPqyLn0vFvWIQPRZadghlPmM5mbNOsn3EycXu83C9y/Px
 UKIgDZaQ6Fv1JB/6+YKKQVRybItlsWjAFISLgGdAYD+LTlVuuqAEIufpCFXtD8VqV2ls
 Y06jzrh4Bay4CGwapcptDz3Up7njEkMj1wr+avetggxLAMYzqgP67FuVuu7oOUfxpXhu
 pUTQEuGbEjOKerrcxMgqxMAGEfHv9aqxihzEwI1KNv57OaP9Foydr6VVbXRucDIyi0U2
 oDi+HPFoUglov5zZRdZSaF1FjAdB07O/wwma2m8O8URO7r+iZM0Ihh/kl93H/DpCr8xe
 M/fQ==
X-Gm-Message-State: AFuF++kZ40df8TP6EtkhmQ1ow9Sc9nKizAgM8PHbzjUWxrqmJf0uVzQa
 VycBFuS7qO+Kjvd7JFmin/WhgdTybdkdjs1JP2SPSEKCc6KRv1fEUUai6E48N5UdzTxogfkUlan
 FrOE4
X-Gm-Gg: AYBFou3Y/EDdV2XWg3jAz+cZlSqIzGAdpzZr7owC5zd5hGAQHr4BpPzj4Nu7Gij3oa3
 SAIUxGkqdgstcO6mz5d+NNs7+oQlKRnFByPl+P1NFzI/cVgd2uyFk5u0GG4HOXhv5fDx/c9kdQ2
 5SML5w5ScEpIkPF4WK82C0sKlpuX7QZHxvjzLroQhHDJ9cRtLQEW1w21GgzWYntn6Pt0BvH8wDf
 86sSpK7XdJXTGDiS6TYntGLt+mlPhP5OgbFqkVUTlrlLTsBFHZeuhYgnVsDkBS4jGIUHfHf8DL2
 7fjKc6CbaAS9GuKBw2CMiDL5U/91Rj7gD8+FdOtIsotya92KqFO92J5PBPbajyWC9O7VirjvMih
 JIriU9RZKCVHKg/irlBWtauvFFjFDXofnrdolcfJR5SCbr/y49In8ogLRsgtpHcmioc8ckoWdRp
 3fk0PwHKmmxJ5yMAtY8ENCcC1uDmajYXqweOiAphB32WOfMM70XlQ5DIcqGvDdvoQ9GaPa1hxV9
 6aqbA5gEw6oMn7C9yx9EpRN4hSkxiCZlkQaruN4aaWebsltcEjrXSRM
X-Received: by 2002:a17:907:3e91:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c29e4e84822mr200564866b.0.1789562365758; 
 Wed, 16 Sep 2026 05:39:25 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086aa3sm136889166b.6.2026.09.16.05.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:39:24 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v9 07/26] usb: dwc3: bring back the samsung usb phy driver
Date: Wed, 16 Sep 2026 14:38:07 +0200
Message-ID: <20260916123826.517181-8-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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

The restore commit at the start of this series deletes samsung_usb_phy.c,
because the file was not part of the original v3.19-rc1 import. It never
came from the kernel, it is U-Boot code added later.

Nothing added it back, but CONFIG_USB_DWC3_PHY_SAMSUNG is still in
Kconfig and odroid-xu3_defconfig still selects it. exynos5-dt.c calls
exynos5_usb3_phy_init() from this file, so that board would lose its USB
3.0 phy setup.

Bring the file back unchanged and add it to the Makefile again.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/Makefile          |  1 +
 drivers/usb/dwc3/samsung_usb_phy.c | 77 ++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 drivers/usb/dwc3/samsung_usb_phy.c

diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index 63c7c6063002..a5775c4bea04 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_STI)		+= dwc3-generic-sti.o
 obj-$(CONFIG_USB_DWC3_UNIPHIER)		+= dwc3-uniphier.o
 obj-$(CONFIG_USB_DWC3_PHY_OMAP)		+= ti_usb_phy.o
+obj-$(CONFIG_USB_DWC3_PHY_SAMSUNG)	+= samsung_usb_phy.o
diff --git a/drivers/usb/dwc3/samsung_usb_phy.c b/drivers/usb/dwc3/samsung_usb_phy.c
new file mode 100644
index 000000000000..3563070cb85d
--- /dev/null
+++ b/drivers/usb/dwc3/samsung_usb_phy.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * samsung_usb_phy.c - DesignWare USB3 (DWC3) PHY handling file
+ *
+ * Copyright (C) 2015 Samsung Electronics
+ *
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ */
+
+#include <asm/io.h>
+#include <asm/arch/power.h>
+#include <asm/arch/xhci-exynos.h>
+#include <linux/delay.h>
+
+void exynos5_usb3_phy_init(struct exynos_usb3_phy *phy)
+{
+	u32 reg;
+
+	/* Reset USB 3.0 PHY */
+	writel(0x0, &phy->phy_reg0);
+
+	clrbits_le32(&phy->phy_param0,
+			/* Select PHY CLK source */
+			PHYPARAM0_REF_USE_PAD |
+			/* Set Loss-of-Signal Detector sensitivity */
+			PHYPARAM0_REF_LOSLEVEL_MASK);
+	setbits_le32(&phy->phy_param0, PHYPARAM0_REF_LOSLEVEL);
+
+	writel(0x0, &phy->phy_resume);
+
+	/*
+	 * Setting the Frame length Adj value[6:1] to default 0x20
+	 * See xHCI 1.0 spec, 5.2.4
+	 */
+	setbits_le32(&phy->link_system,
+			LINKSYSTEM_XHCI_VERSION_CONTROL |
+			LINKSYSTEM_FLADJ(0x20));
+
+	/* Set Tx De-Emphasis level */
+	clrbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH_MASK);
+	setbits_le32(&phy->phy_param1, PHYPARAM1_PCS_TXDEEMPH);
+
+	setbits_le32(&phy->phy_batchg, PHYBATCHG_UTMI_CLKSEL);
+
+	/* PHYTEST POWERDOWN Control */
+	clrbits_le32(&phy->phy_test,
+			PHYTEST_POWERDOWN_SSP |
+			PHYTEST_POWERDOWN_HSP);
+
+	/* UTMI Power Control */
+	writel(PHYUTMI_OTGDISABLE, &phy->phy_utmi);
+
+		/* Use core clock from main PLL */
+	reg = PHYCLKRST_REFCLKSEL_EXT_REFCLK |
+		/* Default 24Mhz crystal clock */
+		PHYCLKRST_FSEL(FSEL_CLKSEL_24M) |
+		PHYCLKRST_MPLL_MULTIPLIER_24MHZ_REF |
+		PHYCLKRST_SSC_REFCLKSEL(0) |
+		/* Force PortReset of PHY */
+		PHYCLKRST_PORTRESET |
+		/* Digital power supply in normal operating mode */
+		PHYCLKRST_RETENABLEN |
+		/* Enable ref clock for SS function */
+		PHYCLKRST_REF_SSP_EN |
+		/* Enable spread spectrum */
+		PHYCLKRST_SSC_EN |
+		/* Power down HS Bias and PLL blocks in suspend mode */
+		PHYCLKRST_COMMONONN;
+
+	writel(reg, &phy->phy_clk_rst);
+
+	/* giving time to Phy clock to settle before resetting */
+	udelay(10);
+
+	reg &= ~PHYCLKRST_PORTRESET;
+	writel(reg, &phy->phy_clk_rst);
+}
-- 
2.53.0


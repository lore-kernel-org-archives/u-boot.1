Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6EED3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC01A89A0B;
	Mon, 25 Nov 2024 10:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fkr3DcCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFD4489A0B; Mon, 25 Nov 2024 10:46:21 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79B889A0C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3824a089b2cso2505495f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732527979; x=1733132779; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oNQ8O576FgB3fxeG/SxKle4tmWqWhdc0jmFGpnDf5VQ=;
 b=Fkr3DcCrEPMoy4FOWc09+sYIbTQX6Ay7K/RYB/K5CAPFstRa61ScEq9RdlOh4TI1mE
 S/VpX/UNUM69Asfw6/4v0f1B/TW26GPrlK1gc6SVHo6ywoLMhlrdy2/08Txf8eDJD2K1
 b7RrI3KwcKO4+rEQEXZDpN880R+6uNva017Svla7PM784iWhuXqOf9H5lYKWzrD0zXKZ
 uvpL6rpPqPXkmHCfhXfa1CdVR8pRKiACAJESRH3pXwBMuNWqs59xipH2xMRrAn0M3lLR
 9z1GJVDJuIso7WbhlwHAinsO67t97oBpVa0PZptToVbcsjvoUfIfg2b5BJwkRNKXHmpX
 Ax0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732527979; x=1733132779;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oNQ8O576FgB3fxeG/SxKle4tmWqWhdc0jmFGpnDf5VQ=;
 b=d7s+9THbYwD72JSNeJ9Wqr6KEmSxeYkCHU6tI+egUjH7dbIdYinvJUv44QFSzabWTl
 KLcVGjx8+gT/xE6ZXb67jDwQo4Kq+U6q9OHmOHV2XCU0meS++llyxn77xLj7yLJuOvc1
 I2KyXaA8ca4gcguKd9R2yEDH52kjWgl8Z/OnBz65LVJ+uJFtOB1xzDVeEUBKrZL06h0t
 ZI7cNtiPZQBG8GQyqeBmES0VeKhBvWF9gWzWkYlLHbcYrm4L7uhFVJEeHbeJs8MdjcLc
 YM8iACOk1TFQYAJJdphQQBgmBKiZW8cIQEu6kBQYxbPWlF9E6CNYQbwWrJn4HPr8NdaF
 78lA==
X-Gm-Message-State: AOJu0YyTmx6CuUFdgDCVfGhjug7N7wcFcbNcWzbbcejlMKqpwQq8zdeS
 cbNC3p3TtHVVSEUmuSHHWbEPN0ou1okUwV26uDAWp6DebfM3uwg0zsT75zmZSXo=
X-Gm-Gg: ASbGncuGZnbSRP+C5eubYtJBQ41qIrkmYGhg13Y7gcfkPgTHrAct+YfVY3OKmrNmUGx
 DUCUpN+90hKkKPTnEyvZGsUepkGgcVllNVJk0Cq/F28FrYKDtd5FkLEkusu98Wmdd1qmwFf7GrL
 L9UKlxrFr5OJvgp0zwW2PfqHjwJPJhnP75IVwnFYzAzBzl9utsz65Q/QOpHSkU8DU9+EfGxxuAO
 BqQR3H71YqviZUiO7e2bCCIe4bOr4qqeOA1CbvPz3l1FRjkk4hZRiukqNtTulGylqE++Xo=
X-Google-Smtp-Source: AGHT+IHHGLRZ/+nN2Av9UdqzOmdGqTf4BB1yK+lCfuV65kt8ISJrjBF6cnz4POgKm2nZatRDwa8sSw==
X-Received: by 2002:a5d:64cc:0:b0:382:5010:c8c8 with SMTP id
 ffacd0b85a97d-38260bcbafcmr8990650f8f.41.1732527979249; 
 Mon, 25 Nov 2024 01:46:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm9804590f8f.53.2024.11.25.01.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 01:46:18 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 10:46:16 +0100
Subject: [PATCH 1/2] pci: pcie_dw_common: introduce pcie_dw_find_capability()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-controller-v1-1-45c20070dd53@linaro.org>
References: <20241125-topic-pcie-controller-v1-0-45c20070dd53@linaro.org>
In-Reply-To: <20241125-topic-pcie-controller-v1-0-45c20070dd53@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2511;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=y2HdtS5CQGOYvcDh20iPQF5aU5NB6kPBpR2LOqM+p7k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnREdpTtvmZVEomk92F5J6fIzrbKn5MO98MSXXzXi2
 uHwRGKCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0RHaQAKCRB33NvayMhJ0fNIEA
 CtXqJKB6RHsdEL9nTmITSe6ppGHfAMqoPtKm6AHFRgj6IVeWVCNZPRSZb+4KSeo1imOLg9ayeTJ826
 3CsQuKvIorAFdt4jLq0htf1MDPXnikDfNzxzmpnC3dxHWJcBR7aLW4cV+dtjI0AocFDeKmIeIppvUa
 JXe2tTJIMF5WRggSS0PMbaA4ffizA/Ae71FrgGb/cCz0Y3ZrLOevivoI8ZeIgG3/eec78wdQgiCIQl
 wWsDVLpMZn+KOJRD4Rb4wXzg8v6xd2JLTxHPSgXugKXqDAn5B66yiyV/JexAKK3Zxn2Icd35q2P+dQ
 sxv+jwquQb/VMeZlohrvSQV4/wN0UVNJrdt7CVZiVgHyhvVfXHyQ5OivMn8Y9CgDpNxCWNaEYeYR0g
 o1/26/UL4XYb7oqLUyb9bG5moo+8hYoErjtUABOpZOklWIl74XhM/v8FoxvmuEsQfOBo3Vg0V+M0I7
 EUwT88AtNZxFyrBpwYyGuqsVpGpCVVce+d0PvEg++pEjHePchP+xWylLK6FZZSsYGsargzD+G3QTTG
 hlhA0FlctpjF8gQiO9NeN6eczqAPoofm2aC/RwAAHD3PlRn3qiuw/f6nLklazQQXnuvzIsoO6Waj2Q
 2u95055rtwXAJBz+XStGJhuVVMSlwitsQNAJse2V9s6RoXY07/NYIZ7Io/+Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add PCIe config space capability search function specific for
the host controller, which are bridges *to* PCI devices but
are not PCI devices themselves.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pcie_dw_common.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie_dw_common.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index 0673e516c6fee6c01e5a5d23592e0ef55d49d823..78961271a8eef8e4b6991675ee9de2bb1968b8da 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -267,6 +267,48 @@ int pcie_dw_write_config(struct udevice *bus, pci_dev_t bdf,
 						 pcie->io.bus_start, pcie->io.size);
 }
 
+/*
+ * These interfaces resemble the pci_find_*capability() interfaces, but these
+ * are for configuring host controllers, which are bridges *to* PCI devices but
+ * are not PCI devices themselves.
+ */
+static u8 pcie_dw_find_next_cap(struct pcie_dw *pci, u8 cap_ptr, u8 cap)
+{
+	u8 cap_id, next_cap_ptr;
+	u32 val;
+	u16 reg;
+
+	if (!cap_ptr)
+		return 0;
+
+	val = readl(pci->dbi_base + (cap_ptr & ~0x3));
+	reg = pci_conv_32_to_size(val, cap_ptr, 2);
+	cap_id = (reg & 0x00ff);
+
+	if (cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
+	if (cap_id == cap)
+		return cap_ptr;
+
+	next_cap_ptr = (reg & 0xff00) >> 8;
+	return pcie_dw_find_next_cap(pci, next_cap_ptr, cap);
+}
+
+u8 pcie_dw_find_capability(struct pcie_dw *pci, u8 cap)
+{
+	u8 next_cap_ptr;
+	u32 val;
+	u16 reg;
+
+	val = readl(pci->dbi_base + (PCI_CAPABILITY_LIST & ~0x3));
+	reg = pci_conv_32_to_size(val, PCI_CAPABILITY_LIST, 2);
+
+	next_cap_ptr = (reg & 0x00ff);
+
+	return pcie_dw_find_next_cap(pci, next_cap_ptr, cap);
+}
+
 /**
  * pcie_dw_setup_host() - Setup the PCIe controller for RC opertaion
  *
diff --git a/drivers/pci/pcie_dw_common.h b/drivers/pci/pcie_dw_common.h
index e0f7796f2a873f91ef74bc6ce84966a4215c22f0..8cb99a12ea1a5fd3687f980cc1ff99839d06dbc2 100644
--- a/drivers/pci/pcie_dw_common.h
+++ b/drivers/pci/pcie_dw_common.h
@@ -139,6 +139,8 @@ int pcie_dw_read_config(const struct udevice *bus, pci_dev_t bdf, uint offset, u
 int pcie_dw_write_config(struct udevice *bus, pci_dev_t bdf, uint offset, ulong value,
 			 enum pci_size_t size);
 
+u8 pcie_dw_find_capability(struct pcie_dw *pci, u8 cap);
+
 static inline void dw_pcie_dbi_write_enable(struct pcie_dw *pci, bool en)
 {
 	u32 val;

-- 
2.34.1


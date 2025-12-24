Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8454BE7848A
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74E78432A;
	Wed, 24 Dec 2025 20:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pQRIA6Q0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDB4842C9; Wed, 24 Dec 2025 20:32:35 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7576D842B6
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4510974a6bbso2060493b6e.3
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604751; x=1767209551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v32Aoj0DxSZ4+qi4oBXeCvvygyJ3yFHfDtehe6eGEuE=;
 b=pQRIA6Q0ysSqywFdJx4FuGA51Ma7s29eJFsGVeyifbh7XyTh01NAAxknzLCCH31KuQ
 ZIjzaCAtapIAgMDat2ACQPIWEB4NI1iydTR4s+tnXzIRpWVjAQsxTQrv4qSN0v4X00Gp
 hHxvzRNeAcDBQia32X21ti62TbawVD0+hkoHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604751; x=1767209551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v32Aoj0DxSZ4+qi4oBXeCvvygyJ3yFHfDtehe6eGEuE=;
 b=fFmuovidgFz0IW2UA/+PXwPrBFMxVOsx3109vreN+eAD2Nxr4xdJUhRACyha0Uv756
 iv4QhDgN/dhe4ArpWQ61tixdHiwYubCYkNcBBRepHcPtFrLM1WxIKsBOx5b22NDjI0MS
 MAlWTnnPQV0CKOSNA4McV7VI+rHsI4C9NW6WW7tGeP+9TlIwC6TvJDH5tjPRcgM1iCdp
 z8rgOgVnjaNOM/2wkPHxt2Mys+bJdwggjUwr8xGRfK2qgj6pn1P9ZaDCERQCvojI5Shk
 7vArm7B/8wAhSmJKJmnIa4qrYFsl3684SIYd3atwKKjxdVztxNZeeryUMB42lcWRPat+
 fqXQ==
X-Gm-Message-State: AOJu0Yxl5EopEIrFExzRqs8GIM1K8Nxkt61ZkA1/uatCL4SF9LSy0lY4
 K+ruentbuWb0XoGpkTOHMLnyjFiOxhAEwtwunhbv8alHSpg7ysY56t+YIREXferNN4xwZU6/CdN
 YpgbanbI=
X-Gm-Gg: AY/fxX7Xq3EsQk2I9A6N9CvQc4EpKMeAM9EqyrKH584I2zv6vN+7kDrFz9kVDyb7Vh3
 /OsQWc5PtoRj72sMMwGq32LjjRyYdfk7gNHJITU4SsmhEiB7ZstONqBbNGw5k7453+25wZidm9K
 rgqkC6AgMaC6ddw+Ayxxw00J4nhNPJpCphUx096CnBmn9phNrGkkqpwdHgTi0WkkBv0KFXnUzpu
 72WAQkvUbZHPbiNirSNjsa2WowhTHvLe+QRbMDrykaoKpi9MVw7Kivg9KiIkw3qZ/zwsdVdb/dq
 7C39hYu5Z5L02Ii6k0O3S+YsmcbjgMQ0YxWLqUXEl4OHYeFV8b5DgB41X7b8Uhgg2s4BLV0Tbpv
 NpxPD9JqPgbCpGfAFjUtXNIDbDjbD/jElcOV/z0O3wkj92V/SrjryYS8EptN4wPrjWgPs+5S70v
 FVQUZGzfCGqJRXdj52xNbiEoyYgMCnKNCdKe0=
X-Google-Smtp-Source: AGHT+IFiCogj/Csn/GR1y68Q77eH61UIPDNJrcwTrhqU/nXtVZjI6p4ydWRV8t3HeAfsskk2Ap5kyg==
X-Received: by 2002:a05:6808:470c:b0:450:4367:111 with SMTP id
 5614622812f47-457b222aa4fmr7945388b6e.66.1766604750965; 
 Wed, 24 Dec 2025 11:32:30 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:30 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] pci: pcie_cdns_ti: Add PCIe support for J722S SoC
Date: Wed, 24 Dec 2025 13:32:03 -0600
Message-ID: <20251224193213.802246-6-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251224193213.802246-1-george.mccollister@konsulko.com>
References: <20251224193213.802246-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 20:37:54 +0100
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

TI's J722S SoC has one instance of PCIe namely PCIe0 which is a Gen3
single lane PCIe controller. Add support for the "ti,j722s-pcie-host"
compatible specific to J722S SoC.

Based on:
https://lore.kernel.org/all/20240524092349.158443-1-s-vadapalli@ti.com/

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
---

 drivers/pci/pcie_cdns_ti.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index ff56ba3930c6..38804f1c09c7 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -855,6 +855,11 @@ static const struct pcie_cdns_ti_data am64_pcie_rc_data = {
 	.max_lanes = 1,
 };
 
+static const struct pcie_cdns_ti_data j722s_pcie_rc_data = {
+	.mode = PCIE_MODE_RC,
+	.max_lanes = 1,
+};
+
 static const struct udevice_id pcie_cdns_ti_ids[] = {
 	{
 		.compatible = "ti,j7200-pcie-host",
@@ -864,6 +869,10 @@ static const struct udevice_id pcie_cdns_ti_ids[] = {
 		.compatible = "ti,am64-pcie-host",
 		.data = (ulong)&am64_pcie_rc_data,
 	},
+	{
+		.compatible = "ti,j722s-pcie-host",
+		.data = (ulong)&j722s_pcie_rc_data,
+	},
 	{},
 };
 
-- 
2.51.2


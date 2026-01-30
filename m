Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24638E6BF20
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 15:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E39844C0;
	Fri, 30 Jan 2026 16:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r5qm7NdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50C583C30; Fri, 30 Jan 2026 16:39:37 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A2283C30
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 16:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1634694fac.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769787573; x=1770392373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2y55Ozop1jlTMFLCZGpRhEwWf7BsApz3F7/gmMn4CJE=;
 b=r5qm7NdOvvOaSwEXm5dPxYTfpd1tSJWQb5QKzL+F9zIXYEBKbGtv7SqTll3+bhJ5gE
 m6LOEnRCqD+oyAP6dQK+fOB3RWS0BYeaf9T0/DsDV+iApQapxqhEit/9QskHEDbqzX8o
 eYZy5a/BpuspYFkMMAz+UHEmcBkichlX48PbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787573; x=1770392373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2y55Ozop1jlTMFLCZGpRhEwWf7BsApz3F7/gmMn4CJE=;
 b=v7lSihBeW/ey4EuCLu6BZi0eu6755XcHI1HHlExS2TAmLv0ovPvABLJ01KqrlS0qaz
 Buro5ijmLoxXweCNT86mgc8JN26CgzosU7vrbZ8cb32J+6tWcAey8g3mI3fiVPbKXv7J
 I6dKXwiV6RNb5OBvkIvD9+3zx9VdiUcrdLjn2eBZnXyRNNjp7nGykIsEURi/nmVC06ys
 9WyjliKBUP7Iv5Hi8nQwM0cv1CR5XvEIzJcQb1Wc5nMpfA3lMJherKBanDg7vUdnx+Fd
 OGtZxQ6MqmUaDHtJeKNmp+ZtGH0Zatgr5UIoWpTMVLxEkw0uDIbmPwLZG54Ofuc74YDv
 ltcA==
X-Gm-Message-State: AOJu0YyJx9Ise7XQr6qV7ZK/EoP6FgrouCcnGLU2SMIHa3G0oImWHZmR
 ztyyJASI9pT2MLj9B+Adnia8n7cTRpYROjcdTAweKKlECpNiWLcdRo3WNfD8gJhD4amAtu+CpBt
 ANOyL
X-Gm-Gg: AZuq6aLGvMbV2Cu4+1jEyzyPMdJ5Hutn3Sx0j4pwC/sA04EPeJImjPh9sPu3T0ZaU1F
 hmkxjEXi2BAkLhZmuw6fAIsTPzKK4VhBtx615wBnxNtmXAqIU8RBtGd7ML96StuaNJwVc803MXP
 WdyoELjFxAQ5AZ+9RYCisXvJ13jsGPdjo1pY4wYB22yPBHX44pRLYUmlvhuHnpiKK/JWNNMKHv4
 FL2goFx2Murlg6NgpoA2AS1sZ4XfJZGVS7kumbXCbZD911eNCQPPAl2LN6RYh/2LN2i3ukPXDWd
 t/N/Hq82AOUXjWFZKB5JgFdNKEg8dxM5DpSgUjC6BAMDimVIqQscB/Y5r3L1VIW+/Ul+QOGJvKp
 Sm2ASUmXnTOoWPPiCD362u3YYurm9ZfCuQdPQaYK5ZBVkxbAUrkxx+O8crCpBh5X9s0lbsoTDIf
 dCf83MsrldgCCuGnNphJIrPgGroS1JNeLPOuQ=
X-Received: by 2002:a05:6870:d69f:b0:404:3f2b:fc99 with SMTP id
 586e51a60fabf-4097fd69ef4mr3672330fac.18.1769787573597; 
 Fri, 30 Jan 2026 07:39:33 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm5944934fac.16.2026.01.30.07.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:39:33 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/6] pci: skip unnecessary PCIe scanning
Date: Fri, 30 Jan 2026 09:38:01 -0600
Message-ID: <20260130153856.2049575-2-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153856.2049575-1-george.mccollister@konsulko.com>
References: <20260130153856.2049575-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 16:40:08 +0100
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

Use the same mechanism as the Linux kernel to skip unnecessary (and in
the case of the J722S, errant) scanning of direct children of root
ports, downstream ports or bridges.

Based on Linux PCI code in the following files as of b927546677c8:
  drivers/pci/probe.c
  drivers/pci/pci.h
  include/linux/pci.h

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
Tested-by: Bryan Brattlof <bb@ti.com>
---

Changes in v2:
- Return 0 if dev_get_parent_plat(dev) is invalid.

 drivers/pci/pci-uclass.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index c370f8c6400d..83b76d01f24a 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -872,6 +872,38 @@ __weak extern void board_pci_fixup_dev(struct udevice *bus, struct udevice *dev)
 {
 }
 
+static int only_one_child(struct udevice *bus)
+{
+	int pos;
+
+	if (!dev_get_parent_plat(bus))
+		return 0;
+
+	/*
+	 * A PCIe Downstream Port normally leads to a Link with only Device
+	 * 0 on it (PCIe spec r3.1, sec 7.3.1).  As an optimization, scan
+	 * only for Device 0 in that situation.
+	 */
+	pos = dm_pci_find_capability(bus, PCI_CAP_ID_EXP);
+	if (pos) {
+		ulong reg;
+		ulong pcie_type;
+
+		dm_pci_read_config(bus, pos + PCI_EXP_FLAGS,
+				   &reg, PCI_SIZE_16);
+
+		pcie_type = (reg & PCI_EXP_FLAGS_TYPE) >> 4;
+
+		if (pcie_type == PCI_EXP_TYPE_ROOT_PORT ||
+		    pcie_type == PCI_EXP_TYPE_DOWNSTREAM ||
+		    pcie_type == PCI_EXP_TYPE_PCIE_BRIDGE) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 int pci_bind_bus_devices(struct udevice *bus)
 {
 	ulong vendor, device;
@@ -895,6 +927,9 @@ int pci_bind_bus_devices(struct udevice *bus)
 		if (PCI_FUNC(bdf) && !found_multi)
 			continue;
 
+		if (only_one_child(bus) && (PCI_MASK_BUS(bdf) > 0))
+			continue;
+
 		/* Check only the first access, we don't expect problems */
 		ret = pci_bus_read_config(bus, bdf, PCI_VENDOR_ID, &vendor,
 					  PCI_SIZE_16);
-- 
2.52.0


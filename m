Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DEEE7848C
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9D3842FC;
	Wed, 24 Dec 2025 20:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RTm2e3ib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2203584301; Wed, 24 Dec 2025 20:32:31 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E2E842C2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4503ee5c160so3654581b6e.1
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604746; x=1767209546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVRX5BzEPwGLDpCl/EoTPMMZ1uHTfBFHcmXhYtc7Fqg=;
 b=RTm2e3ibM19pvdj5QB03zYygbySVSZqw24ZW1hLCfYc1AQ/MjAfdwlN5gYsdgXM4+K
 Kt0TYavOHW81tnRQEtYS3o2Vt90A7nvcc3zeIQalGxViQ505tQUgzHleP60mXJmOx0M3
 Gu7n9MsKbPaZfD4nuDkZX8MRtGeSFHPZkFKnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604746; x=1767209546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eVRX5BzEPwGLDpCl/EoTPMMZ1uHTfBFHcmXhYtc7Fqg=;
 b=pqUftbq5QX9pPtZ2IEw7xvz4fIMHjlAZKpymt56BlAdDspHYv08SMOGMft2OMBz8f7
 YE9MeyraOW7pnxsZ67+jmOqqJo1rCVnUabCAT/6ja1DXgPEmidYx3xY1W4jfdXQP26a7
 vzlnQgCxMG5HjGPvlESsho1rWQCONrSGX/MhJdl/tmpPDxuGlmOr9wcdiLnh5X6IHWxC
 RllUDBpx2/xzIatV7fT+bQxzjx9rZWpZkEvhF+osCQ2jACOxkPWnpI21lV6a5Jg8RcS6
 lIHaYrvifGCWorPsO0uPe9/Lpaa4SMZRO3UF5rUvPiFA12kLv2RMPrRWQc21oK/ewzVO
 iYBg==
X-Gm-Message-State: AOJu0Yx8ti4F3CUbC1DuYggDdK5BAri2iUaPRbb47ItdQYN1c0cBwmJo
 M3lzZCXqotNaEh/iG5NDN3wJouQZWGU/nlIyTVERGJmNwf6BEyA1NFLDiApS0+1b/adkU0fzULG
 kWkYnhc8=
X-Gm-Gg: AY/fxX5Nzk1Rr8xmLa6jcpZLlf/CrDIVfwaQyh4dXhqMtOKYu43EulymrBCBPfTR0V/
 OJt6WJLDvWduNlYLn+WFMnVQhnrpQWTuNhatFfWwBz/XSy7mADM//IMhY3x7vBkDrek/n/HhZhw
 yxJOSMUjCxKLx150PfbW7qzogUy4cXXcovhHIUtMbZ1TzoBaDVDYZk1AppkS2b7/IJFWHU9kBMu
 yKNtYQllC8wE+GaQwF6Q1BwvZK5o3K6LXgwhOn3nmXWsGF2s22LcuOYpAicc8WxB0N/+4lhHRil
 iU1OibTvCaCF2JnvGejfl1z+GryOXXHUZJjonT/S7oaiR7xxYKCWyLNbpf/3yrDtUzvHleOlYlJ
 wlhTZr45z+MvkpVpg6GRm+gVZzJX0oy6q+d+R5lDd9Gm52ZeMtHpmXE4gJzatjqRFsmA4Vb2M66
 i9CZdKHEAGTF2cLLAGw/EdZXCoh+VPjDhQ520=
X-Google-Smtp-Source: AGHT+IH3BpwpGgJuN/xqbO0wAHphwRSCqvV6vH2kVH9wJsMwp50b7urm0lBBB8RDQj/ULmX8P7t1zw==
X-Received: by 2002:a05:6808:6f8c:b0:455:7fe4:b215 with SMTP id
 5614622812f47-457b21d3073mr9388262b6e.53.1766604746423; 
 Wed, 24 Dec 2025 11:32:26 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:26 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] pci: skip unnecessary PCIe scanning
Date: Wed, 24 Dec 2025 13:31:59 -0600
Message-ID: <20251224193213.802246-2-george.mccollister@konsulko.com>
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

Use the same mechanism as the Linux kernel to skip unnecessary (and in
the case of the J722S, errant) scanning of direct children of root
ports, downstream ports or bridges.

Based on Linux PCI code in the following files as of b927546677c8:
  drivers/pci/probe.c
  drivers/pci/pci.h
  include/linux/pci.h

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
---

 drivers/pci/pci-uclass.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index c370f8c6400d..8a1fb76b365c 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -872,6 +872,35 @@ __weak extern void board_pci_fixup_dev(struct udevice *bus, struct udevice *dev)
 {
 }
 
+static int only_one_child(struct udevice *bus)
+{
+	int pos;
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
@@ -895,6 +924,9 @@ int pci_bind_bus_devices(struct udevice *bus)
 		if (PCI_FUNC(bdf) && !found_multi)
 			continue;
 
+		if (only_one_child(bus) && (PCI_MASK_BUS(bdf) > 0))
+			continue;
+
 		/* Check only the first access, we don't expect problems */
 		ret = pci_bus_read_config(bus, bdf, PCI_VENDOR_ID, &vendor,
 					  PCI_SIZE_16);
-- 
2.51.2


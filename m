Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64F4E7848A
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF90842B7;
	Wed, 24 Dec 2025 20:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Od3WS78p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25ECD842B6; Wed, 24 Dec 2025 20:32:29 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C28A8842B6
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6d13986f8so5110693a34.0
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604745; x=1767209545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/GQi83yd3HbUhmGBn6/dxm+KMLJCRlVMDmRJ8c54xqg=;
 b=Od3WS78pp9dizFDIuV7wNnwXiEHbzNzmTafz3hsCBXF7Xe7Z9uguc31nx2u8ylJfdW
 Kv2/IOcN8dIZySwGiuiOxDx2SLOYI5nUvlNN1yfcKY1sBHNOqVCw3snmgaTJzH2yUvBX
 d8hUsnbIFKaV9a3zolX6KAGH/o0qgZP+Mh9ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604745; x=1767209545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/GQi83yd3HbUhmGBn6/dxm+KMLJCRlVMDmRJ8c54xqg=;
 b=f/k4X/uXZT0BHgIoRD/3wAvXnDujkdDD3PjlQIYV8bLZ1nx7XzL7DCe6nIIJxRms+o
 Nprf3pnqisI0PsXHBkuPQmUXWAyhYQ+20upSxpUVJQK5Nysm3KpozXhyQ0rJ/QaBqMYs
 O6aT5S/H++gZOesKe5XIplDaHhp6sArfH06iQBUQbrUXsAkFoHw9LzRUY0m707O0NGlZ
 MGXTvRgn3Uf/RJiAjMgoqhvLAu74oDEjMtVGwQe8D7h0lNryIXILf4vU0Lpf3TwEeRHH
 1Igo2bHJcW7ZzmTbuAbesjdKavN5BSvk7FJXxP5rGnv3GLrxLuvfXYO9tyfosA82y8Lb
 AADg==
X-Gm-Message-State: AOJu0Ywh746jBrINPzmPh78Nfb2RZiyeVocmr9vVhLbVwG+3x4ugiKlJ
 +gI4Mf027OOrgIflQ/kHBjkQaRX56G4P1lC/hOhkoOmt2zB189EnGxIrI91F/9srupLDtl+z0xl
 xJ6Eo+HQ=
X-Gm-Gg: AY/fxX4BQHOcKOVL5OFjH+T/dF+zaAZGuSX31dmtqBCQRLzCpkxqLWKlHO+yJY3nT3X
 iRJeWPFM7pTNzDAKrlZ719dnCG1sF3qUFpjsY9SprfJG5ntp+MUfXygvTzsPbcN7vWQXSOsJ98m
 cZh5x/jVnYt6dbxQOxpQ0w1/9MDn9pD5vIJEQKNFfStyfATRrMPlc07C3S9EqlrpQp8Se0ZsyWV
 /FeHCKt9m56S5C0NVgQmz24UiXHdtpcRn6zDFGCh0QjUc1b+tt9/0Tffg4vDkc0VD7k29JKouAx
 +yrfyx2XtqNeRHVFmnfHbTS6M99zBBBSAjUzA2KyAk6UsBj6/StGntdKWHVS4HHOlvmtiAXGL7H
 dx+dnrqH52Wsp/TA4DJWlEJqsHuDsfcXfq/5rHJf+2ILVPBunauNfZJqenfjvavmlngN44cMD/X
 Ntvvmybzx53bD28x0nC7WerdlwQm9DkUuOTF8=
X-Google-Smtp-Source: AGHT+IGf5j1WxjAGQi5HaR8tQICTOR3FOAxBDgZ1YUd0KVJPULIH4uFzDIPPWjN+Su+IswJU3gsE7g==
X-Received: by 2002:a05:6830:6e12:b0:7c7:ad8:68b3 with SMTP id
 46e09a7af769-7cc592a5296mr11057901a34.14.1766604745179; 
 Wed, 24 Dec 2025 11:32:25 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:24 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Judith Mendez <jm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH 0/6] arm: k3: j722s: add PCIe support
Date: Wed, 24 Dec 2025 13:31:58 -0600
Message-ID: <20251224193213.802246-1-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.51.2
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

This patch series brings over several changes from Linux that are required to get PCIe working on the j722s and also enables PCIe in j722s_evm_a53_defconfig. This allows Linux to be booted from an NVMe drive.

The J722S SoC provides pcie0 (using pcie_cdns_ti) thru serdes1 (using phy-cadence-torrent)
thru serdes_wiz1 (using phy-j721e-wiz). Changes to the three drivers needed to be ported from Linux to enable the REFCLK output which is used with this SoC. These changes should be tested on other platforms using these drivers by those with the hardware available to make sure no problems were introduced.

The PCIe controller in this SoC relies on the code performing the PCI scan not scanning devices which cannot exist. In Linux this is implemented as only_one_child() in probe.c. If this mechanism is not used, PCI config reads for subsequent functions will return information for device 0 resulting in U-Boot detecting 32 devices when only 1 is present. This change should be tested on other platforms with PCI to ensure the same PCI devices are enumerated before and after the patch is applied.

I would like to thank Opto 22 for sponsoring the initial development and anyone that is able to contribute to testing of patches.


George McCollister (6):
  pci: skip unnecessary PCIe scanning
  phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
  phy: cadence-torrent: Add support to drive refclk out
  pci: pcie_cdns_ti: Add support to provide refclk to PCIe connector
  pci: pcie_cdns_ti: Add PCIe support for J722S SoC
  configs: j722s_evm_a53_defconfig: enable PCIe

 configs/j722s_evm_a53_defconfig           |   8 ++
 drivers/pci/pci-uclass.c                  |  32 +++++
 drivers/pci/pcie_cdns_ti.c                |  23 +++
 drivers/phy/cadence/phy-cadence-torrent.c | 168 ++++++++++++++++++++++
 drivers/phy/ti/phy-j721e-wiz.c            |  46 ++++++
 5 files changed, 277 insertions(+)

-- 
2.51.2

base-commit: baf076aeb32dcdd2b022405088c3288ffc160fcf
branch: j722s-pcie-next

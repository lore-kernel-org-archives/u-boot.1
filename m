Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F32E74AD1
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 20:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE2E895BD;
	Tue,  3 Dec 2024 21:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IX0rsuoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D11895F3; Tue,  3 Dec 2024 21:40:44 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D49893DB
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 21:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 107EA5C6BA3;
 Tue,  3 Dec 2024 20:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2B9C4CEDA;
 Tue,  3 Dec 2024 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733258440;
 bh=VnR/zH8juEPOQQL6w7b9ELbb+e1lBNzMh6ZdMU77Mro=;
 h=From:Date:Subject:To:Cc:From;
 b=IX0rsuoydBMgabAK5toH+gmCONxIV5fK7EHpmzosvUTHOr24ylbFxFqvjbhrDnuH/
 baa+jqVmTYKDRRmX34p6iFH0utWR/koBNgbsNhGZqlUSucJkxzth8eht7pWAiSx0A2
 n/6Fv/bXll1vTFcwLqrxeOfKZNOH0T9FSLdUlUNV77B7+FeFUDEuBE2djU+aZvmsp9
 j6n4o6VNI3b/6t7ZAisCgH5yNcHRzSRGEplEReGIm2pvTgw2gHkHSdLw9PLuL7wYvg
 KLM4z6kjUUHQgFOdLGg6/b5vNBkRNWFpCTxtHJhRZpUiyvqBc/1BnTW0M0myRrObQz
 ujnvBqsBZelLA==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 03 Dec 2024 22:40:29 +0200
Subject: [PATCH] configs: am62x_evm_*: Fix USB DFU configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-am62-usb-xhci-v1-1-a791cb914186@kernel.org>
X-B4-Tracking: v=1; b=H4sIALxsT2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNj3cRcMyPd0uIk3YqM5EzdpFQzo6RkS1MLk2RLJaCegqLUtMwKsHn
 RsbW1AIN1BEBfAAAA
To: Tom Rini <trini@konsulko.com>, Martyn Welch <martyn.welch@collabora.com>, 
 Sjoerd Simons <sjoerd@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, marex@denx.de, 
 vigneshr@ti.com, nm@ti.com, j-humphreys@ti.com
Cc: s-vadapalli@ti.com, srk@ti.com, u-boot@lists.denx.de, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=VnR/zH8juEPOQQL6w7b9ELbb+e1lBNzMh6ZdMU77Mro=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnT2zFCMh/tvWcSpageKJHK4WHnatIr9Y+Tc8VR
 0WyuxHjQ1aJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ09sxQAKCRDSWmvTvnYw
 k8A8EACgyUUuH6iir2a8NAZ6VjKyDLO5zHBwyuWNaGlu9bYG9S8mgCKl5T3sx1YNmWIjY9oeCV7
 lgDJnKuOv1AKmM8BvfWDn37ueaGSK7EH5QIt3HkikxQNYfKAV3/9WeoeAPNMFitPv1jOVPgLRit
 iit0iNQA6C3Y32gmOQoPHjavT5VjlmWn/uk0hCvF4YXVpCHjYdyh3jlvTrRRLyuc2uSQL7+uCOG
 YdBHBbfqiaZBm4B/q8Y21m14gKi8BZV3e8KJDZ8UfskitktOBHYijaG/AZDB8sfVeA0KsxxPmZF
 pifM80ClQFl5wFm5yzLSH146So8J0P/Z4xfPyrPesXBiBxGsNofxv2LG9w2aBvffChpV1GdS+QU
 jV1uGtpFxGSkQK54wndz6A7ch3hfu4aD3HIi1KgnmpB8w2L2tbWGoeAVwvOgixN74hlDGZj201v
 mnxBPssYhst21UC9J7ARPB1aktgu6eMnHMqw2KJ78p8KI+PA1YEvonX0Fu9MDR+lPkbKPowoC+i
 vf+AcJXyxk7WaUT7vmVveWjAF8uXNyZdeMuX35QzfwlMJZFuZX0FfgKyB3z9k99XFHSgfs46lI4
 l/qaBCbxamDo7vJiNrWMgG/BEcuzEkf+OFUnq1Mev2sh85xN0SRRnIkYaQ8bbHpnbJconslvsVn
 /6fTpFJ8kCu5QeA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

CONFIG_USB_XHCI_DWC3 is not required for AM62x as the XHCI
driver is registered through the dwc3-generic driver.

CONFIG_USB_XHCI_DWC3 causes problems by hijacking the
USB controller even if it is not set for Host mode in
device tree.

'dm tree' output after 'usb start' is fixed from

 simple_bus    5  [ + ]   dwc3-am62             |   |-- dwc3-usb@f900000
 usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   |-- usb@31000000
 usb           0  [ + ]   xhci-dwc3             |   |   `-- usb@31000000
 usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
 simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
 usb           1  [ + ]   dwc3-generic-host     |   |   |-- usb@31100000
 usb_hub       1  [ + ]   usb_hub               |   |   |   `-- usb_hub
 usb           1  [ + ]   xhci-dwc3             |   |   `-- usb@31100000
 usb_hub       2  [ + ]   usb_hub               |   |       `-- usb_hub

[notice that 'xhci-dwc3' and 'usb_hub' drivers are probed
 for both USB instances although the first instance
 is supposed to be 'peripheral' only]

to

 simple_bus    5  [   ]   dwc3-am62             |   |-- dwc3-usb@f900000
 usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   `-- usb@31000000
 simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
 usb           1  [ + ]   dwc3-generic-host     |   |   `-- usb@31100000
 usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub

Fixes: dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 configs/am62x_a53_usbdfu.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
index 3a19cf23287..0d3c6df1e73 100644
--- a/configs/am62x_a53_usbdfu.config
+++ b/configs/am62x_a53_usbdfu.config
@@ -16,7 +16,6 @@ CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_SPL_USB_DWC3_GENERIC=y

---
base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
change-id: 20241203-am62-usb-xhci-be62bc9584c9

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


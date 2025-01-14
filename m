Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE4C02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E583806D4;
	Tue, 14 Jan 2025 18:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="a4LPfbbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D54806D4; Tue, 14 Jan 2025 17:47:13 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30AF8007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736873228; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bpU6jgyPE1gg+e71YIeT02tFGHmK5vI6oYxXk0V3sV/PyI7HU8NAeFrL6jtyoAQJzctHcew/iEt1agi3Bt7rsdhAwd+G2bzI4OVR9jzYU6TKggV4mT5eZU+sJvtC8r+1I0rfeMQ0Zobs85zYPc/PiVjEcAzFpRypX4Xx9Vmb6F0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736873228;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nkMn8YAVfNdxODsm1ETWZImcHqgWjrsnjQQzBiAFAZU=; 
 b=Y/FVB6LNkTQXSQu9+XTwcEMHGP+ZEASM28mLVukYz5HaxOy3vUh75nO6k49ZQCYyz5nSX6n6g+fR/1+ehoSEFUsFDe2DplTHjCpB33Nz5LKFybTLEKRuSmr0VSHXzB1//rlC8G3VEex31diQ7FtMln5RXw0v4VO9WRGGoud3AZA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736873228; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=nkMn8YAVfNdxODsm1ETWZImcHqgWjrsnjQQzBiAFAZU=;
 b=a4LPfbbvKin7oFJsSn63cOEJToYMi5VSCuCBv1/tqOoDnNK6yZtY9kUyFujtqtpV
 ZtFpHuBYAogjdHKLzC7F2iSKhX/MrncYa08CMRN8PevhVeNf/Iw8c4wLN7MJHknacH/
 OEBlI8oVycnoF+pYDN676HGm2IO9jibJtqR3eK2E=
Received: by mx.zohomail.com with SMTPS id 1736873226403700.6859339816145;
 Tue, 14 Jan 2025 08:47:06 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 15 Jan 2025 00:46:37 +0800
Subject: [PATCH 1/5] usb: dwc2: Add support for Canaan K230
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-k230-dev-1-v1-1-f4b77259e34a@pigmoral.tech>
References: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
In-Reply-To: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736873211; l=1350;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=p2v0GLeOWKnEzxxK8wGasqWnMkdCHouD1U28LQgN0jw=;
 b=5XlbVm0WTLOuZ5OFdgWIxT+ahYLAa2CWWsfy7i+c6SeutkfFzJElVGowPf59ZP0IawZzvpEQD
 gVres7URo/5BgSpWglqc2MgdbLjT9eJSi5BZSZOMGAP4bLWOT3JL3Ek
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 14 Jan 2025 18:26:11 +0100
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

Canaan Kendryte K230 SoC instantiates a dwc2 v4.30a core. This patch
adds the compatible for it.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

---
The USB function on K230 currently relies on patch [1], which updates
the core reset flow of dwc2 in version 4.20a and newer. However, the USB
PHY drivers is not supported for now, and that will be a separate patch.

[1] https://lore.kernel.org/u-boot/20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech
---
 doc/device-tree-bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/device-tree-bindings/usb/dwc2.txt b/doc/device-tree-bindings/usb/dwc2.txt
index 7a533f6593435a9ac23833584cdd0adc14690d14..9a87202d4b9e5f4ac829c8d9e4b7ba4a1583965e 100644
--- a/doc/device-tree-bindings/usb/dwc2.txt
+++ b/doc/device-tree-bindings/usb/dwc2.txt
@@ -4,6 +4,7 @@ Platform DesignWare HS OTG USB 2.0 controller
 Required properties:
 - compatible : One of:
   - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
+  - canaan,k230-otg: The DWC2 USB controller instance in the K230 SoC.
   - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
   - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
   - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;

-- 
2.47.1


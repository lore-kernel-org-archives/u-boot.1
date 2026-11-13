Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F7606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KjKDv3h1;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VEOWO4zK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C4D860634;
	Fri, 13 Nov 2026 15:26:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b5i0jK4I99sX; Fri, 13 Nov 2026 15:26:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4CEDE605F4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794583563;
	b=BYKwQumri9SZ9xhOxOCoyFQEHF+ZpyTJqp3vb9gt2HGg/d726LR7Rjb4LSUE8T4gjQqI
	 XgOZa9OfibkooCPOjBWG9CamIN58tpk/KZkY/eek2hfXJIFiQJLf35fVsjWRS+tCtI+40
	 FbjyE6YEAwgNFALF2MW6Gjt4npd3NkrJL74Yl0M79RbnhbFhVwOHx0XZWcplSKqpqbumt
	 JNWNOnP8NMwuZ3LZZxOKP6DvWoGX4j5qzNAmxOX4Qk3vxULDHGVZB/ZOLb8IL1Xiu5pWo
	 As0Jl1MHRw3JZxnu1yePtApjPLjTQDnvfVts2J4R8OZGWvYzENUDvbjdH7bcUFA21+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794583563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=062xYmUtf5CABsiIpY3DEFPzHRGBErLg0BVSRLGWaFM=;
	b=FUYKiItlHg05BmRLwM3l5frY5OXs14hykH7ipR4LA4D7JbQIBzIcvDyoclPHlPgWzS3U
	 +AqPCeVs/ahhfhB7KKeRKrNzTP02Tpf4zExI25x1Rb5rIqjBt+hzc2rGJ+wnSgJjb4r1T
	 y/ISy/LOC25xDCmzCapPRA64MXvnkW2Yns82ahINvw04KlE/QcxTTUaG0OGPogsbjDxFs
	 WaYZ31AmNN0OBLqqsbKe2qfrguM14cZMIiZZk7Isg8fSe/Q9v5fc7uSY0EeVx92YY82xN
	 JQaPk9AdkamJfGVt/vPw1BFsMCqR33UGLZzwvYA0YaImZa9Ohsmf0pZqDXuefLF0j3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794583563;
	bh=062xYmUtf5CABsiIpY3DEFPzHRGBErLg0BVSRLGWaFM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KjKDv3h1xu+QPI/U65dDjIGCL/0p2seNQRWZdEzZ6dY71B5riW7qXj1ObbC+b8bc7
	 T12GRlgE1rH3Obc3GlmYV8J4GG8BoHSIjOCGNxPVJAH4w8MgqVdDH+gKrRQZgpc7M6
	 FYWjUKFWgDIeLX7DS7ue/XCVjaMlR8N/Kbq53EFTEKE9xBG2HowkRUlSyCXV+5mHz2
	 8n6U2iSvbPHwu0ULOa6zN6fQNUNnZLrE6s2ZMDmLVeq3TZTlCkea2uj5P1xakiZV0Q
	 kC2isjR5FmVjqlvz1LKI62a79a01ZsGfaseh2Z9sA/yu/Zki2AGva/jp5l+gy2TmeT
	 Gc34klsxeAdUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CEDE605F4;
	Fri, 13 Nov 2026 15:26:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5D6928C
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABA7581163
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fo8Bsh0tPG0w for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:26:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 68AFA8112A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VEOWO4zK
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68AFA8112A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:25:59 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so8723915e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 07:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794583558; x=1795188358;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=062xYmUtf5CABsiIpY3DEFPzHRGBErLg0BVSRLGWaFM=;
 b=VEOWO4zKUG3SeILAgHk8hXb8ctaClC0GcBaS5ATnWA+o3hi9n8ntDpDxKBr5NtMJ8K
 JwimTaPbEjIbZSqwSC4NUUUzfohyHTMhvnXYoqRyn+JJPoRAgrp7u1zDag0JwZU+s/As
 ucZakS1KwsXukR3Y/RKEb3bWCGo/f0MucMERgDaxWWgUg9+1OHFi7eGcWsnhVm28/Npd
 pvL6PjKHguXrambBk1oxeqy3Mlqwik1vIqaLUWmM+afqppF/Axgv3tCqo2kOgQCSFKVI
 /U8ObGkGOR1J5D/5/iXRDpvlovelYzez7b2aE47k7tDBVPKFvATabAbfzjjKBmooP4b9
 IpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794583558; x=1795188358;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=062xYmUtf5CABsiIpY3DEFPzHRGBErLg0BVSRLGWaFM=;
 b=s6JRoBcumsUPo735XvRcP5trwGpGHwII7thyrjQyFKrTOMzxyQSoihEHmdByzyvmYO
 4OwD1v2U0IkYewDQ46k1yh5nQrxb701HouIEFhuCNs3wDgkh79NZg2skcDaZ5YiD1GkJ
 /vRaGyEeKT89Xp2JpL1LFMisgDhplBexOY1tGXh+qdNlu7EAGKic7cCDbAS2YnX+FKlf
 BvXcEeq2loXEZoFjUzK2QzrewSfnw30CMQi9V5ov5l6Mr6ETCGPgIUKtfr37tyk9VrS7
 1RArSPhV5vDMX8ZD2roa/T0dk5r2Wknt6J4AwiqlB0qXsosZd7iA1TaAnoxjap1NUjbm
 Gmbw==
X-Forwarded-Encrypted: i=1;
 AL+hErFsRI9USCktm2fUhYvFLYY++m59rGZsuRx0D6RCo4IZ9NitVwe7idkFE1mMqPZzpjs84KaXEJc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+p/uHTIvhPO58j3d+K/jduNz42e0qseAuSwYp2BN+GvEqMJ5YY
 o5gD8fEApRfwwxOFFhuAoA9BmNk1NwzN5aUiUTmCrA8AivyUynCmpzhS+t3wS3jaN6s=
X-Gm-Gg: AYBFou1FrLkzU4nAUulUmRBC1XnOPpNvWdu3Ydw39Os8cCjxBh/Fl+FXGBIR2y5lMbQ
 1pTKqt+MGOHKrZpvKffhQ5bcnHeXyk2hi5DeQIRsYu+klLLblgHZhQGZlmvjJGEqXdcas4IAW/w
 IJNsWPLQxpYq4XSD/TzZfBoARAlJESBraXZJ05Rz6F682U+sEku3qFpL+muELkYxCdkiSb5dgPj
 oHUN/bPHXJ4ygJFPQmL1NVXUwugGDJQeXcBSKn7QVte7WShs48WC6LQWsXnMKZyu9Nkyix61KmK
 kFEmtM0Vna0WXsoZhml992wFinr0fZie4lP//a1KgFXws7l1MWGRoDL27KhXVrAfWoF+0Cgzgdd
 bUjOUyav6aqXoggAs6dXoIaPuTG1IA06vPQnBAmnp/rDd8wNvQiy56RKLFx8XINscUTHp/6fAjj
 7TKu/Qnrn3fwHAyyhuw3FHppPhOI2SXd0a3sQoWEhgVavtd8txwio2iKUB3r3pJgbjCNH7DAK3E
 AXFSbMmyr+mGZ34NQdDr++WHVTLQb2uSy0LtpDB8rme8sxLNn0IoBMCZ1dX9eutTs2zWG2iip9V
 M6DXYf4Jjnj2z/oaD8NZodpsH/JWAdsCUm1b7hh3al5PQI8fOzMDjaYtxxL4hhLoNR2BTqvuanv
 e30IjwazMz/9JCDh5UG/7VD/7USXoCfp7GfBVrVpKHxcVpQ==
X-Received: by 2002:a05:600c:548b:b0:4a2:1364:252b with SMTP id
 5b1f17b1804b1-4bb55ab07c6mr60598905e9.35.1794583557287; 
 Fri, 13 Nov 2026 07:25:57 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ace535sm70042255e9.6.2026.11.13.07.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:25:56 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v3 0/5] Enable USB host support on the Genio 510 and 700 EVKs
Date: Fri, 13 Nov 2026 16:25:36 +0100
Message-Id: <20261113-ccaione-upstream-mtk-g700-usb-v3-0-78b554604bbb@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43OzQ6CMBAE4FcxPbtmaYGiJ9/DeGjLAlX5SQtEQ
 nh3Cx5MvOhxksk3MzNPzpJnp93MHI3W27YJQex3zFSqKQlsHjLjyNMI+RGMUaFCMHS+d6RqqPs
 7lBIRBq9BCp5KLBCNilkwOkeFfW7+5frOftA3Mv2Kro3K+r5103ZgjNbev1tjBAipxjxXPNEks
 rNW08NqRwfT1mydG/kHjDD+BfIA6iw3aaJjKaT4ApdleQE1tVHQMAEAAA==
X-Change-ID: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the USB-C PD host port on the MediaTek Genio 510 and 700 EVKs
using the existing MTU3, xHCI and T-PHY drivers. Both boards share the
same USB controller, PHY, onboard hub and connector wiring.

Two supporting changes are needed before enabling the boards: the PMIC
wrapper must recognize fallback compatible strings, and the onboard-hub
driver must initialize the TI TUSB8020B hub's power and reset controls.
The remaining patches provide fixed-host settings in the shared U-Boot
device tree and enable the required drivers in the MT8188 configuration
fragment used by both boards.

This enables the USB-C PD port for normal boot. USB0 remains enabled as
a peripheral in download-agent builds; the USB2 M.2/header controller
remains disabled.

---
Changes in v3:
- Rebase the complete series onto mediatek-staging at 60f6d41e23ad,
  immediately before the V2 patches were applied.
- Correct the reversed TUSB8020B speed comments in a standalone fix.
- Explicitly enable USB0 in the download-agent override for both DAs.
- Drop CONFIG_USB_XHCI_MTK; the host controller is handled by MTU3.
- Select USB1 DRVVBUS on GPIO87 instead of driving VBUS as a GPIO.
- Link to v2: https://patch.msgid.link/20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com

Changes in v2:
- Remove the redundant PMIC compatible-property lookup and pmic_name.
- Update the MT6366 comment to retain only the regulator-support caveat.
- Drop CONFIG_USB_MTU3_HOST, which is already selected by default.
- Link to v1: https://patch.msgid.link/20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com

---
Carlo Caione (5):
      power: pmic: mtk-pwrap: honor fallback compatible strings
      usb: onboard-hub: add TI TUSB8020B power and reset support
      usb: onboard-hub: fix the TUSB8020B speed comments
      arm: dts: mediatek: configure Genio 510 and 700 USB-C hosts
      configs: mt8188: enable USB host support

 arch/arm/dts/mt8370-genio-da-u-boot.dtsi     |  1 +
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 20 ++++++++++++++++++++
 common/usb_onboard_hub.c                     | 12 ++++++++++++
 configs/mt8188.config                        | 13 +++++++++++++
 drivers/power/pmic/mtk-pwrap.c               | 14 +++-----------
 5 files changed, 49 insertions(+), 11 deletions(-)
---
base-commit: 60f6d41e23adb1fd52a3d0e9c9423803bf07e4e6
change-id: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


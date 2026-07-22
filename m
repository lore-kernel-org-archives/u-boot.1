Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4A7C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9599608C3;
	Wed, 22 Jul 2026 21:44:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kR5OMc-DJaHK; Wed, 22 Jul 2026 21:44:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CB382608BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756655;
	bh=s8maGOkvukmMMG86CyUNg/QcrZtys0gXl8LB+UrBX1M=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=UqYP5ce69kjR0qVxqw3f0XgADCQCvIPNzeCuFG/I+QQnwtEEdMvtAQPs3mHYopIHc
	 MmVCj53rH1EIb/eeLMcmny2HVZLKMwQjSxNANAOuehi2vIzuigr7vPQhVX76B+/caz
	 GIK7xIQl/u3j9ZmzZG9bK3sPh0Qz7fQTbf+uyInptX5nO0QiAIb9P/3V7IXxWM5Y7B
	 lpTOC5m1sLuR/NwmWfvdx2P7DfikHca7VWSKWz6otxWVLbNgzg0o7fxioTzj065djt
	 ShhiJvQ/mtrdc6nfCr+CeUru/xjv/mZlKyARDm/ioQXfWluwNDw22y4kzFhHo+z1C0
	 LlBqYtm4Swo+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB382608BE;
	Wed, 22 Jul 2026 21:44:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7326C3B0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 648C3407D0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4hLSV1itzPe for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:44:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::9;
 helo=mail-wm2-x09.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7432E407A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7432E407A4
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7432E407A4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:11 +0000 (UTC)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-493e55619a2so26685415e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756649; x=1785361449;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s8maGOkvukmMMG86CyUNg/QcrZtys0gXl8LB+UrBX1M=;
 b=czt1fRxHoUXWlyQ/6v6ptTpDd+7LynG5ojYrtiKSDmL9IK6UQIZkjI2103EdCWIz6C
 KGZ/JlHtzxgDdW2fmq1FxsiHqiPZZu6mxTiC8s1wc8ErJkobAYjwW38+MvbiHgQVt3X5
 JojDxMg5wSsxfUMNy8EIDApfi6+Wit1gIneNKyfxeA4XL0QUMZtCI2vQSvxbDRmhgGIq
 8Ae5xzcamVG5q24OLXADRRXwmKJ2F3r5CMdtNEktKfKe6qs+J4IwY3+47FE5nbRQbSRK
 0BvvFRYXDkZuAj6e5LozVeiP3XNos5r9TOY6j+IEdz1Q7vpF2KgjHDdDaPY/OoG5913v
 V8Fg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRxw0TySWSMk0IY5uiSmFh8yDNG/u5b0xCcFPeUORbi9CdM9n8jun1QlkSy9IvhY9HKXo7nvI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzVQ5gmBeBmMi4ANWlfhZgNi4XnZoGYi36nFlE90bMMfUw1Scto
 93N1FlHg8087NZEqqnIeriGMnUYvVd4Nehpb+vA2UiOkzGT7TP0o9gx7XGehlekWEgU=
X-Gm-Gg: AR+sD10EolzXGW+72aD++KlGMAPRwZokfWHBN0qMVrPXNEfUWUYa0jo17AjUQkZceKP
 FU8ASqChnWOxsi/x40Km/jG8i3hsXM5PcHWY5mRfEae1+8/VcWdPzDAYmS/r/TOHE9mYiFaw9By
 kMdrr4datqZittIdmhnlZN3iJwc+LCD8suHBzGlYlvjD4UY4/HXCeg3Qrci5bSTEhqUBHrhGDLn
 Xi13ILP2HORfpZPiNRpoMXfucAbF10/PQmgeCq0yTO1AiUagGeRgxUvMpaDYjjbIGtOQLKwJzsj
 5fVqCDI+E5SPFw/ie+AMEDHnBpkkUQ7RTcaUJ5LktE1z2yUKGEjQiyve9r2+GRzVebtl8dL5Yma
 C9g8VJP0rCjeQgGNhGKg5A7+xSNtbO0lBTl90sc89lGgewZOADZf9tej/2BRS0Fs8W0OetqnX/o
 cP3oRgJS/7nvyyNVzwInxMQGJNujVGCPU4UsH7F1+KGuW+WAENi3koGcfwVjU=
X-Received: by 2002:a05:600c:1989:b0:495:3f99:849c with SMTP id
 5b1f17b1804b1-49573cc7cdbmr4064995e9.15.1784756648849; 
 Wed, 22 Jul 2026 14:44:08 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a967289sm96879285e9.11.2026.07.22.14.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:44:08 -0700 (PDT)
Subject: [PATCH v4 0/2] Add support for the MTU3 upstream devicetree
 binding
Date: Wed, 22 Jul 2026 23:43:57 +0200
Message-Id: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XPQW7CMBAF0KsgrzvIHidO01XvUXUxtifBiJDId
 qIilLvXgQ2quoDll77en7mKxDFwEh+7q4i8hBTGcwnV2064A517huBLFijRyEY14ByVCsM8pRy
 ZBhjyrCFNJ+jJ95yBSHvdOvLSkCjMFLkLP7eJr+97TrM9ssubuzUOIeUxXm43LGrrvTC3KFBQN
 6QZvSS08tPS5RRs5L0bB7EtLvhovj9hYjGbzpQvKoN13f5j6gcT5ROmLmarXNdVlVUG8Y+5rus
 vodCZoI0BAAA=
X-Change-ID: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756649; x=1785361449;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s8maGOkvukmMMG86CyUNg/QcrZtys0gXl8LB+UrBX1M=;
 b=BpkmqHfT9Ag0LlMFExh2HuOSFmit4dize1rYvF3XnWbeZDKbeeNCPSmSpoywHPgEoa
 b+s7eOzhePrm/3/N5KehH0nuEIpo5kgq5iO32s3dVxu0h7OMqTLTFsVlAIrw/7qGAEr7
 VeqpUG50fQ4+jg3+CISc6PrzfRbHhcxRMOZ+fMc///7s3RpslwuOrw1OK8DgQAZ88poJ
 d/+vz4IsF2kCb2Dq9Xzc+hYKOpLGWS7EScvEezg4C+TN0xHLF1mRcOQ3X1nWg9H7mW47
 M9orQtmorYDDHHUG+i6/oDsroZXbkZspabcqOaFWz5TbLJz9+TEfXW9A8y/tHm7aHrmH
 j/xQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BpkmqHfT
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The MTU3 glue driver currently depends on the legacy U-Boot-only
mediatek,ssusb child node. The upstream binding instead places the gadget
resources and dr_mode directly on the controller.

Teach the driver to support both layouts, then convert the MT8183
devicetree to the upstream representation. MT8512 keeps the legacy layout
because its compatible is not yet described by the upstream schema.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v4:
- Describe mediatek,ssusb as a legacy U-Boot-only binding
- Fix the MAC resource error and remove redundant ofnode initialization
- Convert the MT8183 devicetree to the upstream MTU3 binding
- Link to v3: https://patch.msgid.link/20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com

Changes in v3:
- Remove the temporary platform data and derive the binding during probe
- Use dev_read_addr_name() for the MAC resource
- Link to v2: https://patch.msgid.link/20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com

Changes in v2:
- Removed typecast horror
- Added platform storage to pass around legacy flags and device
- Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com

---
Carlo Caione (2):
      usb: mtu3: support the upstream devicetree binding
      arm: dts: mt8183: use the upstream MTU3 binding

 arch/arm/dts/mt8183-pumpkin.dts |  4 ----
 arch/arm/dts/mt8183.dtsi        | 12 ++----------
 drivers/usb/mtu3/mtu3_plat.c    | 23 ++++++++++++++++++++---
 3 files changed, 22 insertions(+), 17 deletions(-)
---
base-commit: d0c49353a648e135f269a2953dc9326505ba87de
change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>


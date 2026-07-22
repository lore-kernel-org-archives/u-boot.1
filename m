Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1233C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13F30608C2;
	Wed, 22 Jul 2026 21:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhCQmISvQZON; Wed, 22 Jul 2026 21:44:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4A068608CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756658;
	bh=9LsXA/8Nz/jUoD2crUNATnlXj80RtlTJRZrKa2+nLZo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tIK7eYVTV29EDLF9KwvNDIrqk48rd2YgSpew/DsMqP6s3YIZ9G/8hMTOLIcuOYLWO
	 KY9K/6iLXINNi3JQxXzc98WlJkUSgJUOID8cDYNExvyYp5PUWUoYGxg/EjlitHnN09
	 bjO+sSq77hNEE6htK0OlfBmzuBzj7JnM/CykKrGjS+eV+tUmUk4Xvp4kuw3NLFElGc
	 1ZpNAHnVIM2wAufWJLH7wVsYSljzueRMnB1TRsfroo2cz/5K5DHZCWDqjspUsqxXSs
	 QfZmaWk4XcFQYCesUW5Yx5703etPDyxXW9CIZZCRJiuYMFhHPUHRckSrBryvT3C+ps
	 ed4KAW2mfWpww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A068608CE;
	Wed, 22 Jul 2026 21:44:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49C16390
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B224608BE
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dXsoZM5uq6EI for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:44:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 458C5608B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 458C5608B7
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 458C5608B7
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:44:14 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so37944135e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756652; x=1785361452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9LsXA/8Nz/jUoD2crUNATnlXj80RtlTJRZrKa2+nLZo=;
 b=GIrnSRsHfzHD/pKs8y9LbyJY8ChsJtkmq87gzljmE0925OWqR73Lfv4/3mrHL5WdMZ
 yKAOQ3uo8lv6bjf15XChGiz0U+iH8OWU3N0WhaPKq5YCki1btldgUN0nVbys4ZWuCyQ2
 cDHfjs8pB2fSWi9ZjyJfobJBd09QulGqDg3RDJrp8GIVfnkFEN7ZPcdZkdE+KQCFfZoQ
 1C7kNVX/KyNAqgjRNzgWutqUjq1eIb9qKol+Ix9hXTyT4RQH80oQFfstj9WLr7UCNoeY
 PfDy5ui95zkF20R6840MXIJ5OAeND3KAn8MpnpsJb46kllE6B3ak9JKTSdvbLk7djEYA
 mRXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRtZ3aGvMsDTScPeOb3kD+dnnLv937pvg20QBFfgeW9VLeQppwFrm/vxDwby2PTvOriukfLrI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx7sLQbXwM3XWXCYmV/UhQ55v4eevEZC5CtpIsLPHn/IRl4JXWq
 kNtgl69iDLv14t8M8MdqfvutkiqLB7AAfNIOHysgokJgsF9xCvDm5uNuCH3s1UeVLu8=
X-Gm-Gg: AR+sD122slQAhp6xAq7e+TLYyxvi+WqQUcsnzvXWesyqk4mwyX70vBJLmJOIBj80S69
 z4AjGPQdOsLEw5+kkCDZ4NGRS3q/YHH1qJ3A76zywYg03GBvckQAhFUQ16dRl7UzrqmmjpZ2lBv
 09O/mbU8cmc4gGv7jsPI4Ij3lilWEIJeJOd3d3s2D//4BSwKwzlpIfzipsftgmD9MAyANkJ6cyB
 QQ1+gpn3epBY36oRVs6V1BhuwSaYlibaYe9PNTt4NhZ7hbXvf00UsLmRPEItTTop0tuvKPWqBrg
 yi6T/m0tLqvjiISj0JCHiCUw3iYOSrQBNqbBTXB4xa2Ny8QH7kQi8onZ5Z5ktoWgiB6k4zwfZmU
 JsweiUQ2Zog6XkINh0wGhxNhOkZQtJvK1PHBxyuZNvnxw7TKXSXbR1nmDruTTAB4IRt8nnT+Z87
 Qz9W/OUXnPKvrIuJ0XPfPbwwalgsuEOMncC9aoVwj02V8MV4/+Amaifgyj+EE=
X-Received: by 2002:a05:600c:3143:b0:495:67b8:d97e with SMTP id
 5b1f17b1804b1-49573d0cd6dmr4747345e9.30.1784756652003; 
 Wed, 22 Jul 2026 14:44:12 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a967289sm96879285e9.11.2026.07.22.14.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:44:10 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:43:59 +0200
Subject: [PATCH v4 2/2] arm: dts: mt8183: use the upstream MTU3 binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-2-9719f4cecaeb@baylibre.com>
References: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-mtu3-spl-gadget-v4-0-9719f4cecaeb@baylibre.com>
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
 d=baylibre.com; s=google; t=1784756652; x=1785361452;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LsXA/8Nz/jUoD2crUNATnlXj80RtlTJRZrKa2+nLZo=;
 b=ejR0c6QIDTh7PNxncHgwUy5iG5GSkr+JjuSJagFjz0J+QLn66Km24J42ArWm6Sfi+C
 gU3v5tbgI/faqThJuCeoDIA9toE6rwsIdRXKTXqycF67eVRgRUsag7/pl8Ci53AuO7Fi
 C8PyuER/FvnxSvyTQ7knqRhHM8kbK2zcTjMEHDqBAQVgC+gYrzpaPDLN+7e9sDL/SoS9
 nMIEe6JR574ofSIs7W5xJb3wtWS2AOFZCq7Gtfcnzxe4F4VR2HXzjIkaWM0uS9HM/noB
 FL8rPv/R15Fb7guuEEJsuf3L994FUNHlooldYX7buQoCqSySFZtl2Sk//gc1IUPSsZU7
 uaTw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ejR0c6QI
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

The MT8183 devicetree still uses the legacy U-Boot-only
mediatek,ssusb child even though MT8183 is described by the upstream
MTU3 binding.

Move the MAC resource from the whole-controller base to the device-block
base expected by the upstream binding, remove the synthetic child, and
place the Pumpkin peripheral properties on the controller node.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/dts/mt8183-pumpkin.dts |  4 ----
 arch/arm/dts/mt8183.dtsi        | 12 ++----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/mt8183-pumpkin.dts b/arch/arm/dts/mt8183-pumpkin.dts
index 470a7693997..623561b6a63 100644
--- a/arch/arm/dts/mt8183-pumpkin.dts
+++ b/arch/arm/dts/mt8183-pumpkin.dts
@@ -88,10 +88,6 @@
 };
 
 &usb {
-	status = "okay";
-};
-
-&ssusb {
 	mediatek,force-vbus;
 	maximum-speed = "high-speed";
 	dr_mode = "peripheral";
diff --git a/arch/arm/dts/mt8183.dtsi b/arch/arm/dts/mt8183.dtsi
index 294aa2b8979..b118a106f01 100644
--- a/arch/arm/dts/mt8183.dtsi
+++ b/arch/arm/dts/mt8183.dtsi
@@ -236,9 +236,9 @@
 			};
 		};
 
-		usb: usb@11200000 {
+		usb: usb@11201000 {
 			compatible ="mediatek,mt8183-mtu3", "mediatek,mtu3";
-			reg = <0 0x11200000 0 0x3e00>,
+			reg = <0 0x11201000 0 0x2e00>,
 			      <0 0x11203e00 0 0x0100>;
 			reg-names = "mac", "ippc";
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
@@ -251,14 +251,6 @@
 			ranges;
 			status = "disabled";
 
-			ssusb: ssusb@11200000 {
-				compatible = "mediatek,ssusb";
-				reg = <0 0x11200000 0 0x3e00>;
-				reg-names = "mac";
-				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_LOW>;
-				status = "disabled";
-			};
-
 			usb_host: xhci@11200000 {
 				compatible = "mediatek,mtk-xhci";
 				reg = <0 0x11200000 0 0x1000>;

-- 
2.55.0


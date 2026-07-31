Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EB5C55165
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 00:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D32EB40E62;
	Fri, 31 Jul 2026 00:15:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lly99DD78A3g; Fri, 31 Jul 2026 00:15:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C740740E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785456949;
	bh=05W7NvOyjUR2fRaDuUcJgc5AJOlJgsv/YyHuQ0nWJNw=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kt+tWu84LUe5Qlh50/RFLMVy7T5ongu++p634vyoJNjOYkiuxtzU7c3En1ctlOgBE
	 HJ+jSncOCxcvXLRWZ1RJq9YKqlxHeDdvJT7p8lY+BJb9K5BpqlM0wyEGHT9ZpPY5jU
	 TxU+t7ydWLggdiNc91oHuZhf9gK+CbItpDhc1qmYQuPEP3IgHVAOLSPWD89uzA7kLE
	 0/E/keeatm3uQnsz4az3EimRbVSZmzBnV7YAsNFOswS58jTw/DR29bFU3xPWN1xpou
	 dXkZPR5z4jQ+B8h9wgxUL2y8CpfKlEp1Do55rRJp/fJwtHntyeJ9PJtcXSYhlSg3aa
	 +i1HsZF4DIJ0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C740740E3B;
	Fri, 31 Jul 2026 00:15:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16A1F197
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0830F60674
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gs_iLnmK81lG for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 00:14:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6A95060648
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A95060648
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6A95060648
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:52 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E73913F9AB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 00:14:50 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484f26852dso454844b3a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 17:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456889; x=1786061689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=05W7NvOyjUR2fRaDuUcJgc5AJOlJgsv/YyHuQ0nWJNw=;
 b=MglXHnpOxqO/PBdJmsByAVCh0r37JNTF7VgeIL/ff1zWuj+TFjL66FlLqbmTy6Yfm1
 OnxrTAWgKMGDSn8aSHTJpTo/mvgDE9a3ZQSYQ/yL0ET7i3BiCryHKZM+VBGLW18pK80E
 on0hbPdnvbGNg260dEdP8FrDQynLFXssZr1vvi/nIFnte3J8Q/UoNjzgiSl5S8oWG/2F
 kwoxMv4BgfCcanStOvMekeYYRQabGbNm5b7KB+yeMV8FGf3zIzb4z9XZJzP2LC3BGa9g
 QOuhq7ZknBCJqn7IGsX3RhiwX0Z6Nj/R8x9ouc4mlftoL4thDf0oTsfwjW0RGA9sBZru
 IcOQ==
X-Gm-Message-State: AOJu0YwnkRcdkCOfzBKTlJaK2yzPU9vzKr5QJqgqycfZ4nkQ9eMHROWr
 9xkiQdSjjOphphkhVtEGcSiivLVrem1xZNFbHpYMBIZ4R/Je/cjUAOIEH0bfwWCXERU8T2FyDL8
 0bm7UN9NW0bBit9M1LNMPRDmbRDXriO1b9UvGZU5DtT7xyTBmNUZ2+YQggHzAdNkbMUyIGuuU91
 sNad/+65RaiCdIGHLisN42LeA=
X-Gm-Gg: AR+sD13wrYpgtgYPXK8wko3VlmxJBGaybNs6r4UHAT9+D37rnhN66CT51QWVRRe/h0k
 wdYxToDzSGfVJ7tFbpMJ0jWMOtUhxfsDLXZv7gdxz3L1N05XNTp1MUTJQE2rDfYvdunLhD4Qbfv
 ZVE9OmIBAqBMF3EDE7Etct7nNz5GPrZy/E12ntWZYM+0ugfkxI5Z017hWhS56HUdoxFGOC47+kc
 aIZeDfNBiMaXKgMT9W2moGpM/jRjwmoO4aNmsS8tdTXhQPlZcIrnFZJ65reZhKlT5h6mjKmANFh
 LTwk9lQAjnSdVOMtsi4dr5Un35fll/gQWqIjMW1NPlNDPGJ0lSOElTadAKhPicthO3aTGV4Z4/K
 nFLoyHvXr2Q4ckF+UflT7Y6jKX+YR329ZhzGJCxwPTHFe6YPp+kL3jpPU+qFXlgqTh3KZKA==
X-Received: by 2002:a05:6a00:2d9c:b0:847:926a:7ae3 with SMTP id
 d2e1a72fcca58-84ebc22d885mr4032968b3a.20.1785456889308; 
 Thu, 30 Jul 2026 17:14:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d9c:b0:847:926a:7ae3 with SMTP id
 d2e1a72fcca58-84ebc22d885mr4032952b3a.20.1785456888934; 
 Thu, 30 Jul 2026 17:14:48 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea02f8461sm3695718b3a.28.2026.07.30.17.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:14:48 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org,
 nm@ti.com, bb@ti.com, n-francis@ti.com, d-gole@ti.com, e@freeshell.de,
 jonas@kwiboo.se, Aristo Chen <aristo.chen@canonical.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Garrett Giordano <ggiordano@phytec.com>, Suhaas Joshi <s-joshi@ti.com>,
 upstream@lists.phytec.de
Subject: [PATCH v4 4/7] arm: dts: k3: phycore: widen SPL overlay load address
 spacing
Date: Fri, 31 Jul 2026 00:13:38 +0000
Message-ID: <20260731001347.35624-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731001347.35624-1-aristo.chen@canonical.com>
References: <20260731001347.35624-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 00:15:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785456891;
 bh=05W7NvOyjUR2fRaDuUcJgc5AJOlJgsv/YyHuQ0nWJNw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MsBDnuC1vAAnhS6wopoWJT6UhCRqRlGLgxkT9AH9mNxIEOtvNpaXUAnmzaDyBF2y0
 ZP7zn3ctZtmsAYgzj1O0V/6wP0RgjOU+I6NjcReO6lvFgkE9lmTu8q2nXidCCQpufT
 2yB4i7KVgGSfjN3ZBn2c1WiRdFkrglVdj8u/YuGXyRxefysWcNDDQm3b0bvUOwYiCq
 LQNW9OfV/gonP7iqgdT9FGGjMoTwvjwQiW7k7RDmc9saTsXWVk4gmWGd9eESntuCO+
 VuJ8vmlbVDfzsJR/3Y3pwfDBg9Gmc5ATcdB/YgSw/D8lbH84gr9R+OdQoCaJcfIRHW
 SaFSTD19PtcBINfTUqDEhRHahd3EY8gMxaFllF9ZESo45e3h6rzxQSIH2dnidPzvI1
 9LSSUQuLydXRREfGfoWQIXtvwpLZgY3iewRd/upu1AMrIkxS23QF20wSN2m3dlgOwP
 PK3OlrvvMDouzzH3UKkbUci6ohjSWpHHv17phCOSVaqEPL8IdFVDRCgNTu/RIAvRKf
 XNHi9aOltvbzlnBl8wQuV0656M/RogfSNSpCG6yZnPeNCuTiUqK/LIz+nBPFUKGsXf
 iuu0HW+c1GKezPD8X4b6D/qu00bfCFJVnrJPYh35NDtEZTTnk0cJQxkB1XuaN7PQdY
 DKdDMm5eZXqU8g9PvGzcORYk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=MsBDnuC1
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The phyCORE AM62x, AM62Ax and AM64x u-boot FIT images carry four
devicetree overlays (som-no-rtc, som-no-spi, som-no-eth, som-qspi)
that SPL loads simultaneously as loadables of the same configuration.
Their load addresses are spaced only 4 KiB apart, but each packaged
image is larger than that. Measured on a phycore_am62x build, every
overlay is between 6035 and 6163 bytes including the prepended
ti-secure certificate, and the raw dtbo that remains in memory after
the certificate is stripped is still around 4.2 to 4.4 KiB.

Loading the images back to back therefore overwrites the tail of the
previously loaded overlay, so by the time the board code applies the
overlays from the recorded /fit-images addresses the earlier ones are
already corrupted.

Space the overlay slots 16 KiB apart so each image has comfortable
headroom. The addresses are only consumed through the /fit-images
records that SPL writes while loading the images, so no other code
needs to change. This also allows the upcoming mkimage load address
overlap check to pass for these boards.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 6 +++---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 6 +++---
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 6d57a5d9ffa..d0eaa7dd992 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -368,7 +368,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -383,7 +383,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F008000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -398,7 +398,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F00C000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
index cdc9a100a04..2c98e16b00b 100644
--- a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -295,7 +295,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -310,7 +310,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F008000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -325,7 +325,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F00C000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
index 07cb79fd04a..64679195e72 100644
--- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
@@ -402,7 +402,7 @@
 					description = "k3-am6xx-phycore-disable-spi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F001000>;
+					load = <0x8F004000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_spi_not_dtbo>;
@@ -417,7 +417,7 @@
 					description = "k3-am6xx-phycore-disable-eth-phy";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F002000>;
+					load = <0x8F008000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
@@ -432,7 +432,7 @@
 					description = "k3-am6xx-phycore-qspi-nor";
 					type = "flat_dt";
 					compression = "none";
-					load = <0x8F003000>;
+					load = <0x8F00C000>;
 					arch = "arm";
 					ti-secure {
 						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
-- 
2.43.0


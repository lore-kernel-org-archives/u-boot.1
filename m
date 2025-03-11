Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C71C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79648168B;
	Tue, 11 Mar 2025 14:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PI2h2cRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE0E817D8; Tue, 11 Mar 2025 11:33:14 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5ED807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso4272324a12.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689180; x=1742293980;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qS3Zh5OA2/6C+XGS5mpcFT7Z0ttiG7le4D1xohlV/ug=;
 b=PI2h2cRpVWmS0iMcZjG1JDDzmoibmlrHO349xnK3C5RPX0rKTXbiDvQoOZt8WN2smY
 tVvQgJ5wW8A3YmI1pD0yMSDzSkj7xFQ9fWaXSJELzoNmUBpujHfgz7cOZ/ythOkDIjOK
 RyqsFlrAw5ZDSk6l04goQ6pzw7O3Cm2nU046wv4qtqQvUKdYvEfjnnIrv9vDxBmpSJcr
 O+qzIvw/e5LxP5qbG8CryIOZFyz1d2RG7NkS3dOta50sbUBuAqIHPcbuHoj1IM1vbgdn
 mSM/nYbMRG+q50YATzEPz4fYXi1GAlbOBf7K7SyIqgB+rfcKjA1VO4eJla2ureTvl2K7
 wAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689180; x=1742293980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qS3Zh5OA2/6C+XGS5mpcFT7Z0ttiG7le4D1xohlV/ug=;
 b=Us/utpzh89FNC6x6OgEslp/10GB+T4lZg4JpR+bxoOCK7DCWMjF1fqdllJZARbGVWd
 QyTcTtkde4pghu3FiBNPcuI307NypTavR+n2l2tr4FYOJbQoUVISOL6M6dAaHvr2bWsD
 04sl9Asp2uFmoBcfmcAMJcQTI1M85hWXIxxzTXDiOIXFva44CmlWKmIfL5Linhsdpu7D
 1oGiYxY3X3bE1DlAawQNwZbHNB3OAPaU7Ex+Fd39SWnC+j9NIZM5LLZf8C99DDMk9xb5
 PvmDz/Q9Zm5mHnB0b2JEimba8gBAiarJWehAiEK4rAngXraJQ73BKPAfrntxoXe5rba3
 byyQ==
X-Gm-Message-State: AOJu0YyOpxsZFIpJ+Ye2iegQfhIfuYBax3hUznZdvlvD4jyiBNyAROgz
 uwK64LHquYwDvaSrmQGIEpi5rGrQ8pxMas7cmRSRk6ytb3tZHJkWQwhtoMw6ElGFsVoT9UR7d6A
 d
X-Gm-Gg: ASbGncsJIf4riFTVeqUmtq01bl1Ew1hr1BCn5zeudgQwIW6mjJTbzN40kUCcu23+TJb
 2F+G3VeBpl9HmymgRqPVRv05TwYw2iWkzc8skxqz0lb3AaX/PC6Za9WEj8e58Q9CydnIjtVAFd2
 Dzu6yxerxDbNKiSMHUiraN5VFdFXpdSzzhBjcFxEfLpKt3YQ7pDBM2SGSAgE2Y5mk0mJzUKQ1XY
 8WKYooXCedcJxvpRvfzybI9hERI45uxkC4sVJoZbFY+IfURt/8dODxYTAcGTLJWIMkgKHkipcly
 O1g5Ys/ikBQ6Z/sNPe04eqbv/rlR25LHvPMs49Kc
X-Google-Smtp-Source: AGHT+IGHKPb3XX7v08nvPPjvY8NWo0bjfFzNN8Li0/zbVl/ks03sUlJVPdzvpfAiiQ6xe2nxs8AstQ==
X-Received: by 2002:a05:6402:520c:b0:5e5:c0e7:f43a with SMTP id
 4fb4d7f45d1cf-5e5e21050b2mr21921292a12.0.1741689179889; 
 Tue, 11 Mar 2025 03:32:59 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-5e5c766a16esm8089006a12.60.2025.03.11.03.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:59 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:51 +0100
Subject: [PATCH 12/19] arm64: dts: ti: k3-am62a-main: Add C7xv device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-12-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, Jai Luthra <j-luthra@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>, 
 Andrew Davis <afd@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=msp@baylibre.com;
 h=from:subject:message-id; bh=GJKw2LLWILqri9RJ2kmlyf5B+3xlzJV0G39loBE1YUo=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCKo+ehgjwWFh+iBzctaHoq07Xe3vdBSnSU9cscBay
 Krh9ivPjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAih04w/LOdEfSCZd/mjRtk
 NZbFq5j5a+z5vnd3b83zdVaOTAc+/fRi+O/x7E1myA3lPbz6WZMFX7d4VBfY5LQ9PSe0I77ht9O
 qKk4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

From: Jai Luthra <j-luthra@ti.com>

AM62A SoCs have a C7xv DSP subsystem with Analytics engine capability.
This subsystem is intended for deep learning purposes. Define the
device node for C7xv DSP.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250210221530.1234009-5-jm@ti.com
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi
index a93e2cd7b8c74ab942612d1090939614066e9d2b..805cde942b97f0b6069d505ec90b8201255e5eec 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-main.dtsi
@@ -1124,6 +1124,18 @@
 		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
 	};
 
+	c7x_0: dsp@7e000000 {
+		compatible = "ti,am62a-c7xv-dsp";
+		reg = <0x00 0x7e000000 0x00 0x00100000>;
+		reg-names = "l2sram";
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <208>;
+		ti,sci-proc-ids = <0x04 0xff>;
+		resets = <&k3_reset 208 1>;
+		firmware-name = "am62a-c71_0-fw";
+		status = "disabled";
+	};
+
 	e5010: jpeg-encoder@fd20000 {
 		compatible = "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc";
 		reg = <0x00 0xfd20000 0x00 0x100>,

-- 
2.47.2


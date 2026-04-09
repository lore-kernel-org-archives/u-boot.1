Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933A2EA3C59
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C48841CD;
	Thu,  9 Apr 2026 15:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3NUS3Qo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D930841F2; Thu,  9 Apr 2026 15:33:31 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3B6841B9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 15:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48374014a77so12230495e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775741609; x=1776346409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BLr4rz6/NPSRwC+PVD7LgQ5DgBFkgdtUkZlMdTEORZ4=;
 b=V3NUS3QotCTW5f3hKJvC+bMSVkve7eDB95sNRxCBkhJ/cc0bcKxUAZAv77IHfG1Dmz
 MHhjmCgTYzoWwSZhFLx+dbYT2yqjBQZF4c5G0/SBK4GpZaC5EvCu+buIogRNzvMZDa3b
 rkMl3uaLg4YYWRs16mLGvYKegvZ50a4YbVKQa5EhvNMCCfIxfUXzl9hpyPnYHqbNCKHo
 i8+9E3QQLGYUVhhdv+al4JnBwf9uLlWPJFFYRFf7LgPOPKcqGv+KIJtBd/UlZiDpQ2QO
 9ON8zRafVJKfr+tzC2l96nne1Uz2x23lyg+uDh2z/Lhilo1POHG/Qeb7YKfiw86Z1CmW
 ULtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775741609; x=1776346409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BLr4rz6/NPSRwC+PVD7LgQ5DgBFkgdtUkZlMdTEORZ4=;
 b=bo47SQ06SOAZWk5gRN67ItcHQv1AlfVjeCpFIzloc4RSW949CCzIY0sonVbvCdAnin
 qfr4NWRhLZWMm+rgChAWjEA1XJp15HR2PLeI/jEkHX0vh+b6DkTYU3cyAND1yMD1F/O/
 Jp2Fyy4KsCv72ISTXYjA3dVarFrL2KjXxgRjB8GlQw/l1bhKT/8pYFZAFvd7uXnbn1/N
 Rjw9YvfnhbCDJZNM6cJMBkVK1/ZpCy5HfEAenHQjpfOYDZRlsOcNbw8IJ6zLU251FYJA
 EFbilFNvm9fis1B9TK4H0I5VPwSIEQQuYIVqt3L62NB6A/Dnc/ru9mOmAZX0w2pan5Y7
 UjEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3aNZwXATnAfkYc0CCOlO/o21fd//7QqDebKMTGQlB1D6DXTxjoEwMy/By79KTWcPVacd/Vq4=@lists.denx.de
X-Gm-Message-State: AOJu0Yym8v4Gq1YjbdFAqG971KrN8Mg7qGEJIoe/IGm+199qg7Er8zs7
 CVhlPb5FYwovjvujree9W/3YACxP8iug0lzwykWrkBze5lJBUZJfK37O
X-Gm-Gg: AeBDies1dG/U14q3pwL/hfYJ9MTDSerTdp3SmbzwOtQ9JpsdkfCmUAL2QhA/MX/P00t
 MK+Gk6UgoYgB7qSOvEJEf9Nx/RbvaRJhwuqrU1MytJ89F13Iwx+AwXKz3/8/IKoj7ouC9lwngiz
 CwA9vZNK+ZNo5kw9n5xYRPo+1xwDXFQbJ8JGzPM/kyVPI7Urq4bn4WKQzQX0cvCNrPtmMbBIHvJ
 CiFWjneSNHgeh4IAQx5i6Qn0lityOJUeGEDmetEAam56ACz1Mv2ja/Fm3XkOAxCfwSwQX7/M9J7
 nlxZvicSYOY+anL1dFZMuTBoF2izM2omiyAnC605QGckw29cw7IfguksOF7aS5BY3iEK3y3XPre
 HaSqnlIbdlIP3DSedZV/wSdYw7lGZmdxQeCRQllGYT0dWeHjbSJ1163azjbn9aGqYTfvrxk7v5i
 hzpyYpztjg1jE1C9XpISc8IybtKe6P/P/hiUSW9w2pvDCpa/NmltrsNcUU6IVYLguIoeeu0fM=
X-Received: by 2002:a05:600c:5251:b0:488:c257:a73b with SMTP id
 5b1f17b1804b1-488c257a952mr119130235e9.9.1775741608413; 
 Thu, 09 Apr 2026 06:33:28 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-61-192-155.retail.telecomitalia.it.
 [82.61.192.155]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488ccf9b919sm52876215e9.0.2026.04.09.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 06:33:27 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v6 6/6] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Thu,  9 Apr 2026 15:33:02 +0200
Message-ID: <20260409133303.31875-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133303.31875-1-ansuelsmth@gmail.com>
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Update documentation for Generic Firmware loader, generalize it from FS
specific and add new property and example for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../misc/{fs_loader.txt => fw_loader.txt}     | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)
 rename doc/device-tree-bindings/misc/{fs_loader.txt => fw_loader.txt} (60%)

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fw_loader.txt
similarity index 60%
rename from doc/device-tree-bindings/misc/fs_loader.txt
rename to doc/device-tree-bindings/misc/fw_loader.txt
index 542be4b25a0a..9b00b2c887c0 100644
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ b/doc/device-tree-bindings/misc/fw_loader.txt
@@ -1,17 +1,23 @@
-* File system firmware loader
+* Generic Firmware loader
 
 Required properties:
 --------------------
 
-- compatible: should contain "u-boot,fs-loader"
+- compatible: should contain "u-boot,fs-loader" or "u-boot,fip-loader"
 - phandlepart: which block storage device and partition the image loading from,
 	       this property is required for mmc, usb and sata. This is unsigned
 	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
 	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
+- mtdpart: which partition of ubi the image loading from, this property is
 	   required for ubi and mounting.
 - ubivol: which volume of ubi the image loading from, this property is required
 	  for ubi and mounting.
+- partoffset: valid ONLY for "u-boot,fip-loader". Offset of the partition to
+	      parse the FIP partition from.
+
+Either 'phandlepart' or 'mtdpart' can be used. For Block device, 'phandlepart'
+should be used and for MTD device, 'mtdpart' should be used. With UBI device,
+in addition to 'mtdpart' also 'ubivol' is required.
 
 Example of storage device and partition search set for mmc, usb, sata and
 ubi in device tree source as shown in below:
@@ -46,3 +52,20 @@ ubi in device tree source as shown in below:
 		mtdpart = "UBI",
 		ubivol = "ubi0";
 	};
+
+	Example for FIP from eMMC:
+	fs_loader4: fip-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		phandlepart = <&mmc0 0>;
+		partoffset = <0x100>;
+	};
+
+	Example for FIP from ubi:
+	fs_loader4: fip-loader@4 {
+		bootph-all;
+		compatible = "u-boot,fip-loader";
+		mtdpart = "ubi",
+		ubivol = "bl31";
+	};
+
-- 
2.53.0


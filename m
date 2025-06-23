Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498FFC77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B441382E86;
	Mon, 23 Jun 2025 14:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="grN9oVEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF22F81E13; Mon, 23 Jun 2025 14:10:54 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0839282CCE
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-60702d77c60so7900444a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680652; x=1751285452;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QSwIA5mNa4+xpp+hTFw/bktLVt7ObwE492iQQt71g1k=;
 b=grN9oVEVBdfotmCgALXF6a9gGGMTApVMNer/L0xhV+dHyD8LBoZihpvz2K026Q0Pe9
 viU/8wBaJ/8aE6zrzzn8oHp0skN8wUbr4D6+H3KQQ1bcsI4IYz880dFnEcH0zdxT+1YC
 JpNipKq0sxtMGWoOxehSFbuDa+yjYm0fvVV4x/WKwcehg4XRxyggLgCRfHNcsSZJTYiJ
 1TRrLtOB+ly+Xtv79iPvLoHc/6//r106L2j2gGvIL0HRVyYtxyTYL8DP/kWvW1tFMCI2
 ZRrZJ4r4k8NjNVV0o2d0LHW8FrXT+vWu/sfuW0yh6KdZMadxp3wQpvi829kn64ui55Q0
 Gjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680652; x=1751285452;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSwIA5mNa4+xpp+hTFw/bktLVt7ObwE492iQQt71g1k=;
 b=Q4mqY+cQXR9v7BIGX03DBPBXWysFkW4vXMCoSstDTp563rfxYeKDoYjjw88Rxb/nMV
 9Cm9tyW6wLgYVpsKIUvOFdFg0gN1DuzYgiW2uMh3V4WzuwotOkCOLJ1cd7y9tDLbAcGw
 EW2FWDIs+xgIeF+8x840LdH3h/MyyrKd4UMDji5jUVa/yEzGYAuMaVS9EkQ6MNNikXxR
 +ThWFQIHAWqL39Z2UEWFcVx7/ID5pgtqHYi0zT8mHiH/yJd1L5Xil0gXKLACusrBlMDC
 ictHvqkpepbSTSUjty6gwaCQFHU9PUJBuqFw0txpGVS/d/cbLvwfhis9Il4ylHEeIj8q
 bYOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrCYuMxeNdPTJZk44wy+Q+M+l66f9117cL3aGgZP/mORAknicO7OtZO2B+2nP56NBpbFgikds=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2Qxy3Yy/sWskzlROxW8i+qDS9bygmGGiZzbj4xv9iP19fzNY3
 tAfSTbhr60Gb/8sRL9J38h96SapRkHnzqgJYrtmBZGWGvlOXl6bBOXna0TMXowsNy3o=
X-Gm-Gg: ASbGnctaiAMjGFZ4lmo+R7CGQRQoAdPhqrtb5UGVbJHxmtNTXrqu97acDE3vcbMIVSl
 +qO7NdE0nDXgKxTGvgZy1cCpvzYwrPkXTteL0PaiWJRg+AwHhqEvRuHZ+oM9quBeQ9lsWrA7row
 rLBfyEF8XEqg9fP62ClaM9J1IwB//FupfgiUvwDwzJHanD9p2l+p3U23Sdu7NiE3GW8KR9MFTYk
 bsm+Hfula89DUHDlu3VL115qEnuvN2B9SHVEXuiD1ucVWZEM4SAGqRrXQNmBLeduqDSDnJoAWyK
 51ZLGEtNnNbP4BLe8/6l+PwTnvMmKIOdgkEXcFYp3qYO0PP7Eo30tgpYfjPrguS0HU2gCA==
X-Google-Smtp-Source: AGHT+IEny2eEhIZ5vshJXUUe8vRZbRmJCwkngdm/iZJemfB96uLoozo0xvswGQngNSK8hPKMCezj9w==
X-Received: by 2002:a05:6402:234d:b0:606:b4de:f72c with SMTP id
 4fb4d7f45d1cf-60a1ca0ecefmr10084241a12.0.1750680652033; 
 Mon, 23 Jun 2025 05:10:52 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-60a18ccef52sm6062860a12.63.2025.06.23.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:50 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:42 +0200
Subject: [PATCH v3 19/22] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-19-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=msp@baylibre.com;
 h=from:subject:message-id; bh=v8z25nqKH9oS4wesytZdHU8dhpwffiQJU5A55TVG9OY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIF9ltlot42ndphVRz/5OML/Dgm1LIkfDR+8/6XyUxR
 wx+LdjQUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPxCWdkOKTUxR6pP8NRcaPN
 WxHlM9+MY9sVXXnlWX6YrX759arINYb/5eqV7XE/jNj3OAm0Cp6NMjPcv2BCyo9FapPtn3k7yIa
 yAAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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

These are needed in SPL to be able to resume from DDR immediately after
booting from IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
index a70fc88317e04de032e4da1428e25eb78ecc30cf..7e6a76f72b2a63bf706c3839189b6213aee4497d 100644
--- a/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-sk-u-boot.dtsi
@@ -14,6 +14,14 @@
 	memory@80000000 {
 		bootph-all;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
 };
 
 &cbass_main {
@@ -68,6 +76,14 @@
 	bootph-all;
 };
 
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};
+
 &cbass_wakeup {
 	bootph-all;
 };

-- 
2.49.0


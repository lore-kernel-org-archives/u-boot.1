Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5038C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA69B82F71;
	Mon, 23 Jun 2025 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RH2wzgXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97A5D81E13; Mon, 23 Jun 2025 14:10:47 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5397782D21
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so8145190a12.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680645; x=1751285445;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mrUxM9mIj0J7O7I7vKPgS4Xm/oriEiQRQpUjDGhl1IU=;
 b=RH2wzgXj7bVHH7sHjASxhPfB2IEYi85lNPbp51typ4kwNK8sya11WSD4ZVmEgP1gq7
 KFUasKv20wDkFysJ7WXAQf+s8n6hZZonH2PUjHRIjVfNdhXP4JI6wRlZYWotcHbEepLY
 qCGc4U54rSszMpiEUUXh5ohitUIRcqUaqkLDPGHEzlnSEI2+t+K5JU4YpRInkhTDI52S
 58JhRBA4wNvGK9pDEgr92Pw9/q6qJWBQnweZhF9INMmZ5sAfSI/b0Yi47eZCWWdK4HDS
 Ahq99HhiGzR/vrn82Ax8d9ItObkXgh9hJgLWOTH+5iF8tnbu/4htbGng02FdGYOlbtcU
 FnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680645; x=1751285445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrUxM9mIj0J7O7I7vKPgS4Xm/oriEiQRQpUjDGhl1IU=;
 b=ZwNcJnPCmxv0/vwTEkaDwCSyuO5EJEBzDyKtcQlxJaPNyB/EZ9XMv5B+uKAD7ZrD/U
 a26+85EF83+hciXYfdcduHQIWf7i811B4DkG9FSeLYGtMXsQJ/gWGKbdHzyAB9b6z0Kh
 VTi4TheJk0Slvr5hDBmP1v1fvTl/JYkXF94dRQmqUzGTm64gcvHpNAmGHSQoTlBe+lzB
 mcQy4dq/bbM6Ak2Qlq+sHdKov5FvH8SKXUjoDveuvwNbSVQ6HlJ74cm2usYB0rTfkTp7
 Rcff2P6SNGatPoXVcHvSx3LiX4wRsdZYgE8RNX6O/fHyYff6b8gopZvUjy6HR6eBpy1l
 +Y6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQtThfTuRmv6MYNDV36kxiJjd7Abi/GjYTUC/FXTOusC/WTy30QvrSZbOjBeMPa/pU+SzOk3M=@lists.denx.de
X-Gm-Message-State: AOJu0YxLrCNK4PmqPJpS4s4jVfJmTJ4cmyG1uHSYJq3QJ/ZLP65njkev
 q8COoHMm+s9sNKrqIsgKAWKaZocwsIkuYHO6j56zavVSD5EBuAzDxdd0jF+kAG8VtBw=
X-Gm-Gg: ASbGncsWuo01x9MZdZ8BRoLyW1KvT4kWPR6A0PzYn6fjW7m87UILvC4kTaqbRxR7HFx
 f7gCA+cJ0wnSajHcPl79CMIbzgln5YmVAcRMsntS/5G0KrxCBxA64v1+eO7jKT8Oqf7CmnJNCsj
 ZvDcH6xndXHqslGtzU7aHGbZVqBaj9IKF7c4bydmP3UxbhZ1QD91GwaC5LQJ2wRoQwhJ4pbjRkk
 zkON+Bgrin3JLxiduTutuVP95lH7GA6FKqHtykQQpayzboG6kM0DPS47HInEi2RMebYsK7TdyHe
 H8zYl2E07RAzLlTWGtrEup6VGFQeOLgGTcXDEtfk6A2+fe7nOPaCs1SdjaA=
X-Google-Smtp-Source: AGHT+IGd642UKzFTDLCo7ijkda1UewLqKfOEIl/o9lXjWDYytWsfyAvJWG/TKBXWuZgP+b8lq0XTrg==
X-Received: by 2002:a05:6402:50c9:b0:604:bbd2:7c6c with SMTP id
 4fb4d7f45d1cf-60a1d19192amr11180772a12.27.1750680644763; 
 Mon, 23 Jun 2025 05:10:44 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-60a18c9473bsm5932932a12.51.2025.06.23.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:44 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:37 +0200
Subject: [PATCH v3 14/22] arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-14-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=msp@baylibre.com;
 h=from:subject:message-id; bh=3h3B22xXibfEaCo843QbJHnBR/evntVXn17B/KwcGz4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIFxbVhywlLE3/xdYd3dnSZ12QfYrHeJVF17LVtm87j
 Au91Ng7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCKtkxl+MZ1ur5NM1L+ZwLLu
 Upa6UsbFb3PZ3sZfPSrPPiFC3MPNm5Hh6qJVK5Y+OH4p5WTBnJfinhd6Tu26NffXi9VZr3ZKCAp
 OZgcA
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

From: Devarsh Thakkar <devarsht@ti.com>

AM62A SoCs have a single R5F core in wakeup domain. This core is
also used as a device manager for the SoC.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Tested-by: Daniel Schultz <d.schultz@phytec.de>
Acked-by: Andrew Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20250502220325.3230653-5-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: f0623719c2a612cbb9d5927fc5ffef9b54a12fb7 ]

(cherry picked from commit 87d1a5e90b69c4d995561fe9c1e077bad5db7416)
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi b/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
index b2c8f5351743857a54385178cce5c82a961917e3..259ae6ebbfb5ac5f83cc2c159c779ecaf9f96dcf 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi
@@ -103,6 +103,31 @@
 		status = "reserved";
 	};
 
+	wkup_r5fss0: r5fss@78000000 {
+		compatible = "ti,am62-r5fss";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x78000000 0x00 0x78000000 0x8000>,
+			 <0x78100000 0x00 0x78100000 0x8000>;
+		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+
+		wkup_r5fss0_core0: r5f@78000000 {
+			compatible = "ti,am62-r5f";
+			reg = <0x78000000 0x00008000>,
+			      <0x78100000 0x00008000>;
+			reg-names = "atcm", "btcm";
+			resets = <&k3_reset 121 1>;
+			firmware-name = "am62a-wkup-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <121>;
+			ti,sci-proc-ids = <0x01 0xff>;
+		};
+	};
+
 	wkup_vtm0: temperature-sensor@b00000 {
 		compatible = "ti,j7200-vtm";
 		reg = <0x00 0xb00000 0x00 0x400>,

-- 
2.49.0


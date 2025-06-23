Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B45C77B7F
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181858303E;
	Mon, 23 Jun 2025 14:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FQDfPusm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E55881FEE; Mon, 23 Jun 2025 14:10:57 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD2B8210D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ade5b8aab41so860235866b.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680654; x=1751285454;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H219KVZw5grLTyoQw9SIkS6lcNkeXNDs9oZGAD+Pn6w=;
 b=FQDfPusmAOEG5IFkAQtpkut0YEqkKnxgDeng3tsQ48hLTQA6+kzYRZ1O8CUI2leOJL
 MEvQ5y5NvEiBdm0rr6eWpB3b99QF/z6jzIzxo2xRrf5rKYuGCSW8DBekbkLz4dd0+xI0
 XW/jndv9Dvigh2J9dUSBIlV7M65+Ev2nAbGAQpoIS0GDhi8IKUe7m1adzxrhdLnKxJ6s
 Qg9az2TpMU9/jg44DPmaEJ0Xdo7PTp3auAzzUCZVGZJQ6nE6HNlQESCkJzTiLolbb2FN
 cftR0f3o3VekkGr19iKATfYh/R+EVvZEKJeA0LuSrIsOsqcDZOrULZpnds9m7MYdEJcM
 ZM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680654; x=1751285454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H219KVZw5grLTyoQw9SIkS6lcNkeXNDs9oZGAD+Pn6w=;
 b=tpRkpUCK3Wcy34NIq4jG/R9Xwa4tkBuVeibbWSDP/bdhNzR5pS8dQlq7sGdUdDML4c
 6dDLQaEcu6SjNIuLCHRI0FPDB0sGoCPO+bgJEf1Wof8ScY/nrWybqe54JiBXf1Bfylwu
 Lwmgkw1t8LjUG1Wkr+I/CmtizMUY788oSvwUZlOgQl/XzBn53ptHAqqbcviOHS/dT01+
 hZpvSUpUBiTWWD7USV/2bNyKMUDtSuTN9vuoqb9RNpSjmIu3C6SMBposOUNBJoLzoAdp
 9ApqwNudtzhAbbnbwyghfZ4724oWRQxGkEa6FUGAnxQVsmv3y0CpOMzjTXiWKqwj1I1j
 9z1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFp8Ny2SMGCZn6LMGK78IuObMeZdBUfwjyKJ6dBPRG9sEpjLu4c1yHzLOxQojFewdjxUdPfh8=@lists.denx.de
X-Gm-Message-State: AOJu0YxDChxNlkB/yh2HaLWhRObUjLSYD6DEBK3mFOPskoxTnGY3n4/P
 dSA9aGaEesLijCT1rWd4AD9qcox5DSeu9wPdQ8r+N28oV2fDJQ+BLiRYHets5q1yCso=
X-Gm-Gg: ASbGncuA7JWKSj5pXQAod6u42VL2gMY9fQrEDazJW9HjB4fkvJ+Wg+SbiLezhjaOoU1
 uSo5O/Csm5uwNopjKIT2VJhQDXuqLa+BO7dw3cSPyjF5j0fHkHnkUERyv3TBi/tpfQ79XpWBw8e
 LxKm/YYkBJjwtU1P/XdNDMCSPTT/FOcv4p8mv4DhLp9aT7zUV4niYwOIGsUEAA5EOloteTupvVh
 dbMj7Z/Wq9IAx3bMjpDULx2z68C0nRIMSLQzYx4WnFbTlBHeWfM1P0DRTI7Kn+8EOVDh+FjkCvU
 m9JG53ZRRk5q4ia4tUtNB07bODrJLqYPov0ImvaRHIES85MilY0kRwJi2HA=
X-Google-Smtp-Source: AGHT+IHDnlA50bcIw5E/TJEeDZQOOH1g1NKX+ngeQzKtnQWOqSaox5rIXSxeM1vZrfbpJTr9IjIbMQ==
X-Received: by 2002:a17:907:7e92:b0:ad8:8f44:134 with SMTP id
 a640c23a62f3a-ae057bc88c3mr1209000966b.46.1750680654445; 
 Mon, 23 Jun 2025 05:10:54 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0541b39e0sm697665566b.110.2025.06.23.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:53 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:43 +0200
Subject: [PATCH v3 20/22] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-20-a4da322c16af@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Zoqhv8UWHGbqUQ4qIa4qJq4nErwA6hRuiIIjgmPZ2yc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxIFyW/OYE/nGt2fXy2VqPwamO8z5UTwY0pnfI1HfNS2
 NeWRh3sKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgInosjIydO8+VPXxbe/rtLbv
 el/nr+rr8ZRkKleZ2s39X+0Lg7fOMkaGGepSpYkNx9zTf8SadVSxbdDu152W8ObAZb/+u2v1Q07
 zAQA=
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
 arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
index cf087c6e343a8af6f4bb2093bb6c3f28395a2686..8c2b198dede03fd77f16786f8743313a34902e46 100644
--- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
@@ -11,8 +11,28 @@
 		stdout-path = "serial2:115200n8";
 		tick-timer = &main_timer0;
 	};
+
+	reserved-memory {
+		bootph-pre-ram;
+	};
+};
+
+&wkup_r5fss0_core0_memory_region {
+	bootph-pre-ram;
+};
+
+&cbass_wakeup {
+	bootph-pre-ram;
 };
 
 &dmsc {
 	bootph-pre-ram;
 };
+
+&wkup_r5fss0 {
+	bootph-pre-ram;
+};
+
+&wkup_r5fss0_core0 {
+	bootph-pre-ram;
+};

-- 
2.49.0


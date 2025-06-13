Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA445C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920F382F28;
	Fri, 13 Jun 2025 15:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eAK6QTcx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7E9C82CA0; Fri, 13 Jun 2025 15:22:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264DF82D09
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-adb47e0644dso366731066b.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820935; x=1750425735;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H219KVZw5grLTyoQw9SIkS6lcNkeXNDs9oZGAD+Pn6w=;
 b=eAK6QTcxdgula9ouVRbLZ2oYpQblstIrLnkzolqlGvG3krROeWYHzIV9+pl28N4nkT
 Yw68jzGwcIsC4PbGPSZO/STCfn0BAdR4PwjKCjY6ux1UGy7mHYP5hsbEwiAz9hnLmQcc
 gQJdT6dPtYNnUCwWOzOWCXSwdqPDUAACoakYwS6DmM9otueEwP7VFwWQESMvxhRDqAvn
 4F8LOk81o/uSTMG06qIb/PbwbBDs/tUXyDN+6AeqeuF9yJHMqIp7NkuXoRYc02RozhMz
 0GwvVFVXkHbJ9xHWsRVZNesr8ZbrXG3DJ0vWaf47obaPMer18mThWnXAHdkDbR3bpfbz
 ri1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820936; x=1750425736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H219KVZw5grLTyoQw9SIkS6lcNkeXNDs9oZGAD+Pn6w=;
 b=TIGn2aceKvnUgF5V/apUYJzVZ568YpNccL9rZzwrXE+c7CLCbTjDK9GZovrUkChrlE
 wjuAYkUqNiFSSr7VD1ks8ivqbP6xZTrN0y9m3rBfh3rjNtAYCt3dLJtpO0cUbO8nWhVt
 q3JdIKzGCm8BJUSf9qjXq5CxTEJdWalsmJl/iPH1KydVOWq7L/AzD6vXy5N+wKLcHdKA
 NfNMqKr5Zn9a5dHIYtMCT7wr3e07I3engBukQLQStK0xM+RN1v3yN+kXE6AG/N6GSUey
 aCc9TJsznd0o4bWyipcy+iM5yJlcLjpxgli2tvgiUEc4RBeBi8TwgdjoXBOsnPKQXIXt
 SOgQ==
X-Gm-Message-State: AOJu0Yx/u6aAUq34DcwFKZK0se2D5G3Zu6Qqd7rq9ZoTNcyuaFVGLim+
 oSq4uBp9WVZi0PWr4f8XcSAN1KD02yqna1ML+KZ2SdHddZPZ4Pvft1TZ+2/clsShEQuBwdOn0HK
 TbccD
X-Gm-Gg: ASbGnctfGCyTYONfSSFjfJHjX/S86Aw9Ot2SXNtFtYNlyV5ZmeBatvDcpB6kHf2glo2
 0qR6tzOlLJqYUaqfFOaFTaC0GikkCiLAEh15lg6cseuXWPOIO01LTWTB5H4v6791irf2XyBqr7J
 TyMJp5tKZRoRNrn1YrdseeARK74LNx1HZk5dbDxE65I5558PV5nXf1W7Po/X+MaCT/JFkBdxVhz
 hb5qET7Cx4iZ1iaa4svA9ihja6vp+VEbMxRm3dhmK+1UAWbnrTO+cX98a6KlZt2LRO+m5JanRHg
 l6RaeXtb3tqG6t45chuFvpQQH8Luhkq0UY6c//ugt7hf5b3zq4YaZMjFYp8=
X-Google-Smtp-Source: AGHT+IF24N55cv2xdb8c27qoGQWzV8twAHp/Ozb1q2y0oSQmETI2uhuvfCoTpgMNHkLa5lSGiUaDYA==
X-Received: by 2002:a17:907:3d45:b0:ad2:2fdb:b0ab with SMTP id
 a640c23a62f3a-adf56630427mr67170166b.29.1749820935601; 
 Fri, 13 Jun 2025 06:22:15 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec81566afsm130805366b.19.2025.06.13.06.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:15 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:40 +0200
Subject: [PATCH v2 20/22] arm: dts: k3-am62p: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-20-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Zoqhv8UWHGbqUQ4qIa4qJq4nErwA6hRuiIIjgmPZ2yc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1UdnHJvbDhRKz5nRJJ/1mM3tr7eqbt4j38C8PMvfB
 0RFMlZ0lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwESmJzD8D3SQm8913vBekOH9
 d2HBHVpS6TNOWjS+1y5SZhQPrvpxkJHhT6er/pnJNT6OnFFSXyY61i9srYxl9eKMWbyoK+PFi68
 cAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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


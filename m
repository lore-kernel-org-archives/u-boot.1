Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216FECF887B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB248413A;
	Thu, 20 Nov 2025 17:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dA449xlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977058409E; Thu, 20 Nov 2025 17:05:13 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6FCA83E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7370698a8eso135288066b.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654711; x=1764259511;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zCW/KzqwTgPbwOzgdpVxKt0fOuIKjwrbFupJyE3SaaA=;
 b=dA449xlT09gSK0IDBMDLiXqfTMFkOObhx3sKhRtgXm67PArXm3CtTLmAWhoow2SfRS
 VW4jChiUwLyFskLbvrbIv/bAwUGbIpT+t9m6vF05cjmjXuNOwfXgRGgSuGLRxR7w2uJX
 b/2eToX9zrlAA2XmPtgJRF9ayvPgUMhvJuDSPK691O9Z0b6dia/EjuLh17kGPUl7rwSK
 AGcgQ4QH689yoWZ4EAqGe2o+2+c5vjizNq/DwRsvl7dslehR0OPsluw7lvMHKDFYKtrU
 ImUBArUXjHAYpdydZ86tXAwqgmngml32jBjMrV+dBm/ZEpA6IOA6yI2hbuXuGFlT2kNv
 SZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654711; x=1764259511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zCW/KzqwTgPbwOzgdpVxKt0fOuIKjwrbFupJyE3SaaA=;
 b=MySXAqbtQngPFRXumk8WyfoDfb7k6XBOY5kd4njQ23/S8ZbAXY7sXAUzvjFhcFCCB4
 Ok5ID8XTJvc2MVAwhSl/8wDZiFM/MFqPnkeTxeCar0r7rk/Cn4X3rvTEDAHi80PFTnZF
 R70x6vaTe7yIL4+PRLng7zFFORHzpc5sci9ZlsJp5arEQRIw8opMOF8Jw/gPG8X3h+Ag
 hdEgicma0QelWoUypahvss4yaPld/Rz+4bSHGuCphK07Ce1G/adCF/voRJ2CpCeug2XF
 u3c2m/8yh0GHkke2RH14amvK1rIWMMfk1ake44BvqhZoZQJmIU6U+b93b25gv+EPK9zW
 OdaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZhgA4+ojV2Kl8Ncs+7P5anFoV0FkNOZOHSfRsGF9Sj2bDGYR0ObUP0EOo0c79R/16bEUZNgQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxtX5lhWF/TGJmfS1yc7nJY3bISnUGvHZvs42m0MoDhXhWqT4qt
 3WWisDdRJAYtNz+vjFo97V31gjNgP8hM0AL93G418tfaqCoN075CuuV5aH5IPnYgh6k=
X-Gm-Gg: ASbGncsHSY4pWZGvyvdBuSev53YCpMeNwmTobu5RIN6fBsbVwjkCN1zIgw1/8VvKTuh
 qzvfEiN7NGnHJArNPCNMIqsnCXmUTXte93W8wh28TF9eym3zBvyG+6piqB8+eyfPhjDg3LL385Z
 qmODKGAgmmwSqgmqHJT1FvQEULMdQJii+C61hO2K4Dn3zhRu5cr4+Xaxau6jEYjm0qz9W3XqqQp
 t4WrbHl4F3kXNBAdZvjlRoboSjMqTSFdpJ1Ez9Nj+0v3OO5afVSszePw0lVL4LSqpdImLqGzp+C
 xV+CntwNo7lWP5PgS5i6Ig1GYb36NAQs2Hz5ZsyCZiv7NBoMI8qEKYxyD6tLb1ZQrwfKEkxzS3W
 XAlqHwqLS3t5gmj7pcI7du3w1GvY5hGG2EHpT111FJo2n2l1laCHfyGvVA38XqHvUQmkDGfmXFy
 imGC+aRP4=
X-Google-Smtp-Source: AGHT+IE6xiafvPMtcszQAG0ZxBD+Jotw1Q4yhNAfm/eQJrAugO6w94R8zPn4+MbK9GG5cgaYVzXcjw==
X-Received: by 2002:a17:907:3e8d:b0:b73:4c5e:eb5f with SMTP id
 a640c23a62f3a-b766abb4f0fmr3362966b.37.1763654711016; 
 Thu, 20 Nov 2025 08:05:11 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b765502a9cfsm230548766b.57.2025.11.20.08.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:10 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:27 +0100
Subject: [PATCH v6 10/13] arm: dts: k3-am62a: Add r5 device nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-10-6dd99a7271bb@baylibre.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=msp@baylibre.com;
 h=from:subject:message-id; bh=N/4IPP68xX9ZB44FabIhYzh+dnNlUJfRbK9Xg/viI2k=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5G5G/3SJ+vFkX3j+yS3Sw22dZWCOWXn6Zt3iSU+S5q
 Ft7Ddg7SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCKTOxj+x/torbO3+Pr48/mL
 zi/ULx47X3IlJFLTntvlywqLfZoqLgz/K2315vbnKH9o/LKkwu/ToUc5zJWvlUJO/Um++atsYUM
 aEwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 20 Nov 2025 17:09:03 +0100
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

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
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
2.51.0


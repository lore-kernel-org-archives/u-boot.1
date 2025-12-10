Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8080D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC72583C08;
	Wed, 10 Dec 2025 16:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Y65DyyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2538389A; Wed, 10 Dec 2025 15:10:53 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83847836C8
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b7cee045187so116711666b.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375850; x=1765980650;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vRw8SMAbYN7v7r8vA6bDxQh9opwZKPtnfpIHwNCGK+Y=;
 b=2Y65DyyLecC0Fliqq4O++COHAjJ37KJWkXZwEynZ9rJLMLOOOd6etNy/hRo4qo7HNi
 cLFOTolN8ELevFwA5Sz+w29jncMxUphaAEsxEYAiEgyMBf3+P52PPBcanpbKqkMvI1XK
 8O/y7oO2ZMeHpNVLJusHOv0yw119BKDNUaLtMS+pnpZ+VlvBugENuoSnFAmVJvirlWC9
 EHBUj5+4ZMd6bmmgbd1Ub0HAZ729Cb3Or6tzb7QZ47PBqinKyPY//ZVDE+NEamWcJSlH
 LD55/w3yH8ZxXLe2LkgFnXugAPC8O1O5jXQlLPXFLO3UIFnVNj4+mOglsCbpcFr1ctJY
 hkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375850; x=1765980650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vRw8SMAbYN7v7r8vA6bDxQh9opwZKPtnfpIHwNCGK+Y=;
 b=VqiaWgZaH+kyLhFw9Rof3UxP+YsF5nNzvtNrhSkY7fAFVN97F91AblnVDSXarGUjzj
 FmlnX/V38hiRoUxZKUTGKbiqhKVyFyqInvts1ft3AAu1E58sIx2hu49NBNhIprl/gsaI
 Sv14fzCY6FD2sHA8VGp8Yx0PG7loQ1G6UetsGozXym3Eu4bPnk4szl946iM4IDvoZoAZ
 B0mkgB3TVee3DoM8NFnZ2gqSrDrc91PdwWoPGow/rHSNJwibFRxhai9lnn3Fn2/g3qHz
 oGhat3bdSzEW2T+ISa6hMhlR4QK9KNyJtwc9Sef3piQrje+/nBXKo7pLxVbzu3yuI79K
 2KSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscTeOU5Jt9bcCP/rLPMFVonAwR0zKUa+d8LW0Y5bLjPLwVibqDPQ0Phldn9T+gcBBYN1UP2w=@lists.denx.de
X-Gm-Message-State: AOJu0YznOrsZu4xmlKPrs0joyV1oooS7/wVXkyTzxKSdOaPxvjNE91HD
 /u7bb0GBe3/hit21ioB3nXo9GRJsJ0ZSuseshvzjw+UBw4/kWye6+v+bD1g6fbZLjyLZ5n6hOM4
 WZcwI
X-Gm-Gg: ASbGncu/cjWusxgBBLyUU8p1IZFbRPy6rz+fGGLYWrFBp5YhpD5lJ/kcYQCPsPLKI10
 4LHqznosI4h0pQ/wVvB1iiDPjLqyf//D7JmwcJ2rhzrjKrqGEppYk/74zGW9H+TW6UZ0PtFImBG
 zMWoNwKEwC/QiYTqf9etROz4givPfp31z+8voEskE5pzENTRVvQ9fHdU/KSJ7u+RKy4CZf0YCX3
 En0QbPK6hM5P8u5uUvKOZ4XJdy+kaucrZoy8ReroV8/+V0igL/tKIKb77HGKquk2eHzE0TJ8f2t
 00rIMSfdl4yL/z1uyFV/pyflyE8E+Vc9qM6Uoo8pkg7iFpUEYvg99iR+MYMxlTcclcPex54VMbp
 gZ45VR9qKsQ0PLk6bpwQdFcp9EBR3wuaEGVdwoaZCm9f4SKpCx8fqWvgcmqkzIqTV7FVTndGuae
 QsiKPuIrPF
X-Google-Smtp-Source: AGHT+IHgRlKcSImRIufxxMWgnDeOKuBvyd0vMbMLpkfGdtLIgd7lsPcY0mNIv12cCB2K+O7To63a4A==
X-Received: by 2002:a17:907:7294:b0:b7a:617d:5f40 with SMTP id
 a640c23a62f3a-b7ce7737e53mr307185866b.25.1765375849902; 
 Wed, 10 Dec 2025 06:10:49 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4457a42sm1721555266b.14.2025.12.10.06.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:49 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:08:55 +0100
Subject: [PATCH v7 01/13] arm: mach-k3: Kconfig: Add symbol for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-1-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zbVqM1kp8JGa0VItD9+jpA2kAqKpnMflWT19zkP5rAg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLeqaUw2uXvnv/yFlZ5NW0U03relVWLn2xoEih+eCTp
 hc/+7itO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiVgUM/5PfFKVMvDb3xWLx
 y6dOMv6dPmlD5N8fYXKPvt6p9WK4xDuRkWGy2cSHE3y275Cblf1sMYdLZljY573dreemP2UrdlV
 e5MYAAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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

Symbol to enable support to resume from IO+DDR where the SoC is turned
off and DDR is in self-refresh.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..4b7cef64935c7b403051c080eba7bdb48f727bf1 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -148,6 +148,14 @@ config K3_DM_FW
 	  bootloader, it makes RM and PM services not being available
 	  during R5 SPL execution time.
 
+config K3_IODDR
+	bool "Enable IO+DDR Low Power Mode support"
+	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
+	help
+	  Enable support for IO+DDR Low Power Mode. If this is enabled and a
+	  resume from IO+DDR is detected, metadata in the DDR is used to
+	  restore TIFS and resume DM.
+
 config K3_X509_SWRV
 	int "SWRV for X509 certificate used for boot images"
 	default 1

-- 
2.51.0


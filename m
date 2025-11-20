Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AF4CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEEB084114;
	Thu, 20 Nov 2025 17:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZT8cdRCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4301840AB; Thu, 20 Nov 2025 17:05:09 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BFF8409B
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640bd9039fbso1725013a12.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654706; x=1764259506;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vRw8SMAbYN7v7r8vA6bDxQh9opwZKPtnfpIHwNCGK+Y=;
 b=ZT8cdRCVMLiSmhG7rd72WkFSsxLj11jH5l77CULGqWILWeqvGVUDzK9Eb5BZRGBett
 lKleGFLqoof6DCw918kgUaVwOjftaS7pGt3B1ro79Gtd/EAi1fBVjISnQ4oE4PrNwpYD
 FAv5k1brfkDyMNhxZUROtAXsCV6yxrQNEKI4Yc+Pe43PM9N8dhTeRvEuebU8VqMq5O/n
 VeW9/m4ocfDtOiNfz8Qf+ImkNyVVTwX/F9sUA2+JCkWoZPqZ6aqEXh76CZ2ISJJzptiI
 P0amHQN9XakyomgRFVPohM+mv0XLbKDqvDMWq86GFpCUM1Qx4LvqW5QNi1lVJHqokoyk
 YnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654706; x=1764259506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vRw8SMAbYN7v7r8vA6bDxQh9opwZKPtnfpIHwNCGK+Y=;
 b=dGJm45sw0LghYRbtn/jedjo7ato5My2TdQUBYAATQQUK3KzGQo4Kjpfhlj96podkY/
 rlAVC8Jxh1XX0PW1vI3DLkvDUXBOo3Sw0MV5ten3ChLGdLbg2Qmw95z/U63HYC/KJa5g
 zP+vdVydt0as3q48DBIW7k8P7rwMp0OiTiJ+TsiukRMpbfysBRr0YpH8+IqBn2/Bak9d
 Hgukty9ZczxuLnBwhdmQYwDyzYgCZOujHI6Ma8lXsnu3P0QFrdjByGnLhrAdIqK7XIa5
 FLdEmU9ZwZuWqM2mSkzsqbzSmNZ6zDQ/Awmgop/awm5TtK6Mk5wYMA/OBlYY59Da05PN
 /mTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgQtC0ZqZyAKl0AErFK906oXYX4lwcu4iCtfm44ghSbbY4cfIwDYpl7YF78nEmJVin55y4DEU=@lists.denx.de
X-Gm-Message-State: AOJu0YyoVaCkOflBMwZugkScvrr+iDg06imWCdxOJDq6QsBk+2pQUrAK
 kWdcJEad4y0nerT71vcXbVut/cAXW2YBVbcpBQm4wj+pAHd1uZF9CjGlGNdiPg9UT6Q=
X-Gm-Gg: ASbGnctRFhJj9AKe/HqUuQpGV8wjAtrGgZMgJadM2JA72jM7UODbcx9Db5ZTZpuYY1U
 AE3t7jACxjXGTZLzG5Xi1YuF72U3NvFsYcnzz5IaCjXKLSFodOQ7Zo9ZDEy5CQJIFiXWws3PmzY
 U0sCK8ihSfQ7wTobZBDoSMlw8yrkyXxeZxi7v012QH/qUIeTeehx6DE3G/30XshWU2aYj3x7W3V
 FWYw1XlybTT5mCgLSzHO/e7zc+HMI2Ge20tTHouGcx0E5sudJF+pVkANKZq29hiJshHulLdcBOb
 M2Fp0vUWlvXoVCLwJ6vseJMDkU0j/HI1uLjtouKSD74e2GmUQkrac6doJ2lOlTs2SWzcqP1U6LV
 93epI7IyzaalODv0sCk8FMTl5hZmvKfbXyGyWrPli6WVgl7oPLw4IY8V3tw94o2Y+XtOdOeax3a
 xL01ZuGKE=
X-Google-Smtp-Source: AGHT+IEJUODgrGDilit5mP++o3FjgkjSbGjSisNXr2bqpQjjjztpZMqdUqg2liyDPj/ar4KTV8+lzA==
X-Received: by 2002:a05:6402:34c5:b0:640:947e:70b7 with SMTP id
 4fb4d7f45d1cf-6453d078d19mr2225826a12.3.1763654699932; 
 Thu, 20 Nov 2025 08:04:59 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-645364437b2sm2330956a12.25.2025.11.20.08.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:04:59 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:19 +0100
Subject: [PATCH v6 02/13] arm: mach-k3: Kconfig: Add symbol for IO+DDR Low
 Power Mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-2-6dd99a7271bb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zbVqM1kp8JGa0VItD9+jpA2kAqKpnMflWT19zkP5rAg=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx56xtM2d/vN7brlVcd405cvYP1yTGekwd7Ao2PWc2Iv
 Ly/WWhdRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzk8AtGhos+N0y5DKe66XDv
 SX0W7h++1JdBhkn+ZNK2Va594kuL7Rn+J8r7SB9ymRKnXfYunPdP8pSJxbPEa+/ustiqt3jx+3M
 N3AA=
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


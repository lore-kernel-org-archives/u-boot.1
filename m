Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D14D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6479E83D4A;
	Wed, 10 Dec 2025 16:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bjasgHYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727688042F; Wed, 10 Dec 2025 15:11:02 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE1280077
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so11625546a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375859; x=1765980659;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Qv60IIy90U9uo0l1/yBrU0wfRp02Sm9VUvQmpaFgho=;
 b=bjasgHYCkBoQwbiw2/Em0vlxvhaBB9NdSTXikoLYM1fe7+IvnxCOEY6PEe0GstjsMf
 lb8560RcZhA+NyfG4JDBoJFG2VDwMAKyggLCkRm9rRB7oMZBEvGBAtPoRFNnWozjwAXR
 SCo8tQ4vR6v2HCZC4Po0WzOdF3I1MNYh9DeKg5vkNrLfaqMFEp5e/Ai5+Kij2TPiXqZt
 kohcrD3jTWVoLjiq8qI967TSJw7aaDC3yJl705qHXdUkaFauYOqNEDTv8t65SIEoicoI
 7EJXDkzgjUTpNEG6ajg+8XqqfZ4fgZTW1wXdD9bme2MXn86cns81twTQLSPBWYd1tG0y
 GvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375859; x=1765980659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0Qv60IIy90U9uo0l1/yBrU0wfRp02Sm9VUvQmpaFgho=;
 b=Wr4jtscTVCSX6O/EcVJAEyq7wXD7eFrKXgBn4Neh1UPUm8C+lff8a+83o6NG3JsQpu
 NKCojMS8aYPDc5zL6bKCX1QypcDF9ITfn4oIaYj7tEK7HshQyldeSPSKfEYKODjOv6BR
 jXj/5UV+acliGe9BmpZ5+0mUdDrsfUWAfxr6IaN4+twzQLgJWdAJFU2rriqlNcj6aV+d
 IQ0CEDWYlkcjeDPFtQWFK72hBf2YuKnBR8YtsCZxDKiDYVFXzel16GM3liBKquUM5qqr
 rxKFvAcit8W2kiy4L8nq0s/l+BuSGe9qqiqByBG/T4ZXfsG6RGiXOeqsdyVp6tY/m6Lk
 3HMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo4YlP+NNyT0OToi9KnjUh/pvMFOMDB1HDHuNmMhSjEipYXsHj7s0o858O39fU8YsOgs6j8i4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3KCfe8cT2IJIYEd8d54bi2I8rFABjhhOG4s9PwxzyDhq1rxHj
 LP8jgBEAn4tvlWrg7LOsPkIKZkpfrshvp1A3ZmwLyT4TzUz1G2Iev4wxyR8NxjOCx4tmPCaWv/e
 Rtz/s
X-Gm-Gg: AY/fxX4pVmpBYdCWgwyhWp6EWKbKp6+OeYyqT9M3rMraqsX/ZnoqOCA2C1x/CUQwE1h
 fvuCqCbh44lcnAv2vv0uGhQLG0Jie54VEZHdpk8ItThViSqvU6xPN7qxtHwH0spqqqT//hkggAC
 gg39PAslj+SitvN72oZYappPpnrEoki2oBRrz5TIqUMETymLiDGXpBKv3obA/aN+iDw8CzSkokU
 kC3uSG/kar9l6/zirXIcZpUf9ZF6tX3zWYhire3di91/EsKH2NGbJ4wOMKqar3plEfAY+1ecZpx
 F7HkIVwhNX6CYN5h7cSIp6NXawbEbanXdUARWkxq7OXvxRuzVtLp5Y7+oi3IeEvuJ/2BvJzH4Am
 aN2r5347ZUl2+Zlt/hMzc+aiqtB1mwTeuScXuFTpoDPGYkkF2k+nzOZw23tnUUhzplguA79Aw32
 FRCQckOx8R
X-Google-Smtp-Source: AGHT+IGgfFUEBg3tc2rRU8e+3g+fK6diUPNDscxeIiZX+XC5gbyIqzsdpcBr5DvTU7TZEyLRcT+yfQ==
X-Received: by 2002:a17:907:94c8:b0:b72:8489:7e65 with SMTP id
 a640c23a62f3a-b7ce84761b9mr286769866b.31.1765375859536; 
 Wed, 10 Dec 2025 06:10:59 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49dd380sm1677403566b.57.2025.12.10.06.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:59 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:02 +0100
Subject: [PATCH v7 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-8-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=msp@baylibre.com;
 h=from:subject:message-id; bh=K+ZIw9M+Eex4lT8pGvItMFQlxGxVLNvn/o4CnpufdPA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLevNle489K6s6Yde6SdNy25sl9w6ZtD/RybTKMdn4e
 E7daxazjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjInYcM/8zv7T9id3SzqdGX
 Pxzzdn+dv+/YLpFnG3/H+CzVKotaHZjPyDDjAK9vjXhFhaBMpdkE9p2/lp+aZff4v+Tmy9euaDx
 stOcAAA==
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 24fdfdd7f1d9146f0cb6dde333d2bb54df96700d..9fe671c3ff458189ba04ddedd0f2fa8894629cec 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -197,6 +197,15 @@ void board_init_f(ulong dummy)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
 #endif
 	spl_enable_cache();
 

-- 
2.51.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D736FC79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BDB083EF2;
	Mon,  5 Jan 2026 17:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eAAtbTN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB66839A8; Mon,  5 Jan 2026 17:41:36 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2A483E0E
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-47d493a9b96so828895e9.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631285; x=1768236085;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=guha0+ObHnVDO8wUswyUSJsMbnYHqR9CrIJqzUDHY4I=;
 b=eAAtbTN7394DLQ6hRyqFZAVJKZogsiUTT/DFvBdoqAQrI65NH1ivEJpzmJ/p1W0D4W
 +6d3mil1tfKujiTTmVKmexUuK+U/OwcHon4NFX/L5XdWHe3oMqmwdrDje91OvNaeBhIx
 h4j8EJJRoJF55uEn3PLJU2sUfnsle5qg7pZhibwTbCsB4zTk3pyES0fPD5f3ci9n6FgT
 5KKwtXGi7WpOSEcL5u2dyRtIjChop6CZ6XXiFNQDrUf6KDTyXCcfXuRw/aNMVZe3EF/g
 UGv0d0fLrVlpMPjVnUSkUB+XMdvjfurLXcBGeQq031MTuMCJT+EPJetTM1Z985P176iI
 44FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631285; x=1768236085;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=guha0+ObHnVDO8wUswyUSJsMbnYHqR9CrIJqzUDHY4I=;
 b=KiJDCtFLnCM4NpH7fbel2MRp5VwxoOMVYFbAKl+aFCDb3OUAdQgQRv6kZCjGU3kGHx
 K6046NDcwSDpudKhdbzqGplho1hVQChUAupVWhYTUdZhkCD9Ix7gnG7A6UdYXIEOCX5O
 NUxRBM8CdKhAjyk2FzhopiBKycujh5JchVkoA0bcq3vSYJBzgvhfyfB7BkdE54U0eIza
 VqGUoZAzwA62itoUXeaAbOp94qINDRbHIlTxghCKIIXXtUGXG5N9I84drW2j1zQHKFCt
 M6UZPRBxCoI5YL/Y6uL4kANOTSjPorFO9PzXhmrTMDl2NfH8MzwYUWO4Dk09y+0h4wjE
 dKNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWccf3oXMdfNnTbfvmeDQRnIldJ25S9a7bXLhw53mZcfTx2V2I3oRT53lZV2HLH7uVc8HFDYe8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxj6e4D3Qs4GWC+OUYtsnq5ggZbJF6AN4/L0Jj1LuQhKn2Bwq4K
 mQKrVEJ20qOtvyyk8hE8UD3OHAGLsgkqz+cc7AW8sopkAwkeT1XDqPlZsTiJYMAd8No=
X-Gm-Gg: AY/fxX65tYn52t9dUXphy0yxwi8ibEjzQCudhODMPHLn7J1nf8jDoj7IyxvK0Ef39qu
 cRK9y7bjc4azVHGxr8dQOXnK0CnV43BdtS9Pm4ghQIN7HK7xinVsFN4xVIYN6sfnTCGlkg2zn8k
 ai0Zjv5imIj0QTx3JxrE1fhVUgwmQ0NdVdjrhxaVfuqYne8KAxuBrjVrQi0YdZxvCLwMX0JP52X
 AWGbCKFxaK6yUZxtPrsHkkgPuyRJmUNKN53g+ygI0nyxzdvJT0+QYb50zW7QASfgLkKO0dyjqRM
 ojzFvNprMMDVEGqbfix88fikTKDtUMyoM0cIQSPMMbR6cYTRiQTlg7Hdqt1a/g+MHV14WQyCPoo
 jRvs5o6fdvo2LkgnK3Zg0Lkt6Ip4ll5M2GMyUp2y9y3CZiKiQcphoXEquZRNK9qEb57VkoH1Ve5
 UnUndCzXWz
X-Google-Smtp-Source: AGHT+IF/AisuqV5o4T1U2eDyY519EK9AFlImSOKc72UZaV4p32cYcINJ1b0VHHPCpRJyIPDuDtoepA==
X-Received: by 2002:a05:600d:8:b0:477:5897:a0c4 with SMTP id
 5b1f17b1804b1-47d1c13fcfdmr492759185e9.4.1767631285352; 
 Mon, 05 Jan 2026 08:41:25 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d452c69sm203518325e9.9.2026.01.05.08.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:25 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:53 +0100
Subject: [PATCH v9 08/13] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-8-7e33f2c77dbf@baylibre.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
In-Reply-To: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=msp@baylibre.com;
 h=from:subject:message-id; bh=gVyc654uua2+E2sbhP89IhpMdd18THC7tF5/0Phx6hY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol13PihN2ZG3v6lIQFb6/9Ilz4Kqfqc8WZ4l7nQ5t1
 dW1qbvXUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOZEMPIcGlueaniBK5JF10T
 ZqvyzUjQ/mK+6+rT22FrLjrE8/hzKTH8D9KYd7buSjjvgqBrRld3rLKfNU/H08mstXJL1Zuv++O
 bOAE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
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

Swap order of setup_qos() and spl_enable_cache(). setup_qos() is
required for LPM resume but spl_enable_cache() is not required. There is
no dependency between the two.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index c1c7d669a45f53b7528c80d44bf9b914fed1cc10..74e598d52420cd2ff59384c69d1b038a40e08cca 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -194,14 +194,24 @@ void board_init_f(ulong dummy)
 		enable_mcu_esm_reset();
 	}
 
+	setup_qos();
+
 #if defined(CONFIG_K3_AM62A_DDRSS)
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
-#endif
-	spl_enable_cache();
 
-	setup_qos();
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+#endif
+
+	spl_enable_cache();
 
 	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
 	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {

-- 
2.51.0


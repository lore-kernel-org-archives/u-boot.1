Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8086AC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 10:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB0C87B50;
	Wed, 17 Jan 2024 11:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RojUnitM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C5687B44; Wed, 17 Jan 2024 11:18:25 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD06B87B47
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 11:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e88012233so7599345e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705486690; x=1706091490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYfEATmOi+dh1RkpjsODkIfh8J2USs/3oMpWapDYgZc=;
 b=RojUnitMXmkp/paNTkCN/vP0tNkLK7rCJ91yBmbt1tbP+cNDz8CYIenh+ogftycRAF
 17rQGN5UhdPeeFashB3MYIdfKnF8czvd2YkqOZoZcLb6Zz7PiRJCiPiZf4G7qHnOdwJi
 n8zz6CWmOq4Y8DaqYSjv8KSgeiKscsHrqpDPgbWt1q83DQRjaZ2pf0aaSbT5UZvG7Bb4
 dNAQbNdp1PQUVlrv4PtuJlg69PheEZ8L70oDdAI6YTpsVjkxDojNZzA0cJBlwBJBd+q4
 GRhNBs+WXqxnFSN8f1kXiSaIpaRNxhwMairGx+gQIWr/OlYB2KWFeWmnOhGGCQ29bmro
 8xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705486690; x=1706091490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYfEATmOi+dh1RkpjsODkIfh8J2USs/3oMpWapDYgZc=;
 b=Cy+SsBz91NsEbhPkIQnayXOXZiAXWj9ycaW3K5j9UvxSvdMVjYrMLMI8Vz/YC7k9Z/
 2R8tpWirj508SWWRWjPVtuOhRJ3qya364l7YFoxRDKlWA+keKRMgdVikUNO6VoOWKvhR
 CxAdsnbELweSObo/lDBmuiEO0pf1dELhh5rHsxe9TMr5XA+okjaJz0ihgETruHijOA/n
 sursPbyI1PwjJTfR/FRFgFwuQUxcJlQOINTVLm28eErSbCjDrRbsuNBiCD50X/NmUcOt
 OdH4Xqcf8/wRu23pTTiSRQXdxPxUqiDF1LNY5rvOaccQHygjltdnQTEuj2q7CSBFb3WQ
 2nqg==
X-Gm-Message-State: AOJu0Yy44rgVluBQ4GGe6e3kldzAQKTIvprSawXRAo4NBdWxL0V1DIY/
 TLmr4R14moT1Ji3zlgDUNtE=
X-Google-Smtp-Source: AGHT+IF6PA+n/vCmonBUwy5yyDWkf6dBqeLJHcGbfxd3TpWtXlv/FYlPar/8/8spHd/Pwhqwfs/RXA==
X-Received: by 2002:a05:600c:a4c:b0:40e:4e14:45bc with SMTP id
 c12-20020a05600c0a4c00b0040e4e1445bcmr4790889wmq.13.1705486690402; 
 Wed, 17 Jan 2024 02:18:10 -0800 (PST)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 s14-20020a5d69ce000000b00337478efa4fsm1305849wrw.60.2024.01.17.02.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 02:18:10 -0800 (PST)
From: Max Krummenacher <max.oss.09@gmail.com>
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Andrew Davis <afd@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1 2/4] arm: mach-k3: am62: move device identification
 accessor functions to header
Date: Wed, 17 Jan 2024 11:16:47 +0100
Message-ID: <20240117101743.3955852-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117101743.3955852-1-max.oss.09@gmail.com>
References: <20240117101743.3955852-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

mach-k3/am625_fdt.c does fdt fixup depending on fields in the device
identification register. Move the accessors to the device identification
register as inline functions into the am62_hardware.h header, so that
they can be used for other functionality.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/mach-k3/am625_fdt.c                  | 23 -------------------
 arch/arm/mach-k3/include/mach/am62_hardware.h | 23 +++++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-k3/am625_fdt.c b/arch/arm/mach-k3/am625_fdt.c
index 37806907af1..970dd3447de 100644
--- a/arch/arm/mach-k3/am625_fdt.c
+++ b/arch/arm/mach-k3/am625_fdt.c
@@ -38,29 +38,6 @@ static void fdt_fixup_pru_node_am625(void *blob, int has_pru)
 		fdt_del_node_path(blob, "/bus@f0000/pruss@30040000");
 }
 
-static int k3_get_core_nr(void)
-{
-	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-
-	return (full_devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
-}
-
-static int k3_has_pru(void)
-{
-	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-	u32 feature_mask = (full_devid & JTAG_DEV_FEATURES_MASK) >>
-			   JTAG_DEV_FEATURES_SHIFT;
-
-	return !(feature_mask & JTAG_DEV_FEATURE_NO_PRU);
-}
-
-static int k3_has_gpu(void)
-{
-	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-
-	return (full_devid & JTAG_DEV_GPU_MASK) >> JTAG_DEV_GPU_SHIFT;
-}
-
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_nodes_am625(blob, k3_get_core_nr());
diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index acd2d109c2c..ea5bcf5d3de 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -79,6 +79,29 @@
 
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
 
+static inline int k3_get_core_nr(void)
+{
+	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return (full_devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
+}
+
+static inline int k3_has_pru(void)
+{
+	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u32 feature_mask = (full_devid & JTAG_DEV_FEATURES_MASK) >>
+			   JTAG_DEV_FEATURES_SHIFT;
+
+	return !(feature_mask & JTAG_DEV_FEATURE_NO_PRU);
+}
+
+static inline int k3_has_gpu(void)
+{
+	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return (full_devid & JTAG_DEV_GPU_MASK) >> JTAG_DEV_GPU_SHIFT;
+}
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 static const u32 put_device_ids[] = {};
-- 
2.42.0


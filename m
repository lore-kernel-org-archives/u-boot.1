Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9116BC71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F28A982DFD;
	Fri, 13 Jun 2025 15:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iDOHnzze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A18482D17; Fri, 13 Jun 2025 15:22:05 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BCA82CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad89333d603so421763866b.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820923; x=1750425723;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GCm0WtfO78Oz5ehYnd53GOoAyFctm0Y3FFNG2a93lzI=;
 b=iDOHnzzeqKA8LddFsa2OjbxN+6n13iTYYVPNhE8uNdBHnDPwcbEWcJ3KIIWhKqTkgp
 CJghyZd3G0XrKqR2+Br7LQFNJV+DZIZEL0CYzSNpZTPEkmwozaD/RR4B+7a6HIpO2wLa
 f3n0MYzcCxTW2YAaZNN0bMydmaU0CVpk7RatsaP404ndDqLQem5S2C72oUpAgi3pdOU9
 9NlibNshP4R6Iu+kiU4iv55uiI3P3n5tfrRc9RWiTevIfrwW4jvOHc5IAV64PC7tC1qP
 bAjJ8W7mK0TSqacz0CNpx4ImItYfWx0VwdLcjR2qCHF74/JlxmFHdWFzKrqofh9uUXD+
 jqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820923; x=1750425723;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCm0WtfO78Oz5ehYnd53GOoAyFctm0Y3FFNG2a93lzI=;
 b=mZPwhgPwfjGnxzGX/1PytW3ui9oD9Y7fzVZFpIPt3sfCOLeyupeP0lynBTpMjnfMGV
 oXkYg31K0pfz7+k9xEZesEjsxK1dJ+rUN4sUY9NmS6ABF172phDpZsnNwAneptRYyEY1
 sjX4ri7ZN110qNgg26JHxdckO238icVR5NDp6d0Rz0kFE5PnTtnenQkTzXZg/NNzKRjD
 s1VaCOTmY0IZGja8AAw+u48JXf6bmJKB/dYeCoiAEPqV1PQDnCCxRokDRBgd0BKe3H/J
 HZAtqnhspGCYuJwki+49yedtXInxTqbqXQnrTgrK0+ohnTbkcQqU+I8o+Q+YWEYYeOdL
 go3A==
X-Gm-Message-State: AOJu0YyjeUaa3urg9xo5ALtVO0igry2aHl31fzufi9shWIxvBDhX1kxX
 ahKIpnUlwErpgPNIr7bp0tC/xdbRU64KKHVEA/yLnhJL0CapFPJQTukFDsP3e8URhBb2PN1zWmS
 G2rjO
X-Gm-Gg: ASbGncsdKgevUEUhzCTQNypVQptgPLc3lK0r7RvG3ZucotNrxAbJhbMZOxOiK7JiP/P
 GQscStXm/fvEOWSe+JTjNDBOObKEN89YblQkhWim4GsPpXJOr0Wfb82QeRdlQwmuyruvS78KrVZ
 0He3DSvOm+JUzxcuOfbT432bKT4eOT54O3du0xQf2DfELQ9cQnGj21zBJDi9nDw/9nxrnL3XiMf
 dR59X7+LMfiKkBKXUH0l+WVs8S63U6yOzKanX3mw8ecog+mGXdyRHUS3ZFzkqaipNVl75PZvRQZ
 c0aPQqnU5Jf9q2ERtiQfnA1VU9AZLFUX/r/0XfbHOSlIQmJqb+COu6G1Rm4=
X-Google-Smtp-Source: AGHT+IH9MkEiD/9IjzMGqkvCH2/MRF3RxNx31on2X+ZRiPdONTUWRgyE0PJLtz7QBuj80ZZZR6Rdxg==
X-Received: by 2002:a17:906:4fca:b0:ade:433c:6412 with SMTP id
 a640c23a62f3a-adec53e92afmr333628466b.3.1749820922742; 
 Fri, 13 Jun 2025 06:22:02 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec81c0135sm127821866b.47.2025.06.13.06.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:02 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:28 +0200
Subject: [PATCH v2 08/22] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-8-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027; i=msp@baylibre.com;
 h=from:subject:message-id; bh=SfzC7fBe2v/ey7l22O0xntG0VIP5KpxJcrlNayaufZs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1bkZf2ULvy5rr1jZ5VGbnnVfXmFe+t2wfacdo4+r3
 5xypoG/o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACaidYyR4d301ZMeBL8MPsP7
 pLWmaGFEkvv0T6Vv+Gb0lsdtOCK9SIDhf3T4Ctcsfbfvmdu61iu0+j1T3dfz8c7JwO2zZ755tVF
 +PgsA
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index d50de75ff669938c0803c0622d040fc1e5d0cf4c..7f2e8265bc2af942edbfcb94b8149ec15862d41f 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -192,6 +192,15 @@ void board_init_f(ulong dummy)
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
2.49.0


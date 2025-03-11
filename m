Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042CEC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A7D81DCA;
	Tue, 11 Mar 2025 14:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HQOb9tTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A1AA8083E; Tue, 11 Mar 2025 11:33:23 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56B1817A5
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2a089fbbdso374402066b.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689175; x=1742293975;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lsubHR8Ol8pfsT8krZWp8t/kYmu9lzpqiUjTuubyI74=;
 b=HQOb9tTLWNrvF8kf052KZH6hpk28W8OpGN96SnzohhUxM1QFZxHQTjoSBF/ewh1exm
 SLbuSl1r8r4mgxZo7IqCK5+Di7bF3CfXTnzwbUZ1gBOx2d8yl1765+cIHg0v7xNqayQy
 xcD1cGeB3XN2tWkQRnRA0/e/qKsqmNkiI1ZEBy2fjTzcJPV4K9DV44Ox0qpwK1r/Ta7K
 38NvgsvpxhO7RF4CpcekfKJD7qOg8b5SxoCzYB5SJ/I4aTOcMtTmRqOsyFGu6/0f9LQ7
 c2xUoEThHBdfpAOxFFAN8BGLvgtSKmAk37ydCF/RkkQ7icBIBsyPdOh6VgB/0UIBPR66
 7JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689175; x=1742293975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsubHR8Ol8pfsT8krZWp8t/kYmu9lzpqiUjTuubyI74=;
 b=OnxacPIUuOvvoAYwkWEneCmvUt4TbhdLY/8QocnJnRER+WKCJCaOXvOhUAhH3rO9F7
 4Oz+QFWb7gz5CxbsAHkc/BJTRkRIvhaD0B6I7jipxM/cvpSsqC4mqJ6XhQJJe8TjZjeR
 W51V7L/GnemnDdLq+LjGG5IzVHzDiZcJYdaF/NzHTqUDA4uSYHnidSJJwWcUl+0Tmtz5
 T+ODJSsY2+M3AzooRKh64xsFBObpVACzs6XHTckdxj8Y+eB4MXKkd9rx8aZa50mt9x5x
 ZomtZ1ZvFr6UB9G0BULN8N26KpXNdGhLCgWRt38FqbKcq7GkJeCOPm8RjLC32rxfkBiL
 pvXg==
X-Gm-Message-State: AOJu0YwT23Rqd8K2Ew9FJeObMySKMX1quNwlHlLR6FFcYwHXi7cCh/Kj
 2ySvx1YdF1qMS0QrzJ9tcfdEasqXqHwO+E0dSfPGdeTBYlxHLC5a7aN0hoPolBKtwMCtfPe182t
 d
X-Gm-Gg: ASbGncv3/qH1y+AMLB+9oqG18NzkDt61071MORr50auGuMImh4u0WAx+dI7jkZpoW0M
 +PIk+Poxr8pZ8Rg0S7T2hu8Y872f+eTsfd52g2zwcGQjYSCTe6iwVihbrI12DJDQR1HIQMZPGE9
 aatw/Ez9sGljrBirVM69n6Vy5gPi1T+CuxXONvAmxRRBouxi06GpynoZ4oICaXrKBvhgVjfF8bO
 3hLLhZIEPd/Ey2gbRPu3tkSdxlr42bc7p/xT5pmrfSUyFBJFUv9jXdxLAld5Cwy5SYlROW0wdXr
 OVeyEW7jmkfSVHbXeyh6KwIH1zWVXWfqsHImTSMP
X-Google-Smtp-Source: AGHT+IFfEzlrwCjbn0wZvFZhUHShRThJ7CrJMAY/irvxUBg8wyubiNWS19SmDrPpMEGT/y8oVNKLSg==
X-Received: by 2002:a17:906:340b:b0:ac2:4f30:5033 with SMTP id
 a640c23a62f3a-ac2ba4ec6d5mr315262066b.15.1741689175572; 
 Tue, 11 Mar 2025 03:32:55 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac27e72fbadsm520097266b.154.2025.03.11.03.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:55 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:47 +0100
Subject: [PATCH 08/19] arm: mach-k3: am62a7_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-8-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MZlxq5Ruc0lg/XjXde9FFw+sQAxv29l/UHXg4GlhMfU=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCPKf3uy+6s2LxKhTCwI+J2t4Tf0UWh3gFroytiLcq
 0Uz5m5SRykLgxgHg6yYIsvdDwvf1cldXxCx7pEjzBxWJpAhDFycAjCRj56MDEf2PD+0fJ9Qiedk
 E43DzSZPXy/nbDVpEZ+s4Va5zSaBfTHD/5CQTfvUe4QSnvL4bvH2mFOyRk5zfe59C6eZbWc0rpp
 +4QQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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
index 7697e365c6ea1b9a4819fe813a63d4ee8fc9de8f..a7f7b9b5c2eb48a1049d1a79980e0cff83321a98 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -166,6 +166,15 @@ void board_init_f(ulong dummy)
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
 
 	setup_qos();

-- 
2.47.2


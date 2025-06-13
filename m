Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D4C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C0E782E17;
	Fri, 13 Jun 2025 15:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yMem25tI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B1C582D17; Fri, 13 Jun 2025 15:22:06 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C14D82C30
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-606ddbda275so4215423a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820924; x=1750425724;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1+SomWi3H77I8TRlw0ITmjSWIDSsWZUYho6iXyCxTXY=;
 b=yMem25tIakJ4L+fjcYWKAVhPKRdWd46Vx0wzRCltDeIVLczMBMGtvk/B6ctmRzs3QZ
 uvrEQtYFtdFwe6YM17ikL1VjBfg835bnVaC8WJYux/k6nQMkN8OpqmfakZViTZOu+iE2
 TkD2Jt7WVhNyOA4Mq1J7d9tnb5FLtc+V0CGpFU5fXgm5IxMXdMTTUkvoSrtScDoUq4AN
 f6n8Y6VIqDnVi+FgircDKWqgbIwk237NP8cLZD4uq7dETVo76iK6ypZkykwuQa+21l2a
 psWoDpoFWQWsKnOGa7xyX22QhkYMEx2BtbomxP7vnbOTXONFl3oNjmK6jQZuFeoaKYIT
 z/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820924; x=1750425724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+SomWi3H77I8TRlw0ITmjSWIDSsWZUYho6iXyCxTXY=;
 b=iR5scf6YKSP+nohk6eXTe6m3XgNR3ikwwbNEpUrJrUY+OWRbva0uZ34gk9P2bbx+Sv
 r3sVuDwse8scOZfDyE+H+qcrCJQSFV0UNQA6Hk29zLJ/rwF6EfGt4jY4TQrYK/4cwvtJ
 8DPtp384HrVKXD447h+tcaPKueXttmPkkx39bps6DRCtlqM0dzin6JayMavR+fLM5ZY+
 n941YGKBiSf+qijyyJlWvvG7On5xsVJCn+cewe6IvecNVb5MSpNl8K7GRMWa6Y6STkrj
 oJjmtAzemnruIcr9bT6afcyezUnFZSsYx6zOmTcy2bmQe5QkZ4UA1MqzeIeisZPOcrsC
 K1pg==
X-Gm-Message-State: AOJu0YwkaFd8qZYlBE6iWvWC0OF3XlZrl44LSAHzdUCTrCyX6FweG+FN
 yq3C5BE1Klms15GJi0GQAQF5t4ian4owYxl66sPRQhDMZeK20nIUhqokKRbvt4AGKmMVY1Qlxi7
 +RTaJ
X-Gm-Gg: ASbGncs9hgR/pF8ZeJA5YukUnmyQODAyFBU3u6Ovr+RYxa6X2XkR4LIzInCEovjNiWM
 yBbGIlUJOhJ8Iy3Yzrivo/UmXQnULilZv86YE1AGq7cZ3LejzsHremMe81lN0mNSRewvJpeipVE
 2OA60XBywjPtyH8ZbTvffRdtOMUI0G1MjMdIwZ132aJWsXJVyYpxYeIl5YhC/LA/42sFR4WVs8r
 l3Yl1JDP7UYSFgLSHmIDdjefHUlnM95hacjui8bWiUAH3BLasaTLvfQgxG67ZxVHDH+xAaLjg9Y
 vZrj5oWVk9O6A3Bdv+iiez7m1spB6n0GjbE6S31UXYIGZS5s0X10Jq5gl8yYAYig2rFndw==
X-Google-Smtp-Source: AGHT+IETFlXcSCeBh7ZRnJdEHsk9EroN3jiULS8jLJmZaw2Szp5ZhW6hXOf37dYdJT9ZVyMoimR5kA==
X-Received: by 2002:a17:907:7faa:b0:ade:3bec:ea40 with SMTP id
 a640c23a62f3a-adec54dc9femr298651966b.10.1749820923848; 
 Fri, 13 Jun 2025 06:22:03 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec8158d8esm128490966b.5.2025.06.13.06.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:03 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:29 +0200
Subject: [PATCH v2 09/22] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-9-3d233aaea355@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=msp@baylibre.com;
 h=from:subject:message-id; bh=f1LIySQa1+o3D0Vl5MgVicXbjesnn2pYzwzeidL/K3g=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1SURc+XkLwU7+eos/fWh4M3GI+annj8s7l1h4rTki
 sTJzFmtHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRdVmMDPM3ecv9bvR7p/eL
 Yc9ZXe7NK+/I6J/4rGGeJej0V+JyVQAjw6N2z0JWYxHO9BgB6a8nVxyZf7Xsp7wGa08MC8f0K5u
 N2AE=
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
 arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 357012b3e52b4a381fb8592c7afb624d01583776..8cb54fcb42003ecdd5dbe80fbd3e6a19ae668103 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -249,6 +249,16 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.49.0


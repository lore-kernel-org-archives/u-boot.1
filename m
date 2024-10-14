Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DC5D18142
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F319E8913A;
	Mon, 14 Oct 2024 22:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZRNL3FE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F0B89098; Mon, 14 Oct 2024 22:26:14 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3409089166
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so23376351fa.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728937571; x=1729542371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i9xeaVAwp4MY0oBiG73E+ql2NFLUqOCoA9Scgk4rmlc=;
 b=lZRNL3FEk5VPlRHkbqRDplxP4q/7ADC5BiJcJ5zfH9eCAHa3rxiOU86pzQB76+Ar3c
 GrkcYrn2hzuiGxc1XG/Ya3xf609wN8OMl+J2jvuyg8QAPPAApyhmyejtu2zAIDaOUn8f
 MyKIDStn48rHEJ/xFzvcZjTW7gVeqe5VWarxry2gFThOPrTXNw9mBP9/GSEU5JZ0Desy
 uKU7IdMnJsTqTp4GcGEqeT9RR4sehsj6xEvmN83llZ+j/6FzSVrFoa8JQHQOPofbxyhT
 Mu2j1+PaDcDJdjWxVgLC2sgwkD2KpRNCt8sujbpCZLhWw3ObcOm4NHQcF+UWVpcEfNuA
 8iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937571; x=1729542371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9xeaVAwp4MY0oBiG73E+ql2NFLUqOCoA9Scgk4rmlc=;
 b=gqiew0v6fEBvJlc82X7OG17iwcdreZJha7XRId+hPanYP9bet7JT+DatDG0Y2Uwk7J
 3Wfn0WJnSrqEKNMdAWJCOgmsmCFybF98bUgARdYQc3UOzuQH5B2ZcMYVRkjEQ6cm/usd
 VAzvz55J4QtHKD6CMvpoKpx4kYCTkAg+gRvaAF0b0glzcKNEUEsfS3ATNDUAuolqxiVd
 ZwBDpzN3/Bu4ajGsNXxG/OEYjFukXMkAKb7omHpa7L1UAw/f7bliIi6CZD+98CG2ACNj
 zWlseu5eEpz2BE5hH8lde/84+whMxD5tnstm9BzGD2PzcKfCJvMcj/egbs9ELi+0kB6t
 DB7Q==
X-Gm-Message-State: AOJu0YwIIGtptuzZFapo0M3RY2H5pYoCTiJ2f8cvWs7W0bI1F8guF1pH
 Gutl9/BRVVKoMtGfJrDbVMN9kTlM4V4hPnw9XP4nD9eYDdjes3EIjl2d2e0zCao=
X-Google-Smtp-Source: AGHT+IETGUzoXW1s6uwprwsgbpyczk9NpuLoOZ0vdmwK+Tif4ofJAAOEwHbRm+UXXyHgCmgxVeHjCw==
X-Received: by 2002:a2e:958f:0:b0:2fb:cc0:2a05 with SMTP id
 38308e7fff4ca-2fb3f30c7bdmr29886641fa.37.1728937570886; 
 Mon, 14 Oct 2024 13:26:10 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2fb49d78f3fsm6403001fa.129.2024.10.14.13.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 13:26:09 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
Date: Mon, 14 Oct 2024 23:26:05 +0300
Message-Id: <20241014202605.2799040-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Increase rng-seed size to make Linux happy and initialize rng pool instantly.
Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
currently provides only 8 bytes.
Linux 5.18 and probably some vesrions before it used to require 64 bytes.
Bump min value to 64 bytes to be on a safe side.

Boot with 8 byte rng-seed (Linux 6.11):
    # dmesg | grep crng
    [   12.089286] random: crng init done
Boot with 32 byte rng-seed (Linux 6.11):
    # dmesg | grep crng
    [    0.000000] random: crng init done

Linux source references:
https://github.com/torvalds/linux/blob/7234e2ea0edd00bfb6bb2159e55878c19885ce68/drivers/char/random.c#L632
https://elixir.bootlin.com/linux/v5.18/source/drivers/char/random.c#L236
https://elixir.bootlin.com/linux/v5.19/source/drivers/char/random.c#L551

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
---

Changes in v3:
- reword warning
- increase default rng_seed_size to support older linux as well
- reword commit message

Changes in v2:
- add env config knob rng_seed_size
- add warning for small rng_seed_size
- 12-character commit SHA in Fixes

 arch/arm/mach-rockchip/board.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 3fadf7e412..9ff1567fb1 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -472,9 +472,16 @@ __weak int misc_init_r(void)
 __weak int board_rng_seed(struct abuf *buf)
 {
 	struct udevice *dev;
-	size_t len = 0x8;
+	ulong len = env_get_ulong("rng_seed_size", 10, 64);
 	u64 *data;
 
+	if (len < 64) {
+		// rng_seed_size should be at least 32 bytes for Linux 5.19+, or 64 for
+		// older Linux'es
+		log_warning("Value for rng_seed_size too low (%lu) and likely insufficient for the Linux RNG initialization\n",
+			    len);
+	}
+
 	data = malloc(len);
 	if (!data) {
 		printf("Out of memory\n");
-- 
2.34.1


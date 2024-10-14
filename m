Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32104D18138
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D3A884FC;
	Mon, 14 Oct 2024 19:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bb40au7X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0B280245; Mon, 14 Oct 2024 19:53:56 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE8988CD9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539e3f35268so2721866e87.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 10:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728928433; x=1729533233; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8fjJ/Iu2CzWa7akm7Q3yd4fOtzdSuRHjFls/W36bZgo=;
 b=Bb40au7XBDrHE3plFD6znQZon5FjHM4dZcjgixViMIFByS6g3oe79Mj8YbnVZxggjR
 FNkoep9zSqbAPF4KWBjjlu4i1lYDuyCnnAIcAJXAJFvcVNBPiVrML1ko7HHdjcWZ1ZRc
 Phwb+ZT9JAr2oTXMilvkoFtKWVYssjoe8Nuf6STnHCGT77RfbUKi/kdYObCxmEUsx1eS
 Sh0C1PyHGewKg9EywRz4lvjG5Sf0p08hGPl8L+8KRHhKrXEqB0sNaqBK0/oyqFcoz87e
 FwBSPmV5JcUGORZqZe34DYcZSQuQ9ocx4eMI4rOg+skAqmr/Feg4ciV0vXDpUNx0yFkb
 F6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728928433; x=1729533233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fjJ/Iu2CzWa7akm7Q3yd4fOtzdSuRHjFls/W36bZgo=;
 b=DzgFJsYe2RxYNdqY95zIbpruGAF9tPLJuYEmRIUbQ9uHdIbFSGb52bDrl7o0goRT92
 hEtZbfoftAWYfTxV2BG1IhPsmk++/6D4fwFdIDPpQ6DXENkeC6aSfY7o12Mnu477FYjD
 xIq9jOlkpvhpqFi0tMPggw0s7atYtnwcfuAVAj4J4y4N2ADLhWF5Ftg7QrwLag/ynzxq
 SNhBdFlCVLW68TG06yfX2OKpHj7K7CIVwzow2xiRY7a/9dWspM1SacETE+BPdaSjNiPH
 nnm+jbZcQort5gKydbakhkZtkG3dhPfQzAmkFvw4iAfPAPPXH0HD+IEpfkD+QudwLz4i
 8I9g==
X-Gm-Message-State: AOJu0Yw3ZAMdQ3Ho5vdDux8VPF0to3ZZ2/D3n6u5cmALxKfpBSvrZCWl
 lnoVlbZ6a9gx5bGZCpTvLGopL+9I+c4weCOJJHcfndn5cQwSclScZE/FJa7/mn4=
X-Google-Smtp-Source: AGHT+IH9pnfzmYgkl1Pis1E5j+IP64YiIK/HnZ5MiH9RGi/SbpswOZm6YWUNRe89eF8RonYBGQde/Q==
X-Received: by 2002:a05:6512:2346:b0:536:9f02:17b4 with SMTP id
 2adb3069b0e04-539e5731678mr4509895e87.40.1728928432517; 
 Mon, 14 Oct 2024 10:53:52 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539ee0ecddfsm690996e87.234.2024.10.14.10.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 10:53:51 -0700 (PDT)
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
Subject: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
Date: Mon, 14 Oct 2024 20:53:38 +0300
Message-Id: <20241014175338.2675136-1-alexthreed@gmail.com>
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

Modern Linux requires 32 byte seed to initialize random pool, but u-boot
currently provides only 8 bytes. Increase rng-seed size to make Linux happy and
initialize rng pool instantly.

Boot with 8 byte rng-seed:
    # dmesg | grep crng
    [   12.089286] random: crng init done
Boot with 32 byte rng-seed:
    # dmesg | grep crng
    [    0.000000] random: crng init done

https://github.com/torvalds/linux/blob/7234e2ea0edd00bfb6bb2159e55878c19885ce68/drivers/char/random.c#L632

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
---

Changes in v2:
- add env config knob rng_seed_size
- 12-character commit SHA in Fixes

 arch/arm/mach-rockchip/board.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 3fadf7e412..f9f0d7214c 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -472,9 +472,15 @@ __weak int misc_init_r(void)
 __weak int board_rng_seed(struct abuf *buf)
 {
 	struct udevice *dev;
-	size_t len = 0x8;
+	ulong len = env_get_ulong("rng_seed_size", 10, 32);
 	u64 *data;
 
+	if (len < 32) {
+		// rng_seed_size should be 32 bytes for Linux 5.19+, or 64 for older Linux'es
+		log_warning("Too small rng_seed_size (%lu). It is likely insufficient to init linux crng\n",
+			    len);
+	}
+
 	data = malloc(len);
 	if (!data) {
 		printf("Out of memory\n");
-- 
2.34.1


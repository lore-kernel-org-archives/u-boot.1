Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5248D18156
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E7E8917B;
	Tue, 15 Oct 2024 00:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dbDHeoW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B859888EB7; Tue, 15 Oct 2024 00:15:34 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828C18919D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f53973fdso1224744e87.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728944131; x=1729548931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WY5SmcB9qWNKPWQtlr1pMiBoxwg3M3RdtRhh4LQwJaY=;
 b=dbDHeoW4mQYv0doRAZRhc1cfCdzme6p8kCIXFwhbQMUTyasTmY6S+O8eu4ZZco9vhm
 y+l0lKgBjH6ADfFi86yRxuwdNMAI9IHtbTFusaGvZVx6N/UMtdW7C+z2cNJJ66LPlUTZ
 3x36CYl0RL87kynfUpDFj4xkd/sAuCfW857ndeVTnSjuSK2p7Q4Ziv/iKZjgU1QDvCQM
 Go3lmtM31/nH8gdJU7jVx51BszoHVTRYsYZ3ct6oXcFe5CqElaz9ka1o1OU5Bnbhy0th
 GeL3x2OFMh7LurXeeNObvcCAOjDi7iLrJ4i8zHnzNfAq1/c8nokMJeSGQMm3FuXZ8fJM
 Uc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728944131; x=1729548931;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WY5SmcB9qWNKPWQtlr1pMiBoxwg3M3RdtRhh4LQwJaY=;
 b=QSxNPnYYgoziQ14DIAvHvD8a1EwOPk4eCFtgSFXoRCW2ee7ZkKFlpIPX40D8H4pWXG
 bCEtF86hrgfcrltzUyijwxdkz+jcDrhWnxXb855ml/2t2jR5t404eazO+dEpMbERuHRe
 t3xo4IxUqMTgf/C/JqMNIAoJqUOvD58PIRY+45OUV/dCAQ31UAhQ++Ku46IhXjJ1BaON
 i9nExH0UwU31M9MxC/iEc2DtpUicR4KVVwePAcSncZswlZY5WzPtHUkfmi39i15SQgbV
 W74H34Ci6YwJ7WXofWHOgbBgclnb2J041vLCXsjUshSta37rZifcghXiFpQn9i2joF4Q
 I5tw==
X-Gm-Message-State: AOJu0YwhbeOs5tRGiCzrC/QejHZ2Ft4CDBonGaIZO7LvpYm1lx8ktctK
 RSWy5OpjlbWBCvV0RfYhCeUtorkN4TiMU+/RzWf3jnag1JfYAxodASITonXccE0=
X-Google-Smtp-Source: AGHT+IEI14bCKZY/fGxYSZy9JYYhOpixkbjUdgMpFu+k0lArnF3tVg5EO9yHdxfQxbo36JuNwaNmlQ==
X-Received: by 2002:a05:6512:2811:b0:539:f554:78c4 with SMTP id
 2adb3069b0e04-539f5547a6dmr1599876e87.1.1728944130774; 
 Mon, 14 Oct 2024 15:15:30 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53a00006146sm3418e87.188.2024.10.14.15.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:15:29 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
Date: Tue, 15 Oct 2024 01:15:22 +0300
Message-Id: <20241014221523.2912260-1-alexthreed@gmail.com>
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
Linux 5.18 and probably some versions before it used to require 64 bytes.
Bump min value to 64 bytes to be on a safe side.

Boot with 8 byte rng-seed (Linux 6.11):
    # dmesg | grep crng
    [   12.089286] random: crng init done
Boot with 32 byte rng-seed (Linux 6.11):
    # dmesg | grep crng
    [    0.000000] random: crng init done

Linux source references:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236

Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---

Changes in v4:
- fix typos and code style

Changes in v3:
- reword warning
- increase default rng_seed_size to support older linux as well
- reword commit message

Changes in v2:
- add env config knob rng_seed_size
- add warning for small rng_seed_size
- 12-character commit SHA in Fixes

 arch/arm/mach-rockchip/board.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 3fadf7e412..ca6404776f 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -472,9 +472,18 @@ __weak int misc_init_r(void)
 __weak int board_rng_seed(struct abuf *buf)
 {
 	struct udevice *dev;
-	size_t len = 0x8;
+	ulong len = env_get_ulong("rng_seed_size", 10, 64);
 	u64 *data;
 
+	if (len < 64) {
+		/*
+		 * rng_seed_size should be at least 32 bytes for Linux 5.19+,
+		 * or 64 for older Linux kernel versions
+		 */
+		log_warning("Value for rng_seed_size too low (%lu) and likely insufficient for the Linux RNG initialization\n",
+			    len);
+	}
+
 	data = malloc(len);
 	if (!data) {
 		printf("Out of memory\n");
-- 
2.34.1


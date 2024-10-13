Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DE5CF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 09:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8316B88E51;
	Sun, 13 Oct 2024 11:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fB1GYcoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54BD688E17; Sun, 13 Oct 2024 11:33:03 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2212388E69
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 11:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539e5c15fd3so880544e87.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728811980; x=1729416780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5b6Jnw51ID4dk3wcAxzawE/dkg/QH347sfYTIJnGpdg=;
 b=fB1GYcoSarkeIDEZcJBvp5W2MMWCZeIJokJA4Q9Wl+mIMtTKuhxKj7jh7O9wNitBd0
 AAmFn8h71Ul+m9T0DKEyjMbCl7a0FPtWydT2i8eC57iR5I69kVeBFOLhiRSLmMiK5PuS
 jBtlVfFE3UmX23oX3Q4l0vRU98pJYMe8jj98CK7nMWSesdo5eXcdjr9RJAZvwCkVJSfh
 2tVM5pgMQkUTVtmzvZ9Yoso+T8MtlBPYzl6UqDG16J9ytPoXHLeMqRT0/2TbJsvon42P
 ZwNkFhcInvWRXCE7g7eG0w9e4fPdxjyKxNaAxx8Uqi/7o3ggOpUU7TXspoFC3mfWX3Br
 ga5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728811980; x=1729416780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5b6Jnw51ID4dk3wcAxzawE/dkg/QH347sfYTIJnGpdg=;
 b=dMsC00P+5QtTQbKjZEiixjfRiFCreS/Umv0rhXG3DQ0PnRityliS5uZ17IrUo8DzX4
 uyI77K/W15C4Ksqt6t+1cedV2gh2MRcZow5rx+x2w1wPcg2/n7M4l6dt4wRo3TFSsarO
 cnx0SgwwCup0Eip/eCTtov4/KggWjAyOdEMQ300FzwhGOLkfPB5WZUmKbMVqb/++rfBQ
 w1tgXQddR9kRBYOODAckDVUnirl1D982Hec/7iJh15BU8ilLx1yxCMeyGOcVxJ6jAQjt
 hfQjj2gRE4UdrMXCRsIBU8MYWllWm/9NnX1F1R4ERxQYdJPeYBBmcwpkqVSaRxm0+K/k
 93Vw==
X-Gm-Message-State: AOJu0Ywed5+wdCday3N9I5iDVQfz7lxnBJx6hfRvlzNwe5nJ29QpfCMW
 YEoDuVtl7D21QE83ndBqUhJsGTLZTCwNNhG9IjSTupBeklIaHOQyz+m9To8iRBo=
X-Google-Smtp-Source: AGHT+IFVOXFAG0USGxd1MUxNXTxixN06uN/TyTXQB2hjLyhbACkUlgAvgSuEyl08LHzmgwm5gOEgFg==
X-Received: by 2002:a05:6512:2255:b0:533:711:35be with SMTP id
 2adb3069b0e04-539da4ccf41mr3357394e87.26.1728811979655; 
 Sun, 13 Oct 2024 02:32:59 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539eff62fbfsm205133e87.17.2024.10.13.02.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 02:32:58 -0700 (PDT)
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
Subject: [PATCH] rockchip: board: Increase rng-seed size to make it sufficient
 for modern Linux
Date: Sun, 13 Oct 2024 12:32:44 +0300
Message-Id: <20241013093244.817790-1-alexthreed@gmail.com>
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
Fixes: d2048ba ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
---

 arch/arm/mach-rockchip/board.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 3fadf7e412..eee75f7bcb 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -472,7 +472,7 @@ __weak int misc_init_r(void)
 __weak int board_rng_seed(struct abuf *buf)
 {
 	struct udevice *dev;
-	size_t len = 0x8;
+	size_t len = 32;
 	u64 *data;
 
 	data = malloc(len);
-- 
2.34.1


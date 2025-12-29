Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9077CE784BE
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C01683C91;
	Mon, 29 Dec 2025 02:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aObkCFOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D952583BC7; Mon, 29 Dec 2025 01:06:03 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A32E8003E
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7cc50eb0882so3154065a34.3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766966759; x=1767571559; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ASbNUpp4CR8+wf2i7X4zV9LkWIIw3TXk+Bx8AQgLRq0=;
 b=aObkCFOtkN+VVqysrnJr6cTPocvjJv7KY9j48z3dUhqqbrl1vHEMjgaVu+BaSkyKSa
 2Bp+7gEk2a7TRbi39DkzMrRCANkKNbu7aiy5QeYGHzoALI9sMAHBL/YCF8QTnC497SkH
 /inioAIhXWYqHmepOd1L8H4ybxlY5G7WlIgoNX3IL+fcy5qA4OzXZWAXVPQx24w+PKOa
 iklVKEaMU09nCuQKJy281wC2aF8j0emomGG3axLiCPP8K6y7GNa8oUCJeD7Dm5irqb24
 hvvEwiTZ1mswdEH+aZ/Eumz5fATQsVmpLk70NBxd/d3r0xqSitpVlKtlupIDmigxJsTK
 z1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766966759; x=1767571559;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ASbNUpp4CR8+wf2i7X4zV9LkWIIw3TXk+Bx8AQgLRq0=;
 b=XUwVomazB7tOVmSY+a0a/K3L4hVqvP7ScveMu0iBT4Fdc32jH69Vx8og46Pk7LMIVZ
 bFJqMLLsPK8TFQ6o/rmE3m7ZxRlzNyp8NRaeAKa8KcC5kyat57OGAmQTyDbz7hYGpX4n
 wvtbJZjJp/JgDQc0NFlxEp5lGGBgXirV/hPtJlT96srf9GdJTNz/KKccER/u6MLxQ3Pq
 ZoKCeivmLilAB4Ssd3w/7bPBt1fcMMgUUhm4poddl91rAKt5YcJrZgUkFWakuUDVNNBv
 aXLzW7CZZuJJvmyvJSBtrlNWSNL+FOZlaEQk6j/r3E5zCty+TG72Q/ydAv+JbDgQdLa4
 BtAA==
X-Gm-Message-State: AOJu0YzMIEusdemkUvreJvKk5cLFPy7YU1yJVHBkPvgnnhjIWL6IDPki
 CFnMv4nq6MMeH5SKHxWZCtsW3VYYrCn7T+ZpO2LyyRZIgA2dNuFY/Gwz
X-Gm-Gg: AY/fxX69rFtv2UJ4H0nYvLFROvINRxQxHQp2xU3+v2OOA+dEpLbqUYa+dMvuCMX3+OK
 7Mk9UJv0Eapkc2O7dHi9X90+7o7ZZldiIWwFrGn8Dou/iTqrffmbp57TNEo0cNG6OetQe1v9ExV
 rYKPzthoeZ6jAzE90o7WfPj8/XgKE51mdM1xmXgV/zggohQ9FyQnlBXtPVrX9vPeV3O/o1ALSGV
 fl8TSUQAEB4bQvyD/++tpnZvDUJdY3x2mrEzJtA59osyAt4F0paMYArLxGWWc9t1xfDuOk5R6iJ
 WxuPoEEZWHT7sJa4MhuBrvPJgXjx+YwRh3PwBoFPspqYrZ6jRNbEu5GlsECyrU6SkB82YO3s/rz
 EeLvpGRKzVqkVSzreSQwqmVUdknnXmwvUKoyiGIlA82PuCi9eq2+i6cxpbpfvWRkscjdlaLuxi6
 V2mSh+Ro954QU3fgo2LBkOnb9uaLvAXtKqrw2/b97TDDviOkxKFq9fgHth
X-Google-Smtp-Source: AGHT+IHD2qYaHIMNME07D68LoQrecjSI+VbBlVZUyiv35TD7JuKN4qVyuT4zhjXP8MODQ1v+2WC5YQ==
X-Received: by 2002:a05:6830:923:b0:7c7:2d7d:5d0f with SMTP id
 46e09a7af769-7cc66a4b655mr14664892a34.20.1766966758977; 
 Sun, 28 Dec 2025 16:05:58 -0800 (PST)
Received: from [127.0.1.1] (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm19397294a34.28.2025.12.28.16.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 16:05:58 -0800 (PST)
From: Aaron Griffith <aargri@gmail.com>
Date: Sun, 28 Dec 2025 19:05:24 -0500
Subject: [PATCH 2/5] rockchip: sdram: remove redundant configuration checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-rockchip-tpl-use-atags-v1-2-8ac5140c3763@gmail.com>
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
In-Reply-To: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Aaron Griffith <aargri@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:48:58 +0100
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

The new config option that enables this code guarantees
ROCKCHIP_EXTERNAL_TPL, and is implied by these four SoC configs,
making these checks redundant.

Signed-off-by: Aaron Griffith <aargri@gmail.com>
---
 arch/arm/mach-rockchip/sdram.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
index f549baaa8e7e0664029f37de012dd22dfe92b07f..2f39928bcbda2936fb4f079bbb72fa13f80af6c0 100644
--- a/arch/arm/mach-rockchip/sdram.c
+++ b/arch/arm/mach-rockchip/sdram.c
@@ -109,15 +109,6 @@ static int rockchip_dram_init_banksize(void)
 	u32 calc_hash;
 	u8 i, j;
 
-	if (!IS_ENABLED(CONFIG_ROCKCHIP_RK3588) &&
-	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3576) &&
-	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3568) &&
-	    !IS_ENABLED(CONFIG_ROCKCHIP_RK3528))
-		return -ENOTSUPP;
-
-	if (!IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL))
-		return -ENOTSUPP;
-
 	/* Find DDR_MEM tag */
 	while (addr < (u32 *)ATAGS_PHYS_END) {
 		tag_h = (const struct tag_header *)addr;

-- 
2.47.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5098CC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6906684C9D;
	Mon, 13 Jul 2026 20:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="bLIXMIFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727F284C9B; Mon, 13 Jul 2026 20:36:30 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE0884C8D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493f140ca8eso21736105e9.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967788; x=1784572588; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CnYeeimXLbLjRMgYTj3clRHYDTCbfeqDN7GbqCf3xvw=;
 b=bLIXMIFEttW5ZGOV0xa1li6AWHaJKeou/JxfA0YsRmG/yxpL05v3tHgAC1qYJaHTwT
 ce97YJ649jNzp4uGRwi1jJClCYiY/7TIJXemDhH685T4i/rDh+fNUt79acezr5to5MSr
 wCkHKxh/nVS9FPFsEtkTksRukcAjAditwrxYSSesZf4DropYAt7U4S0y0uuQCBKA6P/G
 uy8uwPy9RLuayjQRfF6245DfotxrZ7LBHRcg28uikEoWNvwulPtVu5XrOiRmosrwxNY6
 Bb/0luRe6MLL38VoybjKkKpnPqq8DRjfsIE4tmlq5wtCdnP95cXvM59qPQpNfbybFZx5
 MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967788; x=1784572588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CnYeeimXLbLjRMgYTj3clRHYDTCbfeqDN7GbqCf3xvw=;
 b=evA+lK0aTSqsB+WOBXQPpD/pPzBFWR8Hb/NLexRB3p6hX1KbFkqhmZl12lIxpjCWl/
 I9YQZ1RfKL76obqZqc1wlbEewTLycc10zumb9GTJkMiGk9gfC28rRTitv/627PYpvOTi
 ZeIEKJjIS3Cx1nxlnYtexg+7X76Bv33xvBPIA3gW9Ous4yFkpD9Fc/m626cFbfj0My/O
 9TprWaN+J6oYqpzXzc8tHZ2LFFLrVynFOdNkL548dJwZkFiPcryL1zYG4tg8T/7p5GgW
 15VZd/nLUBLiG/aAPn99fmuf+N3+EeeurMmGXuGztdSb9hNCAzyQU3zQMU1M0qSjtmlx
 QQvQ==
X-Gm-Message-State: AOJu0YwhGOxDViBJTEm99NWlSnk7OaoUKUhvzWX+ru65VG+TGfJ0gakp
 pVrxZg6rX7TAzh2kHty0xli4qALWHzu+rosNwqFQWVqThJ86Sn7FEbdEBMXhNqhSvJs=
X-Gm-Gg: AfdE7ckiUxhf8WWJur3akJKG1hwGE2pf0i1HgF+Z5dvu1UFc0iKbf1bQe1/fdNobDxW
 uKOwIS2pGJ08AxqwgObB/t1DD3MMPjyOLN5aEGFnnpX1ZrTe8NeE3BBFlJkcqupaTBf2LNMAmEd
 Es7Y20GH7SKVkWUL2oN8s8N4Vr9kodvRP/RDX67kekAqU/BCJFq3dOKoFBPMzIpamlmtJyhut5G
 yyA9eJjdYf/OdMy3hRErpBPqFr9y8Y/qcO61vfzfC8zVo05klNiVPra4UNvJflCngbZU5WiN7gU
 bQq6nOoL2O09J6B29Ea0EKLUop8Wvq5kbipthRCANiHwFFtqO9EZDD2XWDZPMkFdts54XRai37h
 5KeT6EfNc5W/YImE72HaOaUmKrilJpCQfLU8Q1aMfZA7JNOS01xGAFtaashXnXnVNaKyIrw03IQ
 NSWX84MspMwp+vjeOe4Cmbz9qdeEuixxg4qW85w3bMRghOZxYaQ+Hd+HrQX8Ii3UPC
X-Received: by 2002:a05:600c:63d0:b0:493:af56:8e64 with SMTP id
 5b1f17b1804b1-493f882e94emr76527055e9.32.1783967787996; 
 Mon, 13 Jul 2026 11:36:27 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:27 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 13 Jul 2026 22:35:21 +0400
Subject: [PATCH 5/6] clk: rockchip: pll: fractional PLL coefficient is
 two's complement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-rk3588-fracpll-v1-5-cdf47f2ca0b8@flipper.net>
References: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
In-Reply-To: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334; i=alchark@flipper.net;
 h=from:subject:message-id; bh=tussQ39I4zGPWI4W+xED1R3wez+KkuhhZSQQKnrXiWA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGkjzTuay2ti0fFq5z+uHTTpXZDkdLNLtziR9vJyVZ
 28qL9LSMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFR/X8PwT+lfWoG4o46H56+/6wxNDgQJB94/8C3q0Jq3qVs0t82Qy2Jk6I+Iffy
 V0zE3h1f6sOrDNg+xCLO8zUpiLw9OP/f+RF0fMwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

The TRM defines the fractional PLL adjustment coefficient as a signed
two's complement number, 16 bits wide, so store it as such to avoid
confusion.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 arch/arm/include/asm/arch-rockchip/clock.h | 2 +-
 drivers/clk/rockchip/clk_pll.c             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
index 95b08bfd046f..f9bfdfb8a6a3 100644
--- a/arch/arm/include/asm/arch-rockchip/clock.h
+++ b/arch/arm/include/asm/arch-rockchip/clock.h
@@ -104,7 +104,7 @@ struct rockchip_pll_rate_table {
 	unsigned int m;
 	unsigned int p;
 	unsigned int s;
-	unsigned int k;
+	int k;
 };
 
 enum rockchip_pll_type {
diff --git a/drivers/clk/rockchip/clk_pll.c b/drivers/clk/rockchip/clk_pll.c
index 6324c11091af..ebe90b55ea06 100644
--- a/drivers/clk/rockchip/clk_pll.c
+++ b/drivers/clk/rockchip/clk_pll.c
@@ -195,8 +195,9 @@ static struct rockchip_pll_rate_table *
 rockchip_rk3588_pll_frac_by_auto(unsigned long fin_hz, unsigned long fout_hz)
 {
 	struct rockchip_pll_rate_table *rate_table = &rockchip_auto_table;
-	u32 p, m, s, k;
+	u32 p, m, s;
 	u64 fvco;
+	s16 k;
 
 	for (s = 0; s <= 6; s++) {
 		fvco = (u64)fout_hz << s;

-- 
2.53.0


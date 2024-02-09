Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FEC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 21:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAD287E7B;
	Fri,  9 Feb 2024 22:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=ragnatech.se header.i=@ragnatech.se header.b="cwO4B4jJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FABC87E70; Fri,  9 Feb 2024 22:16:32 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B72F87E6E
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 22:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=niklas.soderlund+renesas@ragnatech.se
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55fc7f63639so1953199a12.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ragnatech.se; s=google; t=1707513389; x=1708118189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8wmYeTCl6g4Puyeq+hHOJXDfECuUyxrrSnQt72/tYE0=;
 b=cwO4B4jJ19WLuS4C3wLB2UqS9OBqX7QuKtwn/EddG8Y3X4MqiwZeDKnYySpRI+uovn
 sF5KI3mmYamkmhogRIfHfyamc0WqEdAINa6fKLbwkiXsj+CSE8A3rHHC5+Ev5ufqdTFR
 gkNChIE7ddqskiphALBlqrZGThmdabrUOuyz7KMLNCtcTQepn96/XKOOtcWR0D2tPsqD
 Or1ayHd8Io/0ir2PMkyqnmF99saR7labKcQfg44DhHNWWHnL3oKhbSjITndATRWmXWIz
 HRQOtzctCuZMoTBS/zc7U7anc31bi8XxTSc/f75EpQNsHAfD4LFDvnR6LCG/N3kTjMlF
 B0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707513389; x=1708118189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wmYeTCl6g4Puyeq+hHOJXDfECuUyxrrSnQt72/tYE0=;
 b=AyTvEgnt08uq5RwIK/lw8/mxPRpeP1IFB/fMpx/RQkufERDlcqJ4nALn8G0UNPzt1k
 UxfOkbv2irI/ws3/AHlwnmKLrCSIrfP9mcwZKz79RxBWj9dFJCf5CdfDcuZ5S2c6riv1
 zs0bBWt91GFAs2HJiOrvZWhYiv7CqTvdbFLreRD9Yyb3fkUWu0xh6+g8cxuGlwinD9vH
 lRgS1Xy/f6D4EIc6LBjXRA/mOx50/JqGkuVBusoX8gLWeXABu+nRsp3jPWEXmAiy4yB/
 kAhw7dgX/mv7J2cHHXwvhqKmYj9vfgrtUupx0hyIPUY4ZPkqbweQULt6oQZKuMMdShao
 snWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfEw1E2N4c1MumXYKIWCysKZOgtIV8f2MR5WyR+QF1fS07EJM7Zse0/75yI/oEq+Dtru1YxfhtfPN8Fl/PfyylKR+IKw==
X-Gm-Message-State: AOJu0Ywxhm2+nbiUBhZJ6pt1F4Ou6JM57Y+ic9Bu6fUfp2fum5kwla/L
 TYTHlSZd9ZDvb7yhUOSQ1/VxL3usZ5jqTCcgBgApsAmKEy1SWKnlOzbi5anqvW0=
X-Google-Smtp-Source: AGHT+IHUWcxtsHrW3Eeqb5w5ol2U9vAxa0u7f2aOE7ikg30kSaIdN/HxnhU3z40HI5iT6jcK/oZqHQ==
X-Received: by 2002:aa7:cf14:0:b0:561:aa3:fafb with SMTP id
 a20-20020aa7cf14000000b005610aa3fafbmr85595edy.6.1707513389128; 
 Fri, 09 Feb 2024 13:16:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWfVcY9Lnfb9ZeVVYIVs/4ouIFo69Fbbgu2cCZ+eNeDPpuxy474PeZs8VYOtGFRL7tHV8c4mlgWuI70nE6veueLPYz8LKGmNIWHPXbNrBJbODmXwnNajWRAp8UWOHjTnjOC7yEoQrD8PIznUHMQGfMJmvh16vRWKunRRN1r+J28YY0peAyt+EE/qt9I+k0WxJkogqz4wFTxfwEJBTv3zRU/oKrvKsuw764Xs7x6RisJcE+URzaAv/GNpOcUg2BK+wOL1xhQZESQwNhuey1ax4128+aSwgfiDRFurPo=
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de.
 [79.204.140.106]) by smtp.googlemail.com with ESMTPSA id
 et13-20020a056402378d00b0055d19c9daf2sm105202edb.15.2024.02.09.13.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 13:16:28 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Hai Pham <hai.pham.ud@renesas.com>,
 u-boot@lists.denx.de
Cc: linux-renesas-soc@vger.kernel.org,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] clk: renesas: Fix broken clocks on all Gen2 boards
Date: Fri,  9 Feb 2024 22:15:35 +0100
Message-ID: <20240209211535.3313392-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Feb 2024 22:27:02 +0100
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

To prepare support for multiple register layouts pointers to register
tables where added to struct cpg_mssr_info. These pointers are suppose
to be filled in at probe time and no intended change in behavior was
intended.

However the new pointers where only filled in by some paths of the
driver implemented in clk-rcar-gen3.c. The path implemented in
clk-rcar-gen2.c was not updated leaving the pointers uninitialized
leading to a crash when trying to probe the clocks.

Fix this by filling in the pointers in the Gen2 code path with the
values used before they where moved to struct cpg_mssr_info.

Fixes: d413214fb748 ("clk: renesas: Add register pointers into struct cpg_mssr_info")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/clk/renesas/clk-rcar-gen2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 66ffef96b695..89f2d9667469 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -298,6 +298,15 @@ int gen2_clk_probe(struct udevice *dev)
 	if (!priv->cpg_pll_config->extal_div)
 		return -EINVAL;
 
+	if (info->reg_layout == CLK_REG_LAYOUT_RCAR_GEN2_AND_GEN3) {
+		priv->info->status_regs = mstpsr;
+		priv->info->control_regs = smstpcr;
+		priv->info->reset_regs = srcr;
+		priv->info->reset_clear_regs = srstclr;
+	} else {
+		return -EINVAL;
+	}
+
 	ret = clk_get_by_name(dev, "extal", &priv->clk_extal);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


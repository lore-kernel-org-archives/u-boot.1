Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E581C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0745584AC9;
	Wed,  8 Jul 2026 19:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cy8lEwSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CAB7849D2; Wed,  8 Jul 2026 19:02:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EFD8496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=royzah@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so9054375e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783530164; x=1784134964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zcnbao9Q/haaCYa6vhwxnfTqcIXBORptuj0oPuob0M4=;
 b=cy8lEwSemIHaAI497kRFOWScuxSCW2KUpwX7Geg6Ol+g8zVWiYSEKKJrPncwzBQH47
 j7TLXinraw41cnanR3u9EnDT83mY3Atk53zi9wFY9dkVdDVHzYi5n/gcgV7+k4eku92s
 ToLW7HVUa85xzf6OBlTkbaPmPtqeouHQPOOfERcHgI8Elx0y8islxIouCIz3zrG84NNl
 27pawbDTLnSx8kCv124rqu/t9TXI62If6mHl2xc/ueMqx3a/0uKaLzdrMBOnSvHz3dFs
 lS0rM9G9L3kehfQYOqGnAdIJMo4ODQCxMGDF52aH22+2HyBkDv/GJpqpKq7p66SJ4sli
 g/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783530164; x=1784134964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zcnbao9Q/haaCYa6vhwxnfTqcIXBORptuj0oPuob0M4=;
 b=IHo7GF5Y1HN7L/tZDHgKKQN4BMcI0J4vg3lL7fJ0tPeYt6nxSdgT0D/79CFjlCX6jL
 WrhRNHV0s3v892IQQe7asCYfrT8Hg29s6GbNJcdKlPszZf2rAAsW5F7oszCHiRoGqRps
 wj04HMf3p3S0N1qvWfkdiXu7FQucscMWab4vKtnR9oxZXkASayBJXqTCFrxEyGJFBfg4
 js4b8zZZlvxVRqbp/0Se7xPu9b1MLWGLdsWs6H8PeK37Nl7sYw8EvsHxN8XSqmTTJDKU
 6Hf9CQCZOZSYa6wzDXj3zwFrm/4/OqohXPK0iYYvyNJPArnZ+eDE1cejU9hnzs6Hm+Qz
 mO3w==
X-Gm-Message-State: AOJu0YxvjEgPTHLU3/x8zQbyFqSZMe9jMHMbHhIw5qgUHoOKftpBlJkm
 BN4JTfbhQFvFbl99ou5J0zwpsSY4Armx3ZMw6LetELnmfIUmmMFqhWzW5o9i/ZFRXEuL2THt
X-Gm-Gg: AfdE7cm+KTJPQHOCvzuaXbe/69AqiqV1LnpSAdUZHCKOW4iYKvUq5HizRLgS43kPUXM
 XVLtuZud2ITK2VQly5dhMpSHnxEJrAlHEtOLy1Y6cbit5U4YZvNga9dBpvLqgIMYtkCl8DKzPPo
 cl73ZSsCoQBMOQ1EnK/Htr6GUK1ubDeYMoH2tZHjOXMwSGJhrI22LcN1joOaieeIjbi5/SiiCFW
 GegZh0iHsNiNRSxV1686sRROHV2iqMRYmJQv6S81mxKLWRmoPVfEM5KMpgN7OswEslkmltai5Lg
 abz2sEUAyk6rJlD3JNoBxsQzv2GkBy2wixeUhB4Sn3KAoYyUk4tshyV2VR4RKbT9MO6f88fvnMW
 kDZhN3GDeUvjsd0NcQJ93VE1m21G9Mb8lpRBKufOyExYJvl8bDDjRRMEA1beRRK+tMs6tppT8GL
 bQgUgd5iTpiwHlcWYufcIGQYHcnBBrzQ==
X-Received: by 2002:a05:600c:3b26:b0:493:e3e9:85fb with SMTP id
 5b1f17b1804b1-493e685f1f6mr37032335e9.20.1783530163301; 
 Wed, 08 Jul 2026 10:02:43 -0700 (PDT)
Received: from royzah-ThinkPad-T14-Gen-4.lan
 ([2001:8f8:1137:19c:166:4fca:c84a:eee4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0fbd355sm143349355e9.13.2026.07.08.10.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:02:42 -0700 (PDT)
From: Royyan Zahir <royzah@gmail.com>
To: u-boot@lists.denx.de
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, Royyan Zahir <royzah@gmail.com>
Subject: [PATCH] clk: qcom: sa8775p: enable GPLL9 before SDCC1 high-speed rates
Date: Wed,  8 Jul 2026 21:02:28 +0400
Message-ID: <20260708170228.621618-1-royzah@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 19:36:50 +0200
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

On lemans/sa8775p, the SDCC1 apps clock high-speed rates (192 and 384 MHz)
source from GPLL9 (ftbl_gcc_sdcc1_apps_clk_src), but the driver never enables
GPLL9. When SDCC1 is set to such a rate the RCG switches its source to a PLL
that is off, so the CMD_RCGR update bit never self-clears and U-Boot warns:

  WARNING: RCG @ 0x120014 stuck at off

Vote GPLL9 on before selecting it as the SDCC1 source, mirroring how
clock-sm8250.c enables GPLL9 for SDCC2. GPLL9's mode/status register is at
0x9000 (lock is bit 31) and its enable vote is bit 9 of the APCS GPLL vote
register 0x4b028, matching gcc-sa8775p.c in Linux.

Not hardware-validated for SDCC high speed: the board this was found on
(Qualcomm IQ-9075 / Lemans EVK) boots from UFS with no SD card populated, so
here it only clears the stuck-RCG warning. Build-tested on lemans.

Signed-off-by: Royyan Zahir <royzah@gmail.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -26,6 +26,9 @@

 #define SDCC1_APPS_CLK_CMD_RCGR			0x20014

+#define APCS_GPLL9_STATUS			0x9000
+#define APCS_GPLLX_ENA_REG			0x4b028
+
 #define GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT BIT(10)
 #define GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT BIT(11)
 #define GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT BIT(12)
@@ -90,6 +93,14 @@
 	{ }
 };

+/* GPLL9 (SDCC1 high-speed source) is not enabled by earlier boot stages. */
+static const struct pll_vote_clk gpll9_vote_clk = {
+	.status = APCS_GPLL9_STATUS,
+	.status_bit = BIT(31),
+	.ena_vote = APCS_GPLLX_ENA_REG,
+	.vote_bit = BIT(9),
+};
+
 static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -130,6 +141,9 @@
 		return 19200000;
 	case GCC_SDCC1_APPS_CLK:
 		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		/* SDCC1 high-speed rates source from GPLL9; vote it on first. */
+		if (freq->src == CFG_CLK_SRC_GPLL9)
+			clk_enable_gpll0(priv->base, &gpll9_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;

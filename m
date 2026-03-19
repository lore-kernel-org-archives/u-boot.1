Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A65109192C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 23:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C92E84223;
	Fri, 20 Mar 2026 00:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IATjc6t+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5208683FDE; Thu, 19 Mar 2026 21:58:27 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE2C83FC0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-486b96760easo15182555e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773953903; x=1774558703; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y7YG64DnCuy2McZZ3OS1s5OitYK10LkBi72/Tt+MRRY=;
 b=IATjc6t+hy9lHoLYQNZKV6c00JP2A8J7WhVWGO/SfgTjwLBBGPTyVZam38SSMDzHt3
 oJYd5pvaF8WpcmG5ghiZnBXsMqKGye8Wx34ekSpoCM8hZrdvuTfCn7cKZMBNCmD9zkSP
 iFTSN/9GyzdXWA8uF+aly1RVXe4+icfauT0WToyN6kp+OjF7UFKgQKzjX/1n6oxf9DCt
 jrKvAkFt5xZ6tmyo3w59styGp/BTrw1Fsqlon08ISFjwt9QTgkpEc4uQPK1a6n+jJXQf
 GCbjJvBnqcPwpOwQEWWMgAdwrTMr8Mcc69n7eDmU6dSGEuNVSpbi6RTy4QjVBEInYmXo
 Bcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773953903; x=1774558703;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y7YG64DnCuy2McZZ3OS1s5OitYK10LkBi72/Tt+MRRY=;
 b=Q8LVtN1HTib+I9/aMymxF4a5EzCrZ9/J8mZxwhl69ssWDG7MgsQmjlUHoB3taOAozu
 sqWxswhXHBMUPFt6BT2WsG1/eyD1Qc8Mhs4GTZw9NNtFqqthhrpKPg1QlrQcn9CSXt/G
 HIT0kLP0AK3n8xYOs6BPX/2EEP6rUkWU+jWC2GKg8De6Hg/IhBtkFf6Wk77wKPG/0Z3m
 TUB1LOe0v1WsQWsA04TG8tSevBplXtenGNa9l/GESZotJWvpTvB75FXpH+19aQDMhDUP
 MGzyWauDGNomkkc87A/PpiUGLZv4fn72BgTgDqfKBYocrxJ1kD+8JnBQ5o7W8rDeJLmb
 BhAg==
X-Gm-Message-State: AOJu0YxDnueerjDOEX2YZOtP++F61/2TdOVqsygHdGMF9VhCjCIUXRzB
 Oxb/uThVxxY3/5n+Q2Unzs6VMEZDpc0q0AT0DReX+z5BCGPWdgnPkHsmLQtWKQDa+FU=
X-Gm-Gg: ATEYQzy+bP6s5lqRLDON/U+YYnSYJUsxfQIdOmW70auv8wNbfY/+8AFYLjCPMgsiK3r
 vY0VzrGgFM0oAjl73n8gH2Kf+ZyygY9uC0julpcYXrJUOzgHGwHloLJDCPjWyqfX6mWchsobAiE
 nVEMyF4pCG96xTWQT673eAYkMInQo9KBZUWVppCECJCpg9dqshNvzcq5kolF2yi20oAjLd9AHZn
 gPQWY3mNcOJlOTgj0j7JxcGUo+sszHbyKaw8Bm62H43ofBq6AIvS//iqAVd1UjqKSn6xU7tsOQU
 rqoYgtK31ap40zrfZrtkgZ9M8Z2jsSws03iIqXhXDcjyLXTtJyshJd9Eb0ExP69DSzW6trETIaZ
 TDZrk0d2WefdZLniHBWRakXfOr0G0v4p7nJNj3x1GC/tF8WZBUSvBZ1VxbfAJ0/ox1FfVyV1dvE
 ng61Ag9ug0aKRHq45bMYNY2n/UlcFuoqAxiCd9G/DOMcKfa1UdjGVE79HRn1IayRFB3p4=
X-Received: by 2002:a05:600c:8b31:b0:485:9a50:3369 with SMTP id
 5b1f17b1804b1-486fee304c4mr7491445e9.29.1773953902485; 
 Thu, 19 Mar 2026 13:58:22 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd39.dip0.t-ipconnect.de.
 [79.195.221.57]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64714e2esm1191396f8f.32.2026.03.19.13.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:58:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Mar 2026 21:56:44 +0100
Subject: [PATCH RFC 22/40] clk: move clock flags to common clk-provider.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-casey-ccf-upstream-v1-22-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>, 
 u-boot-qcom@groups.io, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Paul Barker <paul@pbarker.dev>, Dai Okamura <okamura.dai@socionext.com>, 
 linux@analog.com, uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Jens Reidel <adrian@mainlining.org>, 
 David Wronek <david.wronek@mainlining.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, Nishanth Menon <nm@ti.com>, 
 Alice Guo <alice.guo@nxp.com>, Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Sam Day <me@samcday.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Shmuel Leib Melamud <smelamud@redhat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5656;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=pyXAUexLV67NxbGLlNdz7O544IZi4ffGh3W9T1xKaV0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw9yfzx1pPc5kyeEqS2Ry9LVzppW71iUWWD4oLmxp0ln
 +2KysQ6SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESMKxh+MTksTxGIUHi72dUm
 3aPboKi5sKs96wML69Jz3cl/J1qkMzLsevraySBDSj1gmsaX6iqr1oiimabzFXznXEq3avsw6Xo
 RAA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Fri, 20 Mar 2026 00:01:15 +0100
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

These are the same between uccf and ccf_full, move them out to
clk-provider.h so we can ensure they stay in sync.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/clk-provider-ccf_full.h | 24 ------------------------
 include/linux/clk-provider-uccf.h     | 24 ------------------------
 include/linux/clk-provider.h          | 24 ++++++++++++++++++++++++
 3 files changed, 24 insertions(+), 48 deletions(-)

diff --git a/include/linux/clk-provider-ccf_full.h b/include/linux/clk-provider-ccf_full.h
index dfc2049feee5..0e160b13b3b2 100644
--- a/include/linux/clk-provider-ccf_full.h
+++ b/include/linux/clk-provider-ccf_full.h
@@ -9,32 +9,8 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <clk-uclass.h>
 
-/*
- * flags used across common struct clk.  these flags should only affect the
- * top-level framework.  custom flags for dealing with hardware specifics
- * belong in struct clk_foo
- *
- * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
- */
-#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
-#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
-#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
-#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
-				/* unused */
-				/* unused */
-#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
-#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
-#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
-#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
-#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
-#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
-/* parents need enable during gate/ungate, set rate and re-parent */
-#define CLK_OPS_PARENT_ENABLE	BIT(12)
-/* duty cycle call may be forwarded to the parent clock */
-#define CLK_DUTY_CYCLE_PARENT	BIT(13)
-
 struct clk;
 struct clk_hw;
 struct clk_core;
 struct dentry;
diff --git a/include/linux/clk-provider-uccf.h b/include/linux/clk-provider-uccf.h
index bfd16fbdfc67..63b8df663a7a 100644
--- a/include/linux/clk-provider-uccf.h
+++ b/include/linux/clk-provider-uccf.h
@@ -27,32 +27,8 @@ static inline void clk_dm(ulong id, struct clk *clk)
 	if (!IS_ERR(clk))
 		clk->id = CLK_ID(clk->dev, id);
 }
 
-/*
- * flags used across common struct clk.  these flags should only affect the
- * top-level framework.  custom flags for dealing with hardware specifics
- * belong in struct clk_foo
- *
- * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
- */
-#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
-#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
-#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
-#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
-				/* unused */
-#define CLK_IS_BASIC		BIT(5) /* Basic clk, can't do a to_clk_foo() */
-#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
-#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
-#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
-#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
-#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
-#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
-/* parents need enable during gate/ungate, set rate and re-parent */
-#define CLK_OPS_PARENT_ENABLE	BIT(12)
-/* duty cycle call may be forwarded to the parent clock */
-#define CLK_DUTY_CYCLE_PARENT	BIT(13)
-
 #define CLK_MUX_INDEX_ONE		BIT(0)
 #define CLK_MUX_INDEX_BIT		BIT(1)
 #define CLK_MUX_HIWORD_MASK		BIT(2)
 #define CLK_MUX_READ_ONLY		BIT(3) /* mux can't be changed */
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1140c2b10ac2..4fcdb5a86799 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -8,8 +8,32 @@
  */
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
+/*
+ * flags used across common struct clk.  these flags should only affect the
+ * top-level framework.  custom flags for dealing with hardware specifics
+ * belong in struct clk_foo
+ *
+ * Please update clk_flags[] in drivers/clk/clk.c when making changes here!
+ */
+#define CLK_SET_RATE_GATE	BIT(0) /* must be gated across rate change */
+#define CLK_SET_PARENT_GATE	BIT(1) /* must be gated across re-parent */
+#define CLK_SET_RATE_PARENT	BIT(2) /* propagate rate change up one level */
+#define CLK_IGNORE_UNUSED	BIT(3) /* do not gate even if unused */
+				/* unused */
+				/* unused */
+#define CLK_GET_RATE_NOCACHE	BIT(6) /* do not use the cached clk rate */
+#define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate change */
+#define CLK_GET_ACCURACY_NOCACHE BIT(8) /* do not use the cached clk accuracy */
+#define CLK_RECALC_NEW_RATES	BIT(9) /* recalc rates after notifications */
+#define CLK_SET_RATE_UNGATE	BIT(10) /* clock needs to run to set rate */
+#define CLK_IS_CRITICAL		BIT(11) /* do not gate, ever */
+/* parents need enable during gate/ungate, set rate and re-parent */
+#define CLK_OPS_PARENT_ENABLE	BIT(12)
+/* duty cycle call may be forwarded to the parent clock */
+#define CLK_DUTY_CYCLE_PARENT	BIT(13)
+
 /*
  * U-Boot: for compatibility include the correct clk-provider.h
  * for either uccf (U-Boot CCF) or ccf_full (Linux CCF)
  */

-- 
2.51.0


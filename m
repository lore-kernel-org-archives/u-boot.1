Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C8CCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 804A5846F2;
	Tue, 19 May 2026 00:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Vto/ku7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957C98465A; Tue, 19 May 2026 00:29:59 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59382846A4
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2baef9f5ecdso22970805ad.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143396; x=1779748196;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJFijbFWvKBZm7I98eHLoxi50SCPJIJ6nz9C3HJeCUE=;
 b=Vto/ku7fAhsb/S+VSa5wgkC/RK3K6o+xr32/Tm8pr8fNN9o3MMuf2Y/BfH3lz8i5cB
 s6vst0iM79nwiGZLbrSi+ZNEMCqlqAgTsKx5EPyIw/q21WDH8dasqBEwJHjMkErY2apY
 53U0dWhsuiRptvocDQjVi0UARNX3A1/hfp2ZnZ5PheSUfTJl+MpVU8E/oE84ke+MBVfK
 gTf2Xm7iUvC3ie/nloHUPWFUgypbPzCw+OWrN7ZE+ZKgBGol5bQgmInY5i1VitaLCfwM
 wqhrn+8YH4XTtn5eSOOVAIBkW8pSqM/gNXlG2M0W2CwFH14YOzRC/xnSaay1+3hJ51wm
 K3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143396; x=1779748196;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sJFijbFWvKBZm7I98eHLoxi50SCPJIJ6nz9C3HJeCUE=;
 b=ZadV6Yni9G6ekKSFZmCpkSlogls9z1uH7AnoYQJCnx+10yFSUg5iEnshKlhTMnYDl4
 RvakLU0myaJ0i+l/sUJlyL66K5BUgMKafHHLaSPVYcWe51xnjqGo2lzGwSAfIbEhN16D
 kEvrFPmX3b+jBkorwkWGZxmMp+1NRHUl+uWPUqHKUkFk28SEzzfHHrZbQwurP9sJCy1m
 fIkNxB9aazVnvQDFFxPsfrd6E8oVjCBDsYTmy/GAghUp1Vcz8AYV+SLMk8atX3IrXmkq
 yS/VOi7EbwiOpdEtnQqxsZPVS+XyHVakkLzpWICcewg3ANMTi6wJlxz70gc892MGs9oM
 O07w==
X-Gm-Message-State: AOJu0YwB7pYP3E5SRCZz7zTRTf9Et74GUVC5gxA4LcrToOfi9IuIdzpB
 xlVft9XK4ufx7XIO98sttyu2ex1a3kOj1hYgY+nJeE65gJloiehq/PYlV2T048Z/buE=
X-Gm-Gg: Acq92OF2C3pbNoAzYHso6S9y1HC6k0Jz/cQYTht8KhipgpUQmYMrL4RQ0YpOVj181EX
 EFs3EbxkpHfoup9DToLjaUsICkOFtSmdSsBqLBeNfJ4/UzNPA1+0iSPV+rzYDC6KE0Yu+rTdNMV
 RWQMybdHlwIxBVt3FXjtd74byezJvROAaGGiXV+I9Mz4/A60VvzrIyr6z2Ewvpu1tVfzj0DP4WA
 X4h3yBRWZVFvrqX/q6YW6OfB84qBa1lpyUy0iqmVIBWPmXdW9en8OuIWX4XEmncCehN8wEjo2yp
 rOCBiqTBi3zG/PKNrTmWYwZ8Xs0JPm23nHhBexobSBiFPeQH8zw9TF5y0YJMFR1JlOxGrSm3AOf
 fLR0JN/EQIFSH9bIB23xU4SR5JK+/rvQFij9+81xIYznjKstmtef+PzZyQYtUM0FCM7IKdQxNvm
 bHmrm8Q41Hb5k3hXcvLb7t/8cyB+gu2ervAXbMEk8+JsU=
X-Received: by 2002:a17:902:7892:b0:2ba:6518:a6d4 with SMTP id
 d9443c01a7336-2bd7e87d577mr133312535ad.20.1779143395861; 
 Mon, 18 May 2026 15:29:55 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:29:55 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:24 -0400
Subject: [PATCH v4 06/14] dts: k1: enable clocks in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-6-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

From: Raymond Mao <raymond.mao@riscstar.com>

Make the K1 clock controllers visible to SPL by tagging the four root
fixed clocks (osc_32k, vctcxo_{1,3,24}m) and the four syscon nodes
(mpmu, pll, apmu, apbc) with bootph-pre-ram in the BPI-F3 U-Boot
overlay.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4:
- Drop v3's separate k1-spl.dts (which #included k1.dtsi from the
  local fork); place SPL bootph-pre-ram markers in
  k1-bananapi-f3-u-boot.dtsi against the upstream-mirrored BPI-F3 DT.
- Extend APBC clocks/clock-names with pll1_d78_31p5 (MPMU) and
  pll1_d4 (PLL controller). The kernel registers these via
  clk_register_fixed_factor at runtime; U-Boot's CCF resolves them
  through DT, so they must be listed for probe ordering.
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 4e4d0e0c49e..fbee8763a21 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -32,3 +32,35 @@
 &uart0 {
 	bootph-pre-ram;
 };
+
+&osc_32k {
+	bootph-pre-ram;
+};
+
+&vctcxo_1m {
+	bootph-pre-ram;
+};
+
+&vctcxo_3m {
+	bootph-pre-ram;
+};
+
+&vctcxo_24m {
+	bootph-pre-ram;
+};
+
+&syscon_mpmu {
+	bootph-pre-ram;
+};
+
+&pll {
+	bootph-pre-ram;
+};
+
+&syscon_apmu {
+	bootph-pre-ram;
+};
+
+&syscon_apbc {
+	bootph-pre-ram;
+};

-- 
2.43.0


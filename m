Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29836C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72E1884ADB;
	Tue, 30 Jun 2026 03:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vq9++A/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B28843B6; Tue, 30 Jun 2026 03:19:56 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D4284ADC
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so7286485c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782393; x=1783387193;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n/iYe5fe1lFyyX30TAet221Udxf2Fe8ElR2WhCy1z+s=;
 b=vq9++A/5e3PAAR3o29TB6ORFBVtcPjfBJ7p3QCGED30y2qCVVan7yp1RCBU5B7ML0I
 Rv0YxtE+YRX2f2Y8ycESaBvbH9LFDsBeqHwDLqL6e3pDUvM2fnMrAdkmp94TyCCfiCh3
 cSxOblFc2BI82JBDuRlD9XtwtK8CynpVoLf5iX6IVNkUFRQ88cRZn97HPa7HKADAUSwQ
 coTzuJTlMYNJB472g7dFmJ0ep759REBuAIj/DDvqCTRNYHw2jijDwAIIdI7cMPiVAuhN
 mSlHCuw9h+lVCbOdNMOviwm0/zAxVQQGGWiv7K4yxc2fKritJGcbQcYnqMSs1e9cCozQ
 4omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782393; x=1783387193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n/iYe5fe1lFyyX30TAet221Udxf2Fe8ElR2WhCy1z+s=;
 b=aby1TSuvEY6CU96/30zg4C73EUHOHoBU7gfToyrb0vxguynnv47lKVi4bkKR/6IDF6
 nmCJb1HSPEu1Xy67Ks7Nan7IAoVaXX6AJfQMF54dQGzc/dh17kau+xC048nTdDhi3ND5
 Myd8hO2dqBL4s5E0twl3sp3k0USO1VLmxT2IMupKj1SwawnDY7nOZr1g37SYzLyqAunH
 zlePhoi9txmSa98za7VhCz703emL3rbnc5NuVa+vM/qrmt0pZYzI3ghwdbj5uy0K4x7j
 uaQ88niXoEZ5Js0iMXBvwZOehL/s7kJs3EoiBNBuJtvx2MDYT6ktFP4BjOJSvRip4Kz1
 CfUw==
X-Gm-Message-State: AOJu0YzSviKZj9vcRdBr26uEJh9bGt+Y0SNxQ4sFmvkU+W3rlgpcawEG
 dPDQna6Lq6mata1WGNS/yZtleSc88tY12aSsbvn4jHUpcIfsl7cmb4kuZcIIUahQA8k=
X-Gm-Gg: AfdE7cl2nWcq5iApDvepcusT/s02oyVbtZG5jY0jDbJYaLaZ4xCS6pcYpQhJz0yHQW5
 W485sj4sa1VhwfehxvOnfllYh1ymrUBzeLAhRcO3Ls8cXjPBmQfgeFpeCjyjqprRxqsZIPZDVX3
 XTUYA3fbcgQxvy7JgvgtJTO3oSrNJDPu88/M4KfdYc5CyE7gtdiGg2JI4k2pdalDdgfUlP303gp
 MBOhrwqZPaBjZLKUuWFwJmsn50fSsr/39LjVffWZHqdCNzhxsNBFx8KEtpt5wozCQFWSJIpLerI
 qMpUJ/psPEL+ASmttnyacRt5Bsqaf06EaxrFu1/WBuClP2hZIzuyHEM570hpTbqy4YvgWyvrvA5
 QwSFjEiM+I1WcmkThBLRVKHqNgLlEAOxTLY5zTCCkSyvfQpSPHnw7cBFQfqaPHpRUOf6ik2vy7u
 Vp+rMSo4jA5Nzr/iUqP0phVLMpS0oSqEJ1vPlMKVwSSLpR/7aGOeEXfkdstUerMqlZwY/Z770ku
 H6d5mOq17iMAsS2mrL66hekijVflC12TsPrnTURqdROwekgXK+WiQ==
X-Received: by 2002:a05:7022:672a:b0:139:ed5d:3b9 with SMTP id
 a92af1059eb24-13b2a1db527mr1026780c88.50.1782782392659; 
 Mon, 29 Jun 2026 18:19:52 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:52 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:07 +0800
Subject: [PATCH v5 06/14] dts: k1: enable clocks in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-6-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index ef63b43f69f..e140c07b834 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -15,3 +15,35 @@
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
2.51.0


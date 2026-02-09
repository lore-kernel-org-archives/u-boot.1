Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2CFE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCA883CEA;
	Mon,  9 Feb 2026 19:32:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UdMU4601";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D03F83C29; Mon,  9 Feb 2026 19:32:31 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863A480325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59de66fda55so4027667e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661949; x=1771266749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMz+JxRxCbHSz7vBDtrlX6aR0fPzcls4cMx03G4KFMw=;
 b=UdMU4601pDdY19hTG0vJk1uZ2LCNSaXnctVrlBPasTU03UTr+9MVhBESuY4evxQgS3
 oPomop3xrAMzXnVGzgeKSln82mv0SKc3b5QNFeTyoNoOy2XR5TyaOj7gEwZx+MRxdL4A
 kLQmErfNmCd+xl0P4DiCp1bHcpEV+5WQCXk/bD28xdcJ8taQzS5oFDpZRNe7BU7WevHR
 K71Q4/7ES+lqdq5aSV0Z27CGXBRxDe54D5qC/MgpM6vutdS1XgYVcTFti4vINyrIsSNz
 Dnl52LTAu+GQLtSdhi51enr1v1gDdFqBQ5dEw8pCP+U0kVjeWPUOYfOBsv23t2CueNWo
 Z1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661949; x=1771266749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mMz+JxRxCbHSz7vBDtrlX6aR0fPzcls4cMx03G4KFMw=;
 b=X+dEo7QBM/71YoJ/kbGoA9O1uYK5qPZgunFMYwRx4wQ7GNfVywwnC1b9n36l1tiZTL
 eNizpodV45G6fcWHNmZU4eQa06yjrRMYH4vsDCwFdhIRextiU7fByXCh2LzIg0VNwW/P
 NAZ5sDLEqZx+XdFZm/UnVuWH74O4cBg49xe2eXes6wJHhjjbyBo9fE1RleezUXZArjyK
 XR6M0RrmDzO0K6FbnJzPgEl6nkvi4Te/f8TwpxzdspQLB6KWhP7peXyFFzyNjsrqRQOF
 5630xTaHByAK6iWuWdaN4W4QBmZZpu2cnsZenLueuWVdUMSEc0imuoQtSLWF6XbM2qy6
 Plnw==
X-Gm-Message-State: AOJu0Yxt1lr+hub989q3sFehEfEUuDlemuquAPzxC2UAQKEkD1xWZlxr
 WKIuFQJfHgI4MXDnnhh3GXQ1Pe0Jwa2ev80AP9TfjzHMAUxWloeryGy8
X-Gm-Gg: AZuq6aJX1DRWiDXZGOXGFuoafn979PYdVuAj0ewxp1O8lWfKfp7DKfC4K1v16CxsWst
 7YX0ID6DuNlUCZ29xl3JjHN5+2aAEm/6Ll8D3zkLgSpZL9bVTPYg2Z92cvIwSviVdYUn70DqAt7
 V8mCY+EruoJH6gbUaMRBsH4RXifV14I+2CVod93voWxVCuAlW03t4DvA128qa/SBdyKjDyF8hhw
 RX+5xskEKlNI0TEXBlV9K9f6/ddkoXZjTgl7y78WwGfOfT+Dus/q0YXZqsFpIou0R0Jl+X81HIY
 78mBiioxCj8eopGc9SvSbU2TShikX/3Xi9UtFY1VItL/+FDji55/QUd8OPZKTiZeySMP35rXBWJ
 GTMhFCxVPJ3Hz3x/37rCHw30JhEde4GfV17Bm83AGGrpH2hR6qD+80d9twoSYU7BPl5/gtcy2RJ
 9a
X-Received: by 2002:a05:6512:114b:b0:59e:18b0:e9dc with SMTP id
 2adb3069b0e04-59e45155712mr3676289e87.25.1770661948590; 
 Mon, 09 Feb 2026 10:32:28 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:28 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/6] ARM: tegra: mot: change backlight LED source
Date: Mon,  9 Feb 2026 20:32:16 +0200
Message-ID: <20260209183219.34250-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209183219.34250-1-clamor95@gmail.com>
References: <20260209183219.34250-1-clamor95@gmail.com>
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

Mot based devices use LM3532 LED controller with 3 sources. Panel
backlight uses LED 0 while keypad uses LED 1 and 2. Adjust device tree
accordingly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra20-motorola-mot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/tegra20-motorola-mot.dtsi b/arch/arm/dts/tegra20-motorola-mot.dtsi
index db2cce1cc0d..5a9f58ff17f 100644
--- a/arch/arm/dts/tegra20-motorola-mot.dtsi
+++ b/arch/arm/dts/tegra20-motorola-mot.dtsi
@@ -330,7 +330,7 @@
 			backlight_led: led@0 {
 				reg = <0>;
 
-				led-sources = <2>;
+				led-sources = <0>;
 				led-max-microamp = <26600>;
 
 				ti,led-mode = <0>;
-- 
2.51.0

